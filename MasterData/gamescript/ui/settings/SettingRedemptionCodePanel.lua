local typeof = _ENV.typeof
local InputField = CS.UnityEngine.UI.InputField
local SettingRedemptionCodePanel, Super = System.NewClass("SettingRedemptionCodePanel", UIBasePanel)
SettingRedemptionCodePanel.uiResCls = UI_Setting_Popup_CodeResource

function SettingRedemptionCodePanel:ctor()
  Super.ctor(self)
  self.inputText = Vue.ref("")
end

function SettingRedemptionCodePanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Paste, System.fn(self, self.OnPaste))
  binder:BindButtonClick(self.ui.Btn_Clean, System.fn(self, self.OnClean))
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnCancelClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("RedemptionCodePanelTitle")
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  binder:BindToVisible(self.ui.Btn_Paste, function()
    return not self.inputText.value or self.inputText.value == ""
  end)
  binder:BindToVisible(self.ui.Btn_Clean, function()
    return self.inputText.value and self.inputText.value ~= ""
  end)
  binder:BindToInputValueChange(self.ui.InputField_Account, function()
    local curStr = binder:GetInputText(self.ui.InputField_Account)
    curStr = self:BecomeLegalLenth(curStr)
    if self:IsLegalName(curStr) then
      self.inputText.value = curStr
    end
    self.ui.InputField_Account:GetComponent(typeof(InputField)).text = self.inputText.value
  end)
end

function SettingRedemptionCodePanel:OnPaste()
  local function pasteFunc()
    local pasteText = ""
    
    if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
      if not CS.Sirenix.Utilities.Editor.Clipboard:IsEmpty() then
        pasteText = CS.Sirenix.Utilities.Editor.Clipboard:Paste()
      end
    else
      pasteText = CS.UnityEngine.GUIUtility.systemCopyBuffer
    end
    if "" ~= pasteText and self.ui then
      pasteText = string.gsub(pasteText, " ", "")
      Logger.Debug("pasteText", pasteText)
      self.binder:SetInputText(self.ui.InputField_Account, pasteText)
    end
  end
  
  if SettingManager.Instance.firstRedemptionCode then
    Alert.Show(10558, function()
    end, pasteFunc)
    SettingManager.Instance.firstRedemptionCode = false
    return
  end
  pasteFunc()
end

function SettingRedemptionCodePanel:OnClean()
  self.binder:SetInputText(self.ui.InputField_Account, "")
end

function SettingRedemptionCodePanel:OnConfirmClick()
  if not self.inputText.value or self.inputText.value == "" then
    Alert.ShowStr(LT.Text("RedemptionTips_Empty"))
    return
  end
  for k = 1, #self.inputText.value do
    local c = string.byte(self.inputText.value, k)
    if not c then
      break
    end
    if 32 == c then
      Alert.Show(10804)
      return
    end
  end
  ProtoManager.Instance:ReqServer("GameRequest", "UseActiveCode", nil, function(_, code)
    local id = code.code
    local isSuccessFul = 200 == id
    local languageKey = "RedemptionTips_" .. id
    local showStr = LT.Text("RedemptionTips_other")
    if DT.LanguageConfig[languageKey] then
      showStr = LT.Text(languageKey)
    end
    Alert.ShowStr(showStr)
    if isSuccessFul then
      self.binder:SetInputText(self.ui.InputField_Account, "")
    end
  end, self.inputText.value)
end

function SettingRedemptionCodePanel:IsLegalName(newName)
  if not newName or "" == newName then
    return true
  end
  local isLegalName = true
  local ss = {}
  for k = 1, #newName do
    local c = string.byte(newName, k)
    if not c then
      break
    end
    if 32 == c or 45 == c or c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
      ss[#ss + 1] = string.char(c)
    elseif c >= 228 and c <= 233 then
      local c1 = string.byte(newName, k + 1)
      local c2 = string.byte(newName, k + 2)
      if c1 and c2 then
        local a1, a2, a3, a4 = 128, 191, 128, 191
        if 228 == c then
          a1 = 184
        elseif 233 == c then
          a2, a4 = 190, 190 ~= c1 and 191 or 165
        end
        if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
          k = k + 2
          ss[#ss + 1] = string.char(c, c1, c2)
        end
      end
    end
  end
  if #ss > 0 then
    local len = 0
    for k, v in pairs(ss) do
      len = len + #v
    end
    if #newName == len then
      isLegalName = true
    else
      isLegalName = false
    end
  else
    isLegalName = false
  end
  return isLegalName
end

function SettingRedemptionCodePanel:BecomeLegalLenth(newName)
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
    if charCount > 20 then
      break
    end
    returnName = returnName .. char
  end
  return returnName
end

function SettingRedemptionCodePanel:OnCancelClick()
  self:Close()
end

return SettingRedemptionCodePanel
