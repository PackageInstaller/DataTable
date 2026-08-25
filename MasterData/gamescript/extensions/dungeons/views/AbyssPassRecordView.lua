local AbyssPassRecordView, Super = NewClass("AbyssPassRecordView", BaseView)
AbyssPassRecordView.uiResCls = UI_Dungeous_Popup_Team_Tip_OptimizedResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_UIAnimationController = CS.Z1Client.UIAnimationController

function AbyssPassRecordView:ctor(targetStageGroupTid)
  Super.ctor(self)
  self.model = AbyssExtModel.Instance
  self.controller = AbyssController.Instance
  self.selectStageGroupTid = targetStageGroupTid
end

function AbyssPassRecordView:OnBuildView()
end

function AbyssPassRecordView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(TYPEOF_UIAnimationController))
  self:_RefreshView(true)
end

function AbyssPassRecordView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Skill, System.fn(self, self._OnClickKeeperSkill))
  self:AddButtonClickListener(self.ui.Btn_Reset, System.fn(self, self._OnClickReset))
  self:_CreateTabTableView()
end

function AbyssPassRecordView:RegisterNotifications()
end

function AbyssPassRecordView:_RefreshView(isReloadData)
  self:_RefreshTabs(isReloadData)
  self:_RefreshRecordInfo()
end

function AbyssPassRecordView:_RefreshRecordInfo()
  self:_RefreshAwakers()
  local passed = self.model:HasStageGroupPassed(self.selectStageGroupTid)
  self.ui.Group_Null_Black:SetActive(not passed)
  self.ui.Image_Team:SetActive(passed)
  self.ui.Image_Difficulty:SetActive(passed)
  self.ui.Btn_Reset:SetActive(passed)
  self.ui.Btn_Skill:SetActive(passed)
  if not passed then
    return
  end
  local teamData = self.model:GetTeamData(self.selectStageGroupTid)
  if not teamData then
    return
  end
  self:SetText(self.ui.Text_Difficulty, self.model:GetPassText(self.selectStageGroupTid))
  if teamData.keeperSkill then
    self:SetText(self.ui.Text_Introduce, KeeperSkillUtils.GetSkillName(teamData.keeperSkill))
    self:SetImage(self.ui.Keeper_Skill_Icon, KeeperSkillUtils.GetSkillIcon(teamData.keeperSkill))
  end
  if self.uiAnimationController then
    self.uiAnimationController:PlayMultiState("UI_Dungeous_Popup_Team_Tip_Change", nil, 1)
  end
end

function AbyssPassRecordView:_RefreshAwakers()
  local teamData = self.model:GetTeamData(self.selectStageGroupTid)
  for i = 1, 4 do
    local obj = self.ui["UI_Team_Item_Awaker_List_" .. i]
    local awakerData = teamData.awakers[i]
    local items = {}
    if awakerData then
      if awakerData.weaponSlots then
        for _, weaponSlotData in pairs(awakerData.weaponSlots) do
          if weaponSlotData and weaponSlotData.weaponUid then
            items[weaponSlotData.weaponUid] = teamData.items[weaponSlotData.weaponUid]
          end
        end
      end
      if awakerData.trinkets then
        for _, trinketUid in pairs(awakerData.trinkets) do
          if trinketUid then
            items[trinketUid] = teamData.items[trinketUid]
          end
        end
      end
      local recordItemData = {
        awakerData = awakerData or {},
        items = items
      }
      self:AddViewComponentOnce(obj, UICompAbyssAwakerRecordItem, recordItemData, System.bind(self._OnClickAwaker, self, self.selectStageGroupTid))
    end
  end
end

function AbyssPassRecordView:_CreateTabTableView()
  local cellRT = self.ui.UI_Dungeons_Popup_List_Tip_Item_Btn:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.tabTableView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.tabList then
      return 0
    end
    return #self.tabList
  end, function(view, index)
    do return self._TabCellAtIndex, self, view end
    return self._TabCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function AbyssPassRecordView:_TabCellAtIndex(view, index)
  local tabData = self.tabList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Popup_List_Tip_Item_Btn)
  local ui = UI_Dungeons_Popup_List_Tip_Item_BtnResource(cell.gameObject)
  
  local function _OnClickTab()
    self.selectStageGroupTid = tabData.tid
    self:_RefreshView(false)
  end
  
  self:SetText(ui.Text_Function, tabData.name)
  self:AddButtonClickListener(ui.Group_Btn, _OnClickTab)
  self:SetButtonChosen(ui.Group_Btn, self.selectStageGroupTid == tabData.tid)
  return cell
end

function AbyssPassRecordView:_RefreshTabs(isReloadData)
  if isReloadData then
    local stageGroupTids = self.model:GetStageGroupTidList()
    self.tabList = {}
    for _, stageGroupTid in ipairs(stageGroupTids) do
      local name = CopyDataUtils.GetStageGroupName(stageGroupTid)
      table.insert(self.tabList, {tid = stageGroupTid, name = name})
    end
  end
  self.tabTableView:ReloadData()
end

function AbyssPassRecordView:_OnResetStageGroup()
  self:_RefreshRecordInfo()
end

function AbyssPassRecordView:_OnClickKeeperSkill()
  if not self.model:HasStageGroupPassed(self.selectStageGroupTid) then
    return
  end
  local teamData = self.model:GetTeamData(self.selectStageGroupTid)
  local keeperSkillItemTid = teamData and teamData.keeperSkill
  if not keeperSkillItemTid then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Skill, nil, keeperSkillItemTid)
end

function AbyssPassRecordView:_OnClickAwaker(stageGroupTid)
  if not stageGroupTid then
    return
  end
  
  local function _OnOpenAwakerPanel()
    local teamData = table.clone(self.model:GetTeamData(stageGroupTid))
    local previewData = {
      items = teamData.items,
      awakers = teamData.awakers,
      hideAwakerChangeForm = true
    }
    local awakerBasePanelData = {
      jumpPage = CommonDefine.AwakerPage.Detail,
      previewAwakersData = previewData
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  self.controller:ReqAbyssTeamDetail(stageGroupTid, false, _OnOpenAwakerPanel)
end

function AbyssPassRecordView:_OnClickReset()
  local stageGroupTid = self.selectStageGroupTid
  if not self.model:HasStageGroupPassed(stageGroupTid) then
    return
  end
  local stageTid = self.model:GetPassedStageTid(stageGroupTid)
  local config = CopyDataUtils.GetStageConfig(stageTid)
  if not config then
    return
  end
  
  local function _OnReset()
    self.controller:ReqResetAbyssChallenge(stageGroupTid, function()
      Alert.ShowWithParams(10754, {
        LT.Text(config.Name)
      })
    end)
  end
  
  Alert.Show(20124, nil, _OnReset)
end

function AbyssPassRecordView:OnExitView()
  Super.OnExitView(self)
end

return AbyssPassRecordView
