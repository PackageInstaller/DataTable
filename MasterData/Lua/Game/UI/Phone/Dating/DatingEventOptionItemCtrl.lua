local DatingEventOptionItemCtrl = class("DatingEventOptionItemCtrl", BaseCtrl)
DatingEventOptionItemCtrl._mapNodeConfig = {
  btnOption = {},
  goOptionTip = {},
  OptionList = {
    sComponentName = "RectTransform"
  },
  txtSelection = {},
  txtSelectionDummy = {},
  txtOptionTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Dating_Option_Tip"
  }
}
DatingEventOptionItemCtrl._mapEventConfig = {
  DatingSelectOption = "OnEvent_DatingSelectOption"
}
DatingEventOptionItemCtrl._mapRedDotConfig = {}
local replace_str = "==DATING_CHARACTER=="

function DatingEventOptionItemCtrl:InitItem(data)
  self.data = data
  self.tbBtnCtrl = {}
  self._mapOptionDisplayText = {}
  local charCfg = ConfigTable.GetData_Character(self._panel.nCharId)
  for nId, mapOptData in pairs(self.data.tbOptions) do
    local goItem = instantiate(self._mapNode.btnOption, self._mapNode.OptionList)
    if goItem ~= nil then
      goItem.gameObject:SetActive(true)
      local btnComp = goItem.transform:GetComponent("UIButton")
      local func_Handler = ui_handler(self, self.OnBtnClick_Select, btnComp, mapOptData.nOptId)
      btnComp.onClick:AddListener(func_Handler)
      table.insert(self.tbBtnCtrl, btnComp)
      local txtOption = goItem.transform:Find("AnimRoot/txtOption"):GetComponent("TMP_Text")
      local sOpt = mapOptData.sOpt
      if charCfg ~= nil then
        sOpt = string.gsub(sOpt, replace_str, charCfg.Name)
      end
      self._mapOptionDisplayText[mapOptData.nOptId] = sOpt
      NovaAPI.SetTMPText(txtOption, sOpt)
      local imgAnimFavor = goItem.transform:Find("AnimRoot/imgBg_favor")
      local bSpecial = PlayerData.Dating:CheckSpecialOption(mapOptData.nOptId, self._panel.nCharId, self._panel.nLandmark)
      local bBranchB = self.data.nId.nType == GameEnum.DatingEventType.BranchB
      imgAnimFavor.gameObject:SetActive(bSpecial and bBranchB)
    end
  end
  self.txtSelection = instantiate(self._mapNode.txtSelection, self._mapNode.OptionList):GetComponent("TMP_Text")
  self.txtSelectionDummy = instantiate(self._mapNode.txtSelectionDummy, self._mapNode.OptionList):GetComponent("TMP_Text")
  self.txtSelectionDummy.gameObject:SetActive(true)
end

function DatingEventOptionItemCtrl:SelectDefault()
  self:OnBtnClick_Select(nil, self.data.tbOptions[1].nOptId)
end

function DatingEventOptionItemCtrl:OnBtnClick_Select(btn, nIndex)
  if self.bSelected then
    return
  end
  self.bSelected = true
  self._mapNode.goOptionTip.gameObject:SetActive(false)
  for k, mapOptData in pairs(self.data.tbOptions) do
    if mapOptData.nOptId == nIndex then
      local sOpt = self._mapOptionDisplayText[mapOptData.nOptId] or mapOptData.sOpt
      NovaAPI.SetTMPText(self.txtSelection, sOpt)
      NovaAPI.SetTMPText(self.txtSelectionDummy, sOpt)
      self.txtSelection.gameObject:SetActive(true)
      self.txtSelectionDummy.gameObject:SetActive(true)
      self.animator:Play("DatingPanel_EventSelectionItem_Select")
      self:AddTimer(1, 1, function()
        EventManager.Hit("DatingOptionSelected", nIndex)
      end, true, true, true)
    end
    self.tbBtnCtrl[k].gameObject:SetActive(false)
  end
end

function DatingEventOptionItemCtrl:StartEvent(nSpeed, bAuto)
  if bAuto then
    self:SelectDefault()
  end
end

function DatingEventOptionItemCtrl:ChangeSpeed(nSpeed)
end

function DatingEventOptionItemCtrl:FinishImmediately(bCancelAuto)
end

function DatingEventOptionItemCtrl:GetAuto()
  return false
end

function DatingEventOptionItemCtrl:GetBranch()
  return true
end

function DatingEventOptionItemCtrl:SkipTimer()
  self:SelectDefault()
end

function DatingEventOptionItemCtrl:Awake()
end

function DatingEventOptionItemCtrl:OnEnable()
  self.bSelected = false
  self.animator = self.gameObject:GetComponent("Animator")
end

function DatingEventOptionItemCtrl:OnDisable()
  if self.tbBtnCtrl ~= nil then
    for k, v in pairs(self.tbBtnCtrl) do
      v.onClick:RemoveAllListeners()
      v = nil
    end
    self.tbBtnCtrl = nil
  end
  self._mapOptionDisplayText = nil
end

return DatingEventOptionItemCtrl
