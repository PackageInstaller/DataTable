_class("UILuckLandCardBag", UIController)
UILuckLandCardBag = UILuckLandCardBag

function UILuckLandCardBag:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandCardBag:OnShow(uiParams)
  self._perRowCount = 8
  self._preIndex = 0
  self._curIndex = 0
  self._fromInnerGame = uiParams[1]
  self._showDeleteBtn = uiParams[2]
  self._levelCardDatas = LuckLandData:GetInstance():CurCardDatas()
  if self._fromInnerGame then
    local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
    if entityMgr then
      local backpackPets = entityMgr:GetBackpackPets()
      self._levelCardDatas:ResetAllCardDatasFromInnerGame(backpackPets)
    end
  end
  self._cardWidgets = {}
  self._isDelete = false
  self:_InitWidget()
  self:_OnValue()
  self:AttachEvent(GameEventType.OnLuckLandDeleteCardSucc, self._OnLuckLandDeleteCardSucc)
  if self._fromInnerGame then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UILuckLandCardBag)
  end
end

function UILuckLandCardBag:OnHide()
  if self._task1 then
    GameGlobal.TaskManager():KillTask(self._task1)
    self._task1 = nil
  end
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
end

function UILuckLandCardBag:_InitWidget()
  self._cardCount = self:GetUIComponent("UILocalizationText", "CardCount")
  self._deleteCost = self:GetUIComponent("UILocalizationText", "DeleteCost")
  self._costGO = self:GetGameObject("Cost")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._deleteBtnGO = self:GetGameObject("DeleteBtn")
  self._cancleDeleteBtnGO = self:GetGameObject("CancleDeleteBtn")
  self._deleteBtnGO:SetActive(self._showDeleteBtn and not self._levelCardDatas:IsOnlyOne())
  self._costGO:SetActive(self._showDeleteBtn and not self._levelCardDatas:IsOnlyOne())
  self._cancleDeleteBtnGO:SetActive(false)
  self._markGO = {}
  self._markAnimation = {}
  for i = 1, 4 do
    self._markGO[i] = self:GetGameObject("Mark" .. i)
    self._markAnimation[i] = self:GetUIComponent("Animation", "Mark" .. i)
    self._markAnimation[i]:Play("uieff_UILuckLandCardBag_click_out")
  end
  if self._showDeleteBtn and LuckLandInnerGameHelper.CheckWord(LuckLandWordType.LockDeleteCard) then
    self._deleteBtnGO:SetActive(false)
    self._costGO:SetActive(false)
  end
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandCardBag:SortBtn1OnClick(go)
  self._levelCardDatas:Sort(function(a, b)
    if a:Camp() ~= b:Camp() then
      return a:Camp() < b:Camp()
    else
      return a:UniqueID() > b:UniqueID()
    end
  end)
  self:_RefreshBtns(1)
end

function UILuckLandCardBag:SortBtn2OnClick(go)
  self._levelCardDatas:Sort(function(a, b)
    if a:Attribute() ~= b:Attribute() then
      return a:Attribute() < b:Attribute()
    else
      return a:UniqueID() > b:UniqueID()
    end
  end)
  self:_RefreshBtns(2)
end

function UILuckLandCardBag:SortBtn3OnClick(go)
  self._levelCardDatas:Sort(function(a, b)
    if a:Star() ~= b:Star() then
      return a:Star() > b:Star()
    else
      return a:UniqueID() > b:UniqueID()
    end
  end)
  self:_RefreshBtns(3)
end

function UILuckLandCardBag:SortBtn4OnClick(go)
  self._levelCardDatas:Sort(function(a, b)
    local a_id = 1
    local b_id = 1
    if a:FirstSkill() then
      a_id = a:FirstSkill()
    end
    if b:FirstSkill() then
      b_id = b:FirstSkill()
    end
    if a_id ~= b_id then
      return a_id < b_id
    else
      return a:UniqueID() > b:UniqueID()
    end
  end)
  self:_RefreshBtns(4)
end

function UILuckLandCardBag:_RefreshBtns(index)
  if self._curIndex == index then
    return
  end
  self._preIndex = self._curIndex
  self._curIndex = index
  self:Lock("UILuckLandCardBag")
  self._task1 = self:StartTask(function(TT)
    for i = 1, 4 do
      if i == self._curIndex then
        self._markAnimation[i]:Play("uieff_UILuckLandCardBag_click_in")
      end
      if i == self._preIndex then
        self._markAnimation[i]:Play("uieff_UILuckLandCardBag_click_out")
      end
    end
    self:_RefreshScrollView()
    self:_DynamicListPlayAnimation(TT)
    YIELD(TT, 667)
    self:UnLock("UILuckLandCardBag")
  end, self)
end

function UILuckLandCardBag:_DynamicListPlayAnimation(TT)
  local showTabIds = self._scrollView:GetVisibleItemIDsInScrollView()
  if not showTabIds then
    return
  end
  for index = 0, showTabIds.Count - 1 do
    local id = math.floor(showTabIds[index])
    local item = self._scrollView:GetShownItemByItemIndex(id)
    local view = item.gameObject:GetComponent(typeof(UIView))
    local animation = view:GetUIComponent("Animation", "Animation")
    local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", view:GetGameObject("Root"))
    if animation then
      view:GetGameObject("Root"):SetActive(false)
      YIELD(TT, index * 50)
      view:GetGameObject("Root"):SetActive(true)
      animation:Play("uieff_UILuckLandCardBagItem_in")
      local itemWidgets = itemPool:GetAllSpawnList()
      for i = 1, #itemWidgets do
        itemWidgets[i]:PlayAnimation()
      end
    end
  end
end

function UILuckLandCardBag:DeleteBtnOnClick(go)
  local isOnlyOne = LuckLandData:GetInstance():CurCardDatas():IsOnlyOne()
  if isOnlyOne then
    ToastManager.ShowToast(StringTable.Get("str_luckland_cardbag_delete_error1"))
    return
  end
  local curCost = LuckLandData:GetInstance():CurCardDatas():CurDeleteCost()
  local curMoney = LuckLandInnerGameHelper.GetCurMoney()
  if curCost > curMoney then
    ToastManager.ShowToast(StringTable.Get("str_luckland_cardbag_delete_error"))
    return
  end
  for _, cardWidget in pairs(self._cardWidgets) do
    cardWidget:ShowDeleteBtn(true)
  end
  self._deleteBtnGO:SetActive(false)
  self._cancleDeleteBtnGO:SetActive(true)
  self._isDelete = true
end

function UILuckLandCardBag:CancleDeleteBtnOnClick(go)
  for _, cardWidget in pairs(self._cardWidgets) do
    cardWidget:ShowDeleteBtn(false)
  end
  local isOnlyOne = self._levelCardDatas:IsOnlyOne()
  self._deleteBtnGO:SetActive(not isOnlyOne)
  self._costGO:SetActive(not isOnlyOne)
  self._cancleDeleteBtnGO:SetActive(false)
  self._isDelete = false
  if self._showDeleteBtn and LuckLandInnerGameHelper.CheckWord(LuckLandWordType.LockDeleteCard) then
    self._deleteBtnGO:SetActive(false)
    self._costGO:SetActive(false)
  end
  local cost = LuckLandData:GetInstance():CurCardDatas():CurDeleteCost()
  local total = LuckLandInnerGameHelper.GetCurMoney()
  if cost > total then
    self._deleteCost:SetText("<color=#f35349>" .. cost .. "</color>/" .. total)
  else
    self._deleteCost:SetText("<color=#d5c5ff>" .. cost .. "</color>/" .. total)
  end
end

function UILuckLandCardBag:_OnValue()
  self:_SetCommonTopButton()
  self:_InitDynamicScrollView()
  if self._showDeleteBtn then
    self._cardCount:SetText(StringTable.Get("str_luckland_cardbag_total", self._levelCardDatas:TotalCount()))
    local cost = LuckLandData:GetInstance():CurCardDatas():CurDeleteCost()
    local total = LuckLandInnerGameHelper.GetCurMoney()
    if cost > total then
      self._deleteCost:SetText("<color=#f35349>" .. cost .. "</color>/" .. total)
    else
      self._deleteCost:SetText("<color=#d5c5ff>" .. cost .. "</color>/" .. total)
    end
  end
  if self._fromInnerGame then
    self._cardCount:SetText(StringTable.Get("str_luckland_cardbag_total", self._levelCardDatas:TotalCount()))
  else
    self._cardCount:SetText(StringTable.Get("str_luckland_cardbag_total1"))
  end
end

function UILuckLandCardBag:_SetCommonTopButton()
  local function closeCallback()
    self:StartTask(function(TT)
      self:Lock("UILuckLandCardBag")
      
      self._animation:Play("uieff_UILuckLandCardBag_out")
      YIELD(TT, 333)
      self:UnLock("UILuckLandCardBag")
      self:CloseDialog()
    end, self)
  end
  
  local function helpCallBack()
    self:ShowDialog("UIIntroLoader", "UILuckLandCardBag")
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "BackBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, helpCallBack, nil, true)
end

function UILuckLandCardBag:_InitDynamicScrollView()
  self._scrollView:InitListView(math.ceil(self._levelCardDatas:TotalCount() / self._perRowCount), function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
  self:Lock("UILuckLandCardBag")
  self._task = self:StartTask(function(TT)
    self:_DynamicListPlayAnimation(TT)
    YIELD(TT, 667)
    self:UnLock("UILuckLandCardBag")
  end, self)
end

function UILuckLandCardBag:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("UILuckLandCardBagItem")
  local view = item.gameObject:GetComponent(typeof(UIView))
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", view:GetGameObject("Root"))
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UILuckLandSingleCard", self._perRowCount)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  for i = 1, self._perRowCount do
    local itemWidget = itemWidgets[i]
    if itemWidget then
      local widgetIndex = index * self._perRowCount + i
      local data = self._levelCardDatas:GetCardDataByIndex(widgetIndex)
      itemWidget:SetData(data, self._isDelete, self._fromInnerGame, true)
      if not self._cardWidgets[widgetIndex] then
        self._cardWidgets[widgetIndex] = itemWidget
      end
    end
  end
  return item
end

function UILuckLandCardBag:_RefreshScrollView()
  self._scrollView:SetListItemCount(math.ceil(self._levelCardDatas:TotalCount() / self._perRowCount))
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UILuckLandCardBag:_OnLuckLandDeleteCardSucc(uniqueID)
  self._cardCount:SetText(StringTable.Get("str_luckland_cardbag_total", self._levelCardDatas:TotalCount()))
  if self._showDeleteBtn then
    local cost = LuckLandData:GetInstance():CurCardDatas():CurDeleteCost()
    local total = LuckLandInnerGameHelper.GetCurMoney()
    if cost > total then
      self._deleteCost:SetText("<color=#f35349>" .. cost .. "</color>/" .. total)
    else
      self._deleteCost:SetText("<color=#d5c5ff>" .. cost .. "</color>/" .. total)
    end
  end
  self._scrollView:SetListItemCount(math.ceil(self._levelCardDatas:TotalCount() / self._perRowCount))
  self._scrollView:RefreshAllShownItem()
end
