local FilterLogic = import("..hero.FilterLogic")
local unitCsv = require("csvdata.unit")
local heroRes = "ui/hero/"
local chooseRes = "ui/tower/choose/"
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
    StarsBtn3 = "exrtBg/fourStarsBtn",
    StarsBtn4 = "exrtBg/fiveStarsBtn"
  }
}
local ChoosePvpHeroLayer = class("ChoosePvpHeroLayer", UIBase)

function ChoosePvpHeroLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChoosePvpHeroLayer:init(params)
  TopBar:show(TopBarType.full, "食灵列表")
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.okBtn:setPositionX(self.okBtn:getPositionX() + 125)
    self.exrtBg:setPositionX(self.exrtBg:getPositionX() + 125)
  end
  self.okBtn:hide()
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.okBtn:setTouchScale()
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose
  self.heroId = params.heroId
  self.type = params.type or 0
  self.desc = params.desc or "符合要求食灵:"
  self.rule = params.rule or function()
    return false
  end
  self.max = params.max
  self.originHeros = params.choosed or {}
  self.chooseList = {}
  self.unChooseList = {}
  self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  if not self.quickChose or false then
    for i = 1, 4 do
      self["StarsBtn" .. i]:hide()
    end
  end
  self.order1:hide()
  self.typeBg:hide()
  self.professions = {}
  self.ruleFront = 5
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
  self.order2:setCallback(function()
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
  
  local function multiChose()
    if self.multiChoose then
      self.okBtn:show()
      self.okBtn:setCallback(function()
        local result = self.chooseCallback(self.formatList)
        if not result then
          BackManager:pop()
        end
      end)
    else
      self.okBtn:hide()
    end
  end
  
  multiChose()
  self.changeBtn:setString({
    text = "快速选择",
    size = 22
  })
  self.changeBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#014b56"), 1)
  self.changeBtn:setTouchScale()
  self.changeBtn:setCallback(function()
    if not self.multiChoose then
      self.multiChoose = true
      self:refreshContent()
      self.changeBtn:setString({
        text = "普通选择",
        size = 22
      })
    else
      self.multiChoose = nil
      self:refreshContent()
      self.changeBtn:setString({
        text = "快速选择",
        size = 22
      })
    end
    multiChose()
  end)
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

function ChoosePvpHeroLayer:refreshContent()
  self.list:removeAllChildren()
  self.heros = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  self.formatList = {}
  local heros = self.heroFilter:getResult()
  for index, hero in pairs(heros) do
    if not self.multiChoose and hero.id == self.heroId then
    else
      table.insert(self.heros, hero.id)
    end
  end
  if not self.multiChoose and self.heroId then
    table.insert(self.heros, 1, 0)
  end
  local index = 1
  for heroId, slot in pairs(self.originHeros) do
    if self.multiChoose then
      self.formatList[index] = {slot = slot, id = heroId}
      self.chooseList[heroId] = true
    end
    index = index + 1
  end
  self.rowViews = {}
  self.rowLoaded = {}
  local maxCount = #self.heros
  self.num:setString(string.format("%s %d", self.desc, maxCount - (self.heroId and 1 or 0)))
  if maxCount == 0 then
    local tip = tipData[self.type]
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

function ChoosePvpHeroLayer:loadPage(topRow, buttomRow)
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

function ChoosePvpHeroLayer:loadList(row)
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
  if self.multiChoose then
    self:checkFormationSlot()
  end
end

function ChoosePvpHeroLayer:createCard(curRow, heroId, index)
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
    card = SmallCard.new({heroId = heroId, tower = true})
    card:name("heroChoose" .. heroId)
    card:setNormalTouch(function()
      self:choose(heroId, card)
    end)
    card:setForcetouch(function()
      local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
      self:hide()
      BackManager:push(function()
        card:checkMarry()
        layer:close()
        self:show()
        TopBar:show(TopBarType.full, "对阵信息")
      end)
    end)
    if self.originHeros[heroId] then
      display.newSprite("ui/tower/choose/format_cur.png"):pos(101, 120):addTo(card)
    end
    if self.chooseList[heroId] then
      local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
      if self.multiChoose then
        local slot = self:findSlotById(heroId)
        local str = string.format("%stext_%d.png", chooseRes, slot)
        display.newSprite(str):center(choose):addTo(choose)
        self.chooseCards[heroId] = card
      end
    end
    if not self.unChooseList[curRow] then
      self.unChooseList[curRow] = {}
    end
    self.unChooseList[curRow][heroId] = card
  end
  return card
end

function ChoosePvpHeroLayer:choose(heroId, card)
  if not self.multiChoose then
    local result = self.chooseCallback(heroId)
    if not result then
      BackManager:pop()
    end
    return
  end
  if self.chooseList[heroId] then
    card:removeChildByName("choose")
    self.chooseList[heroId] = nil
    self.chooseCards[heroId] = nil
    self:calculateFormatSlot()
  else
    local lock = card:getChildByName("lock")
    if lock then
      return
    end
    if self:checkFormationSameHero(heroId) then
      SysError(SYS_ERR_TEAM_SAME_HERO)
      return
    end
    self.chooseList[heroId] = true
    local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
    self.chooseCards[heroId] = card
    self:calculateFormatSlot()
  end
  if self.multiChoose then
    self:checkFormationSlot()
  end
end

function ChoosePvpHeroLayer:checkFormationSlot()
  local isFull = self:checkChangeCountFull()
  if table.nums(self.formatList) >= 5 then
    isFull = 1
  end
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if lock then
          lock:removeSelf()
          lock = nil
        end
        if not lock and isFull == 1 then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
          local bg = display.newSprite(chooseRes .. "text_bg.png"):pos(101, 114):addTo(lock)
          display.newTTFLabel({
            text = "队伍已满",
            size = 20,
            color = UIHelper.hex2rgb("#ffffff")
          }):center(bg):addTo(bg)
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

function ChoosePvpHeroLayer:calculateFormatSlot()
  local cur, all = table.nums(self.chooseList), table.nums(self.formatList)
  
  local function findSlot()
    for slot = 1, 5 do
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

function ChoosePvpHeroLayer:checkFormationSameHero(heroId)
  for index, data in ipairs(self.formatList) do
    local hero = game.role.heros[data.id]
    local curHero = game.role.heros[heroId]
    if hero.type == curHero.type and heroId ~= data.id then
      return true
    end
  end
  return false
end

function ChoosePvpHeroLayer:checkChangeCountFull()
  return table.nums(self.chooseList) >= self.max
end

function ChoosePvpHeroLayer:findSlotById(heroId)
  for index, data in ipairs(self.formatList) do
    if heroId == data.id then
      return data.slot
    end
  end
end

function ChoosePvpHeroLayer:setFilter(params)
  params = params or {}
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.love = self.ruleFront == 6
  self.heroFilter:orderByCondition({
    professions = self.professions,
    rule = RuleFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
end

return ChoosePvpHeroLayer
