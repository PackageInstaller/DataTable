local FilterLogic = import(".FilterLogic")
local heroRes = "ui/hero/"
local chooseRes = "ui/hero/choose/"
local uiData = {
  csbFile = "ui/hero/ChooseHeroLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    exrtBg = "exrtBg",
    up = "up",
    btnsBg = "btnsBg",
    panel = "panel",
    list = "list",
    okBtn = "okBtn",
    num = "panel/num",
    order1 = "panel/order1",
    order2 = "panel/order2",
    order3 = "panel/order3",
    typeBg = "panel/typeBg",
    changeBtn = "exrtBg/changeBtn",
    StarsBtn1 = "exrtBg/twoStarsBtn",
    StarsBtn2 = "exrtBg/threeStarsBtn",
    StarsBtn3 = "exrtBg/fourStarsBtn"
  }
}
local tipData = {
  [1] = {
    title = "暂时没有可选择的食灵\n或可供选择的食灵被锁定",
    desc = " "
  }
}
local ChooseAwakeResetLayer = class("ChooseAwakeResetLayer", UIBase)

function ChooseAwakeResetLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseAwakeResetLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.okBtn:setPositionX(self.okBtn:getPositionX() + 125)
    self.exrtBg:setPositionX(self.exrtBg:getPositionX() + 125)
  end
  TopBar:show(TopBarType.full, "食灵列表")
  self.changeBtn:hide()
  self.order1:hide()
  self.typeBg:hide()
  self.desc = "符合要求食灵:"
  self.ruleSort = params.rule
  self.chooseList = params.list or {}
  self.chooseCallback = params.callback
  self.unChooseList = {}
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

local cellSize = cc.size(200, 212)

function ChooseAwakeResetLayer:refreshContent()
  self.list:removeAllChildren()
  self.heros = {}
  self.chooseCards = {}
  self.unChooseList = {}
  self.rowViews = {}
  self.rowLoaded = {}
  for index, hero in pairs(self.heroFilter:getResult()) do
    if self.ruleSort(hero) then
    else
      table.insert(self.heros, hero.id)
    end
  end
  local maxCount = #self.heros
  self.num:setString(string.format("%s %d", self.desc, maxCount))
  if maxCount == 0 then
    local tip = tipData[1]
    if not tip then
      return
    end
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    local bg = display.newSprite(heroRes .. "tip_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = tip.title,
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(440, 180):addTo(bg)
    display.newTTFLabel({
      text = tip.desc,
      size = 18,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(442, 130):addTo(bg)
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(maxCount / 5) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function ChooseAwakeResetLayer:loadPage(topRow, buttomRow)
  topRow = math.max(1, topRow)
  local len = self.rowViews and #self.rowViews or 0
  buttomRow = math.min(len, buttomRow)
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

function ChooseAwakeResetLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 5
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.heros then
      local heroId = self.heros[index]
      local col = index - (row - 1) * colCount
      local card = self:createCard(row, heroId, index)
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
    end
  end
  self.rowLoaded[row] = true
end

function ChooseAwakeResetLayer:createCard(curRow, heroId, index)
  local card = SmallCard.new({
    hero = game.role.heros[heroId]
  })
  card:setNormalTouch(function()
    self:choose(heroId, card)
  end)
  if self.chooseList[heroId] then
    local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
    display.newSprite(chooseRes .. "text.png"):center(choose):addTo(choose)
  end
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  self.unChooseList[curRow][heroId] = card
  return card
end

function ChooseAwakeResetLayer:choose(heroId, card)
  if heroId ~= 0 then
    local selectHero = game.role.heros[heroId]
    local state = selectHero:getState()
    if state[2] then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_CURE)
      return
    end
    if state[3] then
      SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_CURE)
      return
    end
  end
  local lock = card:getChildByName("lock")
  if lock then
    return
  end
  local result = self.chooseCallback(heroId)
  if not result then
    BackManager:pop()
  end
  return
end

return ChooseAwakeResetLayer
