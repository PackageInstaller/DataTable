_class("UIAircraftCamp", UICustomWidget)
UIAircraftCamp = UIAircraftCamp

function UIAircraftCamp:OnShow(uiParams)
  self:InitWidget()
  self._airModule = self:GetModule(AircraftModule)
  self._roleModule = self:GetModule(RoleModule)
  self._smeltRoom = self._airModule:GetSmeltRoom()
  self._atomDiscount = self._smeltRoom:AtomDiscount()
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
    if cfg.UIType == SmeltRoomUIType.Camp then
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
  self._stringList = HelperProxy:GetInstance():NewStringList()
  self._tab2 = nil
  self._index = nil
  self._current = nil
  self._items = nil
  self._count = 1
  self._curCampIdx = nil
  self._active = true
end

function UIAircraftCamp:OnHide()
  self._addButton:Dispose()
  self._removeButton:Dispose()
  self._active = false
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
end

function UIAircraftCamp:InitWidget()
  self._root = self:GetGameObject("UIAircraftCamp")
  self.scrollView = self:GetUIComponent("Image", "ScrollView")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.contentRectT = self:GetUIComponent("RectTransform", "Content")
  self.contentGridL = self:GetUIComponent("GridLayoutGroup", "Content")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.dropdown = self:GetUIComponent("SmeltDropdown", "Dropdown")
  self._currencyPool = self:GetUIComponent("UISelectObjectPath", "Currency")
  self._currentRoot = self:GetGameObject("Currency")
  self._itemCountTex = self:GetUIComponent("UILocalizationText", "itemCountTex")
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
  self._atomDes = self:GetUIComponent("UILocalizationText", "AtomDes")
  self._atomTip = self:GetUIComponent("Transform", "AtomTip")
  self._atomMask = self:GetGameObject("AtomTipMask")
  local atomIcon = self:GetUIComponent("Image", "AtomIcon")
  local atomCfg = Cfg.cfg_top_tips[RoleAssetID.RoleAssetAtom]
  atomIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(atomCfg.Icon)
  self._center = self:GetUIComponent("RectTransform", "Center")
  self._needItemWidget = {}
  for i = 1, 7 do
    local mat = self:GetUIComponent("UISelectObjectPath", "mat0" .. i)
    self._needItemWidget[i] = mat:SpawnObject("UIAircraftCampMatItem")
  end
  for i = 1, #self._needItemWidget do
    self._needItemWidget[i]:Active(false)
  end
  self._campTip = self:GetUIComponent("RollingText", "CampTip")
end

function UIAircraftCamp:SetData(tab1)
  self._tab1 = tab1
  self._tab2 = 0
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

function UIAircraftCamp:SetShow(show)
  self._root:SetActive(show)
  if show then
    self:AttachEvent(GameEventType.ItemCountChanged, self.onItemCountChanged)
  else
    self:DetachEvent(GameEventType.ItemCountChanged, self.onItemCountChanged)
  end
end

function UIAircraftCamp:JumpTo(jumpID)
  local changeScrollViewIdx
  if jumpID then
    for idx, value in ipairs(self._items) do
      if value.ID == jumpID then
        self:OnItemSelected(idx)
        changeScrollViewIdx = idx
        break
      end
    end
  end
  if jumpID and changeScrollViewIdx then
    self:_ChangeScrollViewPos(changeScrollViewIdx)
  elseif jumpID and not changeScrollViewIdx then
    Log.exception("找不到跳转物品：", jumpID)
  end
end

function UIAircraftCamp:OnDropDownChanged(idx)
  if self._tab2 == idx then
    return
  end
  self._tab2 = idx
  self:RefreshItems()
  self:OnItemSelected(1)
end

function UIAircraftCamp:RefreshItems()
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
    self._itemWidgets[idx]:SetData(idx, data, func, self._lockInfo[data.ID], self._itemSelectSprite, self._itemUnSelectSprite)
  end
  self._index = nil
end

function UIAircraftCamp:_ChangeScrollViewPos(idx)
  local itemSizeY = self.contentGridL.cellSize.y
  local top = self.contentGridL.padding.top
  local spacingY = self.contentGridL.spacing.y
  local anchorPosY = (idx - 1) * (itemSizeY + spacingY) + top
  self.contentRectT.anchoredPosition = Vector2(0, anchorPosY)
end

function UIAircraftCamp:OnItemSelected(idx)
  if self._index == idx then
    return
  end
  if self._index then
    self._itemWidgets[self._index]:Cancel()
  end
  self._index = idx
  self._current = self._items[idx]
  self._itemWidgets[self._index]:Select()
  self._outputID = self._current.Output[1]
  local cfg = Cfg.cfg_item[self._outputID]
  local icon = cfg.Icon
  local color = cfg.Color
  self.icon:LoadImage(icon)
  self:FlushCurrentCount()
  self:RefreshItem(1, false)
  local target = 0
  for idx, input in ipairs(self._current.Input) do
    local id = input[1]
    local count = input[2]
    if count <= self._roleModule:GetAssetCount(id) then
      target = idx
      break
    end
  end
  if 0 < target then
    self:OnCampItemChanged(target, false, false)
  else
    self:ClearItem()
  end
end

function UIAircraftCamp:ClearItem()
  self._campTip:RefreshText(StringTable.Get("str_aircraft_smelt_camp_tip", self._current.Input[1][2], self._current.Output[2]))
  self._curCampIdx = nil
  for i = 1, #self._needItemWidget do
    self._needItemWidget[i]:Select(false)
  end
  self._count = 0
  self:RefreshItem(self._count, false)
end

function UIAircraftCamp:FlushCurrentCount()
  local itemCount = self._roleModule:GetAssetCount(self._outputID)
  self._itemCountTex:SetText(StringTable.Get("str_item_owned") .. itemCount)
end

function UIAircraftCamp:RefreshItem(count, checkCount)
  local code = 0
  if checkCount then
    code = self:CheckCount(self._current, count)
  end
  if 0 < code & ~AirItemErrorCode.FireflyOverflow then
    return false
  end
  self._count = count
  self.count:SetText(self._count * self._current.Output[2])
  if self._current.SInput then
    self._currentRoot:SetActive(true)
    self._currencyPool:SpawnObjects("UIAircraftSmeltCurrency", #self._current.SInput)
    self._currencyWidgets = self._currencyPool:GetAllSpawnList()
    for i, value in ipairs(self._current.SInput) do
      local id = value[1]
      local _count = value[2]
      local atomClick
      if id == RoleAssetID.RoleAssetAtom then
        _count = math.ceil(_count * self._count * self._atomDiscount)
        
        function atomClick(pos)
          local dis = 1 - self._atomDiscount
          if dis < 1 then
            dis = string.format("%.2f", dis * 100)
          else
            dis = 100
          end
          self._atomDes:SetText(StringTable.Get("str_aircraft_atom_des", dis))
          self._atomMask:SetActive(true)
        end
      else
        _count = _count * self._count
      end
      self._currencyWidgets[i]:SetData(id, _count, atomClick)
    end
  else
    self._currentRoot:SetActive(false)
  end
  
  local function onClick(id, go, idx)
    local item = self._current.Input[idx]
    local id = item[1]
    local count = self._roleModule:GetAssetCount(id)
    if count <= 0 then
      ToastManager.ShowToast(StringTable.Get("str_aircraft_smelt_camp_notenough"))
      return
    end
    self:OnCampItemChanged(idx, true, true)
  end
  
  for i = 1, #self._needItemWidget do
    if i <= table.count(self._current.Input) then
      self._needItemWidget[i]:Active(true)
      local input = self._current.Input[i]
      local id = input[1]
      local _count = input[2]
      if i == self._curCampIdx then
        self._needItemWidget[i]:SetData(id, _count * self._count, onClick, i)
      else
        self._needItemWidget[i]:SetData(id, 0, onClick, i)
      end
      self._needItemWidget[i]:TryStopShake()
    else
      self._needItemWidget[i]:Active(false)
    end
    self._needItemWidget[i]:SetCamp()
  end
  return true
end

function UIAircraftCamp:OnCampItemChanged(idx, checkCount, clampCount)
  if self._curCampIdx == idx then
    return
  end
  if self._curCampIdx then
    self._needItemWidget[self._curCampIdx]:ResetCount(0)
    self._needItemWidget[self._curCampIdx]:Select(false)
    self._needItemWidget[self._curCampIdx]:TryStopShake()
  end
  self._curCampIdx = idx
  local input = self._current.Input[idx]
  local _count = input[2]
  self._needItemWidget[self._curCampIdx]:ResetCount(_count * self._count)
  self._needItemWidget[self._curCampIdx]:Select(true)
  local result = 0
  if checkCount then
    result = self:CheckCount(self._current, self._count)
  end
  if clampCount and 0 < result & AirItemErrorCode.NotEnough then
    local item = self._current.Input[self._curCampIdx]
    local id = item[1]
    local need = item[2]
    local count = self._roleModule:GetAssetCount(id)
    self._count = math.floor(count / need)
    self:RefreshItem(self._count, false)
  end
  if 0 < result & AirItemErrorCode.NotEnough then
    self._needItemWidget[self._curCampIdx]:ShakeAndHighlight()
  end
  self._campTip:RefreshText(StringTable.Get("str_aircraft_smelt_camp_tip", _count, self._current.Output[2]))
end

function UIAircraftCamp:CheckCount(cfg, count)
  local result = AirItemErrorCode.None
  if count <= 0 then
    result = result | AirItemErrorCode.Zero
  end
  if cfg.SInput then
    for idx, value in ipairs(cfg.SInput) do
      local id = value[1]
      local need = value[2]
      local have = self._roleModule:GetAssetCount(id)
      if id == RoleAssetID.RoleAssetAtom then
        need = math.ceil(need * count * self._atomDiscount)
      end
      if have < need then
        result = result | AirItemErrorCode.SNotEnough
        self._currencyWidgets[idx]:Shake()
      else
        self._currencyWidgets[idx]:Reset()
      end
    end
  end
  local item = cfg.Input[self._curCampIdx]
  local id = item[1]
  local need = item[2]
  if self._roleModule:GetAssetCount(id) < need * count then
    result = result | AirItemErrorCode.NotEnough
    self._needItemWidget[self._curCampIdx]:ShakeAndHighlight()
  end
  if cfg.Output[1] == RoleAssetID.RoleAssetFirefly then
    local _count = cfg.Output[2]
    if self._airModule:GetFirefly() + _count * count > self._airModule:GetMaxFirefly() then
      result = result | AirItemErrorCode.FireflyOverflow
    end
  end
  return result
end

function UIAircraftCamp:AddButtonOnClick()
  if self._curCampIdx == nil or self._curCampIdx == 0 then
    return
  end
  local result = self:RefreshItem(self._count + 1, true)
  if not result then
    self._addButton:Cancel()
  end
end

function UIAircraftCamp:RemoveButtonOnClick()
  if self._curCampIdx == nil or self._curCampIdx == 0 then
    return
  end
  local result = self:RefreshItem(self._count - 1, true)
  if not result then
    self._addButton:Cancel()
  end
end

function UIAircraftCamp:OnDropdownShow()
  self.dropdown.interactable = false
  self.dropdown.captionText.color = Color(1, 1, 1)
  self.dropTitleBtn.sprite = self.dropTitleBtns[1]
  self.dropTitleIcon.sprite = self.dropTitleIcons[1]
end

function UIAircraftCamp:OnDropdownHide()
  self.dropdown.interactable = true
  self.dropdown.captionText.color = Color(0, 0, 0)
  self.dropTitleBtn.sprite = self.dropTitleBtns[2]
  self.dropTitleIcon.sprite = self.dropTitleIcons[2]
end

function UIAircraftCamp:SmeltButtonOnClick(go)
  if self._curCampIdx == nil or self._curCampIdx == 0 then
    return
  end
  local code = self:CheckCount(self._current, self._count)
  if 0 < code then
    if 0 < code & AirItemErrorCode.FireflyOverflow then
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_aircraft_firefly_overflow"), function(param)
        AirLog("分解材料超过萤盏上限：", self._current.ID, "数量：", self._count, "当前萤盏：", self._airModule:GetFirefly(), "/", self._airModule:GetMaxFirefly())
        GameGlobal.TaskManager():StartTask(self.Smelt, self, self._current.ID, self._count)
      end, nil, function(param)
        AirLog("取消分解材料")
      end, nil)
    elseif 0 < code & ~AirItemErrorCode.FireflyOverflow then
      AirLog("不能熔炼，错误码：", code)
    end
  else
    GameGlobal.TaskManager():StartTask(self.Smelt, self, self._current.ID, self._count)
  end
end

function UIAircraftCamp:AtomTipMaskOnClick(go)
  self._atomMask:SetActive(false)
end

function UIAircraftCamp:Smelt(TT, id, count)
  self:Lock(self:GetName())
  local item = self._current.Input[self._curCampIdx]
  local inputid = item[1]
  local inputNeed = item[2]
  local res, reply = self._airModule:HandleItemSmelt(TT, id, count, {inputid})
  if not self._active then
    self:UnLock(self:GetName())
    return
  end
  if res:GetSucc() then
    local asset = ItemAsset:New()
    asset.assetid = reply.id
    asset.count = reply.num
    local eft1 = self:getEft("uieff_UIAircraftCamp_trail"):GetComponent(typeof(UnityEngine.RectTransform))
    local eft2 = self:getEft("uieff_UIAircraftCamp_glow"):GetComponent(typeof(UnityEngine.RectTransform))
    local from = self:GetUIComponent("RectTransform", "mat0" .. self._curCampIdx).anchoredPosition:Clone()
    local to = self:GetUIComponent("RectTransform", "icon").anchoredPosition:Clone()
    local time1 = 200
    local time2 = 800
    local time3 = 1000
    eft1.anchoredPosition = from
    eft1.localScale = Vector3.one
    eft1.localRotation = Quaternion.identity
    eft1.gameObject:SetActive(true)
    YIELD(TT, time1)
    if not self._active then
      self:UnLock(self:GetName())
      return
    end
    self._tweener = eft1:DOAnchorPos(to, time2 / 1000)
    YIELD(TT, time2)
    YIELD(TT)
    eft1.gameObject:SetActive(false)
    self._tweener = nil
    if not self._active then
      self:UnLock(self:GetName())
      return
    end
    eft2.gameObject:SetActive(false)
    eft2.anchoredPosition = to
    eft2.localScale = Vector3.one
    eft2.localRotation = Quaternion.identity
    eft2.gameObject:SetActive(true)
    YIELD(TT, time3)
    if not self._active then
      self:UnLock(self:GetName())
      return
    end
    eft2.gameObject:SetActive(false)
    local curCount = self._roleModule:GetAssetCount(inputid)
    local ceiling = math.floor(curCount / inputNeed)
    local newCount = Mathf.Clamp(self._count, 0, ceiling)
    if newCount == 0 then
      local target = 0
      for idx, input in ipairs(self._current.Input) do
        local id = input[1]
        local count = input[2]
        if count <= self._roleModule:GetAssetCount(id) then
          target = idx
          break
        end
      end
      if 0 < target then
        self:OnCampItemChanged(target, false, false)
        item = self._current.Input[self._curCampIdx]
        inputid = item[1]
        inputNeed = item[2]
        curCount = self._roleModule:GetAssetCount(inputid)
        ceiling = math.floor(curCount / inputNeed)
        newCount = Mathf.Clamp(self._count, 0, ceiling)
      else
        self:ClearItem()
        newCount = 0
      end
    end
    self:RefreshItem(newCount, false)
    self:ShowDialog("UIGetItemController", {asset}, function()
    end)
    self:FlushCurrentCount()
    if reply.id == RoleAssetID.RoleAssetFirefly then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
    end
  else
    ToastManager.ShowToast(self._airModule:GetErrorMsg(res:GetResult()))
  end
  self:UnLock(self:GetName())
end

function UIAircraftCamp:onItemCountChanged()
  self:RefreshItem(self._count, false)
end

function UIAircraftCamp:getEft(name)
  if self._efts == nil then
    self._efts = {}
  end
  if not self._efts[name] then
    local eft = self:GetAsset(name .. ".prefab", LoadType.GameObject)
    eft.transform:SetParent(self._center)
    self._efts[name] = eft
  end
  return self._efts[name]
end
