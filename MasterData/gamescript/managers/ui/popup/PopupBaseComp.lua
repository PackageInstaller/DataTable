local PopupBaseComp = System.NewComponent("PopupBaseComp")

function PopupBaseComp:CheckPopup()
  assert(self ~= PopupBaseComp, "PopupBaseComp:CheckPopup 用于子类实现自己的检查逻辑。检查成功调用SetBusy(true), 完成之后需要调用SetBusy(false), 否则PopupQue会卡住")
end

function PopupBaseComp:Clear()
  assert(self ~= PopupBaseComp, "PopupBaseComp:Clear 用于子类实现自己的清理逻辑。")
end

function PopupBaseComp:SetBusy(isBusy)
  self._isBusy = isBusy
  if isBusy then
    print("Popup队列暂停", self.__name)
    self._busySafeId = (self._busySafeId or 0) + 1
    local safeId = self._busySafeId
    self.binder:BindTimer(5, 0, nil, function()
      if self._busySafeId ~= safeId or not self._isBusy then
        return
      end
      if self:_OnBusySafetyCheck() then
        return
      end
      Logger.Warn("PopupBaseComp:SafetyCheck cleared stale busy for", self.__name)
      self:SetBusy(false)
    end)
  else
    print("Popup队列恢复", self.__name)
    self._busySafeId = (self._busySafeId or 0) + 1
  end
end

function PopupBaseComp:_OnBusySafetyCheck()
  local url = self._safeCheckUrl
  if url then
    return UIManager.Instance:GetWindow(url) ~= nil
  end
  return true
end

function PopupBaseComp:IsBusy()
  return self._isBusy
end

local copyUrls = {
  Urls.CopyMainView,
  Urls.CopyMainChapterView
}

function PopupBaseComp:IsInCopyView()
  for _, url in ipairs(copyUrls) do
    if UIManager.Instance:GetWindow(url) then
      return true
    end
  end
  return false
end

return PopupBaseComp
