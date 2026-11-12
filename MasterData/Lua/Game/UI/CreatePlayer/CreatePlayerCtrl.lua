local CreatePlayerCtrl = class("CreatePlayerCtrl", BaseCtrl)
local PlayerBaseData = PlayerData.Base
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
CreatePlayerCtrl._mapNodeConfig = {
  cgStart = {
    sNodeName = "--start--",
    sComponentName = "CanvasGroup"
  },
  btn_LeftStart = {
    sComponentName = "NaviButton",
    callback = "OnBtn_LeftStart",
    sAction = "LeftPage"
  },
  btn_RightStart = {
    sComponentName = "NaviButton",
    callback = "OnBtn_RightStart",
    sAction = "RightPage"
  },
  StartTip = {
    sNodeName = "InfoStart",
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_Start"
  },
  cgSelect = {
    sNodeName = "--select--",
    sComponentName = "CanvasGroup"
  },
  animator_select = {sNodeName = "--select--", sComponentName = "Animator"},
  btn_LeftSelect = {
    sComponentName = "NaviButton",
    callback = "OnBtn_LeftSelect",
    sAction = "LeftPage"
  },
  btn_RightSelect = {
    sComponentName = "NaviButton",
    callback = "OnBtn_RightSelect",
    sAction = "RightPage"
  },
  SelectTip = {
    sNodeName = "InfoSelect",
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_Select"
  },
  btn_Select = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Select",
    sAction = "CreatePlayerConfirm"
  },
  tbRawImg = {
    sNodeName = "CreatePlayerBG",
    sComponentName = "RawImage"
  },
  tbOffscreenRenderer = {
    sNodeName = "offscreen_renderer_1",
    sComponentName = "Transform"
  },
  tbCamera = {sNodeName = "Camera_1", sComponentName = "Camera"},
  trL2D_Root_1 = {sComponentName = "Transform"},
  cgSetName = {
    sNodeName = "--set_name--",
    sComponentName = "CanvasGroup"
  },
  btn_Back = {sComponentName = "UIButton", callback = "OnBtn_Back"},
  txtPlsInputName = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_InputName"
  },
  txtNameTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_NameTips"
  },
  input_PlayerName = {
    sComponentName = "TMP_InputField"
  },
  ChangeNameTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_ChangeNameTips"
  },
  btn_ConfirmName = {
    sComponentName = "UIButton",
    callback = "OnBtn_ConfirmName"
  },
  txtBtnConfirmName = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_BtnConfim"
  },
  cgConfirmName = {
    sNodeName = "--confirm_name--",
    sComponentName = "CanvasGroup"
  },
  goSnapshot = {sNodeName = "snapshot"},
  btnBgClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_CloseConfirmWin"
  },
  goConfirmWindow = {sNodeName = "t_window"},
  animator_ConfirmWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_WinTitle"
  },
  txtWinContent = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_WinContent"
  },
  txtWinTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_WinTip"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_CloseConfirmWin"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtn_CloseConfirmWin"
  },
  txtCancelBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_WinBtnCancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtn_ConfirmNameSendMsg"
  },
  txtConfirmBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "CreatePlayer_WinBtnConfirm"
  }
}
CreatePlayerCtrl._mapEventConfig = {}
local MALE = 1
local FEMALE = 2
local START = 1
local SELECT = 2
local SET_NAME = 3

function CreatePlayerCtrl:Awake()
  self._animator = self.gameObject:GetComponent("Animator")
  local _nScale = 1 / Settings.CANVAS_SCALE
  local _v3Scale = Vector3(_nScale, _nScale, _nScale)
  self._mapNode.tbOffscreenRenderer.localScale = _v3Scale
  local n = math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
  self.tbRT = GameUIUtils.GenerateRenderTextureFor2D(n, n)
  self.tbRT.name = "CreatePlayer"
  self._mapNode.tbCamera.targetTexture = self.tbRT
  NovaAPI.SetTexture(self._mapNode.tbRawImg, self.tbRT)
  self:CreateL2DInstance()
  NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim1, "createplayer1_F_idle", true, true)
  NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim1, "createplayer1_M_idle", true, true)
  NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_ready", true, true)
  NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_ready", true, true)
  self._mapNode.tbCamera.enabled = false
  self.bIdCreateCharacter = false
  self.sex = 0
  self.selected = false
  self.state = 0
  self:timerCallback_HideConfirmName()
end

function CreatePlayerCtrl:OnEnable()
  EventManager.Add("OnEscCallback", self, self.OnEvent_OnEscCallback)
  self._mapNode.tbCamera.enabled = true
  self:SetCanvasGroup(self._mapNode.cgStart, true)
  self:SetCanvasGroup(self._mapNode.cgSelect, false)
  self:SetCanvasGroup(self._mapNode.cgSetName, false)
  self:SetCanvasGroup(self._mapNode.cgConfirmName, false)
  self:AddTimer(1, 0.5, "timerCallback_enable_DONE", true, true, true)
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("CreatePlayerCtrl", self.tbGamepadUINode)
end

function CreatePlayerCtrl:timerCallback_enable_DONE()
  self.goInsFemaleAnim2.localScale = Vector3(1, 1, 1)
  self.goInsMaleAnim2.localScale = Vector3(1, 1, 1)
  self.state = START
end

function CreatePlayerCtrl:OnDisable()
  if not self.bSkipGamepadDisable then
    GamepadUIManager.DisableGamepadUI("CreatePlayerCtrl")
    GamepadUIManager.QuitAdventure()
  end
  EventManager.Remove("OnEscCallback", self, self.OnEvent_OnEscCallback)
  self._mapNode.tbCamera.targetTexture = nil
  NovaAPI.SetTexture(self._mapNode.tbRawImg, nil)
  GameUIUtils.ReleaseRenderTexture(self.tbRT)
  self.tbRT = nil
end

function CreatePlayerCtrl:OnDestroy()
end

function CreatePlayerCtrl:OnBtn_LeftStart(btn)
  if self.state ~= START then
    return
  end
  self:SetCanvasGroup(self._mapNode.cgStart, false)
  self.goInsAnim1Ctrl:Play("createplayer_L_in")
  NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_in", false, true)
  self.sex = MALE
  self:AddTimer(1, 0.7, "timerCallback_start_DONE", true, true, true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_creation_enter")
end

function CreatePlayerCtrl:OnBtn_RightStart(btn)
  if self.state ~= START then
    return
  end
  self:SetCanvasGroup(self._mapNode.cgStart, false)
  self.goInsAnim1Ctrl:Play("createplayer_R_in")
  NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_in", false, true)
  self.sex = FEMALE
  self:AddTimer(1, 1, "timerCallback_start_DONE", true, true, true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_creation_enter")
end

function CreatePlayerCtrl:timerCallback_start_DONE()
  self.state = SELECT
  self:SetCanvasGroup(self._mapNode.cgSelect, true)
  self._mapNode.animator_select:Play("CreatePlayerUI_select")
end

function CreatePlayerCtrl:OnBtn_LeftSelect(btn)
  if self.state ~= SELECT or self.selecting or self.selected then
    return
  end
  self.selecting = true
  self.goInsAnim1Ctrl:Play("createplayer_L_switch")
  if self.sex == MALE then
    self.sex = FEMALE
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_leftin", false, true)
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_leftout", false, true)
  elseif self.sex == FEMALE then
    self.sex = MALE
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_leftout", false, true)
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_leftin", false, true)
  end
  self:SetCanvasGroup(self._mapNode.cgSelect, false)
  self:AddTimer(1, 1, "timerCallback_selecting_DONE", true, true, true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_creation_switch")
end

function CreatePlayerCtrl:OnBtn_RightSelect(btn)
  if self.state ~= SELECT or self.selecting or self.selected then
    return
  end
  self.selecting = true
  self.goInsAnim1Ctrl:Play("createplayer_R_switch")
  if self.sex == MALE then
    self.sex = FEMALE
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_rightin", false, true)
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_rightout", false, true)
  elseif self.sex == FEMALE then
    self.sex = MALE
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_rightout", false, true)
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_rightin", false, true)
  end
  self:SetCanvasGroup(self._mapNode.cgSelect, false)
  self:AddTimer(1, 1, "timerCallback_selecting_DONE", true, true, true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_creation_switch")
end

function CreatePlayerCtrl:timerCallback_selecting_DONE()
  self.selecting = false
  self:SetCanvasGroup(self._mapNode.cgSelect, true)
  self._mapNode.animator_select:Play("CreatePlayerUI_select")
end

function CreatePlayerCtrl:OnBtn_Select(btn)
  if self.state ~= SELECT or self.selecting or self.selected then
    return
  end
  self.selected = true
  NovaAPI.SetTMPInputFieldInteractable(self._mapNode.input_PlayerName, false)
  self:SetCanvasGroup(self._mapNode.cgSetName, true)
  self:SetCanvasGroup(self._mapNode.cgSelect, false)
  self.goInsAnim1Ctrl:Play("createplayer_oe")
  self._animator:Play("CreatePlayerUI_name_in")
  if self.sex == MALE then
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_t", false, true)
  elseif self.sex == FEMALE then
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_t", false, true)
  end
  self:AddTimer(1, 1, "timerCallback_selected_DONE", true, true, true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_creation_confrim")
end

function CreatePlayerCtrl:timerCallback_selected_DONE()
  self.state = SET_NAME
  NovaAPI.SetTMPInputFieldInteractable(self._mapNode.input_PlayerName, true)
  GamepadUIManager.EnableGamepadUI("CreatePlayerCtrl1", {}, nil, true)
end

function CreatePlayerCtrl:OnBtn_Back(btn)
  if self.state ~= SET_NAME or self.selected == false then
    return
  end
  self.selected = false
  self:SetCanvasGroup(self._mapNode.cgSetName, false)
  self.goInsAnim1Ctrl:Play("createplayer_oe_out")
  self._animator:Play("CreatePlayerUI_name_out")
  if self.sex == MALE then
    NovaAPIHotfix.PlayL2DAnim(self.goInsMaleAnim2, "createplayer2_M_out", false, true)
  elseif self.sex == FEMALE then
    NovaAPIHotfix.PlayL2DAnim(self.goInsFemaleAnim2, "createplayer2_F_out", false, true)
  end
  self:AddTimer(1, 0.6, "timerCallback_selectback_DONE", true, true, true)
end

function CreatePlayerCtrl:timerCallback_selectback_DONE()
  self.state = SELECT
  GamepadUIManager.DisableGamepadUI("CreatePlayerCtrl1")
  self:SetCanvasGroup(self._mapNode.cgSelect, true)
  self._mapNode.animator_select:Play("CreatePlayerUI_select")
end

function CreatePlayerCtrl:OnBtn_ConfirmName(btn)
  if self:CheckName(NovaAPI.GetTMPInputFieldText(self._mapNode.input_PlayerName)) == true then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    self._mapNode.goSnapshot:SetActive(true)
    self:AddTimer(1, 0.1, "timerCallback_ShowConfirmName", true, true, true)
  end
end

function CreatePlayerCtrl:timerCallback_ShowConfirmName()
  self:SetCanvasGroup(self._mapNode.cgConfirmName, true)
  self._mapNode.btnBgClose.gameObject:SetActive(true)
  self._mapNode.goConfirmWindow:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtWinContent, orderedFormat(ConfigTable.GetUIText("CreatePlayer_WinContent"), NovaAPI.GetTMPInputFieldText(self._mapNode.input_PlayerName)))
  self._mapNode.animator_ConfirmWindow:Play("t_window_04_t_in")
end

function CreatePlayerCtrl:OnBtn_CloseConfirmWin(btn)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:SetCanvasGroup(self._mapNode.cgConfirmName, false)
  self._mapNode.animator_ConfirmWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "timerCallback_HideConfirmName", true, true, true)
end

function CreatePlayerCtrl:timerCallback_HideConfirmName()
  self._mapNode.goSnapshot:SetActive(false)
  self._mapNode.btnBgClose.gameObject:SetActive(false)
  self._mapNode.goConfirmWindow:SetActive(false)
end

function CreatePlayerCtrl:OnBtn_ConfirmNameSendMsg(btn)
  local sName = NovaAPI.GetTMPInputFieldText(self._mapNode.input_PlayerName)
  if self:CheckName(sName) == true then
    self:SendMsgLogin(sName)
  end
end

function CreatePlayerCtrl:CheckName(sName)
  local nMaxlen = 14
  local nMinlen = 1
  local nMaxuftlen = 21
  local nMinuftlen = 1
  local nUtf8Len = string.utf8len(sName)
  local nLen = string.len(sName)
  if sName == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_04"))
    return
  end
  if nMaxlen < nUtf8Len or nMaxuftlen < nLen then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_02"))
    return
  end
  if nMinlen > nUtf8Len or nMinuftlen > nLen then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_06"))
    return
  end
  if not NovaAPI.IsChannelString(sName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_00"))
    return
  end
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  if NovaAPI.IsDirtyString(sName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_01"))
    return
  end
  if string.find(sName, "%d") == 1 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_05"))
    return
  end
  
  local function isFullWidthDigit(s)
    local firstChar = string.sub(s, 1)
    local code = UFT8ToUnicode(firstChar)
    return 65296 <= code and code <= 65305
  end
  
  if isFullWidthDigit(sName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_05"))
    return
  end
  return true
end

function CreatePlayerCtrl:SetCanvasGroup(cg, b, anim)
  if not anim then
    if b == true then
      NovaAPI.SetCanvasGroupAlpha(cg, 1)
    else
      NovaAPI.SetCanvasGroupAlpha(cg, 0)
    end
  end
  NovaAPI.SetCanvasGroupInteractable(cg, b == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(cg, b == true)
end

function CreatePlayerCtrl:CreateL2DInstance()
  self.goIns1 = self:CreatePrefabInstance("UI/CreatePlayer/L2D/createplayer_bg.prefab", self._mapNode.trL2D_Root_1)
  local nLayerIndex = CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4")
  self.goIns1.transform:SetLayerRecursively(nLayerIndex)
  local goInsAnim1 = self.goIns1.transform:Find("AnimRoot")
  self.goInsAnim1Ctrl = goInsAnim1:GetComponent("Animator")
  self.goInsFemaleAnim1 = goInsAnim1:Find("--3--/createplayer_F")
  self.goInsMaleAnim1 = goInsAnim1:Find("--3--/createplayer_M")
  self.goInsFemaleAnim2 = goInsAnim1:Find("--3--/createplayer2_F")
  self.goInsMaleAnim2 = goInsAnim1:Find("--3--/createplayer2_M")
end

function CreatePlayerCtrl:SendMsgLogin(sName)
  self.bFemale = false
  if self.sex == FEMALE then
    self.bFemale = true
  end
  local mapSendData = {}
  mapSendData.Nickname = sName
  mapSendData.Gender = self.bFemale ~= true
  
  local function func_Callback()
    HttpNetHandler.SetPingPong()
    self:OnServerReturn()
  end
  
  if AVG_EDITOR == true then
    self:OnServerReturn(sName)
  else
    HttpNetHandler.SendMsg(NetMsgId.Id.player_reg_req, mapSendData, nil, func_Callback)
  end
end

function CreatePlayerCtrl:OnServerReturn(sName)
  EventManager.Hit(EventId.UserEvent_CreateRole)
  EventManager.Hit("PrologueBattleArchive", nil, nil, nil, -1)
  if sName ~= nil and AVG_EDITOR == true then
    PlayerBaseData:SetPlayerSex(self.bFemale == false)
    PlayerBaseData:SetPlayerNickName(sName)
  end
  self:SetCanvasGroup(self._mapNode.cgConfirmName, false)
  self._mapNode.animator_ConfirmWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.5, "timerCallback_DONE", true, true, true)
end

function CreatePlayerCtrl:timerCallback_DONE()
  GamepadUIManager.DisableGamepadUI("CreatePlayerCtrl")
  GamepadUIManager.QuitAdventure()
  self.bSkipGamepadDisable = true
  self._mapNode.goSnapshot:SetActive(false)
  self._mapNode.btnBgClose.gameObject:SetActive(false)
  self._mapNode.goConfirmWindow:SetActive(false)
  self:SetCanvasGroup(self._mapNode.cgSetName, false)
  self.gameObject:SetActive(false)
  self._mapNode.tbCamera.enabled = false
  self.bCheckModule = true
  EventManager.Hit("CreatePlayerNextModule", self)
  if self.bCheckModule then
    PlayerData.StarTower:EnterTowerPrologue()
  end
  NovaAPI.SetBuglyPlayerUid(tostring(PlayerData.Base._nPlayerId))
end

function CreatePlayerCtrl:OnEvent_OnEscCallback()
  if not self.bIdCreateCharacter then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Login_QuitTips"),
    callbackConfirm = function()
      local UIGameSystemSetup = CS.UIGameSystemSetup
      UIGameSystemSetup.Instance:KillApplication()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return CreatePlayerCtrl
