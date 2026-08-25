local KeeperSkillView, Super = System.NewClass("KeeperSkillView", BaseView)
KeeperSkillView.uiResCls = UI_Keeper_Skill_PanelResource

function KeeperSkillView:ctor(teamModel)
  Super.ctor(self)
  self._teamModel = teamModel
  self._model = KeeperSkillModel.Instance
  local keeperSkillItem = teamModel:GetDisplayKeeperSkillItem()
  local skillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
  self._model:SetSelectedSkillId(keeperSkillItem)
  self._model:SetUsedSkillId(skillId)
  self._model:SetSelectedSchool(1)
  self._usedSkillItemId = keeperSkillItem
  local selectedSchool = self._model:GetSelectedSchool()
  self._skillList = self:_GetSortedSkillList(selectedSchool)
  self._skillItemComps = {}
  local selectedSkillId = self._model:GetSelectedSkillId()
  if 0 == selectedSkillId then
    self._model:SetSelectedSkillId(self._skillList[1])
  end
end

function KeeperSkillView:OnBuildView()
  self:_OnInitSkillTableView()
  self:_OnInitSelectToggle()
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    self._model:SetSelectedSchool(1)
    self:Close()
  end)
end

function KeeperSkillView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnKeeperSkillSelectedSkillIdChanged, self._OnSelectedSkillIdChange, self)
  self:BindEvent(EventMgr.Instance.UIKeeperSkillClick, System.fn(self, self._OnKeeperSkillClick))
end

function KeeperSkillView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Use, System.fn(self, self._OnButtonClick))
end

function KeeperSkillView:OnEnterView()
  local selectedSchool = self._model:GetSelectedSchool()
  self:_SetSchool(selectedSchool)
  self:_RefreshSchoolToggles()
  self:_OnSelectedSkillIdChange()
end

function KeeperSkillView:OnExitView()
  self._keeperSkillView.reloadFinishCallback = nil
  Super.OnExitView(self)
end

function KeeperSkillView:_RefreshButton()
  local buttonText = self:_GetButtonText()
  self:SetButtonText(self.ui.UI_Common_Btn_Use, buttonText)
  local buttonState = self:_GetButtonState()
  self:SetButtonState(self.ui.UI_Common_Btn_Use, buttonState)
end

function KeeperSkillView:_OnInitSelectToggle()
  for toggleId, toggleData in pairs(KeeperSkillDefine.ToggleList) do
    local toggleObj = self.ui[toggleData.uiNode]
    local toggleUI = UI_Common_Item_Toggle_2Resource(toggleObj)
    self:AddZ1ToggleValueChangedListener(toggleObj, function(isOn)
      if isOn then
        self:_SetSchool(toggleId)
      end
    end)
    self:AddViewComponentOnce(toggleUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
      do return RedPointDataUtils.GetSchoolKeeperRedPoint end
      return RedPointDataUtils.GetSchoolKeeperRedPoint, toggleId
    end)
  end
end

function KeeperSkillView:_RefreshSchoolToggles()
  local selectedSchool = self._model:GetSelectedSchool()
  for toggleId, toggleData in pairs(KeeperSkillDefine.ToggleList) do
    local isOn = toggleId == selectedSchool
    self:SetZ1Toggle(self.ui[toggleData.uiNode], isOn, true)
  end
end

function KeeperSkillView:_SetSchool(schoolId)
  self._model:SetSelectedSchool(schoolId)
  self:SetText(self.ui.Text_School, self:_GetClassifyName())
  local selectedSchool = self._model:GetSelectedSchool()
  self._skillList = self:_GetSortedSkillList(selectedSchool)
  self._keeperSkillView:ReloadData()
  if self.ui.Group_Null_Black then
    self:SetActive(self.ui.Group_Null_Black, #self._skillList <= 0)
  end
end

function KeeperSkillView:_OnInitSkillTableView()
  local selectedSchool = self._model:GetSelectedSchool()
  self._skillList = self:_GetSortedSkillList(selectedSchool)
  self._keeperSkillView = self:CreateTableview(self.ui.ScrollView_Skill, function()
    if not self._skillList then
      return 0
    end
    return #self._skillList
  end, function(view, index)
    do return self._KeeperSkillCellAtIndex, self, view end
    return self._KeeperSkillCellAtIndex, self, view, index
  end)
  self._keeperSkillView:ReloadData()
  
  function self._keeperSkillView.reloadFinishCallback()
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Skill)
  end
end

function KeeperSkillView:_KeeperSkillCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Keeper_Skill_Item)
  local skillId = self._skillList[index]
  local comp = self._skillItemComps[cell.gameObject]
  comp = self:AddViewComponentOnce(cell.gameObject, UIKeeperSkillItem, skillId, self._fightedItemMap[skillId], self._teamModel:IsBanTid(skillId))
  self._skillItemComps[cell.gameObject] = comp
  return cell
end

function KeeperSkillView:_GetSortedSkillList(schoolId)
  local usedSkillId = self._model:GetUsedSkillId()
  local skillTidList = KeeperSkillUtils.GetSortedSkillList(usedSkillId)
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
  self._fightedItemMap = {}
  local canChooseSkiilItemList = {}
  local canNotChooseSkiilItemList = {}
  local fightedTeamDatas = self._teamModel:GetFightedStageGroupData()
  for i = 1, #skillTidList do
    local itemId = KeeperSkillUtils.GetItemIdBySkill(skillTidList[i])
    local canChoose = true
    for _, fightedTeamData in pairs(fightedTeamDatas) do
      if fightedTeamData.keeperSkillId == itemId then
        self._fightedItemMap[itemId] = fightedTeamData.stageGroupId
        canChoose = false
        break
      end
    end
    if self._teamModel:IsBanTid(itemId) then
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

function KeeperSkillView:_OnSelectedSkillIdChange()
  local selectedSkillId = self._model:GetSelectedSkillId()
  local skillIcon = KeeperSkillUtils.GetDisplayImage(selectedSkillId)
  self:SetImage(self.ui.Image_Crystal, skillIcon)
  self:_RefreshButton()
  self:SetText(self.ui.Text_NowName, ItemDataUtils.GetKeeperSkillName(selectedSkillId))
  local skillItemTid = KeeperSkillUtils.GetItemIdBySkill(selectedSkillId)
  local desc = ""
  if KeeperSkillUtils.CheckSkillItemIsPvpOnly(skillItemTid) then
    desc = LT.Text("PvpOnlyKeeperSkillClickTips")
  else
    desc = KeeperSkillUtils.GetKeeperSkillDesc(selectedSkillId)
  end
  self:SetText(self.ui.Text_Desc, desc, false, nil, {
    lockParentNode = self.ui.KeyWord_Tip_Pos
  })
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc)
  local sizeDelta = self.ui.DescContent.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = height
  self.ui.DescContent.transform.sizeDelta = Vector2
end

function KeeperSkillView:_OnButtonClick()
  local selectedSkillId = KeeperSkillUtils.GetSkillIdByItem(self._model:GetSelectedSkillId())
  local usedSkillId = KeeperSkillUtils.GetSkillIdByItem(self._model:GetUsedSkillId())
  if selectedSkillId == usedSkillId then
    Alert.Show(10644)
    return
  end
  if not self:_GetIsUnlocked(selectedSkillId) then
    Alert.Show(10645)
    return
  end
  self._model:SetUsedSkillId(selectedSkillId)
  usedSkillId = self._model:GetUsedSkillId()
  local keeperSkillItem = KeeperSkillUtils.GetItemIdBySkill(selectedSkillId)
  self._teamModel:ReqSetKeeperSkill(keeperSkillItem)
  Alert.ShowStr(LT.Textf("KeeperSkillEquipPrompt", KeeperSkillUtils.GetSkillName(usedSkillId)))
  NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EquipWeaponClose", self.ui.UI_Common_Btn_Use, Urls.KeeperSkillView)
  self:Close()
end

function KeeperSkillView:_OnKeeperSkillClick()
  NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_KeeperSkillSave", self.ui.UI_Common_Btn_Use, Urls.KeeperSkillView)
end

function KeeperSkillView:_GetButtonState()
  local selectedSkillId = KeeperSkillUtils.GetSkillIdByItem(self._model:GetSelectedSkillId())
  local usedSkillId = KeeperSkillUtils.GetSkillIdByItem(self._usedSkillItemId)
  if selectedSkillId == usedSkillId then
    return CommonDefine.BtnType.Unclickable
  else
    return CommonDefine.BtnType.High
  end
end

function KeeperSkillView:_GetButtonText()
  local selectedSkillId = self._model:GetSelectedSkillId()
  if selectedSkillId == self._usedSkillItemId then
    do return LT.Text end
    return LT.Text, "UIKeeperSkillUsed"
  else
    do return LT.Text end
    return LT.Text, "UIKeeperSkillChoose"
  end
end

function KeeperSkillView:_GetClassifyName()
  local selectedSchool = self._model:GetSelectedSchool()
  if not KeeperSkillDefine.ToggleList[selectedSchool] or not KeeperSkillDefine.ToggleList[selectedSchool].classify then
    do return LT.Text end
    return LT.Text, "UIKeeperSkillChooseAll", nil
  else
    do return LT.Text end
    return LT.Text, DT.CommonID[KeeperSkillDefine.ToggleList[selectedSchool].classify].Desc, KeeperSkillDefine.ToggleList[selectedSchool].classify
  end
end

function KeeperSkillView:_GetIsUnlocked(skillId)
  do return KeeperSkillUtils.IsUnlocked end
  return KeeperSkillUtils.IsUnlocked, skillId
end

return KeeperSkillView
