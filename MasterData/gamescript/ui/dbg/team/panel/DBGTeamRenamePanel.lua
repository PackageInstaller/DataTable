local typeof = _ENV.typeof
local InputField = CS.UnityEngine.UI.InputField
local NameCharLimitNum = DT.GetConstant("TeamNameCharacterLimit")
local DBGTeamRenamePanel, Super = System.NewClass("DBGTeamRenamePanel", UIBasePanel)
DBGTeamRenamePanel.uiResCls = UI_Team_Popup_Tip_ChangeNameResource

function DBGTeamRenamePanel:ctor(dbgTeamBuildModel, index)
  Super.ctor(self)
  self.model = dbgTeamBuildModel
  self.index = index
end

function DBGTeamRenamePanel:OnBind(binder)
  self.binder = binder
  self.confirmBtnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return self.confirmBtnState.value
    end,
    text = LT.Text("Formation_RenameTeam_Sure_Btn")
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnCancelClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("Formation_RenameTeam_Back_Btn")
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("Formation_RenameTeam_Title_String")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  binder:BindToText(self.ui.Placeholder, function()
    do return LT.Text end
    return LT.Text, "Formation_RenameTeam_Recommend_String"
  end)
  binder:BindToInputValueChange(self.ui.InputField_Name, function()
    local newName = self.binder:GetInputText(self.ui.InputField_Name)
    local clickShowTip = self:AnalyzeInPutName(newName)
    if type(clickShowTip) == "number" then
      self.confirmBtnState.value = CommonDefine.BtnType.Unclickable
    else
      self.confirmBtnState.value = CommonDefine.BtnType.High
    end
    newName = self:BecomeLegalLenth(newName)
    self.ui.InputField_Name:GetComponent(typeof(InputField)).text = newName
  end)
  self:BindOldName()
end

function DBGTeamRenamePanel:OnConfirmClick()
  local newName = self.binder:GetInputText(self.ui.InputField_Name)
  local clickShowTip = self:AnalyzeInPutName(newName)
  if type(clickShowTip) == "number" then
    Alert.Show(clickShowTip)
    return
  end
  newName = self:BecomeLegalLenth(newName)
  self:SaveNewTeamName(newName)
end

function DBGTeamRenamePanel:OnCancelClick()
  self:OnClose()
end

function DBGTeamRenamePanel:OnClose()
  self:Close()
end

function DBGTeamRenamePanel:AnalyzeInPutName(newName)
  if "" == newName then
    return 10528
  end
  local isLegalName = StrUtils.IsCnJpAlphaNum(newName)
  if false == isLegalName then
    return 10520
  end
  return ""
end

function DBGTeamRenamePanel:BecomeLegalLenth(newName)
  local lenInByte = #newName
  local charCount = 0
  local i = 1
  local returnName = ""
  while lenInByte >= i do
    local curByte = string.byte(newName, i)
    local byteCount = 1
    if curByte > 0 and curByte <= 127 then
      byteCount = 1
    elseif curByte >= 192 and curByte < 223 then
      byteCount = 2
    elseif curByte >= 224 and curByte < 239 then
      byteCount = 3
    elseif curByte >= 240 and curByte <= 247 then
      byteCount = 4
    end
    local char
    char = string.sub(newName, i, i + byteCount - 1)
    i = i + byteCount
    charCount = charCount + (1 == byteCount and 1 or 2)
    if charCount > NameCharLimitNum then
      break
    end
    returnName = returnName .. char
  end
  return returnName
end

function DBGTeamRenamePanel:SaveNewTeamName(newName)
  local updateTeamData = self.model:CreateUpdateTeamData(self.index, newName, self.model.allTeamList[self.index].awakerTidList, System.fn(self, self.OnClose))
  DBGTeamDataUtils.UpdateTeam(updateTeamData)
end

function DBGTeamRenamePanel:BindOldName()
  self.binder:BindToText(self.ui.Text_Old_Name, function()
    local teamName = DBGTeamDataUtils.GetDBGTeamName(self.model.teamType, self.index)
    do return string.format, "%s%s", (LT.Text("Formation_RenameTeam_CurrentTeam_String")) end
    return string.format, "%s%s", LT.Text("Formation_RenameTeam_CurrentTeam_String"), teamName
  end)
end

return DBGTeamRenamePanel
