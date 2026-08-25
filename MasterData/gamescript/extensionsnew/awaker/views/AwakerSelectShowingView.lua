local AwakerSelectShowingView, Super = System.NewClass("AwakerSelectShowingView", BaseView)
AwakerSelectShowingView.uiResCls = UI_Main_Helicopter_TipsResource

function AwakerSelectShowingView:ctor(mainPanelModel)
  Super.ctor(self)
  self.mainPanelModel = mainPanelModel
  self.model = AwakerSelectShowingModel.Instance
  self.controller = AwakerSelectShowingController.Instance
end

function AwakerSelectShowingView:OnBuildView()
  Super.OnBuildView(self)
  self:_BuildAwakerListView()
end

function AwakerSelectShowingView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.OnClose))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnClose))
  self:AddButtonClickListener(self.ui.Group_ResetBg, System.fn(self, self._OnClickResetBg))
  self:AddButtonClickListener(self.ui.Btn_Hide_HUD, System.fn(self, self._OnClickHideHud))
end

function AwakerSelectShowingView:OnEnterView()
  Super.OnEnterView(self)
  self.model:ResetData()
  self.model:SetCurSelectAwakerTid(self.mainPanelModel.showAwakerTid)
  self._awakerGroup = self.model:GetSelectAwakerGroup()
  self:_RefreshAll()
end

function AwakerSelectShowingView:OnExitView()
  Super.OnExitView(self)
end

function AwakerSelectShowingView:_RefreshAll()
  self:_RefreshPortrait()
  self:_RefreshTexts()
  self:_RefreshList()
end

function AwakerSelectShowingView:_RefreshPortrait()
  local awakerTid = self.model:GetCurSelectAwakerTid()
  if not awakerTid then
    return
  end
  local resNum = AwakerDataUtils.GetAwakerResNum(awakerTid)
  self:AddViewComponentOnce(self.ui.Container_Awaker, UICompAwakerPortrait, {
    awakerTid = awakerTid,
    portraitNo = resNum,
    portraitAlign = CommonDefine.PortraitAlign.HorizontalCenter
  })
end

function AwakerSelectShowingView:_RefreshTexts()
  local awakerTid = self.model:GetCurSelectAwakerTid()
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if awakerData and awakerData.createTime then
    local y, m, d = TimeUtils.GetTimestampYmdHMS(awakerData.createTime)
    self:SetText(self.ui.Text_Date, LT.Text(string.format("%s/%s/%s", y, m, d)))
  else
    self:SetText(self.ui.Text_Date, "")
  end
  local likeLevel = AwakerDataUtils.GetAwakerLikeLevel(awakerTid)
  local isLvMax = likeLevel >= FavorabilityVisualUtils.ShowPremiumCardFaceLevel()
  self:SetText(self.ui.Text_Lv, likeLevel)
  if self.ui.Image_LvBg then
    local lvBgRes = isLvMax and "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_AwakerFavor_Max.png" or "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_01Nor.png"
    self:SetImage(self.ui.Image_LvBg, lvBgRes)
  end
  if self.ui.Image_LvBg2 then
    self:SetActive(self.ui.Image_LvBg2, not isLvMax)
  end
  if self.ui.Text_Lv then
    self:SetActive(self.ui.Text_Lv, not isLvMax)
  end
  self:SetText(self.ui.Text_CurRate, self.model:GetAwakerLike())
  self:SetText(self.ui.Text_NextRate, "/" .. self.model:GetNextAwakerLike())
end

function AwakerSelectShowingView:_RefreshList()
  if self._tableView then
    self._tableView:ReloadData()
  end
end

function AwakerSelectShowingView:_BuildAwakerListView()
  local cellPrefab = UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Awaker_List)
  if not cellPrefab then
    return
  end
  self._cellPrefab = cellPrefab
  local cellW = cellPrefab.transform.sizeDelta.x
  local cellH = cellPrefab.transform.sizeDelta.y
  self._tableView = self:CreateTableview(self.ui.ScrollView_Awaker_List, function()
    return self._awakerGroup and #self._awakerGroup or 0
  end, function(view, idx)
    do return self._OnAwakerCellAtIndex, self, view end
    return self._OnAwakerCellAtIndex, self, view, idx
  end, function()
    return cellW, cellH
  end)
end

function AwakerSelectShowingView:_OnAwakerCellAtIndex(view, idx)
  local awakerData = self._awakerGroup[idx]
  if not awakerData then
    return nil
  end
  local cell = self:DequeueCell(view, self._cellPrefab)
  local itemData = {
    awakerData = awakerData,
    clickFunc = function()
      self.model:SetCurSelectAwakerTid(awakerData.tid)
      self:_RefreshAll()
    end,
    selectFunc = function()
      return awakerData.tid == self.model:GetCurSelectAwakerTid()
    end,
    showTextFunc = function()
      local awakerCfg = DT.AwakerConfig[awakerData.tid]
      return awakerCfg and awakerCfg.Name
    end
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicAwakerListItem, itemData)
  return cell
end

function AwakerSelectShowingView:_OnClickConfirm()
  self.controller:Confirm(self.mainPanelModel, self.model:GetCurSelectAwakerTid())
  self:OnClose()
end

function AwakerSelectShowingView:_OnClickResetBg()
  self.controller:ResetBg()
end

function AwakerSelectShowingView:_OnClickHideHud()
  self.controller:HideHud(self.mainPanelModel)
  self:OnClose()
end

function AwakerSelectShowingView:OnClose()
  self:Close()
end

return AwakerSelectShowingView
