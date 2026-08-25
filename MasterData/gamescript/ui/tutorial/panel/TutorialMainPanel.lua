local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local VerticalLayoutGroup = CS.UnityEngine.UI.VerticalLayoutGroup
local TutorialTabType = CommonDefine.TutorialTabType
local typeof = _ENV.typeof
local ITEM_PER_HEIGHT = 120
local ONE_PAGE_SHOW_ITEM_NUM = 7
local TutorialMainPanel, Super = System.NewClass("TutorialMainPanel", UIBasePanel)
TutorialMainPanel.uiResCls = UI_Course_Panel_MainResource

function TutorialMainPanel:ctor(tidGroup)
  Super.ctor(self)
  self.tidGroup = tidGroup
  self.showRewardGroup = {}
end

function TutorialMainPanel:OnBind(binder)
  local model = binder:createModel(TutorialMainPanelModel)
  self.model = model
  self.binder = binder
  self:_BindTabGroup(binder, model)
  self:_BindToturialItemScrollView(binder, model)
  self:_BindRightToturialDetailPart(binder, model)
  self:_BindTopLabelCurrencyGroup(binder, model)
  self:_BindReadRewardEvent(binder, model)
  self:_BindInputSearchFilter(binder, model)
  self:_InitUI(binder, model)
  local tmpText = self.ui.Text_Info:GetComponent(TYPEOF_TMP_Text)
  if tmpText then
    self.tmpTextMat = tmpText.fontMaterial
  end
  if self.tmpTextMat then
    self.tmpTextMat:EnableKeyword("BEVEL_ON")
  end
end

function TutorialMainPanel:RefreshOnRendered()
  self:OnEnterUI()
end

function TutorialMainPanel:_BindReadRewardEvent(binder)
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(items)
    if not items or type(items) ~= "table" then
      return
    end
    for _, item in pairs(items) do
      if item.reason == "TutorialRead" then
        self:_AddReward(item)
      end
    end
  end)
end

function TutorialMainPanel:_BindToturialItemScrollView(binder, model)
  binder:BindToRaw(function(cBinder, nVal, oVal)
    if not oVal then
      return
    end
    if 1 == TutorialDataUtils.GetTutorialMaxPageByTid(oVal) then
      TutorialDataUtils.ReqTutorialFinishRead(oVal)
    end
  end, function()
    return model.curSelectTutorialItemTid
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Toturial_Item, function()
    return model.curShowItemGroup
  end, function(itemBinder, item, index)
    local tutorialData = model.curShowItemGroup[index]
    local tid = tutorialData.tid
    local toturialCfg = TutorialDataUtils.GetConfigByTid(tid)
    
    local function clickFunc()
      model:SetCurSelectTutorialItemTid(tid)
      if 1 == model.maxPage then
        TutorialDataUtils.ReqTutorialFinishRead(tid)
      end
    end
    
    local function redFunc()
      return tutorialData.state == CommonDefine.TutorialItemState.Receive and RedPointDataUtils.RedAttrType.Red or false
    end
    
    local function selectBgFunc()
      return tutorialData.tid == model.curSelectTutorialItemTid
    end
    
    local function showTextFunc()
      do return LT.Text end
      return LT.Text, toturialCfg.Title
    end
    
    local sendData = {
      clickFunc = clickFunc,
      redFunc = redFunc,
      selectBgFunc = selectBgFunc,
      showTextFunc = showTextFunc
    }
    itemBinder:BindComponent(TutorialMainPanelScrollItem(item, sendData))
  end)
  binder:BindToRaw(function(itemBinder)
    local idx = model.curSelectTutorialItemShowIndex
    itemBinder:CircularScrollTo(self.ui.ScrollView_Toturial_Item, idx)
    itemBinder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Toturial_Item)
  end, function()
    return model.curSelectTutorialTab
  end)
end

function TutorialMainPanel:_BindTabGroup(binder, model)
  self.tabGroup = {}
  for ind, toggleInfo in ipairs(model.showTutorialTabGroup) do
    self:_BindToggle(binder, model, toggleInfo, ind)
  end
end

function TutorialMainPanel:_BindToggle(binder, model, toggleInfo, index)
  local toggleObj = self.ui["Toggle_" .. index]
  binder:BindToImage(UI_Common_Item_Toggle_2Resource(toggleObj).Image_Normal_Icon, function()
    return "Icon/Course/" .. toggleInfo[2] or ""
  end)
  binder:BindToImage(UI_Common_Item_Toggle_2Resource(toggleObj).Image_Select_Icon, function()
    return "Icon/Course/" .. toggleInfo[3] or ""
  end)
  local tabInfo = {}
  tabInfo.type = toggleInfo[1]
  tabInfo.ui = toggleObj
  table.insert(self.tabGroup, tabInfo)
  binder:BindToZ1Toggle(toggleObj, nil, function(isOn)
    if isOn then
      model:SetCurSelectTutorialTab(tabInfo.type)
    end
  end, function()
    return model.curSelectTutorialTab and model.curSelectTutorialTab == tabInfo.type
  end)
  binder:BindComponent(RedDotComponent(UI_Common_Item_Toggle_2Resource(toggleObj).Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    local tutorialGroup = model.showTutorialTidGroups[tabInfo.type]
    for _, tid in pairs(tutorialGroup) do
      local tutorialData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
      if tutorialData.state == CommonDefine.TutorialItemState.Receive then
        return RedPointDataUtils.RedAttrType.Red
      end
    end
    return false
  end))
  binder:BindToVisible(toggleObj, function()
    do return self.GetToggleActiveState, self end
    return self.GetToggleActiveState, self, tabInfo.type
  end)
end

function TutorialMainPanel:_BindRightToturialDetailPart(binder, model)
  binder:BindToVisible(self.ui.Group_Empty, function()
    return 0 == #model.curShowItemGroup
  end)
  binder:BindToVisible(self.ui.Group_Right, function()
    return 0 ~= model.curSelectTutorialItemTid
  end)
  binder:BindToImage(self.ui.Image_banner, function()
    return model.curShowImage
  end)
  binder:BindToRaw(function(_, desc)
    binder:SetText(self.ui.Text_Info, desc)
    StrUtils.SetPreferredHeight(self.ui.Text_Info)
  end, function()
    return model.curShowDesc
  end)
  binder:BindToVisible(self.ui.Group_Cut, function()
    return 1 ~= model.maxPage
  end)
  binder:BindToText(self.ui.Text_Num1, function()
    return model.curPage
  end)
  binder:BindToText(self.ui.Text_Num2, function()
    return model.maxPage
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Up, function()
    model:SetCurPage(model.curPage - 1)
  end, function()
    if model.curPage == model.minPage then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Down, function()
    local newPage = model.curPage + 1
    if model.maxPage > 1 and newPage == model.maxPage then
      TutorialDataUtils.ReqTutorialFinishRead(model.curSelectTutorialItemTid)
    end
    model:SetCurPage(newPage)
  end, function()
    if model.curPage == model.maxPage then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end, nil, function()
    if not model.curSelectTutorialItemTid then
      return false
    end
    local tutorialData = TutorialDataUtils.GetTutorialItemDataByTid(model.curSelectTutorialItemTid)
    if not tutorialData then
      return false
    end
    if tutorialData.state == CommonDefine.TutorialItemState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function TutorialMainPanel:_BindInputSearchFilter(binder, model)
  binder:BindZ1Button(self.ui.Btn_Search, function()
    local searchStr = binder:GetInputText(self.ui.InputField_Course)
    model:SetInSearchingState("" ~= searchStr)
    model:UpdateCurShowItemGroup()
    model:SetCurSelectTutorialItemTid(model.curShowItemGroup[1] and model.curShowItemGroup[1].tid or 0)
  end)
  binder:BindZ1Button(self.ui.Btn_Onekey, function()
    if TutorialDataUtils.CheckTutorialHaveState(CommonDefine.TutorialItemState.Receive) then
      Alert.Show(20113, nil, function()
        TutorialDataUtils.ReqTutorialFinishAllRead()
      end)
    else
      Alert.Show(10738)
    end
  end)
  binder:BindToInputValueChange(self.ui.InputField_Course, function()
    local searchStr = binder:GetInputText(self.ui.InputField_Course)
    model:SetSearchKeyStr(searchStr)
  end)
  binder:BindToVisible(self.ui.Group_InputNum, function()
    return model.inSearchingState
  end)
  binder:BindToText(self.ui.Text_Result, function()
    local rst = ""
    if model.inSearchingState then
      rst = LT.Textf("TutorialSearchResult", #model.curShowItemGroup)
    end
    return rst
  end)
end

function TutorialMainPanel:_BindTopLabelCurrencyGroup(binder, model)
  binder:BindToText(self.ui.Text_Label, function()
    if model.curSelectTutorialTab then
      do return LT.Text end
      return LT.Text, DT.CommonID[model.curSelectTutorialTab].Desc, model.curSelectTutorialTab
    end
    return ""
  end)
end

function TutorialMainPanel:_InitUI(binder, model)
  self.ui.Group_ScrollView:GetComponent(typeof(VerticalLayoutGroup)).enabled = true
  self.scrollContent = self.ui.Content:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not self.tidGroup then
    model:SetCurSelectTutorialTab(TutorialTabType.All)
    binder:CircularScrollTo(self.ui.ScrollView_Toturial_Item, model.curSelectTutorialItemShowIndex)
    return
  end
  if 1 ~= #self.tidGroup then
    table.sort(self.tidGroup, function(a, b)
      local aTutorialItemData = TutorialDataUtils.GetTutorialItemDataByTid(a)
      local bTutorialItemData = TutorialDataUtils.GetTutorialItemDataByTid(b)
      return aTutorialItemData.sortWeight > bTutorialItemData.sortWeight
    end)
  end
  local jumpTid = self.tidGroup[1]
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(jumpTid)
  for ind, toggleInfo in ipairs(model.showTutorialTabGroup) do
    if toggleInfo[1] == tutorialCfg.Type then
      self.binder:SetZ1Toggle(self.ui["Toggle_" .. ind], true, true)
      break
    end
  end
  model:SetCurSelectTutorialTab(tutorialCfg.Type)
  model:SetCurSelectTutorialItemTid(jumpTid)
  print("mainc TutorialMainPanel:_InitUI", model.curSelectTutorialItemShowIndex, model.curSelectTutorialTab, model.curSelectTutorialItemTid)
  binder:CircularScrollTo(self.ui.ScrollView_Toturial_Item, model.curSelectTutorialItemShowIndex)
end

function TutorialMainPanel:_AddReward(newItem)
  for idx, reward in pairs(self.showRewardGroup) do
    if reward.uid == newItem.uid then
      self.showRewardGroup[idx].num = self.showRewardGroup[idx].num + newItem.num
      self.showRewardGroup[idx].changedNum = self.showRewardGroup[idx].changedNum + newItem.changedNum
      return
    end
  end
  table.insert(self.showRewardGroup, newItem)
end

function TutorialMainPanel:_GetCurShowingItemRange()
  local startIdx, endIdx = 1, #self.model.curShowItemGroup
  if 0 == endIdx then
    return 0, 0
  end
  local scrollContentYPos = math.floor(self.scrollContent.anchoredPosition.y + 0.5)
  if endIdx < ONE_PAGE_SHOW_ITEM_NUM then
    return startIdx, endIdx
  end
  local deltaNum = scrollContentYPos // ITEM_PER_HEIGHT
  startIdx = startIdx + deltaNum
  endIdx = startIdx + ONE_PAGE_SHOW_ITEM_NUM - 1
  return startIdx, endIdx
end

function TutorialMainPanel:_JumpToHead()
  self.binder:CircularScrollTo(self.ui.ScrollView_Toturial_Item, self.model.curSelectTutorialItemShowIndex)
end

function TutorialMainPanel:_JumpToTail()
  self.binder:CircularScrollTo(self.ui.ScrollView_Toturial_Item, self.model.curSelectTutorialItemShowIndex - ONE_PAGE_SHOW_ITEM_NUM + 1)
  self.scrollContent.anchoredPosition = CS.UnityEngine.Vector2(self.scrollContent.anchoredPosition.x, self.scrollContent.anchoredPosition.y + 40)
end

function TutorialMainPanel:GetToggleActiveState(type)
  local rst = false
  local showTutorialTidGroup = self.model.showTutorialTidGroups[type]
  for _, tid in pairs(showTutorialTidGroup) do
    local tutorialItemData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
    if tutorialItemData.state == CommonDefine.TutorialItemState.Receive or tutorialItemData.state == CommonDefine.TutorialItemState.Done then
      rst = true
      break
    end
  end
  return rst
end

function TutorialMainPanel:ReqTutorialFinishReadCb(cb)
  if 1 == TutorialDataUtils.GetTutorialMaxPageByTid(self.model.curSelectTutorialItemTid) then
    TutorialDataUtils.ReqTutorialFinishRead(self.model.curSelectTutorialItemTid, cb)
  end
  ItemDataUtils.ShowItemGain(self.showRewardGroup, nil, "TutorialReward")
  self.showRewardGroup = {}
end

function TutorialMainPanel:OnUnbind()
  if self.tmpTextMat then
    self.tmpTextMat:DisableKeyword("BEVEL_ON")
  end
  if TaskModel.Instance:GetCurTaskPage() == cd.TaskPage.Tutorial then
    self:ReqTutorialFinishReadCb()
  end
  self.binder = nil
end

function TutorialMainPanel:Close()
  self:OnEnterUI()
  Super.Close(self)
end

return TutorialMainPanel
