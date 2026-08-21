require("monster_move_system")
_class("ClientMonsterMoveSystem_Render", MonsterMoveSystem)
ClientMonsterMoveSystem_Render = ClientMonsterMoveSystem_Render

function ClientMonsterMoveSystem_Render:_DoRenderHidePetInfo(TT)
  Log.debug("[refresh] HidePetInfo start ")
  local renderEntitySvc = self._world:GetService("RenderEntity")
  renderEntitySvc:ShowUITurnTips(false)
  self._renderBattleService:HideUIPetInfo(TT)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuideRound, GuideRoundTurn.MonsterTurn)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientMonsterMoveSystem_Render:_DoRenderTrapState(TT, calcStateTraps)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:RenderTrapState(TT, TrapDestroyType.DestroyByRound, calcStateTraps)
end

function ClientMonsterMoveSystem_Render:_DoRenderShowPetInfo(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPetInfo, 1)
end

function ClientMonsterMoveSystem_Render:_DoRenderInnerStoryMonsterTurn(TT)
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.WaveAndRoundBeginMonsterRound) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
end

function ClientMonsterMoveSystem_Render:_DoRenderMonsterBuff(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayMonsterTurnBuff(TT, false)
end

function ClientMonsterMoveSystem_Render:_DoRenderMonsterBuffDelayed(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayMonsterTurnBuff(TT, true)
  playBuffSvc:PlayMonsterTurnDelayedBuff(TT)
end

function ClientMonsterMoveSystem_Render:_DoRenderNotifyMonsterTurnEnd(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTMonsterTurnEnd:New())
end

function ClientMonsterMoveSystem_Render:_DoRenderShowInnerStory(TT)
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.WaveAndRoundAfterMonsterRound) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
  innerStoryService:CheckStoryTips(StoryShowType.WaveAndRoundAfterMonsterRound)
end

function ClientMonsterMoveSystem_Render:_DoRenderMonsterLockHPState(TT)
  local PlayBuffService = self._world:GetService("PlayBuff")
  PlayBuffService:RefreshLockHPView(TT, GameStateID.MonsterTurn)
end

function ClientMonsterMoveSystem_Render:_WaitBeHitSkillFinish(TT)
  local count = 0
  local previewEntity = self._world:GetPreviewEntity()
  local renderState = previewEntity:RenderState()
  if renderState and renderState:GetRenderStateType() == RenderStateType.WaitPlayTask then
    local taskID = renderState:GetRenderStateParam()
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
      count = count + 1
    end
  end
  if count ~= 0 then
    Log.warn("HPLock Wait Count:", count)
  end
end

function ClientMonsterMoveSystem_Render:_DoRenderPlayMonsterAction(TT)
  local monsterMoveServiceRender = self.world:GetService("MonsterMoveRender")
  monsterMoveServiceRender:_DoRenderPlayMonsterAction(TT)
end

function ClientMonsterMoveSystem_Render:_DoRenderTrapBeforeMonster(TT)
  local monsterMoveServiceRender = self.world:GetService("MonsterMoveRender")
  monsterMoveServiceRender:_DoRenderTrapBeforeMonster(TT)
end

function ClientMonsterMoveSystem_Render:_DoRenderTrapAfterMonster(TT)
  local monsterMoveServiceRender = self.world:GetService("MonsterMoveRender")
  monsterMoveServiceRender:_DoRenderTrapAfterMonster(TT)
end

function ClientMonsterMoveSystem_Render:_DoRenderHideBesiegedTips(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideBesiegedTips, false)
end

function ClientMonsterMoveSystem_Render:_DoRenderInWave(TT, traps, monsters)
  local utilDataSvc = self._world:GetService("UtilData")
  local waveNum = utilDataSvc:GetStatCurWaveIndex()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local interval = levelConfigData:GetWaveShowInterval(waveNum)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:PlaySpawnInWave(TT, traps, monsters, interval)
end

function ClientMonsterMoveSystem_Render:_UpdateTrapGridRound(TT)
  local svc = self._world:GetService("TrapRender")
  svc:UpdateTrapGridRound()
end

function ClientMonsterMoveSystem_Render:_DoRenderWorldBossStageBuff(TT)
  if self._world:MatchType(GetMatchTypeType.WorldBossBattle) == MatchType.MT_WorldBoss then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTWorldBossStageSwitch:New())
  end
end

function ClientMonsterMoveSystem_Render:_DoPrintAIDebugInfo(TT)
  local aiLogger = self._world:GetAILogger()
  aiLogger:SaveAILog()
end

function ClientMonsterMoveSystem_Render:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTMonsterRoundBeforeTrapRoundCount:New(teamEntity))
end
