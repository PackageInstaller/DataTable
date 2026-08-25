local UIKeeperSkillDisplayPanel, Super = System.NewClass("UIKeeperSkillDisplayPanel", UIBasePanel)
UIKeeperSkillDisplayPanel.uiResCls = UI_Keeper_Skill_PanelResource

function UIKeeperSkillDisplayPanel:ctor(keeperSkillItemTid)
  Super.ctor(self)
  local skillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItemTid)
  self.usedSkillId = Vue.ref(skillId or 0)
  self.selectedSkillId = Vue.ref(skillId or 0)
end

function UIKeeperSkillDisplayPanel:OnBind(binder)
  self.binder = binder
  self.skillItemComps = {}
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindToText(self.ui.Text_NowName, function()
    do return KeeperSkillUtils.GetSkillName end
    return KeeperSkillUtils.GetSkillName, self.selectedSkillId.value
  end)
  binder:BindToImage(self.ui.Image_Crystal, function()
    do return KeeperSkillUtils.GetDisplayImage end
    return KeeperSkillUtils.GetDisplayImage, self.selectedSkillId.value
  end)
  self.binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.Close))
  binder:SetActive(self.ui.UI_Common_Btn_Use, false)
  self.keeperSkillView = self:CreateTableview(self.ui.ScrollView_Skill, function()
    if not self.skillList then
      return 0
    end
    return #self.skillList
  end, function(view, index)
    do return self.KeeperSkillCellAtIndex, self, view end
    return self.KeeperSkillCellAtIndex, self, view, index
  end, function(view, index)
    do return self.KeeperSkillCellSize, self, view end
    return self.KeeperSkillCellSize, self, view, index
  end)
  self.keeperSkillView:ReloadData()
  
  function self.keeperSkillView.reloadFinishCallback()
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Skill)
  end
end

function UIKeeperSkillDisplayPanel:KeeperSkillCellAtIndex(view, index)
  local cell = self:DequeueCell(view, self.ui.UI_Keeper_Skill_Item)
  local oldComp = self.skillItemComps[cell.gameObject]
  if oldComp and oldComp.binder then
    oldComp.binder:teardown()
  end
  local skillId = self.skillList[index]
  local comp = self.binder:BindComponent(UIKeeperSkillItem(cell.gameObject, skillId, self.selectedSkillId, self.usedSkillId, self.fightedItemMap[skillId], self.ui.KeyWord_Tip_Pos))
  self.skillItemComps[cell.gameObject] = comp
  return cell
end

function UIKeeperSkillDisplayPanel:KeeperSkillCellSize(view, index)
  local skillId = self.skillList[index]
  local desc = KeeperSkillUtils.GetKeeperSkillDesc(skillId)
  self.binder:SetText(self.ui.Text_Info, desc)
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Info) + 132
  local width = 680
  return width, height
end

function UIKeeperSkillDisplayPanel:GetSortedSkillList()
  local itemList = {
    self.usedSkillId.value
  }
  return itemList
end

function UIKeeperSkillDisplayPanel:GetIsUnlocked(skillId)
  do return KeeperSkillUtils.IsUnlocked end
  return KeeperSkillUtils.IsUnlocked, skillId
end

function UIKeeperSkillDisplayPanel:OnUnbind()
  self.keeperSkillView.reloadFinishCallback = nil
  self.skillItemComps = nil
end

return UIKeeperSkillDisplayPanel
