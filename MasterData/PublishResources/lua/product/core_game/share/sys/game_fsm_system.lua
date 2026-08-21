require("game_event_type")
_class("GameFSMSystem", Object)
GameFSMSystem = GameFSMSystem

function GameFSMSystem:Constructor(world)
  self._world = world
  self._gameFSMComponent = world:GameFSM()
  self.autoBinder = AutoEventBinder:New(self._world:EventDispatcher())
  self.autoBinder:BindEvent(GameEventType.ModeStateEnter, self, self.OnStateEnter)
end

function GameFSMSystem:Execute()
  self:UpdateFSM()
end

function GameFSMSystem:TearDown()
  self.autoBinder:UnBindEvent(GameEventType.ModeStateEnter)
end

function GameFSMSystem:UpdateFSM()
  self._gameFSMComponent:Update()
end

function GameFSMSystem:OnStateEnter()
  local gameFsmCmpt = self._gameFSMComponent
  if gameFsmCmpt == nil then
    return
  end
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID ~= GameStateID.WaitInput and gameFsmStateID ~= GameStateID.WaitInputChain then
    gameFsmCmpt:EnableHandleInput(false)
  end
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.GameFSM, gameFsmCmpt)
end
