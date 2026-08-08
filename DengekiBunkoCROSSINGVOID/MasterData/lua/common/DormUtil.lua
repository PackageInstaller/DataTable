local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")
local BoxTerm = CS.IsometricGame.BoxTerm
local DormUtil = {}
local m_deskSuitMap

function DormUtil.GetFurnIdByName(name)
  return tonumber(string.sub(name, 11))
end

function DormUtil.RequestSaveArrangement(arrangementList, callback)
  local param = {arrangement = arrangementList}
  DB:GameRequest("fci/dorm-arrangement"):Post(ProtobufT("ApiDormArrangement", param), function(resp)
    local dormInfo = DB:GetData("fci/dorm/{playerId}").dormInfo
    for _, arrangement in ipairs(arrangementList) do
      local idx = table.find(dormInfo.dormArrangement, function(k, v)
        return v.floor == arrangement.floor
      end)
      if idx then
        dormInfo.dormArrangement[idx] = arrangement
      else
        table.insert(dormInfo.dormArrangement, arrangement)
      end
    end
    DB:SetData("fci/dorm/{playerId}", {dormInfo = dormInfo})
    if callback then
      callback(resp)
    end
  end)
end

function DormUtil.ShowExtendFloorMessage(respCallback)
  local playerId = DB:GetData("playerId")
  local dormInfo = DB:GetData("fci/dorm/{playerId}").dormInfo
  DormUtil.ShowExtendMessage(PB.enum.DormExtensionType.Floor, dormInfo.dormLevel + 1, function(resp)
    dormInfo.dormLevel = dormInfo.dormLevel + 1
    DB:SetData("fci/dorm/{playerId}", {dormInfo = dormInfo})
    if respCallback then
      respCallback(resp)
    end
  end)
end

function DormUtil.ShowExtendMessage(type, target, respCallback)
  local costConfig = PB.get("DormExtensionCost", type, target)
  if costConfig == nil then
    return
  end
  local cost = costConfig.cost[1]
  local enough = DB:GetData(string.format("fci/resource/%s_%s", PB.enum.ResourceType.__keys[cost.type], cost.id)) >= cost.count
  WU.ShowMessageYesNo(WU.GetString("Dorm_ExtendTip_" .. type) .. "<br>" .. WU.GetString("Purchase_Tips4") .. string.format("<img src='ResIcon_s.%s_%s'>&nbsp;%s", PB.enum.ResourceType.__keys[cost.type], cost.id, HU.ApplyFontColor(cost.count, fif(enough, "#2B487F", "#FD5454"))), function(result)
    if result == "YES" then
      DB:GameRequest("fci/dorm-extend"):Post({extType = type}, function(resp)
        DBH.ResChange(resp.resChange)
        if respCallback then
          respCallback(resp)
        end
      end)
    end
  end)
end

function DormUtil.TranslateActorToInteractiveFurn(agentBox, targetBox)
  agentBox.flip = fif(targetBox.flip, not targetBox.interactiveFlip, targetBox.interactiveFlip)
  agentBox.isoPosition = targetBox:GetInteractiveSeat()
  agentBox:SetParent(targetBox)
end

function DormUtil.CalcComfort()
  local totalComfort = 0
  local subCategoryFurnitrueMap = _ENV["!"]({})
  local furnitureConfigs = PB.all("FurnitureConfig")
  for i = 1, #furnitureConfigs do
    local furnConfig = furnitureConfigs[i]
    local id = furnConfig.id
    local item = DB:GetData("fci/item/" .. id)
    if item and 0 < item.count then
      local subCat = furnConfig.subCategory
      subCategoryFurnitrueMap[subCat] = subCategoryFurnitrueMap[subCat] or _ENV["!"]({})
      local cnt = item.count
      while 0 < cnt do
        table.insert(subCategoryFurnitrueMap[subCat], id)
        cnt = cnt - 1
      end
    end
  end
  local subComfort = {}
  for cat, furnitures in pairs(subCategoryFurnitrueMap) do
    furnitures = furnitures:sort(function(a, b)
      return PB.get("FurnitureConfig", a).comfort > PB.get("FurnitureConfig", b).comfort
    end)
    local comfortConfig = PB.get("DormComfortConfig", cat)
    local comfortCount = 99999
    if comfortConfig and comfortConfig.comfortCount ~= 0 then
      comfortCount = comfortConfig.comfortCount
    end
    for idx, id in ipairs(furnitures) do
      if idx <= comfortCount then
        local comfort = PB.get("FurnitureConfig", id).comfort
        subComfort[cat] = subComfort[cat] or 0
        subComfort[cat] = subComfort[cat] + comfort
      end
    end
  end
  for _, v in pairs(subComfort) do
    totalComfort = totalComfort + v
  end
  return totalComfort
end

function DormUtil.GetLuaArrangement(root, floor)
  local furnitures = {}
  local arrangement = {floor = floor, furnitures = furnitures}
  local cntBorder = root.borderList.size
  
  local function Impl(list)
    for i = 0, list.size - 1 do
      local box = list[i]
      if box.term ~= BoxTerm.Dynamic then
        local furnId = DormUtil.GetFurnIdByName(box.name)
        local pos = box.isoPosition
        local parentIdx = -1
        if box.boxParent then
          parentIdx = cntBorder + list:IndexOf(box.boxParent) + 1
        end
        table.insert(furnitures, {
          furnitureId = furnId,
          position = {
            x = pos.x,
            y = pos.y,
            z = pos.z
          },
          flip = box.flip,
          parent = parentIdx
        })
      end
    end
  end
  
  Impl(root.borderList)
  Impl(root.boxList)
  return arrangement
end

local function InitDeskSuitMap()
  local furnitureConfigs = PB.all("FurnitureConfig")
  m_deskSuitMap = {}
  for i = 1, #furnitureConfigs do
    local config = furnitureConfigs[i]
    for j = 1, #config.deskConstrains do
      local deskId = config.deskConstrains[j].id
      m_deskSuitMap[deskId] = m_deskSuitMap[deskId] or {}
      table.insert(m_deskSuitMap[deskId], config.id)
    end
  end
end

function DormUtil.CheckDeskSuit(onDeskId, deskId)
  if m_deskSuitMap == nil then
    InitDeskSuitMap()
  end
  local deskConstrains = PB.get("FurnitureConfig", onDeskId).deskConstrains
  if #deskConstrains ~= 0 then
    return table.find(deskConstrains, function(k, v)
      return v.id == deskId
    end) ~= nil
  else
    local onDeskIds = m_deskSuitMap[deskId]
    if onDeskIds == nil then
      return true
    end
    return table.has(onDeskIds, onDeskId)
  end
end

function DormUtil.AgentBoxFaceToFace(box1, box2)
  local pos1 = box1.isoPosition
  local pos2 = box2.isoPosition
  local k1 = pos1.x + pos1.y
  local k2 = pos2.x + pos2.y
  if k1 < k2 then
    return box1.flip and not box2.flip
  elseif k1 > k2 then
    return not box1.flip and box2.flip
  else
    return false
  end
end

return DormUtil
