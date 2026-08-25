local typeof = _ENV.typeof
local CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local CSImage = CS.UnityEngine.UI.Image
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local UIAnimationController = CS.Z1Client.UIAnimationController
local Image = CS.UnityEngine.UI.Image
local BattleRoleBloodUI, Super = System.NewComponent("BattleRoleBloodUI")

function BattleRoleBloodUI:ctor(uiNode, battleRole, intentNode)
  Super.ctor(self)
  self.ui = Func_Battle_Blood_ShareResource(uiNode)
  self.intentNode = intentNode
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.beHitInfoList = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleRoleBloodUI:OnBind(binder)
  self.binder = binder
  local scale = Vector3(0, 1, 1)
  self.ui.Image_Shield_Bar_To_Right.transform.localScale = scale
  self.ui.Image_Shield_Bar_To_Left.transform.localScale = scale
  self:HideBlockEffect()
  self:OnBindHp(binder)
  self:OnBindHpWidth(binder)
  self:OnBindDecorate(binder)
  self:OnBindBlock(binder)
  self:OnBindCurseBlood(binder)
  self:OnBindRoleName(binder)
  self:OnBindUnSelect(binder)
  self.stateUIComp = binder:BindComponent(BattleRoleStateUI(self.ui.uiNode, self.battleRole, self.intentNode))
  self:OnBindTentacle(binder)
  self:OnBindScarletBlood(binder)
  bg.battleRender:PerformWithDelay(1, function()
    self.dimensionUI = binder:BindComponent(BattleDimensionUI(self.ui, self.battleRole))
  end, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MonsterChangeName, self.OnMonsterChangeName, self)
  self:OnBindBloodEnterAnim()
  if bg.battleDataCenter:IsMyCamp(self.roleData.camp) then
    self:OnBindBloodReviveEffect()
  end
  self:BindBossHpNum(binder)
  self:BindThreat(binder)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BeHit, self._AddBeHitInfo, self)
end

function BattleRoleBloodUI:OnUnbind()
  Super.OnUnbind(self)
  if bg.battleRender then
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
  end
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleRoleBloodUI:UpdatePosition()
  self:UpdateSchoolPos()
  self:UpdateBloodPos()
  if self.stateUIComp then
    self.stateUIComp:BindClickAreaToMonsterShape()
  end
  if self.dimensionUI then
    self.dimensionUI:SetDimensionSlotPos()
  end
end

function BattleRoleBloodUI:PlayReboneHpEffect()
  self.ui.Group_Shield_Bar:SetActive(false)
  self:Ordinary_uiAnimPlayState("UI_Battle_Blood_Share_BloodEnemy_Return", function()
    self.ui.Group_Shield_Bar:SetActive(false)
  end)
end

function BattleRoleBloodUI:Ordinary_uiAnimPlayState(aniName, callback)
  if IsNil(self.Ordinary_uiAnim) then
    return
  end
  if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    if callback then
      callback()
    end
    return
  end
  if not self.playDead then
    self.Ordinary_uiAnim:PlayState(aniName, function()
      if callback then
        callback()
      end
    end)
  end
end

function BattleRoleBloodUI:BindThreat(binder)
  binder:BindToVisible(self.ui.Group_Threat, function()
    return self.roleData.camp == bc.BattleCamp.Camp1
  end)
  if self.roleData.camp ~= bc.BattleCamp.Camp1 then
    return
  end
  binder:BindToRaw(function()
    self:_ClearBeHitInfo()
    self:RefreshThreatData()
  end, function()
    do return bg.battleDataCenter.GetRealCamp end
    return bg.battleDataCenter.GetRealCamp, bg.battleDataCenter
  end)
  binder:BindToText(self.ui.Text_Save, function()
    do return LT.Text("Battle_Threat_Save").color, (LT.Text("Battle_Threat_Save")) end
    return LT.Text("Battle_Threat_Save").color, LT.Text("Battle_Threat_Save"), "#" .. DT.GetConstant("ThreatVisualSaveColor"), DT.GetConstant("ThreatVisualSaveColor"), "ThreatVisualSaveColor"
  end)
  binder:BindToText(self.ui.Text_Unknown, function()
    do return LT.Text("Battle_Threat_Unknown").color, (LT.Text("Battle_Threat_Unknown")) end
    return LT.Text("Battle_Threat_Unknown").color, LT.Text("Battle_Threat_Unknown"), "#" .. DT.GetConstant("ThreatVisualUnKnownColor"), DT.GetConstant("ThreatVisualUnKnownColor"), "ThreatVisualUnKnownColor"
  end)
  binder:BindToRaw(function()
    if self:_IsMyTurn() then
      self:RefreshThreatData()
    else
      local camp = bg.battleRender.boutMgr:GetCamp()
      local forceRefresh = camp == bc.BattleCamp.Camp1
      self:RefreshThreatData(forceRefresh)
    end
  end, function()
    return {
      self.roleData:GetProperty(bc.RoleProperty.hp),
      self.roleData:GetProperty(bc.RoleProperty.max_hp),
      self.roleData:GetProperty(bc.RoleProperty.block)
    }
  end)
end

function BattleRoleBloodUI:RefreshThreatData(forceRefresh)
  local finHp = self.threatData and self.threatData.finHp or 0
  local threatData = self.roleData:GetThreat(self.beHitInfoList)
  if not forceRefresh and not self:_IsMyTurn() then
    threatData.finHp = finHp
  end
  self.perThreatData = self.threatData
  self.threatData = threatData
  self:RefreshThreat(self.binder, forceRefresh)
end

function BattleRoleBloodUI:RefreshThreat(cbinder, forceRefresh)
  if not self.threatData then
    return
  end
  if not forceRefresh and self.lockThreat then
    self:PlayThreatAni()
    return
  end
  local blindData = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.blind)
  local blind = blindData and blindData > 0
  cbinder:SetActive(self.ui.Text_Unknown, blind)
  cbinder:SetActive(self.ui.Group_ThreatShield, not blind)
  cbinder:SetActive(self.ui.Group_ThreatBlood, not blind)
  if blind then
    cbinder:SetActive(self.ui.Text_Save, false)
    cbinder:SetActive(self.ui.Text_ThreatNum, false)
    cbinder:SetActive(self.ui.Image_Fatal, false)
    return
  end
  local unBlockThreat = self.threatData.hp - self.threatData.finHp
  local totalShield = self.threatData.shield / self.threatData.maxHp
  local breakShield = 1 - self.threatData.finShield / self.threatData.maxHp
  local totalHp = self.threatData.hp / self.threatData.maxHp
  local breakHp = 1 - self.threatData.finHp / self.threatData.maxHp
  if forceRefresh or self:_IsMyTurn() then
    cbinder:SetActive(self.ui.Text_Save, unBlockThreat <= 0)
    cbinder:SetActive(self.ui.Text_ThreatNum, unBlockThreat > 0)
    cbinder:SetActive(self.ui.Image_Fatal, unBlockThreat >= self.threatData.hp)
    if unBlockThreat > 0 then
      local threatText = ("-" .. bc.NumberToK(math.floor(unBlockThreat))):color("#" .. DT.GetConstant("ThreatVisualDangerColor"))
      cbinder:SetText(self.ui.Text_ThreatNum, threatText)
    end
    cbinder:SetImageFillAmount(self.ui.Image_ThreatShield_FillTotal, totalShield)
    cbinder:SetImageFillAmount(self.ui.Image_ThreatShield_Fill, breakShield)
    cbinder:SetImageFillAmount(self.ui.Image_ThreatBlood_FillTotal, totalHp)
    cbinder:SetImageFillAmount(self.ui.Image_ThreatBlood_Fill, breakHp)
    self:PlayThreatAni()
  end
end

function BattleRoleBloodUI:PlayThreatAni()
  local aniTime = 0.5
  local totalHp = self.threatData.hp / self.threatData.maxHp
  local bloodReduceImgTotal = self.ui.Image_ThreatBlood_FillTotal:GetComponent(typeof(CSImage))
  bloodReduceImgTotal:DOFillAmount(totalHp, aniTime)
  local shieldReduceImgTotal = self.ui.Image_ThreatShield_FillTotal:GetComponent(typeof(CSImage))
  local totalShield = self.threatData.shield / self.threatData.maxHp
  local preShieldPercent = self.perThreatData and self.perThreatData.shield / self.perThreatData.maxHp or nil
  local shieldPercent = self.threatData.shield / self.threatData.maxHp
  if preShieldPercent and preShieldPercent > shieldPercent then
    shieldReduceImgTotal:DOFillAmount(totalShield, aniTime)
  end
end

function BattleRoleBloodUI:BindBossHpNum(binder)
  if bg.battleDataCenter:IsMyCamp(self.roleData.camp) then
    return
  end
  binder:BindToRaw(function(cbinder, monsterHpNum)
    for index = 1, monsterHpNum - 1 do
      local hpNumItem = cbinder:BindNewComponent(self.ui.Content_Boss_HpNum, MonsterHpNumItem, UI_Battle_HpNumResource, self.roleData, index)
      cbinder:BindToRaw(function(_, hpNum)
        if hpNum < index then
          hpNumItem:DisappearItem(hpNum)
        else
          hpNumItem:ShowItem(hpNum)
        end
      end, function()
        do return self.roleData.GetHpNum end
        return self.roleData.GetHpNum, self.roleData
      end)
    end
  end, function()
    do return self.roleData.GetMonsterLifeNum end
    return self.roleData.GetMonsterLifeNum, self.roleData
  end)
end

function BattleRoleBloodUI:OnBindHp(binder)
  local groupBlood = self.ui.Group_Blood
  local bloodReduceImg = self.ui.Image_Blood_Reduce_Effect:GetComponent(typeof(CSImage))
  local bloodReduceTween, bloodTween
  self.ui.Image_Blood_Reduce_Effect:SetActive(true)
  self.Ordinary_uiAnim = self.ui.Ordinary_Bg:GetComponent(typeof(UIAnimationController))
  local reduceTimer
  local baseTime = 0.3
  local maxTime = 3.0
  local lostHpRate_maxEffect = 1.0
  binder:BindToRaw(function(_, hpPercent, preHpPercent)
    if preHpPercent and hpPercent ~= preHpPercent then
      self:Ordinary_uiAnimPlayState("Func_Battle_Blood_Hit01")
    end
    if bloodTween then
      bloodTween:Kill(false)
    end
    if 0 == preHpPercent and hpPercent >= 1 and bg.battleDataCenter:IsMyCamp(self.roleData.camp) then
      return
    end
    local resultTime = baseTime
    if preHpPercent and hpPercent < preHpPercent then
      local lostRate = preHpPercent - hpPercent
      local leftWhite = bloodReduceImg.fillAmount - hpPercent
      resultTime = baseTime + (lostRate + leftWhite) * (maxTime - baseTime) / lostHpRate_maxEffect
    end
    if hpPercent > 0.001 then
      bloodTween = groupBlood.transform:DOScaleX(hpPercent, 0.3)
    else
      bloodTween = groupBlood.transform:DOScaleX(hpPercent, 0.1)
    end
    if hpPercent >= 1 then
      bloodReduceImg.fillAmount = 1
    else
      self.ui.Image_Blood_Reduce_Effect:SetActive(true)
      self.lockThreat = true
      if not reduceTimer then
        bloodReduceImg.fillAmount = preHpPercent
      else
        reduceTimer = binder:StopTimer(reduceTimer)
      end
      local isMyTurn = self:_IsMyTurn()
      reduceTimer = binder:BindTimer(0.3, 0, nil, function()
        reduceTimer = nil
        if bloodReduceTween then
          bloodReduceTween:Kill(false)
        end
        bloodReduceTween = bloodReduceImg:DOFillAmount(hpPercent, resultTime):OnComplete(function()
          if not self.ui then
            return
          end
          self.ui.Image_Blood_Reduce_Effect:SetActive(false)
          self.lockThreat = false
          self:RefreshThreat(binder, isMyTurn)
        end)
      end)
    end
  end, function()
    local hp = self.roleData:GetProperty(bc.RoleProperty.hp)
    local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp)
    if hp and maxHp and 0 ~= maxHp then
      return hp / maxHp
    end
    return 0
  end)
  binder:BindToText(self.ui.Text_LifeBloor, function()
    local hp = self.roleData:GetProperty(bc.RoleProperty.hp)
    local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp)
    if self.roleData.camp == bc.BattleCamp.Camp2 then
      do return bc.NumberToK end
      return bc.NumberToK, hp, nil, nil, nil
    else
      do return string.format, "%s/%s", bc.NumberToK(hp), bc.NumberToK(maxHp) end
      return string.format, "%s/%s", bc.NumberToK(hp), bc.NumberToK(maxHp)
    end
  end)
end

function BattleRoleBloodUI:OnBindBloodReviveEffect()
  self.binder:BindEvent(EventMgr.Instance.BattleReviveAnim, System.fn(self, self.PlayBloodReviveEffect))
  self.binder:BindEvent(EventMgr.Instance.UpdateMonsterDamage, System.fn(self, self.RefreshThreatData))
end

function BattleRoleBloodUI:PlayBloodReviveEffect()
  self.ui.Image_Blood_Reduce_Effect:SetActive(false)
  self:Ordinary_uiAnimPlayState("UI_Battle_Blood_Share_DeadResistance", function()
    self.ui.Image_Blood_Reduce_Effect:SetActive(true)
  end)
end

function BattleRoleBloodUI:OnBindHpWidth(binder)
  local configWidth = DT.Constant.MonsterHpBarLength.Data
  binder:BindToRaw(function(_, width)
    if width then
      self.ui.uiNode.transform.sizeDelta = Vector2(width, 60)
    end
  end, function()
    if self.battleRole.camp == bc.BattleCamp.Camp1 then
      return DT.Constant.PlayerHpBarLength.Data[1]
    end
    local bodySize = self:GetBodySize() or bc.BodySize.Middle
    return configWidth[bc.BloodWidth[bodySize]]
  end)
end

function BattleRoleBloodUI:GetBodySize()
  if bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeMiniState")) then
    return bc.BodySize.Mini
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeMiddleState")) then
    return bc.BodySize.Middle
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeBigState")) then
    return bc.BodySize.Big
  elseif bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetConstant("MonsterSizeHugeState")) then
    return bc.BodySize.Huge
  end
  local config = self.battleRole.awakerList[1].configData
  return config and config.BodySize
end

function BattleRoleBloodUI:UpdateSchoolPos()
  if self.roleData.camp ~= bc.BattleCamp.Camp1 then
    return
  end
  if not bg.battleScene or not bg.battleScene.battleSceneCfg then
    return
  end
  local sceneId = bg.battleScene.battleSceneCfg.ID
  local farCameraScenes = bg.DT.GetOriginalConstant("FarCameraScenes")
  if not table.contains(farCameraScenes, sceneId) then
    self.ui.Parent_School.transform.anchoredPosition3D = Vector3(-206, 426, 0)
  else
    self.ui.Parent_School.transform.anchoredPosition3D = Vector3(-206, 356, 0)
  end
end

function BattleRoleBloodUI:UpdateBloodPos()
  if self.battleRole.camp == bc.BattleCamp.Camp1 then
    return
  end
  if self.roleData.tid == 44177 then
    CS.Framework.TransformUtil.SetLocalPos(self.ui.uiNode.transform, -100, 0, 0)
  else
    CS.Framework.TransformUtil.SetLocalPos(self.ui.uiNode.transform, 0, 0, 0)
  end
end

function BattleRoleBloodUI:HideBlockEffect()
  self.ui.UI_Vx_Battle_Defense_Appear01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Hit01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die02_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Appear01_Left:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Hit01_Left:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die01_Left:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die02_Left:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Appear01_Boss:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Hit01_Boss:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die01_Boss:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die02_Boss:SetActive(false)
  self.ui.UI_Vx_Battle_EliteDefense_Appear01:SetActive(false)
  self.ui.UI_Vx_Battle_EliteDefense_Hit01:SetActive(false)
  self.ui.UI_Vx_Battle_EliteDefense_Die01:SetActive(false)
  self.ui.Image_Shield_Reduce_Effect_To_Right:SetActive(false)
  self.ui.Image_Shield_Reduce_Effect_To_Left:SetActive(false)
end

function BattleRoleBloodUI:OnBindDecorate(binder)
  binder:BindToRaw(function(childBinder, camp)
    local isCamp1 = camp == bc.BattleCamp.Camp1
    local isCamp2 = camp == bc.BattleCamp.Camp2
    local isBoss = self:IsBoss()
    local isElite = self:IsElite()
    self.ui.Image_D_BloodPlayer:SetActive(isCamp1)
    self.ui.Image_D_BloodEnemy:SetActive(isCamp2)
    self.ui.Image_D_BloodBoss:SetActive(isBoss or isElite)
    self.ui.Boss_Blood_Decorate:SetActive(isBoss or isElite)
    self.ui.Boss_Shield_Decorate:SetActive(isBoss)
    self.ui.Boss_Shield_Elite:SetActive(isElite)
    self.ui.Image_Shield_Reduce_Effect_To_Right:SetActive(isCamp1)
    self.ui.Image_Shield_Bar_To_Right:SetActive(isCamp1)
    self.ui.Image_Shield_Reduce_Effect_To_Left:SetActive(isCamp2)
    self.ui.Image_Shield_Bar_To_Left:SetActive(isCamp2)
    childBinder:BindToRaw(function(_, isHaveBlock)
      if true == isHaveBlock then
        self.ui.Group_Shield_Bar:SetActive(true)
      end
      self.ui.Image_Shield_Border_Left:SetActive(isHaveBlock)
      self.ui.Image_Char_Shield_FillBg:SetActive(isHaveBlock)
      local showBossShield = isHaveBlock and isBoss
      self.ui.Image_Shield_Boss_Nor:SetActive(showBossShield)
      self.ui.Text_Shield_Boss:SetActive(showBossShield)
      local showEliteShield = isHaveBlock and isElite
      self.ui.Image_Shield_Elite_Nor:SetActive(showEliteShield)
      self.ui.Text_Shield_Elite:SetActive(showEliteShield)
      local showLeftShield = isHaveBlock and isCamp2 and not isBoss and not isElite
      self.ui.Image_Shield_Left_Nor:SetActive(showLeftShield)
      self.ui.Image_Shield_Left:SetActive(showLeftShield)
      self.ui.Text_Shield_Left:SetActive(showLeftShield)
      local showRightShield = isHaveBlock and isCamp1
      self.ui.Image_Shield_Right_Nor:SetActive(showRightShield)
      self.ui.Image_Shield_Right:SetActive(showRightShield)
      self.ui.Text_Shield_Right:SetActive(showRightShield)
      if showBossShield then
        self:Ordinary_uiAnimPlayState("Func_Battle_Boss_Shield")
      elseif showLeftShield then
        self:Ordinary_uiAnimPlayState("Func_Battle_Group_Shield")
      elseif showRightShield then
        self:Ordinary_uiAnimPlayState("Func_Battle_Shield_Right")
      end
    end, function()
      local block = self.roleData:GetProperty(bc.RoleProperty.block) or 0
      return block > 0
    end)
    childBinder:BindToRaw(function(_, newAttr)
      local newBlock = newAttr[1]
      local newMaxHp = newAttr[2]
      local isFullBlock = newBlock >= newMaxHp
      self.ui.Image_Shield_Boss:SetActive(isBoss and isFullBlock)
      self.ui.Image_Shield_Elite:SetActive(isElite and isFullBlock)
      self.ui.Image_Shield_Left:SetActive(isCamp2 and not isBoss and not isElite and isFullBlock)
      self.ui.Image_Shield_Right:SetActive(isCamp1 and isFullBlock)
      self.ui.Image_Shield_Border_Right:SetActive(isFullBlock)
    end, function()
      local block = self.roleData:GetProperty(bc.RoleProperty.block) or 0
      local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp)
      return {block, maxHp}
    end)
  end, function()
    return self.roleData.camp
  end)
end

function BattleRoleBloodUI:IsBoss()
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    local config = self.battleRole.awakerList[1].configData
    return config.MonsterClass == bc.MonsterClass.Boss
  end
  return false
end

function BattleRoleBloodUI:IsElite()
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    local config = self.battleRole.awakerList[1].configData
    return config.MonsterClass == bc.MonsterClass.Elite
  end
  return false
end

function BattleRoleBloodUI:OnBindBlock(binder)
  local shieldBarTween
  binder:BindToRaw(function(itembinder, nVal, oVal)
    local shieldBar, shieldBarReduceEffect, whiteBar, whiteBarAnimName
    local camp = self.roleData.camp
    if camp == bc.BattleCamp.Camp1 then
      itembinder:SetText(self.ui.Text_Shield_Right, bc.NumberToK(nVal))
      self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Appear01_Right, oVal and 0 == oVal)
      self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Hit01_Right, oVal and 0 ~= nVal and nVal < oVal)
      self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Die01_Right, oVal and 0 == nVal and nVal < oVal)
      shieldBar = self.ui.Image_Shield_Bar_To_Right
      shieldBarReduceEffect = self.ui.Image_Shield_Reduce_Effect_To_Right
      whiteBar = self.ui.Group_Vx__Shield_BarRight
      whiteBarAnimName = "Func_Battle_Blood_Dissapear_Right"
    elseif camp == bc.BattleCamp.Camp2 then
      if self:IsBoss() then
        itembinder:SetText(self.ui.Text_Shield_Boss, bc.NumberToK(nVal))
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Appear01_Boss, oVal and 0 == oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Hit01_Boss, oVal and 0 ~= nVal and nVal < oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Die01_Boss, oVal and 0 == nVal and nVal < oVal)
      elseif self:IsElite() then
        itembinder:SetText(self.ui.Text_Shield_Elite, bc.NumberToK(nVal))
        self:_ShowFX(self.ui.UI_Vx_Battle_EliteDefense_Appear01, oVal and 0 == oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_EliteDefense_Hit01, oVal and 0 ~= nVal and nVal < oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_EliteDefense_Die01, oVal and 0 == nVal and nVal < oVal)
      else
        itembinder:SetText(self.ui.Text_Shield_Left, bc.NumberToK(nVal))
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Appear01_Left, oVal and 0 == oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Hit01_Left, oVal and 0 ~= nVal and nVal < oVal)
        self:_ShowFX(self.ui.UI_Vx_Battle_Defense_Die01_Left, oVal and 0 == nVal and nVal < oVal)
      end
      shieldBar = self.ui.Image_Shield_Bar_To_Left
      shieldBarReduceEffect = self.ui.Image_Shield_Reduce_Effect_To_Left
      whiteBar = self.ui.Group_Vx__Shield_Bar
      whiteBarAnimName = "Func_Battle_Blood_Dissapear_Left"
    end
    if oVal and 0 == nVal and nVal < oVal then
      whiteBar:SetActive(true)
      self:Ordinary_uiAnimPlayState(whiteBarAnimName)
    end
    local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp)
    local percent = math.max(0, math.min(nVal / maxHp, 1))
    if oVal and 0 ~= nVal and nVal ~= oVal then
      self:Ordinary_uiAnimPlayState("Func_Battle_Blood_Defense_NubChange01")
    end
    if not oVal or oVal < nVal then
      if shieldBarTween then
        shieldBarTween:Kill(false)
      end
      local imageProgress = shieldBarReduceEffect:GetComponent(typeof(Image))
      shieldBarTween = shieldBar.transform:DOScaleX(percent, 0.5)
      self.lockThreat = true
      local isMyTurn = self:_IsMyTurn()
      imageProgress:DOFillAmount(math.max(percent - 0.02, 0), 0.5):OnComplete(function()
        self.lockThreat = false
        self:RefreshThreat(binder, isMyTurn)
      end)
      return
    end
    if oVal and nVal < oVal then
      shieldBar.transform.localScale = Vector3(percent, 1, 1)
      if self.shieldBarReduceEffectTimer then
        binder:StopTimer(self.shieldBarReduceEffectTimer)
      end
      self.shieldBarReduceEffectTimer = binder:BindTimer(0.5, 0, nil, function()
        local imageProgress = shieldBarReduceEffect:GetComponent(typeof(Image))
        shieldBar.transform.localScale = Vector3(percent, 1, 1)
        self.lockThreat = true
        local isMyTurn = self:_IsMyTurn()
        imageProgress:DOFillAmount(math.max(percent - 0.02, 0), 0.5):OnComplete(function()
          self.lockThreat = false
          self:RefreshThreat(binder, isMyTurn)
        end)
      end)
      return
    end
  end, function()
    do return self.roleData.GetProperty, self.roleData end
    return self.roleData.GetProperty, self.roleData, bc.RoleProperty.block
  end)
end

function BattleRoleBloodUI:OnBindCurseBlood(binder)
  binder:BindToRaw(function(cBinder, params)
    if not params then
      cBinder:SetActive(self.ui.Slider_BloodDisable, false)
      cBinder:SetSliderCurValue(self.ui.Slider_BloodDisable, 0)
      return
    end
    local stateLayer = params[1] or 0
    local hp = params[2] or 0
    local needShow = stateLayer > 0
    cBinder:SetActive(self.ui.Slider_BloodDisable, needShow)
    if not needShow then
      cBinder:SetSliderCurValue(self.ui.Slider_BloodDisable, 0)
      return
    end
    local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp) or 0
    if hp <= 0 or maxHp <= 0 then
      cBinder:SetSliderCurValue(self.ui.Slider_BloodDisable, 0)
      return
    end
    local fillAmount = stateLayer / hp
    fillAmount = math.max(0, math.min(fillAmount, 1))
    cBinder:SetSliderCurValue(self.ui.Slider_BloodDisable, fillAmount)
  end, function()
    local hp = self.roleData:GetProperty(bc.RoleProperty.hp) or 0
    local state = bg.battleDataCenter.stateData:GetRoleState(self.roleUid, DT.GetOriginalConstant("FateCutState"))
    if not state then
      return {0, hp}
    end
    return {
      state.layer or 0,
      hp
    }
  end)
end

function BattleRoleBloodUI:_ShowFX(fxNode, show)
  fxNode:SetActive(false)
  if show then
    fxNode:SetActive(true)
  end
end

function BattleRoleBloodUI:OnBindRoleName(binder)
  binder:LoadAllLangFont(self.ui.Text_Monster_Name)
  self.ui.Text_Monster_Name:SetActive(self.battleRole.camp == bc.BattleCamp.Camp2)
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    local roleDataModel = bg.battleDataCenter:GetRoleDataModel(self.battleRole.uid)
    local monsterCfg = DT.MonsterConfig[roleDataModel and roleDataModel.tid or 0]
    if not monsterCfg or not monsterCfg.IsHide then
      binder:SetText(self.ui.Text_Monster_Name, LT.Text(bg.battleDataCenter:GetRoleName(self.battleRole.uid, false)))
    else
      binder:SetText(self.ui.Text_Monster_Name, "")
    end
  end
end

function BattleRoleBloodUI:OnMonsterChangeName(data)
  if data.uid ~= self.battleRole.uid then
    return
  end
  if self.roleData and self.roleData.SetShowName then
    self.roleData:SetShowName(data.showName)
  end
  self.binder:SetText(self.ui.Text_Monster_Name, LT.Text(data.showName))
end

function BattleRoleBloodUI:OnBindUnSelect(binder)
  binder:BindToRaw(function(_, visible)
    local canvasGroup = self.ui.uiNode:GetComponent(CanvasGroup)
    if canvasGroup then
      if visible then
        canvasGroup.alpha = 1
      else
        canvasGroup.alpha = 0
      end
    end
  end, function()
    local notSelected = 0 == self.roleData:GetProperty(bc.RoleProperty.not_select)
    return notSelected
  end)
end

function BattleRoleBloodUI:OnBindTentacle(binder)
  if self.roleData.camp == bc.BattleCamp.Camp1 then
    binder:BindNewComponent(self.ui.Content_Tentacle, BattleTentacleUI, Func_Battle_ChuwanResource, self.battleRole, self.roleData)
  end
end

function BattleRoleBloodUI:OnBindScarletBlood(binder)
  binder:BindToRaw(function(childBinder, show)
    self.ui.Content_Blood_Drop:SetActive(show)
    if not show then
      return
    end
    childBinder:BindNewComponent(self.ui.Content_Blood_Drop, UIBloodDrop, UI_Battle_Blood_DropResource, self.battleRole, self.roleData)
  end, function()
    do return self.roleData.IsShowBloodDrop end
    return self.roleData.IsShowBloodDrop, self.roleData
  end, true)
end

function BattleRoleBloodUI:PlayBloodDeadAnim()
  self:Ordinary_uiAnimPlayState("Func_Battle_Blood_Dissapear_01", function()
    self.playDead = false
  end)
  self.playDead = true
end

function BattleRoleBloodUI:PlayBloodReviveAnim()
  self.playDead = false
  self:Ordinary_uiAnimPlayState("Func_Battle_Blood_Apear_01")
end

function BattleRoleBloodUI:OnBindBloodEnterAnim()
  local eventMgr = bg.battleRender.eventMgr
  eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, self.PlayBloodEnterAnim, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BattleRecover, self.PlayBloodEnterAnim, self)
end

function BattleRoleBloodUI:PlayBloodEnterAnim()
  self:Ordinary_uiAnimPlayState("Func_Battle_Blood_Apear_01")
end

function BattleRoleBloodUI:_IsMyTurn()
  local realcamp = bg.battleDataCenter:GetRealCamp()
  local isOurCamp = realcamp == bc.BattleCamp.Camp1
  local isMyBoutEnd = bg.battleDataCenter:GetIsMyBoutEnd()
  return isOurCamp and not isMyBoutEnd
end

function BattleRoleBloodUI:_AddBeHitInfo(beHitData)
  if self.roleUid ~= beHitData.roleUid then
    return
  end
  table.insert(self.beHitInfoList, beHitData.beHitConfig)
end

function BattleRoleBloodUI:_ClearBeHitInfo()
  self.beHitInfoList = {}
end

return BattleRoleBloodUI
