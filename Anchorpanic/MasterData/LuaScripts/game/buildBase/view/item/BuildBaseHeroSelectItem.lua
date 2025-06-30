module("buildBase.BuildBaseHeroSelectItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextHeroName = self:getChildGO("mTextHeroName"):GetComponent(ty.Text)
    self.mGroupHeroState_1 = self:getChildGO("mGroupHeroState_1")
    self.mGroupHeroState_2 = self:getChildGO("mGroupHeroState_2")

    self.mTextHeroStateTime = self:getChildGO("mTextHeroStateTime"):GetComponent(ty.Text)
    self.mImgHeroMoodSlider = self:getChildGO("mImgHeroMoodSlider"):GetComponent(ty.Image)
    self.mTextHeroMood = self:getChildGO("mTextHeroMood"):GetComponent(ty.Text)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon")
    self.mSkillContent = self:getChildTrans("mSkillContent")
    self.mTxtHeroState = self:getChildGO("text_2"):GetComponent(ty.Text)
    self.mBtnSettled = self:getChildGO("mBtnSettled")
    self.mHeroRoot = self:getChildGO("mHeroRoot")
    self.mBtnRemove = self:getChildGO("mBtnRemove")
    self.mBtnOpenHeroSelect = self:getChildGO("mBtnOpenHeroSelect")
    self:addOnClick(self.mBtnSettled, function()
        local buildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(buildBase.BuildBaseManager:getNowBuildId())
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, {
            buildBaseVo = buildBaseInfo
        })
        -- GameDispatcher:dispatchEvent(EventName.OPEN_SETTLED_HERO_VIEW)
    end)

    self:addOnClick(self.mBtnRemove, function()
        GameDispatcher:dispatchEvent(EventName.AUTOSETTLEDBUILDBASEHERO, { build_id = buildBase.BuildBaseManager:getNowBuildId(), hero_id = self.data.heroTid })
    end)
    self:addOnClick(self.mBtnOpenHeroSelect, function()
        local buildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(buildBase.BuildBaseManager:getNowBuildId())
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, {
            buildBaseVo = buildBaseInfo
        })
    end)

    self:setGuideTrans("funcTips_guide_BuildBase_btnSettled", self.mBtnSettled.transform)
end

function setData(self, data)
    super.setData(self, data)
    if data.heroTid then
        self.mBtnSettled:SetActive(false)
        self.mHeroRoot:SetActive(true)

        self.buildHeroData = buildBase.BuildBaseHeroManager:getBuildHeroInfo(data.heroTid)
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(data.heroTid)
        --疲劳上限
        local max = sysParam.SysParamManager:getValue(5001)
        if buildBase.BuildBaseManager:getBuildType() ~= buildBase.BuildBaseType.Dormitory then
            self.mTxtHeroState.text = "工作时间"
        end
        self.mImgHead:SetImg(UrlManager:getHeroHeadUrl(data.heroTid), false)
        self.mTextHeroName.text = heroConfigVo.name
        self.mTextHeroMood.text = string.format("%s/%s", self.buildHeroData.stamina, max)
        self.mImgHeroMoodSlider.fillAmount = self.buildHeroData.stamina / max
        local color = "000000ff"
        local color_1 = sysParam.SysParamManager:getValue(5011)
        local color_2 = sysParam.SysParamManager:getValue(5012)
        if self.buildHeroData.stamina >= color_1 then
            color = "45CEA2FF"
        elseif self.buildHeroData.stamina > color_2 then
            color = "FF9E35FF"
        elseif self.buildHeroData.stamina <= color_2 then
            color = "D53529FF"
        end

        self.mImgHeroMoodSlider.color = gs.ColorUtil.GetColor(color)
        self.m_childGos["mask"]:SetActive(true)
        if self.buildHeroData.stamina > 0 then
            self.mGroupHeroState_1:SetActive(true)
            self.mGroupHeroState_2:SetActive(false)
            self.mTextHeroStateTime.text = "--:--:--"
        else
            self.mGroupHeroState_1:SetActive(false)
            self.mGroupHeroState_2:SetActive(true)
        end
        self:clearTimer()
        self:updateTime()
        self.m_TimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
        if not self.mSkillGrid then
            self.mSkillGrid = {}
        end
        self:recoverSkillGrid()
        for k, v in pairs(heroConfigVo.warshipSkill) do
            local item = SimpleInsItem:create(self.mImgSkillIcon, self.mSkillContent, "DormitoryHeroSkill")
            local image = item:getGo():GetComponent(ty.AutoRefImage)
            local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(v)
            image:SetImg(UrlManager:getBuildBaseSkillIconPath(skillVo.icon), false)
            table.insert(self.mSkillGrid, item)
        end
    else
        self.mBtnSettled:SetActive(true)
        self.mHeroRoot:SetActive(false)
    end
end

function updateTime(self)
    local staminaTime = self.buildHeroData.staminaTime - GameManager:getClientTime()
    if staminaTime > 0 then
        self.mTextHeroStateTime.text = TimeUtil.getHMSByTime(staminaTime)
        self.mGroupHeroState_1:SetActive(true)
        self.mGroupHeroState_2:SetActive(false)
    else
        self.mTextHeroStateTime.text = "--:--:--"
        if self.buildHeroData.stamina > 0 then
            self.mGroupHeroState_1:SetActive(false)
            self.mGroupHeroState_2:SetActive(false)
            self.m_childGos["mask"]:SetActive(false)
        else
            self.mGroupHeroState_1:SetActive(false)
            self.mGroupHeroState_2:SetActive(true)
            self.m_childGos["mask"]:SetActive(true)
        end

        self:clearTimer()
    end
end

function recoverSkillGrid(self)
    if self.mSkillGrid then
        for k, v in pairs(self.mSkillGrid) do
            v:poolRecover()
        end
    end
    self.mSkillGrid = {}
end

function clearTimer(self)
    if self.m_TimeSn then
        LoopManager:removeTimerByIndex(self.m_TimeSn)
        self.m_TimeSn = nil
    end
end

function onDelete(self)
    super.onDelete(self)

    self:clearTimer()
    self:recoverSkillGrid()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]