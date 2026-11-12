local StarTowerAutoDecisionRenameCtrl = class("StarTowerAutoDecisionRenameCtrl", BaseCtrl)
StarTowerAutoDecisionRenameCtrl._mapNodeConfig = {
  blur = {sNodeName = "blurRename"},
  aniBlur = {sNodeName = "blurRename", sComponentName = "Animator"},
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
  txtOldName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_OldName"
  },
  txtNameDesc = {
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
StarTowerAutoDecisionRenameCtrl._mapEventConfig = {}

function StarTowerAutoDecisionRenameCtrl:Open(mapPlan, callback)
  self.gameObject:SetActive(true)
  self.mapPlan = mapPlan
  self.sCurName = mapPlan.sName
  self.callback = callback
  self:Refresh()
  self:PlayInAni()
end

function StarTowerAutoDecisionRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  if self.sCurName ~= nil and self.sCurName ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtCurName, self.sCurName)
  elseif self.mapPlan.sName == "" or self.mapPlan.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtCurName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtCurName, self.mapPlan.sName)
  end
end

function StarTowerAutoDecisionRenameCtrl:PlayInAni()
  self._mapNode.goWindow:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function StarTowerAutoDecisionRenameCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function StarTowerAutoDecisionRenameCtrl:Close()
  self.gameObject:SetActive(false)
end

function StarTowerAutoDecisionRenameCtrl:Awake()
end

function StarTowerAutoDecisionRenameCtrl:OnEnable()
end

function StarTowerAutoDecisionRenameCtrl:OnDisable()
end

function StarTowerAutoDecisionRenameCtrl:OnDestroy()
end

function StarTowerAutoDecisionRenameCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function StarTowerAutoDecisionRenameCtrl:OnBtnClick_Confirm(btn)
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
  if self.bSkip then
    self:PlayOutAni()
    if self.callback then
      self.callback(sNewName)
    end
  else
    local nPlanId = self.mapPlan.nPlanId or self.mapPlan.Id
    PlayerData.StarTowerAutoPlan:SendRenamePlan(nPlanId, sNewName, function()
      self.mapPlan.sName = sNewName
      if self.callback then
        self.callback(sNewName)
      end
      self:PlayOutAni()
    end)
  end
end

return StarTowerAutoDecisionRenameCtrl
