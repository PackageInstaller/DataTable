local BuildingCsv = require("csvdata.farm_building")
local PlantRes = "ui/farm/plant/"
local uiData = {
  csbFile = "ui/farm/PlantManagersLayer.csb",
  mask = true,
  widgets = {
    center = "center",
    herosBg = "herosBg",
    list = "herosBg/list",
    node1 = "node1",
    node2 = "node2",
    node3 = "node3",
    node4 = "node4",
    node5 = "node5",
    node6 = "node6"
  }
}
local PlantManagersLayer = class("PlantManagersLayer", UIBase)

function PlantManagersLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PlantManagersLayer:init(params)
  TopBar:show(TopBarType.back)
  UIHelper.MoveToLeft({
    node = self.herosBg,
    time = 0.3
  })
  self.cellSize = display.newSprite("ui/global/item_bg.png"):getContentSize()
  self.maxNum = BuildingCsv[4][game.role.farmData.level4].land
  self.cards = {}
  self.types = {}
  self.choosed = {}
  self.curHero = 0
  self.selected = 0
  self.plantData = json.decode(game.role.farmData.buildList)
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
      local now = socket:gettime()
      if not self.lastTime then
        self.lastTime = now
      end
      if now - self.lastTime > 0.4 then
        self.lastTime = nil
        self.list:stopAutoScroll()
        return
      end
      self.lastTime = now
      self:loadPage(topRow + 1, bottomRow + 1)
    end
  end)
end

function PlantManagersLayer:showData(params)
  for index = 1, 6 do
    local root = self["node" .. index]
    local xPos, yPos = root:getPosition()
    local touch = UIHelper.newImageView(PlantRes .. "touch.png")
    touch:anch(0.5, 0.5):setRotation(-30):pos(xPos, yPos):scale(0.6):addTo(self.center)
    local image = index <= self.maxNum and "open.png" or "lock.png"
    local card = UIHelper.newImageView(PlantRes .. image):scale(0.6):pos(xPos, yPos):addTo(self.center)
    self.cards[index] = {
      card = card,
      root = root,
      touch = touch
    }
  end
  local land = 1
  self.center:runAction(cc.Repeat:create(transition.sequence({
    cc.DelayTime:create(0.02),
    cc.CallFunc:create(function()
      self:showCardDetail(land)
      land = land + 1
    end)
  }), 6))
  self:showHeros()
end

function PlantManagersLayer:showCardDetail(land)
  local card = self.cards[land].card
  local root = self.cards[land].root
  local touch = self.cards[land].touch
  local landInfo = self.plantData[tostring(land)]
  card:removeAllChildren()
  root:removeAllChildren()
  if self.selected == land then
    display.newSprite(PlantRes .. "select.png"):center(card):addTo(card)
  end
  local heroType = landInfo and landInfo.hero and landInfo.hero or false
  if heroType then
    FormatHead.new({type = heroType}):pos(-5, 30):addTo(root)
    local btn = UIHelper.newImageView(PlantRes .. "off.png"):pos(60, 65):addTo(root)
    btn:setCallback(function()
      game:sendData(actionCodes.Farm_changeFarmerRpc, MsgPack.pack({index = land, type = 0}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Farm_changeFarmerRpc, function(event)
        UIHelper.removeWaiting()
        self.plantData = json.decode(game.role.farmData.buildList)
        self:showCardDetail(land)
        self:cleanSelected(land)
        self.selected = land
        self:showHeros()
      end)
    end)
  elseif land <= self.maxNum then
    UIHelper.newImageView(PlantRes .. "add.png"):pos(0, 0):addTo(root)
  end
  touch:setCallback(function()
    if land > self.maxNum then
      return
    end
    self:cleanSelected(land)
    self.selected = land
    self:showHeros(heroType)
  end)
end

function PlantManagersLayer:cleanSelected(land)
  if self.selected ~= 0 then
    local orginCard = self.cards[self.selected].card
    orginCard:removeAllChildren()
  end
  if land > self.maxNum then
    return
  end
  local nowCard = self.cards[land].card
  display.newSprite(PlantRes .. "select.png"):center(nowCard):addTo(nowCard)
end

function PlantManagersLayer:showHeros(heroType)
  self.list:removeAllChildren()
  self.types = {}
  self.choosed = {}
  self.curHero = heroType or 0
  for _, data in pairs(json.decode(game.role.farmData.buildList)) do
    if data.hero then
      self.choosed[data.hero] = 1
    end
  end
  local temp = {}
  for _, hero in pairs(game.role.heros) do
    if not heroType and not temp[hero.type] and self.selected == 0 then
      table.insert(self.types, hero.type)
      temp[hero.type] = 1
    elseif not temp[hero.type] and (not self.choosed[hero.type] or self.choosed[hero.type] and heroType == hero.type) then
      table.insert(self.types, hero.type)
      temp[hero.type] = 1
    end
  end
  table.sort(self.types, function(a, b)
    return a < b
  end)
  self:refreshContent()
end

function PlantManagersLayer:refreshContent()
  self.list:removeAllChildren()
  self.rowViews = {}
  self.rowLoaded = {}
  local nodeSize = cc.size(self.list:getContentSize().width, self.cellSize.height + 6)
  for row = 1, math.ceil(#self.types / 4) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 4)
end

function PlantManagersLayer:loadPage(topRow, buttomRow)
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
    end
  end
end

function PlantManagersLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.types then
      local col = index - (row - 1) * colCount
      local Icon = HeroHead.new({
        type = self.types[index]
      })
      Icon:anch(0, 0):pos(5 + (self.cellSize.width + 6) * (col - 1), 0):addTo(viewNode)
      Icon:setCallback(function()
        if self.selected == 0 then
          SysError(SYS_ERR_FARM_CHOOSE_LAND)
          return
        end
        if self.curHero == self.types[index] then
          return
        end
        game:sendData(actionCodes.Farm_changeFarmerRpc, MsgPack.pack({
          index = self.selected,
          type = self.types[index]
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Farm_changeFarmerRpc, function(event)
          UIHelper.removeWaiting()
          self.plantData = json.decode(game.role.farmData.buildList)
          self:showCardDetail(self.selected)
          if not tolua.isnull(self.iconSelect) then
            self.iconSelect:removeFromParent()
            self.iconSelect = nil
          end
          self.curHero = self.types[index]
          self.iconSelect = display.newSprite(PlantRes .. "manager.png"):pos(47, 14):addTo(Icon)
        end)
      end)
      if self.choosed[self.types[index]] then
        self.iconSelect = display.newSprite(PlantRes .. "manager.png"):pos(47, 14):addTo(Icon)
      end
    end
  end
  self.rowLoaded[row] = true
end

return PlantManagersLayer
