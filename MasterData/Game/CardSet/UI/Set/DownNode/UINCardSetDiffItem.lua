local UINCardSetDiffItem = class("UINCardSetDiffItem", UIBaseNode)
local base = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local cs_Ease = CS.DG.Tweening.Ease

function UINCardSetDiffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickSelect)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self.__OnClickChallenge)
end

function UINCardSetDiffItem:InitCardDiffItem(diffData, clickCallback, cardSetCtrl, existChallenge)
  self.diffData = diffData
  self.clickCallback = clickCallback
  self.cardSetCtrl = cardSetCtrl
  self:RefreshCardSetDiffItem()
  self.ui.mode:SetActive(existChallenge)
end

function UINCardSetDiffItem:RefreshCardSetDiffItem()
  local diffData = self.diffData
  local challengeDiffData = self.diffData:GetCardSetDiffChallengeData()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local actCardSetData = self.cardSetCtrl:GetCdStActData()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  local curSelectDiffId = cardSetData:GetCardSetCurDiffId()
  local isSelectedChallenge = challengeDiffData and challengeDiffData:GetCardSetDiffDiffId() == curSelectDiffId
  self._isSelectedChallenge = isSelectedChallenge
  if isSelectedChallenge then
    diffData = challengeDiffData
  end
  local isUnlock, unlockInfo = diffData:GetIsCardSetDiffUnlock()
  self._isUnlock = isUnlock
  local isSelected = diffData:GetCardSetDiffDiffId() == curSelectDiffId
  self.ui.obj_NoChallenge:SetActive(challengeDiffData == nil)
  self.ui.obj_challengeOn:SetActive(isSelectedChallenge)
  self.ui.obj_challengeOff:SetActive(not isSelectedChallenge)
  self.ui.img_PointArrow:SetActive(isSelectedChallenge)
  self.ui.img_PointArrow.gameObject.transform:DOLocalMoveY(-50, 0.5):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject)
  self.ui.img_AdditionArrow:SetActive(isSelectedChallenge)
  self.ui.img_AdditionArrow.gameObject.transform:DOLocalMoveY(-50, 0.5):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject)
  self.ui.btn_Challenge.gameObject:SetActive(challengeDiffData ~= nil)
  self.ui.obj_challengeClear:SetActive(false)
  if challengeDiffData then
    local passChanllengeTimes = actCardSetData:GetActCardSetPassDiffTimes(playType, challengeDiffData:GetCardSetDiffDiffId())
    if 0 < passChanllengeTimes then
      self.ui.obj_challengeClear:SetActive(true)
      self.ui.btn_Challenge.gameObject:SetActive(false)
    end
  end
  self.ui.obj_Selected:SetActive(isSelected)
  self.ui.obj_Lock:SetActive(not isUnlock)
  self.ui.tex_Word:SetIndex(isSelected and 1 or 0)
  self.ui.tex_Selection:SetIndex(isSelected and 1 or 0)
  self.ui.img_DiffBg.color = self.ui.color_DiffBg[isSelected and 1 or 2]
  self.ui.canvasGroup.alpha = isUnlock and 1 or 0.5
  self.ui.tex_Des.gameObject:SetActive(isUnlock)
  if isUnlock then
    self.ui.tex_Des.text = diffData:GetCardSetDiffDes()
  else
    self.ui.tex_LockDes.text = unlockInfo
  end
  local itemCfg = cardSetData:GetCurCardSetScoreItemCfg()
  self.ui.img_ScoreIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
  local baseValue, rate
  if playType == CardSetEnum.eSetType.normal or playType == CardSetEnum.eSetType.rewind then
    baseValue = diffData:GetCardSetBaseReward()
    rate = diffData:GetCardSetRewardCoe()
    self.ui.tex_Cost.text = tostring(diffData:GetCardSetDiffCostBattlePoint())
  elseif playType == CardSetEnum.eSetType.rank then
    baseValue = diffData:GetCardSetBaseScore()
    rate = diffData:GetCardSetScoreCoe()
    self.ui.tex_Cost.text = tostring(0)
  end
  local showAdd = math.floor((rate or 0) / 10)
  self.ui.tex_Lvl.text = diffData:GetCardSetDiffName()
  self.ui.tex_Point.text = tostring(baseValue)
  self.ui.tex_Additon:SetIndex(0, tostring(showAdd))
end

function UINCardSetDiffItem:__OnClickSelect()
  local diffData = self._isSelectedChallenge and self.diffData:GetCardSetDiffChallengeData() or self.diffData
  self:_ChangeDiff(diffData)
end

function UINCardSetDiffItem:__OnClickChallenge()
  local diffData = self._isSelectedChallenge and self.diffData or self.diffData:GetCardSetDiffChallengeData()
  self:_ChangeDiff(diffData)
end

function UINCardSetDiffItem:_ChangeDiff(diffData)
  if not self._isUnlock then
    return
  end
  if self.clickCallback ~= nil then
    self.clickCallback(diffData)
  end
end

function UINCardSetDiffItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetDiffItem
