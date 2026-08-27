local base = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINEpChipDetail = class("UINEpChipDetail", base)
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINButtonGroup = require("Game.Exploration.UI.SelectChip.UINEpChipDetailButtonGroup")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_EaseLinear = CS.DG.Tweening.Ease.Linear
local cs_Material = CS.UnityEngine.Material
local cs_PropertyNameHash = CS.UGUIExtend.Ui3DModifier.propertyNameHash
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType

function UINEpChipDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadItem, self.ui.obj_HeroHeadItem)
  self.buttonGroup = UINButtonGroup.New()
  self.buttonGroup:Init(self.ui.obj_Group)
  self.ui.obj_HeroHeadItem:SetActive(false)
  self.ui.obj_AllHero:SetActive(false)
  self.ui.obj_ReCC:SetActive(false)
  if not IsNull(self.ui.root) then
    self._defaultRootPos = self.ui.root.localPosition
    self._refreshRootPos = Vector3.New(self._defaultRootPos.x, self._defaultRootPos.y + 60, self._defaultRootPos.z)
  end
  self.effPrefabDic = {}
  if IsNull(self.dissolveMat) then
    if isEditorMode then
      self.dissolveMat = CS.UnityEngine.Object.Instantiate(self.ui.Mat_fXMImage)
    else
      self.dissolveMat = self.ui.Mat_fXMImage
    end
    if not IsNull(self.ui.modifier.material) then
      local matrix = self.ui.modifier.material:GetMatrix(cs_PropertyNameHash)
      self.dissolveMat:SetMatrix(cs_PropertyNameHash, matrix)
    end
  end
  for i = 1, #self.ui.Img_ButtomList do
    local image = self.ui.Img_ButtomList[i]
    image.material = self.dissolveMat
  end
  self.ui.Obj_discard:SetActive(false)
  self:SetObjNewTagActive(false)
  base.SetBaseBackground(self, self.ui.Fad_Item.transform)
end

function UINEpChipDetail:InitEpChipDetail(index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, powerType, isOwnData)
  base.InitBaseChipDetail(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  self:_InitEpChipEffectInfo(chipData, dynPlayer, powerType, isOwnData)
end

function UINEpChipDetail:_InitEpChipEffectInfo(chipData, dynPlayer, powerType, isOwnData)
  self:_InitHeroHead(chipData, dynPlayer)
  self:_InitFightPower(chipData, dynPlayer, powerType, isOwnData)
  self:_InitReturnCC(chipData, dynPlayer, isOwnData)
  self.buttonGroup:InitChipDetailButtonGroup(self)
  local index = self.level:HasFlashTween() and 1 or 0
  if self.dissolveSeq ~= nil then
    self.dissolveSeq:Complete()
  end
end

function UINEpChipDetail:_InitHeroHead(chipData, dynPlayer)
  self.heroHeadPool:HideAll()
  self:_SetTacticNodeActive(false)
  self.ui.obj_AllHero:SetActive(false)
  self.ui.obj_HeroMask:SetActive(false)
  if dynPlayer == nil then
    return
  end
  if chipData ~= nil and chipData:IsValidDynPlayer() then
    self:_SetTacticNodeActive(true, chipData:IsConsumeSkillChip() and 1 or 0)
    return
  end
  local validCharacters = chipData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
  local isAllHero = #validCharacters >= #dynPlayer.heroList
  self.ui.tran_heroHeadList.gameObject:SetActive(not isAllHero)
  self.ui.obj_AllHero:SetActive(isAllHero)
  if isAllHero then
    return
  end
  self.ui.obj_HeroMask:SetActive(true)
  for _, dynHero in pairs(validCharacters) do
    local heroHeadItem = self.heroHeadPool:GetOne()
    heroHeadItem:InitHeroHeadItem(dynHero.heroData, self.__resloader)
    heroHeadItem:Show()
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local maskWidth = self.ui.tran_HeroHeadMask.rect.width
  local headListWidth = self.ui.tran_heroHeadList.rect.width
  self.ui.tran_heroHeadList.localPosition = Vector3.zero
  self.ui.tran_heroHeadList.anchoredPosition = Vector2.zero
  self:_ClearHeroHeadSequece()
  if maskWidth > headListWidth then
    return
  end
  local sequece = cs_DoTween.Sequence()
  sequece:AppendInterval(1)
  sequece:Append(self.ui.tran_heroHeadList:DOLocalMoveX(maskWidth - headListWidth, 4):SetRelative(true):SetEase(cs_EaseLinear))
  sequece:AppendInterval(1)
  sequece:SetAutoKill(false)
  sequece:SetLoops(-1)
  self._heroHeadSeq = sequece
end

function UINEpChipDetail:_ClearHeroHeadSequece()
  if self._heroHeadSeq ~= nil then
    self._heroHeadSeq:Kill()
    self._heroHeadSeq = nil
  end
end

function UINEpChipDetail:_InitFightPower(chipData, dynPlayer, powerType, isOwnData)
  self.ui.obj_PowerNode:SetActive(dynPlayer == nil)
  if dynPlayer == nil then
    return
  end
  self.fightPower = 0
  if powerType == eChipDetailPowerType.Add or powerType == nil then
    self.ui.obj_PowerNode:SetActive(true)
    self.fightPower = dynPlayer:GetChipCombatEffect(chipData, isOwnData)
    self.ui.tex_Power:SetIndex(0, GetPreciseDecimalStr(self.fightPower, 1))
  elseif powerType == eChipDetailPowerType.Subtract then
    self.ui.obj_PowerNode:SetActive(true)
    self.fightPower = dynPlayer:GetChipDiscardFightPower(chipData)
    self.ui.tex_Power:SetIndex(1, GetPreciseDecimalStr(self.fightPower, 1))
  else
    self.ui.obj_PowerNode:SetActive(false)
  end
  if self.fightPower == 0 then
    self:SetAddSuitFxActive(false)
  end
end

function UINEpChipDetail:_InitReturnCC(chipData, dynPlayer, isOwnData)
  self.ui.obj_ReCC:SetActive(false)
  if dynPlayer == nil then
    return
  end
  if not isOwnData then
    local returnMoney = dynPlayer:GetChipReturnMoney(chipData.dataId, chipData:GetCount())
    if 0 < returnMoney and self.ui.obj_ReCC ~= nil then
      self.ui.obj_ReCC:SetActive(true)
      self.ui.tex_ReCC.text = tostring(returnMoney)
    end
  end
end

function UINEpChipDetail:GetInPlayFightPower(dynPlayer, isSubtract)
  if isSubtract then
    return dynPlayer:GetChipDiscardFightPower(self._chipData, true)
  else
    return dynPlayer:GetChipCombatEffect(self._chipData, self._isOwnData, true)
  end
end

function UINEpChipDetail:OnSelectChipChanged(select)
  if select then
    self:UnSelectAlpha(not select)
  else
  end
  self:SetSelectAnima(select)
  self:ShowHeroHeadOrTacticActive(select)
end

function UINEpChipDetail:ShowHeroHeadOrTacticActive(active)
end

function UINEpChipDetail:UnSelectAlpha(boolean)
  self.ui.tran_Mask.localScale = boolean and Vector3.one or Vector3.zero
end

function UINEpChipDetail:SetSelectAnima(active)
end

function UINEpChipDetail:SetUnSelectAlpha()
  self:UnSelectAlpha(true)
end

function UINEpChipDetail:_SetTacticNodeActive(active, index)
  self.ui.obj_TacticNode:SetActive(active)
  if active then
    self.ui.text_TacticNode:SetIndex(index or 0)
    self.ui.textEn_TacticNode:SetIndex(index or 0)
  end
end

function UINEpChipDetail:EnableChipDetailPanelClick(enable)
  self.ui.canvasGroup.interactable = enable
end

function UINEpChipDetail:GetChipDetailPanelData()
  return self._chipData
end

function UINEpChipDetail:GetAutoTipsHolder()
  return self.ui.tran_AutoTipsHolder
end

function UINEpChipDetail:GetChipItemTransform()
  return self.ui.img_Icon.transform
end

function UINEpChipDetail:ShowChipPanelRefreshTween(updItemFunc, index, onlyMoveDown)
  self:_ClearRefreshSequece()
  self:EnableChipDetailPanelClick(false)
  local sequece = cs_DoTween.Sequence()
  local deplay = 0
  if not onlyMoveDown then
    self.ui.canvasGroup.alpha = 1
    self.ui.root.localPosition = self._defaultRootPos
    deplay = 0.04 * index
    sequece:Insert(deplay, self.ui.root:DOLocalMoveY(self._refreshRootPos.y, 0.2))
    sequece:Insert(deplay, self.ui.canvasGroup:DOFade(0, 0.2))
  end
  sequece:InsertCallback(deplay, function()
    updItemFunc()
    self:UnSelectAlpha(false)
    self:SetSelectAnima(false)
    self:ShowHeroHeadOrTacticActive(false)
  end)
  if onlyMoveDown then
    self.ui.canvasGroup.alpha = 0
    self.ui.root.localPosition = self._refreshRootPos
    deplay = 0.04 * index
  end
  deplay = deplay + 0.2
  sequece:Insert(deplay, self.ui.root:DOLocalMoveY(self._defaultRootPos.y, 0.2))
  sequece:Insert(deplay, self.ui.canvasGroup:DOFade(1, 0.2))
  sequece:OnComplete(function()
    self:EnableChipDetailPanelClick(true)
  end)
  self._refreshSequece = sequece
end

function UINEpChipDetail:_ClearRefreshSequece()
  if self._refreshSequece ~= nil then
    self._refreshSequece:Kill()
    self._refreshSequece = nil
  end
end

function UINEpChipDetail:ShowEpChipDetailEff(xRotate)
  if self.effItemData ~= nil then
    self.effItemData.go:SetActive(false)
    self.effItemData.eff:Stop()
  end
  local isRainChip = self._chipData:GetChipType() == ChipEnum.eChipType.Rain
  if not isRainChip and not self.level:HasFlashTween() then
    return
  end
  local quality, path
  if isRainChip then
    quality = 0
    path = RainDetailEffPath
  else
    quality = self._chipData:GetQuality()
    path = ChipDetailEffPatch[quality]
  end
  local effItemData = self.effPrefabDic[quality]
  if effItemData ~= nil then
    effItemData.eff:Play()
    effItemData.go:SetActive(true)
    self.effItemData = effItemData
    return
  end
  self._resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    if self.ui == nil then
      return
    end
    if self.ui.tran_EffHolder == nil or IsNull(self.ui.tran_EffHolder.gameObject) then
      return
    end
    effItemData = {}
    local go = prefab:Instantiate(self.ui.tran_EffHolder)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    particleSystem:Stop()
    go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
    particleSystem:Play()
    effItemData.go = go
    effItemData.eff = particleSystem
    self.effPrefabDic[quality] = effItemData
    self.effItemData = effItemData
  end)
end

function UINEpChipDetail:OnDissolveTweenCompleteAction(Action)
  self.onDissolveTweenComplete = Action
end

function UINEpChipDetail:PlayDissolveTween()
  self:InitDissolveTweenSetting()
  if self.dissolveSeq ~= nil then
    self.dissolveSeq:Restart()
    return
  end
  local dissolveSeq = cs_DoTween.Sequence()
  dissolveSeq:SetAutoKill(false)
  dissolveSeq:SetLink(self.gameObject)
  dissolveSeq:InsertCallback(0, function()
    self.dissolveMat:DOFloat(0, "_add", 0.35):SetLink(self.gameObject)
    self.dissolveMat:DOFloat(0.36, "_DissolutionAlpha", 0.35):SetLink(self.gameObject)
  end)
  dissolveSeq:AppendInterval(0.35)
  dissolveSeq:AppendCallback(function()
    self.dissolveMat:DOFloat(0.5, "_add", 0.35):SetLink(self.gameObject)
    self.dissolveMat:DOFloat(0, "_DissolutionAlpha", 0.35):SetLink(self.gameObject)
    self.ui.Fad_Item:DOFade(0, 0.35):SetLink(self.gameObject)
    self.ui.Obj_discard:SetActive(true)
  end)
  dissolveSeq:AppendInterval(self.ui.Ani_discard.clip.length)
  dissolveSeq:OnComplete(function()
    self.ui.Obj_discard:SetActive(false)
    if self.onDissolveTweenComplete ~= nil then
      self.onDissolveTweenComplete(self.index)
    end
  end)
  self.dissolveSeq = dissolveSeq
end

function UINEpChipDetail:InitDissolveTweenSetting()
  self.ui.Obj_discard:SetActive(false)
  self.ui.Fad_Item:DOKill()
  self.ui.Fad_Item.alpha = 1
  self.dissolveMat:DOKill()
  self.dissolveMat:SetFloat("_add", 1)
  self.dissolveMat:SetFloat("_DissolutionAlpha", 0)
end

function UINEpChipDetail:SetObjNewTagActive(active, chipShowState)
  if active then
    if chipShowState == ChipEnum.eChipShowState.NewState then
      self.ui.img_New.gameObject:SetActive(true)
      self.ui.img_New:SetIndex(0)
      self.ui.tex_New:SetIndex(0)
    elseif chipShowState == ChipEnum.eChipShowState.UpState then
      self.ui.img_New.gameObject:SetActive(true)
      self.ui.img_New:SetIndex(1)
      self.ui.tex_New:SetIndex(1)
    else
      self.ui.img_New.gameObject:SetActive(false)
    end
    self.ui.img_New.image:DOKill()
    self.ui.img_New.image.color = Color.white
    if self.ui.img_New.gameObject.activeInHierarchy then
      self.ui.img_New.image:DOFade(0, 0.7):SetLoops(-1, cs_DoTweenLoopType.Yoyo):SetLink(self.ui.img_New.gameObject)
    end
  else
    self.ui.img_New.gameObject:SetActive(false)
  end
  local index = chipShowState == ChipEnum.eChipShowState.NewState and 0 or 1
  self.buttonGroup:RefreshBtnSelectUI(index)
end

function UINEpChipDetail:GetDetailButtonGroup()
  return self.buttonGroup
end

function UINEpChipDetail:OnDelete()
  self:_ClearRefreshSequece()
  self:_ClearHeroHeadSequece()
  if isEditorMode then
    DestroyUnityObject(self.dissolveMat)
  end
  self.dissolveMat = nil
  base.OnDelete(self)
end

return UINEpChipDetail
