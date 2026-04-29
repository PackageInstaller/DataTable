_class("FightResultEventListenerRender", Object)
FightResultEventListenerRender = FightResultEventListenerRender

function FightResultEventListenerRender:Constructor(world, autoBinder)
  self._world = world
  autoBinder:BindEvent(GameEventType.MissionFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.ExtMissionFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.ResDungeonFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.TowerFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.MazeFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.TalePetFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.LostAreaFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.CampaignFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.ConquestFightResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.BlackFistResult, self, self.OnCommonFightResult)
  autoBinder:BindEvent(GameEventType.AniPopFightResult, self, self.OnCommonFightResult)
end

function FightResultEventListenerRender:OnCommonFightResult(result)
  if result == true then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleResultFinish, result)
  else
    GameGlobal.TaskManager():CoreGameStartTask(self._WaitPlayerDeadTask, self, result)
  end
end

function FightResultEventListenerRender:_WaitPlayerDeadTask(TT, battleRes)
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  if playerEntity then
    local teamLeaderEntity = playerEntity:GetTeamLeaderPetEntity()
    local utilData = self._world:GetService("UtilData")
    if utilData:PlayerIsDead(playerEntity) then
      local deadTriggerParam = "Death"
      local deadAnimName = "death"
      local viewCmpt = teamLeaderEntity:View()
      local playerObj = viewCmpt:GetGameObject()
      local animTimeLen = GameObjectHelper.GetActorAnimationLength(playerObj, deadAnimName)
      teamLeaderEntity:SetAnimatorControllerTriggers({deadTriggerParam})
      YIELD(TT, animTimeLen * 1000)
      Log.debug("EventListenerServiceRender:_WaitPlayerDeadTask ", battleRes)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleResultFinish, battleRes)
end
