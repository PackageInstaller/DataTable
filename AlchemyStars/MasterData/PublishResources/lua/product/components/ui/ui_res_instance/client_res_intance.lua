_class("ClientResInstance", Object)
ClientResInstance = ClientResInstance

function ClientResInstance:Constructor()
  self.entryDatas = {}
  self:InitEntryConfig()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  self.resInstanceLocalDBKey = {
    [DungeonType.DungeonType_Coin] = pstid .. "DungeonType_Coin",
    [DungeonType.DungeonType_Experience] = {
      [DungeonSubType.DungeonSubType_Blue] = pstid .. "DungeonSubType_Blue",
      [DungeonSubType.DungeonSubType_Red] = pstid .. "DungeonSubType_Red",
      [DungeonSubType.DungeonSubType_Green] = pstid .. "DungeonSubType_Green",
      [DungeonSubType.DungeonSubType_Yellow] = pstid .. "DungeonSubType_Yellow"
    },
    [DungeonType.DungeonType_AircraftMaterial] = pstid .. "DungeonType_AircraftMaterial",
    [DungeonType.DungeonType_equip] = pstid .. "DungeonType_AircraftEquip"
  }
  self.resInstanceSubLocalDBKey = pstid .. "ResInstanceSubLocalDBKey"
end

function ClientResInstance:InitEntryConfig()
  local entrys = Cfg.cfg_res_instance_entry({})
  for id, cfg in ipairs(entrys) do
    local e = UIResInstanceEntryData:New(cfg)
    self.entryDatas[e:GetMainType()] = e
  end
end

function ClientResInstance:GetEntryCount()
  return table.count(self.entryDatas)
end

function ClientResInstance:GetEntryDatas()
  return self.entryDatas
end

function ClientResInstance:GetEntryById(entryId)
  return self.entryDatas[entryId]
end

function ClientResInstance:GetInstanceById(entryId, instanceId)
  return self.entryDatas[entryId][instanceId]
end

function ClientResInstance:GetMainTypeByInstanceId(instanceId)
  for mainType, entry in pairs(self.entryDatas) do
    local instanceData = entry:GetInstanceById(instanceId)
    if instanceData then
      return mainType
    end
  end
  return nil
end

function ClientResInstance:GetExpInstanceList(subType)
  return self.entryDatas[DungeonType.DungeonType_Experience]:GetExpInstanceList(subType)
end

function ClientResInstance:GetExpInstanceListSort(subType)
  return self.entryDatas[DungeonType.DungeonType_Experience]:GetExpInstanceListSort(subType)
end

function ClientResInstance:GetNormalInstanceList(mainType)
  return self.entryDatas[mainType]:GetInstanceList(mainType)
end

function ClientResInstance:GetLocalDBKey(mainType, subType)
  if mainType == DungeonType.DungeonType_Experience then
    return self.resInstanceLocalDBKey[mainType][subType]
  else
    return self.resInstanceLocalDBKey[mainType]
  end
end
