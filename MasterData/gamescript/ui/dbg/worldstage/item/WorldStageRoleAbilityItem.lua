local WorldStageRoleAbilityItem, Super = System.NewComponent("WorldStageRoleAbilityItem")

function WorldStageRoleAbilityItem:ctor(res, awakerTid, stageRole, index, rootGo)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Awaker_Head_NewResource(res)
  self.awakerTid = awakerTid
  self.stageRole = stageRole
  self.abilityIndex = index
  self.rootGo = rootGo
  self.awakerInfoDataSource = WorldStageAwakerInfoDataSource(stageRole, awakerTid)
end

function WorldStageRoleAbilityItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, function()
    Logger.Info("点击角色技能按钮")
    self:ShowTips()
  end)
  local roleCfg = DT.AwakerConfig[self.awakerTid]
  if roleCfg and roleCfg.Item_LittleIcon then
    local littleIcon = AwakerDataUtils.GetLittleIcon(self.awakerTid, true)
    local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid) or AwakerDataUtils.GetAwakerData(self.awakerTid)
    local skinResNum = AwakerSkinUtils.GetSkinResNum(awakerData.curSkin)
    littleIcon = AwakerDataUtils.ReplaceSkinRes(littleIcon, self.awakerTid, skinResNum)
    binder:SetImage(self.ui.Icon_Awaker, littleIcon)
  end
  local imgProgress = self.ui.Image_Skill:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local Image_Charge = self.ui.Image_Charge:GetComponent(typeof(CS.UnityEngine.UI.Image))
  binder:BindToRaw(function(_, fillAmount, oldFillAmount)
    imgProgress.fillAmount = fillAmount[1]
    Image_Charge.fillAmount = fillAmount[2]
    self:_CheckPlayEnergyFX(oldFillAmount and oldFillAmount[1], fillAmount[1])
  end, function()
    local roleAttrs = self.stageRole.roleAttrsList[self.awakerTid]
    local energy = roleAttrs.ulti_energy or roleAttrs.ene_first or 0
    local params = {
      ulti_energy_max = roleAttrs.ulti_energy_max or 0,
      ulti_energy_cost_per = roleAttrs.ulti_energy_cost_per or 0,
      ulti_energy_cost_flat = roleAttrs.ulti_energy_cost_flat or 0,
      ulti_energy_max_per = roleAttrs.ulti_energy_max_per or 0
    }
    local energyNormalUltlSkillMax, needEnergySuperUtlSkillMax = BattleSkillUtils.CalcSkillManiacMax(params)
    local fillAmount = math.min(math.max(0, energy / energyNormalUltlSkillMax), 1)
    local fillAmountSuper = 0
    if energyNormalUltlSkillMax < needEnergySuperUtlSkillMax then
      fillAmountSuper = math.min(math.max(0, (energy - energyNormalUltlSkillMax) / (needEnergySuperUtlSkillMax - energyNormalUltlSkillMax)), 1)
    end
    return {fillAmount, fillAmountSuper}
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or not oVal then
      return
    end
    if nVal == CommonDefine.UltiEnergyPerSkill then
      AudioManager.Instance:PostSoundEvent("FIGHT_EXSKILL_MAX_NOTICE")
    end
  end, function()
    local roleAttrsList = self.stageRole.roleAttrsList
    local roleAttrs = roleAttrsList[self.awakerTid]
    local energy = roleAttrs.ulti_energy or roleAttrs.ene_first or 0
    return energy
  end)
  binder:BindToRaw(function()
    self:SetScalers()
  end, function()
    return {
      self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_cost_per,
      self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_max,
      self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_cost_flat,
      self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_max_per
    }
  end)
end

function WorldStageRoleAbilityItem:_CheckPlayEnergyFX(progressOld, progressNew)
  if not progressOld or not progressNew then
    self.ui.UI_Vx_UltiSkill_Activate05:SetActive(false)
    self.ui.UI_Vx_UltiSkill_Activate05:SetActive(false)
    return
  end
  if progressOld < progressNew then
    self.ui.UI_Vx_UltiSkill_Activate05:SetActive(false)
    self.ui.UI_Vx_UltiSkill_Activate05:SetActive(true)
    self.binder:BindTimer(0.5, 0, nil, function()
      self.ui.UI_Vx_UltiSkill_Activate05:SetActive(false)
    end)
  end
end

function WorldStageRoleAbilityItem:ShowTips()
  local model = self.binder:createModel(AwakerInfoModel, self.awakerInfoDataSource)
  UIManager.Instance:Reopen(Urls.CopiesAwakerInfoPanelNew, model)
end

function WorldStageRoleAbilityItem:CloseTips()
  if self.item then
    self.item.binder:teardown()
    self.item = nil
  end
end

function WorldStageRoleAbilityItem:SetScalers()
  if not self.circleScaler then
    self.circleScaler = UICircularScaler(self.ui.Image_TickMarks, self.ui.CircularCenter, self.ui.CircularPoint)
  end
  local avgValue = DT.GetConstant("UltiSkillScaleEnergy")
  local ulti_energy_cost_per = self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_cost_per or 0
  local ulti_energy_max = self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_max or 0
  local ulti_energy_cost_flat = self.stageRole.roleAttrsList[self.awakerTid].ulti_energy_cost_flat or 0
  local maxValue = ulti_energy_max * (1 + ulti_energy_cost_per / 100) + ulti_energy_cost_flat
  self.circleScaler:Apply(avgValue, maxValue)
end

function WorldStageRoleAbilityItem:OnUnbind()
  if self.circleScaler then
    self.circleScaler:Dispose()
    self.circleScaler = nil
  end
  Super.OnUnbind(self)
end

return WorldStageRoleAbilityItem
