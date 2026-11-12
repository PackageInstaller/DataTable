local BossHUDCtrl = class("BossHUDCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local AniTimeHighlight = 0.2
local AniTime = 0.5
local ToughnessRecoverTime = 0.3
local colorHide = Color(1, 1, 1, 0)
local colorWhite = Color(1, 1, 1, 1)
local colorShieldDelay = Color(1, 1, 1, 0.5)
local colorRed = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 1)
local colorRedHide = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 0)
local colorRecover = Color(0.9921568627450981, 0.5098039215686274, 0, 1)
local AnimBossEnergy = 0.5
local tabColorJDBoss = {
  [1] = {
    Color(0.9176470588235294, 0.34901960784313724, 0.27450980392156865, 1),
    Color(1, 0.5803921568627451, 0.30980392156862746, 1)
  },
  [2] = {
    Color(1, 0.5803921568627451, 0.30980392156862746, 1),
    Color(0.9803921568627451, 0.8, 0.3411764705882353, 1)
  },
  [3] = {
    Color(0.9803921568627451, 0.8, 0.3411764705882353, 1),
    Color(0.9176470588235294, 0.34901960784313724, 0.27450980392156865, 1)
  }
}
local jointDrillEnergyAnimStage1 = 0.37
local jointDrillEnergyAnimStage2 = 0.68
local jointDrillEnergyStage = {
  None = 1,
  Stage1 = 2,
  Stage2 = 3,
  Max = 4
}
local bossEnergyMaxValue = 100
BossHUDCtrl._mapNodeConfig = {
  BossIcon = {
    sNodeName = "imgBossIcon",
    sComponentName = "Image"
  },
  TMP_MonsterName = {sComponentName = "TMP_Text"},
  rtHpFillDelay = {
    sNodeName = "imgHpFillDelay",
    sComponentName = "RectTransform"
  },
  rtHpFill = {
    sNodeName = "imgHpFill",
    sComponentName = "RectTransform"
  },
  aniRtHpDelay = {
    sNodeName = "imgHpFillDelay",
    sComponentName = "HpBarRectTransform"
  },
  ainColorHpDelay = {
    sNodeName = "imgHpFillDelay",
    sComponentName = "HpBarColor"
  },
  aniRtHpFill = {
    sNodeName = "imgHpFill",
    sComponentName = "HpBarRectTransform"
  },
  ainColorHpDelayHighlight = {
    sNodeName = "imgHpDelayHighLight",
    sComponentName = "HpBarColor"
  },
  ainColorHpFillHighLight = {
    sNodeName = "imgHpHighLight",
    sComponentName = "HpBarColor"
  },
  ainColorHpFillRecoverLight = {
    sNodeName = "imgHpFillRecoverLight",
    sComponentName = "HpBarColor"
  },
  rtLine = {},
  rtBossIcon = {},
  rtShield = {},
  rtShieldDelay = {
    sNodeName = "imgShieldDelay",
    sComponentName = "RectTransform"
  },
  aniRtShieldDelay = {
    sNodeName = "imgShieldDelay",
    sComponentName = "HpBarRectTransform"
  },
  imgShieldDelay = {sComponentName = "Image"},
  ainColorShieldDelay = {
    sNodeName = "imgShieldDelay",
    sComponentName = "HpBarColor"
  },
  rtShieldFill = {
    sNodeName = "imgShieldFill",
    sComponentName = "RectTransform"
  },
  aniRtShieldFill = {
    sNodeName = "imgShieldFill",
    sComponentName = "HpBarRectTransform"
  },
  imgShieldFillHighLight = {sComponentName = "Image"},
  ainColorShieldFillHighLight = {
    sNodeName = "imgShieldFillHighLight",
    sComponentName = "HpBarColor"
  },
  rtToughness = {},
  rtNormal = {},
  imgBroken = {},
  imgToughnessMaskDelay = {
    sComponentName = "RectTransform"
  },
  imgToughnessMask = {
    sComponentName = "RectTransform"
  },
  rtHighlight = {
    sComponentName = "RectTransform"
  },
  Highlight = {
    sNodeName = "rtHighlight",
    sComponentName = "CanvasGroup"
  },
  imgBrokenChip = {sComponentName = "Image"},
  aniRtToughnessDelay = {
    sNodeName = "imgToughnessMaskDelay",
    sComponentName = "HpBarRectTransform"
  },
  aniRtToughnessFill = {
    sNodeName = "imgToughnessMask",
    sComponentName = "HpBarRectTransform"
  },
  ainColorToughnessHighlight = {
    sNodeName = "rtHighlight",
    sComponentName = "HpBarCanvasGroup"
  },
  ainToughnessBrokenChip = {sNodeName = "imgBroken", sComponentName = "Animator"},
  imgLight = {
    sComponentName = "RectTransform"
  },
  toughnessLockLight = {
    sComponentName = "CanvasGroup"
  },
  ainLockToughnessHighlight = {
    sNodeName = "toughnessLockLight",
    sComponentName = "HpBarCanvasGroup"
  },
  imgToughnessLock = {},
  rtShakeRoot = {sComponentName = "Animator"},
  rtBuff = {
    sCtrlName = "Game.UI.Hud.Buff.BuffCtrl"
  },
  imgHpFilBossRushBG = {},
  TMP_BossRushLv = {sComponentName = "TMP_Text"},
  TMP_BossRushLv1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Boss_Rush_Lv"
  },
  rtHPAin = {sNodeName = "rtHP", sComponentName = "Animator"},
  imgHpFilBossRushBGColor = {
    sNodeName = "imgHpFilBossRushBG",
    sComponentName = "HpBarColor"
  },
  imgHpFillColor = {sNodeName = "imgHpFill", sComponentName = "HpBarColor"},
  jointDrill_BossEnergy = {},
  jointDrill_BossEnergyValue = {sComponentName = "Image"},
  jointDrillGridCount = {},
  imgGridRed = {},
  TMP_JointDrillRed = {sComponentName = "TMP_Text", nCount = 2},
  imgGridGreen = {},
  TMP_JointDrillGreen = {sComponentName = "TMP_Text", nCount = 2},
  rtEnergy = {},
  rtEnergyCount = {},
  rtEnergyFillDelay = {
    sNodeName = "imgEnergyFillDelay",
    sComponentName = "RectTransform"
  },
  rtEnergyFill = {
    sNodeName = "imgEnergyFill",
    sComponentName = "RectTransform"
  },
  rtEnergyFillEff = {
    sNodeName = "imgEnergyFill_Eff"
  },
  aniRtEnergyDelay = {
    sNodeName = "imgEnergyFillDelay",
    sComponentName = "HpBarRectTransform"
  },
  aniRtEnergyFill = {
    sNodeName = "imgEnergyFill",
    sComponentName = "HpBarRectTransform"
  },
  ainColorEnergyFillRecoverLight = {
    sNodeName = "imgEnergyFillRecoverLight",
    sComponentName = "HpBarColor"
  },
  imgEnergyRed = {},
  TMP_EnergyRed = {sComponentName = "TMP_Text"},
  imgEnergyGreen = {},
  TMP_EnergyGreen = {sComponentName = "TMP_Text"}
}
BossHUDCtrl._mapEventConfig = {
  AllHudShow = "OnEvent_HudShow",
  BattleRestart = "OnEvent_Deaded",
  JointDrillReset = "OnEvent_JointDrillReset"
}
BossHUDCtrl._mapRedDotConfig = {}
local multipleBossIcon = {
  [GameEnum.monsterBloodType.BOSS] = "icon_story_boss1",
  [GameEnum.monsterBloodType.MINIBOSS] = "icon_story_boss2"
}

function BossHUDCtrl:PlayTweenHp(hp, hpMax)
  if self.bInit == true then
    return
  end
  local nWidth = 1 <= hp / hpMax and self.BarWidth or hp / hpMax * self.BarWidth
  if nWidth > self.BarWidth then
    nWidth = self.BarWidth
  end
  if hp < self.nBeforeHp then
    if self._mapNode.rtHpFill.sizeDelta.x > self._mapNode.rtHpFillDelay.sizeDelta.x and not self.isToughness then
      self._mapNode.aniRtHpDelay:SetTarget(self._mapNode.rtHpFill.sizeDelta, 0)
    end
    self._mapNode.aniRtHpFill:SetTarget(Vector2(nWidth, self.BarHeight), 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorWhite, 0)
    local delayTime = 0
    if not self.isToughness then
      self._mapNode.ainColorHpDelay:SetTarget(colorRed)
      if (self.nBeforeHp - hp) / hpMax > self.bigDamageThreshold then
        self._mapNode.ainColorHpDelay:SetTarget(colorWhite, 0, 0.2)
        self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0.1, AniTime)
        self._mapNode.rtShakeRoot:Play("HPShake_in")
        delayTime = 0.2
      end
      self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, self.BarHeight), AniTime, delayTime)
    else
      self._mapNode.ainColorHpDelay:SetTarget(colorWhite, 0)
    end
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + delayTime)
  else
    if not self.isToughness then
      self._mapNode.aniRtHpDelay:SetTarget(self._mapNode.rtHpFill.sizeDelta, 0)
    end
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, AniTime)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, AniTimeHighlight)
    if not self.isToughness then
      self._mapNode.ainColorHpDelay:SetTarget(colorRecover, 0)
      self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, self.BarHeight), AniTime)
    end
    self._mapNode.aniRtHpFill:SetTarget(Vector2(nWidth, self.BarHeight), AniTime, AniTime)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRed, 0)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRedHide, AniTimeHighlight, AniTime)
  end
end

function BossHUDCtrl:PlayTweenShield(shieldValue, shieldValueMax)
  local nWidth = 1 <= shieldValue / shieldValueMax and self.ShieldBarWidth or shieldValue / shieldValueMax * self.ShieldBarWidth
  if shieldValue < self.nBeforeShield then
    if self._mapNode.rtShieldDelay.sizeDelta.x < self._mapNode.rtShieldFill.sizeDelta.x then
      self._mapNode.aniRtShieldDelay:SetTarget(self._mapNode.rtShieldFill.sizeDelta, 0)
    end
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(nWidth, self.BarHeight), 0)
    NovaAPI.SetImageColor(self._mapNode.imgShieldFillHighLight, colorWhite)
    local delayTime = 0
    if (self.nBeforeShield - shieldValue) / shieldValueMax > self.bigDamageThreshold then
      NovaAPI.SetImageColor(self._mapNode.imgShieldDelay, colorWhite)
      self._mapNode.ainColorShieldDelay:SetTarget(colorShieldDelay, 0.1, AniTime)
      delayTime = 0.5
    end
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(nWidth, self.BarHeight), AniTime, delayTime)
    self._mapNode.ainColorShieldFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + delayTime)
  else
    NovaAPI.SetImageColor(self._mapNode.imgShieldFillHighLight, colorWhite)
    self._mapNode.ainColorShieldDelay:SetTarget(colorShieldDelay, 0)
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(nWidth, self.BarHeight), AniTime)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(nWidth, self.BarHeight), AniTime)
    self._mapNode.ainColorShieldFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + AniTime)
  end
end

function BossHUDCtrl:KillTweenToughness()
  self._mapNode.aniRtToughnessDelay:Stop()
  self._mapNode.aniRtToughnessFill:Stop()
  self._mapNode.ainColorToughnessHighlight:Stop()
end

function BossHUDCtrl:PlayTweenToughness(toughness, toughnessMax)
  if toughness == self.nBeforeToughness then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.toughnessLockLight, 1)
    self._mapNode.ainLockToughnessHighlight:SetTarget(0, 0.3)
  end
  self._mapNode.imgToughnessLock.gameObject:SetActive(false)
  self:KillTweenToughness()
  local nWidth = 1 <= toughness / toughnessMax and self.ToughnessWidth or toughness / toughnessMax * self.ToughnessWidth
  if self._mapNode.imgToughnessMaskDelay.sizeDelta.x < self._mapNode.imgToughnessMask.sizeDelta.x then
    self._mapNode.imgToughnessMaskDelay.sizeDelta = self._mapNode.imgToughnessMask.sizeDelta
  end
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0 < nWidth and nWidth or 0, self.ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(871 < nWidth and nWidth - 12 or nWidth - 5, 0)
  self._mapNode.imgLight.anchoredPosition = Vector2(-2, 871 < nWidth and -(nWidth - 871) * 0.75 or 3)
  local delayTime = 0
  if (self.nBeforeToughness - toughness) / toughnessMax > self.bigDamageThreshold then
    delayTime = 0.5
    self._mapNode.rtShakeRoot:Play("HPShake_in")
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 1)
  self._mapNode.ainColorToughnessHighlight:SetTarget(0, AniTime, delayTime + AniTime)
  self._mapNode.aniRtToughnessDelay:SetTarget(Vector2(nWidth, self.ToughnessHeight), AniTime, delayTime)
end

function BossHUDCtrl:PlayTweenToughnessBroken()
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0, self.ToughnessHeight)
  self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(0, self.ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(0, 0)
  self._mapNode.rtNormal:SetActive(false)
  self._mapNode.imgBroken:SetActive(true)
  self._mapNode.ainToughnessBrokenChip:Play("imgBrokenChip_in")
  self._mapNode.rtShakeRoot:Play("HPShake_in")
end

function BossHUDCtrl:PlayTweenToughnessRecover()
  self:KillTweenToughness()
  self._mapNode.aniRtToughnessFill:SetTarget(Vector2(0, self.ToughnessHeight), 0)
  self._mapNode.aniRtToughnessDelay:SetTarget(Vector2(0, self.ToughnessHeight), 0)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(self.ToughnessWidth - 12, 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 0)
  self._mapNode.rtNormal:SetActive(true)
  self._mapNode.imgBroken:SetActive(false)
  self.tweenerToughness3 = self._mapNode.aniRtToughnessFill:SetTarget(Vector2(self.ToughnessWidth, self.ToughnessHeight), ToughnessRecoverTime)
end

function BossHUDCtrl:PlayTweenEnergy(nEnergy, nMaxEnergy)
  if self.bInit == true then
    return
  end
  local nWidth = 1 <= nEnergy / nMaxEnergy and self.energyBarWidth or nEnergy / nMaxEnergy * self.energyBarWidth
  if nWidth > self.energyBarWidth then
    nWidth = self.energyBarWidth
  end
  self._mapNode.aniRtEnergyDelay:SetTarget(Vector2(nWidth, self.energyBarWidth), AnimBossEnergy, 0)
end

function BossHUDCtrl:ResetHit()
  self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0)
  self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, 0)
  self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, 0)
  self._mapNode.ainColorShieldFillHighLight:SetTarget(colorHide, 0)
  self.nBeforeHp = 0
  self.nBeforeHpMax = 0
  self.nBeforeShield1 = 0
  self.nBeforeShield2 = 0
  self.nBeforeShield3 = 0
  self.nBeforeShield4 = 0
  self.nBeforeToughness = 0
  self._mapNode.rtNormal:SetActive(true)
  self._mapNode.imgBroken:SetActive(false)
  self._mapNode.jointDrillGridCount.gameObject:SetActive(false)
  self._mapNode.rtEnergy.gameObject:SetActive(false)
  self._mapNode.rtEnergyCount.gameObject:SetActive(false)
  self.nBeforeEnergy = 0
end

function BossHUDCtrl:KillTween()
  self._mapNode.aniRtHpDelay:Stop()
  self._mapNode.ainColorHpDelay:Stop()
  self._mapNode.aniRtHpFill:Stop()
  self._mapNode.ainColorHpDelayHighlight:Stop()
  self._mapNode.ainColorHpFillHighLight:Stop()
  self._mapNode.ainColorHpFillRecoverLight:Stop()
  self._mapNode.aniRtShieldDelay:Stop()
  self._mapNode.ainColorShieldDelay:Stop()
  self._mapNode.aniRtShieldFill:Stop()
  self._mapNode.ainColorShieldFillHighLight:Stop()
  self._mapNode.aniRtToughnessDelay:Stop()
  self._mapNode.aniRtToughnessFill:Stop()
  self._mapNode.ainColorToughnessHighlight:Stop()
  self._mapNode.aniRtEnergyDelay:Stop()
  self._mapNode.aniRtEnergyFill:Stop()
  self._mapNode.ainColorEnergyFillRecoverLight:Stop()
end

function BossHUDCtrl:Awake()
  self.bigDamageThreshold = ConfigTable.GetConfigNumber("BloodSpecialEffectThresholdValue") / 100
  self.rootCanvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self.BarWidth = self._mapNode.rtHpFillDelay.sizeDelta.x
  self.BarHeight = self._mapNode.rtHpFillDelay.sizeDelta.y
  self.ToughnessWidth = self._mapNode.imgToughnessMaskDelay.sizeDelta.x
  self.ToughnessHeight = self._mapNode.imgToughnessMaskDelay.sizeDelta.y
  self.ShieldBarWidth = self._mapNode.rtShieldDelay.sizeDelta.x
  self.ShieldBar = self._mapNode.rtShieldDelay.sizeDelta.x
  self.animRtShield = self.gameObject:GetComponent("Animator")
  self.JDBossColorIndex = 0
  self.isToughness = false
  self.JointDrillBossCount = 0
  self.JointDrillEnergyStage = jointDrillEnergyStage.None
  self.energyBarWidth = self._mapNode.rtEnergyFillDelay.sizeDelta.x
  self.energyBarHeight = self._mapNode.rtEnergyFillDelay.sizeDelta.y
end

function BossHUDCtrl:OnEnable()
  self.bossId = 0
  NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, false)
  self:ResetHit()
end

function BossHUDCtrl:OnDisable()
  self:KillTween()
  self:CloseUI()
end

function BossHUDCtrl:OnDestroy()
end

function BossHUDCtrl:SetHp(hp, hpMax, bChange)
  if self.bossId == 0 then
    return
  end
  if hpMax <= 0 then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(0, self.BarHeight), 0)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(0, self.BarHeight), 0)
  elseif bChange then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(hp / hpMax * self.BarWidth, self.BarHeight), 0)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(hp / hpMax * self.BarWidth, self.BarHeight), 0)
  else
    self:PlayTweenHp(hp, hpMax)
  end
  self.nBeforeHp = hp
  self.nBeforeHpMax = hpMax
end

function BossHUDCtrl:SetBossEnergy(nEnergy, nEnergyMax, bChange)
  if self.bossId == 0 then
    return
  end
  self._mapNode.rtEnergyFill.gameObject:SetActive(nEnergyMax <= nEnergy)
  self._mapNode.rtEnergyFillEff.gameObject:SetActive(nEnergyMax <= nEnergy)
  if nEnergyMax <= nEnergy then
    self._mapNode.ainColorEnergyFillRecoverLight:SetTarget(colorWhite, 0)
  else
    self._mapNode.ainColorEnergyFillRecoverLight:SetTarget(colorHide, AniTimeHighlight, AniTime)
  end
  if nEnergy <= 0 then
    self._mapNode.aniRtEnergyDelay:SetTarget(Vector2(0, self.energyBarHeight), 0)
  elseif bChange then
    self._mapNode.aniRtEnergyDelay:SetTarget(Vector2(nEnergy / nEnergyMax * self.energyBarWidth, self.energyBarHeight), 0)
  else
    self:PlayTweenEnergy(nEnergy, nEnergyMax)
  end
  self.nBeforeEnergy = nEnergy
end

function BossHUDCtrl:OnEvent_HpChanged(hp, hpMax)
  if self.bossType == GameEnum.monsterBloodType.BOSSRUSH and self.isDontChangeHp and hp ~= hpMax then
    return
  end
  if self.bossType ~= GameEnum.monsterBloodType.JOINTDRILLBOSS then
    if hp == self.nBeforeHp then
      self:SetHp(hp, hpMax, true)
    else
      self:SetHp(hp, hpMax)
    end
  else
    local tmpHpBarNum = math.floor(hp / self.tmpJDBossHpMax) + 1
    if tmpHpBarNum < self.curBossHpBarNum then
      self.curBossHpBarNum = tmpHpBarNum
      local tmpJDBossHpCur = math.fmod(hp, self.tmpJDBossHpMax)
      self:SetHp(tmpJDBossHpCur, self.tmpJDBossHpMax, true)
      self:SetJointDrillBossHPValue()
    else
      local tmpJDBossHpCur = math.fmod(hp, self.tmpJDBossHpMax)
      self:SetHp(tmpJDBossHpCur, self.tmpJDBossHpMax)
    end
  end
end

function BossHUDCtrl:OnEvent_ToughnessStateChanged(bBroken, nValue, nToughnessMax)
  if bBroken then
    self.isToughness = true
    if self.timerToughnessState ~= nil then
      self._mapNode.aniRtHpDelay:SetTarget(Vector2(self._mapNode.rtHpFill.sizeDelta.x, self.BarHeight), 0)
      self.timerToughnessState:Cancel()
    end
    self:SetToughness(0, nToughnessMax, true)
  else
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(self._mapNode.rtHpFill.sizeDelta.x, self.BarHeight), AniTimeHighlight)
    
    local function changeToughnessState()
      self.isToughness = false
      self.timerToughnessState = nil
    end
    
    self.timerToughnessState = self:AddTimer(1, AniTimeHighlight, changeToughnessState, true, true, true)
    if nValue ~= 0 then
      self:SetToughness(nToughnessMax, nToughnessMax, true)
    end
  end
end

function BossHUDCtrl:OnEvent_ToughnessValueChanged(toughness, toughnessMax)
  self:SetToughness(toughness, toughnessMax, false)
end

function BossHUDCtrl:OnEvent_ToughnessShowStateChanged(bShow)
  if bShow then
    self._mapNode.rtToughness.transform.localScale = Vector3.one
  else
    self._mapNode.rtToughness.transform.localScale = Vector3.zero
  end
end

function BossHUDCtrl:OnEvent_Deaded()
  EventManager.Hit("MonsterBossDead", self.bossId)
  if self.isToughness then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(0, self.BarHeight), AniTime)
    
    local function changeToughnessState()
      self:CloseUI()
      NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 0)
    end
    
    self:AddTimer(1, AniTime, changeToughnessState, true, true, true)
  else
    self:CloseUI()
    NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 0)
  end
end

function BossHUDCtrl:OnEvent_JointDrillReset()
  if self.bossType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
    self.JointDrillEnergyStage = jointDrillEnergyStage.None
    local anim = self._mapNode.jointDrill_BossEnergy:GetComponent("Animator")
    if anim == nil then
      return
    end
    anim:Play("Empty")
  end
end

function BossHUDCtrl:AddEntityEvent()
  self._mapNode.rtBuff:BindEntity(self.bossId)
  EventManager.AddEntityEvent("ShieldChanged", self.bossId, self, self.OnEvent_ShieldChanged)
  EventManager.AddEntityEvent("HpChanged", self.bossId, self, self.OnEvent_HpChanged)
  EventManager.AddEntityEvent("Dead", self.bossId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("ClearSlef", self.bossId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("BossBuffChanged", self.bossId, self, self.OnEvent_BuffChanged)
  EventManager.AddEntityEvent("ToughnessStateChanged", self.bossId, self, self.OnEvent_ToughnessStateChanged)
  EventManager.AddEntityEvent("ToughnessValueChanged", self.bossId, self, self.OnEvent_ToughnessValueChanged)
  EventManager.AddEntityEvent("ToughnessShowStateChanged", self.bossId, self, self.OnEvent_ToughnessShowStateChanged)
  EventManager.AddEntityEvent("BossRushMonsterLevelChanged", self.bossId, self, self.OnEvent_BossRushMonsterLevelChanged)
  EventManager.AddEntityEvent("BossRushMonsterBattleAttrChanged", self.bossId, self, self.OnEvent_BossRushMonsterBattleAttrChanged)
  EventManager.AddEntityEvent("JointDrillBossEnergyChanged", self.bossId, self, self.OnEvent_JointDrillBossEnergyChanged)
  EventManager.AddEntityEvent("RefreshBossEnergyValueHUD", self.bossId, self, self.OnEvent_RefreshBossEnergyValueHUD)
  EventManager.AddEntityEvent("CastUltra", self.bossId, self, self.OnEvent_JointDrillBossUseSkill)
  EventManager.AddEntityEvent("RedCellNotify", self.bossId, self, self.OnEvent_RedCellNotify)
  EventManager.AddEntityEvent("GreenCellNotify", self.bossId, self, self.OnEvent_GreenCellNotify)
  EventManager.AddEntityEvent("BossEnergyValueChange", self.bossId, self, self.OnEvent_BossEnergyValueChange)
  EventManager.AddEntityEvent("BossBuffChange", self.bossId, self, self.OnEvent_BossBuffChange)
end

function BossHUDCtrl:SetBossInfo(nDataId, nType, nBloodType)
  local mapMonster = ConfigTable.GetData("Monster", nDataId)
  if mapMonster == nil then
    return
  end
  if nType == GameEnum.monsterBloodType.BOSS or nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.MINIBOSS or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
    local mapSkin = ConfigTable.GetData("MonsterSkin", mapMonster.FAId)
    if mapSkin == nil then
      return
    end
    local mapMonsterManual = ConfigTable.GetData("MonsterManual", mapSkin.MonsterManual)
    if mapMonsterManual == nil then
      return
    end
    if nBloodType == AllEnum.BossBloodType.Single or nBloodType == AllEnum.BossBloodType.JointDrill_Mode_2 then
      self:SetPngSprite(self._mapNode.BossIcon, mapMonsterManual.Icon)
    else
      local sIcon = multipleBossIcon[nType]
      self:SetAtlasSprite(self._mapNode.BossIcon, "15_battle", sIcon)
    end
    self._mapNode.rtLine:SetActive(true)
    self._mapNode.rtBossIcon:SetActive(true)
  else
    self._mapNode.rtLine:SetActive(false)
    self._mapNode.rtBossIcon:SetActive(false)
  end
end

function BossHUDCtrl:InitUI(bossId, nDataId, nType, nBloodType)
  local mapMonster = ConfigTable.GetData("Monster", nDataId)
  if mapMonster == nil then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 1)
  self.bossType = nType
  self._mapNode.rtShakeRoot.gameObject:SetActive(true)
  self._mapNode.imgHpFilBossRushBG:SetActive(nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  self._mapNode.TMP_BossRushLv1.gameObject:SetActive(nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  self:SetBossInfo(nDataId, nType, nBloodType)
  self._mapNode.jointDrill_BossEnergy:SetActive(nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS and self.maxJointDrillBossEnergy == nil then
    self.maxJointDrillBossEnergy, self.curJointDrillBossEnergy = safe_call_cs_func2(CS.AdventureModuleHelper.GetJointDrillBossEnergy, bossId)
    self:OnEvent_JointDrillBossEnergyChanged(self.curJointDrillBossEnergy)
    if self._panel.nType ~= nil then
      if self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
        self.jDBossHpBarNum = PlayerData.JointDrill_1:GetBossHpBarNum()
      elseif self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
        self.jDBossHpBarNum = PlayerData.JointDrill_2:GetBossHpBarNum()
      end
    end
  end
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
    self.JointDrillBossCount = self.JointDrillBossCount + 1
  end
  self.bossId = bossId
  self:ResetHit()
  self:KillTween()
  NovaAPI.SetTMPText(self._mapNode.TMP_MonsterName, "")
  NovaAPI.SetTMPText(self._mapNode.TMP_BossRushLv, 1)
  self.bToughnessRecover = mapMonster.ToughnessBrokenTime > 0
  if mapMonster ~= nil then
    local mSkin = ConfigTable.GetData("MonsterSkin", mapMonster.FAId)
    local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
    if mManual ~= nil then
      NovaAPI.SetTMPText(self._mapNode.TMP_MonsterName, mManual.Name)
    end
  end
  local hp = AdventureModuleHelper.GetEntityHp(self.bossId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.bossId)
  local toughness = AdventureModuleHelper.GetMonsterToughness(self.bossId)
  local toughnessMax = AdventureModuleHelper.GetMonsterToughnessMax(self.bossId)
  self._mapNode.rtToughness:SetActive(true)
  self._mapNode.rtToughness.transform.localScale = Vector3.one
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
    self.tmpJDBossHpMax = math.floor(hpMax / self.jDBossHpBarNum)
    local tmpJDBossHpCur = 0
    if hp == hpMax then
      self.curBossHpBarNum = math.floor(hp / self.tmpJDBossHpMax)
      tmpJDBossHpCur = self.tmpJDBossHpMax
    else
      self.curBossHpBarNum = math.floor(hp / self.tmpJDBossHpMax) + 1
      tmpJDBossHpCur = math.fmod(hp, self.tmpJDBossHpMax)
    end
    self:SetHp(tmpJDBossHpCur, self.tmpJDBossHpMax, true)
    self:SetJointDrillBossHPValue()
  else
    self:SetHp(hp, hpMax, true)
  end
  self:SetToughness(toughness, toughnessMax, false, true)
  local shieldValue, shieldValueMax = AdventureModuleHelper.GetEntityShieldValue(self.bossId)
  self:SetShield(shieldValue, shieldValueMax, true)
  self:AddEntityEvent()
  self.bInit = true
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS and self.JointDrillBossCount >= 2 then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0)
  else
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(0, self.BarHeight), 0)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(0, self.BarHeight), 0)
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0.5, 0.5)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0.5, 0.5)
  end
  
  local function InitCompleteCallback()
    self.bInit = false
    self:SetHp(self.nBeforeHp, self.nBeforeHpMax)
  end
  
  self:AddTimer(1, 1, InitCompleteCallback, true, true, true)
end

function BossHUDCtrl:RefreshUI(bossId, nDataId, nType, nBloodType)
  local mapMonster = ConfigTable.GetData("Monster", nDataId)
  if mapMonster == nil then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 1)
  self.bossType = nType
  self._mapNode.rtShakeRoot.gameObject:SetActive(true)
  self._mapNode.imgHpFilBossRushBG:SetActive(nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  self._mapNode.TMP_BossRushLv1.gameObject:SetActive(nType == GameEnum.monsterBloodType.BOSSRUSH or nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  self:SetBossInfo(nDataId, nType, nBloodType)
  self._mapNode.jointDrill_BossEnergy:SetActive(nType == GameEnum.monsterBloodType.JOINTDRILLBOSS)
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS and self.maxJointDrillBossEnergy == nil then
    self.maxJointDrillBossEnergy, self.curJointDrillBossEnergy = safe_call_cs_func2(CS.AdventureModuleHelper.GetJointDrillBossEnergy, bossId)
    self:OnEvent_JointDrillBossEnergyChanged(self.curJointDrillBossEnergy)
    if self._panel.nType ~= nil then
      if self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
        self.jDBossHpBarNum = PlayerData.JointDrill_1:GetBossHpBarNum()
      elseif self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
        self.jDBossHpBarNum = PlayerData.JointDrill_2:GetBossHpBarNum()
      end
    end
  end
  self.bossId = bossId
  self:KillTween()
  NovaAPI.SetTMPText(self._mapNode.TMP_MonsterName, "")
  NovaAPI.SetTMPText(self._mapNode.TMP_BossRushLv, 1)
  self.bToughnessRecover = mapMonster.ToughnessBrokenTime > 0
  if mapMonster ~= nil then
    local mSkin = ConfigTable.GetData("MonsterSkin", mapMonster.FAId)
    local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
    if mManual ~= nil then
      NovaAPI.SetTMPText(self._mapNode.TMP_MonsterName, mManual.Name)
    end
  end
  local hp = AdventureModuleHelper.GetEntityHp(self.bossId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.bossId)
  local toughness = AdventureModuleHelper.GetMonsterToughness(self.bossId)
  local toughnessMax = AdventureModuleHelper.GetMonsterToughnessMax(self.bossId)
  self._mapNode.rtToughness:SetActive(true)
  self._mapNode.rtToughness.transform.localScale = Vector3.one
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS then
    self.tmpJDBossHpMax = math.floor(hpMax / self.jDBossHpBarNum)
    local tmpJDBossHpCur = 0
    if hp == hpMax then
      self.curBossHpBarNum = math.floor(hp / self.tmpJDBossHpMax)
      tmpJDBossHpCur = self.tmpJDBossHpMax
    else
      self.curBossHpBarNum = math.floor(hp / self.tmpJDBossHpMax) + 1
      tmpJDBossHpCur = math.fmod(hp, self.tmpJDBossHpMax)
    end
    self:SetHp(tmpJDBossHpCur, self.tmpJDBossHpMax, true)
    self:SetJointDrillBossHPValue()
  else
    self:SetHp(hp, hpMax, true)
  end
  self:SetToughness(toughness, toughnessMax, false, true)
  local shieldValue, shieldValueMax = AdventureModuleHelper.GetEntityShieldValue(self.bossId)
  self:SetShield(shieldValue, shieldValueMax, true)
  self:AddEntityEvent()
  self.bInit = false
  self:SetHp(self.nBeforeHp, self.nBeforeHpMax)
end

function BossHUDCtrl:OpenUI(bossId, nDataId, nType, nBloodType, bRefresh)
  if self.bossId ~= 0 and self.bossId ~= nil then
    printError(string.format("boss血条已被EntityId为%d绑定 %d重复绑定不生效", self.bossId, bossId))
    return
  end
  local info = AdventureModuleHelper.GetEntityInfo(bossId)
  if info == nil then
    return
  end
  if not bRefresh then
    self:InitUI(bossId, nDataId, nType, nBloodType)
  else
    self:RefreshUI(bossId, nDataId, nType, nBloodType)
  end
end

function BossHUDCtrl:SetShield(shieldValue, shieldValueMax, bChange)
  if self.bossId == 0 then
    return
  end
  if shieldValue <= 0 then
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(0, self.BarHeight), 0)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(0, self.BarHeight), 0)
    if bChange then
      self.animRtShield:Play("rtShield_out_change")
    elseif 0 < self.nBeforeShield then
      self.animRtShield:Play("rtShield_out")
    end
  elseif bChange then
    self.animRtShield:Play("rtShield_in_change")
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(shieldValue / shieldValueMax * self.ShieldBarWidth, self.BarHeight), 0)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(shieldValue / shieldValueMax * self.ShieldBarWidth, self.BarHeight), 0)
  else
    if 0 >= self.nBeforeShield then
      self.animRtShield:Play("rtShield_in")
    end
    self:PlayTweenShield(shieldValue, shieldValueMax)
  end
  self.nBeforeShield = shieldValue
  self.nBeforeShieldMax = shieldValueMax
end

function BossHUDCtrl:SetToughness(toughness, toughnessMax, bState, bChange)
  if self.bossId == 0 then
    return
  end
  if toughnessMax <= 0 then
    self._mapNode.rtToughness:SetActive(false)
  elseif bChange then
    self._mapNode.imgToughnessMask.sizeDelta = Vector2(toughness / toughnessMax * self.ToughnessWidth, self.ToughnessHeight)
    self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(toughness / toughnessMax * self.ToughnessWidth, self.ToughnessHeight)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 0)
  elseif bState then
    if toughness == 0 then
      self:PlayTweenToughnessBroken()
    else
      self._mapNode.rtToughness:SetActive(true)
      self:PlayTweenToughnessRecover()
    end
  else
    self:PlayTweenToughness(toughness, toughnessMax)
  end
  self.nBeforeToughness = toughness
end

function BossHUDCtrl:OnEvent_ShieldChanged(value1, value2)
  if value1 == self.nBeforeShield then
    return
  else
    self:SetShield(value1, value2)
  end
end

function BossHUDCtrl:CloseUI()
  EventManager.RemoveEntityEvent("ShieldChanged", self.bossId, self, self.OnEvent_ShieldChanged)
  EventManager.RemoveEntityEvent("HpChanged", self.bossId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("Dead", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ToughnessStateChanged", self.bossId, self, self.OnEvent_ToughnessStateChanged)
  EventManager.RemoveEntityEvent("ToughnessValueChanged", self.bossId, self, self.OnEvent_ToughnessValueChanged)
  EventManager.RemoveEntityEvent("ToughnessShowStateChanged", self.bossId, self, self.OnEvent_ToughnessShowStateChanged)
  EventManager.RemoveEntityEvent("BossRushMonsterLevelChanged", self.bossId, self, self.OnEvent_BossRushMonsterLevelChanged)
  EventManager.RemoveEntityEvent("BossRushMonsterBattleAttrChanged", self.bossId, self, self.OnEvent_BossRushMonsterBattleAttrChanged)
  EventManager.RemoveEntityEvent("JointDrillBossEnergyChanged", self.bossId, self, self.OnEvent_JointDrillBossEnergyChanged)
  EventManager.RemoveEntityEvent("RefreshBossEnergyValueHUD", self.bossId, self, self.OnEvent_RefreshBossEnergyValueHUD)
  EventManager.RemoveEntityEvent("CastUltra", self.bossId, self, self.OnEvent_JointDrillBossUseSkill)
  EventManager.RemoveEntityEvent("RedCellNotify", self.bossId, self, self.OnEvent_RedCellNotify)
  EventManager.RemoveEntityEvent("GreenCellNotify", self.bossId, self, self.OnEvent_GreenCellNotify)
  EventManager.RemoveEntityEvent("BossEnergyValueChange", self.bossId, self, self.OnEvent_BossEnergyValueChange)
  EventManager.RemoveEntityEvent("BossBuffChange", self.bossId, self, self.OnEvent_BossBuffChange)
  self._mapNode.rtBuff:UnbindEntity()
  self.bossId = 0
  self.isToughness = false
  self.maxJointDrillBossEnergy = nil
  self.JDBossColorIndex = 0
end

function BossHUDCtrl:HideUI()
  self._mapNode.rtShakeRoot.gameObject:SetActive(false)
end

function BossHUDCtrl:OnEvent_HudShow(bShow)
  if bShow and self.bossId ~= 0 then
    NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self.rootCanvasGroup, 0)
  end
end

function BossHUDCtrl:OnEvent_BossRushMonsterLevelChanged(oldLevel, battleLevel)
  self.isDontChangeHp = true
  NovaAPI.SetTMPText(self._mapNode.TMP_BossRushLv, battleLevel)
  self._mapNode.rtHPAin:Play("BossRushHP_in")
  if self.isToughness then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0)
  end
end

function BossHUDCtrl:OnEvent_BossRushMonsterBattleAttrChanged()
  self.isDontChangeHp = false
end

function BossHUDCtrl:OnEvent_JointDrillBossEnergyChanged(curEnergy, bIsUp)
  if self.maxJointDrillBossEnergy and self.maxJointDrillBossEnergy ~= 0 then
    local val = 0.3 + curEnergy / self.maxJointDrillBossEnergy * 0.62
    NovaAPI.SetImageFillAmount(self._mapNode.jointDrill_BossEnergyValue, val)
    if bIsUp then
      self:ChangeBossEnergy(curEnergy, self.maxJointDrillBossEnergy)
    elseif curEnergy == 0 then
      self.JointDrillEnergyStage = jointDrillEnergyStage.None
    end
  else
    NovaAPI.SetImageFillAmount(self._mapNode.jointDrill_BossEnergyValue, 0)
    self.JointDrillEnergyStage = jointDrillEnergyStage.None
  end
end

function BossHUDCtrl:OnEvent_RefreshBossEnergyValueHUD(isSave)
  if not isSave then
    NovaAPI.SetImageFillAmount(self._mapNode.jointDrill_BossEnergyValue, 0)
    self.JointDrillEnergyStage = jointDrillEnergyStage.None
    local anim = self._mapNode.jointDrill_BossEnergy:GetComponent("Animator")
    if anim == nil then
      return
    end
    anim:Play("Empty")
  end
end

function BossHUDCtrl:SetJointDrillBossHPValue()
  self._mapNode.TMP_BossRushLv1.text = ""
  self._mapNode.TMP_BossRushLv.text = "x" .. self.curBossHpBarNum
  self.JDBossColorIndex = self.JDBossColorIndex + 1
  local tmpIndex = math.fmod(self.JDBossColorIndex, 3)
  if tmpIndex == 0 then
    tmpIndex = 3
  end
  self._mapNode.imgHpFillColor:SetTarget(tabColorJDBoss[tmpIndex][1])
  self._mapNode.imgHpFilBossRushBGColor:SetTarget(tabColorJDBoss[tmpIndex][2])
  if self.curBossHpBarNum == 1 then
    self._mapNode.imgHpFilBossRushBGColor.gameObject:SetActive(false)
  end
  if self.isToughness then
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(self.BarWidth, self.BarHeight), 0)
  end
end

function BossHUDCtrl:ChangeBossEnergy(curValue, maxValue)
  local anim = self._mapNode.jointDrill_BossEnergy:GetComponent("Animator")
  if anim == nil then
    return
  end
  local percent = curValue / maxValue
  if 1 <= percent then
    anim:Play("JointDrill_BossEnergy_full")
    self.JointDrillEnergyStage = jointDrillEnergyStage.Max
  elseif percent >= jointDrillEnergyAnimStage2 then
    if self.JointDrillEnergyStage < jointDrillEnergyStage.Stage2 then
      anim:Play("JointDrill_BossEnergy_recharge2")
      self.JointDrillEnergyStage = jointDrillEnergyStage.Stage2
    end
  else
    if percent >= jointDrillEnergyAnimStage1 and self.JointDrillEnergyStage < jointDrillEnergyStage.Stage1 then
      anim:Play("JointDrill_BossEnergy_recharge1")
      self.JointDrillEnergyStage = jointDrillEnergyStage.Stage1
    else
    end
  end
end

function BossHUDCtrl:OnEvent_JointDrillBossUseSkill()
  local anim = self._mapNode.jointDrill_BossEnergy:GetComponent("Animator")
  if anim == nil then
    return
  end
  anim:Play("Empty")
  self._mapNode.rtHPAin:Play("JointDrill_BossEnergy_open")
  self.JointDrillEnergyStage = jointDrillEnergyStage.None
end

function BossHUDCtrl:OnEvent_RedCellNotify(nCount)
  self._mapNode.jointDrillGridCount.gameObject:SetActive(true)
  self._mapNode.imgGridRed.gameObject:SetActive(true)
  self._mapNode.imgGridGreen.gameObject:SetActive(false)
  for _, v in ipairs(self._mapNode.TMP_JointDrillRed) do
    NovaAPI.SetTMPText(v, nCount)
  end
end

function BossHUDCtrl:OnEvent_GreenCellNotify(nCount)
  self._mapNode.jointDrillGridCount.gameObject:SetActive(true)
  self._mapNode.imgGridRed.gameObject:SetActive(false)
  self._mapNode.imgGridGreen.gameObject:SetActive(true)
  for _, v in ipairs(self._mapNode.TMP_JointDrillGreen) do
    NovaAPI.SetTMPText(v, nCount)
  end
end

function BossHUDCtrl:OnEvent_BossEnergyValueChange(nValue)
  self._mapNode.rtEnergy.gameObject:SetActive(true)
  if nValue == self.nBeforeEnergy then
    self:SetBossEnergy(nValue, bossEnergyMaxValue, true)
  else
    self:SetBossEnergy(nValue, bossEnergyMaxValue)
  end
end

function BossHUDCtrl:OnEvent_BossBuffChange(nValue1, nValue2)
  self._mapNode.rtEnergyCount.gameObject:SetActive(true)
  if nValue1 == 0 and nValue2 == 0 then
    self._mapNode.imgEnergyRed.gameObject:SetActive(false)
    self._mapNode.imgEnergyGreen.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMP_EnergyGreen, 0)
  elseif 0 < nValue1 then
    self._mapNode.imgEnergyRed.gameObject:SetActive(false)
    self._mapNode.imgEnergyGreen.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMP_EnergyGreen, nValue1)
  elseif 0 < nValue2 then
    self._mapNode.imgEnergyRed.gameObject:SetActive(true)
    self._mapNode.imgEnergyGreen.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMP_EnergyRed, nValue2)
  end
end

return BossHUDCtrl
