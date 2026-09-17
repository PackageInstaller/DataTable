local this = class("battleInfoTpl")

function this:init(config)
  self.data = config
  self.group = {}
  for i, v in pairs(config) do
    if not table.isEmpty(v.attrGroup) then
      if not self.group[v.attrGroup[1]] then
        self.group[v.attrGroup[1]] = {}
      end
      self.group[v.attrGroup[1]][v.attrGroup[2]] = v
    end
  end
end

function this:getShowTypeOutsideAttrs()
  if self.showTypeOutsideAttrs then
    return self.showTypeOutsideAttrs
  end
  local tempShowTypeOutsideTable = {}
  for _, v in pairs(self.data) do
    if v.showTypeOutside > 0 then
      table.insert(tempShowTypeOutsideTable, v)
    end
  end
  table.sort(tempShowTypeOutsideTable, function(a, b)
    return a.showTypeOutside < b.showTypeOutside
  end)
  self.showTypeOutsideAttrs = {}
  for _, v in ipairs(tempShowTypeOutsideTable) do
    table.insert(self.showTypeOutsideAttrs, v.attrVal)
  end
  return self.showTypeOutsideAttrs
end

function this:getShowTypeLvUpAttrs()
  if self.showTypeLvUpAttrs then
    return self.showTypeLvUpAttrs
  end
  local tempShowTypeLvUpTable = {}
  for _, v in pairs(self.data) do
    if v.showTypeLvUp > 0 then
      table.insert(tempShowTypeLvUpTable, v)
    end
  end
  table.sort(tempShowTypeLvUpTable, function(a, b)
    return a.showTypeLvUp < b.showTypeLvUp
  end)
  self.showTypeLvUpAttrs = {}
  for _, v in ipairs(tempShowTypeLvUpTable) do
    table.insert(self.showTypeLvUpAttrs, v.attrVal)
  end
  return self.showTypeLvUpAttrs
end

function this:getGroupId(tpl)
  if not table.isEmpty(tpl.attrGroup) then
    return tpl.attrGroup[1]
  end
end

function this:getGroupType(tpl)
  if not table.isEmpty(tpl.attrGroup) then
    return tpl.attrGroup[2]
  end
end

function this:getHasGroup(id)
  local tpl = self:getTplById(id)
  if tpl == nil then
    return false
  else
    return not table.isEmpty(tpl.attrGroup)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAttrType(tpl)
  return tpl.attrType
end

function this:getIsRatio(tpl)
  return tpl.isRatio
end

function this:getAttrVal(tpl)
  return tpl.attrVal
end

function this:getAttrID(tpl)
  return tpl.attrID
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getShowTxt(id, value)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    return tostring(value)
  else
    local num = string.format("%.1f", value / 100)
    return string.concat(num, "%")
  end
end

function this:getShowTxtInt(id, value, isMatch)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    if isMatch then
      value = value + value * 0.1
      value = value - 1
    end
    return tostring(math.ceil(value))
  else
    local floored = math.floor(value / 10) / 10
    if isMatch then
      floored = floored + floored * 0.1
      floored = floored - 0.1
    end
    local num = string.format("%.1f", floored)
    return string.concat(num, "%")
  end
end

function this:getShowTxtIntByQuality(id, value, quality, isMatch)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    local _value = this:getValueByQuality(value, quality)
    if isMatch then
      _value = _value + _value * 0.1
      _value = _value - 1
    end
    return tostring(math.ceil(_value))
  else
    local _value = this:getValueByQuality(value, quality)
    local floorValue = math.floor(_value / 10) / 10
    if isMatch then
      floorValue = floorValue + floorValue * 0.1
      floorValue = floorValue - 1
    end
    local num = string.format("%.1f", floorValue)
    return string.concat(num, "%")
  end
end

function this:getValueByQuality(newValue, quality)
  if 0 < quality then
    local accessoryQualityTpl = L_GameTpl:getAccessoryQualityTpl()
    local quality_tpl = accessoryQualityTpl:getTplById(quality)
    newValue = newValue * (1 + accessoryQualityTpl:getValueByTpl(quality_tpl) / 10000)
  end
  return newValue
end

function this:getShowTxtComma(id, value)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    return self:addComma(value)
  else
    local num = string.format("%.1f", value / 100)
    return string.concat(num, "%")
  end
end

function this:addComma(value)
  if tonumber(value) == nil then
    return "Error: Input is not a number."
  end
  value = tostring(value)
  local integer_part, decimal_part = string.match(value, "^(%d+)(%.%d*)$")
  integer_part = integer_part or value
  local output = ""
  local length = string.len(integer_part)
  local counter = 0
  for i = length, 1, -1 do
    counter = counter + 1
    output = string.sub(integer_part, i, i) .. output
    if counter == 3 and 1 < i then
      output = "," .. output
      counter = 0
    end
  end
  if decimal_part then
    output = output .. decimal_part
  end
  return output
end

function this:getShowPropertyTxt_soulEssence(id, value)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    return tostring(value)
  else
    return tostring(value / 100) .. "%"
  end
end

function this:getShowIncreaseNum(id, value1, value2)
  local tpl = self.data[id]
  if tpl.isRatio == 0 then
    return tostring(value1 - value2)
  else
    local temp = (value1 - value2) / 100
    if temp == 0 then
      return "0%"
    end
    return string.concat(temp, "%")
  end
end

function this:getGroupById(id)
  local group = self:getTplById(id).attrGroup
  if table.isEmpty(group) then
    return
  end
  local groupId = group[1]
  return self.group[groupId]
end

function this:getShortName(tpl)
  return L_Config:provider(tpl.shortName)
end

function this:getShowType(tpl)
  return tpl.showType
end

function this:getSort(tpl)
  return tpl.sort
end

function this:getPetShowType(tpl)
  return tpl.petShowType
end

function this:getPetSort(tpl)
  return tpl.petSort
end

function this:getElementType(tpl)
  return tpl.elementType
end

function this:getPetFruitPixelEffectPathInfo(tpl)
  local petFruitPixelEffectPathInfo = {}
  petFruitPixelEffectPathInfo.frontPixelEffectPath = tpl.pixelEffect[1]
  petFruitPixelEffectPathInfo.backPixelEffectPath = tpl.pixelEffect[2]
  return petFruitPixelEffectPathInfo
end

function this:getPixelEffectFrameTextureConfigInfos(tpl)
  local frameTextureConfigInfos = {}
  for i, rawFrameTextureConfigInfo in pairs(tpl.pixelEffectFrame) do
    local frameTextureConfigInfo = {}
    frameTextureConfigInfo.rowNum = rawFrameTextureConfigInfo[1]
    frameTextureConfigInfo.colNum = rawFrameTextureConfigInfo[2]
    frameTextureConfigInfo.iconNum = rawFrameTextureConfigInfo[3]
    if i == 1 then
      frameTextureConfigInfos.frontFrameTextureConfigInfo = frameTextureConfigInfo
    else
      frameTextureConfigInfos.backFrameTextureConfigInfo = frameTextureConfigInfo
    end
  end
  return frameTextureConfigInfos
end

function this:getGroupIdById(id)
  local group = self:getTplById(id).attrGroup
  if table.isEmpty(group) then
    return
  end
  return group
end

return this
