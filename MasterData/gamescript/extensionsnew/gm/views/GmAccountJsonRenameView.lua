local GmAccountJsonRenameView, Super = NewClass("GmAccountJsonRenameView", BaseView)
GmAccountJsonRenameView.uiResCls = UI_Team_Popup_Tip_ChangeNameResource

function GmAccountJsonRenameView:ctor(accountContent)
  Super.ctor(self)
  self._accountContent = accountContent
end

function GmAccountJsonRenameView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClose))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClose))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnConfirm))
end

function GmAccountJsonRenameView:OnEnterView()
  Super.OnEnterView(self)
  self:SetButtonState(self.ui.Btn_Cancel, CommonDefine.BtnType.Unclickable)
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("UniversalConfirmButton"))
  self:SetText(self.ui.Text_Title, LT.Text("请输入账号数据文件名"))
  self:SetText(self.ui.Text_Old_Name, LT.Text("中文无法识别，请输入英文文件名"))
end

function GmAccountJsonRenameView:OnExitView()
  Super.OnExitView(self)
end

function GmAccountJsonRenameView:_OnConfirm()
  local filePath = CS.UnityEngine.Application.streamingAssetsPath .. "/AccountJson"
  local accountName = self:GetInputText(self.ui.InputField_Name)
  local strTime = TimeUtils.GetServerTime()
  strTime = TimeUtils.TimestampToString(math.floor(strTime), TimeUtils.TimeExactType.Hour)
  local fileName = accountName .. " " .. strTime .. ".json"
  local jsonFilePath = string.format("%s/%s", filePath, fileName)
  local file = io.open(jsonFilePath, "w")
  if file then
    file:write(self._accountContent)
    file:close()
  else
    Logger.Error("GmAccountJsonRenameView: 无法写入账号数据文件 %s", jsonFilePath)
  end
  self._accountContent = nil
  local fileGroup = CS.System.IO.Directory.GetFiles(filePath, "*.json")
  local recordFile = io.open(filePath .. "/AccountJsonRecord.txt", "w")
  if recordFile then
    for i = 0, fileGroup.Length - 1 do
      local jsonFileName = string.sub(fileGroup[i], string.find(fileGroup[i], "\\[^\\]*$") + 1)
      recordFile:write(jsonFileName .. "\n")
    end
    recordFile:close()
  end
  self:_OnClose()
end

function GmAccountJsonRenameView:_OnClose()
  self:Close()
end

return GmAccountJsonRenameView
