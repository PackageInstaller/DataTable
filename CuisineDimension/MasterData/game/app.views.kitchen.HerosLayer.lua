local FilterLogic = import("..hero.FilterLogic")
local heroRes = "ui/hero/"
local chooseRes = "ui/hero/choose/"
local uiData = {
  csbFile = "ui/kitchen/HerosLayer.csb",
  widgets = {
    list = "list",
    upBar = "upBar",
    panel = "panel",
    num = "panel/num",
    order1 = "panel/order1",
    order2 = "panel/order2",
    order3 = "panel/order3",
    typeBg = "panel/typeBg"
  }
}
local HerosLayer = class("HerosLayer", UIBase)

function HerosLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HerosLayer:init(params)
  UIHelper.MoveToLeft({
    node = self.upBar,
    delay = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.panel,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.list,
    delay = 0.8,
    ignore = true,
    ease = true
  })
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
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.order1:hide()
  self.typeBg:hide()
  self.professions = {}
  self.ruleFront = 1
  self.ruleAfter = 1
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = RuleFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.heroFilter = FilterLogic.new({
    heros = table.values(game.role.heros),
    sortRule = rule
  })
  self.heroFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:setFilter()
  self.order2:setCallback(function(sender)
    local layer = game:createView("hero.FilterConditionLayer", {
      professions = self.professions,
      ruleFront = self.ruleFront,
      callback = function(param)
        self:setFilter(param)
      end
    })
  end)
  self.order3:setCallback(function(sender)
    self.ruleAfter = self.ruleAfter + 1
    if self.ruleAfter > #RuleAfterType then
      self.ruleAfter = 1
    end
    self.order3:setString({
      text = RuleAfterDesc[self.ruleAfter],
      size = 20
    })
    self:setFilter()
  end)
end

local cellSize = cc.size(200, 212)

function HerosLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 5
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.heros then
      local hero = self.heros[index]
      local col = index - (row - 1) * colCount
      local card = SmallCard.new({
        heroId = hero.id,
        showLove = self.love
      }):anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
      card:setNormalTouch(function()
        local layer = game:createView("hero.HeroDetailLayer", {
          heroId = hero.id,
          index = index,
          heros = self.heros
        })
        self:hide()
        BackManager:push(function()
          if tolua.isnull(card) then
            return
          end
          self:show()
          layer:close()
          self.heroFilter:setSource(table.values(game.role.heros))
          TopBar:show(TopBarType.full, "厨房")
        end)
      end)
    end
  end
  self.rowLoaded[row] = true
end

function HerosLayer:loadPage(topRow, buttomRow)
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

function HerosLayer:refreshContent()
  self.list:removeAllChildren()
  self.rowViews = {}
  self.rowLoaded = {}
  self.heros = self.heroFilter:getResult()
  local maxCount = #self.heros
  self.num:setString(string.format("拥有同伴:%d/%d", maxCount, game.role.heroMaxNum))
  if maxCount == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    local tip = display.newSprite(heroRes .. "tip_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = "主厨您现在还没有满足筛选条件的食灵哦",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(435, 147):addTo(tip)
    self.list:requestDoLayout()
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(#self.heros / 5) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function HerosLayer:setFilter(params)
  params = params or {}
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.love = self.ruleFront == 6
  self.heroFilter:orderByCondition({
    professions = self.professions,
    rule = RuleFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
end

return HerosLayer
