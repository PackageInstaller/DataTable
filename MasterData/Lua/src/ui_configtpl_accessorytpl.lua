local this = class("accessoryTpl")
local _accessoryLevelTpl = L_GameTpl:getAccessoryLevelTpl()
local _accessorySubParameterTpl = L_GameTpl:getAccessorySubParameterTpl()

function this:init(config)
  self.data = config
  self.suitData = {}
  for i, v in pairs(config) do
    if not math.isEmpty(v.setId) then
      self.suitData[v.setId] = self.suitData[v.setId] or {}
      table.insert(self.suitData[v.setId], v)
    end
  end
end

function this:getTplById(id)
  if self.data[id] == nil then
    errorf("accessoryTpl配置中不存在该id：" .. tostring(id))
  end
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getSubAttr(tpl)
  return tpl.subAttr
end

function this:getType(tpl)
  if tpl == nil then
    return nil
  end
  return tpl.type
end

function this:getHeadRank(tpl)
  return tpl.headRank
end

function this:getPosition(tpl)
  return tpl.position
end

function this:getSetId(tpl)
  return tpl.setId
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getMainAttr(tpl)
  return tpl.mainAttr
end

function this:getElementAttr(tpl)
  return tpl.elementAttr
end

function this:getMaxLevel(tpl)
  local maxLevel = _accessoryLevelTpl:getMaxLevelByAccessoryId(tpl.id)
  return maxLevel
end

function this:getRefreshCost1(tpl)
  return tpl.refreshCost1
end

function this:getRefreshCost2(tpl)
  return tpl.refreshCost2
end

function this:getProvideLaborExp(tpl)
  return tpl.provideLaborExp ~= 0
end

function this:getIcon(tpl)
  local icon = tpl.texture[1]
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_icon_accessory_default.png"
  end
  return icon
end

function this:getSlotIcon(tpl)
  local icon = tpl.texture[2]
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_icon_accessory_default.png"
  end
  return icon
end

function this:getLargeIconByTpl(tpl)
  local icon = tpl.texture[3]
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_icon_accessory_default.png"
  end
  return icon
end

function this:getSubParameter(tpl)
  return tpl.subParameter
end

function this:getSubAtt(tpl)
  if math.isEmpty(tpl.subParameter) then
    return {}
  end
  local sortData = _accessorySubParameterTpl:getSortTplByGroupId(tpl.subParameter)
  local res = {}
  for _, v in ipairs(sortData) do
    table.insert(res, {
      type = _accessorySubParameterTpl:getType(v),
      key = _accessorySubParameterTpl:getParameter(v),
      val = _accessorySubParameterTpl:getValue(v),
      quality = _accessorySubParameterTpl:getQuality(v),
      sort = _accessorySubParameterTpl:getSort(v)
    })
  end
  table.sort(res, function(a, b)
    return a.sort < b.sort
  end)
  return res
end

function this:getTplListBySuitId(suitId)
  local res = self.suitData[suitId] or {}
  table.sort(res, function(a, b)
    return a.type < b.type
  end)
  return res
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getWayList(tpl)
  local res = {}
  for i = 1, 3 do
    local systemIdKey = string.format("way%d", i)
    local descKey = string.format("way%ddesc", i)
    if not math.isEmpty(tpl[systemIdKey]) or not string.isEmpty(tpl[descKey]) then
      res[i] = {
        id = tpl[systemIdKey],
        desc = L_Config:provider(tpl[descKey])
      }
    end
  end
  if tpl.way then
    for i, v in ipairs(tpl.way) do
      res[i] = {
        id = v,
        desc = L_Config:provider(tpl.wayDesc[i])
      }
    end
  end
  return res
end

function this:checkIsAcessoryData(id)
  if self.data[id] == nil then
    return false
  end
  return true
end

return this
