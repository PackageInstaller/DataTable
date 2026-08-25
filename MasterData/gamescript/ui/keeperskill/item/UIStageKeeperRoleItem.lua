local UIStageKeeperRoleItem, Super = System.NewComponent("UIStageKeeperRoleItem")

function UIStageKeeperRoleItem:ctor(go, roleInfo, clickFunc)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Awaker_Head_NewResource(go)
  self.roleInfo = roleInfo
  self.clickFunc = clickFunc
end

function UIStageKeeperRoleItem:OnBind(binder)
  self.binder = binder
  self.binder:BindToRaw(function(_, percent)
    self.ui.Image_Skill:GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = percent
  end, function()
    local keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    local max_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100)
    if max_energy <= 0 then
      return 0
    end
    return keeper_energy / max_energy
  end)
  self.binder:BindToRaw(function(_, percent)
    self.ui.Image_Charge:GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = percent
  end, function()
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local max_keeper_energy_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy_per") or 0
    local keeper_energy = math.max(CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0, max_keeper_energy)
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    local skill_keeper_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100)
    local max_keeper_energy_overlay = max_keeper_energy * (1 + max_keeper_energy_per / 100) * (1 + keeper_energy_cost_per / 100)
    if keeper_energy - skill_keeper_energy <= 0 or max_keeper_energy_overlay - skill_keeper_energy <= 0 then
      return 0
    end
    return (keeper_energy - skill_keeper_energy) / (max_keeper_energy_overlay - skill_keeper_energy)
  end)
  self.binder:BindToRaw(function(childBinder, _)
    local newKeeperEnergy = self.roleInfo.keeper_energy()
    local foreProgressUi, backProgressUi
    local foreEnergyLevel = self:_GetKeeperSkillEnergyLevel(newKeeperEnergy)
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
      childBinder:SetImageSync(foreProgressUi, skillProgressInfo[foreEnergyLevel].progressImg)
      local foreImgProgress = foreProgressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
      local percent = self:_GetKeeperSkillCostPercent(newKeeperEnergy)
      foreImgProgress.fillAmount = percent
    end
    if backProgressUi then
      childBinder:SetImageSync(backProgressUi, skillProgressInfo[backEnergyLevel].progressImg)
      local backImgProgress = backProgressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
      backImgProgress.fillAmount = 1
    end
  end, function()
    local keeper_energy = self.roleInfo.keeper_energy()
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    return keeper_energy * 10000 + max_keeper_energy * 1000000 + keeper_energy_cost_per * 100
  end)
  self.binder:BindToImage(self.ui.Icon_Awaker, function()
    do return GenderDataUtils.GetBattleMainHeadRes end
    return GenderDataUtils.GetBattleMainHeadRes, self.roleInfo.gender
  end)
  self.binder:BindButtonClick(self.ui.Btn_Click, function()
    self:OpenKeeperRoleTips()
  end)
  binder:BindToRaw(function(_, maxValue)
    self:SetScalers(maxValue)
  end, function()
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
  end)
end

function UIStageKeeperRoleItem:_GetKeeperSkillOneRingCost()
  local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
end

function UIStageKeeperRoleItem:_GetKeeperSkillEnergyLevel(keeper_energy)
  local oneRingCost = self:_GetKeeperSkillOneRingCost()
  local rst = math.floor(keeper_energy / oneRingCost)
  rst = math.max(CommonDefine.KeeperSkillEnergyMinLevel, rst)
  rst = math.min(CommonDefine.KeeperSkillEnergyMaxLevel, rst)
  return rst
end

function UIStageKeeperRoleItem:_GetKeeperSkillCostPercent(keeper_energy)
  local oneRingCost = self:_GetKeeperSkillOneRingCost()
  if 0 == keeper_energy or 0 == oneRingCost then
    return 0
  end
  return keeper_energy % oneRingCost / oneRingCost
end

function UIStageKeeperRoleItem:OpenKeeperRoleTips()
  if self.clickFunc then
    self.clickFunc()
  else
    UIManager.Instance:Reopen(Urls.UIBattlePopupKeeperSkillTip, self.roleInfo)
  end
end

function UIStageKeeperRoleItem:SetScalers(maxValue)
  if not self.circleScaler then
    self.circleScaler = UICircularScaler(self.ui.Image_TickMarks, self.ui.CircularCenter, self.ui.CircularPoint)
  end
  local avgValue = DT.GetConstant("KeeperSkillScaleEnergy")
  self.circleScaler:Apply(avgValue, maxValue)
end

function UIStageKeeperRoleItem:OnUnbind()
  if self.circleScaler then
    self.circleScaler:Dispose()
    self.circleScaler = nil
  end
  Super.OnUnbind(self)
end

return UIStageKeeperRoleItem
