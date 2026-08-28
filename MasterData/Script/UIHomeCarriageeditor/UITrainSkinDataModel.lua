local DataModel = {
  curCoachData = nil,
  coachData = {},
  curSelectCoachIdx = 0,
  curSelectSkinTypeIdx = 0,
  curSelectSkinIdx = 0,
  lastShowSkinIdx = 0,
  cacheUsedSkin = {},
  tempCo = nil,
  skinTagSkinIds = {},
  newSkinDirty = false
}

function DataModel.InitTrainSkinData(ignoreSpecial)
  DataModel.curCoachData = nil
  DataModel.coachData = {}
  DataModel.cacheUsedSkin = {}
  DataModel.skinTagSkinIds = {}
  for i, uid in pairs(PlayerData:GetHomeInfo().coach_template) do
    local serverCoach = PlayerData:GetHomeInfo().coach_store[uid]
    local coachCA = PlayerData:GetFactoryData(serverCoach.id)
    local t = {}
    t.id = serverCoach.id
    t.uid = uid
    if serverCoach.name and serverCoach.name ~= "" then
      t.name = serverCoach.name
    else
      t.name = coachCA.name
    end
    local usedSkin = tonumber(serverCoach.skin)
    DataModel.cacheUsedSkin[i] = serverCoach.skin
    local unlockSkin = {}
    for j, skinId in pairs(serverCoach.skin_house) do
      unlockSkin[tonumber(skinId)] = true
    end
    local tempSkinTable = {}
    local unlockCount = 0
    t.usedTypeIdx = 1
    local defaultCfg = PlayerData:GetFactoryData(99900044)
    PlayerData.CurTrainSkinIsSpecial()
    for j, skinInfo in ipairs(coachCA.skinList) do
      local temp = {}
      local skinId = skinInfo.id
      local skinCA = PlayerData:GetFactoryData(skinId)
      temp.id = skinId
      temp.used = temp.id == usedSkin
      if temp.used then
        t.usedTypeIdx = skinInfo.num
      end
      temp.isUnlock = unlockSkin[skinInfo.id] ~= nil
      temp.idx = j
      if tempSkinTable[skinInfo.num] == nil then
        tempSkinTable[skinInfo.num] = {}
      end
      table.insert(tempSkinTable[skinInfo.num], temp)
      temp.study = skinCA.study
      if DataModel.skinTagSkinIds[skinCA.skinTag] == nil then
        DataModel.skinTagSkinIds[skinCA.skinTag] = {}
      end
      table.insert(DataModel.skinTagSkinIds[skinCA.skinTag], skinId)
      if 0 < skinCA.skinItem then
        temp.isUnlock = 0 < PlayerData:GetGoodsById(skinCA.skinItem).num
      end
      if ignoreSpecial then
        for k, v in pairs(defaultCfg.skinList) do
          if v.tag == skinCA.skinTag then
            temp.isUnlock = false
            break
          end
        end
      end
      if temp.isUnlock then
        unlockCount = unlockCount + 1
      end
    end
    t.unlockCount = unlockCount
    t.totalCount = #coachCA.skinList
    t.skins = tempSkinTable
    for j, skinTable in ipairs(tempSkinTable) do
      DataModel.SortSkinTable(skinTable)
    end
    table.insert(DataModel.coachData, t)
  end
end

function DataModel.SortSkinTable(skinTable)
  table.sort(skinTable, function(a, b)
    if a.used and not b.used then
      return true
    end
    if not a.used and b.used then
      return false
    end
    if a.isUnlock and not b.isUnlock then
      return true
    end
    if not a.isUnlock and b.isUnlock then
      return false
    end
    return a.idx < b.idx
  end)
end

function DataModel.CheckShowAllUse(skinInfo)
  local isShowAllUse = false
  if skinInfo.isUnlock then
    isShowAllUse = not skinInfo.used
    if not isShowAllUse then
      local skinCA = PlayerData:GetFactoryData(skinInfo.id)
      local tagSkinIds = DataModel.skinTagSkinIds[skinCA.skinTag]
      local cacheSameSkin = {}
      for i, v in ipairs(tagSkinIds) do
        cacheSameSkin[v] = 1
      end
      for i, v in ipairs(DataModel.coachData) do
        if i ~= DataModel.curSelectCoachIdx then
          local skinTable = v.skins[DataModel.curSelectSkinTypeIdx]
          for i1, tempSkinInfo in ipairs(skinTable) do
            if cacheSameSkin[tempSkinInfo.id] then
              if tempSkinInfo.isUnlock and not tempSkinInfo.used then
                isShowAllUse = true
              end
              break
            end
          end
        end
      end
    end
  end
  return isShowAllUse
end

return DataModel
