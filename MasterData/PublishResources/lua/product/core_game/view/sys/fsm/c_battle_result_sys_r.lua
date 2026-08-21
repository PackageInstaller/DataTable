require("battle_result_system")
_class("ClientBattleResultSystem_Render", BattleResultSystem)
ClientBattleResultSystem_Render = ClientBattleResultSystem_Render

function ClientBattleResultSystem_Render:_DoLogicBattleResult()
  local battleSvcRender = self._world:GetService("RenderBattle")
  battleSvcRender:NotifyUIBattleGameOver(self.battleMatchResult)
end

function ClientBattleResultSystem_Render:_DoRenderShowExit(TT, victory, defeatType)
  local playbuff = self._world:GetService("PlayBuff")
  playbuff:PlayBuffView(TT, NTGameOver:New(victory, defeatType))
  self:PlayExitLevelView(TT, victory)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSetGraphicRaycaster, false)
  if victory == 1 then
    local innerStoryService = self._world:GetService("InnerStory")
    if innerStoryService:CheckStoryBanner(StoryShowType.AfterAllMonsterDeadBeginExitGame) then
      InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
    end
    local guideService = self._world:GetService("Guide")
    guideService:Trigger(GameEventType.GuideBattleFinish)
    guideService:YieldComplete()
    local cutsceneSvc = self._world:GetService("Cutscene")
    cutsceneSvc:PlayRealTimeCutscene(TT, StoryShowType.AfterAllMonsterDeadBeginExitGame)
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local utilData = self._world:GetService("UtilData")
  if victory ~= 0 and not utilData:PlayerIsDead(teamEntity) then
    local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    local victoryTaskIDs = {}
    local playSkillService = self._world:GetService("PlaySkill")
    for _, trapEntity in ipairs(trapGroup:GetEntities()) do
      local trapCmpt = trapEntity:TrapRender()
      if not trapEntity:HasDeadFlag() then
        local skillId = trapCmpt:GetVictorySkillID()
        if skillId and 0 < skillId and victory == 1 then
          local taskId = playSkillService:PlaySkillView(trapEntity, skillId)
          table.insert(victoryTaskIDs, taskId)
        end
      end
    end
    while TaskHelper:GetInstance():IsAllTaskFinished(victoryTaskIDs) == false do
      YIELD(TT)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowTransitionEffect)
    YIELD(TT, 1000)
  end
  UnityEngine.Shader.DisableKeyword("_CELL_CLIP")
end

function ClientBattleResultSystem_Render:PlayExitLevelView(TT, victory)
  if victory ~= 1 then
    return
  end
  local viewDataEntity = self._world:GetRenderBoardEntity()
  local waveDataCmpt = viewDataEntity:WaveData()
  if waveDataCmpt:IsExitWave() then
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    local traps = trapGroup:GetEntities()
    local eExitTrap
    for _, e in ipairs(traps) do
      local trapRenderCmpt = e:TrapRender()
      if trapRenderCmpt and trapRenderCmpt:GetTrapID() == BattleConst.ExitTrapID then
        eExitTrap = e
        break
      end
    end
    if not eExitTrap then
      Log.fatal("### [PlayExitLevelView] no exit trap in this level")
      return
    end
    local playSkillService = self._world:GetService("PlaySkill")
    local waitTaskID = playSkillService:PlaySkillView(eExitTrap, BattleConst.ExitViewSkillID)
    while not TaskHelper:GetInstance():IsAllTaskFinished({waitTaskID}) do
      YIELD(TT)
    end
  end
end
