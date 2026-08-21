local FilterLogic = import("..sauce.FilterSauceLogic")
local BreakCsv = require("csvdata.sauce_break")
local heroRes = "ui/hero/"
local chooseRes = "ui/equip/choose/"
local uiData = {
  csbFile = "ui/equip/EquipChooseLayer.csb",
  widgets = {
    center = "center",
    upBar = "upBar",
    num = "upBar/num",
    order1 = "upBar/order1",
    order2 = "upBar/order2",
    order3 = "upBar/order3",
    typeBg = "upBar/typeBg",
    extrBg = "extrBg",
    okBtn = "extrBg/okBtnEquip",
    StarsBtn1 = "extrBg/twoStarsBtn",
    StarsBtn2 = "extrBg/threeStarsBtn",
    StarsBtn3 = "extrBg/fourStarsBtn",
    StarsBtn4 = "extrBg/fiveStarsBtn",
    list = "mainBg/list",
    detailNode = "mainBg/detailNode"
  }
}
local initData = {
  [0] = {
    order2 = 1,
    order3 = 1,
    title = "暂时没有可选择的酱料",
    desc = " "
  },
  [1] = {
    order2 = 1,
    order3 = 1,
    title = "暂时没有可突破的酱料",
    desc = " "
  },
  [2] = {
    order2 = 1,
    order3 = 2,
    title = "暂时没有作为材料的酱料",
    desc = " "
  },
  [3] = {
    order2 = 1,
    order3 = 1,
    title = "暂时没有可进阶的酱料",
    desc = " "
  },
  [4] = {
    order2 = 1,
    order3 = 1,
    title = "暂时没有作为主体的酱料",
    desc = " "
  },
  [5] = {
    order2 = 1,
    order3 = 2,
    title = "暂时没有可重置的酱料",
    desc = " "
  },
  [6] = {
    order2 = 1,
    order3 = 2,
    title = "暂时没有可回收的酱料",
    desc = " "
  }
}
local btnName = {
  [2] = "快速选择蓝色",
  [3] = "快速选择紫色",
  [4] = "快速选择金色"
}
local ChooseSauceLayer = class("ChooseSauceLayer", UIBase)

function ChooseSauceLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseSauceLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
  end
  TopBar:show(TopBarType.full, "酱料列表")
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.okBtn:setTouchScale()
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose
  self.choosedList = params.choosedList or {}
  self.ruleSort = params.rule or function()
    return false
  end
  self.sauceId = params.sauceId
  self.type = params.type or 0
  self.desc = params.desc or "符合要求酱料:"
  self.max = params.max or 20
  self.chooseList = {}
  self.unChooseList = {}
  self.curChoose = 0
  self.heroId = params.heroId
  self.strengthId = params.strengthId
  self.mType = params.mType
  self.strength = params.strength
  self.active = params.active
  self.quickChose = params.quickChose
  self.quickChoseList = {}
  self.StarsBtn1:hide()
  if not self.quickChose then
    for i = 2, 4 do
      self["StarsBtn" .. i]:hide()
    end
  else
    for i = 2, 4 do
      self["StarsBtn" .. i]:setTitleText(btnName[i])
    end
  end
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.order1:hide()
  self.typeBg:hide()
  local orderData = initData[self.type] or initData[0]
  self.professions = {}
  self.ruleFront = orderData.order2
  self.ruleAfter = orderData.order3
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = SauceFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.sauceFilter = FilterLogic.new({
    heros = table.values(game.role.sauces),
    sortRule = rule,
    mType = self.type == 6 and 99 or self.mType
  })
  self.sauceFilter:addEventListener("filter", function(event)
    self.curChoose = 0
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
  self.okBtn:setCallback(function()
    local result = self.chooseCallback(self.multiChoose and self.chooseList or self.curChoose)
    if not result then
      BackManager:pop()
    end
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
  self:updateQuickChoose()
  if self.multiChoose and self.quickChose then
    local sauce = game.role.sauces[self.strengthId]
    local chooseSum = table.nums(self.chooseList) or 0
    if not sauce then
      for i = 2, 4 do
        self["press" .. i] = false
        self.quickChoseList[i] = {}
        self["StarsBtn" .. i]:setCallback(function()
          if not self["press" .. i] then
            for _, _sauce in pairs(self.quickSauces) do
              if _sauce.csvData.rare == i + 1 then
                if self.max and chooseSum < self.max then
                  table.insert(self.quickChoseList[i], _sauce.id, _sauce.id)
                  chooseSum = chooseSum + 1
                else
                  break
                end
              end
            end
            self["StarsBtn" .. i]:setTitleText("取消选择")
            self["press" .. i] = true
          else
            for _, _sauce in pairs(self.quickSauces) do
              if _sauce.csvData.rare == i + 1 and self.quickChoseList[i][_sauce.id] then
                self.quickChoseList[i][_sauce.id] = nil
                chooseSum = chooseSum - 1
              end
            end
            self["StarsBtn" .. i]:setTitleText(btnName[i])
            self["press" .. i] = false
          end
          self:refreshContent()
        end)
      end
      return
    end
    local isExpFull = false
    local addExp = 0
    local curBaseExp = sauce.breakE
    local curLevel = sauce.breakL
    if 0 < #self.chooseList then
      for _, id in pairs(self.chooseList) do
        local tempSauce = game.role.sauces[id]
        if tempSauce then
          addExp = addExp + tempSauce.csvData.exp * ((tempSauce.csvData.maintype == sauce.csvData.maintype or tempSauce.csvData.maintype == 0) and globalCsv.sameSauceBreak or 1)
        end
      end
    end
    local curLevel = sauce.breakL
    local maxExp = 0
    local sauceCsvData = BreakCsv[sauce.type]
    local maxLevel = #sauceCsvData
    local curExp = curBaseExp + addExp
    local breakSet = BreakCsv[sauce.type][curLevel]
    local index = 1
    while curLevel < maxLevel do
      curLevel = curLevel + 1
      index = index + 1
      maxExp = maxExp + breakSet.exp
      breakSet = BreakCsv[sauce.type][curLevel]
    end
    curLevel = sauce.breakL
    for i = 2, 4 do
      self["press" .. i] = false
      self.quickChoseList[i] = {}
      self["StarsBtn" .. i]:setCallback(function()
        if not self["press" .. i] then
          for _, _sauce in pairs(self.quickSauces) do
            if _sauce and _sauce.csvData.rare == i + 1 then
              local haveChose = false
              for _, sauceId in pairs(self.choosedList) do
                if sauceId == sauce.id then
                  haveChose = true
                  break
                end
              end
              if not haveChose then
                if curExp >= maxExp then
                  isExpFull = true
                end
                if not isExpFull and self.max and chooseSum < self.max then
                  table.insert(self.quickChoseList[i], _sauce.id, _sauce.id)
                  local tempSauce = game.role.sauces[_sauce.id]
                  addExp = tempSauce.csvData.exp * ((tempSauce.csvData.maintype == sauce.csvData.maintype or tempSauce.csvData.maintype == 0) and globalCsv.sameSauceBreak or 1)
                  curExp = curExp + addExp
                  chooseSum = chooseSum + 1
                else
                  break
                end
              end
            end
          end
          self["StarsBtn" .. i]:setTitleText("取消选择")
          self["press" .. i] = true
        else
          for _, _sauce in pairs(self.quickSauces) do
            if _sauce.csvData.rare == i + 1 then
              self.quickChoseList[i][_sauce.id] = nil
            end
          end
          for k, sauceId in pairs(self.choosedList) do
            if game.role.sauces[sauceId] and game.role.sauces[sauceId].csvData.rare == i + 1 then
              self.choosedList[k] = nil
            end
          end
          for id, _ in pairs(self.chooseList) do
            if game.role.sauces[id].csvData.rare == i + 1 then
              self.chooseList[id] = nil
            end
          end
          addExp = 0
          isExpFull = false
          if 0 < #self.chooseList then
            for id, _ in pairs(self.chooseList) do
              local tempSauce = game.role.sauces[id]
              if tempSauce then
                addExp = addExp + tempSauce.csvData.exp * ((tempSauce.csvData.maintype == sauce.csvData.maintype or tempSauce.csvData.maintype == 0) and globalCsv.sameSauceBreak or 1)
              end
            end
          end
          curLevel = sauce.breakL
          curExp = sauce.breakE + addExp
          chooseSum = 0
          self["StarsBtn" .. i]:setTitleText(btnName[i])
          self["press" .. i] = false
        end
        self:refreshContent()
      end)
    end
  end
end

function ChooseSauceLayer:updateQuickChoose()
  self.quickSauces = {}
  for i = 2, 4 do
    self["StarsBtn" .. i]:setTitleText(btnName[i])
  end
  local sauces = self.sauceFilter:getResult()
  for index, sauce in pairs(sauces) do
    if self.ruleSort(sauce) then
    elseif self.type == 4 or self.type == 5 then
      if sauce.masterId ~= 0 then
      else
        table.insert(self.quickSauces, sauce)
      end
    else
      table.insert(self.quickSauces, sauce)
    end
  end
end

local cellSize = cc.size(150, 190)

function ChooseSauceLayer:refreshContent()
  self.list:removeAllChildren()
  self.sauces = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  if self.multiChoose and next(self.choosedList) then
    for _, sauceId in pairs(self.choosedList) do
      if sauceId ~= 0 then
        self.chooseList[sauceId] = true
      end
    end
  end
  for index, sauce in pairs(self.sauceFilter:getResult()) do
    if self.ruleSort(sauce) then
    else
      table.insert(self.sauces, sauce.id)
    end
  end
  for i = 2, 4 do
    if self.quickChoseList and self.quickChoseList[i] then
      for _, sauceId in pairs(self.quickChoseList[i]) do
        if sauceId and sauceId ~= 0 then
          self.chooseList[sauceId] = true
        end
      end
    end
  end
  self.rowViews = {}
  self.rowLoaded = {}
  local maxCount = #self.sauces
  self.num:setString(string.format("%s %d", self.desc, maxCount - (self.sauceId and 1 or 0)))
  if maxCount == 0 then
    local tip = initData[self.type]
    if not tip then
      return
    end
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    display.newTTFLabel({
      text = tip.title,
      size = 18,
      color = UIHelper.hex2rgb("#b26b31")
    }):center(viewNode):addTo(viewNode)
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(maxCount / 4) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function ChooseSauceLayer:loadPage(topRow, buttomRow)
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

function ChooseSauceLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.sauces then
      local sauceId = self.sauces[index]
      local col = index - (row - 1) * colCount
      local card = self:createCard(row, sauceId, index)
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
    end
  end
  self.rowLoaded[row] = true
  self:checkMaskCondition()
end

function ChooseSauceLayer:createCard(curRow, sauceId, index)
  local card = SauceSmallCard.new({sauceId = sauceId})
  card:setCallback(function()
    self:choose(sauceId, card)
  end)
  if self.chooseList[sauceId] then
    display.newSprite(chooseRes .. "choose.png"):pos(74, 85):addTo(card):name("choose")
  end
  if self.strength and (game.role.sauces[sauceId].csvData.maintype == self.mType or game.role.sauces[sauceId].csvData.maintype == 0) then
    display.newSprite("ui/sauce/choose/break_up.png"):pos(74, 134):addTo(card)
  end
  if self.curChoose == 0 or self.curChoose == sauceId then
    self:cleanSelected()
    self.select = display.newSprite("ui/sauce/choose/select.png"):center(card):addTo(card)
    self.detailNode:removeAllChildren()
    game:createView("sauce.SauceDetailLayer", {
      scene = self.detailNode,
      sauceId = sauceId,
      showHero = true,
      active = self.active,
      callback = function()
        if card then
          card:refresh()
        end
      end,
      hideLock = self.type == 2 or self.type == 6
    })
    self.curChoose = sauceId
  end
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  self.unChooseList[curRow][sauceId] = card
  return card
end

function ChooseSauceLayer:choose(sauceId, card)
  self:cleanSelected()
  self.select = display.newSprite("ui/sauce/choose/select.png"):center(card):addTo(card)
  self.detailNode:removeAllChildren()
  game:createView("sauce.SauceDetailLayer", {
    scene = self.detailNode,
    sauceId = sauceId,
    showHero = true,
    active = self.active,
    callback = function()
      if card then
        card:refresh()
      end
    end,
    hideLock = self.type == 2 or self.type == 6
  })
  if not self.multiChoose then
    self.curChoose = sauceId
    return
  end
  if self.chooseList[sauceId] then
    game:playMusic(1025)
    card:removeChildByName("choose")
    self.chooseList[sauceId] = nil
  else
    local lock = card:getChildByName("lock")
    if lock then
      return
    end
    game:playMusic(1024)
    self.chooseList[sauceId] = true
    display.newSprite(chooseRes .. "choose.png"):pos(74, 85):addTo(card):name("choose")
  end
  self:checkMaskCondition()
end

function ChooseSauceLayer:checkMaskCondition()
  local isFull = table.nums(self.chooseList) >= self.max
  local str = "本次选择已满"
  if self.strength then
    local sauce = game.role.sauces[self.strengthId]
    local nowExp = sauce.breakE
    for id, _ in pairs(self.chooseList) do
      local tempSauce = game.role.sauces[id]
      if tempSauce then
        nowExp = nowExp + tempSauce.csvData.exp * ((tempSauce.csvData.maintype == sauce.csvData.maintype or tempSauce.csvData.maintype == 0) and globalCsv.sameSauceBreak or 1)
      end
    end
    local curLevel = sauce.breakL
    local maxLevel = #BreakCsv[sauce.type]
    local breakSet = BreakCsv[sauce.type][curLevel]
    while nowExp >= breakSet.exp do
      curLevel = curLevel + 1
      if maxLevel <= curLevel then
        nowExp = 0
        break
      else
        nowExp = nowExp - breakSet.exp
        breakSet = BreakCsv[sauce.type][curLevel]
      end
    end
    if maxLevel <= curLevel then
      isFull = true
      str = "强化经验已满"
    end
  end
  for _, rowData in pairs(self.unChooseList) do
    for sauceId, card in pairs(rowData) do
      if isFull and not self.chooseList[sauceId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite(chooseRes .. "mask.png"):anch(0, 0):pos(-1, 0):addTo(card):name("lock")
          local bg = display.newSprite(chooseRes .. "text_bg.png"):pos(73, 85):addTo(lock)
          display.newTTFLabel({text = str, size = 20}):pos(63, 18):addTo(bg)
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

function ChooseSauceLayer:setFilter(params)
  params = params or {}
  self:updateQuickChoose()
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

function ChooseSauceLayer:cleanSelected()
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

return ChooseSauceLayer
