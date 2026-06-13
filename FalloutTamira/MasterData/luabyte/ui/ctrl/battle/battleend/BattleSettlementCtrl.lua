local M = BaseClass('BattleSettlementCtrl', BaseUICtrl)
local EBattleStyle = EnumConst.EBattleStyle

function M:Init()
    self.m_lastClickTime = 0
    self._view.uiState:onClick(Bind(self, self.OnCloseClick))
end

function M:OnEnter(awards, starCount, battletype, mission, isMop, playerExp, bossInfo)
    self.m_second = 11
    self.m_isMop = isMop
    self.m_mission = mission
    self.m_battletype = battletype
    self.m_lastClickTime = Time.realtimeSinceStartup
    self._view.time:SetText(self.m_second .. "S")
    if battletype == EBattleStyle.Boss then
        self._view.uiState:SetState(2)
        local id = bossInfo.bossWarId
        local bossData = BossWarDataMgr:GetInstance():GetBossDataById(id)
        self._view.bossCtrl:Refresh(bossInfo, bossData)
        self.m_mission = bossData:MissionCfg()
    else
        self._view.uiState:SetState(1)
        self._view.expCtrl:Refresh(mission, playerExp)
        self._view.titleCtrl:Refresh(starCount, mission)
        self._view.awardCtrl:Refresh(awards, Bind(self, self.OnClickAward))
    end
    self._view.msgCtrl:Refresh(self.m_mission)
    self._view.roleCtrl:Refresh(battletype, self.m_mission, self.m_isMop)
    MissionDataMgr:GetInstance():PostMissionRecord(self.m_mission, isMop, battletype)

    self:_StartTimer()
end

function M:OnClose()
    self:_CloseTimer()
    UIContextMgr:GetInstance():Close("HomeLevelUp")
end

function M:OnClickAward(id, num)
    self:_CloseTimer()
    GameHelper.PopItem(id, num, nil, Bind(self, self._StartTimer))
end

function M:OnTimerCallBack()
    if self.m_second < 1 then
        self:OnCloseClick()
        return
    end

    -- 显示扫荡解锁提示
    if self.m_second == 10 then
        self:_ShowMopUpTips()
    end

    self.m_second = self.m_second - 0.5
    local showNumber = math.modf(self.m_second)
    self._view.time:SetText(showNumber .. "S")
end

--点击设置退出键
function M:OnDeviceBack()
    self:OnCloseClick()
    return true
end

function M:OnCloseClick()
    -- 黑屏动画状态不可点击
    if Time.realtimeSinceStartup - self.m_lastClickTime < 1 then
        return
    end
    self:Close()
    self:OnChageModule()
end

--结算之后点击返回
function M:OnChageModule()
    OpenSystemMgr:GetInstance():SetMissionId()
    --扫荡
    if self.m_isMop then
        EventMgr:Broadcast(UIMessageNames.BATTLE_MOPUOP_END)
        return
    end

    -- 遭遇战
    if self.m_battletype == EBattleStyle.Encount then
        self:OpenModule(ModuleConfig.StageModule.id, self.m_battletype, nil, nil, true)
        return
    end

    -- 个人副本
    if self.m_battletype == EBattleStyle.Personal then
        self:OpenModule(ModuleConfig.Dorm.id, IBattle.context.persional_HeroId)
        return
    end

    -- 悬赏关卡
    if self.m_battletype == EBattleStyle.Reward then
        self:OpenModule(ModuleConfig.StageModule.id, self.m_battletype, nil, nil, true)
        return
    end

    -- Boss战
    if self.m_battletype == EBattleStyle.Boss then
        self:OpenModule(ModuleConfig.StageModule.id, self.m_battletype, nil, nil, true)
        return
    end

    -- 主线 及 通用
    local missionId = self.m_mission.id
    local continueArr = ConfigHelper.GetSystemParams(265)
    local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
    local isFirstPass = md and md:GetPassCount() == 1 or false
    if self:GetContext():IsWin() and isFirstPass then
        OpenSystemMgr:GetInstance():SetMissionId(missionId)
    else
        OpenSystemMgr:GetInstance():SetMissionId()
    end
    if table.arrayContains(continueArr, missionId) and isFirstPass then
        --直接开始下一关
        local nextMission = self.m_mission.NextMission
        if not IsNull(nextMission) and nextMission.id == 10102 then
            local heroIds = {}
            CS.GameX.GameGlobal.commanderSkillId = nextMission.adCMSkill
            local adHero = nextMission.adHero
            for i = 0, adHero.Length - 1 do
                table.insert(heroIds, adHero[i])
            end
            -- local Context = UIContextMgr:GetInstance():GetContext("UITeamConfig")
            --local keywords = Context:_GetHeroKeywords(heroIds)
            IBattle:EnterBattle(nextMission.id)
            return
        end
    end

    if self.m_mission.Chapter.type ~= ChapterConst.EChapterType.ECT_None then
        self:OpenModule(ModuleConfig.StageModule.id, self.m_battletype, nil, nil, true)
        return
    end

    self:OpenModule(ModuleConfig.ChallengeModule.id)
end

function M:_ShowMopUpTips()
    if self.m_battletype == EBattleStyle.Reward then return end

    local missionId = self.m_mission.id
    local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
    local hasMopUp = self.m_mission.showFast == 0
    if hasMopUp and md and md:IsFirstOpenSweep() then
        UIContextMgr:GetInstance():Show("ComPopupMopUpTips", self.m_mission)
    end
end

function M:_StartTimer()
    self:_CloseTimer()

    self.m_timer = TimerManager:GetInstance():GetTimer(0.5, Bind(self, self.OnTimerCallBack), self)
    self.m_timer:Start()
end

function M:_CloseTimer()
    Logger.Log("CloseTimer")
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
end

return M
