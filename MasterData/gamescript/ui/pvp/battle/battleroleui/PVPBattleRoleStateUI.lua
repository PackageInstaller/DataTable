local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local RectTransform = CS.UnityEngine.RectTransform
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MAX_CAMP1_BUFF_COUNT = 16
local MAX_CAMP2_BUFF_COUNT = 14
local tempHasMap = {}
local PVPBattleRoleStateUI, Super = System.NewComponent("PVPBattleRoleStateUI")

function PVPBattleRoleStateUI:ctor(uiNode, battleRole, intentNode)
  Super.ctor(self)
  self.ui = UI_Pvp_Blood_ShareResource(uiNode)
  self.intentNode = intentNode
  self.role = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.stateList = Vue.ref({})
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

function PVPBattleRoleStateUI:OnBind(binder)
  self.binder = binder
  self:BindState(binder)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DelState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeStateLayer, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UpdateStateArgs, self.DelayUpdateStateList, self)
end

function PVPBattleRoleStateUI:OnUnbind()
  Super.OnUnbind(self)
  if bg.battleRender then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
end

function PVPBattleRoleStateUI:BindState(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    self:ShowStateList()
  end)
  local DragGesture = CS.Z1Client.General.DragGesture
  local gesture = self.ui.Btn_Click:GetComponent(typeof(DragGesture))
  self.gesture = gesture
  self.gesture:onPointerUp("+", function()
    UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
  end)
  binder:BindToRaw(function()
  end, System.fn(self, self.OnBattlePanelVisible))
  binder:BindToRaw(function()
    self:DelayUpdateStateList()
  end, function()
    do return self.roleData.GetBlock end
    return self.roleData.GetBlock, self.roleData
  end)
  self:BindClickAreaToMonsterShape()
  self:DelayUpdateStateList()
end

function PVPBattleRoleStateUI:DelayUpdateStateList()
  if self.delayUpdateTimer then
    return
  end
  self.delayUpdateTimer = bg.battleRender:PerformWithDelay(0.1, System.fn(self, self.UpdateStateList), self)
end

function PVPBattleRoleStateUI:UpdateStateList()
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
  self:CheckWeaponState()
  if self.delayUpdateTimer then
    bg.battleRender:UnperformWithDelay(self.delayUpdateTimer)
    self.delayUpdateTimer = nil
  end
end

function PVPBattleRoleStateUI:BindClickAreaToMonsterShape()
  if IsNil(self.intentNode) then
    return
  end
  local upRectTransform = self.intentNode:GetComponent(typeof(RectTransform))
  local downRectTransform = self.ui.Btn_Click:GetComponent(typeof(RectTransform))
  local upBottomWorldPos = upRectTransform:TransformPoint(Vector3(0, 0, 0))
  local downTopLocalPos = upRectTransform.parent:InverseTransformPoint(upBottomWorldPos)
  local sizeDelta = downRectTransform.sizeDelta
  if downTopLocalPos.y > 99999 then
    if not self.statusUIPostionAdjTimer then
      self.statusUIPostionAdjTimer = self.binder:BindTimer(0.2, -1, function()
        self:BindClickAreaToMonsterShape()
      end)
    end
    downTopLocalPos.y = 320
  elseif self.statusUIPostionAdjTimer then
    self.binder:StopTimer(self.statusUIPostionAdjTimer)
    self.statusUIPostionAdjTimer = nil
  end
  downRectTransform.sizeDelta = Vector2(sizeDelta.x, downTopLocalPos.y)
end

function PVPBattleRoleStateUI:ShowStateList()
  if not bg.battlePanel.isUIVisible.value then
    return
  end
  if not self.awakerInfoDataSource then
    self.awakerInfoDataSource = BattleAwakerInfoDataSource(self.roleData)
    self.awakerInfoModel = self.binder:createModel(AwakerInfoModel, self.awakerInfoDataSource)
  end
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
  UIManager.Instance:Show(Urls.CopiesAwakerInfoPanelNew, self.awakerInfoModel)
end

function PVPBattleRoleStateUI:OnBattlePanelVisible()
  if not bg.battlePanel.isUIVisible.value then
    UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
  end
end

function PVPBattleRoleStateUI:CheckWeaponState()
  local preWeaponCfg = self.curWeaponCfg
  local weaponStateCfg
  local WeaponIconAndDesc = CommonDefine.StateShowType.WeaponIconAndDesc
  local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(self.roleUid)
  for _, state in pairs(stateList) do
    local sc = BattleStateDataClient(state)
    if not sc:ShowJudgement() then
    elseif state.configData.ShowType == WeaponIconAndDesc then
      weaponStateCfg = state.configData
      break
    end
  end
  if weaponStateCfg and weaponStateCfg.BelongWeapon and DT.PVPCollect[weaponStateCfg.BelongWeapon] then
    self.binder:SetActive(self.ui.Image_Icon_2, true)
    self.binder:SetImage(self.ui.Image_Icon_2, DT.PVPCollect[weaponStateCfg.BelongWeapon].WeaponMiniIcon)
  end
  self.curWeaponCfg = weaponStateCfg
  local isNewWeapon = self.curWeaponCfg and preWeaponCfg ~= self.curWeaponCfg
  local isTakeOff = preWeaponCfg and not self.curWeaponCfg
  if isNewWeapon then
    local uiAnimCtr = self.ui.Image_Wheeloflife:GetComponent(T_UIAnimationController)
    uiAnimCtr:PlayState("UI_Pvp_Blood_Share_Weapon_Open")
  elseif isTakeOff then
    local uiAnimCtr = self.ui.Image_Wheeloflife:GetComponent(T_UIAnimationController)
    uiAnimCtr:PlayState("UI_Pvp_Blood_Share_Weapon_Close")
  end
end

return PVPBattleRoleStateUI
