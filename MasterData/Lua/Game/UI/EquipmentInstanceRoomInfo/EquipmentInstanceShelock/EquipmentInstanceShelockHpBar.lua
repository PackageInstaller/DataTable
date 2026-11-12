local AdventureModuleHelper = CS.AdventureModuleHelper
local EquipmentInstanceShelockHpBar = class("EquipmentInstanceShelockHpBar", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ConfigData = require("GameCore.Data.ConfigData")
local ResType = GameResourceLoader.ResType
local MinShowBuff = 8
local BarHeight = 21
local BarWidth = 640
local lineOffset = 9
local AniTimeHighlight = 0.5
local AniTime = 0.16
local ToughnessRecoverTime = 0.3
local ToughnessWidth = 680
local ToughnessHeight = 21
local colorHide = Color(1, 1, 1, 0)
local colorWhite = Color(1, 1, 1, 1)
local colorShieldDelay = Color(1, 1, 1, 0.5)
local colorRed = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 1)
local colorRedHide = Color(0.9176470588235294, 0.043137254901960784, 0.08627450980392157, 0)
local colorRecover = Color(0.9921568627450981, 0.5098039215686274, 0, 1)
EquipmentInstanceShelockHpBar._mapNodeConfig = {
  BossCanvas = {sNodeName = "rtHPRoot", sComponentName = "Canvas"},
  BossCanvasGroup = {
    sNodeName = "rtHPRoot",
    sComponentName = "CanvasGroup"
  },
  BuffScrollView = {
    sComponentName = "LoopScrollView"
  },
  cgBuffScrollView = {
    sNodeName = "BuffScrollView",
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
  imgLine = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
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
  imgLight = {
    sComponentName = "RectTransform"
  },
  rtShakeRoot = {sComponentName = "Animator"},
  rtBuff = {
    sCtrlName = "Game.UI.Hud.Buff.BuffCtrl"
  },
  DailyShelockblood = {nCount = 3}
}
EquipmentInstanceShelockHpBar._mapEventConfig = {
  AllHudShow = "OnEvent_HudShow"
}

function EquipmentInstanceShelockHpBar:InitBuff()
  self.buffList = nil
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBuffScrollView, 0)
  local buffList = AdventureModuleHelper.GetEntityBuffList(self.bossId)
  if not buffList then
    self._mapNode.BuffScrollView.gameObject:SetActive(false)
    return
  end
  self.buffList = {}
  for i = 0, buffList.Count - 1 do
    local nBuffId = buffList[i].buffConfig.Id
    if ConfigTable.GetData_Buff(nBuffId).IsShow then
      table.insert(self.buffList, {
        nId = buffList[i].buffConfig.Id,
        nNum = buffList[i]:GetBuffNum(),
        nLeftTime = buffList[i]:GetBuffLeftTime():AsFloat()
      })
    end
  end
  self:RefreshBuff()
end

function EquipmentInstanceShelockHpBar:RefreshBuff()
  local curCount = #self.buffList
  if 0 < curCount then
    self._mapNode.BuffScrollView.gameObject:SetActive(true)
    self._mapNode.BuffScrollView:Init(curCount, self, self.OnGridRefresh)
    NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgBuffScrollView, curCount > MinShowBuff)
  else
    self._mapNode.BuffScrollView.gameObject:SetActive(false)
  end
end

function EquipmentInstanceShelockHpBar:OnGridRefresh(goGrid, gridIndex)
  local index = gridIndex + 1
  local imgIcon = goGrid.transform:Find("imgBuffIcon"):GetComponent("Image")
  local txtCount = goGrid.transform:Find("imgBuffIcon/txtBuffCount"):GetComponent("TMP_Text")
  local nBuffId = self.buffList[index].nId
  local config = ConfigTable.GetData_Buff(nBuffId)
  local nBuffNum = self.buffList[index].nNum
  local nLeftTime = self.buffList[index].nLeftTime
  NovaAPI.SetTMPText(txtCount, nBuffNum)
end

function EquipmentInstanceShelockHpBar:PlayTweenHp(hp, hpMax)
  if self.bInit == true then
    return
  end
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
      self._mapNode.rtShakeRoot:Play("HPShake_in")
      delayTime = 0.5
    end
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime, delayTime)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, 0.2 + delayTime)
  else
    self._mapNode.aniRtHpDelay:SetTarget(self._mapNode.rtHpFill.sizeDelta, 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpFillHighLight:SetTarget(colorHide, AniTimeHighlight, AniTime)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorWhite, 0)
    self._mapNode.ainColorHpDelayHighlight:SetTarget(colorHide, AniTimeHighlight)
    self._mapNode.ainColorHpDelay:SetTarget(colorRecover, 0)
    self._mapNode.aniRtHpDelay:SetTarget(Vector2(nWidth, BarHeight), AniTime)
    self._mapNode.aniRtHpFill:SetTarget(Vector2(nWidth, BarHeight), AniTime, AniTime)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRed, 0)
    self._mapNode.ainColorHpFillRecoverLight:SetTarget(colorRedHide, AniTimeHighlight, AniTime)
  end
end

function EquipmentInstanceShelockHpBar:PlayTweenShield(shieldValue, shieldValueMax)
  local nWidth = 1 <= shieldValue / shieldValueMax and BarWidth or shieldValue / shieldValueMax * BarWidth
  if shieldValue < self.nBeforeShield then
    if self._mapNode.rtShieldDelay.sizeDelta.x < self._mapNode.rtShieldFill.sizeDelta.x then
      self._mapNode.aniRtShieldDelay:SetTarget(self._mapNode.rtShieldFill.sizeDelta, 0)
    end
    self._mapNode.aniRtShieldFill:SetTarget(Vector2(nWidth, BarHeight), 0)
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

function EquipmentInstanceShelockHpBar:KillTweenToughness()
  self._mapNode.aniRtToughnessDelay:Stop()
  self._mapNode.aniRtToughnessFill:Stop()
  self._mapNode.ainColorToughnessHighlight:Stop()
end

function EquipmentInstanceShelockHpBar:PlayTweenToughness(toughness, toughnessMax)
  self:KillTweenToughness()
  local nWidth = 1 <= toughness / toughnessMax and ToughnessWidth or toughness / toughnessMax * ToughnessWidth
  if self._mapNode.imgToughnessMaskDelay.sizeDelta.x < self._mapNode.imgToughnessMask.sizeDelta.x then
    self._mapNode.imgToughnessMaskDelay.sizeDelta = self._mapNode.imgToughnessMask.sizeDelta
  end
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0 < nWidth and nWidth or 0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(871 < nWidth and nWidth - 12 or nWidth - 5, 0)
  self._mapNode.imgLight.anchoredPosition = Vector2(-2, 871 < nWidth and -(nWidth - 871) * 0.75 or 3)
  local delayTime = 0
  if (self.nBeforeToughness - toughness) / toughnessMax > self.bigDamageThreshold then
    delayTime = 0.5
    self._mapNode.rtShakeRoot:Play("HPShake_in")
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 1)
  self._mapNode.ainColorToughnessHighlight:SetTarget(0, AniTime, delayTime + AniTime)
  self._mapNode.aniRtToughnessDelay:SetTarget(Vector2(nWidth, ToughnessHeight), AniTime, delayTime)
end

function EquipmentInstanceShelockHpBar:PlayTweenToughnessBroken()
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(0, 0)
  self._mapNode.rtNormal:SetActive(false)
  self._mapNode.imgBroken:SetActive(true)
  self._mapNode.ainColorToughnessBrokenChip:Play("imgBrokenChip_in")
  self._mapNode.rtShakeRoot:Play("HPShake_in")
end

function EquipmentInstanceShelockHpBar:PlayTweenToughnessRecover()
  self:KillTweenToughness()
  self._mapNode.imgToughnessMask.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.imgToughnessMaskDelay.sizeDelta = Vector2(0, ToughnessHeight)
  self._mapNode.rtHighlight.anchoredPosition = Vector2(ToughnessWidth - 12, 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Highlight, 0)
  self._mapNode.rtNormal:SetActive(true)
  self._mapNode.imgBroken:SetActive(false)
  self.tweenerToughness3 = self._mapNode.aniRtToughnessFill:SetTarget(Vector2(ToughnessWidth, ToughnessHeight), ToughnessRecoverTime)
end

function EquipmentInstanceShelockHpBar:ResetHit()
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

function EquipmentInstanceShelockHpBar:KillTween()
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

function EquipmentInstanceShelockHpBar:SetHpBarGrid(nGrid1, nGrid2)
  self.cond1 = nGrid1 / 100
  self.cond2 = nGrid2 / 100
  self._mapNode.imgLine[1].anchoredPosition = Vector2(BarWidth * self.cond1 + lineOffset, 0.3)
  self._mapNode.imgLine[2].anchoredPosition = Vector2(BarWidth * self.cond2 + lineOffset, 0.3)
end

function EquipmentInstanceShelockHpBar:Awake()
  self.bigDamageThreshold = ConfigTable.GetConfigNumber("BloodSpecialEffectThresholdValue") / 100
end

function EquipmentInstanceShelockHpBar:OnEnable()
  self.bossId = 0
  NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, false)
  self:ResetHit()
end

function EquipmentInstanceShelockHpBar:OnDisable()
  self:KillTween()
  self:ResetHit()
  self._mapNode.rtBuff:UnbindEntity()
  EventManager.RemoveEntityEvent("ShieldChanged", self.bossId, self, self.OnEvent_ShieldChanged)
  EventManager.RemoveEntityEvent("HpChanged", self.bossId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("Dead", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("BossBuffChanged", self.bossId, self, self.OnEvent_BuffChanged)
  EventManager.RemoveEntityEvent("ToughnessStateChanged", self.bossId, self, self.OnEvent_ToughnessStateChanged)
  EventManager.RemoveEntityEvent("ToughnessValueChanged", self.bossId, self, self.OnEvent_ToughnessValueChanged)
  EventManager.RemoveEntityEvent("ToughnessShowStateChanged", self.bossId, self, self.OnEvent_ToughnessShowStateChanged)
  self.bossId = 0
end

function EquipmentInstanceShelockHpBar:OnDestroy()
end

function EquipmentInstanceShelockHpBar:SetHp(hp, hpMax, bChange)
  if self.bossId == 0 then
    return
  end
  local nBeforePersent = self.nBeforeHp / self.nBeforeHpMax
  if hpMax <= 0 then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(0, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(0, BarHeight)
  elseif bChange then
    self._mapNode.rtHpFillDelay.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
    self._mapNode.rtHpFill.sizeDelta = Vector2(hp / hpMax * BarWidth, BarHeight)
  else
    self:PlayTweenHp(hp, hpMax)
  end
  local curPersent = hp / hpMax
  if 0 < nBeforePersent and curPersent <= 0 then
    local goGlow = self._mapNode.DailyShelockblood[3].transform:Find("UIParticle/glow")
    local goStar = self._mapNode.DailyShelockblood[3].transform:Find("UIParticle/star")
    GameUIUtils.RestartParticle(goGlow.gameObject)
    GameUIUtils.RestartParticle(goStar.gameObject)
    if self.parent ~= nil then
      self.parent:OnStageChange(3)
    end
  elseif nBeforePersent > self.cond2 and curPersent < self.cond2 then
    local goGlow = self._mapNode.DailyShelockblood[2].transform:Find("UIParticle/glow")
    local goStar = self._mapNode.DailyShelockblood[2].transform:Find("UIParticle/star")
    GameUIUtils.RestartParticle(goGlow.gameObject)
    GameUIUtils.RestartParticle(goStar.gameObject)
    if self.parent ~= nil then
      self.parent:OnStageChange(2)
    end
  elseif nBeforePersent > self.cond1 and curPersent < self.cond1 then
    local goGlow = self._mapNode.DailyShelockblood[1].transform:Find("UIParticle/glow")
    local goStar = self._mapNode.DailyShelockblood[1].transform:Find("UIParticle/star")
    GameUIUtils.RestartParticle(goGlow.gameObject)
    GameUIUtils.RestartParticle(goStar.gameObject)
    if self.parent ~= nil then
      self.parent:OnStageChange(1)
    end
  end
  self.nBeforeHp = hp
  self.nBeforeHpMax = hpMax
end

function EquipmentInstanceShelockHpBar:OnEvent_HpChanged(hp, hpMax)
  if hp == self.nBeforeHp then
    self:SetHp(hp, hpMax, true)
  else
    self:SetHp(hp, hpMax)
  end
end

function EquipmentInstanceShelockHpBar:OnEvent_ToughnessStateChanged(bBroken, nValue, nToughnessMax)
  if bBroken then
    self:SetToughness(0, nToughnessMax, true)
  elseif nValue ~= 0 then
    self:SetToughness(nToughnessMax, nToughnessMax, true)
  end
end

function EquipmentInstanceShelockHpBar:OnEvent_ToughnessValueChanged(toughness, toughnessMax)
  self:SetToughness(toughness, toughnessMax, false)
end

function EquipmentInstanceShelockHpBar:OnEvent_ToughnessShowStateChanged(bShow)
  if bShow then
    self._mapNode.rtToughness.transform.localScale = Vector3.one
  else
    self._mapNode.rtToughness.transform.localScale = Vector3.zero
  end
end

function EquipmentInstanceShelockHpBar:OnEvent_Deaded()
  self:AddTimer(1, 1.6, "CloseUI", true, true)
end

function EquipmentInstanceShelockHpBar:OpenUI(bossId, nDataId, parent)
  self.bossId = bossId
  self.parent = parent
  self:ResetHit()
  self:KillTween()
  local mapMonster = ConfigTable.GetData("Monster", nDataId)
  if mapMonster ~= nil then
  end
  NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 0)
  self:InitBuff()
  local hp = AdventureModuleHelper.GetEntityHp(self.bossId)
  local hpMax = AdventureModuleHelper.GetEntityMaxHp(self.bossId)
  local toughness = AdventureModuleHelper.GetMonsterToughness(self.bossId)
  local toughnessMax = AdventureModuleHelper.GetMonsterToughnessMax(self.bossId)
  self._mapNode.rtToughness.transform.localScale = Vector3.one
  self:SetHp(hp, hpMax, true)
  self:SetToughness(toughness, toughnessMax, false, true)
  local shieldValue, shieldValueMax = AdventureModuleHelper.GetEntityShieldValue(self.bossId)
  self:SetShield(shieldValue, shieldValueMax, true)
  self._mapNode.rtBuff:BindEntity(self.bossId)
  EventManager.AddEntityEvent("ShieldChanged", self.bossId, self, self.OnEvent_ShieldChanged)
  EventManager.AddEntityEvent("HpChanged", self.bossId, self, self.OnEvent_HpChanged)
  EventManager.AddEntityEvent("Dead", self.bossId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("ClearSlef", self.bossId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("BossBuffChanged", self.bossId, self, self.OnEvent_BuffChanged)
  EventManager.AddEntityEvent("ToughnessStateChanged", self.bossId, self, self.OnEvent_ToughnessStateChanged)
  EventManager.AddEntityEvent("ToughnessValueChanged", self.bossId, self, self.OnEvent_ToughnessValueChanged)
  EventManager.AddEntityEvent("ToughnessShowStateChanged", self.bossId, self, self.OnEvent_ToughnessShowStateChanged)
  self.bInit = true
  self.bossHUDAnimTweener = Sequence()
  self.bossHUDAnimTweener:Append(self._mapNode.BossCanvasGroup:DOFade(1, 0.5))
  self.bossHUDAnimTweener:Join(self._mapNode.cgBuffScrollView:DOFade(1, 0.5))
  self.bossHUDAnimTweener:SetUpdate(true)
  self._mapNode.aniRtHpDelay:SetTarget(Vector2(0, BarHeight), 0)
  self._mapNode.aniRtHpFill:SetTarget(Vector2(0, BarHeight), 0)
  self._mapNode.aniRtHpDelay:SetTarget(Vector2(BarWidth, BarHeight), 0.5, 0.5)
  self._mapNode.aniRtHpFill:SetTarget(Vector2(BarWidth, BarHeight), 0.5, 0.5)
  
  local function InitCompleteCallback()
    self.bInit = false
    self:SetHp(self.nBeforeHp, self.nBeforeHpMax)
  end
  
  self:AddTimer(1, 1, InitCompleteCallback, true, true, true)
end

function EquipmentInstanceShelockHpBar:SetShield(shieldValue, shieldValueMax, bChange)
  if self.bossId == 0 then
    return
  end
  if shieldValue <= 0 then
    self._mapNode.rtShieldFill.sizeDelta = Vector2(0, BarHeight)
    self._mapNode.rtShieldDelay.sizeDelta = Vector2(0, BarHeight)
  elseif bChange then
    self._mapNode.rtShieldFill.sizeDelta = Vector2(shieldValue / shieldValueMax * BarWidth, BarHeight)
    self._mapNode.rtShieldDelay.sizeDelta = Vector2(shieldValue / shieldValueMax * BarWidth, BarHeight)
  else
    self:PlayTweenShield(shieldValue, shieldValueMax)
  end
  self.nBeforeShield = shieldValue
  self.nBeforeShieldMax = shieldValueMax
end

function EquipmentInstanceShelockHpBar:SetToughness(toughness, toughnessMax, bState, bChange)
  if self.bossId == 0 then
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

function EquipmentInstanceShelockHpBar:OnEvent_ShieldChanged(value1, value2)
  if value1 == self.nBeforeShield then
    self:SetShield(value1, value2, true)
  else
    self:SetShield(value1, value2)
  end
end

function EquipmentInstanceShelockHpBar:OnEvent_BuffChanged(buffId, bGet)
  if self.bossId == 0 then
    return
  end
  local buffList = AdventureModuleHelper.GetEntityBuffList(self.bossId)
  if not buffList then
    self._mapNode.BuffScrollView.gameObject:SetActive(false)
    return
  end
  self.buffList = {}
  local bHasBuff = false
  for i = 0, buffList.Count - 1 do
    local nBuffId = buffList[i].buffConfig.Id
    local mapCfg = ConfigTable.GetData_Buff(nBuffId)
    if nBuffId == buffId then
      bHasBuff = true
      if bGet and mapCfg.IsShow then
        table.insert(self.buffList, {
          nId = buffList[i].buffConfig.Id,
          nNum = buffList[i]:GetBuffNum(),
          nLeftTime = buffList[i]:GetBuffLeftTime():AsFloat()
        })
      end
    elseif mapCfg.IsShow then
      table.insert(self.buffList, {
        nId = buffList[i].buffConfig.Id,
        nNum = buffList[i]:GetBuffNum(),
        nLeftTime = buffList[i]:GetBuffLeftTime():AsFloat()
      })
    end
  end
  if bHasBuff == false and bGet then
    table.insert(self.buffList, {
      nId = buffId,
      nNum = 1,
      nLeftTime = ConfigTable.GetData_Buff(buffId).Time * ConfigData.IntFloatPrecision
    })
  end
  self:RefreshBuff()
end

function EquipmentInstanceShelockHpBar:CloseUI()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 1)
  self.bossHUDAnimTweener = Sequence()
  self.bossHUDAnimTweener:Append(self._mapNode.BossCanvasGroup:DOFade(0, 0.5))
  self.bossHUDAnimTweener:OnComplete(function()
    NovaAPI.SetComponentEnable(self._mapNode.BossCanvas, false)
  end)
  self.bossHUDAnimTweener:SetUpdate(true)
  self._mapNode.rtBuff:UnbindEntity()
  EventManager.RemoveEntityEvent("ShieldChanged", self.bossId, self, self.OnEvent_ShieldChanged)
  EventManager.RemoveEntityEvent("HpChanged", self.bossId, self, self.OnEvent_HpChanged)
  EventManager.RemoveEntityEvent("Dead", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.bossId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("BossBuffChanged", self.bossId, self, self.OnEvent_BuffChanged)
  EventManager.RemoveEntityEvent("ToughnessStateChanged", self.bossId, self, self.OnEvent_ToughnessStateChanged)
  EventManager.RemoveEntityEvent("ToughnessValueChanged", self.bossId, self, self.OnEvent_ToughnessValueChanged)
  EventManager.RemoveEntityEvent("ToughnessShowStateChanged", self.bossId, self, self.OnEvent_ToughnessShowStateChanged)
  self.bossId = 0
end

function EquipmentInstanceShelockHpBar:OnEvent_HudShow(bShow)
  if bShow then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.BossCanvasGroup, 1)
  end
end

return EquipmentInstanceShelockHpBar
