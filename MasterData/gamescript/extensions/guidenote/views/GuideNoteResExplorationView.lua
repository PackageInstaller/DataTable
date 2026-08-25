local GuideNoteResExplorationView, Super = NewClass("GuideNoteResExplorationView", BaseView)
GuideNoteResExplorationView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_ResExploration.prefab"

function GuideNoteResExplorationView:ctor()
  Super.ctor(self)
  self._summaryList = nil
  self._cardTableView = nil
end

function GuideNoteResExplorationView:OnBuildView()
  Super.OnBuildView(self)
  self:_CreateTableView()
end

function GuideNoteResExplorationView:OnEnterView()
  Super.OnEnterView(self)
  SchoolTowerController.Instance:ReqDisposableTowerAwardProgressForGuideNote()
  self._summaryList = PermResDataUtils.GetSortedSummaryList()
  if self._cardTableView then
    self._cardTableView:ReloadData()
  end
end

function GuideNoteResExplorationView:RegisterEvents()
  Super.RegisterEvents(self)
  self:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.RefreshView))
  self:BindEvent(EventMgr.Instance.OnAwardProgressDataChanged, System.fn(self, self.RefreshView))
end

function GuideNoteResExplorationView:RefreshView()
  if self._cardTableView then
    self._cardTableView:ReloadData()
  end
end

function GuideNoteResExplorationView:_CreateTableView()
  local itemTemplate = self.ui.UI_GuideNote_Item_Exploration
  if nil == itemTemplate then
    return
  end
  itemTemplate:SetActive(false)
  local sizeDelta = itemTemplate.transform.sizeDelta
  local cellWidth, cellHeight = sizeDelta.x, sizeDelta.y
  self._cardTableView = self:CreateTableview(self.ui.ResExplorationView, function()
    return self._summaryList and #self._summaryList or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(itemTemplate)
    self:SetActive(cell.gameObject, true)
    local cfg = self._summaryList[index]
    if cfg then
      self:_RefreshCard(cell.gameObject, cfg)
    end
    return cell
  end, function()
    return cellWidth, cellHeight
  end)
end

function GuideNoteResExplorationView:_RefreshCard(itemGo, cfg)
  if nil == itemGo or nil == cfg then
    return
  end
  local cellUi = UIBaseResource(itemGo)
  if nil == cellUi then
    return
  end
  local moduleKey = cfg.Key
  local isUnlocked = PermResDataUtils.IsModuleUnlocked(moduleKey)
  local title = PermResDataUtils.GetModuleTitle(moduleKey) or ""
  self:SetText(cellUi.Text_Title, title)
  if cellUi.Image_Bg and cfg.Image then
    self:SetImage(cellUi.Image_Bg, cfg.Image)
  end
  self:SetActive(cellUi.Group_Disable, not isUnlocked)
  self:SetActive(cellUi.Group_High, isUnlocked)
  if not isUnlocked then
    self:SetText(cellUi.Text_Featuree, PermResDataUtils.GetModuleFeatureeText(moduleKey))
  end
  local progressPercent = 0
  if isUnlocked then
    progressPercent = PermResDataUtils.GetModuleProgressPercent(moduleKey)
    self:SetText(cellUi.Text_Progress, tostring(progressPercent) .. "%")
    local fillAmount = progressPercent / 100
    self:SetImageFillAmount(cellUi.Image_Progress, fillAmount)
    local featureText = cellUi.Text_Featuree
    if featureText then
      local remainCurrency = PermResDataUtils.GetRemainingSpecialCurrency(moduleKey)
      self:AddViewComponentOnce(cellUi.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, {
        itemTid = CommonDefine.CurrencyType.SeniorMoney,
        itemCount = remainCurrency,
        extraDesc = LT.PanelText("PanelText_UI_GuideNote_Panel_ResExploration_Item_Text_C_Tip_Content")
      })
    end
  end
  if cellUi.Btn_ResSummary then
    self:AddButtonClickListener(cellUi.Btn_ResSummary, function()
      if not isUnlocked then
        Alert.ShowStr(PermResDataUtils.GetModuleFeatureeText(moduleKey))
        return
      end
      local popupTitle = PermResDataUtils.GetModuleTitle(moduleKey) or ""
      UIManager.Instance:Reopen(Urls.GuideNoteResSummaryView, cfg.ID, popupTitle)
    end)
  end
end

return GuideNoteResExplorationView
