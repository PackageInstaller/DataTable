local base = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINWCChipDetailCombat = class("UINWCChipDetailCombat", base)
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_EaseLinear = CS.DG.Tweening.Ease.Linear
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINWCChipDetailCombat:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadItem, self.ui.obj_HeroHeadItem)
  self.ui.obj_HeroHeadItem:SetActive(false)
end

function UINWCChipDetailCombat:InitWCChipDetailCombat(chipData, dynPlayer, resloader, isOwnData)
  base.InitBaseChipDetail(self, nil, chipData, nil, resloader)
  self:_InitHeroHead(chipData, dynPlayer)
  self:_InitFightPower(chipData, dynPlayer, nil, isOwnData)
end

function UINWCChipDetailCombat:_InitHeroHead(chipData, dynPlayer)
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

function UINWCChipDetailCombat:_ClearHeroHeadSequece()
  if self._heroHeadSeq ~= nil then
    self._heroHeadSeq:Kill()
    self._heroHeadSeq = nil
  end
end

function UINWCChipDetailCombat:_InitFightPower(chipData, dynPlayer, powerType, isOwnData)
  self.ui.obj_PowerNode:SetActive(dynPlayer == nil)
  if dynPlayer == nil then
    return
  end
  self.fightPower = 0
  if powerType == eChipDetailPowerType.Add or powerType == nil then
    self.ui.obj_PowerNode:SetActive(true)
    self.fightPower = dynPlayer:GetChipDiscardFightPower(chipData)
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

function UINWCChipDetailCombat:_SetTacticNodeActive(active, index)
  self.ui.obj_TacticNode:SetActive(active)
  if active then
    self.ui.text_TacticNode:SetIndex(index or 0)
    self.ui.textEn_TacticNode:SetIndex(index or 0)
  end
end

function UINWCChipDetailCombat:GetWCChipDetailPanelData()
  return self._chipData
end

function UINWCChipDetailCombat:OnDelete()
  self:_ClearHeroHeadSequece()
  base.OnDelete(self)
end

return UINWCChipDetailCombat
