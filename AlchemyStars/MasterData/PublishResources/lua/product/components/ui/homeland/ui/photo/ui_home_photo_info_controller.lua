_class("UIHomePhotoInfoController", UIController)
UIHomePhotoInfoController = UIHomePhotoInfoController

function UIHomePhotoInfoController:closeBtnOnClick(go)
  self:CloseDialog()
end

function UIHomePhotoInfoController:OnShow(uiParams)
  self._inited = false
  self._switchAnim = "UIHomePhotoInfoController_ui_switching"
  self._type = uiParams[1]
  self._closeCb = uiParams[2]
  self._itemModule = self:GetModule(ItemModule)
  self._itemCountPerRow = 4
  self._index = 0
  self._number2color = {
    [1] = Color(0.2, 0.2, 1),
    [2] = Color(0.3, 0.3, 1),
    [3] = Color(0.4, 0.4, 1),
    [4] = Color(0.5, 0.5, 1),
    [5] = Color(0.1, 0.1, 1),
    [6] = Color(0.6, 0.6, 1)
  }
  self:GetComponent()
  self:OnValue()
  self._inited = true
end

function UIHomePhotoInfoController:GetComponent()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "scrollView")
  self._countTex = self:GetUIComponent("UILocalizationText", "count")
  self._rateTex = self:GetUIComponent("UILocalizationText", "rateTex")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._value2 = self:GetGameObject("value2")
  self._value3 = self:GetGameObject("value3")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._color = self:GetUIComponent("Image", "color")
  self._size = self:GetUIComponent("UILocalizationText", "size")
  self._live = self:GetUIComponent("UILocalizationText", "live")
  self._time = self:GetUIComponent("UILocalizationText", "time")
  self._typeTex = self:GetUIComponent("UILocalizationText", "typeTex")
  self._lock = self:GetGameObject("lock")
  self._unlock = self:GetGameObject("unlock")
  self._selectInfo = self:GetGameObject("selectInfo")
  self._noSelectInfo = self:GetGameObject("noSelectInfo")
  self._btnPool = self:GetUIComponent("UISelectObjectPath", "btnPool")
  self._btnItem = self._btnPool:SpawnObject("UIHomeCommonCloseBtn")
  self._btnItem:SetData(function()
    self:closeBtnOnClick()
  end, nil, true)
  self._fullLineImgGo = self:GetGameObject("FullLineImg")
  self._singleLineImgGo = self:GetGameObject("SingleLineImg")
  self._singleLineImgGo:SetActive(true)
  self._fullLineImgGo:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "uiAnim")
  self.getPath = self:GetGameObject("getPath")
  self.lockTxt = self:GetUIComponent("RectTransform", "lockTxt")
  self.pathPool = self:GetUIComponent("UISelectObjectPath", "pathPool")
end

function UIHomePhotoInfoController:OnValue()
  self:_GetItems()
  self:_InitSrollView()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomePhotoItemClick, self._index)
  self:ShowInfo()
end

function UIHomePhotoInfoController:_GetItems()
  self._items = {}
  self._count = 0
  local cfgs = Cfg.cfg_item_photo({
    Group = self._type
  })
  if cfgs and next(cfgs) then
    for i = 1, #cfgs do
      local cfg = cfgs[i]
      local item = {}
      item.countID = cfg.ID
      item.showID = cfg.ItemID
      item.showValue = cfg.ShowValue
      item.Index = cfg.Index
      local itemCount = self._itemModule:GetItemCount(item.countID)
      item.count = itemCount
      if 0 < itemCount then
        self._count = self._count + 1
      end
      table.insert(self._items, item)
    end
  end
  self:SortList()
  self._max = #self._items
  if #self._items <= 0 then
    Log.error("###[UIHomePhotoInfoController] self._items is nil ! type --> ", self._type)
  end
  self._countTex:SetText(self._count .. "/" .. self._max)
  self._rate = self._count / self._max
  local tmpTex = math.floor(self._rate * 100 + 0.5) .. "%%"
  self._rateTex:SetText(StringTable.Get("str_homeland_photo_current_rate", tmpTex))
  local cfg = Cfg.cfg_home_photo_layout({
    Group = self._type
  })
  if cfg and next(cfg) then
    local title = cfg[1].Title
    self._typeTex:SetText(StringTable.Get(title))
  end
end

function UIHomePhotoInfoController:SortList()
  table.sort(self._items, function(a, b)
    return a.Index < b.Index
  end)
end

function UIHomePhotoInfoController:_InitSrollView()
  self._scrollView:InitListView(self:GetRowCount(), function(scrollView, index)
    return self:InitListInfo(scrollView, index)
  end)
end

function UIHomePhotoInfoController:GetRowCount()
  local row = math.ceil(self._max / self._itemCountPerRow)
  return row
end

function UIHomePhotoInfoController:InitListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHomePhotoInfoItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._max then
      item:GetGameObject():SetActive(false)
    else
      self:ShowItem(item, itemIndex)
    end
  end
  return item
end

function UIHomePhotoInfoController:ShowItem(item, index)
  local data = self._items[index]
  item:GetGameObject():SetActive(true)
  if data ~= nil then
    item:SetData(index, data, function(idx)
      self._index = idx
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomePhotoItemClick, self._index)
      self:ShowInfo()
    end, self._number2color, not self._inited)
  end
end

function UIHomePhotoInfoController:ShowInfo()
  self._selectInfo:SetActive(self._index ~= 0)
  self._noSelectInfo:SetActive(self._index == 0)
  self._anim:Play(self._switchAnim)
  if self._index == 0 then
    return
  end
  local item = self._items[self._index]
  local cfg = Cfg.cfg_item[item.showID]
  if not cfg then
    Log.error("###[UIHomePhotoInfoController] cfg_item is nil ! id --> ", item.id)
  end
  self._icon:LoadImage(cfg.Icon)
  self._singleLineImgGo:SetActive(true)
  self._fullLineImgGo:SetActive(false)
  if 0 < item.count then
    self._color.color = UIForgeData.qualityColors[cfg.Color]
    self._name:SetText(StringTable.Get(cfg.Name))
    local desc = cfg.RpIntro
    if item.showValue then
      local cfg_build = Cfg.cfg_item_architecture[item.showID]
      if not cfg_build then
        Log.error("###[UIHomePhotoInfoController] cfg_build is nil ! id --> ", item.showID)
        Log.exception("cfg_item_architecture为空，配置id=", item.showID)
        return
      end
      desc = cfg_build.Des
      local size = ""
      if cfg_build.Size then
        for i = 1, #cfg_build.Size do
          if i == 1 then
          else
            size = size .. "*"
          end
          size = size .. cfg_build.Size[i]
        end
      end
      self._size:SetText(size)
      self._live:SetText(cfg_build.LivableValue)
      local costTime = self:GetCostTime(cfg_build.CostTime)
      self._time:SetText(costTime)
    end
    self._desc:SetText(StringTable.Get(desc))
    self._value2:SetActive(item.showValue ~= nil)
    self._value3:SetActive(item.showValue ~= nil)
    if item.showValue ~= nil then
      self._singleLineImgGo:SetActive(false)
      self._fullLineImgGo:SetActive(true)
    end
  else
    self:ShowPath(cfg.Color)
  end
  self._lock:SetActive(not (0 < item.count))
  self._unlock:SetActive(0 < item.count)
end

function UIHomePhotoInfoController:ShowPath(color)
  local paths = self:GetPath()
  local count = #paths
  self.getPath:SetActive(0 < count)
  if 0 < count then
    self.lockTxt.anchoredPosition = Vector2(415, -26)
    self.pathPool:SpawnObjects("UIHomePhotoInfoGetPathItem", count)
    local pools = self.pathPool:GetAllSpawnList()
    for i = 1, count do
      local item = pools[i]
      local path = paths[i]
      local tocolor = UIForgeData.qualityColors[color]
      local desc = StringTable.Get(path.desc)
      item:SetData(desc, tocolor)
    end
  else
    self.lockTxt.anchoredPosition = Vector2(415, -185)
  end
end

function UIHomePhotoInfoController:GetPath()
  local ways = {}
  local item = self._items[self._index]
  local cfg = Cfg.cfg_item_getway[item.showID]
  local cfg_item = Cfg.cfg_item[item.showID]
  local color = cfg_item.color
  if cfg then
    local count = table.count(cfg)
    for i = 1, count - 1 do
      local id = cfg["Getway" .. tostring(i)]
      if id then
        local t = UIItemGetWayData:New()
        t:SetData(id)
        if t:CheckChapter() then
          table.insert(ways, t)
        end
      end
    end
  end
  return ways
end

function UIHomePhotoInfoController:GetCostTime(sec)
  if sec then
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    return timeStr
  else
    return ""
  end
end

function UIHomePhotoInfoController:OnHide()
  if self._closeCb then
    self._closeCb()
  end
end
