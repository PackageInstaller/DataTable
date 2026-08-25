local MapGearManager, Super = System.NewClass("MapGearManager", Manager)

function MapGearManager:ctor()
  Super.ctor(self)
  self.gearObjs = {}
  self.postionGearObj = {}
end

function MapGearManager:Awake()
  Super.Awake(self)
end

function MapGearManager:OnInit()
  self:CreateGears()
end

function MapGearManager:OnShow()
  for k, v in pairs(self.gearObjs) do
    if v.playedUp then
      v.playedUp = nil
      v:PlayUp()
    end
  end
end

function MapGearManager:AddGear(gearData, x, y)
  if 0 == gearData.type then
    return
  end
  MapModel.Instance:AddGearData(gearData)
  local obj = GearItemBase.Create(gearData.type, gearData, self)
  obj:SetGridPos(x, y)
  obj:LoadPrefab("MUnit/MUnit_02/Event/MUnit_Event_001/MUnit_Event_001a.prefab")
  self.parent:AddGearToTerrain(obj)
  if gearData.type ~= CommonDefine.GearItemType.ChangeAvatarRes then
    local idx = self.parent:GetIdxByPos(x, y)
    self.postionGearObj[idx] = obj
  end
  self.gearObjs[gearData.uid] = obj
end

function MapGearManager:RemoveGearByUid(uid)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  for idx, gear in pairs(self.postionGearObj) do
    if gear:GetUid() == uid then
      if gear:IsTriggering() then
        gear:EndTriggering()
      end
      local x, y = gear:GetGridPos()
      gear:OnRemove()
      terrainMgr:OnGearRemoved(x, y)
      break
    end
  end
end

function MapGearManager:RemoveGear(gear)
  gear:Dispose()
  for idx, v in pairs(self.postionGearObj) do
    if v == gear then
      self.postionGearObj[idx] = nil
      self.gearObjs[gear:GetUid()] = nil
      break
    end
  end
end

function MapGearManager:GetGearByUid(uid)
  return self.gearObjs[uid]
end

function MapGearManager:GetGearByTid(tid)
  for _, v in pairs(self.gearObjs) do
    if v:GetTid() == tid then
      return v
    end
  end
end

function MapGearManager:GetCurrGearType()
  local triggerObj = self:GetTriggerObj()
  if triggerObj then
    do return triggerObj.GetType end
    return triggerObj.GetType, triggerObj
  end
end

function MapGearManager:GetCurrGearName()
  local triggerObj = self:GetTriggerObj()
  return triggerObj and triggerObj.__name
end

function MapGearManager:GetGearByPos(x, y)
  local idx = self.parent:GetIdxByPos(x, y)
  do return self.GetGearByIdx, self end
  return self.GetGearByIdx, self, idx
end

function MapGearManager:GetGearByIdx(idx)
  return self.postionGearObj[idx]
end

function MapGearManager:CreateGears()
  local data = MapModel.Instance:GetGearData()
  for _, v in ipairs(data) do
    local x = v.x
    local y = v.y
    if v.type ~= CommonDefine.GearItemType.Wall and (6 ~= v.state or not v.isFinishDelete) then
      self:AddGear(v, x, y)
    end
  end
end

function MapGearManager:DestroyGears()
  for _, v in pairs(self.gearObjs) do
    v:Dispose()
  end
end

function MapGearManager:GetTriggerObj()
  local uid = MapModel.Instance:GetTriggerGearUid()
  if uid then
    do return self.GetGearByUid, self end
    return self.GetGearByUid, self, uid
  end
end

function MapGearManager:SetWaitingTrigger(isWaiting, gear)
  if gear then
    gear:SetWaitingForProto(isWaiting)
  end
end

function MapGearManager:InTrigger()
  do return MapModel.Instance.InGearTrigger end
  return MapModel.Instance.InGearTrigger, MapModel.Instance
end

function MapGearManager:OnDestroy()
  Super.OnDestroy(self)
  self:DestroyGears()
end

return MapGearManager
