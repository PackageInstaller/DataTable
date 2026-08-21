local FilterLogic = import(".FilterLogic")
local unitCsv = require("csvdata.unit")
local starCsv = require("csvdata.star")
local heroExpCsv = require("csvdata.hero_exp")
local professionCsv = require("csvdata.profession")
local strengthCsv = require("csvdata.strength")
local treeCsv = require("csvdata.tree")
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
    changeBtn = "exrtBg/changeBtn"
  }
}
local tipData = {
  [1] = {
    title = "暂时没有可选择的食灵\n或可供选择的食灵被锁定",
    desc = " "
  }
}
local ChooseAwakeHeroLayer = class("ChooseAwakeHeroLayer", UIBase)

function ChooseAwakeHeroLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseAwakeHeroLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.okBtn:setPositionX(self.okBtn:getPositionX() + 125)
    self.exrtBg:setPositionX(self.exrtBg:getPositionX() + 125)
  end
  TopBar:show(TopBarType.full, "食灵列表")
  self.changeBtn:hide()
  self.order1:hide()
  self.order2:hide()
  self.order3:hide()
  self.typeBg:hide()
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose or false
  self.choosedList = params.choosedList
  self.heroId = params.heroId
  self.desc = "符合要求食灵:"
  self.needNum = params.needNum
  self.chooseList = {}
  self.unChooseList = {}
  self.allHeros = params.heros or {}
  self.tempChoose = params.tempChoose
  self.stage = params.stage
  if self.tempChoose[params.stage] then
    self.tempChoose[params.stage] = nil
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
  self.okBtn:setCallback(function()
    local sendChoose = false
    if self.chooseList and table.nums(self.chooseList) >= self.needNum then
      sendChoose = true
    end
    local result = self.chooseCallback(self.chooseList, sendChoose)
    if not result then
      BackManager:pop()
    end
    return
  end)
  if self.multiChoose == false then
    self.okBtn:hide()
  end
  self:refreshContent()
end

local cellSize = cc.size(200, 212)

function ChooseAwakeHeroLayer:refreshContent()
  self.list:removeAllChildren()
  self.heros = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  self.formatList = {}
  if self.choosedList then
    for _, heroId in pairs(self.choosedList) do
      if heroId ~= 0 then
        self.chooseList[heroId] = true
      end
    end
  end
  if not self.multiChoose and self.heroId then
    table.insert(self.heros, 0)
  end
  for index, hero in pairs(self.allHeros) do
    table.insert(self.heros, hero.id)
  end
  self.rowViews = {}
  self.rowLoaded = {}
  local maxCount = #self.heros
  self.num:setString(string.format("%s %d", self.desc, maxCount - (self.heroId and 1 or 0)))
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

function ChooseAwakeHeroLayer:loadPage(topRow, buttomRow)
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

function ChooseAwakeHeroLayer:loadList(row)
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
  if self.multiChoose or self.tempChoose then
    self:checkFormationSlot()
  end
end

function ChooseAwakeHeroLayer:createCard(curRow, heroId, index)
  local card
  if heroId == 0 then
    card = UIHelper.newImageView(heroRes .. "small_card_add_bg.png")
    UIHelper.newImageView(heroRes .. "xiexia.png"):pos(97, 155):addTo(card)
    display.newTTFLabel({
      text = "卸下食灵",
      size = 16,
      color = UIHelper.hex2rgb("#a8a8a8")
    }):pos(94, 110):addTo(card)
    card:setCallback(function()
      self:choose(heroId, card)
    end)
  else
    card = SmallCard.new({
      hero = self.allHeros[heroId]
    })
    card:name("heroChoose" .. heroId)
    local cantChoose
    for index, value in pairs(self.tempChoose) do
      if index ~= self.stage and heroId == value[heroId] then
        cantChoose = true
      end
    end
    card:setNormalTouch(function()
      if cantChoose then
        SysError(SYS_ERR_HERO_AWAKE_HASE_CHOOSE_PROP)
      else
        self:choose(heroId, card)
      end
    end)
    card:setForcetouch(function()
      return
    end)
    if self.chooseList[heroId] then
      local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
      if self.multiChoose then
        local slot = self:findSlotById(heroId)
        local str = string.format("%stext_%d.png", chooseRes, slot)
        display.newSprite(str):center(choose):addTo(choose)
        self.chooseCards[heroId] = card
      else
        display.newSprite(chooseRes .. "text.png"):center(choose):addTo(choose)
      end
    end
    if not self.unChooseList[curRow] then
      self.unChooseList[curRow] = {}
    end
    self.unChooseList[curRow][heroId] = card
  end
  return card
end

function ChooseAwakeHeroLayer:choose(heroId, card)
  if heroId ~= 0 then
    local selectHero = self.allHeros[heroId]
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
  if not self.multiChoose then
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
  if self.chooseList[heroId] then
    card:removeChildByName("choose")
    game:playMusic(1025)
    self.chooseList[heroId] = nil
  else
    local result = false
    if not result then
      local lock = card:getChildByName("lock")
      if lock then
        return
      end
      if self:checkFormationSameHero(heroId) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return
      end
      game:playMusic(1024)
      self.chooseList[heroId] = true
      local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
      display.newSprite(chooseRes .. "text.png"):center(choose):addTo(choose)
    end
  end
  if self.multiChoose or self.tempChoose then
    self:checkFormationSlot()
  end
end

function ChooseAwakeHeroLayer:checkFormationSlot()
  local isFull = table.nums(self.chooseList) >= self.needNum
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
        end
      elseif self.tempChoose then
        for _, value in pairs(self.tempChoose) do
          for _, inValue in pairs(value) do
            if inValue == heroId then
              local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
              display.newSprite(chooseRes .. "text.png"):center(choose):addTo(choose)
            end
          end
        end
      else
        local lock = card:getChildByName("lock")
        if lock then
          lock:removeSelf()
        end
      end
    end
  end
end

function ChooseAwakeHeroLayer:calculateFormatSlot()
  local cur, all = table.nums(self.chooseList), table.nums(self.formatList)
  
  local function findSlot()
    for slot = 1, self.needNum do
      local had = false
      for index, data in ipairs(self.formatList) do
        if data.slot == slot then
          had = true
        end
      end
      if not had then
        return slot
      end
    end
  end
  
  local function checkHad(id)
    for _, data in ipairs(self.formatList) do
      if data.id == id then
        return true
      end
    end
    return false
  end
  
  if cur >= all then
    for id, _ in pairs(self.chooseList) do
      if not checkHad(id) then
        local slot = findSlot()
        self.formatList[#self.formatList + 1] = {slot = slot, id = id}
      end
    end
  else
    local remove
    for index, data in ipairs(self.formatList) do
      if not self.chooseList[data.id] then
        remove = index
        break
      end
    end
    for index = remove, #self.formatList - 1 do
      self.formatList[index].id = self.formatList[index + 1].id
    end
    table.remove(self.formatList, #self.formatList)
  end
  for id, card in pairs(self.chooseCards) do
    if not tolua.isnull(card) then
      local slot = self:findSlotById(id)
      local choose = card:getChildByName("choose")
      choose:removeAllChildren()
      str = string.format("%stext_%d.png", chooseRes, slot)
      display.newSprite(str):center(choose):addTo(choose)
    end
  end
end

function ChooseAwakeHeroLayer:checkFormationSameHero(heroId)
  for index, data in ipairs(self.formatList) do
    local hero = self.allHeros[data.id]
    local curHero = self.allHeros[heroId]
    if hero.type == curHero.type then
      return true
    end
  end
  return false
end

function ChooseAwakeHeroLayer:findSlotById(heroId)
  for index, data in ipairs(self.formatList) do
    if heroId == data.id then
      return data.slot
    end
  end
end

return ChooseAwakeHeroLayer
