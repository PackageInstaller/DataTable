local RenamePanel, Super = System.NewClass("RenamePanel", UIBasePanel)
RenamePanel.uiResCls = UI_Common_Popup_Tip_6Resource

function RenamePanel:ctor(model)
  Super.ctor(self)
  self.model = model
  self.newName = self.model:GetRoleName()
  self.nameLengthMin, self.nameLengthMax = StrUtils.GetNameLengthRange()
end

function RenamePanel:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Account)
  local sec = DT.GetConstant("NameChangeIntervalTime")
  self.binder:SetText(self.ui.Text_Tips, LT.Textf("NameChangeTips", math.floor(sec / 3600)))
  self.binder:SetInputText(self.ui.InputField_Account, self.newName)
  self.binder:BindToInputValueChange(self.ui.InputField_Account, function(str)
    local subStr = StrUtils.SubStr(str, self.nameLengthMax)
    if subStr ~= str then
      self.binder:SetInputText(self.ui.InputField_Account, subStr)
    end
    self.newName = subStr
  end)
  self.binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if UIUtils.IsHaveMissingCharacter(self.ui.Text_Account) then
      Alert.Show(10804)
      return
    end
    if self.newName == self.model:GetRoleName() then
      Alert.Show(10628)
      return
    end
    local length = StrUtils.GetCharLen(self.newName)
    if length < self.nameLengthMin or length > self.nameLengthMax then
      local tipCfg = DT.TipsType[10629]
      Alert.ShowStr(LT.Textf(tipCfg.Desc, self.nameLengthMin, self.nameLengthMax))
      return
    end
    local tipCfg = DT.TipsType[10621]
    local title = LT.Text(tipCfg.Title)
    local desc = LT.Textf(tipCfg.Desc, self.newName)
    Alert.SetShowAllLangFont(true)
    Alert.Show(10621, nil, function()
      self.model:RequestRename(self.newName, function()
        Alert.Show(10623)
        DataCenter.playerData.DRole.name = self.newName
        UIManager.Instance:CloseByUrl(Urls.RenamePanel)
      end)
    end, title, desc)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end)
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    maskClickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
end

return RenamePanel
