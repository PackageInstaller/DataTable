_class("HomelandFishingManager", Object)
HomelandFishingManager = HomelandFishingManager

function HomelandFishingManager:Init(homelandClient)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  local cfgs = Cfg.cfg_item_tool_upgrade({ToolType = 2})
  self._fishRodCfgs = {}
  self._needRefreshfishrod = true
  self._haveFishRod = false
  for _, v in pairs(cfgs) do
    self._fishRodCfgs[#self._fishRodCfgs + 1] = v
  end
  table.sort(self._fishRodCfgs, function(a, b)
    return a.Level > b.Level
  end)
  self._homelandClient = homelandClient
  self._buildManager = self._homelandClient:BuildManager()
  local area = self._buildManager:GetHomeArea():GetArea()
  local points = {}
  for i = 1, area.FishingPoints.Count do
    local p = area.FishingPoints[i - 1]
    points[i] = Vector2(p.x, p.z)
  end
  points[#points + 1] = points[1]
  self._buildPoly = BuildPoly:New(points)
  local wishBuilding
  local buildings = self._buildManager:GetBuildings()
  for k, v in pairs(buildings) do
    if v:GetBuildType() == ArchitectureSubType.Wishing_Pool then
      wishBuilding = v
      break
    end
  end
  if wishBuilding then
    local triggerRoot = wishBuilding._transform:Find("TriggerFishingArea")
    if triggerRoot then
      local points = {}
      for i = 0, triggerRoot.childCount - 1 do
        local p = triggerRoot:GetChild(i).position
        points[i + 1] = Vector2(p.x, p.z)
      end
      points[#points + 1] = points[1]
      self._wishBuildingPoly = BuildPoly:New(points)
    end
  end
  if self._fishMatchStartCallback == nil then
    self._fishMatchStartCallback = GameHelper:GetInstance():CreateCallback(self.StartFishMatch, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchStart, self._fishMatchStartCallback)
  end
  if self._characterStartMoveCallback == nil then
    self._characterStartMoveCallback = GameHelper:GetInstance():CreateCallback(self.CharacterStartMove, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnMainCharacterStartMove, self._characterStartMoveCallback)
  end
  if self._exitHomelandCallback == nil then
    self._exitHomelandCallback = GameHelper:GetInstance():CreateCallback(self.ExitHomeland, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ExitHomeland, self._exitHomelandCallback)
  end
  self._homelandFishing = HomelandFishing:New()
  self._homelandFishing:Init()
  if self._itemCountChangedCallBack == nil then
    self._itemCountChangedCallBack = GameHelper:GetInstance():CreateCallback(self._OnItemCountChanged, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._itemCountChangedCallBack)
  end
end

function HomelandFishingManager:_OnItemCountChanged()
  self._needRefreshfishrod = true
end

function HomelandFishingManager:Update(deltaTimeMS)
  if not self._homelandFishing or not self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FISHING_UI) then
    return
  end
  local characterManager = self._homelandClient:CharacterManager()
  if not characterManager then
    return
  end
  local transform = characterManager:GetCharacterTransform()
  if not transform then
    return
  end
  local findTreasureManager = self._homelandClient:FindTreasureManager()
  if findTreasureManager and findTreasureManager:IsFindingTreasure() then
    return
  end
  if self:HasFishRod() then
    local pos = Vector2(transform.position.x, transform.position.z)
    if self._buildPoly:Contains(pos) then
      self:EnterFishing(true)
    elseif self._wishBuildingPoly and self._wishBuildingPoly:Contains(pos) then
      local wishBuilding
      local buildings = self._buildManager:GetBuildings()
      for k, v in pairs(buildings) do
        if v:GetBuildType() == ArchitectureSubType.Wishing_Pool then
          wishBuilding = v
          break
        end
      end
      if wishBuilding then
        if not wishBuilding:IsShabby() then
          self:EnterFishing(false)
        else
          self._homelandFishing:ExistFishing()
        end
      else
        self._homelandFishing:ExistFishing()
      end
    else
      self._homelandFishing:ExistFishing()
    end
  else
    self._homelandFishing:ExistFishing()
  end
end

function HomelandFishingManager:Dispose()
  if self._homelandFishing then
    self._homelandFishing:Destroy()
  end
  self._homelandFishing = nil
  if self._characterStartMoveCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnMainCharacterStartMove, self._characterStartMoveCallback)
    self._characterStartMoveCallback = nil
  end
  self._fishRodCfgs = nil
  if self._itemCountChangedCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._itemCountChangedCallBack)
    self._itemCountChangedCallBack = nil
  end
  if self._exitHomelandCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ExitHomeland, self._exitHomelandCallback)
    self._exitHomelandCallback = nil
  end
  if self._fishMatchStartCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchStart, self._fishMatchStartCallback)
    self._fishMatchStartCallback = nil
  end
end

function HomelandFishingManager:CharacterStartMove()
  if self._homelandFishing then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingCancelFish, true)
    self._homelandFishing:ExistFishing()
  end
end

function HomelandFishingManager:ExitHomeland()
  if self._homelandFishing then
    self._homelandFishing:ExitHomeland()
  end
end

function HomelandFishingManager:StartFishMatch()
  self:EnterFishing(true)
end

function HomelandFishingManager:HasFishRod()
  if self._needRefreshfishrod == true then
    self._needRefreshfishrod = false
    self._haveFishRod = false
    for i = 1, #self._fishRodCfgs do
      local count = self._itemModule:GetItemCount(self._fishRodCfgs[i].ID)
      if 0 < count then
        self._haveFishRod = true
        break
      end
    end
  end
  return self._haveFishRod
end

function HomelandFishingManager:ExistFishing()
  if self._homelandFishing then
    self._homelandFishing:ExistFishing()
  end
end

function HomelandFishingManager:EnterFishing(isRiverFishing)
  self._isRiverFishing = isRiverFishing
  if self._homelandFishing then
    self._homelandFishing:EnterFishing(isRiverFishing)
  end
end

function HomelandFishingManager:IsRiverFishing()
  return self._isRiverFishing
end

function HomelandFishingManager:GetRareFishing(rareId)
  return self._homelandFishing:GetRareFishing(rareId)
end

function HomelandFishingManager:StartFishTools(pet, fishLine, fishLineFirstPointTran)
  self._homelandFishing:StartFishTools(pet, fishLine, fishLineFirstPointTran)
end

function HomelandFishingManager:StopFishTools()
  self._homelandFishing:StopFishTools()
end

function HomelandFishingManager:DestroyFishTools()
  if not self._homelandFishing then
    return
  end
  self._homelandFishing:DestroyFishTools()
end
