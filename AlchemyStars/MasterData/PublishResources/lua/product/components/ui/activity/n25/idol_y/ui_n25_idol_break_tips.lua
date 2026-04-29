_class("UIN25IdolBreakTips", UIController)
UIN25IdolBreakTips = UIN25IdolBreakTips

function UIN25IdolBreakTips:Constructor()
  self._breakInfo = nil
  self._fnConfirm = nil
  self._fnCancel = nil
end

function UIN25IdolBreakTips:OnShow(uiParams)
  self._archivePreviewPath = self:GetUIComponent("UISelectObjectPath", "archivePreview")
  self._archivePreview = self._archivePreviewPath:SpawnObject("UIN25IdolArchiveBreak")
  self._breakInfo = uiParams[1]
  self._fnConfirm = uiParams[2]
  self._fnCancel = uiParams[3]
  self._archivePreview:Flush(self._breakInfo)
end

function UIN25IdolBreakTips:OnHide()
end

function UIN25IdolBreakTips:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIN25IdolBreakTips:BtnCancelGameOnClick(go)
  self:CloseDialog()
end

function UIN25IdolBreakTips:BtnLoadGameOnClick(go)
  self._fnConfirm()
end
