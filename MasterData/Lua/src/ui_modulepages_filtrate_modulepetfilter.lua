local module = class("modulePetFilter", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local raceFilter = {}
local elementFilter = {}
local rideFilter = {}
local wordsData = wordsTpl:getAllData()
local ELEMENT = {
  wordsTpl:getTplById("info_res_none"),
  wordsTpl:getTplById("info_res_water"),
  wordsTpl:getTplById("info_res_fire"),
  wordsTpl:getTplById("info_res_wind"),
  wordsTpl:getTplById("info_res_thunder"),
  wordsTpl:getTplById("info_res_land"),
  wordsTpl:getTplById("info_res_wood"),
  wordsTpl:getTplById("info_res_ice"),
  wordsTpl:getTplById("info_res_light"),
  wordsTpl:getTplById("info_res_dark")
}
local rideType = {
  [1] = "ui_challenge_07",
  [2] = "ui_challenge_08"
}

function module.bind()
  return {
    mainPanel = true,
    chooseFilterPanel = false,
    elementItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    },
    raceFilterItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    },
    rideFilterItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    },
    raceItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    }
  }
end

function module.methods()
  return {
    closeOnClick = function(self)
      self.closeModule()
    end,
    affirmOnClick = function(self)
      self:filtrateCondition()
      local result = {}
      if not self:checkIsEmpty() then
        result = self.filterData
      end
      self.filtrate(result)
      self.closeModule()
    end,
    resetOnClick = function(self)
      self:resetSet()
    end,
    choose_FilterClick = function(self)
      self:switchPanel(2)
    end,
    close_FilterClick = function(self)
      self:switchPanel(1)
    end,
    reset_FilterClick = function(self)
      self:resetRaceItemList()
      self:switchPanel(1)
    end,
    affirm_FilterClick = function(self)
      self:initRaceItemList()
      self:switchPanel(1)
    end
  }
end

function module:initModule(option)
  self.closeModule = option.closeCurModule
  self.filtrate = option.filter
  self:initFilter()
  self.filterData = {}
end

function module:checkIsEmpty()
  local isEmpty = true
  if self.filterData then
    if self.filterData.elementFilter and not table.isEmpty(self.filterData.elementFilter) then
      isEmpty = false
    end
    if self.filterData.raceFilter and not table.isEmpty(self.filterData.raceFilter) then
      isEmpty = false
    end
    if self.filterData.rideFilter and not table.isEmpty(self.filterData.rideFilter) then
      isEmpty = false
    end
  end
  return isEmpty
end

function module:filtrateCondition()
  self.filterData = {
    elementFilter = {},
    raceFilter = {},
    rideFilter = {}
  }
  for k = 1, #self.bind.elementItemList do
    if self.bind.elementItemList:getValue(k, "pitchOn") then
      table.insert(self.filterData.elementFilter, k)
    end
  end
  for k = 1, #self.bind.raceItemList do
    if self.bind.raceItemList:getValue(k, "pitchOn") then
      local id = self.bind.raceItemList:getValue(k, "id")
      table.insert(self.filterData.raceFilter, id)
    end
  end
  for k = 1, #self.bind.rideFilterItemList do
    if self.bind.rideFilterItemList:getValue(k, "pitchOn") then
      local id = self.bind.rideFilterItemList:getValue(k, "id")
      table.insert(self.filterData.rideFilter, id)
    end
  end
end

function module:resetSet()
  self.filterData = {}
  for i = 1, #self.bind.elementItemList do
    self.bind.elementItemList:change(i, {pitchOn = false})
  end
  for i = 1, #self.bind.raceItemList do
    self.bind.raceItemList:change(i, {pitchOn = false})
  end
  for i = 1, #self.bind.rideFilterItemList do
    self.bind.rideFilterItemList:change(i, {pitchOn = false})
  end
end

function module:initFilter()
  for i, v in pairs(wordsData) do
    if string.match(i, "pet_races_") == "pet_races_" then
      local index = string.match(i, "%d+")
      raceFilter[tonumber(index)] = L_Config:provider(v)
    end
  end
  for i, v in pairs(wordsData) do
    if string.match(i, "pet_ele_") == "pet_ele_" then
      local index = string.match(i, "%d+")
      elementFilter[tonumber(index)] = L_Config:provider(v)
    end
  end
  for i, v in ipairs(rideType) do
    rideFilter[i] = L_WordsTpl:getValue(v)
  end
  self.bind.raceItemList:clear()
  local raceData = {}
  for k, v in ipairs(raceFilter) do
    table.insert(raceData, {
      name1 = v,
      name2 = v,
      id = k
    })
  end
  self.bind.raceItemList:insert_array(raceData)
  self.bind.elementItemList:clear()
  local elementData = {}
  for k, v in ipairs(elementFilter) do
    table.insert(elementData, {
      name1 = v,
      name2 = v,
      id = k
    })
  end
  self.bind.elementItemList:insert_array(elementData)
  self.bind.rideFilterItemList:clear()
  local rideData = {}
  for k, v in ipairs(rideFilter) do
    table.insert(rideData, {
      name1 = v,
      name2 = v,
      id = k
    })
  end
  self.bind.rideFilterItemList:insert_array(rideData)
end

function module:initRaceItemList()
end

function module:resetRaceItemList()
  for k = 1, #self.bind.raceFilterItemList do
    self.bind.raceFilterItemList:change(k, {pitchOn = false})
  end
  self:initRaceItemList()
end

function module:switchPanel(index)
end

return module
