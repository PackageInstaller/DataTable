local BattleCardAnimMgr, _ = System.NewClass("BattleCardAnimMgr")

function BattleCardAnimMgr:ctor(cardItem, _, cardMgr)
  self.cardItem = cardItem
  self.cardMgr = cardMgr
  self.lineFsm = LinearFsm(self)
end

function BattleCardAnimMgr:OnBind(binder)
  local fsm = self.lineFsm
  fsm:OnBind(binder)
  fsm:AddState(CardReset(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDraw(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDrop(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDropFadeAway(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDropBurnPVP(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDropBurn(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDrag(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardOtherDrag(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardUse(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardPutBack(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardRelayout(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDisplay(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardOtherDisplay(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDisplayBack(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardSelectBack(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardDisappear(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardConsume(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardInsert(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardEmbryoNew(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardEmbryoSwallow(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardBlessingUse(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardFromDimension(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardUseBack(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardChange(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardRecordUse(self.cardItem, nil, self.cardMgr))
  fsm:AddState(CardForceUse(self.cardItem, nil, self.cardMgr))
end

function BattleCardAnimMgr:GotoState(animState, ...)
  if not self:CanRunAnimState(animState) then
    return
  end
  local animStateCls = self:GetStateCls(animState)
  self.lineFsm:GotoState(animStateCls, true, ...)
end

function BattleCardAnimMgr:ExitState(stateName)
  local animStateCls = self:GetStateCls(stateName)
  local state = self.lineFsm:GetState(animStateCls)
  if state.isEntered then
    state:Exit()
  end
end

function BattleCardAnimMgr:IsInState(stateName)
  local animStateCls = self:GetStateCls(stateName)
  local state = self.lineFsm:GetState(animStateCls)
  return state and state.isEntered
end

function BattleCardAnimMgr:UpdateState(animState, ...)
  if not self:CanRunAnimState(animState) then
    return
  end
  local animStateCls = self:GetStateCls(animState)
  local state = self.lineFsm:GetState(animStateCls)
  if not state.isEntered then
    self.lineFsm:GotoState(animStateCls, true)
  end
  state:UpdateState(...)
end

function BattleCardAnimMgr:CanRunAnimState(animState)
  local recordForceUseState = CommonDefine.CardAnim.CardForceUse
  if animState == recordForceUseState then
    return true
  end
  return not self:IsInState(recordForceUseState)
end

function BattleCardAnimMgr:IsInAnyAnimState(exceptMap)
  exceptMap = exceptMap or {}
  local stateMap = CommonDefine.CardAnim
  for _, stateName in pairs(stateMap) do
    if not exceptMap[stateName] then
      local animStateCls = self:GetStateCls(stateName)
      local state = self.lineFsm:GetState(animStateCls)
      if state and state.isEntered then
        return true
      end
    end
  end
end

function BattleCardAnimMgr:GetStateCls(stateName)
  local animStateCls = require("GameScript.UI.DbgBattle.BattleCardUI.CardAnim.State." .. stateName)
  return animStateCls
end

function BattleCardAnimMgr:ResetAllStates()
  local stateMap = CommonDefine.CardAnim
  for _, stateName in pairs(stateMap) do
    local animStateCls = self:GetStateCls(stateName)
    local state = self.lineFsm:GetState(animStateCls)
    if state and state.isEntered then
      state:Exit()
    end
  end
end

return BattleCardAnimMgr
