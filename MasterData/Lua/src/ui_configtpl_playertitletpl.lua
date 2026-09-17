local this = class("playerTitleTpl")
local DEFAULT_ICON = "UI/Atlas/Item/tex_icon_itemtitle_default.png"

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

local function getIconValue(icon)
  if icon == nil then
    return DEFAULT_ICON
  end
  if type(icon) == "string" then
    return string.isEmpty(icon) and DEFAULT_ICON or icon
  end
  local ok, value = pcall(function()
    return icon[0]
  end)
  if ok and type(value) == "string" and not string.isEmpty(value) then
    return value
  end
  ok, value = pcall(function()
    return L_Config:getPathByHash(icon)
  end)
  if ok and type(value) == "string" and not string.isEmpty(value) then
    return value
  end
  return DEFAULT_ICON
end

function this:init(config)
  self.data = config
end

function this:getAllId(idList, type)
  for _, v in pairs(self.data) do
    local tempType = self:getType(v)
    local id = self:getId(v)
    if tempType == type then
      table.insert(idList, id)
    end
  end
  return idList
end

function this:getTplById(id)
  return self.data[id]
end

function this:getType(tpl)
  return tpl and tpl.type or 0
end

function this:getSpecial(tpl)
  return tpl and tpl.special or 0
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  if not tpl then
    return ""
  end
  return getLangValue(tpl.name)
end

function this:getItemName(tpl)
  if not tpl then
    return ""
  end
  return getLangValue(tpl.itemName)
end

function this:getIcon(tpl)
  return getIconValue(tpl and tpl.icon)
end

function this:getDesc(tpl)
  return getLangValue(tpl and tpl.desc)
end

function this:getItemDesc(tpl)
  return getLangValue(tpl and tpl.itemDesc)
end

function this:getRarity(tpl)
  if not tpl then
    return 0
  end
  local rarity = tpl.itemRarity
  if rarity == nil then
    errorf("playerTitleTpl:getRarity - tpl.rarity is nil, id = %s", tostring(tpl.id))
    return 0
  end
  return rarity
end

function this:getSpecialDesc(tpl)
  return getLangValue(tpl and tpl.specialDesc)
end

function this:getWayList(tpl)
  local res = {}
  if not tpl then
    return res
  end
  for i = 1, 3 do
    local systemIdKey = string.format("way%d", i)
    local descKey = string.format("way%ddesc", i)
    if not math.isEmpty(tpl[systemIdKey]) or not string.isEmpty(tpl[descKey]) then
      res[i] = {
        id = tpl[systemIdKey],
        desc = getLangValue(tpl[descKey])
      }
    end
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
