local GmAccountJsonRenamePanel, Super = System.NewClass("GmAccountJsonRenamePanel", UIBasePanel)
GmAccountJsonRenamePanel.uiResCls = UI_Team_Popup_Tip_ChangeNameResource

function GmAccountJsonRenamePanel:ctor(accountContent)
  Super.ctor(self)
  self.accountContent = accountContent
end

function GmAccountJsonRenamePanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnClose), function()
    return CommonDefine.BtnType.Unclickable
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnConfirm), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "请输入账号数据文件名"
  end)
  binder:BindToText(self.ui.Text_Old_Name, function()
    do return LT.Text end
    return LT.Text, "中文无法识别，请输入英文文件名"
  end)
end

function GmAccountJsonRenamePanel:OnConfirm()
  local filePath = CS.UnityEngine.Application.streamingAssetsPath .. "/AccountJson"
  local accountName = self.binder:GetInputText(self.ui.InputField_Name)
  local strTime = TimeUtils.GetServerTime()
  strTime = TimeUtils.TimestampToString(math.floor(strTime), TimeUtils.TimeExactType.Hour)
  local fileName = accountName .. " " .. strTime .. ".json"
  filePath = string.format("%s/%s", filePath, fileName)
  local file = io.open(filePath, "w")
  file:write(self.accountContent)
  file:close()
  self.accountContent = nil
  self.accountLen = nil
  filePath = CS.UnityEngine.Application.streamingAssetsPath .. "/AccountJson"
  local fileGroup = CS.System.IO.Directory.GetFiles(filePath, "*.json")
  local recordFile = io.open(filePath .. "/AccountJsonRecord.txt", "w")
  for i = 0, fileGroup.Length - 1 do
    local jsonFileName = string.sub(fileGroup[i], string.find(fileGroup[i], "\\[^\\]*$") + 1)
    if recordFile then
      recordFile:write(jsonFileName .. "\n")
    end
  end
  recordFile:close()
  self:OnClose()
end

function GmAccountJsonRenamePanel:OnClose()
  self:Close()
end

return GmAccountJsonRenamePanel
