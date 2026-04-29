_class("UISeasonMazeActiveItem", UICustomWidget)
UISeasonMazeActiveItem = UISeasonMazeActiveItem

function UISeasonMazeActiveItem:InitWidget()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._poolGo = self:GetGameObject("pool")
  self._ItemInfoGo = self:GetGameObject("ItemInfo")
  self._useBtnGo = self:GetGameObject("UseBtn")
  self._ItemInfoGo:SetActive(false)
  self._itemInfoPos = self:GetUIComponent("Transform", "ItemInfo")
  self._itemNameTex = self:GetUIComponent("UILocalizationText", "itemNameTex")
  self._itemDescTex = self:GetUIComponent("UILocalizationText", "itemDescTex")
  self._itemCountTex = self:GetUIComponent("UILocalizationText", "itemCount")
end

function UISeasonMazeActiveItem:OnShow()
  self._module = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._module:CurSeasonObj()
  self._com = self._seasonMazeObj:GetMazeComponent()
  self._comInfo = self._com:GetComponentInfo()
  self._comCfgID = self._com:GetComponentCfgId()
  self:InitWidget()
  self:AttachEvent(GameEventType.OnSeasonMazeItemUseEnd, self.OnItemUseEnd)
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.OnUISeasonMazeAttChanged)
  self:AttachEvent(GameEventType.OnUISeasonMazeSelectBombTarget, self.OnSelectBombTarget)
end

function UISeasonMazeActiveItem:OnUISeasonMazeAttChanged(attType)
  if attType then
    self:SetData()
  end
end

function UISeasonMazeActiveItem:GetItemInfo()
  local bagInfo = self._comInfo.m_bag_info
  local itemMap = bagInfo.once_item_list
  self._itemList = {}
  if itemMap and table.count(itemMap) > 0 then
    for key, value in pairs(itemMap) do
      if 0 < value then
        local item = {}
        item.id = key
        item.count = value
        table.insert(self._itemList, item)
      end
    end
    table.sort(self._itemList, function(a, b)
      return a.id < b.id
    end)
  end
end

function UISeasonMazeActiveItem:SetShowUiCb(showUiCb)
  self._showUiCb = showUiCb
end

function UISeasonMazeActiveItem:SetData()
  self:GetItemInfo()
  self._poolGo:SetActive(table.count(self._itemList) > 0)
  if table.count(self._itemList) > 0 then
    self._pool:SpawnObjects("UISeasonMazeActiveItemUnit", #self._itemList)
    local pools = self._pool:GetAllSpawnList()
    for i = 1, #self._itemList do
      local widget = pools[i]
      local item = self._itemList[i]
      local id = item.id
      local count = item.count
      local cfg = self:GetItemCfg(id)
      local icon = cfg.Icon
      widget:SetData(i, id, count, icon, function(id, count, pos)
        self:OnItemClick(id, count, pos)
      end)
    end
  end
end

function UISeasonMazeActiveItem:OnItemClick(id, count, pos)
  if self._currentSelectID == id then
    return
  end
  if self._usingBomb then
    self._usingBomb = nil
    self._bombTarget = nil
    if self._showUiCb then
      self._showUiCb(true)
    end
  end
  self:OpenItemInfo(id, count, pos)
end

function UISeasonMazeActiveItem:OnHide()
end

function UISeasonMazeActiveItem:Select(id)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._itemList do
    local widget = pools[i]
    widget:Select(id)
  end
end

function UISeasonMazeActiveItem:OpenItemInfo(id, count, w_pos)
  self._ItemInfoGo:SetActive(true)
  self:Select(id)
  self._currentSelectID = id
  self._cfg = self:GetItemCfg(id)
  local name = self._cfg.Name
  local desc = self._cfg.Desc
  self._itemNameTex:SetText(StringTable.Get(name))
  self._itemDescTex:SetText(StringTable.Get(desc))
  self._itemCountTex:SetText(StringTable.Get("str_common_backpack_own_count") .. count)
  self._useBtnGo:SetActive(SMazeAdaptor.CanUseActiveProp())
end

function UISeasonMazeActiveItem:GetItemCfg(id)
  local cfgs = Cfg.cfg_component_season_maze_once({
    ComponentID = self._comCfgID,
    OnceID = id
  })
  if cfgs and next(cfgs) then
    return cfgs[1]
  end
end

function UISeasonMazeActiveItem:UseBtnOnClick(go)
  if self._usingBomb then
    if self._bombTarget then
      SMazeAdaptor.OnUseBombConfirm()
      self._usingBomb = nil
    else
      ToastManager.ShowToast(StringTable.Get("str_season_maze_once_no_select"))
    end
    return
  end
  SMazeAdaptor.UseActiveProp(self._currentSelectID)
  if self:GetItemCfg(self._currentSelectID).Type == SeasonMazeEffectType.SMET_Once_Bomb then
    self._usingBomb = true
    self._bombTarget = nil
    if self._showUiCb then
      self._showUiCb(false)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSMazeActiveItem, self._cfg.Type)
end

function UISeasonMazeActiveItem:CloseItemInfoOnClick(go)
  self._ItemInfoGo:SetActive(false)
  self:Select()
  self._currentSelectID = nil
  if self._usingBomb then
    SMazeAdaptor.OnUseBombCancel()
    self._usingBomb = nil
  end
  self._bombTarget = nil
  if self._showUiCb then
    self._showUiCb(true)
  end
end

function UISeasonMazeActiveItem:OnItemUseEnd()
  self:CloseItemInfoOnClick()
  if self:GetItemCfg(self._currentSelectID).Type == SeasonMazeEffectType.SMET_Once_Bomb and self._showUiCb then
    self._showUiCb(true)
  end
  self._currentSelectID = nil
  self:SetData()
end

function UISeasonMazeActiveItem:OnSelectBombTarget(target)
  if self:GetItemCfg(self._currentSelectID).Type == SeasonMazeEffectType.SMET_Once_Bomb then
    if target and target:GetState() == SMazeNodeState.UnReachable then
      return
    end
    self._bombTarget = target
  else
    Log.error("当前使用的不是炸弹 怎么会收到炸弹消息", target)
  end
end
