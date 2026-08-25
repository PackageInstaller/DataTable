local SettingItemType = CommonDefine.SettingItemType
local KeyCode = CS.UnityEngine.KeyCode
local SettingBundleShortcutSingleItem, Super = System.NewComponent("SettingBundleShortcutSingleItem", SettingBaseItem)

function SettingBundleShortcutSingleItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Item_ShortcutKeyResource(uiNode)
  self.data = data
  self.isRecording = Vue.ref(false)
end

function SettingBundleShortcutSingleItem:OnBind(binder)
  self.binder = binder
  if not self.data then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  self.binder:BindEvent(EventMgr.Instance.OnKeyDown, function(keyName)
    if not self.isRecording.value then
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
  end)
  self.binder:SetText(self.ui.Text_Title, self.data.titleText)
  self.binder:SetText(self.ui.Text_Name, SettingManager.Instance:GetShortCutByTid(self.data.tid))
  self.binder:BindZ1Button(self.ui.Btn_Click, function()
    self:SetRecording(self.ui.Text_Name)
  end, function()
    return self.isRecording.value and cd.Z1ButtonState.High or cd.Z1ButtonState.Normal
  end)
  self.binder:BindEvent(EventMgr.Instance.ShortCutChange, System.fn(self, self.OnShortCutChange))
end

function SettingBundleShortcutSingleItem:OnUnbind()
  EventMgr.Instance.TouchBeginEvent:RemoveEvent(System.fn(self, self.CancelRecording))
  self:SetShortCutRecording(false)
end

function SettingBundleShortcutSingleItem:SetShortCutRecording(isRecording)
  self.isRecording.value = isRecording
  EventMgr.Instance.ShortCutRecording:Dispatch(isRecording)
end

function SettingBundleShortcutSingleItem:SetRecording(textObj)
  self.binder:SetText(textObj, LT.Text("RecordShortcut"))
  EventMgr.Instance.TouchBeginEvent:RegisterEvent(System.fn(self, self.CancelRecording))
  self:SetShortCutRecording(true)
end

function SettingBundleShortcutSingleItem:SetRecordKey(keyName)
  self.binder:SetText(self.ui.Text_Name, keyName)
  SettingManager.Instance:SetNewShortCut(keyName, self.data.tid)
end

function SettingBundleShortcutSingleItem:CancelRecording()
  if not self.isRecording.value then
    return
  end
  self.binder:SetText(self.ui.Text_Name, SettingManager.Instance:GetShortCutByTid(self.data.tid))
  EventMgr.Instance.TouchBeginEvent:RemoveEvent(System.fn(self, self.CancelRecording))
  self:SetShortCutRecording(false)
end

function SettingBundleShortcutSingleItem:OnShortCutChange(tid, _, shortCut)
  if self.data and self.data.tid == tid then
    self.binder:SetText(self.ui.Text_Name, shortCut)
  end
end

return SettingBundleShortcutSingleItem
