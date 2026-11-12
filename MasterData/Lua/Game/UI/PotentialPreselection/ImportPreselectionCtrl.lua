local ImportPreselectionCtrl = class("ImportPreselectionCtrl", BaseCtrl)
ImportPreselectionCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Import_Title"
  },
  txtCodeDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Import_Input"
  },
  input = {
    sComponentName = "TMP_InputField",
    callback = "OnValueChanged_Import"
  },
  btnClose = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnClose1 = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  animator = {
    sNodeName = "---Import---",
    sComponentName = "Animator"
  }
}
ImportPreselectionCtrl._mapEventConfig = {}

function ImportPreselectionCtrl:Refresh()
  NovaAPI.SetTMPInputFieldText(self._mapNode.input, "")
end

function ImportPreselectionCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function ImportPreselectionCtrl:PlayOutAni(callback)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function ImportPreselectionCtrl:ClosePanel()
  local function cb()
    EventManager.Hit(EventId.ClosePanel, PanelId.ImportPreselection)
  end
  
  self:PlayOutAni(cb)
end

function ImportPreselectionCtrl:Awake()
  self:Refresh()
  self:PlayInAni()
end

function ImportPreselectionCtrl:OnEnable()
end

function ImportPreselectionCtrl:OnDisable()
end

function ImportPreselectionCtrl:OnDestroy()
end

function ImportPreselectionCtrl:OnValueChanged_Import(_, sContent)
  if sContent == nil or sContent == "" then
    return
  end
  local sFiltered = string.gsub(sContent, "[^A-Za-z0-9+/=]", "")
  if sFiltered ~= sContent then
    NovaAPI.SetTMPInputFieldText(self._mapNode.input, sFiltered)
  end
end

function ImportPreselectionCtrl:OnBtnClick_Confirm(btn)
  local sCode = NovaAPI.GetTMPInputFieldText(self._mapNode.input)
  local tbPotential = PlayerData.PotentialPreselection:UnPackPotentialData(sCode)
  if tbPotential == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Import_Error"))
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Import_Suc"))
    self:ClosePanel()
    EventManager.Hit("RefreshPreselectionList")
  end
  
  local sName = ConfigTable.GetUIText("Potential_Preselection_Name_Init")
  local bPreference = false
  PlayerData.PotentialPreselection:SendImportPotential(sName, bPreference, tbPotential, callback)
end

return ImportPreselectionCtrl
