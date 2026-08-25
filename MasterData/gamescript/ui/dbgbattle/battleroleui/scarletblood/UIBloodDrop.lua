local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local DOTween = CS.DG.Tweening.DOTween
local Image = CS.UnityEngine.UI.Image
local UIAnimationController = CS.Z1Client.UIAnimationController
local Mathf = CS.UnityEngine.Mathf
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local Input = CS.UnityEngine.Input
local UIBloodDrop, Super = System.NewComponent("UIBloodDrop")

function UIBloodDrop:ctor(uiNode, battleRole, roleData)
  Super.ctor(self)
  self.ui = UI_Battle_Blood_DropResource(uiNode)
  self.battleRole = battleRole
  self.roleData = roleData
  self.bloodLength = self.ui.Image_Progress.transform.sizeDelta.x
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
  self.uiAnimationCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.ui.UI_Battle_Blood_Drop_EnergyIncrease:SetActive(false)
end

function UIBloodDrop:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click_Blood_Drop, function()
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    local tipsData = {
      title = LT.Text("Battle_Tips_BloodName", true),
      desc = self.battleRole:GetSchoolTips(cd.SchoolId.Blood),
      iconPath = self.battleRole:GetSchoolTipsIcon(cd.SchoolId.Blood)
    }
    UIManager.Instance:Reopen(Urls.AlertIconToolBattleTipsPanel, tipsData, bg.battlePanel.ui.School_Effect_Tips_Node, true)
  end, nil, nil, nil)
  binder:BindToRaw(function(childBinder, progress, oldProgress)
    if progress then
      self:UpdateBloodDropProgress(childBinder, progress or 0, oldProgress or 0)
    end
  end, function()
    do return self.GetBloodDropProgress end
    return self.GetBloodDropProgress, self
  end, true)
  binder:BindToText(self.ui.Text_Blood_Drop, System.fn(self, self.GetBloodDropProgressText))
  self:BindBloodHeal()
  if bg.battleDataCenter:IsMixSchoolExChoas() then
    self.ui.uiNode.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    if bg.battleDataCenter:IsSchool(bc.SchoolCnID.DEEP_SEA) then
      self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(0, -60, 0)
    elseif bg.battleDataCenter:IsSchool(bc.SchoolCnID.DIMENSION) then
      self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(0, 25, 0)
    end
  end
end

function UIBloodDrop:_IsBloodAbilityInCd()
  do return end
  return BattleSkillUtils.IsColdBloodInCd
end

function UIBloodDrop:_IsNewBloodSchoolRealm()
  local newBloodAwakerList = DT.GetOriginalConstant("NewBloodSchoolAwakerList", {}) or {}
  if 0 == #newBloodAwakerList then
    return false
  end
  local awakerList = bg.battleScene:GetPlayerAwakerList()
  for _, awaker in ipairs(awakerList) do
    local awakerTid = awaker.tid
    for i = 1, #newBloodAwakerList do
      if newBloodAwakerList[i] == awakerTid then
        return true
      end
    end
  end
  return false
end

function UIBloodDrop:_IsScreenPointOnEmbryoProgressUI()
  local progressTextGo = self.ui.Text_Blood_Drop
  if not progressTextGo then
    return false
  end
  local rectTransform = progressTextGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not rectTransform then
    return false
  end
  local mousePos = Input.mousePosition
  local screenPos = Vector2(mousePos.x, mousePos.y)
  do return RectTransformUtility.RectangleContainsScreenPoint, rectTransform, screenPos end
  return RectTransformUtility.RectangleContainsScreenPoint, rectTransform, screenPos, bg.uiCamera
end

function UIBloodDrop:_ShowBloodAbilityCoolDownTips()
  Alert.ShowStr(LT.Textf("BloodAbilityCoolDown", self.roleData:GetBloodAbilityCd()))
end

function UIBloodDrop:GetBloodDropProgress()
  local maxBloodDrop = self.roleData:GetProperty(bc.RoleProperty.max_scarlet_blood_count)
  local curBloodDrop = self.roleData:GetProperty(bc.RoleProperty.scarlet_blood_count)
  if 0 == maxBloodDrop then
    return
  end
  if 0 == self.roleData:GetProperty(bc.RoleProperty.hp) then
    return
  end
  return curBloodDrop / maxBloodDrop
end

function UIBloodDrop:GetBloodDropProgressText()
  local maxBloodDrop = self.roleData:GetProperty(bc.RoleProperty.max_scarlet_blood_count)
  local curBloodDrop = self.roleData:GetProperty(bc.RoleProperty.scarlet_blood_count)
  if 0 == maxBloodDrop then
    return nil
  end
  if 0 == self.roleData:GetProperty(bc.RoleProperty.hp) then
    return nil
  end
  do return string.format, "%s/%s", curBloodDrop end
  return string.format, "%s/%s", curBloodDrop, maxBloodDrop
end

function UIBloodDrop:UpdateBloodDropProgress(binder, progress, oldProgress)
  self:DoTweenProgress(progress, oldProgress)
  self:SetBloodBubbleSacel(progress)
  if progress >= 1 then
    self:BloodBurst()
  end
end

function UIBloodDrop:DoTweenProgress(curProgress, oldProgress)
  if self.sequence then
    self.sequence:Kill()
  end
  self.binder:SetActive(self.ui.UI_Vx_Xuerou_Blood_Head01, curProgress > 0)
  self.sequence = DOTween.Sequence(self)
  local imageProgress = self.ui.Image_Progress:GetComponent(typeof(Image))
  local dura = 1
  if curProgress < oldProgress then
    local fullProgress = 1
    local middleDura = 0.8
    self.sequence:Insert(0, imageProgress:DOFillAmount(fullProgress, middleDura))
    self.sequence:Insert(0, self.ui.UI_Vx_Xuerou_Blood_Head01.transform:DOLocalMoveX(fullProgress * self.bloodLength, middleDura))
    self.sequence:InsertCallback(middleDura, function()
      self.binder:SetImageFillAmount(self.ui.Image_Progress, 0)
      self.ui.UI_Vx_Xuerou_Blood_Head01.transform.localPosition = Vector3(0, 0, 0)
      self:BloodBurst()
    end)
    dura = dura - middleDura
  elseif oldProgress < curProgress and self.uiAnimationCtr then
    self.uiAnimationCtr:StopPlayableGraph()
    self.uiAnimationCtr:PlayState("UI_Vx_Xuerou_Blood_Head01")
  end
  self.sequence:Join(imageProgress:DOFillAmount(curProgress, dura))
  self.sequence:Join(self.ui.UI_Vx_Xuerou_Blood_Head01.transform:DOLocalMoveX(curProgress * self.bloodLength, dura))
end

function UIBloodDrop:SetBloodBubbleSacel(progress)
  local minScale, maxScale = 0.45, 1
  local bloodScale = minScale + (maxScale - minScale) * progress
  self.ui.UI_Vx_Xuerou_Blood_Qipao01.transform.localScale = Vector3(bloodScale, bloodScale, 1)
end

function UIBloodDrop:BloodBurst()
  self.binder:StopTimer(self.burstTimer)
  self.ui.UI_Vx_Xuerou_Blood_Qipao02:SetActive(false)
  self.ui.UI_Vx_Xuerou_Blood_Qipao02:SetActive(true)
  self.burstTimer = self.binder:BindTimer(0.9, 0, nil, function()
    self.ui.UI_Vx_Xuerou_Blood_Qipao02:SetActive(false)
  end)
end

function UIBloodDrop:BindBloodHeal()
  self.binder:BindToVisible(self.ui.Group_Heal, function()
    local _ = bg.battleDataCenter.boutBloodRecoverTimes.value
    return self:GetBloodHealValue() > 0
  end)
  self.binder:BindToText(self.ui.Text_Value, function()
    do return self.GetBloodHealValue end
    return self.GetBloodHealValue, self
  end)
  self.binder:BindToRaw(function(_, isCold)
    self.ui.Group_Cold:SetActive(isCold)
  end, function()
    local _ = bg.battleDataCenter.boutBloodRecoverTimes.value
    return BattleSkillUtils.IsColdBloodInCd() or BattleSkillUtils.IsColdBloodRecoverTimes()
  end)
  self.binder:BindLongPressButton(self.ui.Group_Heal, nil, System.fn(self, self.OnGroupHeal), 0.3)
  local isMix = bg.battleDataCenter:IsMixSchoolExChoas()
  local isHasSea = bg.battleDataCenter:IsSchool(bc.SchoolCnID.DEEP_SEA)
  local uName = "KeySchoolUse"
  if isMix and isHasSea then
    uName = "KeySchoolUse2"
  end
  self.binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, uName, function()
    if bg.battleDataCenter:GetRealCamp() == bc.BattleCamp.Camp2 then
      return
    end
    self:OnGroupHeal()
  end))
  self.waitIndex = FrameWaiter.OnNextFrame(function()
    self.binder:BindToRaw(function(_, newV, oldV)
      if nil == oldV then
        return
      end
      local changeV = newV - oldV
      if changeV > 0 then
        local floatingText = Pool.GetWithTag(RoleFloatingText, bc.FloatingTextType.BloodBall, bg.battleScene.factoryLayer)
        local text = "+" .. changeV
        local position = CS.UnityEngine.Vector2(0, 120.0)
        floatingText:InitFloat(text, nil, self.ui.Group_Heal.transform, position)
        self.ui.UI_Battle_Blood_Drop_EnergyIncrease:SetActive(true)
        self._increaseEffTimer = bg.battleRender:PerformWithDelay(1.5, function()
          self.ui.UI_Battle_Blood_Drop_EnergyIncrease:SetActive(false)
        end, self)
      end
    end, function()
      do return self.GetBloodHealValue end
      return self.GetBloodHealValue, self
    end)
    FrameWaiter.RemoveWaiter(self.waitIndex)
    self.waitIndex = nil
  end, 30)
  self.binder:BindToRaw(function(_, progress, oldProgress)
    if oldProgress then
      if 1 == progress then
        AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_B_Smelter_Max")
      else
        AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_B_Smelter_Increase")
      end
    end
    local dura = 0.5
    if not oldProgress then
      dura = 0
    end
    local x = -18.7
    local bottomY = -57.3
    local topY = 70.2
    local y = (topY - bottomY) * progress + bottomY
    self.ui.UI_Battle_Blood_Drop_Wave01.transform:DOAnchorPos(Vector2(x, y), dura)
    self.ui.Image_Blood:GetComponent(typeof(Image)):DOFillAmount(self:GetBloodHealProgress(), dura)
    self.ui.Image_water01:GetComponent(typeof(Image)):DOFillAmount(self:GetBloodHealProgress(), dura)
    self.ui.Image_water01:SetActive(false)
  end, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.binder:BindToVisible(self.ui.Group_Max, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.binder:BindToVisible(self.ui.UI_Battle_Blood_Drop_Wave01, function()
    return self:GetBloodHealProgress() < 1
  end)
end

function UIBloodDrop:OnGroupHeal()
  if not bg.battleDataCenter:IsMyActionCamp() then
    return
  end
  if self:_IsNewBloodSchoolRealm() and BattleSkillUtils.IsColdBloodInCd() then
    self:_ShowBloodAbilityCoolDownTips()
    return
  end
  if self:IsColdBloodRecoverTimes() then
    Alert.ShowStr(LT.Text("BoutBloodSkillMaxTimesTips"))
    return
  end
  if BattleSkillUtils.IsColdBloodInCd() then
    self:_ShowBloodAbilityCoolDownTips()
    return
  end
  UIManager.Instance:Reopen(Urls.BattleBloodHealConfirmPanel)
end

function UIBloodDrop:GetBloodHealValue()
  local cmdParser = BattleCmdParserClient({})
  local value = cmdParser:GetValueByCmd(bg.DT.GetConstant("BloodHealCount"))
  do return Mathf.CeilToInt end
  return Mathf.CeilToInt, value, bg.DT.GetConstant("BloodHealCount")
end

function UIBloodDrop:GetBloodHealMaxValue()
  local cmdParser = BattleCmdParserClient({})
  local stateCfg = DT.State[bg.DT.GetConstant("BloodHealStateId")]
  do return cmdParser.GetValueByCmd, cmdParser end
  return cmdParser.GetValueByCmd, cmdParser, stateCfg.MaxLayer
end

function UIBloodDrop:GetBloodHealProgress()
  local cur = self:GetBloodHealValue()
  local max = self:GetBloodHealMaxValue()
  if max and 0 ~= max then
    do return math.min, 1 end
    return math.min, 1, cur / max
  end
  return 0
end

function UIBloodDrop:IsColdBloodRecoverTimes()
  local max = bc.BoutBloodSkillMaxTimes
  local cur = bg.battleDataCenter.boutBloodRecoverTimes.value or 0
  return max <= cur
end

function UIBloodDrop:OnUnbind()
  Super.OnUnbind(self)
  if self.sequence then
    self.sequence:Kill()
  end
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  bg.battleRender:UnperformWithDelay(self._increaseEffTimer)
  if self.waitIndex then
    FrameWaiter.RemoveWaiter(self.waitIndex)
    self.waitIndex = nil
  end
end

return UIBloodDrop
