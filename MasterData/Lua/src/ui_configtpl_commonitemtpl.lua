local this = class("commonItemTpl")

local function internalGetIcon(tpl)
  if tpl.icon and tpl.icon.Length > 0 then
    return tpl.icon[0]
  end
  if tpl.type == L_BagConst.bagItemType.food then
    return "UI/Atlas/Item/tex_icon_itemcooking_default.png"
  elseif tpl.type == L_BagConst.bagItemType.starGift then
    return "UI/Atlas/Item/tex_icon_itemstargift_default.png"
  elseif tpl.type == L_BagConst.bagItemType.skillBook then
    return "UI/Atlas/Item/tex_icon_itemtitle_default.png"
  elseif tpl.type == L_BagConst.bagItemType.enemyCommon then
    return "UI/Atlas/Item/tex_icon_itemstargift_default.png"
  else
    return "UI/Atlas/Item/tex_icon_item_default.png"
  end
end

local function internalGetFilterIcon(tpl)
  return tpl.filterIcon.Length > 0 and tpl.filterIcon[0] or ""
end

function this:init()
  local data = C_CommonItemTable.GetAllData()
  self.typeGroupData = {}
  self.typeNameData = {}
  self.useFunctionTb = {}
  self.giftBagRewardTb = {}
  self.rouletteTypeGroupData = {}
  local tmpUses, tmpReward
  for i = 0, data.Count - 1 do
    tmpUses = nil
    tmpReward = nil
    local commonItemConfig = data[i]
    local itemType = commonItemConfig.type
    local rouletteType = commonItemConfig.rouletteType
    if not self.typeGroupData[itemType] then
      self.typeGroupData[itemType] = {}
    end
    self.typeGroupData[itemType][commonItemConfig.id] = commonItemConfig
    self.useFunctionTb[commonItemConfig.id] = {}
    if commonItemConfig.useFunction then
      for i = 0, commonItemConfig.useFunction.Count - 1 do
        table.insert(self.useFunctionTb[commonItemConfig.id], tonumber(commonItemConfig.useFunction[i]))
      end
    end
    if commonItemConfig.giftBagReward ~= "" then
      tmpReward = string.split(commonItemConfig.giftBagReward, "|")
      self.giftBagRewardTb[commonItemConfig.id] = {}
      for _, rewardItem in ipairs(tmpReward) do
        local newReward = {}
        for _, r in ipairs(string.split(rewardItem, "#")) do
          table.insert(newReward, tonumber(r))
        end
        table.insert(self.giftBagRewardTb[commonItemConfig.id], newReward)
      end
    end
    if 0 < rouletteType then
      if not self.rouletteTypeGroupData[rouletteType] then
        self.rouletteTypeGroupData[rouletteType] = {}
      end
      if not self.rouletteTypeGroupData[rouletteType][commonItemConfig.rouletteTab] then
        self.rouletteTypeGroupData[rouletteType][commonItemConfig.rouletteTab] = {}
      end
      table.insert(self.rouletteTypeGroupData[rouletteType][commonItemConfig.rouletteTab], commonItemConfig)
    end
  end
  self.mt = {
    __index = function(t, k)
      local data = rawget(t, "configData")
      if not data then
        return nil
      end
      if k == "icon" then
        return internalGetIcon(data)
      elseif k == "filterIcon" then
        return internalGetFilterIcon(data)
      elseif k == "useFunction" then
        return self.useFunctionTb[data.id]
      else
        return data[k]
      end
    end
  }
end

function this:getTplById(id, echo)
  local data = C_CommonItemTable.GetData(id)
  if TableIsNull(data) and not echo then
    return nil
  end
  return setmetatable({configData = data}, self.mt)
end

function this:getInBag(tpl)
  return tpl.inBag == 1
end

function this:getCanUse(tpl)
  return tpl.canUse == 1
end

function this:getUseFunction(tpl)
  return self.useFunctionTb[tpl.id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getTypeName(tpl)
  return tpl.typeName.value
end

function this:getShowNum(tpl)
  print("_itemId: " .. tostring(tpl) .. "showNum: " .. tostring(tpl.showNum))
  return tpl.showNum == 1
end

function this:getDesc(tpl)
  return tpl.desc.value
end

function this:getSpecialDesc(tpl)
  return tpl.specialDesc.value
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getWayList(tpl)
  local res = {}
  if not string.isEmpty(tpl.way) then
    local wayList = tpl.configData:GetWayList()
    if wayList then
      local wayDescList = tpl.wayDesc
      for i = 0, wayList.Count - 1 do
        local _desc = ""
        if wayDescList[i] ~= nil and wayDescList[i].value ~= nil then
          _desc = wayDescList[i].value
        else
          print("此道具id描述配置错误" .. tpl.id)
        end
        res[i + 1] = {
          id = wayList[i],
          desc = _desc
        }
      end
    end
  end
  return res
end

function this:getName(tpl)
  return tpl.name.value
end

function this:getRawName(tpl)
  return tpl.name
end

function this:getStack(tpl)
  return tpl.stack
end

function this:getTab(tpl)
  return tpl.tab
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getItemGrade(tpl)
  return tpl.itemGrade
end

function this:getConfig()
  return self.data
end

function this:getSubId(tpl)
  return tpl.subId
end

function this:getTypeGroup(type)
  return self.typeGroupData[type] or {}
end

function this:getTypeNameByTypeNum(type)
  return self.typeNameData[type]
end

function this:getTag(tpl)
  local res = {}
  for i = 0, tpl.tag.Count - 1 do
    table.insert(res, tpl.tag[i].value)
  end
  return res
end

function this:getUseType(tpl)
  return tpl.useType
end

function this:getBagType(tpl)
  return tpl.bagType
end

function this:getBagSubType(tpl)
  return tpl.subType
end

function this:getGiftBagReward(tpl)
  return self.giftBagRewardTb[tpl.id]
end

function this:getStackNum(tpl)
  return tpl.stackNum
end

function this:getRouletteType(tpl)
  return tpl.rouletteType
end

function this:getRouletteTab(tpl)
  return tpl.rouletteTab
end

function this:getFilterIcon(tpl)
  return tpl.filterIcon
end

return this
