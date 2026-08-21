_class("UISideEnterMain", UICustomWidget)
UISideEnterMain = UISideEnterMain

function UISideEnterMain:Constructor()
  self._const_max = 3
end

function UISideEnterMain:_Refresh()
  if not self._refreshTaskId then
    self._refreshTaskId = TaskManager:GetInstance():StartTask(self._LoadDataAndRefresh, self)
  end
end

function UISideEnterMain:_LoadDataAndRefresh(TT)
  local lockName = "UISideEnterMain_LoadDataAndRefresh"
  GameGlobal.UIStateManager():Lock(lockName)
  local cfgList = UISideEnterConst.GetCfgList_SideEnterEdge()
  local showTb = UISideEnterConst.SpawnSideEnterLoader(TT, self, "_loaderPool", cfgList)
  self:_HideEnterBtns(showTb, self._const_max)
  self:_SetCenterEnter(TT)
  GameGlobal.UIStateManager():UnLock(lockName)
  self._refreshTaskId = nil
end

function UISideEnterMain:_HideEnterBtns(showTb, maxCount)
  for i = 1, #showTb do
    local isShow = i <= maxCount
    showTb[i]:GetGameObject():SetActive(isShow)
  end
end

function UISideEnterMain:_SetCenterEnter(TT)
  local obj = UIWidgetHelper.SpawnObject(self, "_centerEnter", "UISideEnterCenterEntry")
  obj:SetData(TT)
end
