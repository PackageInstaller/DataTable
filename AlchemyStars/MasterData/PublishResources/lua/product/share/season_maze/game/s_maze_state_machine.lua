_class("SMazeStateMachine", Object)
SMazeStateMachine = SMazeStateMachine

function SMazeStateMachine:Constructor(mn)
  self._manager = mn
  self._type2ID = {
    [SMazeState_Born] = SMazeStateID.Born,
    [SMazeState_RoundBegin] = SMazeStateID.RoundBegin,
    [SMazeState_PlayCard] = SMazeStateID.PlayCard,
    [SMazeState_CardSettle] = SMazeStateID.CardSettle,
    [SMazeState_PlayerMove] = SMazeStateID.PlayerMove,
    [SMazeState_ArriveRoom] = SMazeStateID.ArriveRoom,
    [SMazeState_RoomSettle] = SMazeStateID.RoomSettle,
    [SMazeState_RoundEnd] = SMazeStateID.RoundEnd,
    [SMazeState_BossAttack] = SMazeStateID.BossAttack,
    [SMazeState_MazeComplete] = SMazeStateID.MazeComplete,
    [SMazeState_ChooseRelic] = SMazeStateID.ChooseRelic,
    [SMazeState_Levelup] = SMazeStateID.Levelup,
    [SMazeState_ChooseFullPet] = SMazeStateID.ChooseFullPet,
    [SMazeState_WorldBoss] = SMazeStateID.WorldBoss
  }
  self._curState = nil
  self._curNode = nil
end

function SMazeStateMachine:Init()
  local type = SMazeState_Born
  local stateID = self._type2ID[type]
  self._curState = type:New(stateID, self, self._manager)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeStateChanged, self._curState:StateID())
  self._curState:OnEnter()
end

function SMazeStateMachine:Update(dt)
  if self._curState then
    self._curState:OnUpdate(dt)
  end
end

function SMazeStateMachine:Dispose()
  self._manager = nil
  self._type2ID = nil
  if self._curState and self._curState:Valid() then
    self._curState:Dispose()
  end
  self._curState = nil
  self._curNode = nil
end

function SMazeStateMachine:ChangeStateTo(type, ...)
  if not type:IsChildOf("SMazeStateBase") then
    Log.exception(type._className, "不是 SMazeStateBase 的子类")
    return nil
  end
  self._curState:OnExit()
  self._curState:Dispose()
  local stateID = self._type2ID[type]
  local state = type:New(stateID, self, self._manager)
  Log.debug("赛季秘境切换状态:", state:StateID())
  self._curState = state
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeStateChanged, self._curState:StateID())
  self._curState:OnEnter(...)
end

function SMazeStateMachine:CurState()
  return self._curState
end

function SMazeStateMachine:SetCurNode(node)
  self._curNode = node
end

function SMazeStateMachine:GetCurNode()
  return self._curNode
end

function SMazeStateMachine:_AddRelicEft(eft)
  if not self._relickEfts then
    self._relickEfts = {}
  end
  table.insert(self._relickEfts, eft)
end

function SMazeStateMachine:_GetAndClearRelicAssets()
  if not self._relickEfts then
    return
  end
  local assets = SeasonMazeTool:GetInstance():Efts2Assets(self._relickEfts)
  self._relickEfts = nil
  return assets
end
