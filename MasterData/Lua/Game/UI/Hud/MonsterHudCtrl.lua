local MonsterHudCtrl = class("MonsterHudCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local BarHeight = 21
local BarWidth = 139
local ShieldWidth = 103
local AniTimeHighlight = 0.5
local AniTime = 0.16
local ToughnessRecoverTime = 0.3
local ToughnessWidth = 208
local ToughnessHeight = 21
local colorHide = Color(1, 1, 1, 0)
local colorWhite = Color(1, 1, 1, 1)
local colorShieldDelay = Color(1, 1, 1, 0.5)
local colorRed = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 1)
local colorRedHide = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 0)
local colorRecover = Color(0.9921568627450981, 0.5098039215686274, 0, 1)
MonsterHudCtrl._mapNodeConfig = {
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
  ainColorToughnessBrokenChip = {
    sNodeName = "imgBrokenChip",
    sComponentName = "Animator"
  },
  rtShakeRoot = {sComponentName = "Animator"},
  aniFadeHpBar = {
    sNodeName = "rtShakeRoot",
    sComponentName = "HpBarCanvasGroup"
  },
  rtBuff = {
    sCtrlName = "Game.UI.Hud.Buff.BuffCtrl"
  }
}
MonsterHudCtrl._mapEventConfig = {}

function MonsterHudCtrl:PlayTweenHp(hp, hpMax)
  local nWidth = 1 <= hp / hpMax and BarWidth or hp / hpMax * BarWidth
  if nWidth > BarWidth then
    nWidth = BarWidth
  end
  if hp < self.nBeforeHp then
    if self._mapNode.rtHpFill.sizeDelta.x > self._mapNode.rtHpFillDelay.sizeDelta.x then
      self._mapNode.aniRtHpDelay:SetTarget(self._mapNode.rtHpFill.sizeDelta, 0)
    end
    self._mapNode.aniRtHpFill:SetTarget(Vector2(nWidth, BarHeight), 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpDelay:SetTarget(colorRed)
    local delayTime = 0
    if (self.nBeforeHp - hp) / hpMax > self.bigDamageThreshold then
      self._mapNode.ainColorHpDelay:SetTarget(colorWhite, 0)
      self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0.1, AniTime)
      delayTime = 0.5
      self._mapNode.rtShakeRoot:Play("HPShake_in")
    end
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime, delayTime)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + delayTime)
  else
    self._mapNode.rtHpFillDelay.sizeDelta = self._mapNode.rtHpFill.sizeDelta
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, AniTime)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, AniTimeHighlight)
    self._mapNode.ainColorHpDelay:SetTarget(colorRecover)
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(nWidth, BarHeight), AniTime, AniTime)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRed, 0)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRedHide, AniTimeHighlight, AniTime)
  end
end

function MonsterHudCtrl:PlayTweenShield(shieldValue, shieldValueMax)
  local nWidth = 1 <= shieldValue / shieldValueMax and ShieldWidth or shieldValue / shieldValueMax * ShieldWidth
  if shieldValue < self.nBeforeShield then
    if self._mapNode.rtShieldDelay.sizeDelta.x < self._mapNode.rtShieldFill.sizeDelta.x then
      self._mapNode.rtShieldDelay.sizeDelta = self._mapNode.rtShieldFill.sizeDelta
    end
    self._mapNode.rtShieldFill.sizeDelta = Vector2(nWidth, BarHeight)
    NovaAPI.SetImageColor(self._mapNode.imgShieldFillHighLight, colorWhite)
    local delayTime = 0
    if (self.nBeforeShield - shieldValue) / shieldValueMax > self.bigDamageThreshold then
      NovaAPI.SetImageColor(self._mapNode.imgShieldDelay, colorWhite)
      self._mapNode.ainColorShieldDelay:SetTarget(colorShieldDelay, 0.1, AniTime)
      delayTime = 0.5
    end
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime, delayTime)
    self._mapNode.ainColorShieldFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + delayTime)
  else
    NovaAPI.SetImageColor(self._mapNode.imgShieldFillHighLight, colorWhite)
    self._mapNode.ainColorShieldDelay:SetTarget(colorShieldDelay, 0)
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(nWidth, BarHeight), AniTime)
    self._mapNode.ainColorShieldFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + AniTime)
  end
end

function MonsterHudCtrl:KillTweenToughness()
  self._mapNode.aniRtToughnessDelay:Stop()
  self._mapNode.aniRtToughnessFill:Stop()
  self._mapNode.ainColorToughnessHighlight:Stop()
end

function MonsterHudCtrl:PlayTweenToughness(toughness, toughnessMax)
  self:KillTweenToughness()
  local nWidth = 1 <= toughness / toughnessMax and ToughnessWidth or toughness / toughnessMax * ToughnessWidth
  if nWidth > ToughnessWidth then
    nWidth = ToughnessWidth
  end
  if self._mapNode.imgToughnessMaskDelay.sizeDelta.x < self._mapNode.imgToughnessMask.sizeDelta.x then
    self._mapNode.imgToughnessMaskDelay.sizeDelta = self._mapNode.imgToughnessMask.sizeDelta
  end
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0 < nWidth and nWidth or 0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(0 < nWidth and nWidth - 12 or 0, 0)
  local delayTime = 0
  if (self.nBeforeToughness - toughness) / toughnessMax > self.bigDamageThreshold then
    delayTime = 0.5
    self._mapNode.rtShakeRoot:Play("HPShake_in")
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 1)
  self._mapNode.ainColorToughnessHighlight:SetTarget(0, AniTime, delayTime + AniTime)
  self._mapNode.aniRtToughnessDelay:SetTarget(Vector2(nWidth, ToughnessHeight), AniTime, delayTime)
end

function MonsterHudCtrl:PlayTweenToughnessBroken()
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(0, 0)
  self._mapNode.rtNormal:SetActive(false)
  self._mapNode.imgBroken:SetActive(true)
  self._mapNode.ainColorToughnessBrokenChip:Play("imgBrokenChip_in")
  self._mapNode.rtShakeRoot:Play("HPShake_in")
end

function MonsterHudCtrl:PlayTweenToughnessRecover()
  self:KillTweenToughness()
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(ToughnessWidth - 12, 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 0)
  self._mapNode.rtNormal:SetActive(true)
  self._mapNode.imgBroken:SetActive(false)
  self.tweenerToughness3 = self._mapNode.aniRtToughnessFill:SetTarget(Vector2(ToughnessWidth, ToughnessHeight), ToughnessRecoverTime)
end

function MonsterHudCtrl:ResetHit()
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
end

function MonsterHudCtrl:KillTween()
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
end

function MonsterHudCtrl:Awake()
  self.monsterId = 0
  self.bigDamageThreshold = ConfigTable.GetConfigNumber("BloodSpecialEffectThresholdValue") / 100
  self._Timer = nil
end

function MonsterHudCtrl:OnEnable()
  self.monsterId = 0
  self:ResetHit()
end

function MonsterHudCtrl:OnDisable()
  self._mapNode.rtBuff:UnbindEntity()
  EventManager.RemoveEntityEvent("HpChanged", self.monsterId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ShieldChanged", self.monsterId, self, self.OnEvent_ShieldChanged)
  self.monsterId = 0
  self:KillTween()
  self:ResetHit()
end

function MonsterHudCtrl:OnDestroy()
end

function MonsterHudCtrl:HideHpBar()
  self._mapNode.aniFadeHpBar:SetTarget(0, 0.5)
end

function MonsterHudCtrl:SetMonsterId(monsterId, nType)
  if self.monsterId == monsterId then
    return
  end
  if nType == GameEnum.monsterBloodType.SIMPLE then
    self._Timer = self:AddTimer(1, 5, "HideHpBar", false, false, true, nil)
    self._mapNode.aniFadeHpBar:SetTarget(0)
  else
    self._mapNode.aniFadeHpBar:SetTarget(1)
    self._Timer = nil
  end
  self.monsterId = monsterId
  self.nType = nType
  self:ResetHit()
  self:KillTween()
  local hp = AdventureModuleHelper.GetEntityHp(self.monsterId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.monsterId)
  self._mapNode.rtToughness.transform.localScale = Vector3.one
  local toughness = AdventureModuleHelper.GetMonsterToughness(self.monsterId)
  local toughnessMax = AdventureModuleHelper.GetMonsterToughnessMax(self.monsterId)
  self:SetHp(hp, hpMax, true)
  self:SetToughness(toughness, toughnessMax, false, true)
  local shieldValue, shieldValueMax = AdventureModuleHelper.GetEntityShieldValue(self.monsterId)
  self:SetShield(shieldValue, shieldValueMax, true)
  self._mapNode.rtBuff:BindEntity(self.monsterId)
  EventManager.AddEntityEvent("HpChanged", self.monsterId, self, self.OnEvent_HpChanged)
  EventManager.AddEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("ShieldChanged", self.monsterId, self, self.OnEvent_ShieldChanged)
end

function MonsterHudCtrl:SetHp(hp, hpMax, bChange)
  if self.monsterId == 0 then
    return
  end
  if hpMax <= 0 then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(0, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(0, BarHeight)
  elseif bChange then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
  else
    self:PlayTweenHp(hp, hpMax)
  end
  self.nBeforeHp = hp
  self.nBeforeHpMax = hpMax
end

function MonsterHudCtrl:SetToughness(toughness, toughnessMax, bState, bChange)
  if self.monsterId == 0 then
    return
  end
  if toughnessMax <= 0 then
    self._mapNode.rtToughness:SetActive(false)
  elseif bChange then
    self._mapNode.imgToughnessMask.sizeDelta = Vector2(toughness / toughnessMax * ToughnessWidth, ToughnessHeight)
    self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(toughness / toughnessMax * ToughnessWidth, ToughnessHeight)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 0)
  elseif bState then
    if toughness == 0 then
      self:PlayTweenToughnessBroken()
    else
      self:PlayTweenToughnessRecover()
    end
  else
    self:PlayTweenToughness(toughness, toughnessMax)
  end
  self.nBeforeToughness = toughness
end

function MonsterHudCtrl:OnEvent_HpChanged(hp, hpMax)
  if hp == self.nBeforeHp then
    self:SetHp(hp, hpMax, true)
  else
    self:SetHp(hp, hpMax)
    self._mapNode.aniFadeHpBar:SetTarget(1)
    if self._Timer ~= nil then
      self._Timer:Reset()
    end
  end
end

function MonsterHudCtrl:OnEvent_ShieldChanged(value1, value2)
  if value1 == self.nBeforeShield then
    self:SetShield(value1, value2, true)
  else
    self:SetShield(value1, value2)
    self._mapNode.aniFadeHpBar:SetTarget(1)
    if self._Timer ~= nil then
      self._Timer:Reset()
    end
  end
end

function MonsterHudCtrl:OnEvent_ToughnessStateChanged(bBroken, nValue, nToughnessMax)
  if bBroken then
    self:SetToughness(0, nToughnessMax, true)
  elseif nValue ~= 0 then
    self:SetToughness(nToughnessMax, nToughnessMax, true)
  end
end

function MonsterHudCtrl:OnEvent_ToughnessValueChanged(toughness, toughnessMax)
  self:SetToughness(toughness, toughnessMax, false)
end

function MonsterHudCtrl:OnEvent_ToughnessShowStateChanged(bShow)
  if bShow then
    self._mapNode.rtToughness.transform.localScale = Vector3.one
  else
    self._mapNode.rtToughness.transform.localScale = Vector3.zero
  end
end

function MonsterHudCtrl:SetShield(shieldValue, shieldValueMax, bChange)
  if self.monsterId == 0 then
    return
  end
  if shieldValue <= 0 then
    self._mapNode.rtShield:SetActive(false)
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(0, BarHeight), 0)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(0, BarHeight), 0)
  elseif bChange then
    self._mapNode.rtShield:SetActive(true)
    self._mapNode.aniRtShieldDelay:SetTarget(Vector2(shieldValue / shieldValueMax * ShieldWidth, BarHeight), 0)
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(shieldValue / shieldValueMax * ShieldWidth, BarHeight), 0)
  else
    self._mapNode.rtShield:SetActive(true)
    self:PlayTweenShield(shieldValue, shieldValueMax)
  end
  self.nBeforeShield = shieldValue
  self.nBeforeShieldMax = shieldValueMax
end

function MonsterHudCtrl:OnEvent_Deaded()
  self._mapNode.rtBuff:UnbindEntity()
  EventManager.RemoveEntityEvent("HpChanged", self.monsterId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ShieldChanged", self.monsterId, self, self.OnEvent_ShieldChanged)
  EventManager.Hit("MonsterHUDChange", self.monsterId, self.nType, false)
end

return MonsterHudCtrl
