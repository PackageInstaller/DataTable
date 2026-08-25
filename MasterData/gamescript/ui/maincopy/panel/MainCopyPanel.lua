local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local UIAnimationController = CS.Z1Client.UIAnimationController
local MOVE_LEN_SHORT = -130
local MOVE_LEN_LONG = -360
local SCROLL_TIME = 10
local MainCopyPanel, Super = System.NewClass("MainCopyPanel", UIBasePanel)
MainCopyPanel.uiResCls = UI_Chapter_Panel_Main2Resource

function MainCopyPanel:ctor(model, page, openCallBack)
  Super.ctor(self)
  self.ScrollMoveIdx = 1
  self.mainCopyItemNum = nil
  self.model = model
  local page = page or CommonDefine.MainCopyPanelPage.MainChapter
  self.openCallBack = openCallBack
  self.page = Vue.ref(page)
end

function MainCopyPanel:OnBind(binder)
  self.binder = binder
  if not self.model then
    self.model = binder:createModel(MainCopyModel)
  end
  local model = self.model
  self.rollListRT = self.ui.Content:GetComponent(typeof(RectTransform))
  self.viewPortRT = self.ui.ViewPort:GetComponent(typeof(RectTransform))
  self.oriViewPortPosY = self.viewPortRT.anchoredPosition.y
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindEvent(EventMgr.Instance.MainCopyStageGroupSelectPlaySmall2Big, function(idx)
    local endPos = self:GetScrollEndPos(idx)
    if not endPos then
      return
    end
    local startPos = self.rollListRT.anchoredPosition.x
    local yPos = self.rollListRT.anchoredPosition.y
    local delta = endPos - startPos
    local showVal = startPos
    for i = 1, SCROLL_TIME do
      FrameWaiter.OnNextFrame(function()
        self.rollListRT.anchoredPosition = CS.UnityEngine.Vector2(showVal, yPos)
        showVal = showVal + delta / SCROLL_TIME
      end, i)
    end
  end)
  binder:BindEvent(EventMgr.Instance.MainCopyStageGroupSelectSwitchSmall2Big, function(idx)
    self.ScrollMoveIdx = idx
  end)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindToRaw(function(itemBinder, nVal, oVal)
    local isAllOpen = true
    local groupIdList = model:GetStageGroupList()
    self.mainCopyItemNum = 0
    self.viewPortRT.anchoredPosition = CS.UnityEngine.Vector2(self.viewPortRT.anchoredPosition.x, -9999)
    self:UpdateMainCopyItemNum(groupIdList)
    for index, groupId in ipairs(groupIdList) do
      self:CreateStageGroupItem(groupId, index, itemBinder, oVal)
      local unlock = MainCopyDataUtils.IsStageGroupUnlock(groupId)
      if not unlock then
        isAllOpen = false
      end
    end
  end, function()
    return model.hardMode
  end)
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, DT.Constant.MainCopyPanelCurrencies.Data))
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Guoup_ItemBranch, DT.Constant.LargeSubplotCurrencies.Data))
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Guoup_SmallBranch, DT.Constant.SmallSubplotCurrencies.Data))
  
  local function redFunc(hardMode)
    local redReturnGroup = {}
    for _, stageGroupId in pairs(CopyDataUtils.CalculateChapterIndex(hardMode)) do
      if MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) then
        table.insert(redReturnGroup, RedPointDataUtils.IsShowStageGroupRedPoint(stageGroupId))
      end
    end
    do return RedPointDataUtils.PickHighWeightRedData end
    return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, pairs(CopyDataUtils.CalculateChapterIndex(hardMode))
  end
  
  local mainTypeKey = PlayerDataUtils.GetFeatureMainTypeKey()
  
  local function GetDifficultyData(hardMode, feature)
    local itemData = {
      model = model,
      redFunc = function()
        do return redFunc end
        return redFunc, hardMode
      end,
      hardGroupShowLockFunc = function()
        local _, unlock = PlayerDataUtils.IsFeatureUnlock(feature, mainTypeKey, nil)
        return not unlock
      end,
      lockClickFunc = function()
        do return PlayerDataUtils.AlertLockedTips, feature end
        return PlayerDataUtils.AlertLockedTips, feature, mainTypeKey
      end,
      hardToggleClickFunc = function(isOn)
        if not isOn then
          return
        end
        EventMgr.Instance.MainCopyDifficultySelect:Dispatch()
        model:SetHardMode(hardMode)
      end
    }
    return itemData
  end
  
  local difficultyData = {
    model = model,
    [CommonDefine.Difficulty.Normal] = GetDifficultyData(CommonDefine.Difficulty.Normal, CommonDefine.FeatureId.MainCopy),
    [CommonDefine.Difficulty.Hard] = GetDifficultyData(CommonDefine.Difficulty.Hard, CommonDefine.FeatureId.MainCopyHard),
    [CommonDefine.Difficulty.Super] = GetDifficultyData(CommonDefine.Difficulty.Super, CommonDefine.FeatureId.MainCopyCrazy)
  }
  binder:BindComponent(MainCopyDifficultySwitchGroup(self.ui.UI_Chapter_Hard_Swich_Group_New, difficultyData))
  binder:BindToText(self.ui.Text_Title, function()
    if self.page.value == CommonDefine.MainCopyPanelPage.MainChapter then
      do return LT.Text end
      return LT.Text, "MainCopyTitle"
    elseif self.page.value == CommonDefine.MainCopyPanelPage.LargeSubplot then
      do return LT.Text end
      return LT.Text, "LargeSubplotTitle"
    elseif self.page.value == CommonDefine.MainCopyPanelPage.SmallSubplot then
      do return LT.Text end
      return LT.Text, "SmallSubplotTitle"
    end
  end)
  binder:BindToVisible(self.ui.ScrollView_Chaper, function()
    return self.page.value == CommonDefine.MainCopyPanelPage.MainChapter
  end)
  binder:BindToVisible(self.ui.Group_Null_White, function()
    return self:_IsLargeSubplotPage() and 0 == #self:_GetSubplotLargeGroupList()
  end)
  binder:BindToVisible(self.ui.Guoup_ItemBranch, System.fn(self, self._IsLargeSubplotPage))
  binder:BindToVisible(self.ui.Guoup_SmallBranch, System.fn(self, self._IsSmallSubplotPage))
  binder:BindToVisible(self.ui.ScrollView_branch, System.fn(self, self._IsLargeSubplotPage))
  binder:BindToVisible(self.ui.ScrollView_SmallBranch, System.fn(self, self._IsSmallSubplotPage))
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, System.fn(self, self._IsSubplotPage))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickBtnTips))
  self:OnBindToggle(binder)
  self:BindToggleRed(binder)
  binder:BindToCircularListView(self.ui.ScrollView_branch, System.fn(self, self._GetSubplotLargeGroupList), System.fn(self, self._OnUpdateLargeSubplotItem))
  binder:BindToCircularListView(self.ui.ScrollView_SmallBranch, System.fn(self, self._GetSubplotGroupList), System.fn(self, self._OnUpdateSmallSubplotItem))
  self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Open")
  if self.openCallBack then
    self.openCallBack()
  end
end

function MainCopyPanel:OnBindToggle(binder)
  binder:BindToZ1Toggle(self.ui.toggle_1, nil, function(isOn)
    if isOn then
      self:_ChangePage(CommonDefine.MainCopyPanelPage.MainChapter)
    end
  end, function()
    return self.page.value == CommonDefine.MainCopyPanelPage.MainChapter
  end)
  binder:BindToZ1Toggle(self.ui.toggle_2, nil, function(isOn)
    if isOn then
      self:_ChangePage(CommonDefine.MainCopyPanelPage.SmallSubplot)
    end
  end, function()
    return self.page.value == CommonDefine.MainCopyPanelPage.SmallSubplot
  end)
  binder:BindToZ1Toggle(self.ui.toggle_3, nil, function(isOn)
    if isOn then
      self:_ChangePage(CommonDefine.MainCopyPanelPage.LargeSubplot)
    end
  end, function()
    return self.page.value == CommonDefine.MainCopyPanelPage.LargeSubplot
  end)
  binder:BindToVisible(self.ui.toggle_2, System.fn(self, self._ShowSmallSubplotTab))
  binder:BindToVisible(self.ui.toggle_3, System.fn(self, self._ShowLargeSubplotTab))
end

function MainCopyPanel:BindToggleRed(binder)
  local UI_Common_Item_Toggle_2Resource = _ENV.UI_Common_Item_Toggle_2Resource
  local toggle_1_ui = UI_Common_Item_Toggle_2Resource(self.ui.toggle_1)
  local toggle_2_ui = UI_Common_Item_Toggle_2Resource(self.ui.toggle_2)
  local toggle_3_ui = UI_Common_Item_Toggle_2Resource(self.ui.toggle_3)
  if toggle_1_ui and toggle_1_ui.Com_RedDot then
    binder:BindComponent(RedDotComponent(toggle_1_ui.Com_RedDot, nil, nil, MainCopyDataUtils.IsShowMainCopyNew))
  end
  if toggle_2_ui and toggle_2_ui.Com_RedDot then
    binder:BindComponent(RedDotComponent(toggle_2_ui.Com_RedDot, nil, nil, SubplotRedUtils.GetSmallSubplotRed))
  end
  if toggle_3_ui and toggle_3_ui.Com_RedDot then
    binder:BindComponent(RedDotComponent(toggle_3_ui.Com_RedDot, nil, nil, SubplotRedUtils.GetLargeSubplotRed))
  end
end

function MainCopyPanel:CreateStageGroupItem(groupId, index, binder, oldHardMode)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(groupId)
  local cacheData = DataCenter.resonanceData.groupedResonances[resonanceGroupId]
  ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
  if not self.ui then
    return
  end
  local uiNode = CS.UnityEngine.GameObject.Instantiate(self.ui.UI_Task_Item_Chapter_Small, self.ui.Content.transform)
  uiNode:SetActive(true)
  binder:BindUIBehavior(uiNode, groupId, index, self.model, oldHardMode)
  binder:onDestroy(function()
    CS.UnityEngine.GameObject.Destroy(uiNode)
  end)
  if self.ScrollMoveIdx and index == self.mainCopyItemNum or 1 == self.mainCopyItemNum then
    if cacheData and oldHardMode then
      self:MoveScrollWithoutAnim()
      self.viewPortRT.anchoredPosition = CS.UnityEngine.Vector2(self.viewPortRT.anchoredPosition.x, self.oriViewPortPosY)
    else
      FrameWaiter.OnNextFrame(function()
        self:MoveScrollWithoutAnim()
        self.viewPortRT.anchoredPosition = CS.UnityEngine.Vector2(self.viewPortRT.anchoredPosition.x, self.oriViewPortPosY)
      end, 1)
    end
  end
end

function MainCopyPanel:Close()
  self.closeBtn:PlayCloseAnim()
  UIManager.Instance:ReShowBehindPanel(self)
  EventMgr.Instance.OpenAnimMask:Dispatch()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Close", function()
    UIManager.Instance:CloseByUrl(Urls.CopyStageDetailView)
    UIManager.Instance:CloseByUrl(Urls.MainCopyChapterPanel)
    EventMgr.Instance.CloseAnimMask:Dispatch()
    Super.Close(self)
  end)
end

function MainCopyPanel:MoveScrollWithoutAnim()
  if not self.ui then
    return
  end
  local endPos = self:GetScrollEndPos(self.ScrollMoveIdx or 1)
  if not endPos then
    return
  end
  local scrollWidth = self.ui.ScrollView_Chaper:GetComponent(typeof(RectTransform)).sizeDelta.x
  self.ScrollRect = self.ui.ScrollView_Chaper:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  local sizeDeltaX = self.rollListRT.sizeDelta.x
  sizeDeltaX = sizeDeltaX > 0 and sizeDeltaX or math.abs(endPos) + scrollWidth
  self.ScrollRect.horizontalNormalizedPosition = math.abs(endPos / (sizeDeltaX - scrollWidth))
  self.ScrollMoveIdx = 1
end

function MainCopyPanel:GetScrollEndPos(idx)
  local rst = 0
  local groupLen = self.mainCopyItemNum
  if idx <= 1 then
    return rst
  end
  for i = 2, idx do
    if 2 == i or i == groupLen then
      rst = rst + MOVE_LEN_SHORT
    else
      rst = rst + MOVE_LEN_LONG
    end
  end
  return rst
end

function MainCopyPanel:UpdateMainCopyItemNum(groupIdList)
  local isAllOpen = true
  for _, groupId in ipairs(groupIdList) do
    self.mainCopyItemNum = self.mainCopyItemNum + 1
    local unlock = MainCopyDataUtils.IsStageGroupUnlock(groupId)
    if not unlock then
      isAllOpen = false
    end
  end
end

function MainCopyPanel:_OnClickBtnTips()
  if not self:_IsSubplotPage() then
    return
  end
  local title = ""
  local content = ""
  if self.page.value == CommonDefine.MainCopyPanelPage.SmallSubplot then
    title = LT.Text("SmallSubplotTipsTitle")
    content = LT.Text("SmallSubplotTipsText")
  elseif self.page.value == CommonDefine.MainCopyPanelPage.LargeSubplot then
    title = LT.Text("LargeSubplotTipsTitle")
    content = LT.Text("LargeSubplotTipsText")
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function MainCopyPanel:_IsSubplotPage()
  local isSmallSubplot = self:_IsSmallSubplotPage()
  local isLargeSubplot = self:_IsLargeSubplotPage()
  return isSmallSubplot or isLargeSubplot
end

function MainCopyPanel:_IsLargeSubplotPage()
  return self.page.value == CommonDefine.MainCopyPanelPage.LargeSubplot
end

function MainCopyPanel:_IsSmallSubplotPage()
  return self.page.value == CommonDefine.MainCopyPanelPage.SmallSubplot
end

function MainCopyPanel:_ShowLargeSubplotTab()
  local typeKey = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.LargeSubplotTab, typeKey)
  return isUnlock
end

function MainCopyPanel:_ShowSmallSubplotTab()
  local typeKey = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SmallSubplotTab, typeKey)
  return isUnlock
end

function MainCopyPanel:_ChangePage(page)
  if not page then
    return
  end
  self.page.value = page
  if self:_IsLargeSubplotPage() then
    EventMgr.Instance.SubplotGroupLargeSelect:Dispatch()
  elseif self:_IsSmallSubplotPage() then
    EventMgr.Instance.SubplotGroupSmallSelect:Dispatch()
  else
    self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Chaper_Open")
  end
end

function MainCopyPanel:_GetSubplotGroupList()
  return self.model.subplotGroupList
end

function MainCopyPanel:_GetSubplotLargeGroupList()
  return self.model.sublplotLargeGroupList
end

function MainCopyPanel:_OnUpdateLargeSubplotItem(binder, go, index)
  local groupTid = self.model.sublplotLargeGroupList[index]
  binder:BindComponent(SubplotGroupListItem(go, groupTid, index, self.model))
end

function MainCopyPanel:_OnUpdateSmallSubplotItem(binder, go, index)
  local groupTid = self.model.subplotGroupList[index]
  binder:BindComponent(SubplotGroupListItem(go, groupTid, index, self.model))
end

return MainCopyPanel
