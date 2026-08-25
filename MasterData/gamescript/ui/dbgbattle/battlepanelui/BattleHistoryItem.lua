local CS = _ENV.CS
local Vector3 = CS.UnityEngine.Vector3
local DragGesture = CS.Z1Client.General.DragGesture
local RectTransform = CS.UnityEngine.RectTransform
local ORI_Y_POS = -34.16
local BattleHistoryItem, Super = System.NewComponent("BattleHistoryItem")

function BattleHistoryItem:ctor(uiNode, data, cardRecordComp)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_AvatarResource(uiNode)
  self.data = Vue.ref(data)
  self.cardRecordComp = cardRecordComp
  self.isOpenedCardDetail = false
end

function BattleHistoryItem:OnBind(binder)
  self.binder = binder
  binder:BindToImageSync(self.ui.Image_Icon, function()
    do return self.GetRoleIcon end
    return self.GetRoleIcon, self
  end)
  binder:BindToVisible(self.ui.Image_Enemy, function()
    do return self.IsEnemy end
    return self.IsEnemy, self
  end)
  binder:BindToVisible(self.ui.Image_Our, function()
    return not self:IsEnemy()
  end)
  binder:BindToRaw(function()
    if self.cardClient then
      self.cardClient:Dispose()
      self.cardClient = nil
    end
    self:ChangeKeerperSkillSize()
  end, function()
    return self.data.value
  end)
  self:InitDrag()
  EventMgr.Instance.BattleAwakerExSkillStart:RegisterEvent(System.fn(self, self.OnAwakerExSkillStart))
  EventMgr.Instance.BattleAwakerExSkillEnd:RegisterEvent(System.fn(self, self.OnAwakerExSkillEnd))
end

function BattleHistoryItem:OnUnbind()
  Super.OnUnbind(self)
  self:RemoveDrag()
  EventMgr.Instance.BattleAwakerExSkillStart:RemoveEvent(System.fn(self, self.OnAwakerExSkillStart))
  EventMgr.Instance.BattleAwakerExSkillEnd:RemoveEvent(System.fn(self, self.OnAwakerExSkillEnd))
  if self.cardClient then
    self.cardClient:Dispose()
  end
end

function BattleHistoryItem:InitDrag()
  local gesture = self.ui.Image_Icon:GetComponent(typeof(DragGesture))
  self.gesture = gesture
  self.gesture.longPressTime = 0.066
  self.gesture:onPointerEnter("+", System.fn(self, self.OnPointerEnter))
  self.gesture:onPointerExit("+", System.fn(self, self.OnPointerExit))
  self.gesture:onPointerDown("+", System.fn(self, self.OnPointerDown))
  self.gesture:onPointerUp("+", System.fn(self, self.OnPointerUp))
end

function BattleHistoryItem:RemoveDrag()
  self.gesture:onPointerEnter("-", System.fn(self, self.OnPointerEnter))
  self.gesture:OnPointerExit("-", System.fn(self, self.OnPointerExit))
  self.gesture:onPointerDown("-", System.fn(self, self.OnPointerDown))
  self.gesture:onPointerUp("-", System.fn(self, self.OnPointerUp))
end

function BattleHistoryItem:OnPointerEnter()
  if self.data.value.uid then
    if not self.cardClient then
      self.cardClient = BattleCardClient(self.data.value)
    end
    local handDelta = {x = 345, y = 45}
    local shiftPos = Vector3(handDelta.x, 0, 0)
    local cardWorldPos = self.ui.uiNode.transform:TransformPoint(shiftPos)
    local extra = {
      hideMask = true,
      forbidTw = true,
      targetPosY = handDelta.y
    }
    AudioManager.Instance:PostSoundEvent("Play_UI_Portrait_PVP_Btn_Open")
    self.isOpenedCardDetail = true
    UIManager.Instance:Reopen(Urls.PVPCardRecordInfoPanel, self.cardClient, cardWorldPos, extra)
    self.cardRecordComp:SetIsInspectCard(true)
  end
end

function BattleHistoryItem:OnPointerExit()
  if self.isInAwakerExSkill then
    return
  end
  if self.isOpenedCardDetail then
    UIManager.Instance:CloseByUrl(Urls.PVPCardRecordInfoPanel)
    self.cardRecordComp:SetIsInspectCard(false)
  end
  self.isOpenedCardDetail = nil
end

function BattleHistoryItem:OnPointerDown()
  self:OnPointerEnter()
end

function BattleHistoryItem:OnPointerUp()
  self:OnPointerExit()
end

function BattleHistoryItem:OnAwakerExSkillStart()
  self.isInAwakerExSkill = true
end

function BattleHistoryItem:OnAwakerExSkillEnd()
  self.isInAwakerExSkill = false
end

function BattleHistoryItem:GetRoleIcon()
  if self.data.value.configId then
    local ownerUid = self.data.value.ownerUid
    local owner = bg.battleDataCenter:GetAwakerDataModel(ownerUid)
    local skillCfg = DT.Skill[self.data.value.configId] or {}
    local awakerId = skillCfg.AwakerID
    if owner.tid ~= awakerId then
      local awakerCfg = DT.AwakerConfig[owner.tid]
      if awakerCfg and awakerCfg.PVPCardIcon then
        do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon end
        return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon, ownerUid
      end
    end
  end
  local skillId = self.data.value.skillId or self.data.value.configId
  if skillId then
    local skillCfg = bg.DT.Skill[skillId]
    if skillCfg then
      if table.contains(skillCfg.Type, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(skillCfg.ID) then
        return skillCfg.UnknownIcon
      end
      do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, skillCfg.Icon end
      return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, skillCfg.Icon, self.data.value.ownerUid, bg.battleDataCenter, awakerCfg.PVPCardIcon, ownerUid
    end
  end
  local roleData = bg.battleDataCenter:GetRoleDataModel(self.data.value.roleUid)
  if roleData and roleData.tid then
    local littleIcon = AwakerDataUtils.GetLittleIcon(roleData.tid)
    do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, littleIcon end
    return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, littleIcon, self.data.value.ownerUid, awakerCfg.PVPCardIcon, ownerUid
  end
end

function BattleHistoryItem:IsEnemy()
  local roleData = bg.battleDataCenter:GetRoleDataModel(self.data.value.roleUid or self.data.value.ownerUid)
  return roleData.camp ~= bg.battleDataCenter:GetMyCamp()
end

function BattleHistoryItem:ChangeKeerperSkillSize()
  local rectTrans = self.ui.Image_Icon:GetComponent(typeof(RectTransform))
  if not self.data.value then
    rectTrans.localPosition = CS.UnityEngine.Vector3(rectTrans.localPosition.x, ORI_Y_POS, rectTrans.localPosition.z)
    rectTrans.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    return
  end
  rectTrans.localPosition = CS.UnityEngine.Vector3(rectTrans.localPosition.x, ORI_Y_POS, rectTrans.localPosition.z)
  rectTrans.localScale = CS.UnityEngine.Vector3(1, 1, 1)
end

return BattleHistoryItem
