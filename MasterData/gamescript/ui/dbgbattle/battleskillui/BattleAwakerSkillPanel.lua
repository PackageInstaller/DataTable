local BattleAwakerSkillPanel, Super = System.NewClass("BattleAwakerSkillPanel", UIBasePanel)
BattleAwakerSkillPanel.uiResCls = UI_Battle_Popup_AngerResource
local Mathf = CS.UnityEngine.Mathf

function BattleAwakerSkillPanel:ctor(battleAwakerInfo, clickFunc)
  Super.ctor(self)
  self.battleAwakerInfo = battleAwakerInfo
  self.btnConfirmStyle = Vue.ref(CommonDefine.BtnType.High)
  self.clickFunc = clickFunc
  self.groupKeyWordShowed = Vue.ref(false)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleAwakerSkillPanel:OnBind(binder)
  self.binder = binder
  self:_OnBindShortCutComps(binder)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  binder:onDestroy(function()
    self.battleAwakerInfo = nil
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local confirmBtnTipsData = {
    clickFunc = self.clickFunc,
    stateFunc = function()
      return self.btnConfirmStyle.value
    end,
    text = LT.Text("UniversalConfirmButton")
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("UniversalCancelButton")
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_S, commonPopupConfirmTipsData))
  binder:BindToRaw(function(_, isEnabled, _)
    self.btnConfirmStyle.value = isEnabled and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    binder:SetImageColorByHtml(self.ui.Icon_Awaker, isEnabled and "#ffffff" or "#505050")
  end, function()
    local awakerDataModel = self.battleAwakerInfo:GetAwakerDataModel()
    local timesLimit = awakerDataModel:GetProperty(bc.BattleProperty.bout_ulti_times)
    local curTimes = awakerDataModel.boutSkillTimes or 0
    if timesLimit <= curTimes then
      return false
    end
    local proName = bc.BattleProperty.ulti_energy
    local ultiEnergy = awakerDataModel:GetProperty(proName)
    local canUseEnergy = self:_CalCanUseEnergy()
    if ultiEnergy < canUseEnergy then
      return false
    end
    return true
  end)
  local extraParam = {
    skillLevel = self.battleAwakerInfo:GetUltiSkillLevel(),
    awakerData = self.battleAwakerInfo:GetAwakerDataModel()
  }
  binder:BindToText(self.ui.Text_Tips, function()
    do return self._GetUltiSkillDesc end
    return self._GetUltiSkillDesc, self
  end, nil, nil, extraParam)
  binder:BindToRaw(function(_, v, _)
    self.ui.Group_Keyword:SetActive(v)
    self.ui.Button_Keyword:SetActive(v)
  end, function()
    return self.groupKeyWordShowed.value
  end)
  binder:BindZ1Button(self.ui.Button_Keyword, function()
    self.groupKeyWordShowed.value = false
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return self._GetSkillName end
    return self._GetSkillName, self
  end)
  self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
    self.battleAwakerInfo:GetUltiSkillDesc()
  }))
  self.ui.Group_Keyword:SetActive(false)
  binder:BindToRaw(function(_, coolingText, _)
    self.ui.Group_CD:SetActive(nil ~= coolingText)
    self.ui.Btn_Cancel:SetActive(nil == coolingText)
    self.ui.Btn_Confirm:SetActive(nil == coolingText)
    binder:SetText(self.ui.Text_C_Cooling, coolingText or "")
  end, function()
    do return self.GetCoolingText end
    return self.GetCoolingText, self
  end, false)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    local roleCfg = self:GetAwakerCfg()
    local curSkin = self.battleAwakerInfo:GetCurSkin()
    do return AwakerDataUtils.GetLittleIcon, roleCfg.ID, nil end
    return AwakerDataUtils.GetLittleIcon, roleCfg.ID, nil, curSkin
  end)
  binder:BindToText(self.ui.Text_Role, function()
    local roleCfg = self:GetAwakerCfg()
    return roleCfg and LT.Text(roleCfg.Name)
  end)
end

function BattleAwakerSkillPanel:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Confirm_ShortCut, "KeyConfirm", self.clickFunc, extraParam))
end

function BattleAwakerSkillPanel:_CalCanUseEnergy()
  local ulti_energy_cost_per = 0
  local ulti_energy_cost_flat = 0
  local ulti_energy_max = 0
  local ulti_energy_max_per = 0
  local awakerDataModel = self.battleAwakerInfo:GetAwakerDataModel()
  ulti_energy_cost_per = awakerDataModel:GetProperty("ulti_energy_cost_per") or 0
  ulti_energy_cost_flat = awakerDataModel:GetProperty("ulti_energy_cost_flat") or 0
  ulti_energy_max = awakerDataModel:GetProperty(bc.BattleProperty.ulti_energy_max) or 0
  ulti_energy_max_per = awakerDataModel:GetProperty(bc.BattleProperty.ulti_energy_max_per) or 0
  local energyNormalUltlSkillMax = Mathf.CeilToInt(ulti_energy_max * (1 + ulti_energy_cost_per / 100)) + ulti_energy_cost_flat
  local needEnergySuperUtlSkillMax = energyNormalUltlSkillMax * (1 + ulti_energy_max_per / 100)
  do return math.min, math.floor(energyNormalUltlSkillMax), math.floor(needEnergySuperUtlSkillMax) end
  return math.min, math.floor(energyNormalUltlSkillMax), math.floor(needEnergySuperUtlSkillMax)
end

function BattleAwakerSkillPanel:_GetSkillName()
  do return self.battleAwakerInfo.GetUltiSkillName end
  return self.battleAwakerInfo.GetUltiSkillName, self.battleAwakerInfo
end

function BattleAwakerSkillPanel:_GetUltiSkillDesc()
  do return self.battleAwakerInfo.GetUltiSkillDesc end
  return self.battleAwakerInfo.GetUltiSkillDesc, self.battleAwakerInfo
end

function BattleAwakerSkillPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleAwakerSkillPanel:GetAwakerCfg()
  local awakerData = self.battleAwakerInfo:GetAwakerDataModel()
  local roleCfg = DT.AwakerConfig[awakerData.tid]
  return roleCfg
end

function BattleAwakerSkillPanel:GetCoolingText()
  if bg.battleDataCenter:IsOpModeInspect() then
    do return LT.Text end
    return LT.Text, DT.TipsType[10616].Desc, 10616, nil, nil, nil
  end
  local awakerDataModel = self.battleAwakerInfo:GetAwakerDataModel()
  local timesLimit = awakerDataModel:GetProperty(bc.BattleProperty.bout_ulti_times)
  local curTimes = awakerDataModel.boutSkillTimes or 0
  if timesLimit <= curTimes then
    do return LT.Text end
    return LT.Text, DT.TipsType[10615].Desc, 10615
  end
  if awakerDataModel:IsUltiSkillSeal() then
    do return LT.Text end
    return LT.Text, DT.TipsType[10617].Desc, 10617
  end
end

function BattleAwakerSkillPanel:OnChangeBoutPhase()
  local boutMgr = bg.battleRender.boutMgr
  local camp = boutMgr:GetCamp()
  if camp == bc.BattleCamp.Camp1 then
    self:ReshowBtn()
  else
    self:ForbiddenBtn()
  end
end

function BattleAwakerSkillPanel:ForbiddenBtn()
  if self.ui then
    self.ui.Btn_Cancel:SetActive(false)
    self.ui.Btn_Confirm:SetActive(false)
    self.ui.Group_CD:SetActive(true)
  end
end

function BattleAwakerSkillPanel:ReshowBtn()
  if self.ui then
    self.ui.Btn_Cancel:SetActive(true)
    self.ui.Btn_Confirm:SetActive(true)
    self.ui.Group_CD:SetActive(false)
  end
end

return BattleAwakerSkillPanel
