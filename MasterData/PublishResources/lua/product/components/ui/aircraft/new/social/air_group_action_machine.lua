require("fsm_state_machine")
require("air_group_action_state_base")
_class("AirGroupActionMachine", FSMStateMachine)
AirGroupActionMachine = AirGroupActionMachine

function AirGroupActionMachine:Constructor(executor, stateTypes)
  self.m_StateTypes = stateTypes
  self.m_CurIndex = 0
  self._disposed = false
end

function AirGroupActionMachine:OnInit()
  self:Add(AirGroupActionNoneState:New(AirGroupActionStateType.None, self))
  self:Add(AirGroupActionMoveState:New(AirGroupActionStateType.Move, self))
  self:Add(AirGroupActionFollowState:New(AirGroupActionStateType.Follow, self))
  self:Add(AirGroupActionLookAtState:New(AirGroupActionStateType.LookAt, self))
  self:Add(AirGroupActionTalkState:New(AirGroupActionStateType.Talk, self))
  self:Add(AirGroupActionFurnitureState:New(AirGroupActionStateType.Furniture, self))
  self:Add(AirGroupActionStandState:New(AirGroupActionStateType.Stand, self))
  self:Add(AirGroupActionCloserState:New(AirGroupActionStateType.Closer, self))
  self:Add(AirGroupActionLocatedState:New(AirGroupActionStateType.Located, self))
  self:Add(AirGroupActionCorrectState:New(AirGroupActionStateType.Correct, self))
  self:Add(AirGroupActionMoveTalkState:New(AirGroupActionStateType.MoveTalk, self))
  self:Add(AirGroupActionFurnitureTalkState:New(AirGroupActionStateType.FurnitureTalk, self))
  self:SetDefault(AirGroupActionStateType.None)
end

function AirGroupActionMachine:ChangeNextState()
  self.m_CurIndex = self.m_CurIndex + 1
  if self.m_CurIndex > #self.m_StateTypes then
    if not self._disposed then
      self._disposed = true
      if self.callback then
        self.callback(self.sender)
      end
    end
  else
    self:ChangeState(self.m_StateTypes[self.m_CurIndex])
    Log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!改变行为", self.m_StateTypes[self.m_CurIndex])
  end
end

function AirGroupActionMachine:ChangeStartState(state)
  local index = table.ikey(self.m_StateTypes, state)
  self.m_CurIndex = index
  self:ChangeState(self.m_StateTypes[self.m_CurIndex])
end

function AirGroupActionMachine:StartState()
  self.m_CurIndex = 1
  self:ChangeState(self.m_StateTypes[self.m_CurIndex])
end

function AirGroupActionMachine:SetProcessFinish(callBack, sender)
  self.callback = callBack
  self.sender = sender
end

function AirGroupActionMachine:OnDispose()
  if not self._disposed then
    self._disposed = true
    if self.callback then
      self.callback(self.sender)
    end
  end
end
