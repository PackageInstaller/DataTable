module("buildBase.BuildBaseListItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mSkillGrid = {}
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mGuideClick = self:getChildGO("mGuideClick")
    self.mIsClick = self:getChildGO("mGuideClick"):GetComponent(ty.Image)
    self.mHeroCardNode = self:getChildTrans("mHeroCardNode")
    self.mDogTag = self:getChildGO("mDogTag")
    self.mSkillNode = self:getChildTrans("mSkillNode")
    self.mSliderStamina = self:getChildGO("mSliderStamina"):GetComponent(ty.Image)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mBuildId = self:getChildGO("mBuildId"):GetComponent(ty.Text)
    self.mImgTired = self:getChildGO("mImgTired")
    self.mImgTired:SetActive(false)
    self.mImgBuildId = self:getChildGO("mImgBuildId")
    self.mImgBuildId.gameObject:SetActive(false)
    self.mSkillImg = self:getChildGO("mSkillImg")
    self.mHeroStteIcon = self:getChildGO("mHeroStteIcon"):GetComponent(ty.AutoRefImage)
    self.mStateName = self:getChildGO("mStateName"):GetComponent(ty.Text)
    self.mStateDispatch = self:getChildGO("mStateDispatch")
    self.mImgDisable = self:getChildGO("mImgDisable")
    self:getChildGO("mTxtDisable"):GetComponent(ty.Text).text = _TT(76202) --无法入住
    self:addOnClick(self.mGuideClick, self.onClickItemHandler)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.SELECT_SETTLEIN_HERO_UI, self.checkItemIsSelected, self)
    local config = hero.HeroCuteManager:getHeroCuteConfigVo(self.dataVo.tid)
    if config == nil then
        self.mImgDisable:SetActive(true)
        self.mGuideClick:SetActive(false)
    else
        self.mImgDisable:SetActive(false)
        self.mGuideClick:SetActive(true)
    end
end

function getGuideTrans(self)
    return self.mGuideClick.transform
end

function setData(self, data)
    super.setData(self, data)
    self.dataVo = data.m_dataVo
    if self.dataVo then
        self.tid = self.dataVo.tid
        self.heroMsgInfo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(self.dataVo.tid)
        self.isSelect, _ = buildBase.BuildBaseHeroManager:checkHeroIsInBuild(self.dataVo.tid)
        self.heroState = buildBase.BuildBaseHeroManager:checkHeroState(self.heroMsgInfo.tid)


        self:updateView()
        self:checkItemIsSelected()
    else
        self:deActive()
    end
end

function updateView(self)
    if (self.dataVo) then
        self:updateSkillGrid()
        self:updateColor()
        self:updateBody()
        self.mImgSelect:SetActive(self.isSelect)
        self.mStateDispatch:SetActive(false)
        self.mDogTag:SetActive(false)
        self.mIsClick.raycastTarget = true
        if self.heroState == buildBase.HeroState.Ready2MoveIn then
            self.mDogTag:SetActive(false)
        else
            self.mDogTag:SetActive(true)
            self.mStateName.text = self.heroState
            local imgUrl = nil
            if self.heroState == buildBase.HeroState.Working then
                self.mImgTired:SetActive(false)
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon05.png")
            elseif self.heroState == buildBase.HeroState.Break or self.heroState == buildBase.HeroState.Able2Work then
                self.mImgTired:SetActive(false)
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon04.png")
            elseif self.heroState == buildBase.HeroState.Tired then
                self.mImgTired:SetActive(true)
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon06.png")
            end
            self.mHeroStteIcon:SetImg(imgUrl, false)
        end

        if self.heroMsgInfo.staminaTime - GameManager:getClientTime() <= 0 then
            if self.heroMsgInfo.stamina > 0 then
                self.m_childGos["mDogTag"]:SetActive(false)
            else
                self.m_childGos["mDogTag"]:SetActive(true)
            end
        else
            self.m_childGos["mDogTag"]:SetActive(true)
        end

        if (self.heroMsgInfo.buildId ~= 0) then
            self.mImgBuildId.gameObject:SetActive(true)
            if self.heroMsgInfo.buildId > 9 then
                self.mBuildId.text = self.heroMsgInfo.buildId
            else
                self.mBuildId.text = "0" .. self.heroMsgInfo.buildId
            end
        else
            self.mImgBuildId.gameObject:SetActive(false)
        end
        self.mTxtHeroName.text = self.dataVo.name

        if self.heroMsgInfo.stamina <= buildBase.HeroStateThreshold.Tired then

            self.mSliderStamina.color = gs.ColorUtil.GetColor("d53529ff")
        elseif self.heroMsgInfo.stamina > buildBase.HeroStateThreshold.Tired and self.heroMsgInfo.stamina < buildBase.HeroStateThreshold.Healthy then

            self.mSliderStamina.color = gs.ColorUtil.GetColor("ff9e35ff")
        elseif self.heroMsgInfo.stamina >= buildBase.HeroStateThreshold.Healthy then

            self.mSliderStamina.color = gs.ColorUtil.GetColor("45cea2ff")
        end
        self.mSliderStamina.fillAmount = self.heroMsgInfo.stamina / buildBase.HeroStaminaMax

    else
        self:deActive()
    end
end

function updateSkillGrid(self)
    self:recoverSkillGrid()
    for k, v in pairs(self.dataVo:getConfigVo().warshipSkill) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(v)
        if skillVo.rank <= self.dataVo.militaryRank then
            local item = SimpleInsItem:create(self.mSkillImg, self.mSkillNode, "BuildBaseSkill")
            local image = item:getGo():GetComponent(ty.AutoRefImage)

            image:SetImg(UrlManager:getBuildBaseSkillIconPath(skillVo.icon), false)
            table.insert(self.mSkillGrid, item)
        end
    end
end

--卡牌等级
function updateColor(self)
    if (self.mImgColorBg == nil) then
        self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.Image)
    end

    local color = "ff9e35ff"
    if self.dataVo.color == 2 then
        color = "2e95ffff"
    elseif self.dataVo.color == 3 then
        color = "ff72f1ff"
    end
    self.mImgColorBg.color = gs.ColorUtil.GetColor(color)


    -- if self.dataVo.color == 2 then
    --     self.mImgColorBg:SetImg(UrlManager:getCommon5Path("common_0272.png"), false)
    -- elseif self.dataVo.color == 3 then
    --     self.mImgColorBg:SetImg(UrlManager:getCommon5Path("common_0273.png"), false)
    -- else
    --     self.mImgColorBg:SetImg(UrlManager:getCommon5Path("common_0274.png"), false)
    -- end
end

--英雄等级
function updateBody(self)
    if (self.mImgBody == nil) then
        self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
    end
    self.mImgBody:SetImg(UrlManager:getHeroBodyImgUrl(self.dataVo:getHeroModel()), false)
end

function onClickItemHandler(self)
    self.isSelect = not self.isSelect
    buildBase.BuildBaseHeroManager:onClickChangeHero(self.data:getDataVo().tid, self.isSelect)
    self:checkItemIsSelected()
end

function checkItemIsSelected(self)
    local res, pos = buildBase.BuildBaseHeroManager:checkHeroIsInBuild(self.tid)
    if self.mTextSelcetedIdx == nil then
        self.mTextSelcetedIdx = self:getChildGO("mTextSelcetedIdx"):GetComponent(ty.Text)
    end
    self.isSelect = res
    if res then
        self.mImgSelect.gameObject:SetActive(true)
        self.mTextSelcetedIdx.text = pos
    else
        self.mImgSelect.gameObject:SetActive(false)
        --填入顺序
    end
end

function recoverSkillGrid(self)
    for k, v in pairs(self.mSkillGrid) do
        v:poolRecover()
    end
    self.mSkillGrid = {}
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.SELECT_SETTLEIN_HERO_UI, self.checkItemIsSelected, self)
    self.isSelect = false
    self:recoverSkillGrid()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]