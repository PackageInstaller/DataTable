local this = class("reputationLevelTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplByForceLv(forceId, lv)
  for k, v in pairs(self.data) do
    if v.reputationId == forceId and v.reputationlevel == lv then
      return v
    end
  end
  return nil
end

function this:getTotalForceList()
  local res = {}
  for k, v in pairs(self.data) do
    local needAdd = true
    for k2, v2 in pairs(res) do
      if v2 == v.reputationId then
        needAdd = false
      end
    end
    if needAdd then
      table.insert(res, v.reputationId)
    end
  end
  
  local function sortFun(a, b)
    return a < b
  end
  
  table.sort(res, sortFun)
  return res
end

function this:getTplByForce(forceId)
  local res = {}
  for k, v in pairs(self.data) do
    if v.reputationId == forceId then
      table.insert(res, v)
    end
  end
  
  local function sortFun(a, b)
    return a.id < b.id
  end
  
  table.sort(res, sortFun)
  return res
end

function this:getAllUnlockContent(tpl)
  local res = {}
  if tpl.reputationRecipe == nil then
    return res
  end
  for i, v in pairs(tpl.reputationRecipe) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.CommonItem,
      id = v
    })
  end
  for i, v in pairs(tpl.reputationProducts) do
    table.insert(res, {
      type = L_HomeConst.HomeLevelUnlockModuleType.Building,
      id = v
    })
  end
  return res
end

return this
