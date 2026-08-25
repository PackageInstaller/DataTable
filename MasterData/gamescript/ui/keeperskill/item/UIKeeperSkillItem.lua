local UIKeeperSkillItem, Super = System.NewComponent("UIKeeperSkillItem")

function UIKeeperSkillItem:ctor(go, skillId, selectedSkillId, usedSkillId, fightedStageGroupId, isBanTid)
  Super.ctor(self)
  self.ui = UI_Keeper_Skill_ItemResource(go)
  self.skillId = skillId
  self.selectedSkillId = Vue.ref(selectedSkillId)
  self.usedSkillId = Vue.ref(usedSkillId)
  self.fightedStageGroupId = fightedStageGroupId
  self.isBanTid = isBanTid
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
end

function UIKeeperSkillItem:OnBind(binder)
  self.binder = binder
  self.binder:BindToVisible(self.ui.Btn_Current, function()
    if self.fightedStageGroupId or self.isBanTid then
      return false
    end
    return self.skillId == KeeperSkillUtils.GetItemIdBySkill(self.usedSkillId.value)
  end)
  self.binder:BindToVisible(self.ui.Btn_TickBg, function()
    return self.fightedStageGroupId or self:_CheckIsPvpOnly() or self.isBanTid
  end)
  self.binder:BindToVisible(self.ui.Image_Icon_Untie, function()
    return not self.fightedStageGroupId
  end)
  self.binder:BindToVisible(self.ui.Image_Icon_Ban, function()
    return self.fightedStageGroupId
  end)
  self.binder:BindToVisible(self.ui.Image_NotObtained, System.fn(self, self.IsNotObtained))
  self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  self.binder:BindToImage(self.ui.Image_Icon_Untie, System.fn(self, self.GetSkillIcon))
  self.binder:BindToImage(self.ui.Image_Icon_Ban, System.fn(self, self.GetSkillIcon))
  self.binder:BindToText(self.ui.Text_Creation_Creation, System.fn(self, self.GetSkillCost))
  self.binder:BindToTextColor(self.ui.Text_Creation_Creation, System.fn(self, self.GetTextColorType))
  self.binder:BindToVisible(self.ui.Btn_Selected, function()
    do return self.IsSelected end
    return self.IsSelected, self
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Dot, CommonDefine.RedDotType.TextNew, function()
    local itemId = KeeperSkillUtils.GetItemIdBySkill(self.skillId)
    do return RedPointDataUtils.GetKeeperRedPoint end
    return RedPointDataUtils.GetKeeperRedPoint, itemId
  end))
end

function UIKeeperSkillItem:SetAsLastSibling()
  self.ui.uiNode.transform:SetAsLastSibling()
end

function UIKeeperSkillItem:IsSelected()
  local isSelected = self.selectedSkillId.value == self.skillId
  return isSelected
end

function UIKeeperSkillItem:OnClick()
  if self.isBanTid then
    local tipsKey = 10757
    local desc = LT.Textf(DT.TipsType[tipsKey].Desc, ItemCfgUtils.GetCfgField("Name", self.skillId))
    Alert.ShowStr(desc)
    return
  end
  if self:_CheckIsPvpOnly() then
    Alert.ShowStr(LT.Text("PvpOnlyKeeperSkillClickTips"))
    return
  end
  EventMgr.Instance.UIKeeperSkillClick:Dispatch(self.skillId)
  if self.fightedStageGroupId then
    local skillName = LT.Text(self:GetSkillName())
    local stageGroupName = LT.Text(DT.StageGroup[self.fightedStageGroupId].Name)
    local desc = DT.TipsType[10739].Desc
    Alert.ShowStr(LT.Textf(desc, skillName, stageGroupName))
    return
  end
  self.selectedSkillId.value = self.skillId
  local itemId = KeeperSkillUtils.GetItemIdBySkill(self.skillId)
  local uidMap = ItemDataUtils.GetItemUidMap(itemId)
  for uid, _ in pairs(uidMap or {}) do
    RedPointDataUtils.ReqRemoveItemNew(uid)
  end
  self:SetAsLastSibling()
end

function UIKeeperSkillItem:GetSkillIcon()
  do return KeeperSkillUtils.GetSkillIcon end
  return KeeperSkillUtils.GetSkillIcon, self.skillId
end

function UIKeeperSkillItem:GetSkillName()
  do return KeeperSkillUtils.GetSkillName end
  return KeeperSkillUtils.GetSkillName, self.skillId
end

function UIKeeperSkillItem:GetTextColorType()
  return self.fightedStageGroupId and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
end

function UIKeeperSkillItem:GetSkillCost()
  do return LT.Textf, "KeeperSkillEnergy", KeeperSkillUtils.GetCost() end
  return LT.Textf, "KeeperSkillEnergy", KeeperSkillUtils.GetCost()
end

function UIKeeperSkillItem:IsSkillObtained()
  do return KeeperSkillUtils.IsUnlocked end
  return KeeperSkillUtils.IsUnlocked, self.skillId
end

function UIKeeperSkillItem:IsNotObtained()
  return not self:IsSkillObtained()
end

function UIKeeperSkillItem:_CheckIsPvpOnly()
  local skillItemTid = KeeperSkillUtils.GetItemIdBySkill(self.skillId)
  do return KeeperSkillUtils.CheckSkillItemIsPvpOnly end
  return KeeperSkillUtils.CheckSkillItemIsPvpOnly, skillItemTid
end

return UIKeeperSkillItem
