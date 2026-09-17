local this = class("runeStore", G_BaseStore)
local _talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local _talentRuneComposeTpl = L_GameTpl:getTalentRuneComposeTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local L_SlotResultType = {
  direct = 0,
  compose = 1,
  gift = 3
}
this.event = {
  composeSuccess = "composeSuccess"
}
this:importPartialClass(require(L_R.store .. "rune.runeAction"))
local MAX_COMPOSE_NUM = 999

function this:checkIsCanMaterialByRuneId(talentRuneId, isUsedGift)
  if isUsedGift == nil then
    isUsedGift = true
  end
  local store = C_RuneStore.GetStore()
  return store:OnCheckIsCanMaterialByRuneId(talentRuneId, isUsedGift)
end

function this:getMaterialByRuneId(talentRuneId)
  local list = {}
  local runeTpl = _talentRuneTpl:getTplById(talentRuneId)
  local runeItemId = _talentRuneTpl:getRuneItem(runeTpl)
  local item = {
    itemType = L_Const.resType.commonItem,
    itemId = runeItemId,
    itemNum = 1
  }
  table.insert(list, item)
  local equipRuneCoin = _talentRuneTpl:getEquipRuneCoin(runeTpl)
  for _, v in pairs(equipRuneCoin) do
    item = {
      itemType = L_Const.resType.currency,
      itemId = v[1],
      itemNum = v[2]
    }
    table.insert(list, item)
  end
  local equipRuneThroughCoin = _talentRuneTpl:getEquipRuneThroughCoin(runeTpl)
  item = {
    itemType = L_Const.resType.currency,
    itemId = L_Const.currencyType.gold,
    itemNum = equipRuneThroughCoin
  }
  table.insert(list, item)
  local extraCost = _talentRuneTpl:getExtraCost(runeTpl)
  if not table.isEmpty(extraCost) then
    extraCost = extraCost[1]
    item = {
      itemType = L_Const.resType.commonItem,
      itemId = extraCost[2],
      itemNum = extraCost[3]
    }
    table.insert(list, item)
  end
  return list
end

function this:OnGetCanCompose(composeId, composeNum)
  local bCanCompose, materiaList = self:bCanCompose(composeId, composeNum)
  if bCanCompose then
    return materiaList
  end
  return nil
end

function this:OnIsCanCompose(composeId, composeNum)
  local bCanCompose, _ = self:bCanCompose(composeId, composeNum)
  if bCanCompose then
    return true
  end
  return false
end

function this:bCanCompose(composeitemID, composeNum)
  local composeTpl = _talentRuneComposeTpl:getTplById(composeitemID)
  local bUnlock = L_ConditionManager:isComplete(_talentRuneComposeTpl:getComposeCondition(composeTpl))
  if bUnlock == false then
    return false, {}, 0
  end
  local composeMaterialMap = _talentRuneComposeTpl:getcomposeMaterialMap()
  if type(composeitemID) ~= "number" or type(composeNum) ~= "number" or composeNum <= 0 then
    return false, {}, 0
  end
  if not composeMaterialMap or not composeMaterialMap[composeitemID] then
    return false, {}, 0
  end
  local coinHave = C_BagMgr:getItemNumByItemId(L_Const.currencyType.gold)
  local midBagUsed = {}
  
  local function useFromMidBag(itemId, needCount)
    if needCount <= 0 then
      return 0
    end
    local have = C_BagMgr:getItemNumByItemId(itemId)
    local used = midBagUsed[itemId] or 0
    local remain = math.max(0, have - used)
    local take = math.min(needCount, remain)
    if 0 < take then
      midBagUsed[itemId] = used + take
    end
    return take
  end
  
  local aggregatedNeeds = {}
  
  local function makeKey(itemType, itemId)
    return tostring(itemType or -1) .. ":" .. tostring(itemId)
  end
  
  local function addNeed(itemType, itemId, count)
    if count <= 0 then
      return
    end
    local k = makeKey(itemType, itemId)
    local node = aggregatedNeeds[k]
    if not node then
      node = {
        itemType = itemType,
        itemId = itemId,
        need = 0
      }
      aggregatedNeeds[k] = node
    end
    node.need = node.need + count
  end
  
  local visiting = {}
  
  local function dfs(itemId, needCount, isRoot, itemType)
    if needCount <= 0 then
      return true
    end
    local used
    if isRoot then
      used = 0
    else
      used = useFromMidBag(itemId, needCount)
    end
    local toCraft = needCount - used
    if toCraft <= 0 then
      addNeed(itemType, itemId, needCount)
      return true
    elseif 0 < used then
      addNeed(itemType, itemId, used)
    end
    local recipe = composeMaterialMap[itemId]
    if not recipe then
      return false
    end
    local subTpl = _talentRuneComposeTpl:getTplById(itemId)
    local subUnlock = L_ConditionManager:isComplete(_talentRuneComposeTpl:getComposeCondition(subTpl))
    if subUnlock == false then
      return false
    end
    if visiting[itemId] then
      return false
    end
    visiting[itemId] = true
    for _, comp in ipairs(recipe) do
      local subNeed = (comp.itemNum or 0) * toCraft
      if 0 < subNeed then
        if composeMaterialMap[comp.itemId] then
          if not dfs(comp.itemId, subNeed, false, comp.itemType) then
            visiting[itemId] = nil
            return false
          end
        else
          addNeed(comp.itemType, comp.itemId, subNeed)
        end
      end
    end
    visiting[itemId] = nil
    return true
  end
  
  local needTop = composeNum
  if 0 < needTop and not dfs(composeitemID, needTop, true) then
    return false, {}, 0
  end
  local materials = {}
  for _, req in pairs(aggregatedNeeds) do
    local have = C_BagMgr:getItemNumByItemId(req.itemId)
    local lack = math.max(0, req.need - have)
    table.insert(materials, {
      itemType = req.itemType,
      itemId = req.itemId,
      itemNumTxt = req.need,
      have = have,
      lack = lack
    })
  end
  table.sort(materials, function(a, b)
    if a.itemType ~= b.itemType then
      return a.itemType < b.itemType
    end
    return a.itemId < b.itemId
  end)
  local bCanCompose = true
  for _, m in ipairs(materials) do
    if 0 < (m.lack or 0) then
      bCanCompose = false
      break
    end
  end
  return bCanCompose, materials
end

function this:canComposeNew(composeitemID, composeNum)
  return self:bCanCompose(composeitemID, composeNum)
end

function this:getMaxCanCompose(itemId)
  local composeMaterialMap = _talentRuneComposeTpl:getcomposeMaterialMap()
  if not composeMaterialMap or not composeMaterialMap[itemId] then
    return 0
  end
  local low, high = 0, 1
  while true do
    local ok = self:canComposeNew(itemId, high)
    if not ok then
      break
    end
    low = high
    if high >= MAX_COMPOSE_NUM then
      break
    end
    high = high * 2
  end
  while low < high do
    local mid = math.floor((low + high + 1) / 2)
    if self:canComposeNew(itemId, mid) then
      low = mid
    else
      high = mid - 1
    end
  end
  return low
end

function this:getNormalComposeNum(itemId)
  local composeTpl = _talentRuneComposeTpl:getTplById(itemId)
  if not composeTpl then
    return 0
  end
  local items = _talentRuneComposeTpl:getItems(composeTpl)
  local num = 0
  for _, item in ipairs(items) do
    local makeNum = math.floor(C_BagMgr:getItemNumByItemId(item[2]) / item[3])
    if num == 0 or num > makeNum then
      num = makeNum
    end
  end
  return math.min(num, MAX_COMPOSE_NUM)
end

function this:isRuneItem(itemId)
  local itemType = L_ItemTplManager.getItemSmallType(L_Const.resType.commonItem, itemId)
  if itemType == nil or type(itemType) ~= "number" then
    return false
  end
  return itemType == 424
end

return this
