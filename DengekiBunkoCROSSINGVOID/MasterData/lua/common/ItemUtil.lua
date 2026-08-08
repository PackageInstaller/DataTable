local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local IU = {}

function IU.FlatInboxItems(items, ownerBoxId)
  local flatenItems = _ENV["!"]({})
  if items ~= nil then
    for k, item in pairs(items) do
      if item.inBox == nil or #item.inBox == 0 then
        if ownerBoxId ~= nil then
          item.ownerBoxId = ownerBoxId
        end
        table.insert(flatenItems, item)
      elseif item.baseRes and item.baseRes.type == PB.enum.ResourceType.ResItem then
        table.append(flatenItems, IU.FlatInboxItems(item.inBox, item.baseRes.id))
      else
        table.append(flatenItems, IU.FlatInboxItems(item.inBox))
      end
    end
  end
  return flatenItems
end

function IU.UpdateItemListener(items, uid)
  if items ~= nil and not table.empty(items) then
    local itemListener = {}
    for i = 1, #items do
      local item = items[i]
      itemListener[item.id] = {}
      local data = DB:GetData("fci/item/" .. item.id)
      local count = 0
      if data ~= nil then
        count = data.count
      end
      itemListener[item.id].count = count
      itemListener[item.id].needCount = item.count
    end
    itemListener.uid = uid
    DB:SetData("Item/Listener", itemListener)
  else
    DB:SetData("Item/Listener", nil)
  end
end

function IU.GetManualBox(boxId)
  local itemInfo = PB.get("ItemInfo", boxId)
  if itemInfo.funcType == PB.enum.ItemFuncType.FinanceBox then
    local result = GetFinanceManualBox(boxId)
    result.type = itemInfo.param[1]
    result.id = boxId
    return result
  end
  local manualBoxList = PB.all("ManualBox")
  local result
  local inBoxArray = _ENV["!"]({})
  for _, manualBox in ipairs(manualBoxList) do
    if manualBox.id == boxId then
      table.insert(inBoxArray, manualBox.inBox)
      manualBox.inBoxArray = inBoxArray
      result = result or manualBox
    end
  end
  return result
end

function GetFinanceManualBox(boxId)
  local manualBoxList = PB.all("FinanceBox")
  local result
  local inBoxArray = _ENV["!"]({})
  for _, manualBox in ipairs(manualBoxList) do
    if manualBox.itemId == boxId then
      table.insert(inBoxArray, manualBox.onceRes)
      manualBox.inBoxArray = inBoxArray
      result = result or manualBox
    end
  end
  return result
end

function IU.RemoveExtraRewards(rewards)
  for i = #rewards, 1, -1 do
    local reward = rewards[i]
    if reward.type == PB.enum.ResourceType.ResItem then
      local info = DB:GetData("fci/item/" .. reward.id)
      if info ~= nil and info.historyGetCount ~= nil then
        local config = PB.get("ItemInfo", reward.id)
        if config == nil then
          error("no id " .. reward.id .. " in ItemInfo.xlsx")
        elseif config.dropMaxCount > 0 and info.historyGetCount >= config.dropMaxCount then
          table.remove(rewards, i)
        end
      end
    end
  end
end

function IU.GetResourceIconPath(type, id)
  if type == PB.enum.ResourceType.ResPlayerHeadFrame then
    return string.format("Texture/ItemIcon/head_frame_%s", id)
  else
    return string.format("Texture/ItemIcon/%s_%s", PB.enum.ResourceType[type], id)
  end
end

function IU.GetResourceQuality(type, id)
  if type == PB.enum.ResourceType.ResItem then
    return PB.get("ItemInfo", id).quality
  else
    return PB.get("ResourceQuality", type).quality
  end
end

return IU
