local SocialRenamePanel, Super = System.NewClass("SocialRenamePanel", UIBasePanel)
SocialRenamePanel.uiResCls = UI_Common_Popup_Tip_6Resource

function SocialRenamePanel:ctor(data)
  Super.ctor(self)
  self.data = data
  self.title = data.title
  self.tips = data.tips
  self.oriName = data.oriName
  self.confirmFunc = data.confirmFunc
  self.inputFieldDefaultStr = data.inputFieldDefaultStr
  local nameLength = DT.GetOriginalConstant("NameLengthRange")
  self.nameLengthMin = nameLength[1]
  self.nameLengthMax = nameLength[2]
  self.newName = self.oriName
end

function SocialRenamePanel:OnBind(binder)
  self.binder = binder
  self.binder:SetText(self.ui.Text_Tips, LT.Text(self.tips))
  self.binder:SetText(self.ui.Text_Placeholder, LT.Text(self.inputFieldDefaultStr))
  self.binder:SetInputText(self.ui.InputField_Account, LT.Text(self.oriName))
  self.binder:BindToInputValueChange(self.ui.InputField_Account, function(str)
    local subStr = StrUtils.SubStr(str, self.nameLengthMax)
    if subStr ~= str then
      self.binder:SetInputText(self.ui.InputField_Account, subStr)
    end
    self.newName = subStr
  end)
  self.binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if self.newName == "" then
      if self.confirmFunc then
        self.confirmFunc(self.newName, System.fn(self, self.Close))
      end
      return
    end
    if self.newName == self.oriName then
      Alert.Show(10628)
      return
    end
    if not StrUtils.IsCnJpAlphaNum(self.newName) then
      Alert.Show(10624)
      return
    end
    local length = StrUtils.GetCharLen(self.newName)
    if length < self.nameLengthMin or length > self.nameLengthMax then
      local tipCfg = DT.TipsType[10629]
      Alert.ShowStr(LT.Textf(tipCfg.Desc, self.nameLengthMin, self.nameLengthMax))
      return
    end
    if self.confirmFunc then
      self.confirmFunc(self.newName, System.fn(self, self.Close))
    end
  end)
  self.binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

return SocialRenamePanel
