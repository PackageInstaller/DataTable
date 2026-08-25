local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local VerticalLayoutGroup = CS.UnityEngine.UI.VerticalLayoutGroup
local TutorialTabType = CommonDefine.TutorialTabType
local typeof = _ENV.typeof
local TutorialMainView, Super = NewClass("TutorialMainView", BaseView)
TutorialMainView.uiResCls = UI_Course_Panel_MainResource

function TutorialMainView:ctor(tidGroup)
  Super.ctor(self)
  self._tidGroup = tidGroup
  self._showRewardGroup = {}
  self._flushRewardAfterBagUpdate = false
  self._tabGroup = {}
  self._itemTableView = nil
  self._cellTemplate = nil
  self._scrollContent = nil
  self._tmpTextMat = nil
end

function TutorialMainView:OnBuildView()
  self._cellTemplate = UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Toturial_Item)
  self:_BuildItemTableView()
  self:_BuildTabGroup()
end

function TutorialMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTutorialMainDataChanged, self._OnDataChanged, self)
end

function TutorialMainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Search, System.fn(self, self._OnClickSearch))
  self:AddButtonClickListener(self.ui.Btn_Onekey, System.fn(self, self._OnClickOneKey))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Up, System.fn(self, self._OnClickPrevPage))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Down, System.fn(self, self._OnClickNextPage))
  self:AddInputValueChangeListener(self.ui.InputField_Course, System.fn(self, self._OnSearchInputChanged))
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self._OnUpdateBagEvent))
end

function TutorialMainView:OnEnterView()
  Super.OnEnterView(self)
  TutorialMainModel.Instance:SetJumpTidGroup(self._tidGroup)
  self:_InitBevelKeyword()
  self:_InitUI()
  self:_RefreshAll()
end

function TutorialMainView:OnExitView()
  if self._tmpTextMat then
    self._tmpTextMat:DisableKeyword("BEVEL_ON")
    self._tmpTextMat = nil
  end
  if TaskModel.Instance:GetCurTaskPage() == cd.TaskPage.Tutorial then
    self:ReqTutorialFinishReadCb()
  end
  UIUtils.DestroyRuntimeTableComponent(self.ui.ScrollView_Toturial_Item)
  self._itemTableView = nil
  Super.OnExitView(self)
end

function TutorialMainView:RefreshOnRendered()
  self:OnEnterUI()
end

function TutorialMainView:Close()
  self:OnEnterUI()
  Super.Close(self)
end

function TutorialMainView:ReqTutorialFinishReadCb()
  local curTid = TutorialMainModel.Instance:GetCurSelectTutorialItemTid()
  if 1 == TutorialDataUtils.GetTutorialMaxPageByTid(curTid) then
    TutorialDataUtils.ReqTutorialFinishRead(curTid)
  end
  self._flushRewardAfterBagUpdate = false
  self:_FlushPendingRewards()
end

function TutorialMainView:_FlushPendingRewards()
  if not self._showRewardGroup or 0 == #self._showRewardGroup then
    return
  end
  ItemDataUtils.ShowItemGain(self._showRewardGroup, nil, "TutorialReward")
  self._showRewardGroup = {}
end

function TutorialMainView:_InitBevelKeyword()
  local tmpText = self.ui.Text_Info:GetComponent(TYPEOF_TMP_Text)
  if tmpText then
    self._tmpTextMat = tmpText.fontMaterial
  end
  if self._tmpTextMat then
    self._tmpTextMat:EnableKeyword("BEVEL_ON")
  end
end

function TutorialMainView:_BuildItemTableView()
  if IsNil(self._cellTemplate) then
    Logger.Error("TutorialMainView missing CircularScrollView itemGameObject")
    return
  end
  local cellRT = self._cellTemplate:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local width = cellRT and cellRT.sizeDelta.x or 560
  local height = cellRT and cellRT.sizeDelta.y or 120
  self._itemTableView = self:CreateTableview(self.ui.ScrollView_Toturial_Item, function()
    return #TutorialMainModel.Instance:GetCurShowItemGroup()
  end, function(view, index)
    do return self._OnItemCellAtIndex, self, view end
    return self._OnItemCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function TutorialMainView:_OnItemCellAtIndex(view, index)
  local itemGroup = TutorialMainModel.Instance:GetCurShowItemGroup()
  local tutorialData = itemGroup[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self._cellTemplate)
  if tutorialData then
    local tid = tutorialData.tid
    self:AddViewComponentOnce(cell.gameObject, TutorialMainScrollItem, {
      tid = tid,
      clickFunc = function()
        self:_OnSelectTutorialItem(tid)
      end
    })
  end
  return cell
end

function TutorialMainView:_BuildTabGroup()
  self._tabGroup = {}
  local tabGroup = TutorialMainModel.Instance:GetShowTutorialTabGroup()
  for ind, toggleInfo in ipairs(tabGroup) do
    local toggleObj = self.ui["Toggle_" .. ind]
    if toggleObj then
      local toggleUI = UI_Common_Item_Toggle_2Resource(toggleObj)
      self:SetImage(toggleUI.Image_Normal_Icon, "Icon/Course/" .. (toggleInfo[2] or ""))
      self:SetImage(toggleUI.Image_Select_Icon, "Icon/Course/" .. (toggleInfo[3] or ""))
      local tabType = toggleInfo[1]
      table.insert(self._tabGroup, {
        type = tabType,
        ui = toggleObj,
        toggleUI = toggleUI,
        index = ind
      })
      self:AddZ1ToggleValueChangedListener(toggleObj, function(isOn)
        if not isOn then
          return
        end
        if TutorialMainModel.Instance:GetCurSelectTutorialTab() == tabType then
          return
        end
        TutorialMainModel.Instance:SetCurSelectTutorialTab(tabType)
        self:_SyncTabInteractable()
        self:_RefreshAll()
        self:_ScrollToSelectItem(true)
      end)
      self:_BindTabRedDot(toggleUI, tabType)
    end
  end
end

function TutorialMainView:_BindTabRedDot(toggleUI, tabType)
  if not toggleUI or not toggleUI.Com_RedDot then
    return
  end
  self:AddViewComponentOnce(toggleUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    if TutorialMainModel.Instance:HasTabReceiveRed(tabType) then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function TutorialMainView:_InitUI()
  self.ui.Group_ScrollView:GetComponent(typeof(VerticalLayoutGroup)).enabled = true
  self._scrollContent = self.ui.Content:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local model = TutorialMainModel.Instance
  if not self._tidGroup then
    model:SetCurSelectTutorialTab(TutorialTabType.All)
    self:_SyncToggleByTab(TutorialTabType.All)
    self:_ScrollToSelectItem(false)
    return
  end
  if 1 ~= #self._tidGroup then
    table.sort(self._tidGroup, function(a, b)
      local aData = TutorialDataUtils.GetTutorialItemDataByTid(a)
      local bData = TutorialDataUtils.GetTutorialItemDataByTid(b)
      return aData.sortWeight > bData.sortWeight
    end)
  end
  local jumpTid = self._tidGroup[1]
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(jumpTid)
  model:SetCurSelectTutorialTab(tutorialCfg.Type)
  model:SetCurSelectTutorialItemTid(jumpTid)
  self:_SyncToggleByTab(tutorialCfg.Type)
  self:_ScrollToSelectItem(false)
end

function TutorialMainView:_SyncToggleByTab(tabType)
  for _, tabInfo in ipairs(self._tabGroup) do
    if tabInfo.type == tabType then
      self:SetZ1Toggle(tabInfo.ui, true, true)
      break
    end
  end
  self:_SyncTabInteractable()
end

function TutorialMainView:_SyncTabInteractable()
  local curTab = TutorialMainModel.Instance:GetCurSelectTutorialTab()
  for _, tabInfo in ipairs(self._tabGroup) do
    self:SetZ1ToggleInteractable(tabInfo.ui, tabInfo.type ~= curTab)
  end
end

function TutorialMainView:_OnDataChanged()
  self:_RefreshAll()
end

function TutorialMainView:_RefreshAll()
  self:_RefreshTabsVisible()
  self:_RefreshItemList()
  self:_RefreshRightDetail()
  self:_RefreshSearchResult()
  self:_RefreshLabel()
end

function TutorialMainView:_RefreshTabsVisible()
  local model = TutorialMainModel.Instance
  for _, tabInfo in ipairs(self._tabGroup) do
    tabInfo.ui:SetActive(model:GetToggleActiveState(tabInfo.type))
    self:_BindTabRedDot(tabInfo.toggleUI, tabInfo.type)
  end
  self:_SyncTabInteractable()
end

function TutorialMainView:_RefreshItemList()
  if self._itemTableView then
    self._itemTableView:ReloadData()
  end
end

function TutorialMainView:_RefreshRightDetail()
  local model = TutorialMainModel.Instance
  local itemGroup = model:GetCurShowItemGroup()
  local curTid = model:GetCurSelectTutorialItemTid()
  self.ui.Group_Empty:SetActive(0 == #itemGroup)
  self.ui.Group_Right:SetActive(nil ~= curTid and 0 ~= curTid)
  if curTid and 0 ~= curTid then
    local image = model:GetCurShowImage()
    if image and "" ~= image then
      self:SetImage(self.ui.Image_banner, image)
    end
    local desc = model:GetCurShowDesc()
    self:SetText(self.ui.Text_Info, desc)
    StrUtils.SetPreferredHeight(self.ui.Text_Info)
    local maxPage = model:GetMaxPage()
    local curPage = model:GetCurPage()
    self.ui.Group_Cut:SetActive(1 ~= maxPage)
    self:SetText(self.ui.Text_Num1, tostring(curPage))
    self:SetText(self.ui.Text_Num2, tostring(maxPage))
    local minPage = model:GetMinPage()
    self:SetButtonState(self.ui.UI_Common_Btn_Up, curPage == minPage and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.Normal)
    self:SetButtonState(self.ui.UI_Common_Btn_Down, curPage == maxPage and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.Normal)
    self:SetButtonRedPoint(self.ui.UI_Common_Btn_Down, function()
      if TutorialMainModel.Instance:HasItemReceiveRed(curTid) then
        return RedPointDataUtils.RedAttrType.Red
      end
      return false
    end)
  end
end

function TutorialMainView:_RefreshSearchResult()
  local model = TutorialMainModel.Instance
  local inSearching = model:IsInSearchingState()
  self.ui.Group_InputNum:SetActive(inSearching)
  if inSearching then
    self:SetText(self.ui.Text_Result, LT.Textf("TutorialSearchResult", #model:GetCurShowItemGroup()))
  else
    self:SetText(self.ui.Text_Result, "")
  end
end

function TutorialMainView:_RefreshLabel()
  local tab = TutorialMainModel.Instance:GetCurSelectTutorialTab()
  if tab and DT.CommonID[tab] then
    self:SetText(self.ui.Text_Label, LT.Text(DT.CommonID[tab].Desc))
  else
    self:SetText(self.ui.Text_Label, "")
  end
end

function TutorialMainView:_ScrollToSelectItem(playFade)
  if not self._itemTableView then
    return
  end
  local itemGroup = TutorialMainModel.Instance:GetCurShowItemGroup()
  if not itemGroup or 0 == #itemGroup then
    return
  end
  local idx = TutorialMainModel.Instance:GetCurSelectTutorialItemShowIndex()
  if idx < 1 or idx > #itemGroup then
    return
  end
  
  local function jump()
    local offset = self._itemTableView:GetOffsetByIndex(idx - 1)
    self._itemTableView:SetOffset(offset, false)
    if playFade then
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_Toturial_Item)
    end
  end
  
  if self._itemTableView.isReady then
    jump()
  else
    function self._itemTableView.reloadFinishCallback()
      self._itemTableView.reloadFinishCallback = nil
      
      jump()
    end
  end
end

function TutorialMainView:_OnSelectTutorialItem(tid)
  local model = TutorialMainModel.Instance
  if model:GetCurSelectTutorialItemTid() == tid then
    return
  end
  model:SetCurSelectTutorialItemTid(tid)
  if 1 == model:GetMaxPage() then
    TutorialMainController.Instance:ReqTutorialFinishRead(tid)
    return
  end
  self:_RefreshAll()
end

function TutorialMainView:_OnClickSearch()
  local model = TutorialMainModel.Instance
  local searchStr = self:GetInputText(self.ui.InputField_Course) or ""
  model:SetInSearchingState("" ~= searchStr)
  model:UpdateCurShowItemGroup()
  local firstItem = model:GetCurShowItemGroup()[1]
  model:SetCurSelectTutorialItemTid(firstItem and firstItem.tid or 0)
  self:_RefreshAll()
  self:_ScrollToSelectItem(false)
end

function TutorialMainView:_OnClickOneKey()
  if TutorialDataUtils.CheckTutorialHaveState(CommonDefine.TutorialItemState.Receive) then
    Alert.Show(20113, nil, function()
      self._flushRewardAfterBagUpdate = true
      TutorialMainController.Instance:ReqTutorialFinishAllRead()
    end)
  else
    Alert.Show(10738)
  end
end

function TutorialMainView:_OnSearchInputChanged()
  local searchStr = self:GetInputText(self.ui.InputField_Course) or ""
  TutorialMainModel.Instance:SetSearchKeyStr(searchStr)
end

function TutorialMainView:_OnClickPrevPage()
  local model = TutorialMainModel.Instance
  model:SetCurPage(model:GetCurPage() - 1)
  self:_RefreshAll()
end

function TutorialMainView:_OnClickNextPage()
  local model = TutorialMainModel.Instance
  local newPage = model:GetCurPage() + 1
  local needFinishRead = model:GetMaxPage() > 1 and newPage == model:GetMaxPage()
  model:SetCurPage(newPage)
  if needFinishRead then
    TutorialMainController.Instance:ReqTutorialFinishRead(model:GetCurSelectTutorialItemTid())
    return
  end
  self:_RefreshAll()
end

function TutorialMainView:_OnUpdateBagEvent(items)
  if not items or type(items) ~= "table" then
    return
  end
  local addedTutorialReward = false
  for _, item in pairs(items) do
    if item.reason == "TutorialRead" then
      self:_AddReward(item)
      addedTutorialReward = true
    end
  end
  if addedTutorialReward and self._flushRewardAfterBagUpdate then
    self._flushRewardAfterBagUpdate = false
    self:_FlushPendingRewards()
  end
end

function TutorialMainView:_AddReward(newItem)
  for idx, reward in pairs(self._showRewardGroup) do
    if reward.uid == newItem.uid then
      self._showRewardGroup[idx].num = self._showRewardGroup[idx].num + newItem.num
      self._showRewardGroup[idx].changedNum = self._showRewardGroup[idx].changedNum + newItem.changedNum
      return
    end
  end
  table.insert(self._showRewardGroup, newItem)
end

return TutorialMainView
