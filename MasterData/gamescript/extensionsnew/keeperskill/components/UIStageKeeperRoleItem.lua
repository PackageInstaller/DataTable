local UIStageKeeperRoleItem, Super = NewViewComponent("UIStageKeeperRoleItem")

function UIStageKeeperRoleItem:ctor(uiNode, view, roleInfo, clickFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dbgcopy_Item_Awaker_Head_NewResource(uiNode)
  self._roleInfo = roleInfo
  self._clickFunc = clickFunc
  self._model = KeeperSkillModel.Instance
end

function UIStageKeeperRoleItem:OnEnterComponent()
  self:_RefreshImage()
  self:_OnKeeperSkillEnergyChanged()
end

function UIStageKeeperRoleItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnKeeperSkillEnergyChanged, self._OnKeeperSkillEnergyChanged, self)
end

function UIStageKeeperRoleItem:RegisterEvents()
  self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OpenKeeperRoleTips))
end

function UIStageKeeperRoleItem:OnExitComponent()
  if self._circleScaler then
    self._circleScaler:Dispose()
    self._circleScaler = nil
  end
  Super.OnExitComponent(self)
end

function UIStageKeeperRoleItem:_RefreshImage()
  local headRes = GenderDataUtils.GetBattleMainHeadRes(self._roleInfo.gender)
  self.binder:SetImage(self.ui.Icon_Awaker, headRes)
end

function UIStageKeeperRoleItem:_RefreshProgressUi()
  local newKeeperEnergy = self._roleInfo.keeper_energy()
  local foreProgressUi, backProgressUi
  local foreEnergyLevel = self._model:GetKeeperSkillEnergyLevel(newKeeperEnergy)
  local backEnergyLevel = foreEnergyLevel - 1
  if backEnergyLevel < CommonDefine.KeeperSkillEnergyLevel.Neg4 then
    self.ui.Image_Charge:SetActive(false)
    foreProgressUi = self.ui.Image_Skill
    backProgressUi = nil
  else
    self.ui.Image_Charge:SetActive(true)
    foreProgressUi = self.ui.Image_Charge
    backProgressUi = self.ui.Image_Skill
  end
  local skillProgressInfo = KeeperSkillUtils.GetKeeperSkillProgressInfo()
  if foreProgressUi then
    self.binder:SetImage(foreProgressUi, skillProgressInfo[foreEnergyLevel].progressImg)
    local foreImgProgress = foreProgressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
    local percent = self._model:GetKeeperSkillCostPercent(newKeeperEnergy)
    foreImgProgress.fillAmount = percent
  end
  if backProgressUi then
    self.binder:SetImage(backProgressUi, skillProgressInfo[backEnergyLevel].progressImg)
    local backImgProgress = backProgressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
    backImgProgress.fillAmount = 1
  end
end

function UIStageKeeperRoleItem:_OpenKeeperRoleTips()
  if self._clickFunc then
    self._clickFunc()
  else
    local keeperSkillController = KeeperSkillController.Instance
    keeperSkillController:OpenBattlePopupKeeperSkillTip(self._roleInfo)
  end
end

function UIStageKeeperRoleItem:_SetScalers(maxValue)
  if not self._circleScaler then
    self._circleScaler = UICircularScaler(self.ui.Image_TickMarks, self.ui.CircularCenter, self.ui.CircularPoint)
  end
  local avgValue = DT.GetConstant("KeeperSkillScaleEnergy")
  self._circleScaler:Apply(avgValue, maxValue)
end

function UIStageKeeperRoleItem:_OnKeeperSkillEnergyChanged()
  local percent = self._model:GetKeeperSkillPercent()
  self.ui.Image_Skill:GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = percent
  local chargePercent = self._model:GetKeeperChargePercent()
  self.ui.Image_Charge:GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = chargePercent
  self:_RefreshProgressUi()
  local oneRingCost = self._model:GetKeeperSkillOneRingCost()
  self:_SetScalers(oneRingCost)
end

return UIStageKeeperRoleItem
