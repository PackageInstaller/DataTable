local RectTransform = CS.UnityEngine.RectTransform
local T_Canvas = typeof(CS.UnityEngine.Canvas)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local BattleRoleRootUINode, Super = System.NewComponent("BattleRoleRootUINode")
local typeof = _ENV.typeof
local GameObject = CS.UnityEngine.GameObject
local Vector3 = CS.UnityEngine.Vector3
BattleRoleRootUINode.BodySizeToUIBox = {
  [bc.BodySize.Mini] = "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Small.prefab",
  [bc.BodySize.Middle] = "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Middle.prefab",
  [bc.BodySize.Big] = "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Big.prefab",
  [bc.BodySize.Huge] = "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Huge.prefab"
}

function BattleRoleRootUINode:ctor(parentRoot, battleRole)
  Super.ctor(self)
  self.HidingAllState = false
  self.parentRoot = parentRoot
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleRoleRootUINode:OnBind(binder)
  self.binder = binder
  self:CreateUINode()
  self:OnBindBase(binder)
  self.bloodUI = self.binder:BindNewComponent(self.hpBarRoot.gameObject, BattleRoleBloodUI, Func_Battle_Blood_ShareResource, self.battleRole, self.intentionRoot.gameObject)
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    self.intentionUI = binder:BindNewComponent(self.intentionRoot.gameObject, BattleRoleIntentionUI, UI_Battle_Item_IntentionResource, self.battleRole, true)
  end
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    self.bubbleUI = binder:BindComponent(BattleRoleBubbleUI(self.intentionRoot.gameObject, self.battleRole))
  else
    self.bubbleUI = binder:BindComponent(BattleRoleBubbleUI(self.bloodUI.ui.Parent_School, self.battleRole))
  end
  if bg.battleDataCenter.isRecover then
    if 0 == self.roleData:GetHp() and self.battleRole.camp == bc.BattleCamp.Camp2 then
      self:SetActiveWithIntention(false)
    end
    if self.roleData:GetProperty("monster_hide") > 0 then
      self:SetActiveWithIntention(false)
    end
  end
  self.binder:BindEvent(EventMgr.Instance.BattleCameraChange, function()
    bg.battleRender:PerformWithDelay(0.1, System.fn(self, self.UpdateRootHpAndRootIntentionPosition), self)
  end)
  binder:BindToRaw(function(_, n, o)
    if 0 == o and n > 0 and not self:_IsRoleHidden() and self.bloodUI and self.bloodUI.ui and not IsNil(self.bloodUI.ui.uiNode) then
      binder:SetCanvasGroup(self.bloodUI.ui.uiNode, 1)
    end
  end, function()
    do return self.roleData.GetProperty, self.roleData end
    return self.roleData.GetProperty, self.roleData, bc.RoleProperty.hp
  end)
end

function BattleRoleRootUINode:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  if bg.battleRender then
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
end

function BattleRoleRootUINode:CreateFloadTextUI()
  self.floatTextUI = self.binder:BindComponent(BattleRoleFloatTextUI(self.floatingTextRoot, self.battleRole))
  return self.floatTextUI
end

function BattleRoleRootUINode:GetBodySize()
  if bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeMiniState")) then
    return bc.BodySize.Mini
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeMiddleState")) then
    return bc.BodySize.Middle
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeBigState")) then
    return bc.BodySize.Big
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeHugeState")) then
    return bc.BodySize.Huge
  end
  local monsterData = self.battleRole.awakerList[1]
  local monsterCfg = DT.MonsterConfig[monsterData.tid]
  local bodySize = monsterCfg and monsterCfg.BodySize or bc.BodySize.Middle
  return bodySize
end

function BattleRoleRootUINode:CreateUINode()
  local hpBarPath
  if self.battleRole.camp == bc.BattleCamp.Camp1 then
    hpBarPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Func_Chararcter_UIRoot.prefab"
  else
    local bodySize = self:GetBodySize()
    hpBarPath = self.BodySizeToUIBox[bodySize]
  end
  local prefab = self.binder:LoadAsset(hpBarPath)
  local uiRoot = self.binder:Instantiate(prefab, self.parentRoot)
  local uiFollow = uiRoot:AddComponent(typeof(CS.Z1Client.StatusUIFollow))
  local followTarget = self.battleRole:GetRootNode()
  local offset = Vector3(0, 0, 0)
  uiFollow:Follow(followTarget, offset, bg.mainCamera, bg.uiCamera)
  self.uiRoot = uiRoot
  self.hpBarRoot = uiRoot.transform:Find("Root_HP").transform
  if self.roleData.camp == bc.BattleCamp.Camp1 then
    self.floatingTextRoot = uiRoot.transform:Find("Root_Blood").transform
  else
    local floatGo = uiRoot.transform:Find("Root_Floating_Monster")
    if not floatGo then
      floatGo = CS.UnityEngine.GameObject("Root_Floating_Monster")
      floatGo:AddComponent(typeof(RectTransform))
      floatGo:AddComponent(typeof(CS.Z1Client.StatusUIFollow))
      floatGo.transform:SetParent(uiRoot.transform)
      floatGo.transform:SetAsFirstSibling()
      UIRootMgr.SetLayerRecursively(floatGo, "UI")
      self.floatingTextRoot = floatGo.transform
      self.binder:onDestroy(function()
        CS.UnityEngine.GameObject.Destroy(floatGo)
      end)
    end
    local statusUIFlow = floatGo:GetComponent(typeof(CS.Z1Client.StatusUIFollow))
    if not self.bodyGo then
      local go = CS.UnityEngine.GameObject("BodyPos")
      go.transform:SetParent(followTarget)
      self.bodyGo = go
      self:RefreshBodyPos()
      self.binder:onDestroy(function()
        CS.UnityEngine.GameObject.Destroy(go)
      end)
    end
    self.floatingTextRoot.localScale = Vector3.one
    statusUIFlow:Follow(self.bodyGo.transform, Vector3.zero, bg.mainCamera, bg.uiCamera)
  end
  local canvas = self.floatingTextRoot.gameObject:GetComponent(T_Canvas)
  if not canvas then
    self.floatingTextRoot.gameObject:AddComponent(T_Canvas)
  end
  self.intentionRoot = uiRoot.transform:Find("Root_Intention").transform
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    self.releaseRoot = self.intentionRoot:Find("Root_Release").transform
    local rootPos = self.battleRole:GetFootPos()
    local scale = 1 - rootPos.z / 7
    local intentionRootPos = self.intentionRoot.anchoredPosition
    intentionRootPos.y = intentionRootPos.y * scale
    self.intentionRoot.anchoredPosition = intentionRootPos
  end
  self:UpdateRootHpAndRootIntentionPosition()
end

function BattleRoleRootUINode:RefreshBodyPos()
  if self.bodyGo then
    local bodyPos = self.battleRole:GetBodyPos()
    self.bodyGo.transform.position = bodyPos
  end
end

function BattleRoleRootUINode:UpdateRootHpAndRootIntentionPosition()
  if self.uiRoot == nil then
    return
  end
  local hpBarRootPos = self.hpBarRoot.transform.anchoredPosition
  local hpBarX, hpBarY = hpBarRootPos.x, hpBarRootPos.y
  if not UIRootMgr.IsInScreen(hpBarX, hpBarY) then
    bg.battleRender:PerformWithDelay(0.01, System.fn(self, self.UpdateRootHpAndRootIntentionPosition), self)
    return
  end
  local manualRootHP, manualRootIntention
  local isCamp2WithDimensionBar = false
  local intentionOffset = Vector3.zero
  local chaoweiOffset = Vector3(2.3, 0, 0)
  local chaoweiScale = Vector3.one
  local chaoweiPaddingLeft = 0
  if self.battleRole.camp ~= bc.BattleCamp.Camp1 then
    local awaker = self.battleRole.awakerList[1]
    manualRootHP = awaker:GetManualRootHP()
    local phaseIndex = self.roleData:GetBossPhaseIndex()
    manualRootIntention = awaker:GetManualRootIntention(phaseIndex)
    isCamp2WithDimensionBar = self:IsCamp2HasDimensionBar()
    if isCamp2WithDimensionBar then
      local leftOffsetX = -0.8
      intentionOffset = Vector3(leftOffsetX, 0, 0)
      chaoweiOffset = Vector3(2.3 + leftOffsetX, 0, 0)
      chaoweiScale = Vector3(0.7, 0.7, 1)
      chaoweiPaddingLeft = -140
    end
  end
  self:ApplyOffset(manualRootHP, self.hpBarRoot)
  self:ApplyOffset(manualRootIntention, self.intentionRoot, intentionOffset)
  if self.bloodUI and self.bloodUI.ui and isCamp2WithDimensionBar then
    self:ApplyOffset(manualRootIntention, self.bloodUI.ui.Content_Chaowei, chaoweiOffset)
    self.bloodUI.ui.Content_Chaowei.transform.localScale = chaoweiScale
    local layoutGroup = self.bloodUI.ui.Content_Chaowei:GetComponent(T_HorizontalLayoutGroup)
    if layoutGroup then
      local padding = layoutGroup.padding
      if padding and padding.left ~= chaoweiPaddingLeft then
        padding.left = chaoweiPaddingLeft
        layoutGroup.padding = padding
      end
    end
  end
  if self.roleData.camp == bc.BattleCamp.Camp2 then
    self:RefreshBodyPos()
    self.binder:BindTimer(0.05, 0, nil, System.fn(self, self.RefreshBodyPos))
  end
  if self.bloodUI then
    self.bloodUI:UpdatePosition()
  end
end

function BattleRoleRootUINode:IsCamp2HasDimensionBar()
  if self.roleData.camp ~= bc.BattleCamp.Camp2 then
    return false
  end
  local slotNum = self.roleData:GetProperty(bc.RoleProperty.monster_dimension_slot) or 0
  return slotNum > 0
end

function BattleRoleRootUINode:ApplyOffset(worldChildNode, uiNode, offsetVec3)
  local tFollow = typeof(CS.Z1Client.StatusUIFollow)
  local uiFollow = uiNode:GetComponent(tFollow)
  if worldChildNode then
    uiFollow = uiFollow or uiNode.gameObject:AddComponent(tFollow)
    uiFollow.enabled = true
    uiFollow:Follow(worldChildNode, offsetVec3 or Vector3(0, 0, 0), bg.mainCamera, bg.uiCamera)
    uiFollow:StartFollowing()
    local sizeDelta = uiFollow.transform.parent.sizeDelta
    sizeDelta.y = 0
    uiFollow.transform.parent.sizeDelta = sizeDelta
  elseif uiFollow then
    uiFollow.enabled = false
  end
end

function BattleRoleRootUINode:OnBindBase(binder)
  binder:BindToRaw(function(_, v, _)
    if v then
      if self.battleRole:IsLogicAlive() then
        return
      end
      binder:teardown()
      GameObject.Destroy(self.uiRoot)
      self.uiRoot = nil
    end
  end, function()
    return self.battleRole.dead.value
  end)
  binder:BindToRaw(function(_, phaseIndex)
    if phaseIndex and phaseIndex > 1 then
      self:UpdateRootHpAndRootIntentionPosition()
    end
    self:UniqueDealBoss(phaseIndex or 1)
  end, function()
    do return self.roleData.GetBossPhaseIndex end
    return self.roleData.GetBossPhaseIndex, self.roleData
  end)
end

function BattleRoleRootUINode:UniqueDealBoss(phase)
  if 1 == phase then
    self:SetChildObjActive("B0009_Idle_2_1", false)
    self:SetChildObjActive("B0009_Idle_2_2", false)
    self:SetChildObjActive("B0009_Idle_1_1", true)
    self:SetChildObjActive("B0009_Idle_1_2", true)
  elseif phase >= 2 then
    self:SetChildObjActive("B0009_Idle_1_1", false)
    self:SetChildObjActive("B0009_Idle_1_2", false)
    self:SetChildObjActive("B0009_Idle_2_1", true)
    self:SetChildObjActive("B0009_Idle_2_2", true)
  end
end

function BattleRoleRootUINode:SetChildObjActive(childName, isActive)
  local awaker = self.battleRole.awakerList[1]
  local obj = awaker and CS.Framework.GameObjectUtil.DeepFindChild(awaker.rootNode.transform, childName)
  if obj and not IsNil(obj) then
    self.binder:SetActive(obj.gameObject, isActive)
  end
end

function BattleRoleRootUINode:PlayReboneHpEffect()
  if self.bloodUI then
    self.bloodUI:PlayReboneHpEffect()
  end
end

function BattleRoleRootUINode:_RawProcess(isActive)
  self:_SetBloodActive(isActive)
  self:_SetIntentionActive(isActive)
end

function BattleRoleRootUINode:SetActive(isActive)
  if self.HidingAllState == true then
    return
  end
  self:_RawProcess(isActive)
  if isActive then
    self:SetBattleUIVisible()
  end
end

function BattleRoleRootUINode:HideOnSummon()
  if self.bloodUI and self.bloodUI.ui and not IsNil(self.bloodUI.ui.uiNode) then
    self.binder:SetCanvasGroup(self.bloodUI.ui.uiNode, 0)
  end
end

function BattleRoleRootUINode:SetBattleUIVisible()
  if self.nextFrameSet then
    return
  end
  self.nextFrameSet = true
  FrameWaiter.OnNextFrame(function()
    self.nextFrameSet = false
    if bg.battleScene then
      bg.battleScene:SetBattleUIVisible()
    end
  end, 1)
end

function BattleRoleRootUINode:SetActiveWithIntention(isActive)
  self:SetBloodActive(isActive)
  self:SetIntentionActive(isActive)
end

function BattleRoleRootUINode:SetAllInHiding(isActive)
  self.HidingAllState = isActive
  self:_RawProcess(not isActive)
end

function BattleRoleRootUINode:SetBloodActive(isActive)
  if self.HidingAllState == true then
    return
  end
  self:_SetBloodActive(isActive)
end

function BattleRoleRootUINode:_SetBubbleActive(isActive)
  if isActive then
    return
  end
  if self.bubbleUI then
    self.bubbleUI:SetActive(isActive)
  end
end

function BattleRoleRootUINode:_IsRoleHidden()
  local isHide = false
  if self.battleRole and self.battleRole.roleDataModel then
    local isHideVal = self.battleRole.roleDataModel:GetProperty("monster_hide")
    isHide = isHideVal and isHideVal > 0
  end
  return isHide
end

function BattleRoleRootUINode:_SetBloodActive(isActive)
  if self:_IsRoleHidden() then
    isActive = false
  end
  if 0 == self.battleRole:GetRealHp() and isActive then
    return
  end
  local time = 0.4
  local resultValue = isActive and 1 or 0
  if self.bloodUITween then
    self.bloodUITween:Kill()
  end
  if self.bloodUI.ui then
    self.bloodUITween = self.binder:DotweenProcessAlpha(self.bloodUI.ui.uiNode, resultValue, time)
    self.bloodUITween:OnComplete(function()
      self.bloodUITween = nil
    end)
  end
  if isActive then
    self:SetBattleUIVisible()
  end
end

function BattleRoleRootUINode:SetIntentionActive(isActive)
  if self.HidingAllState == true then
    return
  end
  self:_SetIntentionActive(isActive)
end

function BattleRoleRootUINode:_SetIntentionActive(isActive)
  if self:_IsRoleHidden() then
    isActive = false
  end
  local time = 0.4
  local resultValue = isActive and 1 or 0
  if self.intentionTween then
    self.intentionTween:Kill()
  end
  if self.intentionUI and self.intentionUI.ui then
    self.intentionTween = self.binder:DotweenProcessAlpha(self.intentionUI.ui.uiNode, resultValue, time)
    self.intentionTween:OnComplete(function()
      self.intentionTween = nil
    end)
  end
  if isActive then
    self:SetBattleUIVisible()
  end
  self:_SetBubbleActive(isActive)
end

function BattleRoleRootUINode:ShowDamageText(floatingTextType, data)
  self.floatTextUI:ShowDamageText(floatingTextType, data)
end

return BattleRoleRootUINode
