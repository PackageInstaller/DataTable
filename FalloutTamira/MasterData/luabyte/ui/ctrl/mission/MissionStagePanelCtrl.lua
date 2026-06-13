local M = BaseClass("MissionStagePanelCtrl", require("UI.Ctrl.Mission.BaseStageInfoCtrl"))
local mLoadString = ConfigHelper.GetLocalStringByPlayerName

-- 初始化
function M:Init()
    self.m_rawardList = { self._view.rewardItem }
    self.m_tagerList = { self._view.challengeItem }
    self.m_entryGroup = self._view.challengeContent

    self._view.img_energy:SetItemIcon(9)
    self._view.mopBtn:onClick(Bind(self, self.OnMoppingClick))
    self._view.btn_map:onClick(Bind(self, self.OnMapInfoClick))
    self._view.enemyBtn:onClick(Bind(self, self.OnMonInfoClick))
    self._view.energyBtn:onClick(Bind(self, self.OnEnergyClick))
    self._view.battleBtn:onClick(Bind(self, self.OnBattleClick))
    self._view.rewardBtn:onClick(Bind(self, self.OnOpenRewardClick))
    self.m_entryGroup:OnToggleChanged(Bind(self, self.OnToggleClick))
end

function M:OnDispose()
    self.m_entryGroup:DoDispose()
    self.m_entryGroup = nil
    self.m_rawardList = nil
    self.m_tagerList = nil
    M.super.OnDispose(self)
end

-- 入口 整理数据 方便调用
function M:Refresh(mission, doubleData)
    self:_SetBaseInfo(mission, doubleData)
    self:RefreshDouble()
    self:_RefreshTitle()
    self:_RefreshRwards()
    self:OnSaveCallback()
    self:_RefreshSuggestedLv()
end

-- 刷新上面Title这块的内容
function M:_RefreshTitle()
    local fmtStr, cfg = "<color=#516Bff>-</color>", self.m_mission
    local isDifficult = self.m_missionData:IsDifficulty()
    local isRes = self.m_missionData:IsResource()
    self._view.btn_map:SetPic(cfg.map)
    self._view.missionName:SetText(cfg.name)
    self._view.hardType:SetIsOn(isDifficult, false)
    self._view.missionText:SetActive(not isDifficult or isRes) -- 不使用词条 或 资源本 显示描述
    self._view.missionText:SetText(mLoadString(cfg.shortStory))
    self._view.starState:SetState(self.m_missionData:GetStar() + 1)
    self._view.star4Bg:SetActive(MissionHelper.Is4StarMission(cfg))

    if isDifficult then self:_RefreshChallengeTarget() end
    if isDifficult then fmtStr = "<color=#D92C24>-</color>" end
    self._view.missionChapter:SetText(string.gsub(cfg.chapterLabel, '-', fmtStr))
end

-- 刷新toggle
function M:_RefreshChallengeTarget()
    local stage = self.m_mission.Stage
    local cTarget, descs = stage.challengeTarget, stage.targetDesc
    local selectDic, len = self:_GetSelectWordDic(), cTarget and cTarget.Length or 0

    for i = 1, len do
        local item = self.m_tagerList[i]
        if not item then
            item = self._view.challengeItem:Instantiate()
            self.m_tagerList[#self.m_tagerList + 1] = item
        end

        local idx = i - 1
        local challengeId = cTarget[idx]
        local isOn = selectDic[challengeId] ~= nil
        item:SetName(tostring(challengeId))
        item:SetUIState(isOn and 3 or 2)
        item:SetIsOnWithoutNotify(isOn)
        item.challengeId = challengeId
        item:SetText(descs[idx])
        item:SetActive(true)
    end

    for i = 1, (#self.m_tagerList - len) do
        self.m_tagerList[len + i]:SetActive(false)
    end
    self.m_entryGroup:RefreshToggles()
end

-- 刷新奖励内容
function M:_RefreshRwards()
    local awardList = self:_GetRewardItems()
    local trans = self._view.rewardContent
    for i, v in ipairs(awardList) do
        local item = self.m_rawardList[i]
        if not item then
            item = self._view.rewardItem:Instantiate(trans)
            self.m_rawardList[#self.m_rawardList + 1] = item
        end

        item:SetActive(true)
        item:SetInfo(v.id, v.num > 0 and ItemNumberType.TOTLE or ItemNumberType.NONE, v.num)
    end

    for i = #awardList + 1, #self.m_rawardList do -- 隐藏多余
        self.m_rawardList[i]:SetActive(false)
    end
end

-- 刷新等级
function M:_RefreshSuggestedLv()
    if self.m_missionData:IsSystemTeam() then
        self._view.curLv:SetText("Lv." .. tostring(MissionHelper.GetMissionSystemLV(self.m_mission)))
    else
        self._view.curLv:SetText("Lv." .. tostring(MissionHelper.GetMissionHeroLV()))
    end

    local showLv = self.m_mission.showLv
    local isShowLv = showLv > 0
    self._view.suggestNode:SetActive(isShowLv)
    self._view.recommendLv:SetText("Lv." .. tostring(showLv))
    self._view.wordTitle:SetActive((not isShowLv) and self.m_missionData:IsDifficulty())
end

-- 刷新限时奖励
function M:RefreshDouble()
    local isDouble = self:_IsDoubleMission()
    local limit = self.m_doubleData:PassLimit()
    local remain = self.m_doubleData:RemainTimes()
    self._view.doubleTag:SetActive(isDouble)                                -- 显示剩余次数tag
    self._view.doubleTimes:SetText(remain .. "/" .. limit)
    self._view.doubleReward:SetActive(isDouble and self:_HasRandomReward()) -- 显示奖励Tag
    self:OnEnergyChanged()
end

-- 刷新按钮状态
function M:OnRefreshState()
    self._view.mopBtn:SetState(self.m_sweepState)
    self._view.mopBtn:SetActive(self.m_mission.showFast == 0)          -- 0:显示扫荡
    self._view.consumeNum:SetText(tostring(self.m_mission.energyCost)) -- 显示体力消耗
    self._view.battleBtn:SetState(self:BattleBtnState())
    self._view.helpTip:SetActive(self:IsShowHelpTip())
end

-- toggle 点击事件
function M:OnToggleClick()
    local selectDic, activeTogs = {}, self.m_entryGroup.ActiveToggles
    for _, v in ipairs(self.m_tagerList) do
        if activeTogs:Contains(v.toggle) then
            v:SetUIState(3) -- 选中状态
            selectDic[#selectDic + 1] = v.challengeId
        else
            v:SetUIState(2)
        end
    end

    GameHelper.SetChallengeTarget(selectDic, self.m_mission.id)
end

function M:OnEnergyChanged()
    local value = EnergyMgr:GetInstance():EnergyValue()
    local limit = EnergyMgr:GetInstance():EnergyLimit()
    self._view.energyValue:SetText(value .. "/" .. limit)

    if not IsNull(self.m_mission) then
        if value >= self.m_mission.energyCost then
            self._view.consumeNum:SetColor(255, 255, 255, 255)
        else
            self._view.consumeNum:SetColor(255, 0, 0, 255)
        end
    end
end

return M
