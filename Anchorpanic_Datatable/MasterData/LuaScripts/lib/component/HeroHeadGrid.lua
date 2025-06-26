module("HeroHeadGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/HeroHeadGrid.prefab")

function __initData(self)
    super.__initData(self)

    -- 一些常用的脚本
    self.mTxtName = nil
    self.m_textLvl = nil
    self.m_imgHead = nil
    -- self.m_imgColor = nil
    self.mImgColorBg = nil

    --------------------------------------------- 数据源 self.m_data 为 hero.HeroVo 或 hero.HeroConfigVo ---------------------------------------------
    -- 名称
    self.m_gridName = nil
    -- 等级
    self.m_heroLvl = nil
    -- 进化等级/星级
    self.m_starLvl = nil
    -- 是否显示英雄的使用状态
    self.m_isShowUseState = nil
    -- 手动设置名字
    self.m_name = ""
    self.isShowColor = true
    self.isShowMilitary = false
    self.isShowType = false
    self.isShowRes = false
    self.isShowEleType = false
    -- 皮肤id
    self.m_fashionId = 0
    self.pro = 0
end

function __updateCustomView(self)
    self:__updateBasicView()

    if (self:getData()._NAME == hero.HeroConfigVo._NAME) then
    elseif (self:getData()._NAME == hero.HeroVo._NAME) then
        self:__updateOtherView()
    else
        if (self:getData().tid == 0) then
        end
    end
end

-- 更新基础的信息显示
function __updateBasicView(self)
    self:__updateName()
    self:__updateLvl()
    self:__updateHead()
    self:__updateColor()
    self:__updateStarLvl()
    self:__updateUseState()
    self:updateMilitary()
    self:updateType()
    self:updateEleType()
    self:updateRes()

    self:updateHP(0)

    self:setSiblingIndex()
    self:getChildGO("mIsLimit"):SetActive(false)--self:getData().isLimit == 1
end

function __updateParent(self)
    super.__updateParent(self)
    if (self.m_isLoadFinish) then
        if (self.m_parentTrans ~= nil) then

        end
    end
end

function setSiblingIndex(self, index)
    if index then
        self.mSiblingIndex = index
    end

    if (self.m_isLoadFinish) then
        if (self.mSiblingIndex ~= nil) then
            self.m_uiGo.transform:SetSiblingIndex(self.mSiblingIndex - 1)
        end
    end
end

-- 更新其他的信息显示
function __updateOtherView(self)
end

function setName(self, cusName)
    self.m_gridName = cusName and cusName or self:getData().name
    self:__updateName()
end

function __updateName(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtName == nil) then
            self.mTxtName = self.m_childTrans["TextName"]:GetComponent(ty.Text)
        end
        if (self.m_gridName == nil) then
            self.mTxtName.text = ""
        else
            self.mTxtName.text = self.m_gridName
            self.mTxtName.gameObject:SetActive(true)
        end
    end
end

function setLvl(self, cusLvl)
    self.m_heroLvl = cusLvl
    self:__updateLvl()
end

function __updateLvl(self)
    if (self.m_isLoadFinish) then
        if (self.m_textLvl == nil) then
            self.m_textLvl = self.m_childTrans["TextLvl"]:GetComponent(ty.Text)
        end
        if (self.m_heroLvl == nil) then
            self.m_textLvl.text = self:getData().lvl
        else
            self.m_textLvl.text = self.m_heroLvl
        end
    end
end

function __updateHead(self)
    if (self.m_isLoadFinish) then
        -- if (self.m_imgHead == nil) then
        self.m_imgHead = self.m_childTrans["ImgHead"]:GetComponent(ty.AutoRefImage)
        -- end
        if self:getData().getHeroModel and self:getData():getHeroModel(self.m_fashionId) ~= nil then
            self.m_imgHead:SetImg(UrlManager:getHeroHeadUrlByModel(self:getData():getHeroModel(self.m_fashionId)), false)
        elseif (self:getData().head) then
            self.m_imgHead:SetImg(UrlManager:getIconPath(self:getData().head), false)
        elseif self:getData().headUrl then
            self.m_imgHead:SetImg(self:getData().headUrl, false)
        else
            self.m_imgHead:SetImg(UrlManager:getHeroHeadUrl(self:getData().tid), false)
        end
    end
end

function setShowColor(self, isShowColor)
    self.isShowColor = isShowColor
    self: __updateColor()
end

function setFashionId(self, fashionId)
    self.m_fashionId = fashionId
    self:__updateHead()
end

function __updateColor(self)
    if (self.m_isLoadFinish) then
        self.mImgColorBg = self.m_childTrans["ImgColorBg"]:GetComponent(ty.AutoRefImage)
        self.mImgColorBg:SetImg(UrlManager:getHeroColorIconUrl_1(self:getData().color), false)
        self.mImgColorBg.gameObject:SetActive(self.isShowColor)
    end
end

function setStarLvl(self, cusStarLvl)
    self.m_starLvl = cusStarLvl
    self:__updateStarLvl()
end

function __updateStarLvl(self)
    if (self.m_isLoadFinish) then
        if (self.m_starLvl == nil) then
            self.m_starLvl = self:getData().evolutionLvl
        end
        if (self.m_starLvl == nil) then
            self.m_starLvl = 0
        end
        for i = 1, 6 do
            if (i <= self.m_starLvl) then
                self.m_childGos["Image" .. i]:SetActive(true)
                self.m_childGos["Image" .. i]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("FFFFFFff")
                self.m_childGos["Image" .. i]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0048.png"), false)
            else
                self.m_childGos["Image" .. i]:SetActive(false)
            end
        end
    end
end

function setIsShowUseState(self, cusIsShowUseState)
    self.m_isShowUseState = cusIsShowUseState
    self:__updateUseState()
end

function __updateUseState(self)
    if (self.m_isLoadFinish) then
        local imgStateGo = self.m_childGos["ImgUseState"]
        imgStateGo:SetActive(false)

        local isCanUse = hero.HeroUseCodeManager:getIsCanUse(self:getData().id)
        if (self.m_isShowUseState and not isCanUse) then
            local imgState = imgStateGo:GetComponent(ty.AutoRefImage)
            imgState:SetImg(hero.HeroUseCodeManager:getIconByHeroUseCode(self:getData().id), true)
            imgStateGo:SetActive(true)
        end
    end
end

function setMilitary(self, isShowMilitary)
    self.isShowMilitary = isShowMilitary
    self:updateMilitary()
end

function updateMilitary(self)
    if (self.m_isLoadFinish) then
        if (self.isShowMilitary) then
            local curHeroVo = hero.HeroManager:getHeroVo(self:getData().id)
            local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
            local txtMilitary = self.m_childGos["mTxtMilitary"]:GetComponent(ty.Text)
            txtMilitary.text = curMilitaryRankVo:getName()
            self.m_childGos["mGroupMilitary"]:SetActive(true)
        else
            self.m_childGos["mGroupMilitary"]:SetActive(false)
        end
    end
end

function setType(self, isShowType)
    self.isShowType = isShowType
    self:updateType()
end

function updateType(self)
    if (self.m_isLoadFinish) then
        if (self.isShowType) then
            self.m_childGos["mImgTypeBg"]:SetActive(true)
            local imgType = self.m_childGos["mImgType"]:GetComponent(ty.AutoRefImage)
            imgType:SetImg(UrlManager:getHeroJobSmallIconUrl(self:getData().professionType), false)
        else
            self.m_childGos["mImgTypeBg"]:SetActive(false)
        end
    end
end

function setRes(self, isShowRes)
    self.isShowRes = isShowRes
    self:updateRes()
end

function updateRes(self)
    if (self.m_isLoadFinish) then
        local heroVo = self:getData()
        if heroVo.__cname ~= hero.HeroVo.__cname and heroVo.__cname ~= hero.OtherHeroVo.__cname then
            self.isShowRes = false
            self.m_childGos["mImgResBg"]:SetActive(self.isShowRes)
            return
        end

        local resonanceCount = heroVo:getActivesSkillResonanceCount()
        self.isShowRes = resonanceCount > 0

        if (self.isShowRes) then
            local imgType = self.m_childGos["mImgRes"]:GetComponent(ty.AutoRefImage)
            imgType:SetImg(string.format("arts/ui/icon/heroResonance/progress_%s.png", resonanceCount), false)
        end
        self.m_childGos["mImgResBg"]:SetActive(self.isShowRes)
    end
end

function setEleType(self, isShowEleType)
    self.isShowEleType = isShowEleType
    self:updateEleType()
end

function updateEleType(self)
    if (self.m_isLoadFinish) then
        local eleBg = self.m_childGos["mEleBg"]
        local eleImg = self.m_childGos["mImgEleType"]:GetComponent(ty.AutoRefImage)
        if (self.isShowEleType) then
            local vo = self:getData()
            eleImg:SetImg(UrlManager:getHeroEleTypeIconUrl(vo.eleType), false) -- 电
            eleBg:SetActive(true)
        else
            eleBg:SetActive(false)
        end
    end
end

function setHpPro(self, pro)
    self.pro = pro
    self:updateHP(self.pro)
end

function updateHP(self)
    if (self.m_isLoadFinish) then
        local hpBg = self.m_childGos["HpProgress"]:GetComponent(ty.RectTransform)
        local hpBar = self.m_childGos["HpBar"]:GetComponent(ty.RectTransform)
        local hpNum = self.m_childGos["HpNum"]:GetComponent(ty.Text)
        if self.pro > 0 then
            gs.TransQuick:SizeDelta01(hpBar, self.pro / 100 * hpBg.sizeDelta.x)
            hpNum.text = self.pro .. "%"
            hpBg.gameObject:SetActive(true)
        else
            hpBg.gameObject:SetActive(false)
        end
    end
end

return _M
