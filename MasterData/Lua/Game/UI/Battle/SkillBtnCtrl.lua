local SkillBtnCtrl = class("SkillBtnCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local NormalCDSize = 34
local eftColor = {
  [1] = "#00B7FF",
  [2] = "#FF587E",
  [3] = "#FF902A",
  [4] = "#86FF3B",
  [5] = "#FFCF00",
  [6] = "#F186FF"
}
local SKILL_FLEE = 1
local SKILL_A = 2
local SKILL_B = 3
local SKILL_ULTRA = 4
local BTN_STATE = {
  None = 0,
  Press = 1,
  Click = 2,
  Hold = 3,
  Cancel = 4
}
SkillBtnCtrl._mapNodeConfig = {
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
  LightLoop = {
    sNodeName = "LightLoop_",
    nCount = 6,
    sComponentName = "GameObject"
  },
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
SkillBtnCtrl._mapEventConfig = {
  Open_Ultra_Special_FX = "OpenUltraSpecialFX",
  [EventId.SettingsBattleClose] = "OnEvent_ChangeKeyLayout"
}

function SkillBtnCtrl:Awake()
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
  self.bCanUse = true
  self.bInCD = false
  self.nCDpercent = 0
  self.nSectionNum = 0
  self.bInCharge = true
  self.bCanPlayCDSound = true
  self.canFresh = true
  self:SetActionLayout()
  self:SetCDTextSize()
  self._mapNode.fx_tip:SetActive(false)
  self.bChargeLoading_CurrentIsActive = nil
end

function SkillBtnCtrl:InitSkillBtn(EET, icon, bShowSection, charId, actionId, bIsSupportChar, bApplyUltraAlpha)
  self:SetMainAlpha(true)
  self.EET = EET
  self.ActionId = actionId
  self.tmpActionPosId = charId * 10 + self.ActionId
  self.bShowSection = bShowSection
  self._mapNode.TMP_Charge.gameObject:SetActive(bShowSection)
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
    local sPath = Settings.AB_ROOT_PATH .. "UI/Battle/FX/Textures/btnSkill_qte_0" .. tostring(EET) .. ".png"
    local sp = GameResourceLoader.LoadAsset(ResType.Any, sPath, typeof(Sprite), "UI", self._panel._nPanelId)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imageQteLoading, sp)
  end
  self:SetPngSprite(self._mapNode.ICON, icon)
  self._mapNode.transformCharge.localScale = Vector3.zero
  self._mapNode.CanvasGroupMain.gameObject:SetActive(true)
  self._mapNode.Action.gameObject:SetActive(true)
  self._mapNode.Empty:SetActive(false)
  self.bIsSupportChar = bIsSupportChar == true
  self.bApplyUltraAlpha = bApplyUltraAlpha == true
  if self.bIsSupportChar == true then
    self.parentCanvasGroup = self.gameObject.transform.parent.parent.parent:GetComponent("CanvasGroup")
  else
    self.parentCanvasGroup = self.gameObject.transform.parent.parent:GetComponent("CanvasGroup")
  end
  for i, v in ipairs(self._mapNode.LightLoop) do
    v:SetActive(bEnable)
  end
end

function SkillBtnCtrl:SetEmptySkillBtn()
  self._mapNode.CanvasGroupMain.gameObject:SetActive(false)
  self._mapNode.Action.gameObject:SetActive(false)
  self._mapNode.TMP_Charge.gameObject:SetActive(false)
  self._mapNode.transformCharge.localScale = Vector3.zero
  self._mapNode.Empty:SetActive(true)
end

function SkillBtnCtrl:RefreshBtn(bSuportSkillUseable, QTEpercent, CDpercent, CDsecond, ChargePercent, ChargeSectionNum, nTotalSectionNum, bBeginResume)
  if self.canFresh == false then
    return
  end
  local bCanUse = false
  if self.ActionId == SKILL_ULTRA then
    if self.bApplyUltraAlpha == true then
      bCanUse = 1 <= ChargeSectionNum and 1 <= ChargePercent and CDpercent <= 0
    else
      bCanUse = 1 <= ChargeSectionNum and CDpercent <= 0
    end
  else
    bCanUse = 1 <= ChargeSectionNum
  end
  if self.bIsSupportChar == true and bCanUse then
    bCanUse = bSuportSkillUseable
  end
  if self.bShowSection ~= (1 < nTotalSectionNum) then
    self.bShowSection = 1 < nTotalSectionNum
    self._mapNode.TMP_Charge.gameObject:SetActive(self.bShowSection)
  end
  local sAnimName, sFxSoundName
  if self.bCanUse == true then
    if bCanUse == true then
      if 1 < nTotalSectionNum and ChargeSectionNum > self.nSectionNum then
        if self.ActionId == SKILL_ULTRA then
          sAnimName = "BattlecgUltra_in0" .. self.EET
          sFxSoundName = "ui_skill_freeze_ultra_ok"
        elseif self.ActionId == SKILL_A then
          sAnimName = "BattlecgSkill_in0" .. self.EET
          sFxSoundName = "ui_skill_freeze_ok"
        elseif self.ActionId == SKILL_FLEE then
          sAnimName = "BattlecgSkill_in"
        end
      end
    elseif self.ActionId ~= 1 then
      NovaAPI.DispatchEventWithData("CHAR_ULTRA_CAN_USE", nil, {
        self.tmpActionPosId,
        false
      })
    end
  elseif bCanUse == true then
    if self.ActionId == SKILL_ULTRA then
      sAnimName = "BattlecgUltra_in0" .. self.EET
      sFxSoundName = "ui_skill_freeze_ultra_ok"
    elseif self.ActionId == SKILL_A then
      sAnimName = "BattlecgSkill_in0" .. self.EET
      sFxSoundName = "ui_skill_freeze_ok"
    elseif self.ActionId == SKILL_FLEE then
      sAnimName = "BattlecgSkill_in"
    end
    if self.ActionId ~= 1 then
      NovaAPI.DispatchEventWithData("CHAR_ULTRA_CAN_USE", nil, {
        self.tmpActionPosId,
        true
      })
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
  self.nCDpercent = CDpercent
  self.nSectionNum = ChargeSectionNum
  self:SetMainAlpha(bCanUse)
  self:SetQTE(QTEpercent)
  if self.ActionId == SKILL_ULTRA or self.bShowSection then
    self:SetCharge(ChargePercent, ChargeSectionNum)
  end
  self:SetCD(CDpercent, CDsecond, bBeginResume)
  self:SetFX(self.ActionId == SKILL_ULTRA and 1 <= ChargePercent and not self.bInCD)
end

function SkillBtnCtrl:SetBtnEnable(bEnable)
  self.BTN.interactable = bEnable == true
  self:SetMainAlpha(bEnable)
end

function SkillBtnCtrl:SetBtnVisible(bVisible)
  self.BTN.gameObject:SetActive(bVisible)
end

function SkillBtnCtrl:GetBtnVisible()
  return self.BTN.gameObject.activeSelf
end

function SkillBtnCtrl:SetMainAlpha(bCanUse)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CanvasGroupMain, bCanUse == true and 1 or 0.3)
end

function SkillBtnCtrl:SetFX(bVisible)
  self._mapNode.transformFX.localScale = bVisible == true and Vector3.one or Vector3.zero
end

function SkillBtnCtrl:SetQTE(percent)
  if self._mapNode.transformQTE.localScale.x < 1 and 0 < percent then
    self.AnimFX:Play("BattlecgUltra_Qte_in")
  end
  self._mapNode.transformQTE.localScale = 0 < percent and Vector3.one or Vector3.zero
  NovaAPI.SetImageFillAmount(self._mapNode.imageQteLoading, percent)
end

function SkillBtnCtrl:PlayAnimFX(sAnimName)
  self.AnimFX:Play(sAnimName)
end

function SkillBtnCtrl:SetCD(percent, second, bBeginResume)
  self.bInCD = 0 < percent
  self._mapNode.transformCD.localScale = self.bInCD == true and Vector3.one or Vector3.zero
  self._mapNode.transformXcd.localScale = self.bInCD == true and Vector3.one or Vector3.zero
  if 1.0 <= second then
    NovaAPI.SetTMPSourceText(self._mapNode.TMP_CD, tostring(math.ceil(second)))
  else
    NovaAPI.SetTMPSourceText(self._mapNode.TMP_CD, string.format("%.1f", second))
  end
  self._mapNode.TMP_CD.transform.localScale = bBeginResume == true and Vector3.one or Vector3.zero
  local bTargetIsActive = self.bInCD and not self.bInCharge
  if self.bChargeLoading_CurrentIsActive ~= bTargetIsActive then
    self.bChargeLoading_CurrentIsActive = bTargetIsActive
    self._mapNode.Charge_Max_glow:SetActive(self.bChargeLoading_CurrentIsActive)
    self._mapNode.Transform_ChargeLoading.gameObject:SetActive(self.bChargeLoading_CurrentIsActive)
  end
end

function SkillBtnCtrl:SetCharge(percent, second)
  if second == 0 and self.ActionId ~= SKILL_ULTRA then
    self._mapNode.transformCharge.localScale = Vector3.zero
    NovaAPI.SetTMPSourceText(self._mapNode.TMP_Charge, "")
    return
  end
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
  NovaAPI.SetTMPSourceText(self._mapNode.TMP_Charge, tostring(math.floor(second)))
end

function SkillBtnCtrl:SetForbidden(bForbidden)
  self._mapNode.transformX.localScale = bForbidden == true and Vector3.one or Vector3.zero
end

function SkillBtnCtrl:OpenUltraSpecialFX(mTmpActionPosId, isShow)
  if self.tmpActionPosId == mTmpActionPosId then
    self._mapNode.fx_tip:SetActive(isShow)
  end
end

function SkillBtnCtrl:Set_SkillHintActive(bActive)
  self._mapNode.transformQTE.localScale = bActive == true and Vector3.one or Vector3.zero
  self._mapNode.imageQteLoading.transform.localScale = bActive == true and Vector3.zero or Vector3.one
end

function SkillBtnCtrl:Set_LightGroup(bEnable)
  self._mapNode.LightLoop[self.EET]:SetActive(bEnable)
end

function SkillBtnCtrl:SetSupSkillStateByUltimate(bForbidden)
  self._mapNode.transformX.localScale = bForbidden == true and Vector3.one or Vector3.zero
  self._mapNode.transformCD.gameObject:SetActive(not bForbidden)
end

function SkillBtnCtrl:GetSupSkillForbidden()
  return self._mapNode.transformX.localScale == Vector3.one
end

function SkillBtnCtrl:BtnStateChange(nState)
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

function SkillBtnCtrl:ChangeSkillIcon(sIcon)
  if type(sIcon) == "string" and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.ICON, sIcon)
  end
end

function SkillBtnCtrl:SetActionBind(sGamepadBind, mapKeyboardBind)
  self._mapNode.Action:SetActionBind(sGamepadBind, mapKeyboardBind)
end

function SkillBtnCtrl:SetActionLayout()
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self:SetKeyPos(self._mapNode.Action.gameObject:GetComponent("RectTransform"), self._mapNode.Action_Pos_Hor)
  else
    self:SetKeyPos(self._mapNode.Action.gameObject:GetComponent("RectTransform"), self._mapNode.Action_Pos)
  end
end

function SkillBtnCtrl:SetKeyPos(btnTra, parentTra)
  btnTra:SetParent(parentTra)
  btnTra.anchoredPosition = Vector2.zero
  btnTra.localScale = Vector3.one
end

function SkillBtnCtrl:SetCDTextSize()
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

function SkillBtnCtrl:SetbtnEnable_Prologuel(bEnable)
  self.BTN.interactable = bEnable == true
  self.canFresh = bEnable
  self:SetMainAlpha(bEnable)
  if bEnable == false then
    self:SetMainAlpha(false)
    self:SetFX(false)
    self:SetCD(1, 0, false)
  end
end

function SkillBtnCtrl:OnEvent_ChangeKeyLayout()
  self:SetActionLayout()
  self:SetCDTextSize()
end

return SkillBtnCtrl
