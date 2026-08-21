local BuildCsv = require("csvdata.farm_building")
local FarmRes = "ui/farm/main/"
local UpLevelRes = "ui/farm/upLevel/"
local KitchenRes = "ui/kitchen/cook/"
local jobRes = "ui/hero/job/"
local uiData = {
  csbFile = "ui/farm/BuildUpLevelLayer.csb",
  popup = true,
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    build = "mainBg/build",
    node1 = "mainBg/node1",
    node2 = "mainBg/node2",
    evoBtn = "mainBg/evoBtn"
  }
}
local funcData = {
  [1] = {
    icon = "store.png",
    callback = function(self)
      self:showStore()
    end
  },
  [2] = {
    icon = "plant.png",
    callback = function(self)
      self:showPlant()
    end
  },
  [3] = {
    icon = "house.png",
    callback = function(self)
      self:showHouse()
    end
  },
  [5] = {
    icon = "collect.png",
    callback = function(self)
      self:showCollent()
    end
  },
  [6] = {
    icon = "trade.png",
    callback = function(self)
      self:showTrade()
    end
  },
  [7] = {
    icon = "box.png",
    callback = function(self)
      self:showBox()
    end
  },
  [9] = {
    icon = "maoxian.png",
    callback = function(self)
      self:showMaoXian()
    end
  }
}
local BuildUpLevelLayer = class("BuildUpLevelLayer", UIBase)

function BuildUpLevelLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BuildUpLevelLayer:init(params)
  self.evoBtn:setTouchScale()
end

function BuildUpLevelLayer:showData(params)
  self.build:removeAllChildren()
  self.node1:removeAllChildren()
  self.node2:removeAllChildren()
  local index = params.index or 1
  self.farmData = game.role.farmData
  self.image = funcData[index].icon
  funcData[index].callback(self)
end

function BuildUpLevelLayer:showStore()
  local level = self.farmData.level3
  local storeData = BuildCsv[3][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = storeData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  display.newTTFLabel({
    text = "资源携带上限:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, 0):addTo(self.node1)
  display.newTTFLabel({
    text = storeData.carry,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(140, 0):addTo(self.node1)
  display.newTTFLabel({
    text = "资源暂存上限:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -35):addTo(self.node1)
  display.newTTFLabel({
    text = storeData.storage,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(140, -35):addTo(self.node1)
  display.newTTFLabel({
    text = "银币存储上限:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -70):addTo(self.node1)
  display.newTTFLabel({
    text = storeData.silver,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(140, -70):addTo(self.node1)
  for i = 1, 3 do
    display.newSprite(UpLevelRes .. "line.png"):anch(0, 0.5):pos(15, -15 + (i - 1) * -35):addTo(self.node1)
  end
  if level == #BuildCsv[3] then
    display.newTTFLabel({
      text = storeData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  for i = 1, 3 do
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(205, (i - 1) * -35):addTo(self.node1)
  end
  local nextData = BuildCsv[3][level + 1]
  display.newTTFLabel({
    text = nextData.carry,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(235, 0):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.storage,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(235, -35):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.silver,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(235, -70):addTo(self.node1)
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < storeData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, storeData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = storeData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = storeData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < storeData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 3}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 1})
    end)
  end)
end

function BuildUpLevelLayer:showPlant()
  local level = self.farmData.level4
  local plantData = BuildCsv[4][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = plantData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  display.newTTFLabel({
    text = "解锁土地:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, 0):addTo(self.node1)
  display.newTTFLabel({
    text = plantData.land,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(195, 0):addTo(self.node1)
  display.newTTFLabel({
    text = "种植时间缩短:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -35):addTo(self.node1)
  display.newTTFLabel({
    text = plantData.timeUp * 100 .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(195, -35):addTo(self.node1)
  display.newTTFLabel({
    text = "稀有食材概率提升:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -70):addTo(self.node1)
  display.newTTFLabel({
    text = plantData.srUp .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(195, -70):addTo(self.node1)
  display.newTTFLabel({
    text = "超稀有食材概率提升:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -105):addTo(self.node1)
  display.newTTFLabel({
    text = plantData.ssrUp .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(195, -105):addTo(self.node1)
  for i = 1, 4 do
    display.newSprite(UpLevelRes .. "line.png"):anch(0, 0.5):pos(15, -15 + (i - 1) * -35):addTo(self.node1)
  end
  if level == #BuildCsv[4] then
    display.newTTFLabel({
      text = plantData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  for i = 1, 4 do
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(235, (i - 1) * -35):addTo(self.node1)
  end
  local nextData = BuildCsv[4][level + 1]
  display.newTTFLabel({
    text = nextData.land,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(265, 0):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.timeUp * 100 .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(265, -35):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.srUp .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(265, -70):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.ssrUp .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(265, -105):addTo(self.node1)
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < plantData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, plantData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = plantData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = plantData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < plantData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 4}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 2})
    end)
  end)
end

function BuildUpLevelLayer:showHouse()
  local level = self.farmData.level1
  local houseData = BuildCsv[1][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = houseData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  display.newTTFLabel({
    text = "建筑等级开放至",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, 0):addTo(self.node1)
  display.newTTFLabel({
    text = "Lv" .. houseData.levelOpen,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(190, 0):addTo(self.node1)
  display.newSprite(UpLevelRes .. "line.png"):anch(0, 0.5):pos(15, -15):addTo(self.node1)
  if level == #BuildCsv[1] then
    display.newTTFLabel({
      text = houseData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(230, 0):addTo(self.node1)
  local nextData = BuildCsv[1][level + 1]
  display.newTTFLabel({
    text = "Lv" .. nextData.levelOpen,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(260, 0):addTo(self.node1)
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < houseData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, houseData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local enough = game.role.level < houseData.roleLevel
  display.newTTFLabel({
    text = houseData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_ROLE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < houseData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 1}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 3})
    end)
  end)
end

function BuildUpLevelLayer:showBox()
  local level = self.farmData.level6 or 1
  local boxData = BuildCsv[6][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = boxData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  display.newTTFLabel({
    text = "所有便当盒横向宽度" .. boxData.boxX,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(10, 0):addTo(self.node1)
  for i = 1, 1 do
    display.newSprite(UpLevelRes .. "line.png"):anch(0, 0.5):pos(15, -15 + (i - 1) * -35):addTo(self.node1)
  end
  if level == #BuildCsv[6] then
    display.newTTFLabel({
      text = boxData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  for i = 1, 1 do
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(235, (i - 1) * -35):addTo(self.node1)
  end
  local nextData = BuildCsv[6][level + 1]
  display.newTTFLabel({
    text = nextData.boxX,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(265, 0):addTo(self.node1)
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({type = 5, showTip = true}):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.diamond
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < boxData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, boxData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = boxData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = boxData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < boxData.starCost then
      SysError(SYS_ERR_DIAMOND_SHORTAGE)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 6}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 7})
    end)
  end)
end

function BuildUpLevelLayer:showCollent()
  local level = self.farmData.level2
  local collentData = BuildCsv[2][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = collentData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  local speeds = collentData.speed:toNumMap()
  for i = 1, 4 do
    local yPos = -(i - 1) * 38 - 5
    display.newSprite(KitchenRes .. string.format("material%d.png", i)):scale(0.3):pos(25, yPos):addTo(self.node1)
    local bg = display.newSprite(UpLevelRes .. "time_bg.png"):pos(95, yPos):addTo(self.node1)
    display.newTTFLabel({
      text = string.format("%d/小时", math.floor(3600 / speeds[i])),
      size = 16,
      color = UIHelper.hex2rgb("#8c4c17")
    }):pos(52, 17):addTo(bg)
  end
  if level == #BuildCsv[2] then
    display.newTTFLabel({
      text = collentData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  local speeds = BuildCsv[2][level + 1].speed:toNumMap()
  for i = 1, 4 do
    local yPos = -(i - 1) * 38 - 5
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(155, yPos):addTo(self.node1)
    local bg = display.newSprite(UpLevelRes .. "time_bg.png"):pos(235, yPos):addTo(self.node1)
    display.newTTFLabel({
      text = string.format("%d/小时", math.floor(3600 / speeds[i])),
      size = 16,
      color = UIHelper.hex2rgb("#8c4c17")
    }):pos(52, 17):addTo(bg)
  end
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < collentData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, collentData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = collentData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = collentData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < collentData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 2}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 5})
    end)
  end)
end

function BuildUpLevelLayer:showMaoXian()
  local level = self.farmData.level7 or 1
  local csvIndex = 7
  local collentData = BuildCsv[csvIndex][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = collentData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  local speeds = collentData.speed:toNumMap()
  local list = ccui.ListView:create()
  list:size(cc.size(300, 150))
  list:setInnerContainerSize(cc.size(300, 140))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(0, -135):addTo(self.node1)
  local viewList = {}
  for i = 1, 6 do
    local viewNode = ccui.Widget:create()
    viewNode:size(cc.size(300, 34)):addTo(list)
    display.newSprite(jobRes .. string.format("expBook_%d.png", i)):scale(0.3):pos(25, 15):addTo(viewNode)
    local bg = display.newSprite(UpLevelRes .. "time_bg.png"):pos(95, 15):addTo(viewNode)
    display.newTTFLabel({
      text = string.format("%.2f/小时", 3600 / speeds[i]),
      size = 16,
      color = UIHelper.hex2rgb("#8c4c17")
    }):pos(52, 17):addTo(bg)
    viewList[i] = viewNode
  end
  if level == #BuildCsv[csvIndex] then
    display.newTTFLabel({
      text = collentData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  local speeds = BuildCsv[csvIndex][level + 1].speed:toNumMap()
  for i = 1, 6 do
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(155, 15):addTo(viewList[i])
    local bg = display.newSprite(UpLevelRes .. "time_bg.png"):pos(235, 15):addTo(viewList[i])
    display.newTTFLabel({
      text = string.format("%.2f/小时", 3600 / speeds[i]),
      size = 16,
      color = UIHelper.hex2rgb("#8c4c17")
    }):pos(52, 17):addTo(bg)
  end
  list:doLayout()
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingMaoXianUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingMaoXianUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < collentData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, collentData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = collentData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = collentData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < collentData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = csvIndex}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 9})
    end)
  end)
end

function BuildUpLevelLayer:showTrade()
  local level = self.farmData.level5
  local tradeData = BuildCsv[5][level]
  display.newSprite(FarmRes .. self.image):addTo(self.build)
  display.newTTFLabel({
    text = tradeData.name .. " Lv" .. level,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, 170):addTo(self.build)
  display.newTTFLabel({
    text = "寄售栏数量:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, 0):addTo(self.node1)
  display.newTTFLabel({
    text = tradeData.sellBox,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(200, 0):addTo(self.node1)
  display.newTTFLabel({
    text = "订单栏数量:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -35):addTo(self.node1)
  display.newTTFLabel({
    text = tradeData.buyBox,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(200, -35):addTo(self.node1)
  display.newTTFLabel({
    text = "购买订单折扣:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -70):addTo(self.node1)
  display.newTTFLabel({
    text = tradeData.buyOff .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(200, -70):addTo(self.node1)
  display.newTTFLabel({
    text = "寄售收入提升:",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(5, -105):addTo(self.node1)
  display.newTTFLabel({
    text = tradeData.taxOff .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(200, -105):addTo(self.node1)
  for i = 1, 4 do
    display.newSprite(UpLevelRes .. "line.png"):anch(0, 0.5):pos(15, -15 + (i - 1) * -35):addTo(self.node1)
  end
  if level == #BuildCsv[5] then
    display.newTTFLabel({
      text = tradeData.name .. "已经满级啦~",
      size = 18,
      color = UIHelper.hex2rgb("#2a9a10")
    }):pos(160, -50):addTo(self.node2)
    self.evoBtn:hide()
    return
  end
  for i = 1, 4 do
    display.newSprite(UpLevelRes .. "arrow.png"):anch(0, 0.5):pos(230, (i - 1) * -35):addTo(self.node1)
  end
  local nextData = BuildCsv[5][level + 1]
  display.newTTFLabel({
    text = nextData.sellBox,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(260, 0):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.buyBox,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(260, -35):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.buyOff .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(260, -70):addTo(self.node1)
  display.newTTFLabel({
    text = nextData.taxOff .. "%",
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(260, -105):addTo(self.node1)
  local sourceBg = display.newSprite(UpLevelRes .. "source_bg.png"):pos(90, -55):addTo(self.node2)
  ItemIcon.new({
    type = globalCsv.buildingUp,
    showTip = true
  }):scale(0.8):pos(44, 40):addTo(sourceBg)
  local num = game.role.items[globalCsv.buildingUp] or 0
  display.newTTFLabel({
    text = "需要\n材料",
    size = 16,
    color = UIHelper.hex2rgb(num < tradeData.starCost and "#f9651d" or "#2a9a10")
  }):pos(20, -55):addTo(self.node2)
  display.newTTFLabel({
    text = string.format("%d/%d", num, tradeData.starCost),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 15):addTo(sourceBg)
  local limits = tradeData.upLimit:toArray("=", true)
  local enough = self.farmData["level" .. limits[1]] < limits[2]
  display.newTTFLabel({
    text = tradeData.limitDesc,
    size = 16,
    color = UIHelper.hex2rgb(enough and "#f9651d" or "#2a9a10")
  }):anch(0, 0.5):pos(145, -55):addTo(self.node2)
  self.evoBtn:setCallback(function()
    if enough then
      SysError(SYS_ERR_FARM_HOUSE_LEVEL_NOT_ENOUGH)
      return
    end
    if num < tradeData.starCost then
      SysError(SYS_ERR_FARM_BUILD_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Farm_levelUpBuilding, MsgPack.pack({type = 5}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Farm_levelUpBuilding, function(event)
      UIHelper.removeWaiting()
      self:showSuccess()
      self:showData({index = 6})
    end)
  end)
end

function BuildUpLevelLayer:showSuccess()
  game:playMusic(1300)
  local bg = display.newSprite("ui/equip/fix/success_bg.png"):pos(568, 320):addTo(self)
  display.newSprite(UpLevelRes .. "success.png"):center(bg):addTo(bg)
  bg:setOpacity(0)
  bg:setCascadeOpacityEnabled(true)
  bg:runAction(transition.sequence({
    cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeIn:create(0.2)),
    cc.DelayTime:create(0.5),
    cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeOut:create(0.2)),
    cc.RemoveSelf:create()
  }))
end

return BuildUpLevelLayer
