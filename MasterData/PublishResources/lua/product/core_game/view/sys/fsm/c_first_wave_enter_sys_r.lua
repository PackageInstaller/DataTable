require("first_wave_enter_system")
_class("ClientFirstWaveEnterSystem_Render", FirstWaveEnterSystem)
ClientFirstWaveEnterSystem_Render = ClientFirstWaveEnterSystem_Render

function ClientFirstWaveEnterSystem_Render:Constructor(world)
  self._onClickUIBonusInfo = GameHelper:GetInstance():CreateCallback(self.OnClickUIBonusInfo, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnClickUIBonusInfo, self._onClickUIBonusInfo)
end

function ClientFirstWaveEnterSystem_Render:TearDown()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnClickUIBonusInfo, self._onClickUIBonusInfo)
end

function ClientFirstWaveEnterSystem_Render:OnClickUIBonusInfo()
  self._isShowBonusInfo = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBonusInfo, false)
end

function ClientFirstWaveEnterSystem_Render:_DoRenderShowUIBattleStart(TT, teamEntity)
  if self._world._matchType == MatchType.MT_Conquest then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIInitN5Score)
  end
  self._isShowBonusInfo = false
  if not GuideHelper.DontShowThreeMission() then
    self._isShowBonusInfo = true
    local match = GameGlobal.GetModule(MatchModule)
    local enterData = match:GetMatchEnterData()
    if enterData._match_type == MatchType.MT_Mission then
      local missionID = enterData:GetMissionCreateInfo().mission_id
      GameGlobal.UAReportForceGuideEvent("MissionPopStarInfo", {missionID})
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBonusInfo, true)
  end
  while self._isShowBonusInfo do
    YIELD(TT)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideUIBattle, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  YIELD(TT)
  self:_RefreshTeamHP(teamEntity)
end

function ClientFirstWaveEnterSystem_Render:_DoRenderAutoAddBuff(TT, buffseqs)
  local svc = self._world:GetService("PlayBuff")
  local utilDataSvc = self._world:GetService("UtilData")
  local isArchived = utilDataSvc:IsArchivedBattle()
  if isArchived then
    svc:LoadArchivedLockHPView(TT)
  end
  svc:PlayBuffSeqs(TT, buffseqs)
  svc:PlayAutoAddBuff(TT)
  svc:PlayBuffView(TT, NTGameStart:New())
end

function ClientFirstWaveEnterSystem_Render:_DoRendeDestroyBattleEnterResource(TT)
  self:UnloadEffect(GameResourceConst.EffRuchangKaichang)
  self:UnloadEffect(GameResourceConst.EffRuchangGeziglow)
  self:UnloadEffect(GameResourceConst.EffRuchuangPetBao)
  self:UnloadEffect(GameResourceConst.EffRuchuangHeti)
  self:UnloadEffect(GameResourceConst.MonsterAppearEffBoss)
  self:UnloadEffect(GameResourceConst.EffRuchangBlackboard)
  self:UnloadEffect(GameResourceConst.EffBoardShowLine)
  for k, v in pairs(GameResourceConst.PetAppearEff) do
    self:UnloadEffect(v)
  end
  local md = GameGlobal.GetModule(SkillPerfModule)
  if md:IsPerfCoreGame() then
    md:SetWorld(self._world)
  end
end

function ClientFirstWaveEnterSystem_Render:UnloadEffect(effectid)
  local poolSvc = self._world:GetService("ResourcesPool")
  local effSvc = self._world:GetService("Effect")
  local effResPath = effSvc:GetEffectResPath(effectid)
  if effResPath then
    poolSvc:DestroyCache(effResPath)
  end
end

function ClientFirstWaveEnterSystem_Render:_RefreshTeamHP(teamEntity)
  if teamEntity == nil then
    return
  end
  local hpCmpt = teamEntity:HP()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
    isLocalTeam = true,
    currentHP = hpCmpt:GetRedHP(),
    maxHP = hpCmpt:GetMaxHP(),
    hitpoint = hpCmpt:GetRedHP(),
    shield = 0,
    entityID = teamEntity:GetID(),
    showCurseHp = hpCmpt:GetShowCurseHp(),
    curseHpVal = hpCmpt:GetCurseHpValue()
  })
end
