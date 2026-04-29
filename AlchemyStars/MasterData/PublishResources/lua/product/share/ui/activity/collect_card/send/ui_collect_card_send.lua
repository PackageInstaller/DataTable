_class("UICollectCardSend", UIController)
UICollectCardSend = UICollectCardSend

function UICollectCardSend:LoadDataOnEnter(TT, res, uiParams)
  self._socialModule = GameGlobal.GetModule(SocialModule)
  self._allFriendList = self._socialModule:GetFriendList(TT) or {}
  self._itemCountPerRow = 1
  self._PersonSendCardNUm = Cfg.cfg_global.PersonSendCardNUm.IntValue
  self._SendCardNum = Cfg.cfg_global.SendCardNum.IntValue
  self._cardCom = uiParams[1]
  self._campID = uiParams[2]
  self._comInfo = self._cardCom:GetComponentInfo()
  self:GetFilterList()
  self:GetFriendList()
end

function UICollectCardSend:GetFilterList()
  self._filterList = {}
  local filterMap = self._comInfo.send_card_info
  if filterMap and table.count(filterMap) then
    for pstid, count in pairs(filterMap) do
      if count >= self._PersonSendCardNUm then
        table.insert(self._filterList, pstid)
      end
    end
  end
end

function UICollectCardSend:GetFriendList()
  self._friendList = {}
  local tmpList = {}
  for pstId, data in pairs(self._allFriendList) do
    local simpleInfo = data.simple_info
    table.insert(tmpList, simpleInfo)
  end
  for key, value in pairs(tmpList) do
    if not table.icontains(self._filterList, value.pstid) then
      table.insert(self._friendList, value)
    end
  end
  table.sort(self._friendList, function(a, b)
    local weight_a = 0
    local weight_b = 0
    if a.is_online then
      weight_a = weight_a + 100
    end
    if b.is_online then
      weight_b = weight_b + 100
    end
    if a.last_logout_time > b.last_logout_time then
      weight_a = weight_a + 10
    else
      weight_b = weight_b + 10
    end
    if a.pstid < b.pstid then
      weight_a = weight_a + 1
    else
      weight_b = weight_b + 1
    end
    return weight_a > weight_b
  end)
end

function UICollectCardSend:OnShow(uiParam)
  self._selectFriend = nil
  self._selectFriendIdx = 0
  self._selectCard = nil
  self._cards = nil
  self:GetComponents()
  self:OnValue()
  self:AttachEvent(GameEventType.OnCollectCardSelectCard, self.OnCollectCardSelectCard)
end

function UICollectCardSend:GetComponents()
  self._friendScrollView = self:GetUIComponent("UIDynamicScrollView", "FriendList")
  self._needCardPool = self:GetUIComponent("UISelectObjectPath", "NeedCardPool")
  self._normalCardPool = self:GetUIComponent("UISelectObjectPath", "NormalCardPool")
  self._cardGo = self:GetGameObject("CardGo")
  self._noCardGo = self:GetGameObject("NoCardGo")
  self._needLayout = self:GetGameObject("NeedLayout")
  self._normalLayout = self:GetGameObject("NormalLayout")
  self._noCardDesc = self:GetUIComponent("UILocalizationText", "NoCardDesc")
  self._sendBtn = self:GetGameObject("SendBtn")
  self._sendBtnHide = self:GetGameObject("SendBtnHide")
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self._contentRT = self:GetUIComponent("RectTransform", "Content")
end

function UICollectCardSend:OnValue()
  self:SetFriendList()
  self:SetSelectInfo()
end

function UICollectCardSend:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local luaUnit = rowPool:SpawnObject("UICollectCardFriendItem")
  if luaUnit then
    local luaIdx = index + 1
    local info = self._friendList[luaIdx]
    luaUnit:SetData(luaIdx, info, function(idx)
      self:OnFriendItemClick(idx)
    end, self._selectFriendIdx)
  end
  return item
end

function UICollectCardSend:SetFriendList()
  if self._friendScrollViewInited then
    self._friendScrollView:SetListItemCount(#self._friendList)
    self._friendScrollView:RefreshAllShownItem()
    self._friendScrollView:MovePanelToItemIndex(0, 0)
  else
    self._friendScrollView:InitListView(#self._friendList, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._friendScrollViewInited = true
  end
end

function UICollectCardSend:OnFriendItemClick(idx)
  if self._friendList[idx] == self._selectFriend then
    return
  else
    self._selectFriend = self._friendList[idx]
    self._selectFriendIdx = idx
    self._selectCard = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCollectCardSelectCard, self._selectCard)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCollectCardSelectFriend, idx)
  self:SetSelectInfo()
end

function UICollectCardSend:SetSelectInfo()
  if self._selectFriend then
    self:SetCardList()
  else
    self:SetNoSelectFriend()
  end
end

function UICollectCardSend:GetMyCards()
  local allCards = self._comInfo.card
  local cardList = {}
  for key, value in pairs(allCards) do
    if self:IsNormalCard(key) and 1 < value then
      local tab = {}
      tab.id = key
      tab.count = value - 1
      table.insert(cardList, tab)
    end
  end
  return cardList
end

function UICollectCardSend:IsNormalCard(id)
  local cfg = Cfg.cfg_component_collect_card[id]
  if cfg.Type == 1 then
    return true
  end
  return false
end

function UICollectCardSend:GetCards()
  local needCards = {}
  local normalCards = {}
  local myCards = self:GetMyCards()
  self._cards = {}
  for key, value in pairs(myCards) do
    local id = value.id
    if self._selectFriend.collect_cards[self._campID] then
      if self._selectFriend.collect_cards[self._campID][id] then
        table.insert(normalCards, value)
      else
        table.insert(needCards, value)
      end
    else
      table.insert(needCards, value)
    end
  end
  if needCards and 0 < #needCards then
    self:SortCard(needCards)
    self._cards.need = needCards
  end
  if normalCards and 0 < #normalCards then
    self:SortCard(normalCards)
    self._cards.normal = normalCards
  end
end

function UICollectCardSend:SortCard(cardList)
  table.sort(cardList, function(a, b)
    return a.id < b.id
  end)
end

function UICollectCardSend:SetCardList()
  self._scrollRect:StopMovement()
  self._contentRT.anchoredPosition = Vector2(0, 0)
  self:GetCards()
  if self._cards and 0 < table.count(self._cards) then
    self._noCardGo:SetActive(false)
    self._cardGo:SetActive(true)
    self:SetNeedCardList()
    self:SetNormalCardList()
    self:SetScrollRectEnable()
    self:OnCollectCardSelectCard()
  else
    self:SetNoCards()
  end
end

function UICollectCardSend:SetScrollRectEnable()
  local normalLen = 0
  if self._cards.normal then
    normalLen = table.count(self._cards.normal)
  end
  local needLen = 0
  if self._cards.need then
    needLen = table.count(self._cards.need)
  end
  local enable = true
  local needRow = 0
  if 0 < needLen then
    needRow = (needLen - 1) // 3 + 1
  end
  local normalRow = 0
  if 0 < normalLen then
    normalRow = (normalLen - 1) // 3 + 1
  end
  local row = normalRow + needRow
  if row <= 2 then
    enable = false
  end
  self._scrollRect.enabled = enable
end

function UICollectCardSend:SetNoCards()
  self._noCardGo:SetActive(true)
  self._cardGo:SetActive(false)
  local tips = StringTable.Get("str_collect_card_friend_tips10")
  self._noCardDesc:SetText(tips)
end

function UICollectCardSend:SetNoSelectFriend()
  self._noCardGo:SetActive(true)
  self._cardGo:SetActive(false)
  local tips = StringTable.Get("str_collect_card_friend_tips4")
  self._noCardDesc:SetText(tips)
end

function UICollectCardSend:SetNeedCardList()
  local show = self._cards.need and #self._cards.need > 0
  self._needLayout:SetActive(show)
  if show then
    self._needCardPool:SpawnObjects("UICollectCardSendCardItem", #self._cards.need)
    local pools = self._needCardPool:GetAllSpawnList()
    for i = 1, #self._cards.need do
      local card = self._cards.need[i]
      local item = pools[i]
      item:SetData(i, card, function(cardid)
        self:SelectCard(cardid)
      end)
    end
  end
end

function UICollectCardSend:SelectCard(id)
  if id == self._selectCard then
    self._selectCard = nil
  elseif self._selectCard == nil then
    self._selectCard = id
  else
    local tips = StringTable.Get("str_collect_card_friend_tips9")
    ToastManager.ShowToast(tips)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCollectCardSelectCard, self._selectCard)
end

function UICollectCardSend:OnCollectCardSelectCard()
  self._sendBtn:SetActive(self._selectCard ~= nil)
  self._sendBtnHide:SetActive(self._selectCard == nil)
end

function UICollectCardSend:SetNormalCardList()
  local show = self._cards.normal and #self._cards.normal > 0
  self._normalLayout:SetActive(show)
  if show then
    self._normalCardPool:SpawnObjects("UICollectCardSendCardItem", #self._cards.normal)
    local pools = self._normalCardPool:GetAllSpawnList()
    for i = 1, #self._cards.normal do
      local card = self._cards.normal[i]
      local item = pools[i]
      item:SetData(i, card, function(cardid)
        self:SelectCard(cardid)
      end)
    end
  end
end

function UICollectCardSend:CheckSendMax()
  local filterMap = self._comInfo.send_card_info
  local sendCount = 0
  if filterMap and 0 < table.count(filterMap) then
    for key, value in pairs(filterMap) do
      sendCount = sendCount + value
    end
  end
  return sendCount >= self._SendCardNum
end

function UICollectCardSend:SendBtnOnClick(go)
  if self:CheckSendMax() then
    local tips = StringTable.Get("str_collect_card_gift_max")
    ToastManager.ShowToast(tips)
    return
  end
  local cardCfg = Cfg.cfg_component_collect_card[self._selectCard]
  local cardName = cardCfg.Name
  local friendName
  if string.isnullorempty(self._selectFriend.remark_name) then
    friendName = self._selectFriend.nick
  else
    friendName = self._selectFriend.remark_name
  end
  local desc = StringTable.Get("str_collect_card_friend_tips12", StringTable.Get(cardName), friendName)
  self:ShowDialog("UICollectCardPop", desc, function()
    self:HandleSendCardReq()
  end)
end

function UICollectCardSend:HandleSendCardReq()
  if self._selectFriend and self._selectCard then
    self:Lock("UICollectCardSend:HandleSendCardReq")
    GameGlobal.TaskManager():StartTask(self.OnHandleSendCardReq, self)
  end
end

function UICollectCardSend:OnHandleSendCardReq(TT)
  local res = AsyncRequestRes:New()
  local pstid = self._selectFriend.pstid
  res = self._cardCom:HandleSendCardReq(TT, res, pstid, self._selectCard)
  self:UnLock("UICollectCardSend:HandleSendCardReq")
  if res and res:GetSucc() then
    local tips = StringTable.Get("str_collect_card_friend_tips13")
    ToastManager.ShowToast(tips)
    Log.debug("###[UICollectCardSend] start refresh ui view !")
    self:ClearSelectFriend()
    self._selectCard = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCollectCardSelectCard, self._selectCard)
    self._cards = nil
    self:GetFilterList()
    self:GetFriendList()
    self:OnValue()
  else
    local result = res:GetResult()
    Log.error("###[UICollectCardSend] OnHandleSendCardReq fail ! result:", result)
  end
end

function UICollectCardSend:ClearSelectFriend()
  local pstid = self._selectFriend.pstid
  local filterMap = self._comInfo.send_card_info
  if filterMap and table.count(filterMap) then
    local info = filterMap[pstid]
    if info and info >= self._PersonSendCardNUm then
      self._selectFriend = nil
      self._selectFriendIdx = 0
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCollectCardSelectFriend, 0)
    end
  end
end

function UICollectCardSend:CloseBtnOnClick(go)
  self:CloseDialog()
end
