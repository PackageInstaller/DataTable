local MaxChooseNum = 4
local Awaker_School_All = 0

local function _IsAwakerOpened(awakerCfg)
  if not awakerCfg then
    return false
  end
  return not awakerCfg.OpenDate or TimeUtils.GetServerTime() >= awakerCfg.OpenDate
end

local function createSocialPlayerChooseAwakerModelState(initData)
  local state = {}
  local singleChoose = initData and initData.singleChoose
  if nil == singleChoose then
    singleChoose = true
  end
  state.singleChoose = singleChoose
  state.allowEmpty = initData and initData.allowEmpty
  state.includeNotOwnedOpened = initData and initData.includeNotOwnedOpened == true
  
  function state.awakerMap()
    if not state.includeNotOwnedOpened then
      do return end
      return AwakerDataUtils.GetOwnedAwakerMap, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local ret = {}
    local awakerMap = AwakerDataUtils.GetAwakerDataMap() or {}
    for tid, awakerCfg in pairs(DT.AwakerConfig) do
      if _IsAwakerOpened(awakerCfg) then
        local awakerData = awakerMap[tid]
        if awakerData then
          ret[tid] = awakerData
        end
      end
    end
    return ret
  end
  
  function state.awakers()
    local map = {
      [Awaker_School_All] = {}
    }
    local awakerMap = state.awakerMap
    for tid, awakerData in pairs(awakerMap) do
      local awakerConfig = AwakerDataUtils.GetAwakerConfig(tid)
      if not awakerConfig then
      else
        if not map[awakerConfig.School] then
          map[awakerConfig.School] = {}
        end
        table.insert(map[awakerConfig.School], tid)
        table.insert(map[Awaker_School_All], tid)
      end
    end
    return map
  end
  
  state.maxChooseNum = state.singleChoose and 1 or MaxChooseNum
  state.showAwakers = {}
  local chosenAwakers = {}
  if initData and initData.chosenAwakers then
    for _, tid in ipairs(initData.chosenAwakers) do
      table.insert(chosenAwakers, tid)
    end
  end
  state.chooseAwakers = chosenAwakers
  state.currSchool = Awaker_School_All
  state.showSortType = false
  state.sortType = CommonDefine.AwakerSortType.Level
  state.sortOrder = CommonDefine.SortOrder.Descend
  
  function state.sortTypeList()
    local list = {}
    for _, typeValue in pairs(CommonDefine.AwakerSortType) do
      if nil == typeValue or type(typeValue) ~= "number" or state.teamType == CommonDefine.TeamType.Daily and typeValue == CommonDefine.AwakerSortType.Level then
      else
        local typeName = AwakerDataUtils.GetSortTypeTitle(typeValue)
        table.insert(list, {type = typeValue, name = typeName})
      end
    end
    table.sort(list, function(a, b)
      return a.type < b.type
    end)
    return list
  end
  
  return state
end

local function createSocialPlayerChooseAwakerModelViews(_)
  local views = {}
  
  function views:GetSchoolAll()
    return Awaker_School_All
  end
  
  function views:GetAwakerData(tid)
    if not tid then
      return
    end
    return self.awakerMap[tid]
  end
  
  function views:IsReachMax()
    local chooseNum = 0
    for _, tid in ipairs(self.chooseAwakers) do
      if tid and tid > 0 then
        chooseNum = chooseNum + 1
      end
    end
    return chooseNum >= self.maxChooseNum
  end
  
  function views:CheckChosenAwakerForm(tid)
    if not tid then
      return false
    end
    local hasOriginType = AwakerDataUtils.HasOriginType(tid)
    if not hasOriginType then
      return true
    end
    if self.chooseAwakers and #self.chooseAwakers <= 0 then
      return true
    end
    local changeFormAwakerTid = AwakerDataUtils.GetChangerForm(tid)
    if changeFormAwakerTid and table.contains(self.chooseAwakers, changeFormAwakerTid) then
      return false
    end
    return true
  end
  
  return views
end

local function createSocialPlayerChooseAwakerModelActions(_)
  local actions = {}
  
  function actions:AddChosenAwaker(tid)
    if self.singleChoose then
      self.chooseAwakers[1] = tid
      return true
    end
    local listNum = math.min(#self.chooseAwakers, self.maxChooseNum)
    if listNum < self.maxChooseNum then
      table.insert(self.chooseAwakers, tid)
      return true
    else
      return false
    end
  end
  
  function actions:RemoveChosenAwaker(tid)
    if not tid then
      return
    end
    local removeIndex
    for index, _tid in ipairs(self.chooseAwakers) do
      if _tid == tid then
        removeIndex = index
        break
      end
    end
    if removeIndex then
      table.remove(self.chooseAwakers, removeIndex)
    end
  end
  
  function actions:SetShowAwakersBySchool(school)
    if not school then
      return
    end
    self.showAwakers = self.awakers[school] or {}
  end
  
  function actions:SortShowAwakers()
    if not self.showAwakers or #self.showAwakers <= 1 then
      return
    end
    local curBuildingAwakerWeightMap = {}
    local curBuildingAwakerTidList = {}
    for key, tid in pairs(self.chooseAwakers) do
      if 0 == tid then
      else
        table.insert(curBuildingAwakerTidList, tid)
        curBuildingAwakerWeightMap[tid] = key
      end
    end
    local curBuildingAwakerDataList = {}
    local notBuildingAwakerDataList = {}
    for _, tid in pairs(self.showAwakers) do
      if table.contains(self.chooseAwakers, tid) then
        table.insert(curBuildingAwakerDataList, self:GetAwakerData(tid))
      else
        table.insert(notBuildingAwakerDataList, self:GetAwakerData(tid))
      end
    end
    table.sort(curBuildingAwakerDataList, function(a, b)
      local aWeight = curBuildingAwakerWeightMap[a.tid] or 100
      local bWeight = curBuildingAwakerWeightMap[b.tid] or 100
      return aWeight < bWeight
    end)
    notBuildingAwakerDataList = AwakerDataUtils.Sort(notBuildingAwakerDataList, self.sortOrder, self.sortType)
    local rst = {}
    for _, data in ipairs(curBuildingAwakerDataList) do
      table.insert(rst, data)
    end
    for _, data in ipairs(notBuildingAwakerDataList) do
      table.insert(rst, data)
    end
    for i = 1, #rst do
      self.showAwakers[i] = rst[i].tid
    end
  end
  
  function actions:SetCurrSchool(school)
    if not school then
      return
    end
    self.currSchool = school
  end
  
  function actions:SetShowSortType(show)
    self.showSortType = show
  end
  
  function actions:SetSortType(sortType)
    self.sortType = sortType
  end
  
  function actions:SetSortOrder(sortOrder)
    self.sortOrder = sortOrder
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, schoolType)
    if not schoolType then
      return
    end
    model:SetShowAwakersBySchool(schoolType)
    model:SortShowAwakers()
  end, function()
    return model.currSchool
  end)
end

local SocialPlayerChooseAwakerModel = Vue.model("SocialPlayerChooseAwakerModel", createSocialPlayerChooseAwakerModelState):views(createSocialPlayerChooseAwakerModelViews):actions(createSocialPlayerChooseAwakerModelActions):setup(onSetup)
return SocialPlayerChooseAwakerModel
