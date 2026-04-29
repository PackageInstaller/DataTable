_class("PlayerActionFSMSystem_Render", Object)
PlayerActionFSMSystem_Render = PlayerActionFSMSystem_Render

function PlayerActionFSMSystem_Render:Constructor(world)
  self._world = world
  self.group = self._world:GetGroup(world.BW_WEMatchers.MoveFSM)
  self.cb = GameHelper:GetInstance():CreateCallback(self.OnStateEnter, self)
  self._world:EventDispatcher():AddCallbackListener(GameEventType.PlayerActionEnter, self.cb)
end

function PlayerActionFSMSystem_Render:TearDown()
  self._world:EventDispatcher():RemoveCallbackListener(GameEventType.PlayerActionEnter, self.cb)
end

function PlayerActionFSMSystem_Render:Execute()
  local timeService = self._world:GetService("Time")
  local deltaTimeMS = timeService:GetDeltaTimeMs()
  for i, e in ipairs(self.group:GetEntities()) do
    e:MoveFSM():Update(deltaTimeMS)
  end
end

function PlayerActionFSMSystem_Render:OnStateEnter(entityID)
  local actorEntity = self._world:GetEntityByID(entityID)
  if actorEntity then
    actorEntity:ReplaceMoveFSM()
  end
end
