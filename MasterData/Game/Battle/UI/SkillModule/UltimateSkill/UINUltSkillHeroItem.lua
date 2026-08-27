local UINUltSkillHeroItem = class("UINUltSkillHeroItem", UIBaseNode)
local base = UIBaseNode
local cs_ParentContraint = CS.UnityEngine.Animations.ParentConstraint
local cs_ConstraintSource = CS.UnityEngine.Animations.ConstraintSource
local cs_MessageCommon = CS.MessageCommon
local cs_BattleCtrl = CS.BattleManager
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINUltSkillHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btnPlus_Root.onClick:AddListener(BindCallback(self, self.__OnClick))
  self.ui.btnPlus_Root.onPress:AddListener(BindCallback(self, self.__OnLongPress))
  self.ui.btnPlus_Root.onPressUp:AddListener(BindCallback(self, self.__OnPressUp))
  if self.headItem == nil then
    self.headItem = UINHeroHeadItem.New()
  end
  self.headItem:Init(self.ui.heroHeadItem)
  if self.ui.fxp_metioned ~= nil then
    self.__MentionEffectCompleted = BindCallback(self, self.MentionEffectCompleted)
    self.ui.fxp_metioned:InitEffectCommon(self.__MentionEffectCompleted, self.ui.fxp_metioned.name)
  end
  self.ui.tr_hpBar.gameObject:SetActive(false)
  self.ui.img_Wound:SetActive(false)
  self.ui.img_Dead:SetActive(false)
  self.specialUltActiveEffects = nil
  self.curSpecialUltActiveEffect = nil
  self.__OnCreatSpecialUltHearoEffect = BindCallback(self, self.CreateSpecialUltEffect)
  MsgCenter:AddListener(eMsgEventId.OnCreatSpecialUltHearoEffect, self.__OnCreatSpecialUltHearoEffect)
  self.__OnShowSpeicalUltHearoEffect = BindCallback(self, self.ShowSpecialUltEffect)
  MsgCenter:AddListener(eMsgEventId.OnShowSpeicalUltHearoEffect, self.__OnShowSpeicalUltHearoEffect)
  self.__OnHideSpeicalUltHearoEffect = BindCallback(self, self.HideSpecialUltEffect)
  MsgCenter:AddListener(eMsgEventId.OnHideSpeicalUltHearoEffect, self.__OnHideSpeicalUltHearoEffect)
end

function UINUltSkillHeroItem:ReSetFpxConsOffest(index, offsetZ)
  TimerManager:StartTimer(1, function()
    self:CalFpxOffestPos(index, offsetZ)
    local vector3 = self.transform:TransformPoint(Vector3.New(self.offestPosX, self.offestPosY, self.offestPosZ))
    local posDelta = vector3 - self.transform.position
    self.ui.fxp_lvl1Cons:SetTranslationOffset(0, posDelta)
    self.ui.fxp_lvl2Cons:SetTranslationOffset(0, posDelta)
  end, self, true, true, true)
end

function UINUltSkillHeroItem:CalFpxOffestPos(itemIndex, offsetZ)
  itemIndex = itemIndex % 6
  if itemIndex == 0 then
    itemIndex = itemIndex + 1
  end
  self.offestPosZ = offsetZ.x - itemIndex * offsetZ.y
  self.offestPosX = self.ui.fxp_metioned.transform.localPosition.x
  self.offestPosY = self.ui.fxp_metioned.transform.localPosition.y
end

function UINUltSkillHeroItem:InitUltSkillHeroItem(battleSkill, resloader, clickFunc, itemIndex, offsetZ, heroData, fxpCanvas, hpCanvas)
  if self.__IsInit == nil then
    self:CalFpxOffestPos(itemIndex, offsetZ)
    self.hpOffesPosY = self.ui.hpBarCons.transform.localPosition.y
    TimerManager:StartTimer(5, self.OnLayOutResetPos, self, true, true, true)
    self.__IsInit = true
  end
  self.battleSkill = battleSkill
  self.clickFunc = clickFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  self._hasUltSkill = true
  self.__disable = false
  self.__isShowReturnCD = false
  self.__inUltSkillCd = false
  self.heroId = heroData.dataId
  self.resloader = resloader
  self:_InitHeadItem(heroData, resloader)
  self.fxpCanvas = fxpCanvas
  self.hpCanvas = hpCanvas
  self:HideEffect()
  self.headItem:SetHpBarActive(true)
end

function UINUltSkillHeroItem:InitHeroUltHeadItem(heroData, resloader, ultNode)
  self._ultNode = ultNode
  self._hasUltSkill = false
  self.heroId = heroData.dataId
  self:_InitHeadItem(heroData, resloader)
end

function UINUltSkillHeroItem:OnLayOutResetPos()
  self.ui.hpBarCons.constraintActive = true
  self.headItem:SetHpBarParent(self.hpCanvas.transform)
  local vector3 = self.headItem.transform:TransformPoint(Vector3.New(0, self.hpOffesPosY, 0))
  local posDelta = vector3 - self.headItem.transform.position
  self.ui.hpBarCons:SetTranslationOffset(0, posDelta)
  self.ui.fxp_lvl1.transform:SetParent(self.fxpCanvas.transform)
  self.ui.fxp_lvl2.transform:SetParent(self.fxpCanvas.transform)
  vector3 = self.transform:TransformPoint(Vector3.New(self.offestPosX, self.offestPosY, self.offestPosZ))
  posDelta = vector3 - self.transform.position
  self.ui.fxp_lvl1Cons:SetTranslationOffset(0, posDelta)
  self.ui.fxp_lvl2Cons:SetTranslationOffset(0, posDelta)
end

function UINUltSkillHeroItem:_InitHeadItem(heroData, resloader)
  self.gameObject.name = tostring(heroData.dataId)
  self.ui.img_CD.enabled = false
  self.ui.highlight.enabled = false
  self.ui.img_HasUltimate.enabled = self._hasUltSkill or false
  self.headItem:InitHeroHeadItem(heroData, resloader)
  self._heroData = heroData
end

function UINUltSkillHeroItem:SetShowUltSkillInfoFunc(showSkillInfoFunc, hideSkillInfoFunc)
  self.showSkillInfoFunc = showSkillInfoFunc
  self.hideSkillInfoFunc = hideSkillInfoFunc
end

function UINUltSkillHeroItem:OnUpdateLogic_UltSkillItem(intensity)
  if self.isSkillNoCD then
    return
  end
  if not self._hasUltSkill then
    return
  end
  local skill = self.battleSkill
  if skill == nil then
    return
  end
  if skill:IsReadyToTake() and not skill.maker:IsAbandonUltSkill() then
    if self.__inUltSkillCd then
      self.__inUltSkillCd = false
      self.ui.img_CD.enabled = false
      if self.__usable then
        self:UltSkillUsable(true, intensity)
      end
    end
  else
    if not self.__inUltSkillCd then
      self:UltSkillUsable(false)
      self.__inUltSkillCd = true
      self.ui.img_CD.enabled = true
    end
    self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
    self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
    self.ui.img_CD.fillAmount = self.curCDRatio
  end
end

function UINUltSkillHeroItem:OnUpdateRender_UltSkillItem(deltaTime, interpolation)
  if self.isSkillNoCD then
    return
  end
  if self.ui.img_CD.enabled then
    self.ui.img_CD.fillAmount = Mathf.Lerp(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

function UINUltSkillHeroItem:OnUpdateLogic_ReturnCD()
  if self.__isShowReturnCD then
    if self.lastReturnCD > 0 then
      self.lastReturnCD = self.lastReturnCD - 1
    else
      self:HideHeroReturnCD()
    end
  end
end

function UINUltSkillHeroItem:OnUpdateRender_ReturnCD()
  if self.__isShowReturnCD then
    local remainSec = BattleUtil.FrameToTime(self.lastReturnCD)
    self.ui.tex_ReCD.text = tostring(remainSec)
  end
end

function UINUltSkillHeroItem:__OnClick()
  if self._hasUltSkill == false and self._ultNode:IsUltSkillSlotFull() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(620))
  end
  if self.__disable or BattleUtil.IsBattleInPause() then
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.battleSkill)
  end
end

function UINUltSkillHeroItem:__OnLongPress()
  if self.showSkillInfoFunc ~= nil then
    self.showSkillInfoFunc(self, self.battleSkill, self._heroData)
  end
end

function UINUltSkillHeroItem:__OnPressUp()
  if self.hideSkillInfoFunc ~= nil then
    self.hideSkillInfoFunc()
  end
end

function UINUltSkillHeroItem:UltSkillUsable(usable, intensity)
  if self.battleSkill ~= nil and self.battleSkill.maker ~= nil and self.battleSkill.maker:IsAbandonUltSkill() then
    usable = false
  end
  if self.__disable or self.__inUltSkillCd then
    usable = false
  end
  if self.__usable == usable then
    if usable then
      self:AdjustEffect(intensity)
    end
  else
    self.ui.highlight.enabled = usable
    self.__usable = usable
    self.headItem:TransparentHeroHeadItem(not usable)
    if usable then
      local color = self.ui.highlight.color
      color.a = intensity
      self.ui.highlight.color = color
    else
      self:HideEffect()
    end
  end
end

function UINUltSkillHeroItem:SetAllEfxActive(activeSelf)
  if self.ui.fxp_metioned.gameObject.activeSelf ~= activeSelf then
    self.ui.fxp_metioned.gameObject:SetActive(activeSelf)
  end
  if self.ui.fxp_lvl1.activeSelf ~= activeSelf then
    self.ui.fxp_lvl1:SetActive(activeSelf)
  end
  if self.ui.fxp_lvl2.activeSelf ~= activeSelf then
    self.ui.fxp_lvl2:SetActive(activeSelf)
  end
  if self.curSpecialUltActiveEffect ~= nil and self.curSpecialUltActiveEffect.activeSelf ~= activeSelf then
    self.curSpecialUltActiveEffect:SetActive(activeSelf)
  end
end

function UINUltSkillHeroItem:ShowEfcMetioned()
  if self.ui.fxp_metioned ~= nil and not self.__disable then
    self.ui.fxp_metioned:PlayWithoutPos()
  end
end

function UINUltSkillHeroItem:MentionEffectCompleted(effect)
  if self.__usable == false then
    return
  end
  if not self.__disable then
    if self.curSpecialUltActiveEffect ~= nil then
      if not self.curSpecialUltActiveEffect.activeSelf then
        self.curSpecialUltActiveEffect:SetActive(true)
      end
      if self.ui.fxp_lvl1 ~= nil and self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(false)
      end
      if self.ui.fxp_lvl2 ~= nil and self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(false)
      end
      return
    end
    local intensity = self.ui.highlight.color
    if intensity.a >= 0.9 then
      if self.ui.fxp_lvl1 ~= nil and self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(false)
      end
      if self.ui.fxp_lvl2 ~= nil and not self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(true)
      end
    else
      if self.ui.fxp_lvl1 ~= nil and not self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(true)
      end
      if self.ui.fxp_lvl2 ~= nil and self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(false)
      end
    end
  end
end

function UINUltSkillHeroItem:AdjustEffect(intensity)
  if not self.__disable then
    if self.curSpecialUltActiveEffect ~= nil then
      if not self.curSpecialUltActiveEffect.activeSelf then
        self.curSpecialUltActiveEffect:SetActive(true)
      end
      if self.ui.fxp_lvl1 ~= nil and self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(false)
      end
      if self.ui.fxp_lvl2 ~= nil and self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(false)
      end
      return
    end
    if 1 <= intensity then
      if self.ui.fxp_lvl1 ~= nil and self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(false)
      end
      if self.ui.fxp_lvl2 ~= nil and not self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(true)
      end
    else
      if self.ui.fxp_lvl1 ~= nil and not self.ui.fxp_lvl1.activeSelf then
        self.ui.fxp_lvl1:SetActive(true)
      end
      if self.ui.fxp_lvl2 ~= nil and self.ui.fxp_lvl2.activeSelf then
        self.ui.fxp_lvl2:SetActive(false)
      end
    end
  end
end

function UINUltSkillHeroItem:HideEffect()
  if self.ui.fxp_lvl1 ~= nil and self.ui.fxp_lvl1.activeSelf then
    self.ui.fxp_lvl1:SetActive(false)
  end
  if self.ui.fxp_lvl2 ~= nil and self.ui.fxp_lvl2.activeSelf then
    self.ui.fxp_lvl2:SetActive(false)
  end
  if self.curSpecialUltActiveEffect ~= nil and self.curSpecialUltActiveEffect.activeSelf then
    self.curSpecialUltActiveEffect:SetActive(false)
  end
end

function UINUltSkillHeroItem:CreateSpecialUltEffect(skillDataID, resPath, isAllItem, heroID)
  if not isAllItem and heroID ~= self.heroId then
    return
  end
  if self.resloader == nil then
    return
  end
  if self.specialUltActiveEffects == nil then
    self.specialUltActiveEffects = {}
  end
  if self.specialUltActiveEffects[skillDataID] ~= nil then
    return
  end
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPrefab(resPath), function(effectAsset)
    if effectAsset == nil then
      return
    end
    local obj = effectAsset:Instantiate(self.transform)
    local constraint = obj:AddComponent(typeof(cs_ParentContraint))
    local source = cs_ConstraintSource()
    source.weight = 1
    source.sourceTransform = self.transform
    constraint:AddSource(source)
    obj.transform:SetParent(self.fxpCanvas.transform)
    local vector3 = self.transform:TransformPoint(Vector3.New(self.offestPosX, self.offestPosY, self.offestPosZ))
    local posDelta = vector3 - self.transform.position
    constraint:SetTranslationOffset(0, posDelta)
    constraint.constraintActive = true
    self.specialUltActiveEffects[skillDataID] = obj
    obj:SetActive(false)
  end)
end

function UINUltSkillHeroItem:ShowSpecialUltEffect(skillDataID, heroID)
  if self.heroId ~= heroID then
    return
  end
  if self.specialUltActiveEffects == nil then
    return
  end
  if self.specialUltActiveEffects[skillDataID] == nil then
    return
  end
  if self.curSpecialUltActiveEffect ~= nil and self.curSpecialUltActiveEffect.activeSelf then
    self.curSpecialUltActiveEffect:SetActive(false)
  end
  self.curSpecialUltActiveEffect = self.specialUltActiveEffects[skillDataID]
  if self.curSpecialUltActiveEffect ~= nil and not self.curSpecialUltActiveEffect.activeSelf then
    self.curSpecialUltActiveEffect:SetActive(true)
  end
end

function UINUltSkillHeroItem:HideSpecialUltEffect(skillDataID, heroID)
  if self.heroId ~= heroID then
    return
  end
  if self.specialUltActiveEffects == nil then
    return
  end
  if self.specialUltActiveEffects[skillDataID] == nil then
    return
  end
  if self.curSpecialUltActiveEffect ~= nil and self.specialUltActiveEffects[skillDataID] == self.curSpecialUltActiveEffect then
    if self.curSpecialUltActiveEffect.activeSelf then
      self.curSpecialUltActiveEffect:SetActive(false)
    end
    self.curSpecialUltActiveEffect = nil
  end
end

function UINUltSkillHeroItem:DeleteAllSpecialEffect()
  if self.specialUltActiveEffects ~= nil then
    for k, effectObj in pairs(self.specialUltActiveEffects) do
      DestroyUnityObject(effectObj)
    end
  end
  self.specialUltActiveEffects = nil
  self.curSpecialUltActiveEffect = nil
end

function UINUltSkillHeroItem:IsHeroItemDisabled()
  return self.__disable or self.__inUltSkillCd
end

function UINUltSkillHeroItem:DisableUltSkillHeroItem(disable)
  self.__disable = disable
  if disable then
    self.headItem:TransparentHeroHeadItem(true)
    self.ui.highlight.enabled = false
    self:HideEffect()
  else
    self.headItem:TransparentHeroHeadItem(not self.__usable)
    self.ui.highlight.enabled = self.__usable
    if self.__usable then
      self:AdjustEffect(self.ui.highlight.color.a)
    end
  end
end

function UINUltSkillHeroItem:ShowHeroReturnCD(returnCD)
  if self.__isShowReturnCD == true or returnCD == nil then
    return
  end
  self.__isShowReturnCD = true
  self.lastReturnCD = returnCD
  self.ui.returnCD:SetActive(true)
end

function UINUltSkillHeroItem:HideHeroReturnCD()
  if self.__isShowReturnCD then
    self.__isShowReturnCD = false
    self.ui.returnCD:SetActive(false)
  end
end

function UINUltSkillHeroItem:SetSideHpBarActive(bool, rate)
  if bool then
    self:__RefreshIsWoundOrDead(rate)
    self.ui.img_hP.fillAmount = rate
  else
    self.ui.img_Wound:SetActive(false)
    self.ui.img_Dead:SetActive(false)
  end
  self.ui.tr_hpBar.gameObject:SetActive(bool)
end

function UINUltSkillHeroItem:__RefreshIsWoundOrDead(rate)
  local amount = rate
  local isWound = amount <= 0.3
  local isDead = amount <= 0
  self.ui.img_Wound:SetActive(isWound and not isDead)
  self.ui.img_Dead:SetActive(isDead)
end

function UINUltSkillHeroItem:IsSkillCanSpecialPlay()
  return self.battleSkill.luaSkill:IsUltCanSepcialPlay()
end

function UINUltSkillHeroItem:OnHide()
  self.clickFunc = nil
  self.battleSkill = nil
  self.__disable = false
  self.__inUltSkillCd = false
  self.resloader = nil
  self.__isShowReturnCD = false
  self:DeleteAllSpecialEffect()
  self:SetAllEfxActive(false)
  self.headItem:SetHpBarActive(false)
end

function UINUltSkillHeroItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCreatSpecialUltHearoEffect, self.__OnCreatSpecialUltHearoEffect)
  MsgCenter:RemoveListener(eMsgEventId.OnShowSpeicalUltHearoEffect, self.__OnShowSpeicalUltHearoEffect)
  MsgCenter:RemoveListener(eMsgEventId.OnHideSpeicalUltHearoEffect, self.__OnHideSpeicalUltHearoEffect)
  self.headItem:Delete()
  self.fxpCanvas = nil
  self.hpCanvas = nil
  base.OnDelete(self)
end

return UINUltSkillHeroItem
