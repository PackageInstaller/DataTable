_class("UIBackPackUseBox", UIController)
UIBackPackUseBox = UIBackPackUseBox

function UIBackPackUseBox:Constructor()
  self._useCount = 1
  self._operateItemInfo = nil
  self._itemModule = GameGlobal.GetModule(ItemModule)
end

function UIBackPackUseBox:Dispose()
end

function UIBackPackUseBox:OnShow(uiParams)
  self:AttachEvent(GameEventType.SwitchUseBoxItem, self.SwtichUseBoxItem)
  self:InitWidget()
  self._item = uiParams[1]
  self._txtName:SetText(StringTable.Get(self._item:GetTemplate().Name))
  local lst = self:GetItemList(self._item:GetTemplateID())
  self._itemList = {}
  for i, item in ipairs(lst) do
    local tplId = item[1]
    local count = item[2]
    self._itemList[i] = BackPackBoxItem:New(tplId, count)
  end
  self._count = 0
  self._selectedId = nil
  if uiParams[2] then
    self._needItem = uiParams[2][1]
    self._needNum = uiParams[2][2]
    local count = self._itemModule:GetItemCount(self._item:GetTemplateID())
    self._useCount = math.min(count, self:CaculateNum(self._needItem, self._needNum))
    self._index, self._operateItemInfo = self:GetSelectedItemInfo(self._needItem)
  end
  local len = table.count(self._itemList)
  self._content:SpawnObjects("UIBackPackBoxUseItem", len)
  self:SetSelectItemId()
  self:ShowText()
  self:FlushItemsUI()
  self:_MoveToIndex()
end

function UIBackPackUseBox:InitWidget()
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemCount = self:GetUIComponent("InputField", "itemCount")
  self._toggleGroup = self:GetUIComponent("ToggleGroup", "Content")
  local path = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self._tips = path:SpawnObject("UISelectInfo")
  self._listRcet = self:GetUIComponent("RectTransform", "list")
  self._contentRcet = self:GetUIComponent("RectTransform", "Content")
  self._addBtn = self:GetGameObject("addBtn")
  self._subBtn = self:GetGameObject("subBtn")
  self._pressTime = Cfg.cfg_global.sale_and_use_press_long_deltaTime.IntValue
  self._updateTime = 0
  self._isAddMouseDown = false
  self._isSubMouseDown = false
  local etlAdd = UILongPressTriggerListener.Get(self._addBtn)
  
  function etlAdd.onLongPress(go)
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
    end
  end
  
  function etlAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
    end
  end
  
  function etlAdd.onClick(go)
    self:AddBtnOnClick()
  end
  
  local etlSub = UILongPressTriggerListener.Get(self._subBtn)
  
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

function UIBackPackUseBox:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseUIBackPackBox)
  self:DetachEvent(GameEventType.SwitchUseBoxItem, self.SwtichUseBoxItem)
end

function UIBackPackUseBox:BgOnClick()
  self:CloseDialog()
end

function UIBackPackUseBox:OnUpdate(deltaTimeMS)
  self._updateTime = self._updateTime + deltaTimeMS
  if self._updateTime > self._pressTime then
    self._updateTime = self._updateTime - self._pressTime
    if self._isAddMouseDown then
      self:AddBtnOnClick()
    end
    if self._isSubMouseDown then
      self:SubBtnOnClick()
    end
  end
end

function UIBackPackUseBox:SwtichUseBoxItem(isOn, index, item)
  if isOn then
    self._operateItemInfo = isOn and item or nil
    self._index = index
    self._selectedId = self._operateItemInfo:GetTplId()
  else
    self._selectedId = nil
    self._operateItemInfo = nil
    self._index = nil
  end
end

function UIBackPackUseBox:GetItemList(itemGiftID)
  local cfgItemGift = Cfg.cfg_item_gift[itemGiftID]
  if not cfgItemGift then
    return 0
  end
  local lst = cfgItemGift.ItemList
  return lst
end

function UIBackPackUseBox:AddBtnOnClick()
  local maxCount = self._itemModule:GetItemCount(self._item:GetTemplateID())
  maxCount = math.min(maxCount, 99)
  self._useCount = math.min(maxCount, self._useCount + 1)
  self:ShowText()
end

function UIBackPackUseBox:SubBtnOnClick()
  self._useCount = math.max(1, self._useCount - 1)
  self:ShowText()
end

function UIBackPackUseBox:BtnUseOnClick()
  if not self._operateItemInfo then
    ToastManager.ShowToast(StringTable.Get("str_common_needselect_one_tips"))
    return
  end
  self:StartTask(function(TT)
    local res, msg = self._itemModule:RequestChooseGift(TT, self._item:GetID(), self._index - 1, self._useCount)
    if res:GetSucc() then
      if self._operateItemInfo == nil then
        ToastManager.ShowToast(StringTable.Get("str_common_needselect_one_tips"))
        return
      end
      local ra = RoleAsset:New()
      ra.assetid = self._operateItemInfo:GetTplId()
      ra.count = self._operateItemInfo:GetCount() * self._useCount
      self:ShowDialog("UIGetItemController", {ra})
      self:CloseDialog()
    else
      Log.fatal("### fail")
    end
  end, self)
end

function UIBackPackUseBox:MaxOnClick()
  self:CaculateMax()
end

function UIBackPackUseBox:ShowText()
  self._itemCount.text = tostring(self._useCount)
end

function UIBackPackUseBox:CaculateMax()
  self._useCount = self._itemModule:GetItemCount(self._item:GetTemplateID())
  self._useCount = math.min(self._useCount, 99)
  self:ShowText()
end

function UIBackPackUseBox:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIBackPackUseBox:FlushItemsUI()
  self._count = self._useCount
  local len = table.count(self._itemList)
  self._uiItems = self._content:GetAllSpawnList()
  for i, uiItem in ipairs(self._uiItems) do
    if i <= len then
      uiItem:Flush(self._itemList[i], i, 1, self._toggleGroup, function(itemId, pos)
        self:ShowTips(itemId, pos)
      end, self._selectedId)
    else
      uiItem:FlushEmpty()
    end
  end
end

function UIBackPackUseBox:CaculateNum(itemId, num)
  local needCount = 0
  if not self._item then
    return needCount
  end
  for key, value in pairs(self._itemList) do
    if value:GetTplId() == itemId then
      needCount = math.max(1, math.ceil(num / value:GetCount()))
      return needCount
    end
  end
  return needCount
end

function UIBackPackUseBox:GetSelectedItemInfo(itemId)
  for key, value in pairs(self._itemList) do
    if value:GetTplId() == itemId then
      return key, value
    end
  end
  return
end

function UIBackPackUseBox:SetSelectItemId()
  if not self._needItem then
    return
  end
  self._selectedId = self._needItem
end

function UIBackPackUseBox:_MoveToIndex()
  if not self._operateItemInfo then
    return
  end
  local posx = 200 * self._index + 15 * (self._index - 1) - 100
  local endPointX = 0
  local len = self._listRcet.sizeDelta.x
  endPointX = Mathf.Min(0, len / 2 - posx)
  self._contentRcet.anchoredPosition = Vector2(endPointX, 0)
end
