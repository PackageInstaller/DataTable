_class("UISeasonTaskListContentModeConfirm", UICustomWidget)
UISeasonTaskListContentModeConfirm = UISeasonTaskListContentModeConfirm

function UISeasonTaskListContentModeConfirm:SetData(confrimCallback, cancelCallback)
  self._confrimCallback = confrimCallback
  self._cancelCallback = cancelCallback
end

function UISeasonTaskListContentModeConfirm:ConfirmBtnOnClick(go)
  if self._confrimCallback then
    self._confrimCallback()
  end
end

function UISeasonTaskListContentModeConfirm:CancelBtnOnClick(go)
  if self._cancelCallback then
    self._cancelCallback()
  end
end
