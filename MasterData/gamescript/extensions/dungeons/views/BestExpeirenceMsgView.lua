local BestExpeirenceMsgView, Super = NewClass("BestExpeirenceMsgView", BaseView)
BestExpeirenceMsgView.uiResCls = UI_Chaper_Popup_BsetPlotResource

function BestExpeirenceMsgView:ctor(viewData)
  Super.ctor(self)
  self._tipsTypeTid = viewData.tipsTypeTid
  self._stageTidList = viewData.stageTidList
  self._confirmFunc = viewData.confirmFunc
  self._jumpList = self:GetJumpList()
end

function BestExpeirenceMsgView:OnBuildView()
  Super.OnBuildView(self)
  self:_CreateGotoStageTableView()
end

function BestExpeirenceMsgView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
end

function BestExpeirenceMsgView:OnEnterViewFinished()
end

function BestExpeirenceMsgView:RegisterEvents()
  self:AddToggleValueChangeListener(self.ui.Toggle_Screening, System.fn(self, self._OnToggleNoPrompts))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnBtnConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnBtnCancel))
end

function BestExpeirenceMsgView:RegisterNotifications()
end

function BestExpeirenceMsgView:_RefreshView()
  self:_RefreshDesc()
  self:_RefreshChapters()
end

function BestExpeirenceMsgView:GetJumpList()
  local tipsTypeCfg = DT.TipsType[self._tipsTypeTid]
  if tipsTypeCfg.QuickJump then
    return tipsTypeCfg.QuickJump
  end
  return self._stageTidList
end

function BestExpeirenceMsgView:_OnToggleNoPrompts(isChoose)
  if isChoose then
    ClientDataUtils.SetClientSubData(cd.ClientSubKey.CloseBestPromptToday, 1)
  else
    ClientDataUtils.SetClientSubData(cd.ClientSubKey.CloseBestPromptToday, 0)
  end
end

function BestExpeirenceMsgView:_OnBtnConfirm()
  local confirmFunc = self._confirmFunc
  self:Close()
  if confirmFunc then
    confirmFunc()
  end
end

function BestExpeirenceMsgView:_OnBtnCancel()
  self:Close()
end

function BestExpeirenceMsgView:_RefreshDesc()
  local tipsConfig = DT.TipsType[self._tipsTypeTid or 0]
  if not tipsConfig then
    return
  end
  self:SetText(self.ui.Text_Tips, LT.Text(tipsConfig.Desc))
  self:SetText(self.ui.Text_Title, LT.Text(tipsConfig.Title))
end

function BestExpeirenceMsgView:_RefreshChapters()
  if not self._stageTableView then
    self:_CreateGotoStageTableView()
  end
  self._stageTableView:ReloadData()
end

function BestExpeirenceMsgView:_CreateGotoStageTableView()
  local tableChildGameObj = self.ui.UI_Common_Item_Exchange
  local sizeDelta = tableChildGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._stageTableView = self:CreateTableview(self.ui.ScrollView_Chapter, function()
    return self._jumpList and #self._jumpList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(tableChildGameObj)
    local stageId = self._jumpList[index]
    self:AddViewComponentOnce(cell.gameObject, GotoStageItem, stageId)
    return cell
  end, function()
    return w, h
  end)
end

function BestExpeirenceMsgView:OnExitView()
  Super.OnExitView(self)
end

return BestExpeirenceMsgView
