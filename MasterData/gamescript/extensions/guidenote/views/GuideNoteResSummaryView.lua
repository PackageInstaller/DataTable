local GuideNoteResSummaryView, Super = NewClass("GuideNoteResSummaryView", BaseView)
GuideNoteResSummaryView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Popup_ResSummary.prefab"

function GuideNoteResSummaryView:ctor(configId, title)
  Super.ctor(self)
  self._configId = configId
  self._title = title
  self._cfg = nil
  self._progressItemList = {}
  self._progressTableView = nil
  self._rewardTableView = nil
  self._rewardList = {}
end

function GuideNoteResSummaryView:OnBuildView()
  Super.OnBuildView(self)
  self._cfg = PermResDataUtils.GetSummaryConfig(self._configId)
  local progressItem = self.ui.UI_GuideNote_Item_Progress
  if progressItem then
    progressItem:SetActive(false)
  end
  local rewardTemplate = self.ui.UI_Common_Item_WuPin_Type2
  if rewardTemplate then
    rewardTemplate:SetActive(false)
  end
  self:_CreateProgressTableView()
  self:_CreateRewardTableView()
end

function GuideNoteResSummaryView:_CreateProgressTableView()
  local itemTemplate = self.ui.UI_GuideNote_Item_Progress
  local progressView = self.ui.ProgressView
  if nil == itemTemplate or nil == progressView then
    return
  end
  local sizeDelta = itemTemplate.transform.sizeDelta
  local cellWidth, cellHeight = sizeDelta.x, sizeDelta.y
  self._progressTableView = self:CreateTableview(progressView, function()
    return self._progressItemList and #self._progressItemList or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(itemTemplate)
    self:SetActive(cell.gameObject, true)
    local itemData = self._progressItemList[index]
    if itemData then
      self:_RefreshProgressItemCell(cell.gameObject, itemData)
    end
    return cell
  end, function()
    return cellWidth, cellHeight
  end)
end

function GuideNoteResSummaryView:_RefreshProgressItemCell(itemGo, itemData)
  if nil == itemGo or nil == itemData then
    return
  end
  local cellUi = UIUtils.GetUIByUINode(itemGo)
  if nil == cellUi then
    return
  end
  if cellUi.Text_ProgressTitle then
    self:SetText(cellUi.Text_ProgressTitle, itemData.title or "")
  end
  if cellUi.Text_Progress then
    self:SetText(cellUi.Text_Progress, tostring(itemData.current) .. " / " .. tostring(itemData.total))
  end
end

function GuideNoteResSummaryView:_CreateRewardTableView()
  local itemTemplate = self.ui.UI_Common_Item_WuPin_Type2
  local scrollView = self.ui.ScrollView_Items
  if nil == itemTemplate or nil == scrollView then
    return
  end
  local sizeDelta = itemTemplate.transform.sizeDelta
  local cellWidth, cellHeight = sizeDelta.x, sizeDelta.y
  self._rewardCellWidth = cellWidth
  self._rewardTableView = self:CreateTableview(scrollView, function()
    return self._rewardList and #self._rewardList or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(itemTemplate)
    self:SetActive(cell.gameObject, true)
    local reward = self._rewardList[index]
    if reward then
      self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, {
        itemTid = reward.itemTid,
        itemCount = reward.count
      })
    end
    return cell
  end, function()
    return cellWidth, cellHeight
  end)
end

function GuideNoteResSummaryView:RegisterEvents()
  Super.RegisterEvents(self)
  local backBtn = self.ui.UI_Common_Btn_Back1
  if backBtn then
    self:AddButtonClickListener(backBtn, System.fn(self, self.Close))
  end
  local maskBtn = self.ui.Btn_Mask
  if maskBtn then
    self:AddButtonClickListener(maskBtn, System.fn(self, self.Close))
  end
  local gotoBtn = self.ui.Btn_Goto
  if gotoBtn then
    self:AddButtonClickListener(gotoBtn, System.fn(self, self._OnClickGoto))
  end
end

function GuideNoteResSummaryView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
end

function GuideNoteResSummaryView:_RefreshView()
  if self._cfg == nil then
    return
  end
  self:_RefreshTitle()
  self._progressItemList = PermResDataUtils.ParseDescProgressItems(self._configId)
  if self._progressTableView then
    self._progressTableView:ReloadData()
  end
  self:_RefreshRemainingRewards()
end

function GuideNoteResSummaryView:_RefreshTitle()
  if self._title then
    self:SetText(self.ui.Text_C_Title, self._title)
  end
  local progressView = self.ui.ProgressView
  if nil == progressView then
    return
  end
  local groupProgress = progressView.transform.parent
  if nil == groupProgress then
    return
  end
  local progressTitle = LT.Text("GuideNote_ExplorationProgress")
  local trTitle = groupProgress:Find("Group_ProgressTitle/Text_C_ProgressTitle")
  local titleNode = trTitle and trTitle.gameObject or nil
  if titleNode then
    self:SetText(titleNode, progressTitle)
  end
end

function GuideNoteResSummaryView:_RefreshRemainingRewards()
  local moduleKey = self._cfg and self._cfg.Key or 0
  local rewards = PermResDataUtils.GetRemainingRewards(moduleKey)
  self._rewardList = rewards or {}
  local hasRemainingRewards = #self._rewardList > 0
  local scrollView = self.ui.ScrollView_Items
  local previewRoot = scrollView and scrollView.transform.parent or nil
  local previewGo = previewRoot and previewRoot.gameObject or nil
  if previewGo then
    self:SetActive(previewGo, true)
  end
  if scrollView then
    self:SetActive(scrollView, hasRemainingRewards)
  end
  local trNull = previewRoot and previewRoot:Find("Text_C_Null") or nil
  local nullGo = trNull and trNull.gameObject or nil
  if nullGo then
    self:SetActive(nullGo, not hasRemainingRewards)
  end
  if not hasRemainingRewards then
    if self._rewardTableView then
      self._rewardTableView:ReloadData()
    end
    return
  end
  if self._rewardTableView then
    local tv = self._rewardTableView
    local oldCb = tv.reloadFinishCallback
    
    function tv.reloadFinishCallback(t)
      tv.reloadFinishCallback = oldCb
      if oldCb then
        oldCb(t)
      end
      self:_CenterRewardTableViewIfNeeded()
    end
    
    tv:ReloadData()
  end
end

function GuideNoteResSummaryView:_CenterRewardTableViewIfNeeded()
  self:CenterTableviewContentIfNeeded(self.ui.ScrollView_Items, self._rewardTableView, #self._rewardList, self._rewardCellWidth)
end

function GuideNoteResSummaryView:_OnClickGoto()
  if self._cfg == nil then
    return
  end
  self:Close()
  PermResDataUtils.JumpToModule(self._cfg.Key)
end

return GuideNoteResSummaryView
