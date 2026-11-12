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
  rtShakeRoot = {sComponentName = "Animator"},
  aniFadeHpBar = {
    sNodeName = "rtShakeRoot",
    sComponentName = "HpBarCanvasGroup"
  }
}
MonsterHudCtrl._mapEventConfig = {}
MonsterHudCtrl._mapRedDotConfig = {}

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
  EventManager.RemoveEntityEvent("HpChanged", self.nEntityId, self, self.OnEvent_HpChanged)
  self.monsterId = 0
  self:KillTween()
  self:ResetHit()
end

function MonsterHudCtrl:ResetHit()
  self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0)
  self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, 0)
  self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, 0)
  self.nBeforeHp = 0
  self.nBeforeHpMax = 0
end

function MonsterHudCtrl:SetMonsterId(nEntityId)
  if self.nEntityId ~= nil and self.nEntityId ~= 0 then
    EventManager.RemoveEntityEvent("HpChanged", self.nEntityId, self, self.OnEvent_HpChanged)
  end
  self.nEntityId = nEntityId
  self:KillTween()
  local hp = AdventureModuleHelper.GetEntityHp(self.nEntityId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.nEntityId)
  self:SetHp(hp, hpMax, true)
  EventManager.AddEntityEvent("HpChanged", self.nEntityId, self, self.OnEvent_HpChanged)
end

function MonsterHudCtrl:SetHp(hp, hpMax, bChange)
  if self.nEntityId == 0 then
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

function MonsterHudCtrl:KillTween()
  self._mapNode.aniRtHpDelay:Stop()
  self._mapNode.ainColorHpDelay:Stop()
  self._mapNode.aniRtHpFill:Stop()
  self._mapNode.ainColorHpDelayHighlight:Stop()
  self._mapNode.ainColorHpFillHighLight:Stop()
  self._mapNode.ainColorHpFillRecoverLight:Stop()
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

return MonsterHudCtrl
