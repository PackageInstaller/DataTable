local DormRenameCtrl = class("DormRenameCtrl", BaseCtrl)
DormRenameCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  aniWindow = {
    sNodeName = "---Rename---",
    sComponentName = "Animator"
  },
  goWindow = {
    sNodeName = "---Rename---"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Rename"
  },
  txtOldName = {sComponentName = "TMP_Text"},
  txtNameDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_NameDesc"
  },
  txtHint2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_NameDesc"
  },
  txtCurName = {sComponentName = "TMP_Text"},
  inputRename = {
    sComponentName = "TMP_InputField"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Cancel"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Cancel"
  }
}
DormRenameCtrl._mapEventConfig = {}

function DormRenameCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function DormRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  NovaAPI.SetTMPText(self._mapNode.txtCurName, self.sCurName)
end

function DormRenameCtrl:PlayInAni()
  self._mapNode.goWindow:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DormRenameCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function DormRenameCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.DormRenamePanel)
end

function DormRenameCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nRoomId = tbParam[1]
  end
end

function DormRenameCtrl:OnEnable()
  local sec = ConfigTable.GetConfigNumber("DormNameResetTimeLimit")
  local day = math.ceil(sec / 86400)
  NovaAPI.SetTMPText(self._mapNode.txtHint2, orderedFormat(ConfigTable.GetUIText("Friend_Rename_TimeLimit"), day))
  self._mapNode.txtHint2.gameObject:SetActive(true)
  if self.nRoomId == 0 then
    local mapDormInfo = PlayerData.PlayerDormData:GetPlayerBaseInfo()
    if mapDormInfo ~= nil then
      self.sCurName = mapDormInfo.DormName
    end
    if self.sCurName == nil or self.sCurName == "" then
      self.sCurName = ConfigTable.GetUIText("Dorm_DefaultName")
    end
    NovaAPI.SetTMPText(self._mapNode.txtOldName, ConfigTable.GetUIText("Dorm_RenameDormTitle"))
    self:Open()
  else
    local function callback(mapDormInfo)
      if mapDormInfo ~= nil and mapDormInfo[self.nRoomId] ~= nil then
        self.sCurName = mapDormInfo[self.nRoomId].RoomName
      end
      if self.sCurName == nil or self.sCurName == "" then
        local mapRoomConfig = ConfigTable.GetData("DormRoom", self.nRoomId)
        if mapRoomConfig ~= nil then
          self.sCurName = mapRoomConfig.DefaultName
        end
      end
      self:Open()
    end
    
    NovaAPI.SetTMPText(self._mapNode.txtOldName, ConfigTable.GetUIText("Dorm_RenameRoomTitle"))
    PlayerData.PlayerDormData:GetRoomInfo(callback)
  end
end

function DormRenameCtrl:OnDisable()
end

function DormRenameCtrl:OnDestroy()
end

function DormRenameCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function DormRenameCtrl:OnBtnClick_Confirm(btn)
  local sNewName = NovaAPI.GetTMPInputFieldText(self._mapNode.inputRename)
  if sNewName == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BUILD_05"))
    return
  end
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  if NovaAPI.IsDirtyString(sNewName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_01"))
    return
  end
  
  local function callback()
    self:PlayOutAni()
  end
  
  PlayerData.PlayerDormData:RenameDorm(self.nRoomId, sNewName, callback)
end

return DormRenameCtrl
