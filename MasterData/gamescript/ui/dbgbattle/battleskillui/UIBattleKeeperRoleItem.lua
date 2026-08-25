local DOTween = CS.DG.Tweening.DOTween
local _GetPos = CS.Framework.TransformUtil.GetPos
local _SetPos = CS.Framework.TransformUtil.SetPos
local UIBattleKeeperRoleItem, Super = System.NewComponent("UIBattleKeeperRoleItem")

function UIBattleKeeperRoleItem:ctor(go, roleInfo, clickFunc)
  Super.ctor(self)
  self.ui = Item_Battle_AwakerSkill_1Resource(go)
  self.roleInfo = roleInfo
  self.clickFunc = clickFunc
  self.delayHandleEnergyChange = nil
  self.skillProgressTweener = nil
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function UIBattleKeeperRoleItem:OnUnbind()
  if self._groupMaxEnergyTrans then
    self._groupMaxEnergyTrans:SetParent(self._groupAwakerTrans, true)
  end
  LateUpdateBeat.Instance:Remove(self._OnLateUpdate, self)
  self:_HideAllMaxPartilePrefab()
  if self.circleScaler then
    self.circleScaler:Dispose()
    self.circleScaler = nil
  end
  self:ClearTweener()
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  Super.OnUnbind(self)
end

function UIBattleKeeperRoleItem:InitViewData()
  self.appearEffGoTimer = {}
  self.energyLevelInfoDict = {
    [CommonDefine.KeeperSkillEnergyLevel.Neg3] = {soundEvent = nil, particleGo = nil},
    [CommonDefine.KeeperSkillEnergyLevel.Neg2] = {soundEvent = nil, particleGo = nil},
    [CommonDefine.KeeperSkillEnergyLevel.Neg1] = {soundEvent = nil, particleGo = nil},
    [CommonDefine.KeeperSkillEnergyLevel.Pos0] = {soundEvent = nil, particleGo = nil},
    [CommonDefine.KeeperSkillEnergyLevel.Pos1] = {
      soundEvent = "Play_NTC_Ft_KPskill_Max",
      particleGo = self.ui.Image_KeeperSkill_Max,
      appearEffGo = self.ui.KeeperSkillAppear
    },
    [CommonDefine.KeeperSkillEnergyLevel.Pos2] = {
      soundEvent = "Play_NTC_Ft_KPskill_Max_2000",
      particleGo = self.ui.Vx_KeeperSkill_ExtraMax,
      appearEffGo = self.ui.Pos2KeeperSkillAppear
    },
    [CommonDefine.KeeperSkillEnergyLevel.Pos3] = {
      soundEvent = "Play_NTC_Ft_KPskill_Max_2000",
      particleGo = self.ui.Vx_KeeperSkill_ExtraMax,
      appearEffGo = self.ui.Pos2KeeperSkillAppear
    }
  }
end

function UIBattleKeeperRoleItem:OnBind(binder)
  self.binder = binder
  self:InitViewData()
  binder:BindToImage(self.ui.Icon_Awaker, function()
    do return GenderDataUtils.GetBattleMainHeadRes end
    return GenderDataUtils.GetBattleMainHeadRes, self.roleInfo.gender
  end)
  binder:BindToVisible(self.ui.Group_Ready, function()
    return self.roleInfo.isReady
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self._OnBtnLongPress), System.fn(self, self._OnBtnShortPress), 0.3)
  binder:BindToRaw(function(_, maxValue)
    self:SetScalers(maxValue)
  end, function()
    local keeper_energy_cost_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy_cost_per) or 0
    local max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy) or 0
    return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
  end)
  self:_OnBindProgress()
  self:_OnBindKeeperEnergyAdd()
  self:_OnBindShortCut(binder)
  self:_OnBindEvent()
end

function UIBattleKeeperRoleItem:_SetupUIEffectLayer()
  local uiLayer = bg.battleScene:GetUIEffectLayer()
  if not uiLayer then
    return
  end
  self._groupAwakerTrans = self.ui.Group_Awaker.transform
  self._groupMaxEnergyTrans = self.ui.Group_Max_Energy_Effect.transform
  self._groupMaxEnergyTrans:SetParent(uiLayer.transform, true)
  LateUpdateBeat.Instance:Add(self._OnLateUpdate, self)
end

function UIBattleKeeperRoleItem:_OnLateUpdate()
  local x, y, z = _GetPos(self._groupAwakerTrans, nil, nil, nil)
  _SetPos(self._groupMaxEnergyTrans, x, y, z)
end

function UIBattleKeeperRoleItem:_OnBindShortCut(binder)
  local uName = "KeyKeeperSkill"
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, uName, function()
    self:_OnBtnShortPress()
  end))
end

function UIBattleKeeperRoleItem:_OnBindKeeperEnergyAdd()
  self.binder:BindToRaw(function(_, keeper_energy, old_keeper_energy)
    if keeper_energy and old_keeper_energy and old_keeper_energy < keeper_energy then
      local floatingText = Pool.GetWithTag(RoleFloatingText, bc.FloatingTextType.UltiEnergy2, bg.battleScene.factoryLayer)
      local text = StrUtils.ParseEmojiNumber(keeper_energy - old_keeper_energy, "Number2")
      text = "<sprite=\"Number2\" index=10>" .. text
      local position = CS.UnityEngine.Vector2(125, 34.55)
      floatingText:InitFloat(text, nil, self.ui.uiNode.transform, position)
    end
  end, function()
    do return self._GetCurKeeperSkillEnergy end
    return self._GetCurKeeperSkillEnergy, self
  end)
end

function UIBattleKeeperRoleItem:_OnBindProgress()
  self.binder:BindToRaw(function(childBinder)
    local newKeeperEnergy = self:_GetCurKeeperSkillEnergy()
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
    end
    if backProgressUi then
      childBinder:SetImageSync(backProgressUi, skillProgressInfo[backEnergyLevel].progressImg)
      local backImgProgress = backProgressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
      backImgProgress.fillAmount = 1
    end
    local targetPercent = self:_GetKeeperSkillCostPercent(newKeeperEnergy)
    self:_PlayProgressAnim(targetPercent, foreProgressUi)
    self:RefreshMaxEffect()
  end, function()
    local curEnergy = self:_GetCurKeeperSkillEnergy()
    local costEnergy = self:_GetKeeperSkillOneRingCost()
    local max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy) or 0
    return curEnergy * 10000 + costEnergy + max_keeper_energy * 1000000
  end)
  self.binder:BindToVisible(self.ui.Text_CD, function()
    do return self._CheckInCD end
    return self._CheckInCD, self
  end)
  self.binder:BindToRaw(function(_, inCD)
    if not inCD then
      self:RefreshMaxEffect()
    end
  end, function()
    do return self._CheckInCD end
    return self._CheckInCD, self
  end)
end

function UIBattleKeeperRoleItem:_OnBindEvent()
  self.binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self._OnCloseUIPanel))
end

function UIBattleKeeperRoleItem:_OnCloseUIPanel(panelUrl)
  if not self.delayHandleChangeEnergy then
    return
  end
  if panelUrl == Urls.AvgDialogPanelNew then
    local to = self.delayHandleChangeEnergy
    self:_PlayProgressAnim(to, self.ui.Image_Skill)
    self.delayHandleChangeEnergy = nil
  end
end

function UIBattleKeeperRoleItem:_OnBtnLongPress()
  self:_OpenUIBattlePopupKeeperSkillTip()
end

function UIBattleKeeperRoleItem:_OnBtnShortPress()
  if self:_CheckInCD() then
    Alert.Show(10615)
    return
  end
  local energyLevel = self:_GetCurKeeperSkillEnergyLevel()
  if energyLevel >= CommonDefine.KeeperSkillEnergyLevel.Pos1 then
    if bg.isReplay then
      return
    end
    KeeperSkillUtils.OpenUseKeeperSkillConfirm(self.roleInfo)
  else
    self:_OpenUIBattlePopupKeeperSkillTip()
  end
end

function UIBattleKeeperRoleItem:_GetCurKeeperSkillEnergy()
  do return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter end
  return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter, bc.RoleProperty.keeper_energy
end

function UIBattleKeeperRoleItem:_GetKeeperSkillOneRingCost()
  local max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy) or 0
  local keeper_energy_cost_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy_cost_per) or 0
  return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
end

function UIBattleKeeperRoleItem:_GetKeeperSkillEnergyLevel(keeper_energy)
  local oneRingCost = self:_GetKeeperSkillOneRingCost()
  local rst = math.floor(keeper_energy / oneRingCost)
  rst = math.max(CommonDefine.KeeperSkillEnergyMinLevel, rst)
  rst = math.min(CommonDefine.KeeperSkillEnergyMaxLevel, rst)
  return rst
end

function UIBattleKeeperRoleItem:_GetKeeperSkillCostPercent(keeper_energy)
  local oneRingCost = self:_GetKeeperSkillOneRingCost()
  if 0 == keeper_energy or 0 == oneRingCost then
    return 0
  end
  return keeper_energy % oneRingCost / oneRingCost
end

function UIBattleKeeperRoleItem:_GetCurKeeperSkillEnergyLevel()
  do return self._GetKeeperSkillEnergyLevel, self, self:_GetCurKeeperSkillEnergy() end
  return self._GetKeeperSkillEnergyLevel, self, self:_GetCurKeeperSkillEnergy()
end

function UIBattleKeeperRoleItem:_CheckInCD()
  do return bg.battleDataCenter.CheckKeeperSkillAwakeInCD end
  return bg.battleDataCenter.CheckKeeperSkillAwakeInCD, bg.battleDataCenter
end

function UIBattleKeeperRoleItem:_OpenUIBattlePopupKeeperSkillTip()
  local keeperSkillController = KeeperSkillController.Instance
  keeperSkillController:OpenBattlePopupKeeperSkillTip(self.roleInfo)
end

function UIBattleKeeperRoleItem:SetScalers(maxValue)
  if not self.circleScaler then
    self.circleScaler = UICircularScaler(self.ui.Image_TickMarks, self.ui.CircularCenter, self.ui.CircularPoint)
  end
  local avgValue = DT.GetConstant("KeeperSkillScaleEnergy")
  self.circleScaler:Apply(avgValue, maxValue)
end

function UIBattleKeeperRoleItem:RefreshMaxEffect()
  if self:_CheckInCD() then
    self:_HideAllMaxPartilePrefab()
    return
  end
  local targetLevel = self:_GetCurKeeperSkillEnergyLevel()
  if targetLevel >= CommonDefine.KeeperSkillEnergyLevel.Pos1 then
    EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondKeeperSkillEnergyFull, {
      bg.battleRender.battleTid,
      bg.battleRender.boutMgr:GetBoutNum()
    })
  end
  for energyLevel, energyLevelInfo in pairs(self.energyLevelInfoDict) do
    if energyLevelInfo.particleGo then
      self:_SetPartilceGoVisible(energyLevelInfo.particleGo, false)
    end
    if energyLevelInfo.appearEffGo then
      self:_SetPartilceAppearGoVisible(energyLevelInfo.appearEffGo, false)
    end
  end
  local targetLevelInfo = self.energyLevelInfoDict[targetLevel]
  if not targetLevelInfo then
    return
  end
  if targetLevelInfo.particleGo then
    self:_SetPartilceGoVisible(targetLevelInfo.particleGo, true)
  end
  if targetLevelInfo.appearEffGo then
    self:_SetPartilceGoVisible(targetLevelInfo.appearEffGo, true)
  end
  if targetLevelInfo.soundEvent then
    AudioManager.Instance:PostSoundEvent(targetLevelInfo.soundEvent)
  end
end

function UIBattleKeeperRoleItem:_SetPartilceGoVisible(go, boolean)
  if not go then
    return
  end
  if go.activeSelf ~= boolean then
    go:SetActive(boolean)
  end
end

function UIBattleKeeperRoleItem:_SetPartilceAppearGoVisible(go, boolean)
  if not go then
    return
  end
  if go.activeSelf ~= boolean then
    go:SetActive(boolean)
  end
  if boolean then
    self:_DelayHideAppearGo(go)
  else
    self:_StopDelayHideAppearGo(go)
  end
end

function UIBattleKeeperRoleItem:_StopDelayHideAppearGo(go)
  if self.appearEffGoTimer[go] then
    self.binder:StopTimer(self.appearEffGoTimer[go])
    self.appearEffGoTimer[go] = nil
  end
end

function UIBattleKeeperRoleItem:_DelayHideAppearGo(go)
  if self.appearEffGoTimer[go] then
    return
  end
  self.appearEffGoTimer[go] = self.binder:BindTimer(1, 0, nil, function()
    if not IsNil(go) then
      go:SetActive(false)
      self:_StopDelayHideAppearGo(go)
    end
  end)
end

function UIBattleKeeperRoleItem:_HideAllMaxPartilePrefab()
  for _, info in pairs(self.energyLevelInfoDict) do
    local go = info.particleGo
    self:_SetPartilceGoVisible(go, false)
    self:_SetPartilceAppearGoVisible(info.appearEffGo, false)
  end
end

function UIBattleKeeperRoleItem:ForbiddenClick(boolVal)
  self.ui.Btn_Click:SetActive(not boolVal)
  self.ui.Group_Max_Energy_Effect:SetActive(not boolVal)
end

function UIBattleKeeperRoleItem:_PlayProgressAnim(to, progressUi)
  if not self.ui or IsNil(progressUi) then
    return
  end
  self:ClearTweener()
  self.delayHandleChangeEnergy = nil
  if UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew) then
    self.delayHandleChangeEnergy = to
    return
  end
  local imgProgressSpeed = 1.5
  local imgProgress = progressUi:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local delta = to - imgProgress.fillAmount
  if delta <= 0 and imgProgress.fillAmount < 1 then
    imgProgress.fillAmount = to
  else
    self.skillProgressTweener = DOTween.To(function()
      return imgProgress.fillAmount
    end, function(percent)
      if imgProgress.fillAmount ~= percent then
        imgProgress.fillAmount = percent
      end
    end, to, delta / imgProgressSpeed, self)
  end
end

function UIBattleKeeperRoleItem:ClearTweener()
  if self.skillProgressTweener then
    self.skillProgressTweener:Kill(true)
    self.skillProgressTweener = nil
  end
end

return UIBattleKeeperRoleItem
