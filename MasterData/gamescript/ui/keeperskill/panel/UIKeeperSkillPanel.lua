local UIKeeperSkillPanel, Super = System.NewClass("UIKeeperSkillPanel", UIBasePanel)
UIKeeperSkillPanel.uiResCls = UI_Keeper_Skill_PanelResource

function UIKeeperSkillPanel:ctor(teamModel)
  Super.ctor(self)
  self.teamModel = teamModel
  local keeperSkillItem = teamModel:GetDisplayKeeperSkillItem()
  local skillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
  self.selectedSkillId = Vue.ref(keeperSkillItem)
  self.usedSkillId = Vue.ref(skillId)
  self.usedSkillItemId = keeperSkillItem
  self.selectedSchool = 1
  self.skillList = self:GetSortedSkillList(self.selectedSchool)
  self.skillItemComps = {}
  if 0 == self.selectedSkillId.value then
    self.selectedSkillId.value = self.skillList[1]
  end
end

function UIKeeperSkillPanel:OnBind(binder)
  self.binder = binder
  self:OnBindSkillTableView()
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self.selectedSchool = 1
    self:Close()
  end))
  binder:BindToRaw(function(_, selectedSkillId)
    self.binder:SetText(self.ui.Text_NowName, ItemDataUtils.GetKeeperSkillName(selectedSkillId))
    local skillItemTid = KeeperSkillUtils.GetItemIdBySkill(self.skillId)
    local desc = ""
    if KeeperSkillUtils.CheckSkillItemIsPvpOnly(skillItemTid) then
      desc = LT.Text("PvpOnlyKeeperSkillClickTips")
    else
      desc = KeeperSkillUtils.GetKeeperSkillDesc(selectedSkillId)
    end
    self.binder:SetText(self.ui.Text_Desc, desc, false, nil, {
      lockParentNode = self.ui.KeyWord_Tip_Pos
    })
    local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc)
    local sizeDelta = self.ui.DescContent.transform.sizeDelta
    local Vector2 = CS.UnityEngine.Vector2(0, 0)
    Vector2.x = sizeDelta.x
    Vector2.y = height
    self.ui.DescContent.transform.sizeDelta = Vector2
  end, function()
    return self.selectedSkillId.value
  end)
  binder:BindToImage(self.ui.Image_Crystal, function()
    do return KeeperSkillUtils.GetDisplayImage end
    return KeeperSkillUtils.GetDisplayImage, self.selectedSkillId.value
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Use, function()
    self:OnComfirm()
  end, function()
    if self.selectedSkillId.value == self.usedSkillItemId then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end, function()
    if self.selectedSkillId.value == self.usedSkillItemId then
      do return LT.Text end
      return LT.Text, "UIKeeperSkillUsed"
    else
      do return LT.Text end
      return LT.Text, "UIKeeperSkillChoose"
    end
  end)
  for toggleId, toggleData in pairs(KeeperSkillDefine.ToggleList) do
    self.binder:BindToZ1Toggle(self.ui[toggleData.uiNode], nil, function(isOn)
      if isOn then
        self:_SetSchool(toggleId)
      end
    end, function()
      return toggleId == self.selectedSchool
    end)
    self.binder:BindComponent(RedDotComponent(UI_Common_Item_Toggle_2Resource(self.ui[toggleData.uiNode]).Com_RedDot, CommonDefine.RedDotType.TextNew, nil, function()
      do return RedPointDataUtils.GetSchoolKeeperRedPoint end
      return RedPointDataUtils.GetSchoolKeeperRedPoint, toggleId
    end))
  end
  self:_SetSchool(self.selectedSchool)
  binder:BindEvent(EventMgr.Instance.UIKeeperSkillClick, function(skillId)
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_KeeperSkillSave", self.ui.UI_Common_Btn_Use, Urls.UIKeeperSkillPanel)
  end)
end

function UIKeeperSkillPanel:_SetSchool(schoolId)
  if self.selectedSchool ~= schoolId then
    self.selectedSchool = schoolId
  end
  self.binder:SetText(self.ui.Text_School, self:_GetClassifyName())
  self.skillList = self:GetSortedSkillList(self.selectedSchool)
  self.keeperSkillView:ReloadData()
  if self.ui.Group_Null_Black then
    self.binder:SetActive(self.ui.Group_Null_Black, #self.skillList <= 0)
  end
end

function UIKeeperSkillPanel:_GetClassifyName()
  if not KeeperSkillDefine.ToggleList[self.selectedSchool] or not KeeperSkillDefine.ToggleList[self.selectedSchool].classify then
    do return LT.Text end
    return LT.Text, "UIKeeperSkillChooseAll", nil, nil
  else
    do return LT.Text end
    return LT.Text, DT.CommonID[KeeperSkillDefine.ToggleList[self.selectedSchool].classify].Desc, KeeperSkillDefine.ToggleList[self.selectedSchool].classify, self.selectedSchool
  end
end

function UIKeeperSkillPanel:OnBindSkillTableView()
  self.skillList = self:GetSortedSkillList(self.selectedSchool)
  self.keeperSkillView = self:CreateTableview(self.ui.ScrollView_Skill, function()
    if not self.skillList then
      return 0
    end
    return #self.skillList
  end, function(view, index)
    do return self.KeeperSkillCellAtIndex, self, view end
    return self.KeeperSkillCellAtIndex, self, view, index
  end)
  self.keeperSkillView:ReloadData()
  
  function self.keeperSkillView.reloadFinishCallback()
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Skill)
  end
end

function UIKeeperSkillPanel:KeeperSkillCellAtIndex(view, index)
  local cell = self:DequeueCell(view, self.ui.UI_Keeper_Skill_Item)
  local oldComp = self.skillItemComps[cell.gameObject]
  if oldComp and oldComp.binder then
    oldComp.binder:teardown()
  end
  local skillId = self.skillList[index]
  local comp = self.binder:BindComponent(UIKeeperSkillItem(cell.gameObject, skillId, self.selectedSkillId, self.usedSkillId, self.fightedItemMap[skillId], self.teamModel:IsBanTid(skillId)))
  self.skillItemComps[cell.gameObject] = comp
  return cell
end

function UIKeeperSkillPanel:GetSortedSkillList(schoolId)
  print("keyset get skill list", schoolId, KeeperSkillDefine.ToggleList[schoolId].classify)
  local skillTidList = KeeperSkillUtils.GetSortedSkillList(self.usedSkillId.value)
  local pvpOnlySkillTidList = KeeperSkillUtils.GetPvpOnlySkillTidList()
  for _, pvpOnlySkillTid in ipairs(pvpOnlySkillTidList) do
    table.insert(skillTidList, pvpOnlySkillTid)
  end
  for i = #skillTidList, 1, -1 do
    local itemId = KeeperSkillUtils.GetItemIdBySkill(skillTidList[i])
    if 0 == ItemDataUtils.GetItemNum(itemId) or KeeperSkillDefine.ToggleList[schoolId].classify and (not DT.Item[itemId].ClassificationParam or DT.Item[itemId].ClassificationParam and DT.Item[itemId].ClassificationParam[1] ~= KeeperSkillDefine.ToggleList[schoolId].classify) then
      table.remove(skillTidList, i)
    end
  end
  self.fightedItemMap = {}
  local canChooseSkiilItemList = {}
  local canNotChooseSkiilItemList = {}
  local fightedTeamDatas = self.teamModel:GetFightedStageGroupData()
  for i = 1, #skillTidList do
    local itemId = KeeperSkillUtils.GetItemIdBySkill(skillTidList[i])
    local canChoose = true
    for _, fightedTeamData in pairs(fightedTeamDatas) do
      if fightedTeamData.keeperSkillId == itemId then
        self.fightedItemMap[itemId] = fightedTeamData.stageGroupId
        canChoose = false
        break
      end
    end
    if self.teamModel:IsBanTid(itemId) then
      canChoose = false
    end
    if canChoose then
      table.insert(canChooseSkiilItemList, itemId)
    else
      table.insert(canNotChooseSkiilItemList, itemId)
    end
  end
  local rst = canChooseSkiilItemList
  for _, canNotChoooseTid in ipairs(canNotChooseSkiilItemList) do
    table.insert(rst, canNotChoooseTid)
  end
  return rst
end

function UIKeeperSkillPanel:OnComfirm()
  if self.selectedSkillId.value == self.usedSkillId.value then
    Alert.Show(10644)
    return
  end
  if not self:GetIsUnlocked(self.selectedSkillId.value) then
    Alert.Show(10645)
    return
  end
  self.usedSkillId.value = self.selectedSkillId.value
  local keeperSkillItem = KeeperSkillUtils.GetItemIdBySkill(self.usedSkillId.value)
  self.teamModel:ReqSetKeeperSkill(keeperSkillItem)
  Alert.ShowStr(LT.Textf("KeeperSkillEquipPrompt", KeeperSkillUtils.GetSkillName(self.usedSkillId.value)))
  NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EquipWeaponClose", self.ui.UI_Common_Btn_Use, Urls.UIKeeperSkillPanel)
  self:Close()
end

function UIKeeperSkillPanel:GetIsUnlocked(skillId)
  do return KeeperSkillUtils.IsUnlocked end
  return KeeperSkillUtils.IsUnlocked, skillId
end

function UIKeeperSkillPanel:OnUnbind()
  self.keeperSkillView.reloadFinishCallback = nil
end

return UIKeeperSkillPanel
