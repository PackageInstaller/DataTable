local FilterLogic = import("..sauce.FilterSauceLogic")
local ChooseRes = "ui/sauce/choose/"
local uiData = {
  csbFile = "ui/equip/EquipsLayer.csb",
  widgets = {
    list = "list",
    upBar = "upBar",
    num = "upBar/num",
    order1 = "upBar/order1",
    order2 = "upBar/order2",
    order3 = "upBar/order3",
    typeBg = "upBar/typeBg",
    detailNode = "mainBg/detailNode"
  }
}
local SaucesLayer = class("SaucesLayer", UIBase)

function SaucesLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SaucesLayer:init(params)
  UIHelper.MoveToLeft({
    node = self.upBar,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.list,
    delay = 0.4,
    ignore = true,
    ease = true,
    pos = {0, 542}
  })
  self.showIndex = 1
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
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
  local rule = SauceFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.sauceFilter = FilterLogic.new({
    heros = table.values(game.role.sauces),
    sortRule = rule,
    mType = 0
  })
  self.sauceFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:setFilter()
  self.order2:setCallback(function()
    local temp = {
      showType = 3,
      professions = self.professions,
      ruleFront = self.ruleFront,
      callback = function(param)
        self:setFilter(param)
      end
    }
    local layer = game:createView("hero.FilterConditionLayer", temp)
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

local cellSize = cc.size(150, 190)

function SaucesLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.sauces then
      local sauce = self.sauces[index]
      local col = index - (row - 1) * colCount
      local card = SauceSmallCard.new({
        sauceId = sauce.id
      }):anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
      card:setCallback(function()
        self:cleanSelected()
        self.showIndex = index
        self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
        self.detailNode:removeAllChildren()
        game:createView("sauce.SauceDetailLayer", {
          scene = self.detailNode,
          sauceId = sauce.id,
          showHero = true,
          callback = function()
            if card then
              card:refresh()
            end
          end
        })
      end)
      if index == self.showIndex then
        self.detailNode:removeAllChildren()
        self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
        game:createView("sauce.SauceDetailLayer", {
          scene = self.detailNode,
          sauceId = sauce.id,
          showHero = true,
          callback = function()
            if card then
              card:refresh()
            end
          end
        })
      end
    end
  end
  self.rowLoaded[row] = true
end

function SaucesLayer:loadPage(topRow, buttomRow)
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

function SaucesLayer:refreshContent()
  self.list:removeAllChildren()
  self.rowViews = {}
  self.rowLoaded = {}
  self.sauces = self.sauceFilter:getResult()
  local maxCount = #self.sauces
  self.num:setString(string.format("拥有酱料:%d/%d", maxCount, game.role:getMaxSauce()))
  if maxCount == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    display.newTTFLabel({
      text = "主厨您现在还没有满足筛选条件的酱料哦",
      size = 28,
      color = UIHelper.hex2rgb("#842c17")
    }):center(viewNode):addTo(viewNode)
    self.list:requestDoLayout()
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(#self.sauces / 4) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function SaucesLayer:setFilter(params)
  params = params or {}
  self:cleanSelected()
  self.detailNode:removeAllChildren()
  game:createView("sauce.SauceDetailLayer", {
    scene = self.detailNode
  })
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.sauceFilter:orderByCondition({
    professions = self.professions,
    rule = SauceFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
end

function SaucesLayer:cleanSelected()
  self.showIndex = 1
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

return SaucesLayer
