local this = class("playercardDressTpl")

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
    return ""
  end
  if type(icon) == "string" then
    return icon
  end
  local ok, value = pcall(function()
    return icon[0]
  end)
  if ok and type(value) == "string" then
    return value
  end
  ok, value = pcall(function()
    return L_Config:getPathByHash(icon)
  end)
  if ok and type(value) == "string" then
    return value
  end
  return ""
end

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCustomize(tpl)
  return tpl.customize
end

function this:getType(tpl)
  return tpl.type
end

function this:getName(tpl)
  return getLangValue(tpl and tpl.name)
end

function this:getItemName(tpl)
  return getLangValue(tpl and (tpl.itemName or tpl.name))
end

function this:getDesc(tpl)
  return getLangValue(tpl and tpl.desc)
end

function this:getRarity(tpl)
  return tpl and tpl.rarity or 0
end

function this:getIcon(tpl)
  return getIconValue(tpl and tpl.icon)
end

function this:getShow(tpl)
  return tpl.show
end

function this:getTxt(tpl)
  return tpl.txt
end

function this:getDefault(tpl)
  return tpl.defaultComponent
end

function this:getSpecialDesc(tpl)
  return getLangValue(tpl and tpl.specialDesc)
end

function this:getId(tpl)
  return tpl.id
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getProfilePic(tpl)
  return tpl.profilepic
end

function this:getFramePic(tpl)
  return tpl.framepic
end

function this:getMaxNum(tpl)
  return tpl.maxNum
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

function this:getPreviewPaintingPath(tpl)
  return tpl.previewPaintingPath
end

function this:getPreviewStartingAnimation(tpl)
  return tpl.previewStartingAnimation
end

function this:getPreviewPlayAnimation(tpl)
  return tpl.previewPlayAnimation
end

function this:getPreviewFrameName(tpl)
  return tpl.previewFrameName
end

function this:getPreviewFallbackFrameName(tpl)
  return tpl.previewFallbackFrameName
end

function this:getPreviewHideBg(tpl)
  return tpl.previewHideBg
end

function this:getPreviewHideRole(tpl)
  return tpl.previewHideRole
end

function this:hasDynamicPreview(tpl)
  if not tpl then
    return false
  end
  local previewPaintingPath = tpl.previewPaintingPath
  return not string.isEmpty(previewPaintingPath)
end

return this
