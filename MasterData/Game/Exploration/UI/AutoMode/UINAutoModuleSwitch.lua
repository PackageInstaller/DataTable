local UINAutoModuleSwitch = class("UINAutoModuleSwitch", UIBaseNode)
local base = UIBaseNode

function UINAutoModuleSwitch:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_AutoModule, self, self.OnTogAutoModuleChanged)
  UIUtil.AddButtonListener(self.ui.btn_StartAuto, self, self.OnBtnStartAutoClicked)
  self.ui.color_DefaultAuto = self.ui.img_StartAuto.color
  self.__onRefreshAutoModeState = BindCallback(self, self.RefreshAutoModeState)
  MsgCenter:AddListener(eMsgEventId.OnRefreshAutoModeState, self.__onRefreshAutoModeState)
end

function UINAutoModuleSwitch:OnTogAutoModuleChanged()
  local enable = ExplorationManager.epCtrl.autoCtrl:IsEnableAutoMode()
  local value = not enable
  if enable then
    ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  else
    ExplorationManager.epCtrl.autoCtrl:EnableEpAutoMode()
  end
end

function UINAutoModuleSwitch:RefreshAutoModeState(value, isRunning)
  self.ui.tex_AutoON:SetActive(value)
  self.ui.tex_AutoOFF:SetActive(not value)
  self.ui.img_AudoSelect:SetIndex(value and 1 or 0)
  self.ui.btn_StartAuto.gameObject:SetActive(value)
  if isRunning then
    self.ui.img_StartAuto.color = self.ui.color_CloseAuto
    self.ui.tex_StartAuto:SetIndex(1)
  else
    self.ui.img_StartAuto.color = self.ui.color_DefaultAuto
    self.ui.tex_StartAuto:SetIndex(0)
  end
end

function UINAutoModuleSwitch:OnBtnStartAutoClicked()
  local modelOpen, isRunning = ExplorationManager.epCtrl.autoCtrl:StartOrStopEpAutoMode()
  self:RefreshAutoModeState(modelOpen, isRunning)
end

function UINAutoModuleSwitch:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnRefreshAutoModeState, self.__onRefreshAutoModeState)
end

return UINAutoModuleSwitch
