local this = class("chatBubbleTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTextColor(tpl)
  return tpl.textColor
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getShowType(tpl)
  return tpl.getShowType
end

function this:getBubbleIcon(tpl)
  local res = L_Config:getPathByHash(tpl.res)
  return res
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

function this:getIcon(tpl)
  return L_Config:getPathByHash(tpl.icon)
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
