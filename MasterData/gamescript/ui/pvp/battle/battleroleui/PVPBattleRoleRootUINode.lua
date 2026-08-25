local RectTransform = CS.UnityEngine.RectTransform
local CSStatusUIFollow = typeof(CS.Z1Client.StatusUIFollow)
local PVPBattleRoleRootUINode, Super = System.NewComponent("PVPBattleRoleRootUINode", nil, IBattleRoleStatusUI)
local typeof = _ENV.typeof
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2

function PVPBattleRoleRootUINode:ctor(parentRoot, battleRole)
  Super.ctor(self)
  self.parentRoot = parentRoot
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function PVPBattleRoleRootUINode:OnBind(binder)
  self.binder = binder
  self:CreateUINode()
  self:OnBindBase(binder)
  self.bloodUI = self.binder:BindNewComponent(self.hpBarRoot.gameObject, PVPBattleRoleBloodUI, UI_Pvp_Blood_ShareResource, self.battleRole, self.intentionRoot.gameObject)
  binder:BindEvent(EventMgr.Instance.OnAwakerExSkillAnimStart, System.fn(self, self.OnExSkillAnimStart))
  binder:BindEvent(EventMgr.Instance.OnAwakerExSkillAnimEnd, System.fn(self, self.OnExSkillAnimEnd))
  binder:BindEvent(EventMgr.Instance.PVPViewChange, System.fn(self, self.OnPVPViewChange))
end

function PVPBattleRoleRootUINode:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function PVPBattleRoleRootUINode:CreateFloadTextUI()
  self.floatTextUI = self.binder:BindComponent(BattleRoleFloatTextUI(self.floatingTextRoot, self.battleRole))
  return self.floatTextUI
end

function PVPBattleRoleRootUINode:CreateUINode()
  local uiAttachmentAsset = bc.PVPRoleUIRootPrefab
  local prefab = self.binder:LoadAsset(uiAttachmentAsset)
  local uiRoot = self.binder:Instantiate(prefab, self.parentRoot)
  local uiFollow = uiRoot:AddComponent(CSStatusUIFollow)
  local firstAwaker = self.battleRole.awakerList[1]
  local followTarget = firstAwaker and firstAwaker.rootNode.transform or self.battleRole:GetRootNode()
  local offset = Vector3(0, 0, 0)
  uiFollow:Follow(followTarget, offset, bg.mainCamera, bg.uiCamera)
  self.uiRoot = uiRoot
  self.hpBarRoot = uiRoot.transform:Find("Root_HP").transform
  local floatGo = uiRoot.transform:Find("Root_Floating_Monster")
  if not floatGo then
    floatGo = CS.UnityEngine.GameObject("Root_Floating_Monster")
    floatGo:AddComponent(typeof(RectTransform))
    floatGo:AddComponent(typeof(CS.Z1Client.StatusUIFollow))
    floatGo.transform:SetParent(uiRoot.transform)
    floatGo.transform:SetAsFirstSibling()
    self.floatingTextRoot = floatGo.transform
    self.binder:onDestroy(function()
      CS.UnityEngine.GameObject.Destroy(floatGo)
    end)
  end
  local statusUIFlow = floatGo:GetComponent(typeof(CS.Z1Client.StatusUIFollow))
  if not self.bodyGo then
    local go = CS.UnityEngine.GameObject("_BodyPos")
    if firstAwaker then
      go.transform:SetParent(firstAwaker.rootNode.transform)
    else
      go.transform:SetParent(self.battleRole:GetRootNode())
    end
    self.bodyGo = go
    self:RefreshBodyPos()
    self.binder:onDestroy(function()
      CS.UnityEngine.GameObject.Destroy(go)
    end)
  end
  statusUIFlow:Follow(self.bodyGo.transform, Vector3.zero, bg.mainCamera, bg.uiCamera)
  self.floatingTextRoot.localScale = Vector3.one
  self.floatingTextRoot.localPosition = Vector3.zero
  self.intentionRoot = uiRoot.transform:Find("Root_Intention").transform
  self.releaseRoot = self.intentionRoot:Find("Root_Release").transform
  self.voiceRoot = uiRoot.transform:Find("Root_AwakerVoice").transform
  local rootPos = self.battleRole:GetFootPos()
  local scale = 1 - rootPos.z / 7
  local intentionRootPos = self.intentionRoot.anchoredPosition
  intentionRootPos.y = intentionRootPos.y * scale
  self.intentionRoot.anchoredPosition = intentionRootPos
  self:UpdateRootHpAndRootIntentionPosition()
end

function PVPBattleRoleRootUINode:RefreshBodyPos()
  if not self.bodyGo then
    return
  end
  local awaker = self.battleRole.awakerList[1]
  if awaker then
    self.bodyGo.transform.position = awaker:GetBodyPos()
  end
end

function PVPBattleRoleRootUINode:OnPVPViewChange()
  self:RefreshBodyPos()
end

function PVPBattleRoleRootUINode:UpdateRootHpAndRootIntentionPosition()
  local manualRootIntention, manualRootHP
  local RectTransformUtility = CS.UnityEngine.RectTransformUtility
  if self.battleRole.camp ~= bc.BattleCamp.Camp1 then
    local awaker = self.battleRole.awakerList[1]
    manualRootHP = false
    manualRootIntention = awaker:GetManualRootIntention()
  end
  if manualRootHP then
    local uiCamera = UIRootMgr.GetUICamera()
    local mainCamera = UIRootMgr.GetMainCamera()
    local rectTrans = self.hpBarRoot.parent:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local screenPos = mainCamera:WorldToScreenPoint(manualRootHP.position)
    screenPos = Vector2(screenPos.x, screenPos.y)
    local _, worldPos = RectTransformUtility.ScreenPointToWorldPointInRectangle(rectTrans, screenPos, uiCamera)
    self.hpBarRoot.position = worldPos
  end
  if manualRootIntention then
    local uiCamera = UIRootMgr.GetUICamera()
    local mainCamera = UIRootMgr.GetMainCamera()
    local rectTrans = self.intentionRoot.parent:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local screenPos = mainCamera:WorldToScreenPoint(manualRootIntention.position)
    screenPos = Vector2(screenPos.x, screenPos.y)
    local _, worldPos = RectTransformUtility.ScreenPointToWorldPointInRectangle(rectTrans, screenPos, uiCamera)
    self.intentionRoot.position = worldPos
  end
  self:RefreshBodyPos()
end

function PVPBattleRoleRootUINode:OnBindBase(binder)
  binder:BindToRaw(function(childBinder, isDead, _)
  end, function()
    return self.battleRole.dead.value
  end)
end

function PVPBattleRoleRootUINode:SetActive(isActive)
  if self.bloodUI.ui then
    self.binder:SetCanvasGroup(self.bloodUI.ui.uiNode, isActive and 1 or 0)
  end
  if self.intentionUI and self.intentionUI.ui then
    self.binder:SetCanvasGroup(self.intentionUI.ui.uiNode, isActive and 1 or 0)
  end
end

function PVPBattleRoleRootUINode:SetActiveWithIntention(isActive)
  self:SetBloodActive(isActive)
  self:SetIntentionActive(isActive)
end

function PVPBattleRoleRootUINode:SetBloodActive(isActive)
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
end

function PVPBattleRoleRootUINode:SetIntentionActive(isActive)
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
end

function PVPBattleRoleRootUINode:ShowDamageText(floatingTextType, data)
  self.floatTextUI:ShowDamageText(floatingTextType, data)
end

function PVPBattleRoleRootUINode:ShowPvpVoice(pvpVoiceTid, duration)
  self._playingPvpVoiceTid = pvpVoiceTid
  self:_ClearTimer()
  self._timer = TimerManager.Instance:CreateTimer(duration, 0, nil, function()
    if BattleManager.Instance:IsInBattle() then
      self:HidePvpVoice()
      EventMgr.Instance.PvpPlayVoiceEnd:Dispatch()
    end
  end)
  local content = LT.Text(PvpOpeningVoiceCfgUtils.GetCfgField("AwakerVoiceContent", pvpVoiceTid))
  if not self.voiceUI then
    local viewData = {
      rootNode = self.voiceRoot,
      content = content,
      battleRole = self.battleRole
    }
    self.voiceUI = self.binder:BindNewComponent(self.voiceRoot.gameObject, PvpBattleRoleVoiceUI, UI_Pvp_AwakerVoiceResource, viewData)
  else
    self.voiceUI:Show()
    self.voiceUI:SetContent(content)
  end
end

function PVPBattleRoleRootUINode:_ClearTimer()
  if self._timer then
    self.binder:StopTimer(self._timer)
    self._timer = nil
  end
end

function PVPBattleRoleRootUINode:GetPlayingPvpVoiceTid()
  return self._playingPvpVoiceTid
end

function PVPBattleRoleRootUINode:HidePvpVoice()
  self._playingPvpVoiceTid = nil
  if self.voiceUI and self.voiceUI.ui then
    self.voiceUI:Hide()
  end
end

function PVPBattleRoleRootUINode:OnExSkillAnimStart()
  if bg.isPVP and self.battleRole.dead.value then
    self.uiRoot:SetActive(false)
  end
end

function PVPBattleRoleRootUINode:OnExSkillAnimEnd()
  if bg.isPVP and self.battleRole.dead.value then
    self.uiRoot:SetActive(true)
  end
end

return PVPBattleRoleRootUINode
