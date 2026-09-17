local this = class("chatEmojiTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getIsDynamic(tpl)
  return tpl.frame > 1
end

function this:getFramePerCol(tpl)
  return tpl.resourceParam[1]
end

function this:getFramePerRow(tpl)
  return tpl.resourceParam[2]
end

function this:getMaxFrame(tpl)
  return tpl.frame
end

function this:getDesc(tpl)
  local desc = L_Config:provider(tpl.desc)
  return desc
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getResource(tpl)
  local resource = L_Config:getPathByHash(tpl.resource)
  return resource
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getShowIcon(tpl)
  local icon = self:getResource(tpl)
  if self:getIsDynamic(tpl) then
    return icon[1]
  else
    return icon
  end
end

function this:getDataByGroup(type)
  local tmp = {}
  for i, v in pairs(self.data) do
    if v.groupId == type then
      table.insert(tmp, v)
    end
  end
  return tmp
end

local function getLangValue(value)
  if value == nil then
    return ""
  end
  local ok, langValue = pcall(function()
    return value.value
  end)
  if ok and langValue ~= nil then
    return langValue
  end
  return L_Config:provider(value)
end

function this:getWayList(tpl)
  local res = {}
  if not tpl then
    return res
  end
  if tpl.way then
    for i, v in ipairs(tpl.way) do
      res[i] = {
        id = v,
        desc = getLangValue(tpl.wayDesc and tpl.wayDesc[i])
      }
    end
  end
  return res
end

return this
