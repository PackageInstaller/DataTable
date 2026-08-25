local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local RectTransform = CS.UnityEngine.RectTransform
local MAX_CAMP1_BUFF_COUNT = 16
local MAX_CAMP2_BUFF_COUNT = 14
local tempHasMap = {}
local BattleRoleStateUI, Super = System.NewComponent("BattleRoleStateUI")

function BattleRoleStateUI:ctor(uiNode, battleRole, intentNode)
  Super.ctor(self)
  self.ui = Func_Battle_Blood_ShareResource(uiNode)
  self.intentNode = intentNode
  self.role = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.stateList = Vue.ref({})
  self.stateMap = {}
  self.stateItemInfo = {}
  self.stateItems = {}
  self.maxStateCount = 0
  self.stateCount = Vue.ref(0)
  if self.role.camp == bc.BattleCamp.Camp1 then
    self.maxStateCount = MAX_CAMP1_BUFF_COUNT
  else
    self.maxStateCount = MAX_CAMP2_BUFF_COUNT
  end
end

function BattleRoleStateUI:OnBind(binder)
  self.binder = binder
  self:BindState(binder)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DelState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeStateLayer, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UpdateStateArgs, self.DelayUpdateStateList, self)
end

function BattleRoleStateUI:OnUnbind()
  Super.OnUnbind(self)
  if bg.battleRender then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
end

function BattleRoleStateUI:BindState(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    self:ShowStateList()
  end)
  local DragGesture = CS.Z1Client.General.DragGesture
  local gesture = self.ui.Btn_Click:GetComponent(typeof(DragGesture))
  self.gesture = gesture
  self.gesture:onPointerUp("+", function()
    UIManager.Instance:CloseByUrl(Urls.BuffListPanelNew)
    UIManager.Instance:CloseByUrl(Urls.MonsterBuffListPanel)
  end)
  binder:BindToRaw(function(_, isVisible)
    if not isVisible then
      UIManager.Instance:CloseByUrl(Urls.BuffListPanelNew)
      UIManager.Instance:CloseByUrl(Urls.MonsterBuffListPanel)
    end
  end, function()
    return bg.battlePanel and bg.battlePanel.isUIVisible and bg.battlePanel.isUIVisible.value
  end)
  self:BindClickAreaToMonsterShape()
  self:DelayUpdateStateList()
end

function BattleRoleStateUI:DelayUpdateStateList()
  if self.delayUpdateTimer then
    return
  end
  self.delayUpdateTimer = bg.battleRender:PerformWithDelay(0.1, System.fn(self, self.UpdateStateList), self)
end

function BattleRoleStateUI:UpdateStateList()
  self.stateItemMap = self.stateItemMap or {}
  local showStateList = bg.battleDataCenter.stateData:GetShowStateList(self.roleUid)
  local hasMap = tempHasMap
  table.clear(hasMap)
  local stateItem
  for _, state in ipairs(showStateList) do
    hasMap[state.stateUid] = true
    stateItem = self.stateItemMap[state.stateUid]
    if not stateItem then
      stateItem = self.binder:BindNewComponent(self.ui.Content_Buff, StateStatusItem, Item_Battle_BuffResource, self.role, state, true)
      self.stateItemMap[state.stateUid] = stateItem
    else
      stateItem:UpdateState(state)
    end
  end
  for uid, stateItem in pairs(self.stateItemMap) do
    if not hasMap[uid] then
      stateItem.binder:teardown()
      self.stateItemMap[uid] = nil
    end
  end
  self:UpdateTaweiStateCounter()
  if self.delayUpdateTimer then
    bg.battleRender:UnperformWithDelay(self.delayUpdateTimer)
    self.delayUpdateTimer = nil
  end
end

function BattleRoleStateUI:UpdateTaweiStateCounter()
  local stateId, maxLayer = table.unpack(DT.GetOriginalConstant("TaWeiFusionStateId") or {})
  if stateId then
    local stateList = bg.battleDataCenter.stateData:GetStateListByOwnerAndStateId(self.roleUid, stateId)
    local state = stateList[1]
    if not self.taweiCounterComp and state then
      local res = Item_Battle_BossFusionTankResource
      self.taweiCounterComp = self.binder:BindNewComponent(self.ui.Content_FunsionTank, TaweiStateCounterItem, res, stateId, maxLayer)
    end
    if self.taweiCounterComp then
      self.taweiCounterComp:UpdateLayer(state and state.layer or 0, state)
    end
    self.binder:SetActive(self.ui.Content_FunsionTank, nil ~= state)
  end
end

function BattleRoleStateUI:BindClickAreaToMonsterShape()
  local mainCamera = UIRootMgr.GetMainCamera()
  local upRectTransform = self.intentNode:GetComponent(typeof(RectTransform))
  local downRectTransform = self.ui.Btn_Click_Range:GetComponent(typeof(RectTransform))
  local screenUpPosY = mainCamera:WorldToScreenPoint(upRectTransform.position).y
  local screenDownPosY = mainCamera:WorldToScreenPoint(downRectTransform.position).y - downRectTransform.sizeDelta.y / 2
  local targetTF = self.ui.Btn_Click:GetComponent(typeof(RectTransform))
  targetTF.sizeDelta = Vector2(downRectTransform.sizeDelta.x, screenUpPosY - screenDownPosY)
end

function BattleRoleStateUI:ShowStateList()
  if bg.battlePanel and bg.battlePanel.isUIVisible and not bg.battlePanel.isUIVisible.value then
    return
  end
  local effectDescGroup = bg.battleDataCenter.stateData:GetRoleShowStateEffectDescGroup(self.roleUid, true)
  if self.role.camp == bc.BattleCamp.Camp1 then
    if #effectDescGroup.descList > 0 then
      UIManager.Instance:Show(Urls.BuffListPanelNew, effectDescGroup)
    end
  else
    UIManager.Instance:Show(Urls.MonsterBuffListPanel, self.role, effectDescGroup)
  end
end

return BattleRoleStateUI
