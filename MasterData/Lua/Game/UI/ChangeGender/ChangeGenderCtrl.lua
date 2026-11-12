local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local ChangeGenderCtrl = class("ChangeGenderCtrl", BaseCtrl)
local PlayerBaseData = PlayerData.Base
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
ChangeGenderCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  tbTrRole = {
    nCount = 2,
    sNodeName = "role_",
    sComponentName = "Transform"
  },
  animSwitchPlayer = {sNodeName = "FG", sComponentName = "Animator"},
  animChooseGender = {
    sNodeName = "--choose_gender--",
    sComponentName = "Animator"
  },
  tmp_notice = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChangeGender_Title"
  },
  tmp_female = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChangeGender_BtnFemale"
  },
  tmp_male = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChangeGender_BtnMale"
  },
  tmp_Confirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  imgSelectedBg1 = {sComponentName = "Image"},
  imgSelectedBg2 = {sComponentName = "Image"},
  btn_female = {
    sComponentName = "UIButton",
    callback = "OnBtn_Female"
  },
  btn_male = {sComponentName = "UIButton", callback = "OnBtn_Male"},
  btn_confirm = {
    sComponentName = "UIButton",
    callback = "OnBtn_Confirm"
  },
  animConfirmGender = {
    sNodeName = "--confirm_gender--",
    sComponentName = "Animator"
  },
  txtTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  txtTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  txtConfirmInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChangeGender_ConfirmText"
  },
  txtConfirmTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChangeGender_ConfirmTips"
  },
  tmpCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Cancel"
  },
  tmpConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  btnBgClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_Close"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtn_Close"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtn_ConfirmAgain"
  }
}
ChangeGenderCtrl._mapEventConfig = {}

function ChangeGenderCtrl:Awake()
  self.v3Invisible = Vector3.zero
  self.v3Visible = Vector3(100, 100, 100)
  if PlayerBaseData:GetPlayerSex() == true then
    self.bFemale = false
  else
    self.bFemale = true
  end
  Actor2DManager.PlayL2DAnim(self._mapNode.tbTrRole[1], "idle", true, true)
  Actor2DManager.PlayL2DAnim(self._mapNode.tbTrRole[2], "idle", true, true)
  self:_AnimChooseGender(true)
  self:_AnimSwitchGender(true)
end

function ChangeGenderCtrl:_AnimChooseGender(bIn)
  self._mapNode.animChooseGender:SetTrigger(bIn == true and "tIn" or "tOut")
end

function ChangeGenderCtrl:_AnimSwitchGender(bForce)
  self._mapNode.imgSelectedBg1.transform.localScale = self.bFemale == true and Vector3.one or Vector3.zero
  self._mapNode.imgSelectedBg2.transform.localScale = self.bFemale == true and Vector3.zero or Vector3.one
  if bForce == true then
    self:_DoSwitch()
  else
    WwiseAudioMgr:PlaySound("ui_charInfo_mirror")
    self._mapNode.animSwitchPlayer:SetTrigger("tPlay")
    self:AddTimer(1, 0.3, "_DoSwitch", true, true, true)
  end
end

function ChangeGenderCtrl:_DoSwitch()
  self._mapNode.tbTrRole[1].localScale = self.bFemale == true and self.v3Visible or self.v3Invisible
  self._mapNode.tbTrRole[2].localScale = self.bFemale == true and self.v3Invisible or self.v3Visible
end

function ChangeGenderCtrl:_AnimConfirmAgain(bIn)
  self._mapNode.animConfirmGender:SetTrigger(bIn == true and "tIn" or "tOut")
end

function ChangeGenderCtrl:OnBtn_Female(btn)
  if self.bFemale == true then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 1.2)
  self.bFemale = true
  self:_AnimSwitchGender()
end

function ChangeGenderCtrl:OnBtn_Male(btn)
  if self.bFemale == false then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 1.2)
  self.bFemale = false
  self:_AnimSwitchGender()
end

function ChangeGenderCtrl:OnBtn_Confirm(btn)
  if PlayerBaseData:GetPlayerSex() ~= self.bFemale then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ChangeGender_Same"))
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("ChangeGender_ConfirmText"),
    sContentSub = ConfigTable.GetUIText("ChangeGender_ConfirmTips"),
    callbackConfirm = function()
      local function func_cb()
        if PlayerBaseData:GetPlayerSex() == true then
          PlayerBaseData:SetPlayerSex(false)
          
          self.bFemale = true
        else
          PlayerBaseData:SetPlayerSex(true)
          self.bFemale = false
        end
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ChangeGender_Succ"))
      end
      
      HttpNetHandler.SendMsg(NetMsgId.Id.player_gender_edit_req, {}, nil, func_cb)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ChangeGenderCtrl:OnBtn_Close(btn)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  self:_AnimConfirmAgain(false)
end

function ChangeGenderCtrl:OnBtn_ConfirmAgain(btn)
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  self:_AnimConfirmAgain(false)
  
  local function func_cb()
    if PlayerBaseData:GetPlayerSex() == true then
      PlayerBaseData:SetPlayerSex(false)
      self.bFemale = true
    else
      PlayerBaseData:SetPlayerSex(true)
      self.bFemale = false
    end
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ChangeGender_Succ"))
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_gender_edit_req, {}, nil, func_cb)
end

return ChangeGenderCtrl
