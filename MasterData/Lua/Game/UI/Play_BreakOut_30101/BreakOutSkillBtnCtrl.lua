local BreakOutSkillBtnCtrl = class("BreakOutSkillBtnCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local FP = CS.TrueSync.FP
local NormalCDSize = 34
local eftColor = {
  [1] = "#00B7FF",
  [2] = "#FF587E",
  [3] = "#FF902A",
  [4] = "#86FF3B",
  [5] = "#FFCF00",
  [6] = "#F186FF"
}
local SKILL_SHOOT = 1
local SKILL_ULTRA = 4
local BTN_STATE = {
  None = 0,
  Press = 1,
  Click = 2,
  Hold = 3,
  Cancel = 4
}
BreakOutSkillBtnCtrl._mapNodeConfig = {
  CanvasGroupMain = {
    sNodeName = "main",
    sComponentName = "CanvasGroup"
  },
  transformFX = {sNodeName = "FX", sComponentName = "Transform"},
  imageFX = {sNodeName = "FX", sComponentName = "Image"},
  imageType = {sNodeName = "type", sComponentName = "Image"},
  imageFXFire = {sNodeName = "fx_fire", sComponentName = "Image"},
  transformQTE = {sNodeName = "QTE", sComponentName = "Transform"},
  imageQteLoading = {
    sNodeName = "qte_loading",
    sComponentName = "Image"
  },
  ICON = {sComponentName = "Image"},
  transformCD = {sNodeName = "CD", sComponentName = "Transform"},
  TMP_CD = {sNodeName = "CD_TMP", sComponentName = "TMP_Text"},
  transformCharge = {sNodeName = "Charge", sComponentName = "Transform"},
  tbTransformRotate = {
    sNodeName = "rotate",
    nCount = 2,
    sComponentName = "Transform"
  },
  imageChargeLoading = {
    sNodeName = "charge_loading",
    nCount = 2,
    sComponentName = "Image"
  },
  TMP_Charge = {sNodeName = "Charge_TMP", sComponentName = "TMP_Text"},
  fx = {sComponentName = "Image"},
  glow = {sComponentName = "Image"},
  Charge_Max_glow = {},
  transformCharge_glow = {
    sNodeName = "Charge_Max_glow",
    sComponentName = "Transform"
  },
  Img_Charge_glow = {
    sNodeName = "Charge_Max_glow",
    sComponentName = "Image"
  },
  Transform_ChargeLoading = {
    sNodeName = "charge_loading1",
    sComponentName = "Transform"
  },
  transformX = {sNodeName = "X", sComponentName = "Transform"},
  fx_tip = {},
  transformXcd = {sNodeName = "Xcd", sComponentName = "Transform"},
  imgPressed = {sNodeName = "pressed", sComponentName = "Image"},
  imgXtips = {sNodeName = "Xtips", sComponentName = "Image"},
  Action = {
    sCtrlName = "Game.UI.Battle.SkillActionIconCtrl"
  },
  Empty = {},
  Action_Pos = {sComponentName = "Transform"},
  Action_Pos_Hor = {sComponentName = "Transform"}
}
BreakOutSkillBtnCtrl._mapEventConfig = {
  Open_Ultra_Special_FX = "OpenUltraSpecialFX",
  [EventId.SettingsBattleClose] = "OnEvent_ChangeKeyLayout",
  Brick_ShootButtonState = "OnEvent_GetShootState"
}

function BreakOutSkillBtnCtrl:Awake()
  self.BTN = self.gameObject:GetComponent("ButtonEx")
  self.AnimFX = self.gameObject:GetComponent("Animator")
  self.tbUltraColor = {
    "#69C6F6",
    "#FA886E",
    "#FFAE67",
    "#B0EE50",
    "#FACC55",
    "#ED78DF"
  }
  self.bCanUse = false
  self.bInCD = false
  self.nCDPercent = 0
  self.bInCharge = true
  self.bCanPlayCDSound = true
  self.canFresh = true
  self:SetActionLayout()
  self:SetCDTextSize()
  self._mapNode.fx_tip:SetActive(false)
  self.skillId = nil
  self:SetEmptySkillBtn()
end

function BreakOutSkillBtnCtrl:InitSkillBtn(EET, icon, skillId, actionId, charId, breakOutLevelData)
  self:SetMainAlpha(actionId ~= SKILL_ULTRA)
  self.EET = EET
  self.ActionId = actionId
  self.skillId = skillId
  self.nCurCharId = charId
  self.BreakOutLevelData = breakOutLevelData
  self.bShowSection = false
  self._mapNode.TMP_Charge.gameObject:SetActive(false)
  if 0 < EET then
    local _, _color = ColorUtility.TryParseHtmlString(self.tbUltraColor[EET])
    local _, _colorFire = ColorUtility.TryParseHtmlString(eftColor[EET])
    NovaAPI.SetImageColor(self._mapNode.imageFX, _color)
    NovaAPI.SetImageColor(self._mapNode.imageChargeLoading[1], _color)
    NovaAPI.SetImageColor(self._mapNode.imageChargeLoading[2], _color)
    NovaAPI.SetImageColor(self._mapNode.fx, _color)
    NovaAPI.SetImageColor(self._mapNode.glow, _color)
    NovaAPI.SetImageColor(self._mapNode.imageFXFire, _colorFire)
    NovaAPI.SetImageColor(self._mapNode.Img_Charge_glow, _color)
    self:SetAtlasSprite(self._mapNode.imageType, "15_battle", "skill_btn_b_type_" .. tostring(EET))
  end
  if icon ~= nil and self.ActionId == SKILL_ULTRA then
    self:SetPngSprite(self._mapNode.ICON, icon)
  end
  self._mapNode.transformCharge.localScale = Vector3.zero
  self._mapNode.CanvasGroupMain.gameObject:SetActive(true)
  self._mapNode.Action.gameObject:SetActive(true)
  self._mapNode.Empty:SetActive(false)
  self.parentCanvasGroup = self.gameObject.transform.parent.parent:GetComponent("CanvasGroup")
  if self.ActionId == SKILL_SHOOT then
    self._mapNode.transformQTE.localScale = Vector3.zero
  end
end

function BreakOutSkillBtnCtrl:SetEmptySkillBtn()
  self._mapNode.CanvasGroupMain.gameObject:SetActive(false)
  self._mapNode.Action.gameObject:SetActive(false)
  self._mapNode.TMP_Charge.gameObject:SetActive(false)
  self._mapNode.transformCharge.localScale = Vector3.zero
  self._mapNode.Empty:SetActive(true)
end

function BreakOutSkillBtnCtrl:RefreshSkillBtn(nCurSkillEnergy, nMaxSkillEnergy, nCurCDTime, nTotalCDTime)
  if self.canFresh == false or self.ActionId == SKILL_SHOOT then
    return
  end
  local bBeginResume = false
  local ChargePercent = 0 < nMaxSkillEnergy and nCurSkillEnergy / nMaxSkillEnergy or 0
  local bCanUse = false
  bCanUse = nMaxSkillEnergy <= nCurSkillEnergy and nCurCDTime <= 0
  self._mapNode.TMP_Charge.gameObject:SetActive(self.bShowSection)
  local sAnimName, sFxSoundName
  if self.bCanUse == true then
    if bCanUse == true then
    elseif self.ActionId ~= 1 then
    end
  elseif bCanUse == true then
    if self.ActionId == SKILL_ULTRA then
      sAnimName = "BattlecgUltra_in0" .. self.EET
      sFxSoundName = "ui_skill_freeze_ultra_ok"
    elseif self.ActionId == SKILL_SHOOT then
      sAnimName = "BattlecgSkill_in"
    end
    if self.ActionId ~= 1 then
    else
    end
  end
  if sAnimName ~= nil then
    self:PlayAnimFX(sAnimName)
  end
  if sFxSoundName ~= nil and self.gameObject.activeInHierarchy == true and 0 < NovaAPI.GetCanvasGroupAlpha(self.parentCanvasGroup) then
    WwiseAudioMgr:PlaySound(sFxSoundName)
  end
  self.bCanUse = bCanUse
  local CDPercent = 0 < nTotalCDTime and nCurCDTime / nTotalCDTime or 0
  self.nCDPercent = CDPercent
  self:SetMainAlpha(bCanUse)
  self:SetQTE(nCurSkillEnergy, nMaxSkillEnergy)
  if self.ActionId == SKILL_ULTRA then
    self:SetCharge(ChargePercent)
  end
  self:SetCD(nTotalCDTime, nCurCDTime, bBeginResume)
  self:SetFX(self.ActionId == SKILL_ULTRA and 1 <= ChargePercent and not self.bInCD)
end

function BreakOutSkillBtnCtrl:SetMainAlpha(bCanUse)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CanvasGroupMain, bCanUse == true and 1 or 0.3)
end

function BreakOutSkillBtnCtrl:SetFX(bVisible)
  self._mapNode.transformFX.localScale = bVisible == true and Vector3.one or Vector3.zero
end

function BreakOutSkillBtnCtrl:SetQTE(nCurrentEnergy, nMaxEnergy)
  local percent = 0
  if nCurrentEnergy == nMaxEnergy then
    percent = 1
  else
    percent = nCurrentEnergy / nMaxEnergy
  end
  if not (1 > self._mapNode.transformQTE.localScale.x) or 0 < percent then
  end
  self._mapNode.transformQTE.localScale = 0 < percent and Vector3.one or Vector3.zero
  NovaAPI.SetImageFillAmount(self._mapNode.imageQteLoading, percent)
end

function BreakOutSkillBtnCtrl:PlayAnimFX(sAnimName)
  self.AnimFX:Play(sAnimName)
end

function BreakOutSkillBtnCtrl:SetCD(totalCDTime, curCDTime)
  if self.ActionId == SKILL_SHOOT then
    self._mapNode.TMP_CD.transform.localScale = Vector3.zero
    return
  end
  local percent = 0 < totalCDTime and curCDTime / totalCDTime or 0
  self.bInCD = 0 < percent
  self._mapNode.transformCD.localScale = self.bInCD == true and Vector3.one or Vector3.zero
  self._mapNode.transformXcd.localScale = self.bInCD == true and Vector3.one or Vector3.zero
  self._mapNode.TMP_CD.transform.localScale = self.bInCD == true and Vector3.one or Vector3.zero
  if 1.0 <= curCDTime then
    NovaAPI.SetTMPSourceText(self._mapNode.TMP_CD, tostring(math.ceil(curCDTime)))
  else
    NovaAPI.SetTMPSourceText(self._mapNode.TMP_CD, string.format("%.1f", curCDTime))
  end
  self._mapNode.Charge_Max_glow:SetActive(self.bInCD and not self.bInCharge)
  self._mapNode.Transform_ChargeLoading.gameObject:SetActive(self.bInCD and not self.bInCharge)
end

function BreakOutSkillBtnCtrl:SetCharge(percent)
  self.bInCharge = percent < 1
  self._mapNode.transformCharge.localScale = 0 < percent and percent < 1 and Vector3.one or Vector3.zero
  self._mapNode.transformCharge_glow.localScale = self.bInCharge and Vector3.zero or Vector3.one
  self._mapNode.Transform_ChargeLoading.localScale = self.bInCharge and Vector3.zero or Vector3.one
  local tr1 = self._mapNode.tbTransformRotate[1]
  local tr2 = self._mapNode.tbTransformRotate[2]
  if 0.02 <= percent and percent < 1 then
    local v3 = Vector3(0, 0, -percent * 360)
    tr1.localScale = Vector3.one
    tr1.localEulerAngles = v3
    tr2.localScale = Vector3.one
    tr2.localEulerAngles = v3
  else
    tr1.localScale = Vector3.zero
    tr2.localScale = Vector3.zero
  end
  NovaAPI.SetImageFillAmount(self._mapNode.imageChargeLoading[1], percent)
  NovaAPI.SetImageFillAmount(self._mapNode.imageChargeLoading[2], percent)
  NovaAPI.SetTMPSourceText(self._mapNode.TMP_Charge, tostring(math.floor(1)))
end

function BreakOutSkillBtnCtrl:SetForbidden(bForbidden, bAvailable)
  self._mapNode.transformX.localScale = bForbidden == true and Vector3.one or Vector3.zero
end

function BreakOutSkillBtnCtrl:OpenUltraSpecialFX(mTmpActionPosId, isShow)
  if self.tmpActionPosId == mTmpActionPosId then
    self._mapNode.fx_tip:SetActive(isShow)
  end
end

function BreakOutSkillBtnCtrl:Set_SkillHintActive(bActive)
  self._mapNode.transformQTE.localScale = bActive == true and Vector3.one or Vector3.zero
  self._mapNode.imageQteLoading.transform.localScale = bActive == true and Vector3.zero or Vector3.one
end

function BreakOutSkillBtnCtrl:GetSupSkillForbidden()
  return self._mapNode.transformX.localScale == Vector3.one
end

function BreakOutSkillBtnCtrl:BtnStateChange(nState)
  if self.BreakOutLevelData:GetPopPlayTips() and not self:GetCanUseSkill() and self.ActionId ~= SKILL_SHOOT and self.bCanUse then
    local sTip = ConfigTable.GetUIText("BreakOut_Play_Tips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
  if nState == BTN_STATE.Cancel then
    NovaAPI.SetComponentEnable(self._mapNode.imgPressed, false)
    NovaAPI.SetComponentEnable(self._mapNode.imgXtips, false)
  elseif nState == BTN_STATE.Press then
    NovaAPI.SetComponentEnable(self._mapNode.imgPressed, self.bInCD == false and self.bCanUse == true)
    NovaAPI.SetComponentEnable(self._mapNode.imgXtips, self.bInCD == true)
    if self.bInCD == true and self.gameObject.activeInHierarchy == true and NovaAPI.GetCanvasGroupAlpha(self.parentCanvasGroup) > 0 and self.bCanPlayCDSound then
      WwiseAudioMgr:PlaySound("ui_skill_freeze_click")
      self.bCanPlayCDSound = false
      self:AddTimer(1, 0.5, function()
        self.bCanPlayCDSound = true
      end, true, true, true)
    end
  elseif nState == BTN_STATE.Click then
    NovaAPI.SetComponentEnable(self._mapNode.imgPressed, false)
    NovaAPI.SetComponentEnable(self._mapNode.imgXtips, false)
  elseif nState == BTN_STATE.Hold then
    NovaAPI.SetComponentEnable(self._mapNode.imgPressed, self.bInCD == false and self.bCanUse == true)
    NovaAPI.SetComponentEnable(self._mapNode.imgXtips, self.bInCD == true)
  end
end

function BreakOutSkillBtnCtrl:SetActionBind(sGamepadBind, mapKeyboardBind)
  self._mapNode.Action:SetActionBind(sGamepadBind, mapKeyboardBind)
end

function BreakOutSkillBtnCtrl:SetActionLayout()
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self:SetKeyPos(self._mapNode.Action.gameObject:GetComponent("RectTransform"), self._mapNode.Action_Pos_Hor)
  else
    self:SetKeyPos(self._mapNode.Action.gameObject:GetComponent("RectTransform"), self._mapNode.Action_Pos)
  end
end

function BreakOutSkillBtnCtrl:SetKeyPos(btnTra, parentTra)
  btnTra:SetParent(parentTra)
  btnTra.anchoredPosition = Vector2.zero
  btnTra.localScale = Vector3(0.68, 0.68, 0.68)
end

function BreakOutSkillBtnCtrl:SetCDTextSize()
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self._mapNode.TMP_CD.fontSize = 74
  else
    local parentTra = self.gameObject.transform.parent
    local scale = parentTra.localScale
    local size = 1 / scale.x * NormalCDSize
    self._mapNode.TMP_CD.fontSize = math.ceil(size)
  end
end

function BreakOutSkillBtnCtrl:OnEvent_ChangeKeyLayout()
  self:SetActionLayout()
  self:SetCDTextSize()
end

function BreakOutSkillBtnCtrl:GetCanUseSkill()
  local bUseSkill = self.bSkillChar and self.bEnableShoot
  return not bUseSkill
end

function BreakOutSkillBtnCtrl:OnEvent_GetShootState(bEnableShoot, bNeedSkillUseTip)
  self.bEnableShoot = bEnableShoot
  self.bSkillChar = bNeedSkillUseTip
end

return BreakOutSkillBtnCtrl
