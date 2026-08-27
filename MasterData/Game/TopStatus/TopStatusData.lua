local TopStatusData = class("TopStatusData")

function TopStatusData:InitTopStatusData(uiTab)
  if uiTab ~= nil and not table.IsEmptyTable(uiTab) then
    self.uiTab = uiTab
  else
    self.uiTab = {isHandledTopStatus = false, settedTopStatus = false}
    self.isEmptyTab = true
  end
  if self.uiTab.GetUIWindowTypeId ~= nil then
    self.winTypeID = self.uiTab:GetUIWindowTypeId()
  end
  self.hideTopStatus = true
end

function TopStatusData:ResetTopStatusData()
  self.isEmptyTab = nil
  self.uiTab = nil
  self.winTypeID = nil
  self.hideTopStatus = nil
  self.hideTopButton = nil
  self.topBtnOnlyReturn = nil
  self.backAction = nil
  self.resIds = nil
  self.resAddCallbackDic = nil
  self.infoAction = nil
  self.infoActionBuledot = nil
  self.onWinShowFunc = nil
  self.OnTopNodeChange = nil
  self.back2FrontCallback = nil
  self.preCheckFunc = nil
  self.asyncWindowId = nil
  self.settedGoHomeAndNaviBtn = nil
  self.prefShowGoHomeBtn = nil
  self.prefShowNaviBtn = nil
  self.isBlockEsc = nil
end

function TopStatusData:SetTopStatusBackAction(backFunc)
  if backFunc ~= nil then
    self.backAction = UIUtil.BindFunc(self.uiTab, backFunc)
  end
  return self
end

function TopStatusData:SetTopStatusResData(resIds, resAddCallbackDic)
  self.resIds = resIds
  self.resAddCallbackDic = resAddCallbackDic
  return self
end

function TopStatusData:SetTopStatusInfoFunc(infoFunc)
  if infoFunc ~= nil then
    self.infoAction = UIUtil.BindFunc(self.uiTab, infoFunc)
  end
  return self
end

function TopStatusData:SetTopStatusVisible(isTopStatusVisible)
  self.hideTopStatus = not isTopStatusVisible
  return self
end

function TopStatusData:SetTopStatusOnWinShowFunc(onWinShowFunc)
  self.onWinShowFunc = onWinShowFunc
  return self
end

function TopStatusData:SetTopStatusChangeFunc(onTopStatusChangeFunc)
  self.OnTopNodeChange = BindCallback(self.uiTab, onTopStatusChangeFunc)
  return self
end

function TopStatusData:SetTopStatusAsyncWindowId(asyncWindowId)
  self.asyncWindowId = asyncWindowId
  return self
end

function TopStatusData:SetTopstatusBlockEsc(isBlock)
  self.isBlockEsc = isBlock
  return self
end

function TopStatusData:PushTopStatusDataToBackStack(checkMultiSetTop)
  if UIManager:GetWindow(UIWindowTypeID.TopStatus) == nil then
    return
  end
  if checkMultiSetTop and self.uiTab.settedTopStatus then
    return
  end
  self.uiTab.settedTopStatus = true
  if UIUtil.TryReplaceDataByAsyncWindowId(self:GetWinTypeID(), self) == nil then
    UIUtil.backStack:Push(self)
  end
  
  local function refreshTopWin(win)
    win:RefreshTopStatusUI(self)
    win.transform:SetAsFirstSibling()
    if self:GetAsyncWindowId() == nil then
      UIUtil.RefreshTopStatus(false)
    end
    if self.onWinShowFunc ~= nil then
      self.onWinShowFunc()
    end
  end
  
  local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topWin == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
      if win ~= nil then
        refreshTopWin(win)
      end
    end)
  else
    refreshTopWin(topWin)
  end
  return self
end

function TopStatusData:GetIsEmptyTab()
  return self.isEmptyTab
end

function TopStatusData:GetAsyncWindowId()
  return self.asyncWindowId
end

function TopStatusData:GetWinTypeID()
  return self.winTypeID
end

function TopStatusData:GetUiTab()
  return self.uiTab
end

function TopStatusData:GetIsBlockEsc()
  return self.isBlockEsc
end

return TopStatusData
