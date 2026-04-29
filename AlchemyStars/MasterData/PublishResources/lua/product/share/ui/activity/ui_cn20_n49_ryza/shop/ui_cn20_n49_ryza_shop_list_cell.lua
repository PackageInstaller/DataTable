_class("UICN20N49Ryza_ShopListCell", UICustomWidget)
UICN20N49Ryza_ShopListCell = UICN20N49Ryza_ShopListCell

function UICN20N49Ryza_ShopListCell:OnShow()
  self._pressTime = Cfg.cfg_global.sale_and_use_press_long_deltaTime.IntValue
  self._updateTime = 0
  self._isAddMouseDown = false
  self._isSubMouseDown = false
  self:InitWidgets()
end

function UICN20N49Ryza_ShopListCell:OnUpdate(deltaTimeMS)
  if self._isAddMouseDown then
    self._updateTime = self._updateTime + deltaTimeMS
    if self._updateTime > self._pressTime then
      self._updateTime = self._updateTime - self._pressTime
      local succ = self:AddBtnOnClick()
      if not succ then
        self._isAddMouseDow = false
        self._updateTime = 0
      end
    end
  end
  if self._isSubMouseDown then
    self._updateTime = self._updateTime + deltaTimeMS
    if self._updateTime > self._pressTime then
      self._updateTime = self._updateTime - self._pressTime
      local succ = self:SubBtnOnClick()
      if not succ then
        self._isSubMouseDown = false
        self._updateTime = 0
      end
    end
  end
end

function UICN20N49Ryza_ShopListCell:InitWidgets()
  self._countTex = self:GetUIComponent("UILocalizationText", "countTex")
  self._inventoryTex = self:GetUIComponent("UILocalizationText", "inventoryTex")
  self._SubBtn = self:GetGameObject("SubBtn")
  self._AddBtn = self:GetGameObject("AddBtn")
  self._item = self:GetUIComponent("UISelectObjectPath", "item")
  local etlAdd = UILongPressTriggerListener.Get(self._AddBtn)
  
  function etlAdd.onLongPress(go)
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
      self._updateTime = 0
    end
  end
  
  function etlAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
      self._updateTime = 0
    end
  end
  
  function etlAdd.onClick(go)
    self:AddBtnOnClick()
  end
  
  local etlSub = UILongPressTriggerListener.Get(self._SubBtn)
  
  function etlSub.onLongPress(go)
    if self._isSubMouseDown == false then
      self._isSubMouseDown = true
    end
  end
  
  function etlSub.onLongPressEnd(go)
    if self._isSubMouseDown == true then
      self._isSubMouseDown = false
    end
  end
  
  function etlSub.onClick(go)
    self:SubBtnOnClick()
  end
end

function UICN20N49Ryza_ShopListCell:MaxBtnOnClick(go)
  if self._count == self._inventory then
    return
  end
  local maxCount = self._maxCb(self._itemid, self._count)
  local count = math.min(maxCount, self._inventory)
  if self._callback then
    if count == 0 then
      Log.debug("all max , count==0")
      return
    end
    local succ = self._callback(self._itemid, count)
    if succ then
      self._count = count
      self:RefreshUI()
    else
      Log.debug("all max , fail")
    end
  end
end

function UICN20N49Ryza_ShopListCell:AddBtnOnClick()
  if self._count == self._inventory then
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_shop_list_add_inv_max"))
    return false
  end
  local count = self._count + 1
  if self._callback then
    local succ = self._callback(self._itemid, count)
    if succ then
      self._count = count
      self:RefreshUI()
    else
      ToastManager.ShowToast(StringTable.Get("str_cn20_n49_shop_list_add_count_max"))
      return false
    end
  end
  return true
end

function UICN20N49Ryza_ShopListCell:SubBtnOnClick()
  if self._count == 0 then
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_shop_list_sub_0"))
    return false
  end
  local count = self._count - 1
  if self._callback then
    local succ = self._callback(self._itemid, count)
    if succ then
      self._count = count
      self:RefreshUI()
    else
      ToastManager.ShowToast("sub fail")
      return false
    end
  end
  return true
end

function UICN20N49Ryza_ShopListCell:SetData(idx, itemid, price, color, inventory, count, callback, maxCb)
  self._idx = idx
  self._itemid = itemid
  self._price = price
  self._color = color
  self._inventory = inventory
  self._count = count
  self._callback = callback
  self._maxCb = maxCb
  self:RefreshItem()
  self:RefreshUI()
end

function UICN20N49Ryza_ShopListCell:RefreshItem()
  local data = UICN20N49RyzaItemData:New()
  data.id = self._itemid
  local price, color = UICN20N49Ryza_Shop.GetItemPriceColor(self._itemid)
  data.color = color
  data.price = self._price
  data.count = nil
  local item = self._item:SpawnObject("UICN20N49Ryza_ShopCell")
  item:SetData(1, data)
end

function UICN20N49Ryza_ShopListCell:RefreshUI()
  self._countTex:SetText(self._count)
  self._inventoryTex:SetText(StringTable.Get("str_cn20_n49_shop_list_inv_tex", self._inventory))
end
