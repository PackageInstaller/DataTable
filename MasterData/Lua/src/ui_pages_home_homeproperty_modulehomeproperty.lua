local this = class("moduleHomeProperty", G_UIModuleBase)
local _HomeBuffCountTpl = L_GameTpl:getHomeBuffCountTpl()
local _HomeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _HomeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _HomeBuildingProductTpl = L_GameTpl:getHomeBuildingProductionTpl()

function this.bind()
  return {
    active_btn_property = true,
    active_btn_property_sw = true,
    active_board = false,
    active_empty = false,
    list_property = {
      moduleName = "pages/home/homeProperty/cellHomeProperty"
    }
  }
end

function this.methods()
  return {
    onClickOpen = function(self)
      self.bind.active_board = true
      self.bind.active_empty = #self.bind.list_property <= 0
      L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
    end,
    onClickSWOpen = function(self)
      self.bind.active_board = true
      self.bind.active_empty = #self.bind.list_property <= 0
      L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
    end,
    onClickClose = function(self)
      self.bind.active_board = false
      self:closePropertyTips()
    end,
    onClickBack = function(self)
      self.bind.active_board = false
      self:closePropertyTips()
    end
  }
end

function this:ctor()
  self._conditionMap = {}
  this.super.ctor(self)
end

function this:open(options)
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen() or not L_DeviceTpl:getIsPc()
  self.bind.active_btn_property_sw = isSuperWidthScene
  self.bind.active_btn_property = not isSuperWidthScene
end

function this:setRanchBlock(blockId)
  local tpls = _HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.RANCH)
  local datas = {}
  self._conditionMap[L_HomeConst.buffConditionType.HOME_DROP_RACE] = table.keys(L_GameTpl:getPetRaceTpl().data)
  local blockRanchData = C_HomeManager:GetHomeStore():getBlockRanchData(blockId)
  local petGuid = blockRanchData and blockRanchData.harvest_pet or 0
  table.fill(datas, self:getShowList(tpls, petGuid))
  self:showProperties(datas)
end

function this:setCropBuild(buildGuid)
  local buildingData = C_HomeUtil.GetBuildData(buildGuid)
  local autoData = buildingData.auto
  self._conditionMap[L_HomeConst.buffConditionType.SEED_TYPE] = {}
  for i = 0, autoData.seeds.Count - 1 do
    local seedItem = autoData.seeds[i]
    local tpl = _HomeSeedTpl:getSeedTplByItem(seedItem.itemId)
    if tpl ~= nil then
      local type = _HomeSeedTpl:getCropType(tpl)
      if not table.containsValue(self._conditionMap[L_HomeConst.buffConditionType.SEED_TYPE], type) then
        table.insert(self._conditionMap[L_HomeConst.buffConditionType.SEED_TYPE], type)
      end
    end
  end
  table.sort(self._conditionMap[L_HomeConst.buffConditionType.SEED_TYPE])
  local datas = {}
  table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.PLANT), autoData.plantPetGuid))
  table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.WATER), autoData.waterPetGuid))
  table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.HARVEST), autoData.harvestPetGuid))
  self:showProperties(datas)
end

local CollectElementGroup = 12

function this:setCollection(collectionId)
  local serverData = C_HomeManager:GetHomeStore().WorldCollectModule:GetDataByBuildGuid(collectionId)
  local collectTpl = _HomeCollectionWorldTpl:getTplById(collectionId)
  local groupId = _HomeCollectionWorldTpl:getGroupId(collectTpl)
  self._conditionMap[L_HomeConst.buffConditionType.COLLECTION_GROUP] = {groupId}
  self._conditionMap[L_HomeConst.buffConditionType.HOME_DROP_ELEMENT] = table.keys(L_GameTpl:getElementTypeTpl().data)
  local petGuid = serverData.PetGuid
  local datas = {}
  table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.COLLECT), petGuid))
  if groupId == CollectElementGroup then
    table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.COLLECT_ELEMENT), petGuid))
  else
    table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.COLLECT_NO_ELEMENT), petGuid))
  end
  self:showProperties(datas)
end

local ProductElementType = 12

function this:setProduct(guid)
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleHomeProperty setProduct")
  local serverData = L_HomeStore:getHomeBuildingByGuid(guid)
  local buildType = C_HomeUtil.GetBuildingType(guid)
  local petGuid = serverData.station_pet_guid
  if buildType == L_Const.WorldMapBuildType.WMBT_HATCH then
    self._conditionMap[L_HomeConst.buffConditionType.PETEGG_ELEMENT] = table.keys(L_GameTpl:getElementTypeTpl().data)
    local tpls = _HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.HATCH)
    self:showProperties(self:getShowList(tpls, petGuid))
  else
    local buildingProTpl = _HomeBuildingProductTpl:getTplById(serverData.build_id)
    local productType = _HomeBuildingProductTpl:getType(buildingProTpl)
    self._conditionMap[L_HomeConst.buffConditionType.PRODUCT_TYPE] = {productType}
    self._conditionMap[L_HomeConst.buffConditionType.PRODUCT_ELEMENT] = table.keys(L_GameTpl:getElementTypeTpl().data)
    local datas = {}
    table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.PRODUCT), petGuid))
    if productType == ProductElementType then
      table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.PRODUCT_ELEMENT), petGuid))
    else
      table.fill(datas, self:getShowList(_HomeBuffCountTpl:getTplsByType(L_HomeConst.HomeBuffCountType.PRODUCT_NO_ELEMENT), petGuid))
    end
    self:showProperties(datas)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:getShowList(tpls, petGuid)
  local datas = {}
  for _, tpl in ipairs(tpls) do
    local buffId = _HomeBuffCountTpl:getBuffId(tpl)
    local conditionIds = _HomeBuffCountTpl:getCondition(tpl)
    if #conditionIds == 0 then
      local buff = L_HomeBuffManager:getBuff(buffId, nil, {petGuid = petGuid})
      if 0 < buff.buffValue or 0 < #buff.buffParams then
        table.insert(datas, {buff = buff, countTpl = tpl})
      end
    else
      do
        local conditionsMap = {}
        for i, conditionId in ipairs(conditionIds) do
          conditionsMap[i] = self._conditionMap[conditionId]
        end
        
        local function parseCondition(i, currConditionMap)
          for _, conditionTarget in ipairs(conditionsMap[i]) do
            local nextConditionMap = table.clone(currConditionMap)
            nextConditionMap[conditionIds[i]] = conditionTarget
            if conditionsMap[i + 1] then
              parseCondition(i + 1, nextConditionMap)
            else
              local buff = L_HomeBuffManager:getBuff(buffId, nextConditionMap, {petGuid = petGuid})
              if buff.buffValue > 0 or 0 < #buff.buffParams then
                table.insert(datas, {buff = buff, countTpl = tpl})
              end
            end
          end
        end
        
        parseCondition(1, {})
      end
    end
  end
  return datas
end

function this:showProperties(datas)
  self.bind.list_property:clear()
  self.bind.list_property:insert_array(datas)
end

function this:closePropertyTips()
  for i = 1, #self.bind.list_property do
    self.bind.list_property:getItemCls(i):onClosePropertyPanel()
  end
end

function this:close(options)
  self.bind.list_property:clear()
  self:closePropertyTips()
end

return this
