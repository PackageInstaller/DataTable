local this = class("currencyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getQuality(tpl)
  return tpl.quality
end

function this:getIconSmall(tpl)
  local icon = L_Config:getPathByHash(tpl.iconSmall)
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getShowNum(tpl)
  return tpl.showNum == 1
end

function this:getMaxNum(tpl)
  return tpl.maxNum
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
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

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

return this
