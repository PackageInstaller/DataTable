local cityStoreDataModel = require("UICityStore/UICityStoreDataModel")
local DataModel = {}

local function init(id)
  local placeId = HomeStationStoreManager:GetCurStationPlace()
  local stationPlaceCA = PlayerData:GetFactoryData(placeId, "HomeStationPlaceFactory")
  DataModel.stationPlaceId = placeId
  DataModel.singeList = stationPlaceCA.keepSingleMealList
  DataModel.teamList = stationPlaceCA.keepTeamMealList
  DataModel.listPrefab = stationPlaceCA.listPrefab
  DataModel.bgmId = stationPlaceCA.bgm
  DataModel.stationId = id
  DataModel.selectIndex = nil
  DataModel.singleRoleId = nil
  DataModel.roleList = {count = 0}
  for k, v in pairs(PlayerData.ServerData.roles) do
    local t = {}
    t.id = k
    local unitCA = PlayerData:GetFactoryData(k, "UnitFactory")
    t.name = unitCA.name
    t.qualityInt = unitCA.qualityInt
    local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
    t.face = viewCA.face
    if 0 < unitCA.homeCharacter then
      table.insert(DataModel.roleList, t)
      DataModel.roleList.count = DataModel.roleList.count + 1
    end
  end
  local trustCfg = PlayerData:GetFactoryData(99900039)
  DataModel.trustExpList = trustCfg.trustExpList
  DataModel.teamRoleList = {count = 0}
  DataModel.RoleSort(0)
end

local function RoleSort(squadId)
  local squad
  if 0 < squadId then
    squad = {}
    DataModel.teamRoleList = {count = 0}
    local squadRole_list = PlayerData.ServerData.squad[squadId].role_list
    for k, v in pairs(squadRole_list) do
      if v.id then
        local isBuffOwned = PlayerData:GetCurStationStoreBuff(tostring(v.id), EnumDefine.HomeSkillEnum.AddTrust) ~= nil
        if not isBuffOwned then
          squad[tostring(v.id)] = k
          DataModel.teamRoleList[tostring(v.id)] = 1
          DataModel.teamRoleList.count = DataModel.teamRoleList.count + 1
        end
      end
    end
  elseif squadId == 0 then
    DataModel.teamRoleList = {count = 0}
  else
    return
  end
  table.sort(DataModel.roleList, function(t1, t2)
    local t1Buff = PlayerData:GetCurStationStoreBuff(tostring(t1.id), EnumDefine.HomeSkillEnum.AddTrust)
    local t2Buff = PlayerData:GetCurStationStoreBuff(tostring(t2.id), EnumDefine.HomeSkillEnum.AddTrust)
    if t1Buff ~= t2Buff then
      return t1Buff == nil and t2Buff ~= nil
    end
    if squad then
      local squadId1 = squad[t1.id] or 999
      local squadId2 = squad[t2.id] or 999
      if squadId1 ~= squadId2 then
        return squadId1 < squadId2
      end
    end
    if t1.qualityInt ~= t2.qualityInt then
      return t1.qualityInt > t2.qualityInt
    end
    return t1.id > t2.id
  end)
end

local function CreateNpcCharacterAnimGroup(idx, animList)
  local count = #animList
  local cbList = {}
  for j = count, 1, -1 do
    local cb = cbList[j + 1]
    cbList[j] = function()
      HomeStationStoreManager:NpcCharacterPlaySingle(idx, animList[j].name, false, cb)
    end
  end
  return cbList
end

local function CreateTempCharacterAnimGroup(idx, animList)
  local count = #animList
  local cbList = {}
  for j = count, 1, -1 do
    local cb = cbList[j + 1]
    cbList[j] = function()
      HomeStationStoreManager:TempCharacterPlaySingle(idx, animList[j].name, false, cb)
    end
  end
  return cbList
end

local function CreateGenerAnimGroup(animList, actList)
  local count = #animList
  local cbList = {}
  for j = count, 1, -1 do
    local cb, act
    if #actList >= count - j + 1 then
      function act()
        actList[count - j + 1]()
      end
    end
    if j == count then
      function cb()
        if act ~= nil then
          act()
        end
      end
    else
      function cb()
        if act ~= nil then
          act()
        end
        cbList[j + 1]()
      end
    end
    cbList[j] = function()
      HomeStationStoreManager:PlayGenerAni(animList[j].name, false, cb)
    end
  end
  return cbList
end

local function RefreshRoleInfo(mealId, selectRoleList)
  local trustExpList = PlayerData:GetFactoryData(99900039).trustExpList
  local roleList = {}
  local homeCharacterList = {}
  local mealCA = PlayerData:GetFactoryData(mealId)
  for k, v in pairs(selectRoleList) do
    local roleCA = PlayerData:GetFactoryData(v)
    if roleCA.homeCharacter > 0 then
      local homeCharacter = roleCA.homeCharacter
      if 0 < roleCA.stationStoreCharacter then
        homeCharacter = roleCA.stationStoreCharacter
      end
      table.insert(homeCharacterList, homeCharacter)
      local trustBuff = PlayerData:GetCurStationStoreBuff(v, EnumDefine.HomeSkillEnum.AddTrust)
      local addTrust = (trustBuff.param - 1) * 100
      local roleData = {
        roleId = v,
        add_trust = addTrust,
        lv_up = false
      }
      table.insert(roleList, roleData)
    end
  end
  local gender = PlayerData:GetUserInfo().gender or 1
  local homeCfg = PlayerData:GetFactoryData(99900014)
  local foodCount = #homeCharacterList
  table.insert(homeCharacterList, gender == 1 and homeCfg.conductorM or homeCfg.conductorW)
  local isOpen = false
  HomeStationStoreManager:SetFastFoodPath(mealCA.foodPrefab)
  HomeStationStoreManager:HideAll()
  PlayerData.foodTempRole = true
  HomeStationStoreManager:CreateRole(homeCharacterList)
  ChangeSkinUtil.InitHomeCaptainSpineSkin()
  ChangeSkinUtil.InitHomeCaptainSpineHairColor()
  PlayerData.foodTempRole = nil
  foodCount = 3 <= foodCount and 3 or foodCount
  local foodPath = mealCA.foodRes
  if foodPath ~= nil and foodPath ~= "" then
    HomeStationStoreManager:CreatFoodList(foodCount, foodPath)
  end
  local npcList = mealCA.npcList
  local npcIdList = {}
  local npcCallBackGroupList = {}
  for i = 1, #npcList do
    npcIdList[i] = npcList[i].npcId
    local aniCA = PlayerData:GetFactoryData(npcList[i].npcAni)
    if aniCA then
      npcCallBackGroupList[i] = CreateNpcCharacterAnimGroup(i, aniCA.animList)
    end
  end
  HomeStationStoreManager:CreateNPC(npcIdList)
  if mealCA.isPickFood then
    local jsonTable = {
      ["1"] = {
        ["1"] = {
          resPath = "Home/Drink/Dorm_daoju/Dorm_daoju_SkeletonData",
          targetSlotName = "handle01",
          targetAttachName = mealCA.foodName,
          replaceSlotName = "handle01",
          replaceAttachName = mealCA.foodName
        }
      }
    }
    HomeStationStoreManager:SetRolePickFood(Json.encode(jsonTable))
  end
  local performFurnitureList = mealCA.performFurnitureList
  local animGroupList = mealCA.playerAni
  local callBackGroupList = {}
  local mealBgm = mealCA.bgmPlay
  local stationPlaceBgm = -1
  if mealBgm and 0 < mealBgm then
    stationPlaceBgm = DataModel.bgmId
  end
  for i = 1, #animGroupList do
    local animList = PlayerData:GetFactoryData(animGroupList[i].animation).animList
    if i ~= #animGroupList and i < #homeCharacterList then
      callBackGroupList[i] = CreateTempCharacterAnimGroup(i, animList)
    else
      callBackGroupList[i] = CreateGenerAnimGroup(animList, {
        function()
          if not isOpen then
            cityStoreDataModel.SetForbidReturn(false)
            UIManager:ClosePanel(true, "UI/CityStore/StoreSkip")
            UIManager:Open(mealCA.foodSettlementPrefab, Json.encode({
              roleList = roleList,
              mealId = mealId,
              bgmId = stationPlaceBgm
            }))
            for i = 1, #performFurnitureList do
              HomeManager:SetFurnitureTL(performFurnitureList[i].furnitureId, performFurnitureList[i].normalPath)
              if performFurnitureList[i].isPerformEffect then
                HomeManager:SetFurnitureEffectVisible(true)
              end
            end
            isOpen = true
          end
        end,
        function()
          HomeStationStoreManager:ShowEffect(true)
          local sound = SoundManager:CreateSound(30001814)
          if sound ~= nil then
            sound:Play()
          end
        end
      })
    end
  end
  cityStoreDataModel.SetForbidReturn(true)
  for i = 1, #callBackGroupList do
    callBackGroupList[i][1]()
  end
  for i = 1, #npcCallBackGroupList do
    npcCallBackGroupList[i][1]()
  end
  for i = 1, #performFurnitureList do
    HomeManager:SetFurnitureTL(performFurnitureList[i].furnitureId, performFurnitureList[i].performPath)
    if performFurnitureList[i].isPerformEffect then
      HomeManager:SetFurnitureEffectVisible(false)
    end
  end
  if mealBgm and 0 < mealBgm then
    local sound = SoundManager:CreateSound(mealBgm)
    if sound ~= nil then
      sound:Play()
    end
  end
  UIManager:Open("UI/CityStore/StoreSkip")
  local skipDataModel = require("UIStoreSkip/UIStoreSkipDataModel")
  skipDataModel:SetCallBack(function()
    HomeStationStoreManager:PauseGenerAni()
    HomeStationStoreManager:TempCharacterPause()
    HomeStationStoreManager:NpcCharacterPause()
    if not isOpen then
      cityStoreDataModel.SetForbidReturn(false)
      UIManager:Open(mealCA.foodSettlementPrefab, Json.encode({
        roleList = roleList,
        mealId = mealId,
        bgmId = stationPlaceBgm
      }))
      for i = 1, #performFurnitureList do
        HomeManager:SetFurnitureTL(performFurnitureList[i].furnitureId, performFurnitureList[i].normalPath)
        if performFurnitureList[i].isPerformEffect then
          HomeManager:SetFurnitureEffectVisible(true)
        end
      end
      isOpen = true
    end
  end)
end

function DataModel:GetRoleIndex(id)
  for i = 1, #DataModel.roleList do
    if tonumber(id) == tonumber(DataModel.roleList[i].id) then
      return i
    end
  end
  return 999
end

DataModel.init = init
DataModel.RoleSort = RoleSort
DataModel.RefreshRoleInfo = RefreshRoleInfo
return DataModel
