module("dormitory.DormitoryHeroInfoItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextHeroName = self:getChildGO("mTextHeroName"):GetComponent(ty.Text)

    self.mTextHeroStateTime = self:getChildGO("mTextHeroStateTime"):GetComponent(ty.Text)
    self.mImgHeroMoodSlider = self:getChildGO("mImgHeroMoodSlider"):GetComponent(ty.Image)
    self.mTextHeroMood = self:getChildGO("mTextHeroMood"):GetComponent(ty.Text)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon")
    self.mSkillContent = self:getChildTrans("mSkillContent")

    self.mBtnSettled = self:getChildGO("mBtnSettled")
    self.mGroupSettled = self:getChildGO("mGroupSettled")
    self.mHeroRoot = self:getChildGO("mHeroRoot")
    self.mBtnRemove = self:getChildGO("mBtnRemove")
    self.mGroupHeroState = self:getChildGO("mGroupHeroState")

    self.mTextHeroMood_text = self:getChildGO("mTextHeroMood_text"):GetComponent(ty.Text)
    self.mTextHeroState_text = self:getChildGO("mTextHeroState_text"):GetComponent(ty.Text)
    self.mGroupHeroState_1 = self:getChildGO("mGroupHeroState_1"):GetComponent(ty.Text)
    self.mGroupHeroState_2 = self:getChildGO("mGroupHeroState_2"):GetComponent(ty.Text)
    
    self:addOnClick(self.mBtnSettled, function()
        local buildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(dormitory.DormitoryManager:getRoomId())
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, {
            buildBaseVo = buildBaseInfo
        })
        -- GameDispatcher:dispatchEvent(EventName.OPEN_SETTLED_HERO_VIEW)
    end)

    self:addOnClick(self.mBtnRemove, function()
        GameDispatcher:dispatchEvent(EventName.AUTOSETTLEDBUILDBASEHERO,{build_id = dormitory.DormitoryManager:getRoomId(), hero_id = self.data.heroTid})
    end)
end

function setData(self, data)
    super.setData(self, data)
    self.mTextHeroMood_text.text = _TT(1378)
    self.mTextHeroState_text.text = "休息时间"
    self.mGroupHeroState_1.text = "工作中"
    self.mGroupHeroState_2.text = "休息中"

    if data.heroTid then
        self.mGroupSettled:SetActive(false)
        self.mHeroRoot:SetActive(true)

        self.buildHeroData = buildBase.BuildBaseHeroManager:getBuildHeroInfo(data.heroTid)
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(data.heroTid)
        --疲劳上限
        local max = sysParam.SysParamManager:getValue(5001)

        self.mImgHead:SetImg(UrlManager:getHeroHeadUrl(data.heroTid), false)
        self.mTextHeroName.text = heroConfigVo.name
        self.mTextHeroMood.text = string.format("%s/%s",self.buildHeroData.stamina,max)
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

        self.mGroupHeroState:SetActive(self.buildHeroData.stamina < max)

        if self.buildHeroData.stamina >= max then 
            self.mGroupHeroState_1.gameObject:SetActive(true)
            self.mGroupHeroState_2.gameObject:SetActive(false)

            self.mTextHeroStateTime.text = "--:--:--"
        else
            self.mGroupHeroState_1.gameObject:SetActive(false)
            self.mGroupHeroState_2.gameObject:SetActive(true)

            self:clearTimer()
            self:updateTime()
            self.m_TimeSn = LoopManager:addTimer(1,0,self,self.updateTime)
        end

        if not self.mSkillGrid then 
            self.mSkillGrid = {}
        end
        self:recoverSkillGrid()
        for k, v in pairs(heroConfigVo.warshipSkill) do
            local item = SimpleInsItem:create(self.mImgSkillIcon, self.mSkillContent, "DormitoryHeroSkill")
            local image = item:getGo():GetComponent(ty.AutoRefImage)
            local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(v)
            image:SetImg(UrlManager:getBuildBaseSkillIconPath(skillVo.icon),false)
            table.insert(self.mSkillGrid, item)
        end
    else
        self.mGroupSettled:SetActive(true)
        self.mHeroRoot:SetActive(false)
    end
end

function updateTime(self)
    --疲劳上限
    local staminaTime = self.buildHeroData.staminaTime - GameManager:getClientTime()
    if staminaTime > 0 then
        self.mTextHeroStateTime.text = TimeUtil.getHMSByTime(staminaTime)
        self.mGroupHeroState_1.gameObject:SetActive(false)
        self.mGroupHeroState_2.gameObject:SetActive(true)
    else
        self.mTextHeroStateTime.text = "--:--:--"
        self.mGroupHeroState_1.gameObject:SetActive(true)
        self.mGroupHeroState_2.gameObject:SetActive(false)

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
