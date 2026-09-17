local this = class("homeLevelShowTpl")

function this:init(config)
  self.data = config
  self.sortData = {}
  for i, v in pairs(config) do
    table.insert(self.sortData, v)
  end
  table.sort(self.sortData, function(a, b)
    return a.id < b.id
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBlock(tpl)
  return tpl.block
end

function this:getCommonItem(tpl)
  return tpl.commonItem
end

function this:getId(tpl)
  return tpl.id
end

function this:getSystemUnlock(tpl)
  return tpl.systemUnlock
end

function this:getTechnology(tpl)
  return tpl.technology
end

function this:getBuilding(tpl)
  return tpl.building
end

function this:getAllUnlockContent(tpl)
  local res = {}
  for i, v in pairs(tpl.building) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.Building,
      id = v
    })
  end
  for i, v in pairs(tpl.systemUnlock) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.System,
      id = v
    })
  end
  for i, v in pairs(tpl.block) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.Block,
      id = v
    })
  end
  for i, v in pairs(tpl.commonItem) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.CommonItem,
      id = v
    })
  end
  for i, v in pairs(tpl.technology) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.Technology,
      id = v
    })
  end
  for _, v in pairs(tpl.buildingNum) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.BuildingNum,
      id = v
    })
  end
  for _, v in pairs(tpl.mountSaddle) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.MountSaddle,
      id = v
    })
  end
  return res
end

function this:getMaxUnlockLevel()
  local res = 0
  for i, v in pairs(self.data) do
    if v.id <= L_PlayerStore:getLv() then
      res = math.max(res, v.id)
    end
  end
  return res
end

function this:getItemIndexByTypeId(type, id)
  for i, v in ipairs(self.sortData) do
    local unlockContent = self:getAllUnlockContent(v)
    local node, index = table.ipairsFind(unlockContent, function(v)
      return v.type == type and v.id == id
    end)
    if index then
      return i
    end
  end
end

return this
