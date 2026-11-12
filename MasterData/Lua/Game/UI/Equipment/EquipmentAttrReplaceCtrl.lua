local EquipmentAttrReplaceCtrl = class("EquipmentAttrReplaceCtrl", BaseCtrl)
EquipmentAttrReplaceCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Title_RollConfirm"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtReplaceName = {sComponentName = "TMP_Text"},
  txtPropertyBefore = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_AttrBefore"
  },
  goPropertyBefore = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  txtPropertyAfter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_AttrAfter"
  },
  goPropertyAfter = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  btnReplace = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Replace"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnReplace = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_ConfirmRollResult"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  }
}
EquipmentAttrReplaceCtrl._mapEventConfig = {}

function EquipmentAttrReplaceCtrl:Open(sName, mapEquipment, nCharId, nSlotId, nSelectGemIndex, callback)
  self.mapEquipment = mapEquipment
  self.nCharId = nCharId
  self.nSlotId = nSlotId
  self.nSelectGemIndex = nSelectGemIndex
  self.callback = callback
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Refresh(sName)
end

function EquipmentAttrReplaceCtrl:Refresh(sName)
  NovaAPI.SetTMPText(self._mapNode.txtReplaceName, sName)
  for i = 1, 4 do
    self._mapNode.goPropertyBefore[i]:SetProperty(self.mapEquipment.tbAffix[i], self.nCharId, false, self.mapEquipment.tbUpgradeCount[i])
    self._mapNode.goPropertyAfter[i]:SetProperty(self.mapEquipment.tbAlterAffix[i], self.nCharId, false, self.mapEquipment.tbAlterUpgradeCount[i])
  end
end

function EquipmentAttrReplaceCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentAttrReplaceCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function EquipmentAttrReplaceCtrl:Close()
  self._mapNode.window:SetActive(false)
  self._mapNode.blur:SetActive(false)
end

function EquipmentAttrReplaceCtrl:Awake()
  self._mapNode.window:SetActive(false)
end

function EquipmentAttrReplaceCtrl:OnEnable()
end

function EquipmentAttrReplaceCtrl:OnDisable()
end

function EquipmentAttrReplaceCtrl:OnDestroy()
end

function EquipmentAttrReplaceCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function EquipmentAttrReplaceCtrl:OnBtnClick_Replace()
  local function replace()
    local function callback()
      self:PlayOutAni()
      
      if self.callback then
        self.callback()
      end
    end
    
    PlayerData.Equipment:SendCharGemReplaceAttributeReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, callback)
  end
  
  local nAll = 0
  if self.mapEquipment.tbUpgradeCount then
    for _, v in ipairs(self.mapEquipment.tbUpgradeCount) do
      nAll = nAll + v
    end
  end
  local nAlterAll = 0
  if self.mapEquipment.tbAlterUpgradeCount then
    for _, v in ipairs(self.mapEquipment.tbAlterUpgradeCount) do
      nAlterAll = nAlterAll + v
    end
  end
  if nAlterAll == nAll then
    replace()
  else
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Equipment_ReplaceWarning_HasUpgrade"),
      callbackConfirmAfterClose = replace,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

return EquipmentAttrReplaceCtrl
