local AccessCsv = require("csvdata.diner_accessory")
local ItemCsv = require("csvdata.item")
local FilterLogic = import(".FilterAccessoryLogic")
local ChooseRes = "ui/diner/choose/"
local uiData = {
  csbFile = "ui/diner/ChooseAccessoryLayer.csb",
  popup = true,
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    list = "mainBg/listBg/list",
    count = "mainBg/countBg/count",
    exNode = "mainBg/exNode",
    btnOrder1 = "mainBg/btnOrder1",
    btnOrder2 = "mainBg/btnOrder2",
    btnOrder3 = "mainBg/btnOrder3"
  }
}
local orderData1 = {
  [1] = "全部",
  [2] = "动力炉",
  [3] = "零件",
  [4] = "外饰"
}
local orderData2 = {
  [1] = "稀有度排序",
  [2] = "等级排序"
}
local orderData3 = {
  [1] = "降序",
  [2] = "升序"
}
local orderRules2 = {
  [1] = "star",
  [2] = "level"
}
local orderRules3 = {
  [1] = "Desc",
  [2] = "Asc"
}
local ChooseAccessoryLayer = class("ChooseAccessoryLayer", UIBase)

function ChooseAccessoryLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseAccessoryLayer:init(params)
  self.ruleSort = params.rule or function()
    return false
  end
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose
  self.accessId = params.accessId
  self.desc = params.desc or "拥有配件: "
  self.layerType = params.layerType
  self.type = params.type
  self.unChooseList = {}
  self.chooseList = {}
  self.curChoose = params.curChoose or 0
  self.tempChoose = self.curChoose
  self.max = params.max or 20
  self.energy = params.energy
  self.recycle = params.recycle
  self.change = false
  self.dinerData = game.role.diner.diners[params.curDiner]
  self.index = params.index or 0
  for i = 1, 3 do
    local color = i == 1 and "#4f2a07" or "#054b6c"
    self["btnOrder" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb(color), 1)
    self["btnOrder" .. i]:setTouchScale()
  end
  if not UserData.accessFilter or game.role.majorGuideStep <= MAX_MAJOR_STEP then
    UserData.accessFilter = {}
  end
  if not UserData.accessFilter["1"] then
    UserData.accessFilter["1"] = {
      order1 = 1,
      order2 = 1,
      order3 = 1
    }
    UserData.accessFilter["2"] = {
      order1 = 1,
      order2 = 1,
      order3 = 1
    }
  end
  local orderData = UserData.accessFilter[tostring(self.layerType)]
  self.sortOrder1 = self.type and self.type + 1 or orderData.order1
  self.sortOrder2 = orderData.order2
  self.sortOrder3 = orderData.order3
  self.btnOrder2:setString({
    text = orderData2[self.sortOrder2],
    size = 20
  })
  self.btnOrder3:setString({
    text = orderData3[self.sortOrder3],
    size = 20
  })
  if self.layerType == 1 then
    self.btnOrder1:hide()
    self.btnOrder2:setPositionX(110)
    self.btnOrder3:setPositionX(242)
  else
    self.btnOrder1:setString({
      text = orderData1[self.sortOrder1],
      size = 20
    })
  end
  local rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
  self.accessFilter = FilterLogic.new({
    heros = game.role.diner.accessories,
    sortRule = rule
  })
  self.accessFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:setFilter({
    type = self.sortOrder1
  })
  self.btnOrder1:setCallback(function()
    self.change = true
    self.sortOrder1 = self.sortOrder1 + 1
    if self.sortOrder1 > #orderData1 then
      self.sortOrder1 = 1
    end
    self.btnOrder1:setString({
      text = orderData1[self.sortOrder1],
      size = 20
    })
    self:setFilter({
      type = self.sortOrder1
    })
  end)
  self.btnOrder2:setCallback(function(sender)
    self.change = true
    self.sortOrder2 = self.sortOrder2 + 1
    if self.sortOrder2 > #orderRules2 then
      self.sortOrder2 = 1
    end
    self.btnOrder2:setString({
      text = orderData2[self.sortOrder2],
      size = 20
    })
    rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
    self:setFilter({order = rule})
    orderData.order2 = self.sortOrder2
  end)
  self.btnOrder3:setCallback(function(sender)
    self.change = true
    self.sortOrder3 = self.sortOrder3 + 1
    if self.sortOrder3 > #orderRules3 then
      self.sortOrder3 = 1
    end
    self.btnOrder3:setString({
      text = orderData3[self.sortOrder3],
      size = 20
    })
    rule = orderRules2[self.sortOrder2] .. orderRules3[self.sortOrder3]
    self:setFilter({order = rule})
    orderData.order3 = self.sortOrder3
  end)
  if self.curChoose ~= 0 then
    self:showAccessDetail(self.curChoose)
  end
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
      self:loadPage(topRow + 1, bottomRow + 1)
    end
  end)
end

local cellSize = cc.size(112, 140)

function ChooseAccessoryLayer:refreshContent()
  self.list:removeAllChildren()
  self.access = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  local equips = self.accessFilter:getResult()
  if not self.multiChoose and self.accessId then
    table.insert(self.access, 0)
  end
  for index, equip in pairs(equips) do
    if self.ruleSort(equip) then
    elseif self.tempChoose == equip.id then
      table.insert(self.access, 1, equip.id)
    else
      table.insert(self.access, equip.id)
    end
  end
  self.rowViews = {}
  self.rowLoaded = {}
  local maxCount = #self.access
  self.count:setString(string.format("%s%d/%d", self.desc, maxCount - (self.accessId and 1 or 0), globalCsv.dinerAccNumInit))
  if maxCount == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    local desc = self.type == 3 and "没有可用外饰，主厨可以通过次元集市获取" or "没有可用配件，主厨可以通过邮购艇或次元集市获取"
    display.newTTFLabel({
      text = desc,
      size = 18,
      color = UIHelper.hex2rgb("#b26b31")
    }):center(viewNode):addTo(viewNode)
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(maxCount / 6) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function ChooseAccessoryLayer:loadPage(topRow, buttomRow)
  topRow = math.max(1, topRow)
  buttomRow = math.min(#self.rowViews, buttomRow)
  if topRow == buttomRow and topRow < #self.rowViews then
    return
  end
  local rows = {}
  for row = topRow, buttomRow do
    if not self.rowLoaded[row] then
      self:loadList(row)
    end
    rows[row] = true
  end
  for row, _ in pairs(self.rowLoaded) do
    if not rows[row] then
      self.rowLoaded[row] = nil
      self.rowViews[row]:removeAllChildren()
      if self.unChooseList[row] then
        self.unChooseList[row] = {}
      end
    end
  end
end

function ChooseAccessoryLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 6
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.access then
      local accessId = self.access[index]
      local col = index - (row - 1) * colCount
      local card = self:createCard(row, accessId, index)
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
    end
  end
  self.rowLoaded[row] = true
  if self.max then
    self:checkMax()
  end
end

function ChooseAccessoryLayer:createCard(curRow, tempId, index)
  local access = game.role.diner.accessories[tempId]
  local itemData = ItemCsv[AccessCsv[access.type].item]
  local card = AccessIcon.new({
    id = tempId,
    big = true,
    owner = self.dinerData:getAccessOwner(tempId),
    energy = self.energy,
    recycle = self.recycle
  })
  card:setCallback(function()
    if self.recycle then
      MTip:show({
        type = MTipType.acc,
        node = card,
        itemData = itemData,
        access = access
      })
    end
    self:choose(tempId, card)
  end)
  if self.chooseList[tempId] then
    local choose = display.newSprite(ChooseRes .. "image_choose.png"):pos(56, 78):addTo(card):name("choose")
  end
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  if self.tempChoose == 0 or self.tempChoose == tempId then
    self.tempChoose = tempId
    self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
    self:showAccessDetail(tempId)
  end
  self.unChooseList[curRow][tempId] = card
  return card
end

function ChooseAccessoryLayer:choose(accessId, card)
  self:cleanSelected()
  self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
  if not self.multiChoose then
    self:showAccessDetail(accessId)
    self.tempChoose = accessId
    return
  end
  if self.chooseList[accessId] then
    game:playMusic(1025)
    card:removeChildByName("choose")
    self.chooseList[accessId] = nil
  else
    local lock = card:getChildByName("lock")
    if lock then
      return
    end
    game:playMusic(1024)
    self.chooseList[accessId] = true
    display.newSprite(ChooseRes .. "image_choose.png"):pos(56, 78):addTo(card):name("choose")
  end
  self:showAccessDetail(accessId)
  if self.max then
    self:checkMax()
  end
end

function ChooseAccessoryLayer:setFilter(params)
  if params.order then
    self.accessFilter:orderByRule({
      rule = params.order
    })
  end
  if params.type then
    self.accessFilter:filterByType({
      type = params.type - 1
    })
  end
end

function ChooseAccessoryLayer:showAccessDetail(id)
  self.exNode:removeAllChildren()
  if self.layerType == 1 then
    game:loadView("diner.AccessoryDetailLayer").new({
      root = self.exNode,
      index = self.index,
      oriId = self.curChoose,
      curId = id,
      dinerId = self.dinerData.id,
      callback = function()
        self:setFilter({
          type = self.sortOrder1
        })
      end
    })
  else
    game:loadView("diner.AccessoryRecycleLayer").new({
      root = self.exNode,
      list = self.chooseList,
      max = self.max,
      callback = function()
        self.chooseCallback(self.chooseList, function()
          self.tempChoose = 0
          self:setFilter({
            type = self.sortOrder1
          })
          self:showAccessDetail()
        end)
      end
    })
  end
end

function ChooseAccessoryLayer:checkMax()
  local isFull = table.nums(self.chooseList) >= self.max
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local mask = card:getChildByName("lock")
        if not mask then
          mask = display.newSprite(ChooseRes .. "mask.png"):center(card):addTo(card):name("lock")
          local bg = display.newSprite(ChooseRes .. "text_bg.png"):pos(56, 78):addTo(mask)
          display.newTTFLabel({
            text = "选择达到上限",
            size = 14
          }):center(bg):addTo(bg)
        end
      else
        local mask = card:getChildByName("lock")
        if mask then
          mask:removeSelf()
        end
      end
    end
  end
end

function ChooseAccessoryLayer:cleanSelected()
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

function ChooseAccessoryLayer:onExit()
  if self.change then
    GameState.save(UserData)
  end
end

return ChooseAccessoryLayer
