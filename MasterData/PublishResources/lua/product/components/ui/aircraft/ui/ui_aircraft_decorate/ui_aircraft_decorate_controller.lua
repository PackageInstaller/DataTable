_class("UIAircraftDecorateController", UIController)
UIAircraftDecorateController = UIAircraftDecorateController

function UIAircraftDecorateController:OnShow(uiParams)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIAircraftDecorate)
  self._uiDepth = self:GetDepth()
  GameGlobal.UIStateManager():SetDepthRaycast(self._uiDepth, false)
  self._decorateMng = uiParams[1]
  self._aircraftModule = GameGlobal.GameLogic():GetModule(AircraftModule)
  self._itemModule = GameGlobal.GameLogic():GetModule(ItemModule)
  self._airMain = self._aircraftModule:GetClientMain()
  self._showDescItemID = nil
  self._tweenTime = 0.2
  self._tabItemRectTransform = {}
  self._tabOpenState = {}
  self._tablChild = 0
  self._openTabChild = 201
  self._isFirstDetail = true
  self._isDetaiOpen = false
  self._colorBlue = Color(0, 0.8627450980392157, 1, 1)
  self._colorGreen = Color(0.615686274509804, 0.9333333333333333, 0.10980392156862745, 1)
  self._colorRed = Color(0.9333333333333333, 0.20392156862745098, 0.10980392156862745, 1)
  local commonTopRoot = self:GetUIComponent("UISelectObjectPath", "TopButton")
  local backBtns = commonTopRoot:SpawnObject("UICommonTopButton")
  backBtns:SetData(function()
    self._decorateMng:Back()
  end, nil, nil, true)
  self._tabContent = self:GetUIComponent("UISelectObjectPath", "TabContent")
  self._rootLeft = self:GetGameObject("Left")
  self._rootTop = self:GetGameObject("Top")
  self._textRoomTitle = self:GetUIComponent("UILocalizationText", "TextRoomTitle")
  self._rootBottom = self:GetGameObject("Bottom")
  self._detailScrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollViewDynamic")
  self._rootRight = self:GetGameObject("Right")
  self._textAtmosphere = self:GetUIComponent("UILocalizationText", "TextAtmosphere")
  self._rotateMask = self:GetGameObject("RotateMask")
  self._rotater = self:GetUIComponent("UIRotater", "Rotater")
  self._rotater.onAngleChanged:AddListener(function(angle)
    self._decorateMng:OnRotate(angle)
  end)
  self._rotaterRect = self:GetUIComponent("RectTransform", "Rotater")
  self:AttachEvent(GameEventType.UIAircraftShowRotater, self._OnShowRotater)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnUIDepthChanged)
  self._descWindow = self:GetGameObject("DescWindow")
  self._descWindowAnim = self:GetUIComponent("Animation", "DescWindow")
  self._descCanvasGroup = self:GetUIComponent("CanvasGroup", "DescWindow")
  self._btnDescFind = self:GetGameObject("BtnFind")
  self._btnDescPut = self:GetGameObject("BtnPut")
  self._textDescName = self:GetUIComponent("UILocalizationText", "TextDescName")
  self._textDescCount = self:GetUIComponent("UILocalizationText", "TextDescCount")
  self._textDescAtmosphere = self:GetUIComponent("UILocalizationText", "TextDescAtmosphere")
  self._textDesc = self:GetUIComponent("UILocalizationText", "TextDesc")
  self._textDescRoot = self:GetUIComponent("RectTransform", "TextDescRoot")
  self._rawImageDesc = self:GetUIComponent("RawImageLoader", "RawImageDesc")
  self:AttachEvent(GameEventType.UIAircraftDecorateSwitchModel, self._OnSwitchDecorateModel)
  self:AttachEvent(GameEventType.UIAircraftDecorateRefreshAtmosphere, self._OnRefreshAtmosphere)
  self:AttachEvent(GameEventType.UIAircraftDecorateRefreshRoomTitle, self._OnRefreshRoomTitle)
  self._searchResult = FurnitureSearchResult:New()
  self._furnitureDic = {}
  self:_OnValue()
  self._decorateMng:OnDecorateUIShow(self:GetGameObject("furnitureBtns"))
end

function UIAircraftDecorateController:OnUIDepthChanged()
  local depth = self:GetDepth()
  if self._uiDepth ~= depth then
    AirLog("装修UI深度变化：", depth)
    GameGlobal.UIStateManager():SetDepthRaycast(self._uiDepth, true)
    self._uiDepth = depth
    GameGlobal.UIStateManager():SetDepthRaycast(self._uiDepth, false)
  end
end

function UIAircraftDecorateController:OnHide()
  self._decorateMng:OnDecorateUIClose()
  self._furnitureDic = nil
  GameGlobal.UIStateManager():SetDepthRaycast(self._uiDepth, true)
end

function UIAircraftDecorateController:_OnValue()
  self:_InitFurnitureTabs()
  for i = self._tabCount, 1, -1 do
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tabs[i]:ItemMoveRectTransform())
    local height = self._tabs[i]:OnGetMaskSizeDeltaHeight()
    self:_OnChangeLayout(i, height)
  end
  local atmosphereNum = self._aircraftModule:CalFurnitureAmbient(true)
  self:_OnRefreshAtmosphere(atmosphereNum)
  self:_OnSwitchDecorateModel(true, self._openTabChild)
  self:_OnRefreshRoomTitle()
  self:_BeginDecorateClearAllPet()
end

function UIAircraftDecorateController:_InitFurnitureTabs()
  local tempTab = {}
  local cfg_aircraft_furniture_tab = Cfg.cfg_aircraft_furniture_tab1({})
  for i = 1, #cfg_aircraft_furniture_tab do
    table.insert(tempTab, cfg_aircraft_furniture_tab[i])
  end
  self._tabCount = table.count(tempTab)
  self._tabContent:SpawnObjects("UIAircraftDecorateTabItem", self._tabCount)
  self._tabs = self._tabContent:GetAllSpawnList()
  for i = 1, self._tabCount do
    local itemData = tempTab[i]
    self._tabs[i]:SetData(i, itemData, function(enum)
      self:_OnSelectTabChild(enum)
    end, function(idx, height, doTween)
      self:_OnChangeLayout(idx, height, doTween)
    end)
  end
  for i = 1, self._tabCount do
    local itemRT = self._tabs[i]:ItemRectTransform()
    table.insert(self._tabItemRectTransform, itemRT)
    table.insert(self._tabOpenState, false)
  end
  self._tabRectTransform = self:GetUIComponent("RectTransform", "TabContent")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tabRectTransform)
  local leftGrid = self:GetUIComponent("GridLayoutGroup", "TabContent")
  self._tabRectTransform.sizeDelta = Vector2(leftGrid.cellSize.x, leftGrid.cellSize.y * self._tabCount + leftGrid.spacing.y * (self._tabCount - 1))
  self._tabRectTransform.anchoredPosition = Vector2(0, 0)
  leftGrid.enabled = false
end

function UIAircraftDecorateController:_OnSelectTabChild(tabChild, force)
  if self._tablChild == tabChild and not force then
    return
  end
  self._tablChild = tabChild
  if self._isFirstDetail == true then
    self._isFirstDetail = false
    self:_InitDetailScrollView()
  else
    self:_RefrenshDetailScrollView()
  end
  self:BtnCloseDescOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSmallTabClick, self._tablChild)
end

function UIAircraftDecorateController:_RefrenshDetailScrollView()
  self._furnitureDataList = self:_GetFurnitureList()
  local furnitureDataListCount = table.count(self._furnitureDataList)
  self._detailScrollView:SetListItemCount(furnitureDataListCount)
  self._detailScrollView:MovePanelToItemIndex(0, 0)
end

function UIAircraftDecorateController:_GetFurnitureList()
  local tempList = {}
  local furnitureListAll = self._aircraftModule:GetFurnitureList()
  for k, value in pairs(furnitureListAll) do
    local cfg_item_furniture = Cfg.cfg_item_furniture[value:GetTemplateID()]
    if not cfg_item_furniture then
      Log.exception("玩家已有道具：", value.ID, "，在家居道具表cfg_item_furniture.xlsx里没找到")
      return
    end
    if cfg_item_furniture.Tab == self._tablChild then
      table.insert(tempList, value)
    end
  end
  if table.count(tempList) > 0 then
    table.sort(tempList, function(a, b)
      if a:IsNewFurniture() == b:IsNewFurniture() then
        local remainsNumA = self._aircraftModule:GetRemainsFurnitureItemNumByItemID(a:GetTemplateID())
        local remainsNumB = self._aircraftModule:GetRemainsFurnitureItemNumByItemID(b:GetTemplateID())
        if 0 < remainsNumA and 0 < remainsNumB or remainsNumA == 0 and remainsNumB == 0 then
          return a:GetTemplate().BagSortIndex < b:GetTemplate().BagSortIndex
        end
        return remainsNumB == 0
      end
      return a:IsNewFurniture()
    end)
  end
  return tempList
end

function UIAircraftDecorateController:_BeginDecorateClearAllPet()
end

function UIAircraftDecorateController:_EndDecorateShowAllPet()
end

function UIAircraftDecorateController:_InitDetailScrollView()
  self._furnitureDataList = self:_GetFurnitureList()
  local furnitureDataListCount = table.count(self._furnitureDataList)
  self._detailScrollView:InitListView(furnitureDataListCount, function(scrollView, index)
    return self:_OnInitDetailScrollView(scrollView, index)
  end)
end

function UIAircraftDecorateController:_OnInitDetailScrollView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIAircraftDecorateItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local decorateItem = rowList[1]
  local itemIndex = index + 1
  self:_ShowDecorateItem(decorateItem, itemIndex)
  return item
end

function UIAircraftDecorateController:_ShowDecorateItem(decorateItem, itemIndex)
  local data = self._furnitureDataList[itemIndex]
  self._furnitureDic[data:GetTemplateID()] = decorateItem
  decorateItem:GetGameObject():SetActive(true)
  if data ~= nil then
    decorateItem:SetData(itemIndex, data, function(item)
      self:_OnSelectItem(item)
    end)
  end
end

function UIAircraftDecorateController:_OnSelectItem(item)
  self:_OnRefreshDescWindow(item)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSelectItem, item)
  self:StartTask(self._OnReadFurniture, self, item)
end

function UIAircraftDecorateController:_OnReadFurniture(TT, item)
  if not item:IsNewFurniture() then
    return
  end
  self._aircraftModule:PushViewNewFurniture(item:GetTemplateID())
  item:SetOldFurniture()
end

function UIAircraftDecorateController:_OnRefreshDescWindow(item)
  local itemID = item:GetTemplateID()
  if self._showDescItemID == itemID then
    return
  end
  self._showDescItemID = itemID
  self._descWindowAnim:Play("uieff_AircraftDecorate_DescWindow")
  self._descCanvasGroup.blocksRaycasts = true
  local cfg_item_furniture = Cfg.cfg_item_furniture[itemID]
  local cfg_item = Cfg.cfg_item[itemID]
  local itemCount = self._itemModule:GetItemCount(itemID)
  local useCount = self._aircraftModule:GetFurnitureItemNumInBagByItemID(itemID)
  local remainsNum = self._aircraftModule:GetRemainsFurnitureItemNumByItemID(itemID)
  self._textDescName:SetText(StringTable.Get(cfg_item.Name))
  self._textDesc:SetText(StringTable.Get(cfg_item.RpIntro))
  self._textDescRoot.anchoredPosition = Vector2(0, 0)
  self._rawImageDesc:LoadImage(cfg_item.Icon)
  local atmosphere = cfg_item_furniture.Atmosphere
  local lfAv, lfMv = self._aircraftModule:CalCentralPetWorkSkill()
  local newAtmosphere = atmosphere + math.floor(atmosphere * lfMv) + math.floor(lfAv)
  self._textDescAtmosphere:SetText(newAtmosphere)
  local remainsNumStr = "<color=#ffd800>" .. remainsNum .. "</color>"
  local itemCountStr = "<color=#a0a0a0>" .. itemCount .. "</color>"
  self._textDescCount.text = remainsNumStr .. "/" .. itemCountStr
  self._btnDescFind:SetActive(0 < useCount)
  self._btnDescPut:SetActive(0 < remainsNum)
end

function UIAircraftDecorateController:_OnChangeLayout(tabIndex, height, doTween)
  if doTween and self._isDetaiOpen then
    return
  end
  local isOpenTab = self._tabOpenState[tabIndex] == false
  self._tabOpenState[tabIndex] = isOpenTab
  self._isDetaiOpen = true
  local changeSizeDelta = Vector2(0, 0)
  if isOpenTab then
    changeSizeDelta = Vector2(0, height)
    self._tabs[tabIndex]:OpenMovePos(doTween)
  else
    changeSizeDelta = Vector2(0, -height)
    self._tabs[tabIndex]:CloseMovePos(doTween)
  end
  for i = 1, self._tabCount do
    local changePosition = Vector2(0, 0)
    if isOpenTab then
      if tabIndex <= i then
        changePosition = Vector2(0, 0)
      else
        changePosition = Vector2(0, -height)
      end
    elseif tabIndex <= i then
      changePosition = Vector2(0, 0)
    else
      changePosition = Vector2(0, height)
    end
    local targetPos = self._tabItemRectTransform[i].anchoredPosition + changePosition
    if not doTween then
      self._tabItemRectTransform[i].anchoredPosition = targetPos
      self._isDetaiOpen = false
    else
      local tweener = self._tabItemRectTransform[i]:DOAnchorPos(targetPos, self._tweenTime)
    end
  end
  local tabRootTargetPos = Vector2(0, 0)
  if not doTween then
    self._tabRectTransform.sizeDelta = self._tabRectTransform.sizeDelta + changeSizeDelta
    tabRootTargetPos = Vector2(0, 0)
    self._tabRectTransform.anchoredPosition = tabRootTargetPos
  else
    tabRootTargetPos = self._tabRectTransform.anchoredPosition + changeSizeDelta
    self._isDetaiOpen = false
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateBigTabClick, tabIndex, isOpenTab)
end

function UIAircraftDecorateController:BtnCloseDescOnClick()
  if self._descCanvasGroup.alpha == 1 then
    self._descWindowAnim:Play("uieff_AircraftDecorate_DescWindow_Fade")
  end
  self._descCanvasGroup.blocksRaycasts = false
  self._showDescItemID = nil
end

function UIAircraftDecorateController:BtnFindOnClick()
  local findItemID = self._showDescItemID
  self._decorateMng:TryPopTip(function()
    self:_searchFur(findItemID)
    self:BtnCloseDescOnClick()
  end)
end

function UIAircraftDecorateController:_searchFur(id)
  local target = self._searchResult:Search(id)
  self._decorateMng:FocusFurniture(target)
end

function UIAircraftDecorateController:BtnPutOnClick()
  if self._decorateMng:TryAddFurniture(self._showDescItemID) then
    self:BtnCloseDescOnClick()
  else
    ToastManager.ShowToast(StringTable.Get("str_aircraft_no_space"))
  end
end

function UIAircraftDecorateController:_OnSwitchDecorateModel(show, openTabChild)
  self._rootTop:SetActive(show)
  self._rootBottom:SetActive(show)
  self._rootLeft:SetActive(show)
  self._rootRight:SetActive(show)
  if show then
    local tabChild = openTabChild
    tabChild = tabChild or self._tablChild
    self:_OnSelectTabChild(tabChild, true)
  end
end

function UIAircraftDecorateController:_OnRefreshAtmosphere(atmosphereNum)
  local realAmbient = self._aircraftModule:CalFurnitureAmbient(true)
  if atmosphereNum < realAmbient then
    self._textAtmosphere.color = self._colorRed
  elseif atmosphereNum > realAmbient then
    self._textAtmosphere.color = self._colorGreen
  else
    self._textAtmosphere.color = self._colorBlue
  end
  local CurCentralAmbientLimit = self._aircraftModule:GetCurCentralAmbientLimit()
  if atmosphereNum > CurCentralAmbientLimit then
    atmosphereNum = CurCentralAmbientLimit
  end
  self._textAtmosphere:SetText(atmosphereNum)
end

function UIAircraftDecorateController:_OnShowRotater(show, angle, offset)
  if show then
    self._rotater:SetAngle(angle)
    self._rotaterRect.anchoredPosition = offset
  end
  self._rotateMask:SetActive(show)
end

function UIAircraftDecorateController:BtnAtmosphereOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIAmbientPanel")
end

function UIAircraftDecorateController:BtnRepealOnClick()
  self._decorateMng:Revert()
end

function UIAircraftDecorateController:BtnClearOnClick()
  self._decorateMng:RemoveAll()
end

function UIAircraftDecorateController:BtnSaveOnClick()
  self._decorateMng:Save()
end

function UIAircraftDecorateController:BtnSwitchRoomLeftOnClick()
  self._decorateMng:SwitchArea(-1)
end

function UIAircraftDecorateController:BtnSwitchRoomRightOnClick()
  self._decorateMng:SwitchArea(1)
end

function UIAircraftDecorateController:_OnRefreshRoomTitle()
  local curArea = self._decorateMng:CurrentArea()
  local cfg_aircraft_area = Cfg.cfg_aircraft_area[curArea]
  self._textRoomTitle:SetText(StringTable.Get(cfg_aircraft_area.Name))
end

function UIAircraftDecorateController:RotateMaskOnClick()
  self:_OnShowRotater(false)
  self._decorateMng:ShowFurTip()
end

function UIAircraftDecorateController:GetTabItem(itemIndex)
  local tabTwo = itemIndex % 100
  local tabOne = itemIndex - tabTwo
  if tabOne == 0 or tabTwo == 0 then
    return nil
  end
  local tabOneItem = self._tabs[tabOne]
  if not tabOneItem then
    return nil
  end
  local tabTwoItem = tabOneItem:GetChildItem(tabTwo)
  if tabTwoItem then
    return tabTwoItem.gameobject
  end
  return nil
end

function UIAircraftDecorateController:GetFurnitureItemByID(tplID)
  local index = -1
  for i = 1, #self._furnitureDataList do
    if self._furnitureDataList[i]:GetTemplateID() == tplID then
      index = i
      break
    end
  end
  self._detailScrollView:MovePanelToItemIndex(index - 1, 0)
  if self._furnitureDic[tplID] == nil then
    Log.exception("找不到引导需要的家具，请注册新账号:", tplID)
  end
  return self._furnitureDic[tplID]:GetBG()
end

function UIAircraftDecorateController:GetScrollRect()
  return self:GetUIComponent("ScrollRect", "ScrollViewDynamic")
end
