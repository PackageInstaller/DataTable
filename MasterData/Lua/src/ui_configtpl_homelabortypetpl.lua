local this = class("homeLaborTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLaborName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getLaborDescList(tpl)
  local tmp = {}
  for _, v in ipairs(tpl.desc) do
    table.insert(tmp, L_Config:provider(v))
  end
  return tmp
end

function this:getLaborDescDetailList(tpl)
  local tmp = {}
  if tpl.descDetail ~= nil then
    for _, v in ipairs(tpl.descDetail) do
      table.insert(tmp, L_Config:provider(v))
    end
  end
  return tmp
end

function this:getLaborDescDetailListWithNoBonus(tpl)
  local tmp = {}
  if tpl.descDetail ~= nil then
    for _, v in ipairs(tpl.descDetail) do
      local subStr = ""
      local desc = L_Config:provider(v)
      if string.find(desc, "<color=#%x+>.*</color>") then
        subStr = string.gsub(desc, "<color=#%x+>.*</color>", "")
      end
      table.insert(tmp, subStr)
    end
  end
  return tmp
end

function this:getDescDetail(tpl)
  return tpl.descDetail
end

function this:getLaborIcon(tpl)
  return tpl.icon
end

function this:getHomeBuffIdList(tpl)
  return tpl.homeBuffId
end

function this:getHomeBuffIconList(tpl)
  return tpl.homeBuffIcon
end

function this:getHomeBuffSimpleTextList(tpl)
  local tmp = {}
  if tpl.homeBuffSimpleText ~= nil then
    for _, v in ipairs(tpl.homeBuffSimpleText) do
      table.insert(tmp, L_Config:provider(v))
    end
  end
  return tmp
end

function this:getHomeBuffTitleList(tpl)
  return tpl.homeBuffTitle
end

function this:getHomeBuffSimpleIconList(tpl)
  return tpl.homeBuffSimpleIcon
end

function this:getBuffValueParameter(tpl)
  return tpl.parameter
end

function this:getLaborParameter(tpl)
  return tpl.laborParameter
end

function this:getBuildingIconListByPetSize(tpl, petSize)
  local key = string.format("buildingIconPetSize%d", petSize)
  local tmp = {}
  for _, v in ipairs(tpl[key]) do
    table.insert(tmp, L_Config:provider(v))
  end
  return tmp
end

function this:getBuildingNameListByPetSize(tpl, petSize)
  local key = string.format("buildingNamePetSize%d", petSize)
  local tmp = {}
  for _, v in ipairs(tpl[key]) do
    table.insert(tmp, L_Config:provider(v))
  end
  return tmp
end

function this:getBuffCanMakeDesc(tpl, buffId)
  local homeBuffIdList = self:getHomeBuffIdList(tpl)
  if not homeBuffIdList then
    return ""
  end
  local buffIndex
  for i, id in ipairs(homeBuffIdList) do
    if id == buffId then
      buffIndex = i
      break
    end
  end
  if not buffIndex then
    return ""
  end
  local allBuffParas = tpl.buff_parameter
  if not allBuffParas or buffIndex > #allBuffParas then
    return ""
  end
  local buffParas = allBuffParas[buffIndex]
  if not buffParas or #buffParas == 0 then
    return ""
  end
  local textList = {}
  for _, index in ipairs(buffParas) do
    local langKey = string.format("ui_accessory_page_tab%d", index)
    local text = L_Lang:get(L_WordsTpl:getValue(langKey))
    table.insert(textList, text)
  end
  return table.concat(textList, "、")
end

return this
