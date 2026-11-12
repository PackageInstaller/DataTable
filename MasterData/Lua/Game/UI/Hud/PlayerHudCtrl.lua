local PlayerHudCtrl = class("PlayerHudCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local nShieldParam = 0.3
local nShieldParamPower = 0.5
local BarHeight = 21
local BarWidth = 166
local ShieldBarHeight = 32
local ShieldBarWidth = 190
local ShieldDelayHeight = 21
local AniTimeHighlight = 0.5
local AniTime = 0.16
local AniTimeShield = 0.5
local ToughnessRecoverTime = 0.3
local ToughnessWidth = 208
local ToughnessHeight = 21
local colorHide = Color(1, 1, 1, 0)
local colorWhite = Color(1, 1, 1, 1)
local colorShieldDelay = Color(1, 1, 1, 0.5)
local colorRed = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 1)
local colorRedHide = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 0)
local colorRecover = Color(0.043137254901960784, 0.9921568627450981, 0.7568627450980392, 1)
local colorGreen = Color(0.5568627450980392, 0.8274509803921568, 0.28627450980392155, 1)
local colorGreenHide = Color(0.5568627450980392, 0.8274509803921568, 0.28627450980392155, 0)
local bulletType = {
  [1] = "icon_bullet_1",
  [2] = "icon_bullet_2",
  [3] = "icon_bullet_3",
  [4] = "icon_bullet_4",
  [5] = "icon_bullet_5"
}
PlayerHudCtrl._mapNodeConfig = {
  canvasGroup = {
    sNodeName = "rtRoot",
    sComponentName = "CanvasGroup"
  },
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
  ainColorimgBigHit = {sNodeName = "imgBigHit", sComponentName = "HpBarColor"},
  imgBg2 = {},
  aniShield = {
    sComponentName = "Animator",
    sNodeName = "rtShieldMask"
  },
  rtShieldMask = {
    sComponentName = "RectTransform"
  },
  rtShieldMaskAin = {
    sNodeName = "rtShieldMask",
    sComponentName = "HpBarRectTransform"
  },
  imgShieldDelay = {
    sComponentName = "RectTransform"
  },
  imgShieldDelayAin = {
    sNodeName = "imgShieldDelay",
    sComponentName = "HpBarRectTransform"
  },
  imgShieldFillHighLight = {
    sComponentName = "RectTransform"
  },
  imgShieldFillHighLightAni = {
    sNodeName = "imgShieldFillHighLight",
    sComponentName = "HpBarColor"
  },
  imgShieldFillLIght = {sComponentName = "HpBarColor"},
  AmmoBar = {sNodeName = "AmmoBar"},
  AmmoBarAnim = {sNodeName = "AmmoBar", sComponentName = "Animator"},
  txtAmmoCount = {sComponentName = "TMP_Text"},
  AmmoIcon = {sComponentName = "Image"},
  JsAniObj = {sNodeName = "JsAniObj"},
  rtShakeRoot = {sComponentName = "Animator"},
  rtBuff = {
    sCtrlName = "Game.UI.Hud.Buff.BuffCtrl"
  }
}
PlayerHudCtrl._mapEventConfig = {
  ShowPlayerHudRootCanvas = "OnEvent_ShowPlayerHudRootCanvas",
  PlayerSwitchGun = "OnEvent_PlayerSwitchGun"
}

function PlayerHudCtrl:PlayTweenHp(hp, hpMax)
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
    local delayTime = 0
    if (self.nBeforeHp - hp) / hpMax > self.bigDamageThreshold then
      self._mapNode.ainColorHpDelay:SetTarget(colorWhite, 0)
      self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0.1, AniTime)
      self._mapNode.rtShakeRoot:Play("HPShake_in")
      delayTime = 0.5
    end
    if hp / hpMax < 0.25 then
      self._mapNode.ainColorimgBigHit:SetTarget(colorWhite, 0)
      self._mapNode.ainColorimgBigHit:SetTarget(colorHide, AniTime, 0.5)
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
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorGreen, 0)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorGreenHide, AniTimeHighlight, AniTime)
  end
end

function PlayerHudCtrl:PlayTweenShield(shieldValue, shieldValueMax)
  local nShieldPersent = shieldValue / self.nBeforeHpMax
  if nShieldPersent < 0.3 then
    nShieldPersent = (nShieldParam * nShieldPersent) ^ nShieldParamPower
  end
  local nWidth = math.min(nShieldPersent, 1) * ShieldBarWidth
  local nHighlightPos = math.min(nShieldPersent, 1) * 180 + 8
  local nBeforePersent = self.nBeforeShield / self.nBeforeHpMax
  if nBeforePersent < 0.3 then
    nBeforePersent = (nShieldParam * nBeforePersent) ^ nShieldParamPower
  end
  local nSumWidth = math.min(nBeforePersent - nShieldPersent, 1) * ShieldBarWidth
  if nSumWidth + nWidth > ShieldBarWidth then
    nSumWidth = ShieldBarWidth - nWidth
  end
  if shieldValue < self.nBeforeShield then
    self._mapNode.imgShieldFillHighLight.anchoredPosition = Vector2(nHighlightPos, 0)
    self._mapNode.imgShieldDelay.anchoredPosition = Vector2(nHighlightPos, 0)
    self._mapNode.imgShieldFillHighLightAni:SetTarget(colorWhite, 0)
    self._mapNode.imgShieldFillHighLightAni:SetTarget(colorHide, AniTimeShield * 1.5)
    self._mapNode.imgShieldFillLIght:SetTarget(colorWhite, 0)
    self._mapNode.imgShieldFillLIght:SetTarget(colorHide, AniTimeShield)
    self._mapNode.rtShieldMaskAin:SetTarget(Vector2(nWidth, ShieldBarHeight), AniTimeShield)
    self._mapNode.imgShieldDelay.anchoredPosition = Vector2(nWidth, 0)
    self._mapNode.imgShieldDelayAin:SetTarget(Vector2(nSumWidth, ShieldBarHeight), 0)
    self._mapNode.imgShieldDelayAin:SetTarget(Vector2(0, ShieldBarHeight), AniTimeShield, AniTimeShield * 0.5)
  elseif self.nBeforeShield <= 0 and 0 < shieldValue then
    self._mapNode.rtShieldMaskAin:SetTarget(Vector2(nWidth, ShieldBarHeight), 0)
    self._mapNode.imgShieldFillLIght:SetTarget(colorHide, 0)
    self._mapNode.aniShield:Play("PlayShield_in")
  else
    self._mapNode.imgShieldDelayAin:SetTarget(Vector2(0, BarHeight), 0)
    self._mapNode.imgShieldFillHighLightAni:SetTarget(colorHide, 0)
    self._mapNode.rtShieldMaskAin:SetTarget(Vector2(nWidth, ShieldBarHeight), AniTimeShield)
    self._mapNode.imgShieldFillLIght:SetTarget(colorWhite, 0)
    self._mapNode.imgShieldFillLIght:SetTarget(colorHide, AniTimeShield)
  end
end

function PlayerHudCtrl:ResetHit()
  self._mapNode.ainColorHpDelay:SetTarget(colorRed, 0)
  self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, 0)
  self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, 0)
  self._mapNode.imgShieldFillHighLightAni:SetTarget(colorHide, 0)
  self._mapNode.ainColorimgBigHit:SetTarget(colorHide, 0)
  self.nBeforeHp = 0
  self.nBeforeHpMax = 0
  self.nBeforeShield1 = 0
  self.nBeforeShield2 = 0
  self.nBeforeShield3 = 0
  self.nBeforeShield4 = 0
end

function PlayerHudCtrl:KillTween()
  self._mapNode.aniRtHpDelay:Stop()
  self._mapNode.ainColorHpDelay:Stop()
  self._mapNode.aniRtHpFill:Stop()
  self._mapNode.ainColorHpDelayHighlight:Stop()
  self._mapNode.ainColorHpFillHighLight:Stop()
  self._mapNode.ainColorHpFillRecoverLight:Stop()
  self._mapNode.rtShieldMaskAin:Stop()
  self._mapNode.imgShieldDelayAin:Stop()
  self._mapNode.imgShieldFillHighLightAni:Stop()
end

function PlayerHudCtrl:Awake()
  self.playerId = 0
  self.bigDamageThreshold = ConfigTable.GetConfigNumber("BloodSpecialEffectThresholdValue") / 100
end

function PlayerHudCtrl:OnEnable()
  self.playerId = 0
  self.bBloodVisible = true
  self._mapNode.AmmoBar:SetActive(false)
  self:ResetHit()
end

function PlayerHudCtrl:OnDisable()
  self._mapNode.rtBuff:UnbindEntity()
  EventManager.RemoveEntityEvent("HpChanged", self.playerId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("AmmoChanged", self.playerId, self, self.OnEvent_AmmoChanged)
  EventManager.RemoveEntityEvent("BuffReduceTime", self.playerId, self, self.OnEvent_JsAniObjActive)
  EventManager.RemoveEntityEvent("ShieldChanged", self.playerId, self, self.OnEvent_ShieldChanged)
  EventManager.RemoveEntityEvent("PlayerDeathStateEnter", self.playerId, self, self.OnEvent_Deaded)
  self.playerId = 0
  self:KillTween()
  self:ResetHit()
end

function PlayerHudCtrl:OnDestroy()
end

function PlayerHudCtrl:SetPlayerId(playerId)
  if self.playerId == playerId then
    return
  end
  if NovaAPI.GetEntryLevelFade() then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  end
  self.playerId = playerId
  self._mapNode.rtBuff:BindEntity(self.playerId)
  self:ResetHit()
  self:KillTween()
  local ammoMax = AdventureModuleHelper.GetEntityAmmoMax(self.playerId)
  local ammoCount = AdventureModuleHelper.GetEntityAmmoCount(self.playerId)
  local bulletType = AdventureModuleHelper.GetEntityBulletType(self.playerId)
  self:SetAmmo(ammoCount, ammoMax)
  self:SetAmmoIcon(bulletType)
  local hp = AdventureModuleHelper.GetEntityHp(self.playerId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.playerId)
  self:SetHp(hp, hpMax, true)
  local activeJs = AdventureModuleHelper.GetEntityHaveBuffTimeReduce(self.playerId)
  self:OnEvent_JsAniObjActive(activeJs)
  local shieldValue, shieldValueMax = AdventureModuleHelper.GetEntityShieldValue(self.playerId)
  self:SetShield(shieldValue, shieldValueMax, true)
  EventManager.AddEntityEvent("HpChanged", self.playerId, self, self.OnEvent_HpChanged)
  EventManager.AddEntityEvent("AmmoChanged", self.playerId, self, self.OnEvent_AmmoChanged)
  EventManager.AddEntityEvent("BuffReduceTime", self.playerId, self, self.OnEvent_JsAniObjActive)
  EventManager.AddEntityEvent("ShieldChanged", self.playerId, self, self.OnEvent_ShieldChanged)
  EventManager.AddEntityEvent("PlayerDeathStateEnter", self.playerId, self, self.OnEvent_Deaded)
end

function PlayerHudCtrl:SetHp(hp, hpMax, bChange)
  if self.playerId == 0 then
    return
  end
  if hpMax <= 0 then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(0, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(0, BarHeight)
  elseif bChange then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorGreenHide, 0)
  else
    self:PlayTweenHp(hp, hpMax)
  end
  self.nBeforeHp = hp
  self.nBeforeHpMax = hpMax
  self._mapNode.imgBg2:SetActive(hp / hpMax < 0.25)
end

function PlayerHudCtrl:OnEvent_HpChanged(hp, hpMax)
  if hp == self.nBeforeHp then
    self:SetHp(hp, hpMax, true)
  else
    self:SetHp(hp, hpMax)
  end
  if hpMax ~= self.nBeforeHpMax then
    self:SetShield(self.nBeforeShield, self.nBeforeShieldMax, true)
  end
end

function PlayerHudCtrl:OnEvent_ShieldChanged(value1, value2)
  self:SetShield(value1, value2)
end

function PlayerHudCtrl:OnEvent_AmmoChanged(ammo, ammoMax)
  self:SetAmmo(ammo, ammoMax)
end

function PlayerHudCtrl:OnEvent_JsAniObjActive(active)
  self._mapNode.JsAniObj:SetActive(active)
end

function PlayerHudCtrl:SetShield(shieldValue, shieldValueMax, bChange)
  if self.playerId == 0 then
    return
  end
  if shieldValue <= 0 then
    self._mapNode.rtShieldMaskAin:SetTarget(Vector2(0, BarHeight), 0)
    self._mapNode.imgShieldDelayAin:SetTarget(Vector2(0, BarHeight), 0)
    self._mapNode.imgShieldFillHighLightAni:SetTarget(colorHide, 0)
  elseif bChange then
    self._mapNode.imgShieldDelayAin:SetTarget(Vector2(0, BarHeight), 0)
    self._mapNode.imgShieldFillHighLightAni:SetTarget(colorHide, 0)
    local nShieldPersent = shieldValue / self.nBeforeHpMax
    if nShieldPersent < 0.3 then
      nShieldPersent = (nShieldParam * nShieldPersent) ^ nShieldParamPower
    end
    local nWidth = math.min(nShieldPersent, 1) * BarWidth
    self._mapNode.rtShieldMaskAin:SetTarget(Vector2(nWidth, BarHeight), 0)
    self._mapNode.imgShieldFillLIght:SetTarget(colorHide, 0)
  else
    self:PlayTweenShield(shieldValue, shieldValueMax)
  end
  self.nBeforeShield = shieldValue
  self.nBeforeShieldMax = shieldValueMax
  if 0 < shieldValue then
    self._mapNode.rtBuff:AddShield()
  else
    self._mapNode.rtBuff:RemoveShield()
  end
end

function PlayerHudCtrl:SetAmmo(ammo, ammoMax)
  if 0 < ammoMax then
    self._mapNode.AmmoBar:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtAmmoCount, ammo)
  else
    self._mapNode.AmmoBar:SetActive(false)
  end
end

function PlayerHudCtrl:SetAmmoIcon(type)
  if type ~= 0 then
    local spriteBullet = bulletType[type]
    self:SetAtlasSprite(self._mapNode.AmmoIcon, "15_battle", spriteBullet)
  end
end

function PlayerHudCtrl:OnEvent_Deaded()
  EventManager.Hit("PlayerShow", self.playerId, false)
end

function PlayerHudCtrl:SetBloodVisible(bShow)
  self.bBloodVisible = bShow
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bShow and 1 or 0)
end

function PlayerHudCtrl:OnEvent_ShowPlayerHudRootCanvas()
  if self.bBloodVisible == false then
    NovaAPI.SetEntryLevelFade(false)
    return
  end
  local sequence = DOTween.Sequence()
  sequence:Append(self._mapNode.canvasGroup:DOFade(1, 0.7):SetUpdate(true))
  sequence:AppendCallback(function()
    NovaAPI.SetEntryLevelFade(false)
  end)
  sequence:SetUpdate(true)
end

function PlayerHudCtrl:OnEvent_PlayerSwitchGun(type)
  local function waitCallback()
    self:SetAmmoIcon(type)
    
    self._mapNode.AmmoBarAnim:Play("AmmoBar_in")
  end
  
  self._mapNode.AmmoBarAnim:Play("AmmorBar_out")
  self:AddTimer(1, 0.2, waitCallback, true, true, true, nil)
end

return PlayerHudCtrl
