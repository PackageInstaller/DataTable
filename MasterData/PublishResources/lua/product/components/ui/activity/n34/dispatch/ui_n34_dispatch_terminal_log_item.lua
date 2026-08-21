_class("UIN34DispatchTerminalLogItem", UICustomWidget)
UIN34DispatchTerminalLogItem = UIN34DispatchTerminalLogItem

function UIN34DispatchTerminalLogItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN34DispatchTerminalLogItem:InitWidget()
  self.logTxt = self:GetUIComponent("UILocalizationText", "LogTxt")
end

function UIN34DispatchTerminalLogItem:SetData(data)
  if not data then
    return
  end
  self.logTxt:SetText(StringTable.Get(data.ChatId))
end
