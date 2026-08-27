local UIActSum22DunRepeat = class("UIActSum22DunRepeat", UIBaseWindow)
local base = UIBaseWindow
local UIActSum22DunRepeatItem = require("Game.ActivitySummer.Year22.DunRepeat.UINActSum22DunRepeatItem")
local cs_DoTween = CS.DG.Tweening.DOTween

function UIActSum22DunRepeat:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChallenge)
  self._itemPool = UIItemPool.New(UIActSum22DunRepeatItem, self.ui.item)
  self.ui.item:SetActive(false)
  UIUtil.AddButtonListener(self.ui.doubleBg, self, self.OnClickDoubleReward)
  UIUtil.AddButtonListener(self.ui.ticketItem, self, self.__OnClickTicketRes)
  self.__OnSelectChallengeCallback = BindCallback(self, self.__OnSelectChallenge)
  self.__RefreshCoinCallback = BindCallback(self, self.__RefreshCoin)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshCoinCallback)
  for k, anim in ipairs(self.ui.anim_iconList) do
    anim:get_Item("UI_ActSum22DunRepeatIcon").time = k * 0.75
  end
end

function UIActSum22DunRepeat:InitSum22DunRepeat(sum22Data, callback)
  self._sum22Data = sum22Data
  self._callback = callback
  self._dungeonLevelDic = self._sum22Data:GetSectorIIIDungeonInfo()
  self.ui.bg_animation:Play()
  local mainCfg = self._sum22Data:GetSectorIIIMainCfg()
  self._showItemId = mainCfg.ticket_item
  self.ui.icon.sprite = CRH:GetSpriteByItemId(self._showItemId, true)
  self:__RefreshCoin()
  self:__RefreshDouble()
  self:__RefreshPointMultRate()
  self._showSe = cs_DoTween.Sequence():SetLink(self.gameObject)
  for k, lineImg in ipairs(self.ui.list_line) do
    local time = k * 0.05 + 0.5
    self._showSe:Insert(time, lineImg.transform:DOScale(0, 0.33):From())
    self._showSe:Insert(time, lineImg:DOFade(0, 0.22):From())
  end
  self._itemPool:HideAll()
  for _, dungeonlevel in pairs(self._dungeonLevelDic) do
    local item = self._itemPool:GetOne()
    item:InitSum22ChallengeItem(dungeonlevel, self.__OnSelectChallengeCallback)
    local idx = dungeonlevel:GetDungeonIndex()
    local parentTr = self.ui.list_posTr[idx]
    if parentTr == nil then
      if isGameDev then
        error("没有这个副本的位置 " .. tostring(dungeonlevel:GetDungeonLevelStageId()))
      end
    else
      item.transform:SetParent(parentTr)
      item.transform.anchoredPosition = Vector2.zero
      local time = idx * 0.1 + 0.4
      local itemCg = item:GetSum22ChallengeItemCanvasGroup()
      self._showSe:Insert(time, itemCg:DOFade(0, 0.2):From())
      self._showSe:Insert(time, item.transform:DOAnchorPos(Vector2.Temp(0, -10), 0.4):From())
    end
  end
end

function UIActSum22DunRepeat:__RefreshCoin()
  self.ui.tex_Point.text = tostring(PlayerDataCenter:GetItemCount(self._showItemId))
end

function UIActSum22DunRepeat:__RefreshPointMultRate()
  local pointMultRateDic = self._sum22Data:GetSectorIII_PointMultRat()
  local poitId = self._sum22Data:GetSectorIIIDunPointId()
  local multRata = pointMultRateDic[poitId] or 0
  local isHaveMultRate = 0 < multRata
  self.ui.pointUpBg:SetActive(isHaveMultRate)
  if not isHaveMultRate then
    return
  end
  self.ui.tex_PointUp.text = string.format("+%s%%", GetPreciseDecimalStr(multRata / 10, 0))
end

function UIActSum22DunRepeat:__RefreshDouble()
  local rate = self._sum22Data:GetSectorIII_EffiMultRate()
  local isCouldUsingMultEffi = 0 < rate
  self.ui.doubleBg.gameObject:SetActive(isCouldUsingMultEffi)
  if isCouldUsingMultEffi then
    local isUsingMultEffi = self._sum22Data:SectorIII_IsFarmDouble()
    self.ui.img_Choose:SetActive(isUsingMultEffi)
    self.ui.tex_Additon:SetIndex(0, tostring(rate + 1))
  end
end

function UIActSum22DunRepeat:OnClickDoubleReward()
  local isUsingMultEffi = self._sum22Data:SectorIII_IsFarmDouble()
  self._sum22Data:SectorIII_SetFarmDouble(not isUsingMultEffi)
  self:__RefreshDouble()
end

function UIActSum22DunRepeat:__OnSelectChallenge(dungenLevelData)
  local isLocked = not dungenLevelData:GetIsLevelUnlock()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
    if win == nil then
      return
    end
    win:InitDungeonLevelDetail(dungenLevelData, isLocked)
    win:SetDungeonLevelBgClose(true)
  end)
end

function UIActSum22DunRepeat:__OnClickTicketRes()
  local itemCfg = ConfigData.item[self._sum22Data:GetSectorIIIDunTicketId()]
  if itemCfg == nil then
    return
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:InitCommonItemDetail(itemCfg)
end

function UIActSum22DunRepeat:OnCloseChallenge()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIActSum22DunRepeat:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshCoinCallback)
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  base.OnDelete(self)
end

return UIActSum22DunRepeat
