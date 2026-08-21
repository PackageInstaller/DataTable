_class("HomelandWishingConst", Object)
HomelandWishingConst = HomelandWishingConst

function HomelandWishingConst:Constructor()
end

function HomelandWishingConst.IsCoinCollected(id)
  local collectCoins = HomelandWishingConst.GetCollectedCoins()
  for i = 1, #collectCoins do
    if collectCoins[i] == id then
      return true
    end
  end
  return false
end

function HomelandWishingConst.CanCollectCoin(id)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(id)
  if items == nil or table.count(items) <= 0 then
    return false
  end
  return true
end

function HomelandWishingConst.GetCollectCoinCounts()
  return table.count(HomelandWishingConst.GetCollectedCoins())
end

function HomelandWishingConst.GetCollectedCoins()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  return homelandModule:GetWishingCoinList()
end

function HomelandWishingConst.GetDefaultCoinIcon()
  return "icon_item_default_coin_icon"
end

function HomelandWishingConst.GetDefaultCoinGetWay()
  return StringTable.Get("str_homeland_collect_coin_item_getway_empty")
end

function HomelandWishingConst.GetDefaultCoinGetWayIcon()
  return "collect_default_getway_icon"
end

function HomelandWishingConst.GetDefaultCoinDes()
  return StringTable.Get("str_homeland_collect_coin_item_des_empty")
end

function HomelandWishingConst.GetDefaultCoinfName()
  return StringTable.Get("str_homeland_collect_coin_item_name_empty")
end

function HomelandWishingConst.Destroy()
  HomelandWishingConst.fish_in_wishing = nil
  HomelandWishingConst.FishInstanceId = nil
end

function HomelandWishingConst.GetRaiseFishList()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  if HomelandWishingConst.fish_in_wishing == nil or HomelandWishingConst.fish_in_wishing[pstId] == nil then
    HomelandWishingConst.ForceUpdateRaiseFishData()
  end
  return HomelandWishingConst.fish_in_wishing[pstId]
end

function HomelandWishingConst.ForceUpdateRaiseFishData()
  if not HomelandWishingConst.fish_in_wishing then
    HomelandWishingConst.fish_in_wishing = {}
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local t = {}
  HomelandWishingConst.fish_in_wishing[pstId] = t
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local itemModule = GameGlobal.GetModule(ItemModule)
  HomelandWishingConst.FishInstanceId = 0
  local fishs = homelandModule:GetFishsInWishingBuilding()
  for k, v in pairs(fishs) do
    local items = itemModule:GetItemByTempId(k)
    for i = 1, v do
      local t1 = {}
      t1.ID = k
      t1.InstanceId = HomelandWishingConst.GenFishInstanceId()
      t[#t + 1] = t1
    end
  end
end

function HomelandWishingConst.GenFishInstanceId()
  if not HomelandWishingConst.FishInstanceId then
    HomelandWishingConst.FishInstanceId = 0
    return HomelandWishingConst.FishInstanceId
  end
  local raisList = HomelandWishingConst.GetRaiseFishList()
  while true do
    HomelandWishingConst.FishInstanceId = HomelandWishingConst.FishInstanceId + 1
    local find = false
    for i = 1, #raisList do
      if raisList[i].InstanceId == HomelandWishingConst.FishInstanceId then
        find = true
      end
    end
    if find == false then
      break
    end
  end
  return HomelandWishingConst.FishInstanceId
end

function HomelandWishingConst.RaiseFish(id, instanceId)
  local raisList = HomelandWishingConst.GetRaiseFishList()
  for i = 1, #raisList do
    if raisList[i].InstanceId == instanceId and raisList[i].ID == id then
      return
    end
  end
  local t = {}
  t.ID = id
  t.InstanceId = instanceId
  raisList[#raisList + 1] = t
end

function HomelandWishingConst.UnRaiseFish(id, instanceId)
  local raisList = HomelandWishingConst.GetRaiseFishList()
  for i = 1, #raisList do
    if raisList[i].InstanceId == instanceId and raisList[i].ID == id then
      table.remove(raisList, i)
      return
    end
  end
end

function HomelandWishingConst.GetRemainFishList()
  local fishInWishing = HomelandWishingConst.GetRaiseFishList()
  
  local function getWishingFishCount(id)
    local count = 0
    for i = 1, #fishInWishing do
      if fishInWishing[i].ID == id then
        count = count + 1
      end
    end
    return count
  end
  
  local result = {}
  local raiseFishList = HomelandWishingConst.GetRaiseFishList()
  local aquariumFishList = HomelandWishingConst.GetAquariumFishList()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemListBySubType(ItemSubType.ItemSubType_Fish)
  for k, v in pairs(items) do
    local cfg = Cfg.cfg_item_homeland_fish[v:GetTemplateID()]
    if cfg and cfg.Type == 2 then
      local t = {}
      t.ID = v:GetTemplateID()
      t.Count = v:GetCount()
      for i = 1, #raiseFishList do
        if t.ID == raiseFishList[i].ID then
          t.Count = t.Count - 1
        end
      end
      for buildPstId, fishs in pairs(aquariumFishList) do
        for i = 1, #fishs do
          if t.ID == fishs[i].ID then
            t.Count = t.Count - 1
          end
        end
      end
      if t.Count > 0 then
        result[#result + 1] = t
      end
    end
  end
  return result
end

function HomelandWishingConst.GetMaxRaiseFishCount()
  local cfg = Cfg.cfg_homeland_global.WishingPoolMaxFishNum
  return cfg.IntValue
end

function HomelandWishingConst.GetAquariumFishList()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  if HomelandWishingConst.fish_in_aquarium == nil or HomelandWishingConst.fish_in_aquarium[pstId] == nil then
    HomelandWishingConst.ForceUpdateAquariumFishData()
  end
  return HomelandWishingConst.fish_in_aquarium[pstId]
end

function HomelandWishingConst.GetCurAquariumFishList(buildPstID)
  local aquariumFishList = HomelandWishingConst.GetAquariumFishList()
  return aquariumFishList[buildPstID] or {}
end

function HomelandWishingConst.DeleteAquariumFish(buildPstID)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  HomelandWishingConst.fish_in_aquarium[pstId][buildPstID] = {}
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  homelandModule:DeleteFishTankData(buildPstID)
end

function HomelandWishingConst.ForceUpdateAquariumFishData()
  if not HomelandWishingConst.fish_in_aquarium then
    HomelandWishingConst.fish_in_aquarium = {}
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule then
    return
  end
  local pstId = roleModule:GetPstId()
  local t = {}
  HomelandWishingConst.fish_in_aquarium[pstId] = t
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local itemModule = GameGlobal.GetModule(ItemModule)
  HomelandWishingConst.AquariumFishInstanceId = 0
  local fishMapList = homelandModule:GetFishsInAquarium()
  for buildPstID, fishs in pairs(fishMapList) do
    for k, v in pairs(fishs) do
      local items = itemModule:GetItemByTempId(k)
      for i = 1, v do
        local fish = {}
        fish.ID = k
        fish.InstanceId = HomelandWishingConst.GenAquariumFishInstanceId(buildPstID)
        if not t[buildPstID] then
          t[buildPstID] = {}
        end
        t[buildPstID][#t[buildPstID] + 1] = fish
      end
    end
  end
end

function HomelandWishingConst.GenAquariumFishInstanceId(buildPstID)
  if not HomelandWishingConst.AquariumFishInstanceId then
    HomelandWishingConst.AquariumFishInstanceId = 0
    return HomelandWishingConst.AquariumFishInstanceId
  end
  local raisList = HomelandWishingConst.GetCurAquariumFishList(buildPstID)
  while true do
    HomelandWishingConst.AquariumFishInstanceId = HomelandWishingConst.AquariumFishInstanceId + 1
    local find = false
    for i = 1, #raisList do
      if raisList[i].InstanceId == HomelandWishingConst.AquariumFishInstanceId then
        find = true
      end
    end
    if find == false then
      break
    end
  end
  return HomelandWishingConst.AquariumFishInstanceId
end

function HomelandWishingConst.AddAquariumFish(buildPstID, id, instanceId)
  local raisList = HomelandWishingConst.GetCurAquariumFishList(buildPstID)
  for i = 1, #raisList do
    if raisList[i].InstanceId == instanceId and raisList[i].ID == id then
      return
    end
  end
  local t = {}
  t.ID = id
  t.InstanceId = instanceId
  raisList[#raisList + 1] = t
end

function HomelandWishingConst.RemoveAquariumFish(buildPstID, id, instanceId)
  local raisList = HomelandWishingConst.GetCurAquariumFishList(buildPstID)
  for i = 1, #raisList do
    if raisList[i].InstanceId == instanceId and raisList[i].ID == id then
      table.remove(raisList, i)
      return
    end
  end
end
