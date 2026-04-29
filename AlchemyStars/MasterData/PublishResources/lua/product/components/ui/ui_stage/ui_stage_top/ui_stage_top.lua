_class("UIStageTop", UICustomWidget)
UIStageTop = UIStageTop

function UIStageTop:OnShow()
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self.roleModule = GameGlobal.GetModule(RoleModule)
  self:_AttachEvents()
end

function UIStageTop:OnHide()
  self:_DetachEvents()
end

function UIStageTop:GetComponents()
  self.pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._power = self:GetUIComponent("Transform", "power")
  self._powerPool = self:GetUIComponent("UISelectObjectPath", "powerpool")
end

function UIStageTop:SetData(idList, iconClick, isBetween)
  self:GetComponents()
  self.idList = idList
  self.iconClick = iconClick
  self.isBetween = isBetween
  self:_RefreshUI()
end

function UIStageTop:_RefreshUI()
  if self.iconClick == nil or self.isBetween == nil or self.idList == nil then
    return
  end
  self.pool:SpawnObjects("UIStageTopItem", #self.idList)
  local cfg = Cfg.cfg_top_tips({})
  local pools = self.pool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local id = self.idList[i]
    local cfg_item = cfg[id]
    local icon = cfg_item.Icon
    local sprite = self.atlas:GetSprite(icon)
    local callback, countStr
    if id == RoleAssetID.RoleAssetPhyPoint then
      function callback(id, go)
        self:ItemClick(id, go)
      end
      
      local currentStr, upperStr
      local currentPhysicalPower = self.roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
      local upperPhysicalPower = self.roleModule:GetHpLevelMax()
      if 9999 < currentPhysicalPower then
        currentStr = "9999+"
      else
        currentStr = currentPhysicalPower .. ""
      end
      if 9999 < upperPhysicalPower then
        upperStr = "9999+"
      else
        upperStr = upperPhysicalPower .. ""
      end
      upperStr = "<color=#aeaeae>" .. upperStr .. "</color>"
      if currentPhysicalPower > upperPhysicalPower then
        currentStr = "<color=#00ffea>" .. currentStr .. "</color>"
      else
        currentStr = "<color=#ffffff>" .. currentStr .. "</color>"
      end
      countStr = currentStr .. "<color=#ffffff>/</color>" .. upperStr
    elseif id == RoleAssetID.RoleAssetDoubleRes then
      local resModule = self:GetModule(ResDungeonModule)
      local count = resModule:GetDoubleResNum()
      local aircraftModule = self:GetModule(AircraftModule)
      local room = aircraftModule:GetResRoom()
      local maxCount = room and math.floor(room:GetResCardLimit()) or -1
      if count >= maxCount then
        countStr = "<color=#ffffff>" .. HelperProxy:GetInstance():Format999(count) .. "/" .. maxCount .. "</color>"
      else
        countStr = "<color=#ffffff>" .. count .. "/" .. maxCount .. "</color>"
      end
      callback = nil
    else
      callback = nil
    end
    item:SetData(id, sprite, countStr, function(id, go)
      self.iconClick(id, go)
    end, callback, self.isBetween)
  end
  local idx = 1
  for i = 1, #self.idList do
    if self.idList[i] == RoleAssetID.RoleAssetPhyPoint then
      idx = i
      break
    end
  end
  local menuItem = pools[idx]
  self.powerPool = self._powerPool:SpawnObject("UIPowerInfo")
  self.powerPool:SetData(self._power, menuItem)
end

function UIStageTop:ItemClick(id, go)
  self:ShowDialog("UIGetPhyPointController")
end

function UIStageTop:_AttachEvents()
  self:AttachEvent(GameEventType.RolePropertyChanged, self._RefreshUI)
  self:AttachEvent(GameEventType.ItemCountChanged, self._RefreshUI)
end

function UIStageTop:_DetachEvents()
  self:DetachEvent(GameEventType.RolePropertyChanged, self._RefreshUI)
  self:DetachEvent(GameEventType.ItemCountChanged, self._RefreshUI)
end
