local BattleKeeperSkillAwakeTips, Super = System.NewClass("BattleKeeperSkillAwakeTips", UIBasePanel)
BattleKeeperSkillAwakeTips.uiResCls = UI_Battle_Popup_KeyTokenAwakenResource

function BattleKeeperSkillAwakeTips:ctor(roleInfo)
  Super.ctor(self)
  self.roleInfo = roleInfo
end

function BattleKeeperSkillAwakeTips:OnBind(binder)
  self.binder = binder
  self:_OnRegisterBtnClick()
  self:_RefreshView()
end

function BattleKeeperSkillAwakeTips:OnUnbind()
  Super.OnUnbind(self)
end

function BattleKeeperSkillAwakeTips:_OnRegisterBtnClick()
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.Btn_Keeper_Skill, System.fn(self, self._OnClickKeeperSkill))
  self.binder:BindButtonClick(self.ui.Btn_KeyTokenNewChaos, System.fn(self, self._OnClickNewChaosSkill))
  self.binder:BindButtonClick(self.ui.Btn_KeyTokenAwaken, System.fn(self, self._OnClickKeeperAwake))
end

function BattleKeeperSkillAwakeTips:_OnClickKeeperSkill()
  if self:_CheckKeeperSkillInCD() then
    Alert.Show(10615)
    return
  end
  if not self:_CheckKeerperSkillEnergyEnough() then
    Alert.ShowStr(LT.Text("C15AFNotUseCard"))
    return
  end
  if not KeeperSkillUtils.CheckCanUseKeeperSkill() then
    return
  end
  if bg.battleDataCenter:IsNewChaosSchool() then
    KeeperSkillUtils.UseChaosType2Skill2()
  else
    KeeperSkillUtils.UseKeeperSkill()
  end
  self:Close()
end

function BattleKeeperSkillAwakeTips:_OnClickKeeperAwake()
  if self:_CheckKeeperAwakeInCD() then
    Alert.Show(10615)
    return
  end
  if not self:_CheckKeerperAwakeEnergyEnough() then
    Alert.ShowStr(LT.Text("C15AFNotUseCard"))
    return
  end
  KeeperSkillUtils.UseKeeperSkillAwake()
  self:Close()
end

function BattleKeeperSkillAwakeTips:_OnClickNewChaosSkill()
  if self:_CheckNewChaosSkillInCD() then
    Alert.Show(10615)
    return
  end
  if not self:_CheckNewChaosSkillEnergyEnough() then
    Alert.ShowStr(LT.Text("C15AFNotUseCard"))
    return
  end
  KeeperSkillUtils.UseChaosType2Skill()
  self:Close()
end

function BattleKeeperSkillAwakeTips:_RefreshView()
  self:_RefreshNewChaosGroup()
  self:_RefreshKeeperSkill()
  self:_RefreshKeeperAwake()
end

function BattleKeeperSkillAwakeTips:_RefreshNewChaosGroup()
  local isNewChaos = bg.battleDataCenter:IsNewChaosSchool()
  if self.ui.Group_KeyTokenNewChaos then
    self.binder:SetActive(self.ui.Group_KeyTokenNewChaos, isNewChaos)
  end
  if not isNewChaos then
    return
  end
  local isInCd = self:_CheckNewChaosSkillInCD()
  local isEnergyNotEnough = not self:_CheckNewChaosSkillEnergyEnough()
  if self.ui.Image_KeyTokenNewChaosLock then
    self.binder:SetActive(self.ui.Image_KeyTokenNewChaosLock, isInCd)
  end
  local btnState = (isEnergyNotEnough or isInCd) and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High
  self.binder:SetButtonState(self.ui.Btn_KeyTokenNewChaos, btnState)
  local newChaosSkillId = DT.GetConstant("ChaosType2Skill")
  if not newChaosSkillId then
    return
  end
  local skillCfg = SkillCfgUtils.GetCfg(newChaosSkillId)
  if not skillCfg then
    return
  end
  local newChaosSkillName = KeeperSkillUtils.GetSkillName(newChaosSkillId)
  local newChaosSkillDesc = KeeperSkillUtils.GetSkillDesc(newChaosSkillId, {})
  self.binder:SetText(self.ui.Txt_C_NewChaosTitle, newChaosSkillName)
  self.binder:SetText(self.ui.Text_KeyTokenNewChaos, newChaosSkillDesc)
  StrUtils.SetPreferredHeight(self.ui.Text_KeyTokenNewChaos)
end

function BattleKeeperSkillAwakeTips:_RefreshKeeperSkillIconDisplay(isNewChaos, keeperSkillIcon)
  if self.ui.Image_KeyToken_NewChaos then
    self.binder:SetActive(self.ui.Image_KeyToken_NewChaos, isNewChaos)
  end
  if self.ui.Image_Keeper_Skill then
    self.binder:SetActive(self.ui.Image_Keeper_Skill, not isNewChaos)
    if not isNewChaos then
      self.binder:SetImage(self.ui.Image_Keeper_Skill, keeperSkillIcon)
    end
  end
end

function BattleKeeperSkillAwakeTips:_RefreshKeeperSkill()
  local isInCd = self:_CheckKeeperSkillInCD()
  local isEnergyNotEnough = not self:_CheckKeerperSkillEnergyEnough()
  self.binder:SetActive(self.ui.Image_KeyTokenLock, isInCd)
  local btnState = (isEnergyNotEnough or isInCd) and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High
  self.binder:SetButtonState(self.ui.Btn_Keeper_Skill, btnState)
  local keeperSkillId, keeperSkillDesc, keeperSKillIcon
  local isNewChaos = bg.battleDataCenter:IsNewChaosSchool()
  if isNewChaos then
    keeperSkillId = DT.GetConstant("ChaosType2Skill2")
    if not keeperSkillId then
      return
    end
    keeperSkillDesc = KeeperSkillUtils.GetSkillDesc(keeperSkillId, {})
    keeperSKillIcon = KeeperSkillUtils.GetSkillIcon(keeperSkillId)
  else
    keeperSkillId = bg.battleDataCenter:GetPlayerKeeperSkill()
    if not keeperSkillId then
      return
    end
    local keeperSkillArgs = self.roleInfo.GetKeeperSkillArgs and self.roleInfo.GetKeeperSkillArgs() or self.roleInfo.keeperSkillArgs
    keeperSkillDesc = KeeperSkillUtils.GetKeeperSkillDesc(keeperSkillId, keeperSkillArgs)
    keeperSKillIcon = KeeperSkillUtils.GetSkillIcon(keeperSkillId)
  end
  local keeperSKillName = KeeperSkillUtils.GetSkillName(keeperSkillId)
  self.binder:SetText(self.ui.Txt_KetToken_Name, keeperSKillName)
  self.binder:SetText(self.ui.Text_KeyToken, keeperSkillDesc)
  StrUtils.SetPreferredHeight(self.ui.Text_KeyToken)
  self:_RefreshKeeperSkillIconDisplay(isNewChaos, keeperSKillIcon)
end

function BattleKeeperSkillAwakeTips:_RefreshKeeperAwake()
  if not bg.battleDataCenter:CheckKeeperSkillAwakeEnable() then
    self.binder:SetActive(self.ui.Group_KeyTokenAwaken, false)
    return
  end
  self.binder:SetActive(self.ui.Group_KeyTokenAwaken, true)
  local isInCd = self:_CheckKeeperAwakeInCD()
  local isEnergyNotEnough = not self:_CheckKeerperAwakeEnergyEnough()
  self.binder:SetActive(self.ui.Image_KeyTokenAwakenLock, isInCd)
  local btnState = (isEnergyNotEnough or isInCd) and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High
  self.binder:SetButtonState(self.ui.Btn_KeyTokenAwaken, btnState)
  local awakeSkillId = DT.GetConstant("SilverKeyAwakeSkill")
  if not awakeSkillId then
    return
  end
  local skillCfg = SkillCfgUtils.GetCfg(awakeSkillId)
  local keeperSKillName = LT.Text(skillCfg.Name)
  local keeperSkillDesc = KeeperSkillUtils.GetSkillDesc(awakeSkillId, bg.battleDataCenter:GetPlayerSilverKeyAwakeDescArgs())
  local keeperSKillIcon = skillCfg.Icon
  self.binder:SetText(self.ui.Text_KeyTokenAwaken, LT.Text(keeperSKillName) .. ":" .. LT.Text(keeperSkillDesc))
  StrUtils.SetPreferredHeight(self.ui.Text_KeyTokenAwaken)
  self.binder:SetImage(self.ui.Image_Keeper_Awake, keeperSKillIcon)
end

function BattleKeeperSkillAwakeTips:_CheckKeeperSkillInCD()
  if bg.battleDataCenter:IsNewChaosSchool() then
    do return bg.battleDataCenter.CheckChaosType2Skill2InCD end
    return bg.battleDataCenter.CheckChaosType2Skill2InCD, bg.battleDataCenter
  end
  do return bg.battleDataCenter.CheckKeeperSkillInCD end
  return bg.battleDataCenter.CheckKeeperSkillInCD, bg.battleDataCenter
end

function BattleKeeperSkillAwakeTips:_CheckKeeperAwakeInCD()
  do return bg.battleDataCenter.CheckKeeperAwakeInCD end
  return bg.battleDataCenter.CheckKeeperAwakeInCD, bg.battleDataCenter
end

function BattleKeeperSkillAwakeTips:_CheckKeerperSkillEnergyEnough()
  local energy = KeeperSkillUtils.GetKeeperEnergy()
  if bg.battleDataCenter:IsNewChaosSchool() then
    return energy >= 0
  end
  local cost = KeeperSkillUtils.GetCost()
  return energy >= cost
end

function BattleKeeperSkillAwakeTips:_CheckKeerperAwakeEnergyEnough()
  local cost = KeeperSkillUtils.GetCost()
  if not cost then
    return false
  end
  local energy = KeeperSkillUtils.GetKeeperEnergy()
  return cost <= energy
end

function BattleKeeperSkillAwakeTips:_CheckNewChaosSkillInCD()
  do return bg.battleDataCenter.CheckChaosType2SkillInCD end
  return bg.battleDataCenter.CheckChaosType2SkillInCD, bg.battleDataCenter
end

function BattleKeeperSkillAwakeTips:_CheckNewChaosSkillEnergyEnough()
  local cost = KeeperSkillUtils.GetCost()
  if not cost then
    return false
  end
  local energy = KeeperSkillUtils.GetKeeperEnergy()
  return cost <= energy
end

return BattleKeeperSkillAwakeTips
