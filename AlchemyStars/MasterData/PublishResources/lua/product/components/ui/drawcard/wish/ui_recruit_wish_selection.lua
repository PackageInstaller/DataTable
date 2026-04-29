_class("UIRecruitWishSelection", UIController)
UIRecruitWishSelection = UIRecruitWishSelection

function UIRecruitWishSelection:LoadDataOnEnter(TT, res, uiParams)
  local param = uiParams[1]
  self._cfgOptional = Cfg.cfg_optional_pool[param.idOptional]
  self._elementType = param.elementType
  self._selPetTid = param.selPetTid
  self._selectionCB = uiParams[2]
  if self._elementType == ElementType.ElementType_Blue then
    self._optionalList = self._cfgOptional.OptionalList_1
  elseif self._elementType == ElementType.ElementType_Red then
    self._optionalList = self._cfgOptional.OptionalList_2
  elseif self._elementType == ElementType.ElementType_Green then
    self._optionalList = self._cfgOptional.OptionalList_3
  elseif self._elementType == ElementType.ElementType_Yellow then
    self._optionalList = self._cfgOptional.OptionalList_4
  end
  if self._optionalList == nil then
    Log.fatal("[UIRecruitWishSelection] cfg_optional_pool.OptionalList is nil, id ->: ", param.idOptional, self._elementType)
    res:SetSucc(false)
    return
  end
end

function UIRecruitWishSelection:OnShow(uiParams)
  self:UIWidget()
  self:CreateDataPool()
  self:CreateUIWidget()
  self:WidgetLayout()
  self:FlushTitle()
  self:FlushDefaultSelection()
end

function UIRecruitWishSelection:OnUpdate(deltaTimeMS)
end

function UIRecruitWishSelection:OnHide()
end

function UIRecruitWishSelection:BtnCancelOnClick(go)
  self:CloseDialog()
end

function UIRecruitWishSelection:BtnOKOnClick(go)
  local data
  for k, v in pairs(self._dataPool) do
    if v.sel then
      data = v
      break
    end
  end
  if data == nil then
    ToastManager.ShowToast(StringTable.Get("str_draw_card_wishsel_seltips"))
  else
    if data.pet ~= self._selPetTid then
      self._selectionCB(data.pet)
    end
    self:CloseDialog()
  end
end

function UIRecruitWishSelection:WishOnClick(index)
  local data = self._dataPool[index]
  local sel = not data.sel
  for k, v in pairs(self._dataPool) do
    v.sel = false
  end
  data.sel = sel
  self._uiSel.gameObject:SetActive(sel)
  self._uiSel.position = data.uiWidget:GetGameObject().transform.position
end

function UIRecruitWishSelection:WishOnLongPress(index)
  local data = self._dataPool[index]
  self:ShowDialog("UIShopPetDetailController", data.pet)
end

function UIRecruitWishSelection:UIWidget()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._scrollView = self:GetUIComponent("ScrollRect", "scrollView")
  self._content = self:GetUIComponent("RectTransform", "content")
  self._uiNotObtained = self:GetUIComponent("UISelectObjectPath", "uiNotObtained")
  self._uiObtained = self:GetUIComponent("UISelectObjectPath", "uiObtained")
  self._uiSel = self:GetUIComponent("RectTransform", "uiSel")
  self._uiPetLayout = self:GetUIComponent("GridLayoutGroup", "uiNotObtained")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._uiSel.gameObject:SetActive(false)
end

function UIRecruitWishSelection:CreateDataPool()
  self._fixedStars = 6
  self._indexObtained = 0
  self._dataPool = {}
  local lstNotObtained = {}
  local lstObtained = {}
  local petModule = self:GetModule(PetModule)
  for k, v in pairs(self._optionalList) do
    local petData = petModule:GetPetByTemplateId(v)
    if petData == nil then
      table.insert(lstNotObtained, v)
    else
      table.insert(lstObtained, v)
    end
  end
  for k, v in ipairs(lstNotObtained) do
    local node = {
      pet = v,
      sel = false,
      uiWidget = nil
    }
    table.insert(self._dataPool, node)
  end
  for k, v in ipairs(lstObtained) do
    local node = {
      pet = v,
      sel = false,
      uiWidget = nil
    }
    table.insert(self._dataPool, node)
  end
  self._indexObtained = #lstNotObtained + 1
  local countAll = #self._dataPool
  self._countNotObtained = self._indexObtained - 1
  self._countObtained = countAll - self._countNotObtained
end

function UIRecruitWishSelection:CreateUIWidget()
  if self._countNotObtained > 0 then
    local uiList = self._uiNotObtained:SpawnObjects("UIDrawCardAwardPetItem", self._countNotObtained)
    for i = 1, self._countNotObtained do
      local uiWidget = uiList[i]
      local data = self._dataPool[i]
      data.uiWidget = uiWidget
      uiWidget:SetData(self._fixedStars, data.pet, nil)
      uiWidget:RootLocalScale(Vector3(0.83, 0.83, 0.83))
      uiWidget:AnimRootPosition(Vector2(0, -126))
    end
  end
  if 0 < self._countObtained then
    local uiList = self._uiObtained:SpawnObjects("UIDrawCardAwardPetItem", self._countObtained)
    for i = 1, self._countObtained do
      local uiWidget = uiList[i]
      local data = self._dataPool[self._countNotObtained + i]
      data.uiWidget = uiWidget
      uiWidget:SetData(self._fixedStars, data.pet, nil)
      uiWidget:RootLocalScale(Vector3(0.83, 0.83, 0.83))
      uiWidget:AnimRootPosition(Vector2(0, -126))
    end
  end
  for k, v in pairs(self._dataPool) do
    local index = k
    local uiWidget = v.uiWidget
    uiWidget:ShowPetAwakening(true)
    uiWidget:EventCallBack(function()
      return self._scrollView
    end, function(go)
      self:WishOnClick(index)
    end, function(go)
      self:WishOnLongPress(index)
    end)
  end
end

function UIRecruitWishSelection:WidgetLayout()
  local spacing = self._uiPetLayout.spacing
  local cellSize = self._uiPetLayout.cellSize
  local contentWidth = self._content.rect.width
  local padding = self._uiPetLayout.padding
  contentWidth = 1536
  self._cxCount = (contentWidth + spacing.x) / (cellSize.x + spacing.x)
  self._cxCount = math.floor(self._cxCount)
  self._paddingHeight = padding.top + padding.bottom
  self._rowsNotObtained = math.ceil(self._countNotObtained / self._cxCount)
  self._rowsObtained = math.ceil(self._countObtained / self._cxCount)
  self._uiNotObtained:Engine().gameObject:SetActive(self._countNotObtained > 0)
  self._uiObtained:Engine().gameObject:SetActive(self._countObtained > 0)
  local heightNotObtained = 0
  if self._countNotObtained > 0 then
    heightNotObtained = self._paddingHeight + self._rowsNotObtained * cellSize.y
    heightNotObtained = heightNotObtained + (self._rowsNotObtained - 1) * spacing.y
  end
  local heightObtained = 0
  if self._countObtained > 0 then
    heightObtained = self._paddingHeight + self._rowsObtained * cellSize.y
    heightObtained = heightObtained + (self._rowsObtained - 1) * spacing.y
  end
  local trObtained = self._uiObtained:Engine().transform
  trObtained.anchoredPosition = Vector2(0, -heightNotObtained)
  local sizeDelta = self._content.sizeDelta
  self._content.sizeDelta = Vector2(sizeDelta.x, heightNotObtained + heightObtained)
end

function UIRecruitWishSelection:FlushTitle()
  local elementTypeNames = {
    "str_pet_element_name_blue",
    "str_pet_element_name_red",
    "str_pet_element_name_green",
    "str_pet_element_name_yellow"
  }
  local elementName = StringTable.Get(elementTypeNames[self._elementType])
  self._title:SetText(StringTable.Get("str_draw_card_wishsel_title", elementName))
end

function UIRecruitWishSelection:FlushDefaultSelection()
  for k, v in pairs(self._dataPool) do
    if v.pet == self._selPetTid then
      local index = k
      self:StartSafeTask("UIRecruitWishSelection::FlushDefaultSelection", function(lockName, TT)
        self:Lock(lockName)
        YIELD(TT)
        self:WishOnClick(index)
        self:UnLock(lockName)
      end)
      break
    end
  end
end
