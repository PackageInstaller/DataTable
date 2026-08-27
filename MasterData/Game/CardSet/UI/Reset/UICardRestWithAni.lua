local base = UIBaseWindow
local UICardRestWithAni = class("UICardRestWithAni", base)
local UINCardRestWithAniItem = require("Game.CardSet.UI.Reset.UINCardRestWithAniItem")
local cs_DoTween = CS.DG.Tweening.DOTween
local MAX_ITEM_NUM = 10

function UICardRestWithAni:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(false):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  self._itemPool = UIItemPool.New(UINCardRestWithAniItem, self.ui.item, false)
  self._itemSpace = self.ui.itemHolder.spacing
  self._itemSizeX = self.ui.item.transform.sizeDelta.x
end

function UICardRestWithAni:InitCardRestAni(cardSetData, callback)
  self.__cardSetData = cardSetData
  self.__callback = callback
  self:__RefreshItems()
  self:__playTween()
end

function UICardRestWithAni:__RefreshItems()
  local roundCfgList = self.__cardSetData:GetCardSetRoundInfo()
  local curRound = self.__cardSetData:GetCardSetCurRound()
  local lastRoundIndex = #roundCfgList
  local loopRoundCfgList = {}
  for _, cfg in ipairs(roundCfgList) do
    if cfg.is_turns then
      table.insert(loopRoundCfgList, cfg)
    end
  end
  self._itemPool:HideAll()
  local half = MAX_ITEM_NUM // 2
  for roundIndex = math.max(curRound - half, 1), curRound + half do
    local cfg
    local isLoop = roundIndex > lastRoundIndex
    local isLastNotLoop = roundIndex == lastRoundIndex
    if not isLoop then
      cfg = roundCfgList[roundIndex]
    else
      local loopIndex = (roundIndex - lastRoundIndex) % #loopRoundCfgList
      if loopIndex == 0 then
        loopIndex = #loopRoundCfgList
      end
      cfg = loopRoundCfgList[loopIndex]
    end
    local item = self._itemPool:GetOne()
    item:RefreshCardResrAniItem(roundIndex, cfg, isLastNotLoop, curRound)
    if roundIndex == curRound - 1 then
      self._lastRoundItem = item
    end
    if roundIndex == curRound then
      self._curRoundItem = item
    end
  end
  local index = 0
  if curRound < lastRoundIndex then
    index = 0
  elseif curRound == lastRoundIndex then
    index = 1
  elseif curRound > lastRoundIndex then
    index = 2
  end
  self.ui.text_process:SetIndex(index)
  self.ui.text_processEN:SetIndex(index)
end

function UICardRestWithAni:__playTween()
  if self._lastRoundItem == nil then
    error("self._lastRoundItem is nil")
    return
  end
  if self._curRoundItem == nil then
    error("self._curRoundItem is nil")
    return
  end
  local lineImg = self._lastRoundItem:GetCardResrAniItemLineImg()
  lineImg.fillAmount = 0
  self.ui.down_cg.alpha = 0
  local curRound = self.__cardSetData:GetCardSetCurRound()
  local lastRound = curRound - 1
  local old_x = -self:__GetHolderPos4Index(lastRound)
  self.ui.trans_itemHolder.anchoredPosition = Vector2.Temp(old_x, 0)
  local cur_x = -self:__GetHolderPos4Index(curRound)
  local sequence = cs_DoTween.Sequence():AppendInterval(0.2):Append(self.ui.top_cg:DOFade(0, 0.7):From()):Join(self.ui.top_cg.transform:DOAnchorPosX(self.ui.top_cg.transform.anchoredPosition.x - 200, 0.7):From()):Insert(0.5, self.ui.down_cg:DOFade(1, 0.2)):Append(self.ui.trans_itemHolder:DOAnchorPosX(cur_x, 0.7)):Join(lineImg:DOFillAmount(1, 0.7)):AppendCallback(function()
    self._curRoundItem:SetCardResrAniItemDotComplete()
    self.ui.dt_Select:DOPlayForward()
  end):AppendInterval(2):Append(self.ui.root_cg:DOFade(0, 0.5)):AppendCallback(function()
    self:Delete()
  end):SetLink(self.gameObject)
end

function UICardRestWithAni:__GetHolderPos4Index(roundIndex)
  local half = MAX_ITEM_NUM / 2
  local curRound = self.__cardSetData:GetCardSetCurRound()
  local min = math.max(curRound - half, 1)
  local num = roundIndex - min
  local offset = num * (self._itemSpace + self._itemSizeX)
  return offset
end

function UICardRestWithAni:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UICardRestWithAni:OnDelete()
  if self.__callback ~= nil then
    self.__callback()
  end
  base.OnDelete(self)
end

return UICardRestWithAni
