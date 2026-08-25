local KeyCode = CS.UnityEngine.KeyCode
local SettingBundleShortcutSingleItem, Super = NewViewComponent("SettingBundleShortcutSingleItem")

function SettingBundleShortcutSingleItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Item_ShortcutKeyResource(uiNode)
  self.data = data
  self._isRecording = false
  self._cancelRecordingFn = System.fn(self, self.CancelRecording)
end

function SettingBundleShortcutSingleItem:OnEnterComponent()
  if not self.data then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  self:BindEvent(EventMgr.Instance.OnKeyDown, System.fn(self, self._OnKeyDown))
  self:SetText(self.ui.Text_Title, self.data.titleText)
  self:SetText(self.ui.Text_Name, SettingManager.Instance:GetShortCutByTid(self.data.tid))
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    self:SetRecording(self.ui.Text_Name)
  end)
  self:_UpdateButtonState()
  self:BindEvent(EventMgr.Instance.ShortCutChange, System.fn(self, self.OnShortCutChange))
end

function SettingBundleShortcutSingleItem:OnExitComponent()
  EventMgr.Instance.TouchBeginEvent:RemoveEvent(self._cancelRecordingFn)
  if self._isRecording then
    self:SetShortCutRecording(false)
  end
  Super.OnExitComponent(self)
end

function SettingBundleShortcutSingleItem:_OnKeyDown(keyName)
  if not self._isRecording then
    return
  end
  if string.startswith(keyName, "Mouse") then
    return
  end
  if keyName == ShortCutKeys.NormalKeys[KeyCode.Backspace] then
    self:SetRecordKey("")
    return
  end
  self:SetRecordKey(keyName)
end

function SettingBundleShortcutSingleItem:_UpdateButtonState()
  local state = self._isRecording and cd.Z1ButtonState.High or cd.Z1ButtonState.Normal
  self:SetButtonState(self.ui.Btn_Click, state)
end

function SettingBundleShortcutSingleItem:SetShortCutRecording(isRecording)
  self._isRecording = isRecording
  EventMgr.Instance.ShortCutRecording:Dispatch(isRecording)
  self:_UpdateButtonState()
end

function SettingBundleShortcutSingleItem:SetRecording(textObj)
  self:SetText(textObj, LT.Text("RecordShortcut"))
  EventMgr.Instance.TouchBeginEvent:RegisterEvent(self._cancelRecordingFn)
  self:SetShortCutRecording(true)
end

function SettingBundleShortcutSingleItem:SetRecordKey(keyName)
  self:SetText(self.ui.Text_Name, keyName)
  SettingManager.Instance:SetNewShortCut(keyName, self.data.tid)
end

function SettingBundleShortcutSingleItem:CancelRecording()
  if not self._isRecording then
    return
  end
  self:SetText(self.ui.Text_Name, SettingManager.Instance:GetShortCutByTid(self.data.tid))
  EventMgr.Instance.TouchBeginEvent:RemoveEvent(self._cancelRecordingFn)
  self:SetShortCutRecording(false)
end

function SettingBundleShortcutSingleItem:OnShortCutChange(tid, _, shortCut)
  if self.data and self.data.tid == tid then
    self:SetText(self.ui.Text_Name, shortCut)
  end
end

return SettingBundleShortcutSingleItem
