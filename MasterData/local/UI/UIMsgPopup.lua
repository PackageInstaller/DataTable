local Text = CS.UnityEngine.UI.Text
local GameObject = CS.UnityEngine.GameObject
local Z1Button = CS.Z1Client.Z1Button
local Z1ButtonState = CS.Z1Client.Z1ButtonState
local Languange = require("Lang.Language")
local UpdateUtils = require("UpdateUtils")
local Input = CS.UnityEngine.Input
local KC_Escape = CS.UnityEngine.KeyCode.Escape
local Application = CS.UnityEngine.Application
local RP_Android = CS.UnityEngine.RuntimePlatform.Android
local RP_WindowsEditor = CS.UnityEngine.RuntimePlatform.WindowsEditor
local UIMsgPopup = {}

function UIMsgPopup:Show(msg, errcode, okCallBack, okTxt, cancelCallBack, cancelTxt, title)
  print("UIMsgPopup:show", msg, errcode)
  local uiParent = GameObject.Find("UIRoot/SafeArea/PopUpRoot").transform
  self:_OnCreate(uiParent)
  self.isShown = true
  local rootTrans = self.rootNode.transform
  rootTrans:SetParent(uiParent)
  if errcode and tonumber(errcode) then
    errcode = tonumber(errcode)
    if errcode < 0 then
      msg = Languange.Text("网络繁忙，请稍后重试")
    end
    self.Text_Bottom.text = string.format(Languange.Text("错误码(%d)"), errcode)
  else
    self.Text_Bottom.text = ""
  end
  self.Text_Tips.text = Languange.GetSDKErrorCodeMsg(errcode, msg)
  self.Text_Title.text = title and Languange.Text(title) or Languange.Text("CommonTipsTitle")
  self.Text_Confirm_Name.text = Languange.Text(okTxt)
  self.okCallBack = okCallBack
  local isCancelTextValid = cancelTxt and "" ~= cancelTxt
  self.Btn_Cancel.gameObject:SetActive(nil ~= cancelCallBack and isCancelTextValid)
  self.Text_Cancel_Name.text = cancelTxt and Languange.Text(cancelTxt) or ""
  self.Btn_Cancel.BtnState = Z1ButtonState.Normal
  self.cancelCallBack = cancelCallBack
end

function UIMsgPopup:Hide()
  if not self.rootNode then
    return
  end
  self.isShown = false
  self.rootNode.transform:SetParent(nil)
  print("UIMsgPopup==================Hide")
end

function UIMsgPopup:HasShown()
  return self.isShown
end

function UIMsgPopup:_OnCreate(uiParent)
  if self.rootNode then
    return
  end
  self.rootNode = GameObject.Instantiate(CS.Framework.AssetLoadUtil.LoadGameObject("GameUpdate/Res/Popup_Tips_S.prefab"), uiParent)
  self.rootNode.name = "Popup_Tips"
  local rootTrans = self.rootNode.transform:Find("Group_Popup").transform
  self.Text_Tips = rootTrans:Find("Group_Content/Text_Tips"):GetComponent(typeof(Text))
  self.Text_Title = rootTrans:Find("Group_Bg/Group_Top/Text_Title"):GetComponent(typeof(Text))
  self.Text_Bottom = rootTrans:Find("Group_Content/Text_Bottom"):GetComponent(typeof(Text))
  self.Text_Cancel_Name = rootTrans:Find("Group_Button/Btn_Cancel/Text_Cancel_Name"):GetComponent(typeof(Text))
  self.Text_Confirm_Name = rootTrans:Find("Group_Button/Btn_Confirm/Text_Confirm_Name"):GetComponent(typeof(Text))
  self.Btn_Confirm = rootTrans:Find("Group_Button/Btn_Confirm"):GetComponent(typeof(Z1Button))
  self.Btn_Confirm.onClick:AddListener(UIMsgPopup.OnClickConfirm)
  self.Btn_Cancel = rootTrans:Find("Group_Button/Btn_Cancel"):GetComponent(typeof(Z1Button))
  self.Btn_Cancel.onClick:AddListener(UIMsgPopup.OnClickCancel)
  self:_UpdateLangFonts()
end

function UIMsgPopup:_UpdateLangFonts()
  if not self.Text_Tips then
    return
  end
  local cur_lang = Languange.cur_lang
  local font = UpdateUtils.GetLangFont(cur_lang)
  self.Text_Tips.font = font
  self.Text_Title.font = font
  self.Text_Bottom.font = font
  self.Text_Cancel_Name.font = font
  self.Text_Confirm_Name.font = font
end

function UIMsgPopup:OnUpdate()
  local supportGoBack = Application.platform == RP_Android or Application.platform == RP_WindowsEditor
  if supportGoBack and Input.GetKeyDown(KC_Escape) and self:HasShown() then
    UIMsgPopup.OnClickCancel()
  end
end

function UIMsgPopup:Destroy()
  self:Hide()
  if self.Btn_Confirm then
    self.Btn_Confirm.onClick:RemoveAllListeners()
  end
  if self.Btn_Cancel then
    self.Btn_Cancel.onClick:RemoveAllListeners()
  end
  if self.rootNode then
    GameObject.Destroy(self.rootNode)
  end
  self.rootNode = nil
  print("UIMsgPopup==================Destroy")
end

function UIMsgPopup.OnClickConfirm()
  print("UIMsgPopup==================OnClickConfirm")
  UIMsgPopup:Hide()
  if UIMsgPopup.okCallBack then
    UIMsgPopup.okCallBack()
  end
end

function UIMsgPopup.OnClickCancel()
  UIMsgPopup:Hide()
  if UIMsgPopup.cancelCallBack then
    UIMsgPopup.cancelCallBack()
  end
end

return UIMsgPopup
