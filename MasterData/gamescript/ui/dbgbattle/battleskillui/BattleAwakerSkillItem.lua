local UnityTime = CS.UnityEngine.Time
local lastClickUtlSkillTime = 0
local BP = bc.BattleProperty
local Animator = CS.UnityEngine.Animator
local DOTween = CS.DG.Tweening.DOTween
local _GetPos = CS.Framework.TransformUtil.GetPos
local _SetPos = CS.Framework.TransformUtil.SetPos
local _SetLocalEulerAngles = CS.Framework.TransformUtil.SetLocalEulerAngles
local imgProgressSpeed = 1.5
local BattleAwakerSkillItem, Super = System.NewComponent("BattleAwakerSkillItem")

function BattleAwakerSkillItem:ctor(res, ultiSkill, skillIndex)
  Super.ctor(self)
  self.ui = Item_Battle_AwakerSkill_1Resource(res)
  self.skillIndex = skillIndex
  self.ultiSkill = ultiSkill
  self._floatingTextIndex = 0
  self._floatingTextDelay = 0
  self.isInAvg = Vue.ref(false)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleAwakerSkillItem:OnBind(binder)
  self.binder = binder
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(self.ultiSkill.roleUid)
  self.awakerInfoDataSource = BattleAwakerInfoDataSource(roleDataModel)
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  self:BindAvgEvent()
  local DragGesture = CS.Z1Client.General.DragGesture
  local gesture = self.ui.Btn_Click:GetComponent(typeof(DragGesture))
  self.gesture = gesture
  self.gesture:onPointerUp("+", function()
    if self.shortPress then
      UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
      self.shortPress = nil
    end
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
    self.shortPress = nil
    self:ShowTips()
  end, function()
    self:OnClickAwakerHead()
  end, tonumber(DT.GetConstant("Role_Press_Time")))
  self:BindShortCut(binder)
  binder:SetText(self.ui.Text_Name, LT.Text(roleDataModel.configData.Name))
  local littleIcon = AwakerDataUtils.GetLittleIcon(roleDataModel.tid, true)
  littleIcon = bg.battleDataCenter:ReplaceSkinPath(littleIcon, roleDataModel.uid)
  binder:SetImage(self.ui.Icon_Awaker, littleIcon)
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  binder:BindToRaw(function(_, ultiEnergy, oldUltiEnergy)
    self:RefreshStatus()
    if nil ~= oldUltiEnergy and oldUltiEnergy < ultiEnergy then
      self:ShowFloatingText(ultiEnergy - oldUltiEnergy)
    end
    if ultiEnergy == bc.UltiEnergyPerSkill and roleDataModel.tid == DT.GetConstant("GuideAwaker") then
      EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideAwakerRage100, bg.battleRender.battleTid)
    end
    if ultiEnergy == bc.UltiEnergyPerSkill then
      AudioManager.Instance:PostSoundEvent("FIGHT_EXSKILL_MAX_NOTICE")
    end
  end, function()
    do return roleDataModel.GetProperty, roleDataModel end
    return roleDataModel.GetProperty, roleDataModel, BP.ulti_energy
  end, true)
  binder:BindToRaw(function(_, _)
  end, function()
    self:RefreshStatus()
  end)
  self.ui.Text_Energy:SetActive(false)
  binder:BindToRaw(function()
    self:SetScalers()
  end, function()
    local awakerDataModel = self.awakerInfoDataSource:GetAwakerDataModel()
    local ulti_energy_cost_per = awakerDataModel:GetProperty("ulti_energy_cost_per") or 0
    local ulti_energy_max = awakerDataModel:GetProperty("ulti_energy_max") or 0
    local ulti_energy_cost_flat = awakerDataModel:GetProperty("ulti_energy_cost_flat") or 0
    local ulti_energy_max_per = awakerDataModel:GetProperty("ulti_energy_max_per") or 0
    return {
      ulti_energy_cost_per,
      ulti_energy_max,
      ulti_energy_cost_flat,
      ulti_energy_max_per
    }
  end)
  self:_SetupUIEffectLayer()
end

function BattleAwakerSkillItem:_SetupUIEffectLayer()
  local uiLayer = bg.battleScene:GetUIEffectLayer()
  if not uiLayer then
    return
  end
  self._groupAwakerTrans = self.ui.Group_Awaker.transform
  self._groupMaxEnergyTrans = self.ui.Group_Max_Energy_Effect.transform
  self._groupMaxEnergyTrans:SetParent(uiLayer.transform, true)
  LateUpdateBeat.Instance:Add(self._OnLateUpdate, self)
end

function BattleAwakerSkillItem:_OnLateUpdate()
  local x, y, z = _GetPos(self._groupAwakerTrans, nil, nil, nil)
  _SetPos(self._groupMaxEnergyTrans, x, y, z)
end

function BattleAwakerSkillItem:OnUnbind()
  if self._groupMaxEnergyTrans then
    self._groupMaxEnergyTrans:SetParent(self._groupAwakerTrans, true)
  end
  LateUpdateBeat.Instance:Remove(self._OnLateUpdate, self)
  self:_StopDelayHideUltiSkill_Activate02()
  self:_StopDelayHideUltiSkillAppear()
  if self.circleScaler then
    self.circleScaler:Dispose()
    self.circleScaler = nil
  end
  if self.skillProgressTweener then
    self.skillProgressTweener:Kill(true)
    self.skillProgressTweener = nil
  end
  if self.superSkillProgressTweener then
    self.superSkillProgressTweener:Kill(true)
    self.superSkillProgressTweener = nil
  end
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleAwakerSkillItem:BindShortCut(binder)
  local uName = "KeyBurst" .. self.skillIndex
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, uName, function()
    self:OnClickAwakerHead()
  end))
end

function BattleAwakerSkillItem:OnClickAwakerHead()
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(self.ultiSkill.roleUid)
  Logger.Info("点击角色技能按钮Short")
  if not roleDataModel:IsUltiEnergyEnough() then
    self.shortPress = true
    self:ShowTips()
    return
  end
  self:PlayUltiSkill()
end

function BattleAwakerSkillItem:OnSettingShortCut(uName)
  if uName == self.shortCutUName then
    self:PlayUltiSkill()
  end
end

function BattleAwakerSkillItem:BindAvgEvent()
  self.binder:BindEvent(EventMgr.Instance.OnStoryStart, function()
    self.isInAvg.value = true
  end)
  self.binder:BindEvent(EventMgr.Instance.OnStoryEnd, function()
    self.isInAvg.value = false
  end)
end

function BattleAwakerSkillItem:ShowFloatingText(eneryNum)
  if not self.binder then
    return
  end
  local gap = 0.08
  self._floatingTextDelay = (self._floatingTextDelay or 0) + gap
  self.binder:BindTimer(self._floatingTextDelay, 0, nil, function()
    local floatingText = Pool.GetWithTag(RoleFloatingText, bc.FloatingTextType.UltiEnergy, bg.battleScene.factoryLayer)
    local text = "+" .. eneryNum
    local maxLayer = 4
    self._floatingTextIndex = (self._floatingTextIndex + 1) % maxLayer
    local index = self._floatingTextIndex
    local offsetX = 0
    local offsetY = -100.0 - index * 30
    local position = CS.UnityEngine.Vector2(offsetX, offsetY)
    floatingText:InitFloat(text, nil, self.ui.uiNode.transform, position)
    self._floatingTextDelay = math.max(0, (self._floatingTextDelay or 0) - gap)
  end)
end

function BattleAwakerSkillItem:RefreshStatus()
  self:_RefreshStatus()
end

function BattleAwakerSkillItem:_RefreshStatus()
  if not bg.battleDataCenter then
    return
  end
  if not self.ui or IsNil(self.ui.Image_Skill) then
    return
  end
  local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(self.ultiSkill.awakerUid)
  local energy = awakerDataModel:GetProperty(BP.ulti_energy)
  local params = {
    ulti_energy_max = awakerDataModel:GetProperty(BP.ulti_energy_max) or 0,
    ulti_energy_cost_per = awakerDataModel:GetProperty(BP.ulti_energy_cost_per) or 0,
    ulti_energy_cost_flat = awakerDataModel:GetProperty(BP.ulti_energy_cost_flat) or 0,
    ulti_energy_max_per = awakerDataModel:GetProperty(BP.ulti_energy_max_per) or 0
  }
  local energyNormalUltlSkillMax, needEnergySuperUtlSkillMax = BattleSkillUtils.CalcSkillManiacMax(params)
  self:_RefreshEnergyProgressBar(energy, energyNormalUltlSkillMax, needEnergySuperUtlSkillMax)
  local enabled = energy >= energyNormalUltlSkillMax
  local forceSuperEx = (awakerDataModel:GetProperty("ulti_skill_level_up") or 0) > 0
  local superEnabled = forceSuperEx and enabled or energy >= needEnergySuperUtlSkillMax and energyNormalUltlSkillMax < needEnergySuperUtlSkillMax
  local isInAvg = self.isInAvg.value
  local seal_ulti = awakerDataModel:GetProperty(BP.seal_ulti)
  local immue_seal_ulti = awakerDataModel:GetProperty(BP.immue_seal_ulti)
  local timesLimit = awakerDataModel:GetProperty(bc.BattleProperty.bout_ulti_times) or 0
  local curTimes = awakerDataModel.boutSkillTimes or 0
  if isInAvg then
    return
  end
  self.ui.handle:SetActive(not forceSuperEx and energy > energyNormalUltlSkillMax and energy < needEnergySuperUtlSkillMax)
  if seal_ulti and seal_ulti > 0 and (not immue_seal_ulti or 0 == immue_seal_ulti) then
    self.ui.Group_Ready:SetActive(false)
    self:ShowMaxEffect(false)
    self:ShowUltiSkillExEffect(false)
    self.ui.Text_CD:SetActive(false)
    self.ui.Text_C_Seal:SetActive(true)
  elseif enabled and timesLimit > curTimes then
    self.ui.Group_Ready:SetActive(true)
    self:ShowMaxEffect(not superEnabled)
    self:ShowUltiSkillExEffect(superEnabled)
    self.ui.Text_CD:SetActive(false)
    self.ui.Text_C_Seal:SetActive(false)
    AnimatorUtils.PlayState(self.animator, "Item_Battle_AwakerSkill_yty_vx")
  elseif timesLimit <= curTimes then
    self.ui.Group_Ready:SetActive(false)
    self:ShowMaxEffect(false)
    self:ShowUltiSkillExEffect(false)
    self.ui.Text_CD:SetActive(true)
    self.ui.Text_C_Seal:SetActive(false)
  else
    self.ui.Group_Ready:SetActive(false)
    self:ShowMaxEffect(false)
    self:ShowUltiSkillExEffect(false)
    self.ui.Text_CD:SetActive(false)
    self.ui.Text_C_Seal:SetActive(false)
  end
end

function BattleAwakerSkillItem:_RefreshEnergyProgressBar(energy, energyNormalUltlSkillMax, needEnergySuperUtlSkillMax)
  if self.skillProgressTweener then
    self.skillProgressTweener:Kill(true)
    self.skillProgressTweener = nil
  end
  if self.superSkillProgressTweener then
    self.superSkillProgressTweener:Kill(true)
    self.superSkillProgressTweener = nil
  end
  self.skillProgressTweener = self:_TweenProgressBar(self.ui.Image_Skill, energy, energyNormalUltlSkillMax)
  self.superSkillProgressTweener = self:_TweenProgressBar(self.ui.Image_Charge, energy - energyNormalUltlSkillMax, needEnergySuperUtlSkillMax - energyNormalUltlSkillMax, true)
end

function BattleAwakerSkillItem:_TweenProgressBar(imgBar, energy, needEnergy, isSuper, handle)
  local imgProgress = imgBar:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local to = 0 == needEnergy and 0 or math.min(math.max(0, energy / needEnergy), 1)
  local delta = to - imgProgress.fillAmount
  if 0 ~= delta then
    local skillProgressTweener = DOTween.To(function()
      return imgProgress.fillAmount
    end, function(percent)
      if isSuper and percent > imgProgress.fillAmount and percent >= 1 then
        AudioManager.Instance:PostSoundEvent("Play_NTC_Ft_SuperExSkill_Max")
      end
      if imgProgress.fillAmount ~= percent then
        imgProgress.fillAmount = percent
      end
      _SetLocalEulerAngles(self.ui.handle.transform, 0, 0, -360 * percent)
    end, to, math.abs(delta) / imgProgressSpeed, self)
    return skillProgressTweener
  end
end

function BattleAwakerSkillItem:ShowMaxEffect(isShow)
  self.ui.Image_Max_Effect:SetActive(isShow)
  self.ui.Vx_AwakerSkill_Max:SetActive(false)
  self.ui.UltiSkillAppear:SetActive(isShow)
  if isShow then
    self:_DelayHideUltiSkillAppear()
  else
    self:_StopDelayHideUltiSkillAppear()
  end
end

function BattleAwakerSkillItem:_StopDelayHideUltiSkillAppear()
  if self._delayHideUltiSkillAppearTimer then
    self.binder:StopTimer(self._delayHideUltiSkillAppearTimer)
    self._delayHideUltiSkillAppearTimer = nil
  end
end

function BattleAwakerSkillItem:_DelayHideUltiSkillAppear()
  if self._delayHideUltiSkillAppearTimer then
    return
  end
  self._delayHideUltiSkillAppearTimer = self.binder:BindTimer(1, 0, nil, function()
    if not IsNil(self.ui.UltiSkillAppear) then
      self.ui.UltiSkillAppear:SetActive(false)
      self:_StopDelayHideUltiSkillAppear()
    end
  end)
end

function BattleAwakerSkillItem:ShowUltiSkillExEffect(isShow)
  self.ui.UI_Vx_UltiSkill_Activate01:SetActive(isShow)
  self.ui.UI_Vx_UltiSkill_Activate02:SetActive(isShow)
  self.ui.Super_UltiSkillAppear:SetActive(isShow)
  if isShow then
    self:_DelayHideUltiSkill_Activate02()
  else
    self:_StopDelayHideUltiSkill_Activate02()
  end
end

function BattleAwakerSkillItem:_StopDelayHideUltiSkill_Activate02()
  if self._delayHideActivate02Timer then
    self.binder:StopTimer(self._delayHideActivate02Timer)
    self._delayHideActivate02Timer = nil
  end
end

function BattleAwakerSkillItem:_DelayHideUltiSkill_Activate02()
  if self._delayHideActivate02Timer then
    return
  end
  self._delayHideActivate02Timer = self.binder:BindTimer(1, 0, nil, function()
    if not IsNil(self.ui.UI_Vx_UltiSkill_Activate02) then
      self.ui.UI_Vx_UltiSkill_Activate02:SetActive(false)
    end
    if not IsNil(self.ui.Super_UltiSkillAppear) then
      self.ui.Super_UltiSkillAppear:SetActive(false)
    end
    self:_StopDelayHideUltiSkill_Activate02()
  end)
end

function BattleAwakerSkillItem:ShowTips()
  if UIManager.Instance:GetWindow(Urls.CopiesAwakerInfoPanelNew) then
    return
  end
  local model = self.binder:createModel(AwakerInfoModel, self.awakerInfoDataSource)
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
  UIManager.Instance:Show(Urls.CopiesAwakerInfoPanelNew, model)
end

function BattleAwakerSkillItem:PlayUltiSkill()
  if 0 ~= lastClickUtlSkillTime and UnityTime.unscaledTime - lastClickUtlSkillTime < 1.2 then
    return
  end
  if bg.battleRender:IsInSelectCard() then
    return
  end
  if bg.isReplay then
    return
  end
  local awakerDataModel = self.awakerInfoDataSource:GetAwakerDataModel()
  local ulti_energy_proName = bc.BattleProperty.ulti_energy
  local ultiEnergy = awakerDataModel:GetProperty(ulti_energy_proName)
  local params = {
    ulti_energy_max = awakerDataModel:GetProperty(BP.ulti_energy_max) or 0,
    ulti_energy_cost_per = awakerDataModel:GetProperty("ulti_energy_cost_per") or 0,
    ulti_energy_cost_flat = awakerDataModel:GetProperty("ulti_energy_cost_flat") or 0,
    ulti_energy_max_per = awakerDataModel:GetProperty(BP.ulti_energy_max_per) or 0
  }
  local energyNormalUltlSkillMax, needEnergySuperUtlSkillMax = BattleSkillUtils.CalcSkillManiacMax(params)
  local forceSuperEx = (awakerDataModel:GetProperty("ulti_skill_level_up") or 0) > 0
  local canUseNormalUlti = ultiEnergy >= energyNormalUltlSkillMax
  local shouldUseSuperEx = canUseNormalUlti and forceSuperEx or energyNormalUltlSkillMax < needEnergySuperUtlSkillMax and ultiEnergy >= needEnergySuperUtlSkillMax
  lastClickUtlSkillTime = UnityTime.unscaledTime
  
  local function clickFunc()
    if not bg.battleDataCenter:IsOpModePlay() then
      return
    end
    local proName = bc.BattleProperty.bout_ulti_times
    local timesLimit = awakerDataModel:GetProperty(proName)
    local curTimes = awakerDataModel.boutSkillTimes or 0
    if timesLimit <= curTimes then
      Alert.ShowStr(LT.Text("Battle_Cooldown"))
      return
    end
    if ultiEnergy >= energyNormalUltlSkillMax then
      bg.battleRender.ultiSkillMgr:UseUltiSkill(awakerDataModel.uid, awakerDataModel.uid)
      if awakerDataModel.tid == DT.GetConstant("GuideAwaker") then
        EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideAwakerUseSkill, bg.battleRender.battleTid)
      end
      EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondAfterUseUltiSkill, {
        bg.battleRender.battleTid,
        bg.battleRender.boutMgr:GetBoutNum()
      })
      UIManager.Instance:CloseByUrl(Urls.BattleAwakerSkillPanel)
      UIManager.Instance:CloseByUrl(Urls.BattleAwakerSuperSkillPanel)
    else
      Alert.Show(10490)
    end
    if shouldUseSuperEx then
      AudioManager.Instance:PostSoundEvent("Play_UI_Ft_Btn_SuperExSkillConfirm_Click")
    else
      AudioManager.Instance:PostSoundEvent("UI_FT_BTN_EXSKILLCONFIRM_CLICK")
    end
  end
  
  local isConfirm = SettingManager.Instance:GetBoolSettingData(CommonDefine.SettingUniqueName.UltiSkillConfirm)
  if isConfirm then
    if shouldUseSuperEx then
      UIManager.Instance:Reopen(Urls.BattleAwakerSuperSkillPanel, self.awakerInfoDataSource, clickFunc)
    else
      UIManager.Instance:Reopen(Urls.BattleAwakerSkillPanel, self.awakerInfoDataSource, clickFunc)
    end
  else
    clickFunc()
  end
end

function BattleAwakerSkillItem:CloseTips()
  if self.item then
    self.item.binder:teardown()
    self.item = nil
  end
end

function BattleAwakerSkillItem:ForbiddenClick(boolVal)
  self.ui.Btn_Click:SetActive(not boolVal)
  self.ui.Group_Max_Energy_Effect:SetActive(not boolVal)
end

function BattleAwakerSkillItem:SetScalers()
  if not self.circleScaler then
    self.circleScaler = UICircularScaler(self.ui.Image_TickMarks, self.ui.CircularCenter, self.ui.CircularPoint)
  end
  local avgValue = DT.GetConstant("UltiSkillScaleEnergy")
  local awakerDataModel = self.awakerInfoDataSource:GetAwakerDataModel()
  local ulti_energy_cost_per = awakerDataModel:GetProperty("ulti_energy_cost_per") or 0
  local ulti_energy_max = awakerDataModel:GetProperty("ulti_energy_max") or 0
  local ulti_energy_cost_flat = awakerDataModel:GetProperty("ulti_energy_cost_flat") or 0
  local maxValue = ulti_energy_max * (1 + ulti_energy_cost_per / 100) + ulti_energy_cost_flat
  self.circleScaler:Apply(avgValue, maxValue)
end

return BattleAwakerSkillItem
