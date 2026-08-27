local UINChipLevel = class("UINChipLevel", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType
local cs_DoTween = CS.DG.Tweening.DOTween
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINChipLevel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  local buttonRect = self.ui.img_Count.sprite.rect
  self.buttonWith = buttonRect.width
  self.buttonHeight = buttonRect.height
  local unitRect = self.ui.img_Curr.image.sprite.rect
  self.unitWith = unitRect.width
  self.unitHeight = unitRect.height
end

function UINChipLevel:InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  self.hasFlashTween = false
  local isFirstGet = false
  local currLevel = 0
  if not isHideNxtLvlInfo and dynPlayer ~= nil then
    local playerChipDic = dynPlayer:GetNormalChipDic()
    if playerChipDic[chipData.dataId] ~= nil then
      currLevel = playerChipDic[chipData.dataId]:GetCount()
    else
      currLevel = chipData:GetCount()
      isFirstGet = true
    end
  else
    currLevel = chipData:GetCount()
  end
  self.currLevel = currLevel
  local maxLevel = chipData:GetChipMaxLevel()
  local nextLevel = math.min(isOwnData and currLevel + 1 or currLevel + chipData:GetCount(), chipData:GetChipMaxLevel())
  self.nextLevel = nextLevel
  self:RefreshLevelUI(currLevel, nextLevel, maxLevel, dynPlayer, isHideNxtLvlInfo, isFirstGet)
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    if self.ui.uiimg_level ~= nil then
      self.ui.uiimg_level:SetIndex(1)
    end
    if self.ui.img_level ~= nil then
      self.ui.img_level.color = Color.white
    end
    self.ui.img_Curr:SetIndex(1)
  else
    if self.ui.uiimg_level ~= nil then
      self.ui.uiimg_level:SetIndex(0)
    end
    self.ui.img_Curr:SetIndex(0)
  end
end

function UINChipLevel:InitChipLevelSimple(currLevel, maxlevel)
end

function UINChipLevel:RefreshLevelUI(currLevel, nextLevel, maxLevel, dynPlayer, isHideNxtLvlInfo, isFirstGet)
  if self.ui.obj_isMaxLevel ~= nil then
    self.ui.obj_isMaxLevel:SetActive(false)
  end
  self.ui.img_Curr.transform.sizeDelta = Vector2.zero
  self.ui.img_Next.transform.sizeDelta = Vector2.zero
  self.ui.img_Curr:SetIndex(0)
  self.ui.tran_Count.sizeDelta = Vector2.New(self.buttonWith * maxLevel, self.buttonHeight)
  if not IsNull(self.ui.fx_lvUpBg) then
    self.ui.fx_lvUpBg:SetActive(false)
  end
  if not IsNull(self.ui.obj_countFx) then
    self.ui.obj_countFx:SetActive(false)
    if self._seq_obj_countFx ~= nil then
      self._seq_obj_countFx:Pause()
    end
  end
  if maxLevel <= currLevel then
    self.ui.img_Curr.transform.sizeDelta = Vector2.New(self.unitWith * maxLevel, self.unitHeight)
    self.ui.img_Curr:SetIndex(1)
    if self.ui.obj_isMaxLevel ~= nil then
      self.ui.obj_isMaxLevel:SetActive(true)
    end
    return
  end
  if 0 <= currLevel and currLevel < nextLevel and not isHideNxtLvlInfo and dynPlayer ~= nil and not isFirstGet then
    self.ui.img_Curr.transform.sizeDelta = Vector2.New(self.unitWith * currLevel, self.unitHeight)
    local nextCount = math.clamp(nextLevel - currLevel, 1, maxLevel - currLevel)
    if self:_UseNewLevelTween() then
      self:_NewLevelTween(currLevel, nextCount)
    else
      self.ui.img_Next.transform.sizeDelta = Vector2.New(self.unitWith * nextCount, self.unitHeight)
      local nextCol = ConfigData:GetChipQuality(nextLevel)
      self.ui.img_Next.color = ItemQualityColor[nextCol]
      self.ui.img_Next:DOKill()
      self.ui.img_Next.color = Color.white
      local t = Time.time % 1.4
      self.ui.img_Next:DOFade(0, 0.7):From():SetLoops(-1, cs_DoTweenLoopType.Yoyo):SetLink(self.ui.img_Next.gameObject):Goto(t, true)
    end
    self.hasFlashTween = true
    return
  end
  self.ui.img_Curr.transform.sizeDelta = Vector2.New(self.unitWith * currLevel, self.unitHeight)
end

function UINChipLevel:_UseNewLevelTween()
  return not IsNull(self.ui.obj_countFx) and self.ui.fxList_newLvPoint ~= nil
end

function UINChipLevel:_NewLevelTween(curLevel, newLevelNum)
  if IsNull(self.ui.obj_countFx) or self.ui.fxList_newLvPoint == nil then
    return
  end
  local activeNum = 0
  for k, go in ipairs(self.ui.fxList_newLvPoint) do
    local show = curLevel <= k and newLevelNum > activeNum
    if show then
      activeNum = activeNum + 1
    end
    go:SetActive(show)
  end
  if self._seq_obj_countFx == nil then
    self.ui.fx_lvUpBg:SetActive(true)
    local seq = cs_DoTween.Sequence()
    seq:InsertCallback(0.75, function()
      self.ui.obj_countFx:SetActive(true)
    end):InsertCallback(2.5, function()
      self.ui.obj_countFx:SetActive(false)
    end):SetLoops(-1):SetLink(self.ui.obj_countFx)
    self._seq_obj_countFx = seq
  else
    self.ui.fx_lvUpBg:SetActive(true)
    self._seq_obj_countFx:Restart()
  end
end

function UINChipLevel:RefreshFlashTween()
  if not self.hasFlashTween then
    return
  end
  if self:_UseNewLevelTween() then
    self.ui.obj_countFx:SetActive(false)
    self.ui.fx_lvUpBg:SetActive(true)
    if self._seq_obj_countFx ~= nil then
      self._seq_obj_countFx:Restart()
    end
  else
    self.ui.img_Next:DOKill(true)
    self.ui.img_Next.color = Color.white
    local t = Time.time % 1.4
    self.ui.img_Next:DOFade(0, 0.7):From():SetLoops(-1, cs_DoTweenLoopType.Yoyo):SetLink(self.ui.img_Next.gameObject):Goto(t, true)
  end
end

function UINChipLevel:GetNextLevel()
  return self.nextLevel
end

function UINChipLevel:GetCurrLevel()
  return self.currLevel
end

function UINChipLevel:HasFlashTween()
  return self.hasFlashTween
end

function UINChipLevel:OnDelete()
  self.ui.img_Next:DOKill()
  base.OnDelete(self)
end

return UINChipLevel
