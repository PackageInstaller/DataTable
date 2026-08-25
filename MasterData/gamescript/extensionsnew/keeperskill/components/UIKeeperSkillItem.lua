local UIKeeperSkillItem, Super = NewViewComponent("UIKeeperSkillItem")

function UIKeeperSkillItem:ctor(uiNode, view, skillId, fightedStageGroupId, isBanTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Keeper_Skill_ItemResource(uiNode)
  self._skillId = skillId
  self._fightedStageGroupId = fightedStageGroupId
  self._isBanTid = isBanTid
  self._uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self._model = KeeperSkillModel.Instance
end

function UIKeeperSkillItem:OnEnterComponent()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
  self:_RefreshRedDot()
  self:_RefreshOnUsedSkillIdChanged()
  self:_RefreshOnSelectedSkillIdChanged()
end

function UIKeeperSkillItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnKeeperSkillUsedSkillIdChanged, self._RefreshOnUsedSkillIdChanged, self)
  self:RegisterLocalNotify(NotifyId.OnKeeperSkillSelectedSkillIdChanged, self._RefreshOnSelectedSkillIdChanged, self)
end

function UIKeeperSkillItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function UIKeeperSkillItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UIKeeperSkillItem:_RefreshText()
  local skillCost = LT.Textf("KeeperSkillEnergy", KeeperSkillUtils.GetCost())
  self:SetText(self.ui.Text_Creation_Creation, skillCost)
  local textColorType = self._fightedStageGroupId and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self:SetTextColorType(self.ui.Text_Creation_Creation, textColorType)
end

function UIKeeperSkillItem:_RefreshImage()
  local skillIcon = KeeperSkillUtils.GetSkillIcon(self._skillId)
  self:SetImage(self.ui.Image_Icon_Untie, skillIcon)
  self:SetImage(self.ui.Image_Icon_Ban, skillIcon)
end

function UIKeeperSkillItem:_RefreshVisible()
  local isTickBgActive = self._fightedStageGroupId or self:_CheckIsPvpOnly() or self._isBanTid
  self:SetActive(self.ui.Btn_TickBg, isTickBgActive)
  self:SetActive(self.ui.Image_Icon_Untie, not self._fightedStageGroupId)
  self:SetActive(self.ui.Image_Icon_Ban, self._fightedStageGroupId)
  local isObtained = self:_IsSkillObtained()
  self:SetActive(self.ui.Image_NotObtained, not isObtained)
end

function UIKeeperSkillItem:_RefreshOnUsedSkillIdChanged()
  local isSelected = self:_IsSelected()
  self:SetActive(self.ui.Btn_Current, isSelected)
end

function UIKeeperSkillItem:_RefreshOnSelectedSkillIdChanged()
  local isSelected = self._model:GetSelectedSkillId() == self._skillId
  self:SetActive(self.ui.Btn_Selected, isSelected)
end

function UIKeeperSkillItem:_RefreshRedDot()
  self:AddViewComponentOnce(self.ui.Red_Dot, UICompRedDot, CommonDefine.RedDotType.TextNew, function()
    local itemId = KeeperSkillUtils.GetItemIdBySkill(self._skillId)
    do return RedPointDataUtils.GetKeeperRedPoint end
    return RedPointDataUtils.GetKeeperRedPoint, itemId
  end)
end

function UIKeeperSkillItem:_OnClick()
  if self._isBanTid then
    local tipsKey = 10757
    local desc = LT.Textf(DT.TipsType[tipsKey].Desc, ItemCfgUtils.GetCfgField("Name", self._skillId))
    Alert.ShowStr(desc)
    return
  end
  if self:_CheckIsPvpOnly() then
    Alert.ShowStr(LT.Text("PvpOnlyKeeperSkillClickTips"))
    return
  end
  EventMgr.Instance.UIKeeperSkillClick:Dispatch(self._skillId)
  if self._fightedStageGroupId then
    local skillName = LT.Text(KeeperSkillUtils.GetSkillName(self._skillId))
    local stageGroupName = LT.Text(DT.StageGroup[self._fightedStageGroupId].Name)
    local desc = DT.TipsType[10739].Desc
    Alert.ShowStr(LT.Textf(desc, skillName, stageGroupName))
    return
  end
  self._model:SetSelectedSkillId(self._skillId)
  local itemId = KeeperSkillUtils.GetItemIdBySkill(self._skillId)
  local uidMap = ItemDataUtils.GetItemUidMap(itemId)
  for uid, _ in pairs(uidMap or {}) do
    RedPointDataUtils.ReqRemoveItemNew(uid)
  end
  self.ui.uiNode.transform:SetAsLastSibling()
end

function UIKeeperSkillItem:_IsSelected()
  if self._fightedStageGroupId or self._isBanTid then
    return false
  end
  local usedSkillId = self._model:GetUsedSkillId()
  return self._skillId == KeeperSkillUtils.GetItemIdBySkill(usedSkillId)
end

function UIKeeperSkillItem:_IsSkillObtained()
  do return KeeperSkillUtils.IsUnlocked end
  return KeeperSkillUtils.IsUnlocked, self._skillId
end

function UIKeeperSkillItem:_CheckIsPvpOnly()
  local skillItemTid = KeeperSkillUtils.GetItemIdBySkill(self._skillId)
  do return KeeperSkillUtils.CheckSkillItemIsPvpOnly end
  return KeeperSkillUtils.CheckSkillItemIsPvpOnly, skillItemTid
end

return UIKeeperSkillItem
