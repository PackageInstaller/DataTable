_class("UIAircraftCompound", UICustomWidget)
UIAircraftCompound = UIAircraftCompound

function UIAircraftCompound:OnShow(uiParams)
  self._maxLimit = 1
  self:InitWidget()
  self:InitMatrialWidgts()
  self._airModule = self:GetModule(AircraftModule)
  self._roleModule = self:GetModule(RoleModule)
  self._smeltRoom = self._airModule:GetSmeltRoom()
  self._atomDiscount = self._smeltRoom:AtomDiscount()
  self._compoundContext = UIAircraftCompoundContext:New()
  self.rootTargetCfg = {index = 1, targetNum = 0}
  self.dropdown.onValueChanged:AddListener(function(idx)
    self:OnDropDownChanged(idx)
  end)
  
  function self.dropdown.onShow()
    self:OnDropdownShow()
  end
  
  function self.dropdown.onHide()
    self:OnDropdownHide()
  end
  
  self._2edTabData = {}
  self.DropDownContent = {}
  self._totalItems = {}
  local items = Cfg.cfg_item_smelt({})
  self._lockInfo = {}
  for _, data in pairs(items) do
    local lock, param = self._airModule:GetSmeltLockInfo(data)
    if lock then
      self._lockInfo[data.ID] = {lock, param}
    end
  end
  local tab1s = Cfg.cfg_aircraft_smelt_tab1({})
  for i, cfg in ipairs(tab1s) do
    if cfg.UIType == SmeltRoomUIType.Compond then
      local id = cfg.ID
      local children = Cfg.cfg_aircraft_smelt_tab2({Tab1 = id})
      table.sort(children, function(a, b)
        return a.Index < b.Index
      end)
      self._2edTabData[id] = children
      local ss = {}
      ss[#ss + 1] = StringTable.Get("str_aircraft_player_info_all")
      for _, _2ed in ipairs(children) do
        ss[#ss + 1] = StringTable.Get(_2ed.Name)
      end
      self.DropDownContent[id] = ss
      local total = {}
      for _, value in pairs(items) do
        local contains = false
        for _, child in ipairs(children) do
          if value.Tab == child.ID then
            contains = true
            break
          end
        end
        if contains then
          total[#total + 1] = value
        end
      end
      
      function self._itemSortFunc(a, b)
        local locka = self._lockInfo[a.ID]
        local lockb = self._lockInfo[b.ID]
        if locka then
          locka = 2
        else
          locka = 1
        end
        if lockb then
          lockb = 2
        else
          lockb = 1
        end
        if locka == lockb then
          if a.Index == b.Index then
            return a.ID < b.ID
          end
          return a.Index < b.Index
        end
        return locka < lockb
      end
      
      table.sort(total, self._itemSortFunc)
      self._totalItems[id] = total
    end
  end
  local idMap = {}
  for k, items in pairs(self._totalItems) do
    for a, subItem in pairs(items) do
      if subItem.Output and #subItem.Output > 1 then
        idMap[subItem.Output[1]] = subItem.ID
      end
    end
  end
  self._compoundContext:InitIdMap(idMap)
  self._stringList = HelperProxy:GetInstance():NewStringList()
  self._tab2 = nil
  self._index = nil
  self._current = nil
  self._items = nil
  self._count = 1
end

function UIAircraftCompound:OnHide()
  self._addButton:Dispose()
  self._removeButton:Dispose()
  self.sldCount.onValueChanged:RemoveListener(self.sldValueChgListener)
end

function UIAircraftCompound:InitWidget()
  self._root = self:GetGameObject("UIAircraftCompound")
  self.scrollView = self:GetUIComponent("Image", "ScrollView")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.contentRectT = self:GetUIComponent("RectTransform", "Content")
  self.contentGridL = self:GetUIComponent("GridLayoutGroup", "Content")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.color = self:GetUIComponent("RawImageLoader", "color")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.dropdown = self:GetUIComponent("SmeltDropdown", "Dropdown")
  self._currencyPool = self:GetUIComponent("UISelectObjectPath", "Currency")
  self._currentRoot = self:GetGameObject("Currency")
  self._itemCountTex = self:GetUIComponent("UILocalizationText", "itemCountTex")
  self._baseMaterialPool = self:GetUIComponent("UISelectObjectPath", "baseMaterial")
  self._subMaterial1Pool = self:GetUIComponent("UISelectObjectPath", "subMaterial1")
  self._subMaterial2Pool = self:GetUIComponent("UISelectObjectPath", "subMaterial2")
  self.subMaterial1Go = self:GetGameObject("subMaterial1")
  self.subMaterial2Go = self:GetGameObject("subMaterial2")
  self.bg1 = self:GetGameObject("bg1")
  self.bg2 = self:GetGameObject("bg2")
  self.sldCount = self:GetUIComponent("Slider", "sldCount")
  self._materialBackBtnGo = self:GetGameObject("materialBackBtn")
  self._comTargeNumGo = self:GetGameObject("comTargeNum")
  self._comTargeNumGo:SetActive(false)
  self._comTargetNumTex = self:GetUIComponent("UILocalizationText", "comTargetNumTex")
  
  function self.sldValueChgListener(value)
    self:OnSldCountValueChange()
  end
  
  self.sldCount.onValueChanged:AddListener(self.sldValueChgListener)
  self._addButton = UITouchButton:New(self:GetUIComponent("UIEventTriggerListener", "AddButton"), function()
    self:AddButtonOnClick()
  end)
  self._removeButton = UITouchButton:New(self:GetUIComponent("UIEventTriggerListener", "RemoveButton"), function()
    self:RemoveButtonOnClick()
  end)
  local atlas = self:GetAsset("UIAircraftSmeltRoom.spriteatlas", LoadType.SpriteAtlas)
  self._itemSelectSprite = atlas:GetSprite("wind_ronglian_kuang12")
  self._itemUnSelectSprite = atlas:GetSprite("wind_ronglian_kuang1")
  self.dropTitleIcon = self:GetUIComponent("Image", "dropTitleIcon")
  self.dropTitleBtn = self:GetUIComponent("Image", "Dropdown")
  local dropTitleIconSelect = atlas:GetSprite("wind_ronglian_icon11")
  local dropTitleIconUnSelect = atlas:GetSprite("wind_ronglian_icon12")
  local dropTitleBtnSelect = atlas:GetSprite("wind_ronglian_btn2")
  local dropTitleBtnUnSelect = atlas:GetSprite("wind_ronglian_btn1")
  self.dropTitleIcons = {
    [1] = dropTitleIconSelect,
    [2] = dropTitleIconUnSelect
  }
  self.dropTitleBtns = {
    [1] = dropTitleBtnSelect,
    [2] = dropTitleBtnUnSelect
  }
  self._qualityColor = {
    [1] = "wind_ronglian_se1",
    [2] = "wind_ronglian_se2",
    [3] = "wind_ronglian_se3",
    [4] = "wind_ronglian_se4",
    [5] = "wind_ronglian_se5",
    [6] = "wind_ronglian_se6"
  }
  self._atomDes = self:GetUIComponent("UILocalizationText", "AtomDes")
  self._atomTip = self:GetUIComponent("Transform", "AtomTip")
  self._atomMask = self:GetGameObject("AtomTipMask")
  local atomIcon = self:GetUIComponent("Image", "AtomIcon")
  local atomCfg = Cfg.cfg_top_tips[RoleAssetID.RoleAssetAtom]
  atomIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(atomCfg.Icon)
  self._normalEfts = {
    [1] = self:GetGameObject("uieff_AircraftSmelt_Se1"),
    [2] = self:GetGameObject("uieff_AircraftSmelt_Se2"),
    [3] = self:GetGameObject("uieff_AircraftSmelt_Se3"),
    [4] = self:GetGameObject("uieff_AircraftSmelt_Se4"),
    [5] = self:GetGameObject("uieff_AircraftSmelt_Se5"),
    [6] = self:GetGameObject("uieff_AircraftSmelt_Se6")
  }
  self._anim = self:GetUIComponent("Animation", "Center")
end

function UIAircraftCompound:SetData(tab1)
  self._tab1 = tab1
  self._tab2 = 0
  self.targetItemList = {}
  self._materialBackBtnGo:SetActive(false)
  self._stringList:Clear()
  for _, s in ipairs(self.DropDownContent[self._tab1]) do
    self._stringList:Add(s)
  end
  self.dropdown:ClearOptions()
  self.dropdown:AddOptions(self._stringList)
  self.dropdown.value = self._tab2
  self:RefreshItems()
  self:OnItemSelected(1)
end

function UIAircraftCompound:SetShow(show)
  self._root:SetActive(show)
  if show then
    self:AttachEvent(GameEventType.ItemCountChanged, self.onItemCountChanged)
  else
    self:DetachEvent(GameEventType.ItemCountChanged, self.onItemCountChanged)
  end
end

function UIAircraftCompound:JumpTo(cfgID, targetNum, jumpFromSelf)
  if cfgID then
    for idx, value in ipairs(self._items) do
      if value.ID == cfgID then
        local len = #self.targetItemList
        if len == 0 then
          self.rootTargetCfg.index = self._index
        else
          self.targetItemList[len].index = self._index
        end
        local targetCfg = {index = idx, targetNum = 0}
        if not jumpFromSelf then
          self.rootTargetCfg.cfgID = cfgID
          self.rootTargetCfg.targetNum = targetNum
        else
          table.insert(self.targetItemList, targetCfg)
        end
        self:JumpToCfg(targetCfg)
        break
      end
    end
  end
end

function UIAircraftCompound:JumpToCfg(targetCfg)
  local index = targetCfg.index
  self:OnItemSelected(index, true)
  self:_ChangeScrollViewPos(index)
  self._materialBackBtnGo:SetActive(#self.targetItemList > 0)
end

function UIAircraftCompound:OnDropDownChanged(idx)
  if self._tab2 == idx then
    return
  end
  self.targetItemList = {}
  self._materialBackBtnGo:SetActive(false)
  self._tab2 = idx
  self:RefreshItems()
  self:OnItemSelected(1)
end

function UIAircraftCompound:RefreshItems()
  local items
  if self._tab2 <= 0 then
    items = self._totalItems[self._tab1]
  else
    if self._tab2ItemCache == nil then
      self._tab2ItemCache = {}
    end
    local tab2 = self._2edTabData[self._tab1][self._tab2].ID
    items = self._tab2ItemCache[tab2]
    if items == nil then
      items = Cfg.cfg_item_smelt({Tab = tab2})
      table.sort(items, self._itemSortFunc)
      self._tab2ItemCache[tab2] = items
    end
  end
  self._items = items
  if #self._items == 0 then
    Log.exception("严重错误，当前筛选条件下没有材料：", self._tab1, self._tab2)
  end
  self.content:SpawnObjects("UIAircraftSmeltItem", #self._items)
  self._itemWidgets = self.content:GetAllSpawnList()
  
  local function func(i)
    self:OnItemSelected(i)
  end
  
  for idx, data in ipairs(self._items) do
    local item = self._itemWidgets[idx]
    item:SetData(idx, data, func, self._lockInfo[data.ID], self._itemSelectSprite, self._itemUnSelectSprite)
    item:ShowColor()
  end
  self._index = nil
end

function UIAircraftCompound:_ChangeScrollViewPos(idx)
  local itemSizeY = self.contentGridL.cellSize.y
  local top = self.contentGridL.padding.top
  local spacingY = self.contentGridL.spacing.y
  local anchorPosY = (idx - 1) * (itemSizeY + spacingY) + top
  self.contentRectT.anchoredPosition = Vector2(0, anchorPosY)
end

function UIAircraftCompound:OnItemSelected(idx, force)
  if self._index == idx and not force then
    return
  end
  if self._index then
    self._itemWidgets[self._index]:Cancel()
  end
  local len = #self.targetItemList
  if 0 < len and idx ~= self.targetItemList[len].index then
    self.targetItemList = {}
    self._materialBackBtnGo:SetActive(false)
  end
  self._index = idx
  self._current = self._items[idx]
  self._itemWidgets[self._index]:Select()
  self._outputID = self._current.Output[1]
  local cfg = Cfg.cfg_item[self._outputID]
  local icon = cfg.Icon
  local color = cfg.Color
  self.icon:LoadImage(icon)
  self:CalcMaterial()
  self:FlushCurrentCount()
  self:SetSldCount(true)
  if self._eff then
    self._eff:SetActive(false)
  end
  self._eff = self._normalEfts[color]
  self._eff:SetActive(true)
  self._anim:Play("uieff_AircraftSmelt_SwitchItem")
end

function UIAircraftCompound:CalcMaterial()
  self._compoundContext:InitWithTargetItem(self._current, self._atomDiscount)
  self._maxLimit = math.max(1, self._compoundContext.maxComNum)
  self.sldCount.minValue = 1
  self.sldCount.maxValue = self._maxLimit
end

function UIAircraftCompound:FlushCurrentCount()
  local itemCount = self._roleModule:GetAssetCount(self._outputID)
  self._itemCountTex:SetText(StringTable.Get("str_item_owned") .. itemCount)
end

function UIAircraftCompound:OnSldCountValueChange()
  local count, a = math.modf(self.sldCount.value)
  self:RefreshMateialItem(count, false)
end

function UIAircraftCompound:RefreshMateialItem(count, checkCount)
  local code = 0
  if checkCount then
    code = self:CheckCount(self._current, count)
  end
  self._compoundContext:CalcWithTargetNum(count, true)
  if not self._compoundContext:IsMaterialEnough() then
    self._compoundContext:ReCalcOnlyUseBaseMaterial(count)
  end
  if 0 < code & ~AirItemErrorCode.FireflyOverflow then
    return false
  end
  self._count = count
  local strCount = self._count * self._current.Output[2]
  self.count:SetText(strCount)
  local curItemId = self._current.Output[1]
  local curItem = Cfg.cfg_item[curItemId]
  self.color:LoadImage(self._qualityColor[curItem.Color])
  self._comTargeNumGo:SetActive(false)
  if self.rootTargetCfg.cfgID == self._current.ID and self.rootTargetCfg.targetNum and 0 < self.rootTargetCfg.targetNum then
    self._comTargeNumGo:SetActive(true)
    self._comTargetNumTex:SetText(StringTable.Get("str_aircraft_targetNum", self.rootTargetCfg.targetNum))
  end
  local cost = self._compoundContext:GetCost()
  if 0 < cost then
    self._currentRoot:SetActive(true)
    local items = self._currencyPool:SpawnObjects("UIAircraftSmeltCurrency", 1)
    
    local function atomClick(pos)
      self._atomTip.position = pos + Vector3(-0.4, 0.04, 0)
      local dis = 1 - self._atomDiscount
      if dis < 1 then
        dis = string.format("%.2f", dis * 100)
      else
        dis = 100
      end
      self._atomDes:SetText(StringTable.Get("str_aircraft_atom_des", dis))
      self._atomMask:SetActive(true)
    end
    
    items[1]:SetData(RoleAssetID.RoleAssetAtom, cost, atomClick)
    if not self._compoundContext:IsCostEnough() then
      items[1]:SetCountStr("<color=#ff0000>" .. cost .. "</color>")
    end
  else
    self._currentRoot:SetActive(false)
  end
  self:RefreshMatrials()
  return true
end

function UIAircraftCompound:RefreshMatrials()
  self:RefreshMaterailByType(1)
  self:RefreshMaterailByType(2)
  self:RefreshMaterailByType(3)
end

function UIAircraftCompound:RefreshMaterailByType(index)
  local function onClick(id, go)
    self:ShowDialog("UIItemGetPathController", id)
  end
  
  local widgetCfg = self.materailWidgetCfg[index]
  local widget = widgetCfg.widget
  local go = widgetCfg.go
  local bgGo = widgetCfg.bgGo
  local materials = self._compoundContext.materialData[index]
  if go then
    go:SetActive(materials ~= nil)
  end
  if bgGo then
    bgGo:SetActive(materials == nil)
  end
  if materials then
    local index = 1
    for k, subMaterial in pairs(materials) do
      local item = widget[index]
      if item then
        local id = subMaterial.ID
        local needCount = subMaterial.SelectNum
        item:SetData(id, needCount, onClick, index)
      end
      index = index + 1
    end
  end
end

function UIAircraftCompound:InitMatrialWidgts()
  self._baseMatrialItems = self._baseMaterialPool:SpawnObjects("UIAircraftItemSmeltMatItem", 3)
  self._subMaterial1Items = self._subMaterial1Pool:SpawnObjects("UIAircraftItemSmeltMatItem", 3)
  self._subMaterial2Items = self._subMaterial2Pool:SpawnObjects("UIAircraftItemSmeltMatItem", 3)
  self.materailWidgetCfg = {
    [1] = {
      widget = self._baseMatrialItems,
      go = nil
    },
    [2] = {
      widget = self._subMaterial1Items,
      go = self.subMaterial1Go,
      bgGo = self.bg1
    },
    [3] = {
      widget = self._subMaterial2Items,
      go = self.subMaterial2Go,
      bgGo = self.bg2
    }
  }
end

function UIAircraftCompound:CheckCount(cfg, count)
  local result = AirItemErrorCode.None
  if count == 0 then
    result = result | AirItemErrorCode.Zero
  end
  return result
end

function UIAircraftCompound:AddButtonOnClick()
  if self._count >= self._maxLimit then
    if self._count == 1 then
      self:CheckMaterialAndCost()
    end
    return
  end
  self:SetSldCount(false, self._count + 1)
end

function UIAircraftCompound:CheckMaterialAndCost()
  if not self._compoundContext:IsCostEnough() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_compound_cost_not_enought"))
    return false
  end
  if not self._compoundContext:IsMaterialEnough() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_compound_material_not_enought"))
    return false
  end
  return true
end

function UIAircraftCompound:RemoveButtonOnClick()
  if self._count <= 1 then
    return
  end
  self:SetSldCount(false, self._count - 1)
end

function UIAircraftCompound:MaterialBackBtnOnClick()
  local len = #self.targetItemList
  if 1 < len then
    local cfg = self.targetItemList[len - 1]
    self.targetItemList[len] = nil
    self:JumpToCfg(cfg)
  elseif len == 1 then
    table.clear(self.targetItemList)
    local cfg = self.rootTargetCfg
    self:JumpToCfg(cfg)
  end
end

function UIAircraftCompound:OnDropdownShow()
  self.dropdown.interactable = false
  self.dropdown.captionText.color = Color(1, 1, 1)
  self.dropTitleBtn.sprite = self.dropTitleBtns[1]
  self.dropTitleIcon.sprite = self.dropTitleIcons[1]
end

function UIAircraftCompound:OnDropdownHide()
  self.dropdown.interactable = true
  self.dropdown.captionText.color = Color(0, 0, 0)
  self.dropTitleBtn.sprite = self.dropTitleBtns[2]
  self.dropTitleIcon.sprite = self.dropTitleIcons[2]
end

function UIAircraftCompound:SmeltButtonOnClick(go)
  if self:CheckMaterialAndCost() then
    GameGlobal.TaskManager():StartTask(self.Smelt, self, self._current.ID, self._count)
  end
end

function UIAircraftCompound:AtomTipMaskOnClick(go)
  self._atomMask:SetActive(false)
end

function UIAircraftCompound:Smelt(TT, id, count)
  self._isSmelting = true
  self:Lock(self:GetName())
  local itemList = self._compoundContext:GetComListData()
  local res, reply = self._airModule:HandleAIMultItemSmelt(TT, itemList)
  if res:GetSucc() then
    local assetList = reply.item_list
    local color = 1
    for k, v in pairs(assetList) do
      local item = Cfg.cfg_item[v.assetid]
      if item and color < item.Color then
        color = item.Color
      end
    end
    local time = 0
    if color < 5 then
      time = 1000
      self._anim:Play("uieff_AircraftSmelt_Smelt")
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAircraftSmeltNormalMat)
    else
      time = 2000
      self._anim:Play("uieff_AircraftSmelt_Smelt2")
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAircraftSmeltHighMat)
    end
    YIELD(TT, time)
    self._isSmelting = false
    self:onItemCountChanged()
    self:ShowDialog("UIGetItemController", assetList, function()
      self._anim:Play("uieff_AircraftSmelt_SmeltOver")
    end)
    self:FlushCurrentCount()
    if reply.id == RoleAssetID.RoleAssetFirefly then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
    end
  else
    self._isSmelting = false
    ToastManager.ShowToast(self._airModule:GetErrorMsg(res:GetResult()))
  end
  self:UnLock(self:GetName())
end

function UIAircraftCompound:onItemCountChanged()
  if self._isSmelting then
    return
  end
  self:CalcMaterial()
  local value = math.min(self._count, self._maxLimit)
  self:SetSldCount(true, value)
end

function UIAircraftCompound:GetDefaultSelectNum()
  if self.rootTargetCfg.cfgID == self._current.ID and self.rootTargetCfg.targetNum and self.rootTargetCfg.targetNum > 0 then
    return math.min(self.rootTargetCfg.targetNum, self._maxLimit)
  end
  return 1
end

function UIAircraftCompound:SetSldCount(forceChange, value)
  local v = value
  v = v or self:GetDefaultSelectNum()
  self.sldCount.value = v
  if forceChange then
    self:OnSldCountValueChange()
  end
end
