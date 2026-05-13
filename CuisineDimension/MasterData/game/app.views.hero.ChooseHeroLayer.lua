local FilterLogic = import(".FilterLogic")
local unitCsv = require("csvdata.unit")
local starCsv = require("csvdata.star")
local heroExpCsv = require("csvdata.hero_exp")
local professionCsv = require("csvdata.profession")
local strengthCsv = require("csvdata.strength")
local TreeCsv = require("csvdata.tree")
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
    StarsBtn3 = "exrtBg/fourStarsBtn",
    StarsBtn4 = "exrtBg/fiveStarsBtn"
  }
}
local TextShow = {
  [1] = "显示强化已满",
  [7] = "显示好感度已满",
  [8] = "显示天赋已满"
}
local TextHide = {
  [1] = "隐藏强化已满",
  [7] = "隐藏好感度已满",
  [8] = "隐藏天赋已满"
}
local tipData = {
  [0] = {
    title = "暂时没有可选择的食灵\n或可供选择的食灵被锁定",
    desc = " "
  },
  [1] = {
    title = "暂时没有可强化的食灵",
    desc = "(食灵升级后会提升强化上限)"
  },
  [2] = {
    title = "暂时没有可作为强化材料的食灵",
    desc = "(锁定中食灵&套餐中食灵  不会作为强化材料)"
  },
  [3] = {
    title = "暂时没有可提升品质的食灵",
    desc = "(食灵达到10、30、50、70、90级可提升品质)"
  },
  [4] = {
    title = "暂时没有同名食灵或白米饭",
    desc = "(锁定中食灵&套餐中食灵  不可作为升品材料)"
  },
  [5] = {
    title = "暂时没有可回收食灵",
    desc = "(锁定中食灵&套餐中食灵  不可回收)"
  },
  [6] = {
    title = "暂时没有该类食灵",
    desc = " "
  },
  [7] = {
    title = "暂时没有可提升好感度的食灵",
    desc = " "
  },
  [8] = {
    title = "暂时没有可升华的食灵",
    desc = " "
  },
  [9] = {
    title = "暂时没有可作为觉醒材料的食灵",
    desc = " "
  },
  [10] = {
    title = "暂时没有可被重置觉醒的食灵",
    desc = " "
  },
  [11] = {
    title = "暂时没有可以作为梦境呼唤材料的食灵",
    desc = "(锁定中食灵&套餐中食灵  不可作为梦境呼唤材料)"
  },
  [12] = {
    title = "暂时没有可以作为天赋提升的食灵",
    desc = "(锁定中食灵&套餐中食灵  不可作为天赋提升材料)"
  }
}
local ChooseHeroLayer = class("ChooseHeroLayer", UIBase)

function ChooseHeroLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local function filterHeros(heroId, heros)
  if heroId and heroId ~= 0 then
    local selectHero = heros[heroId]
    local state = selectHero:getState()
    if state[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
      return true
    end
    if state[2] then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_CURE)
      return true
    end
    if state[3] then
      SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_CURE)
      return true
    end
  end
  return false
end

function ChooseHeroLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.okBtn:setPositionX(self.okBtn:getPositionX() + 125)
    self.exrtBg:setPositionX(self.exrtBg:getPositionX() + 125)
  end
  TopBar:show(TopBarType.full, "食灵列表")
  self.okBtn:hide()
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.okBtn:setTouchScale()
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose
  self.choosedList = params.choosedList
  self.strengthId = params.strengthId
  self.newRule = params.newRule
  self.heroId = params.heroId
  self.type = params.type or 0
  self.cure = params.cure
  self.star = params.star
  self.format = params.format
  self.desc = params.desc or "符合要求食灵:"
  self.max = params.max
  self.chooseList = {}
  self.unChooseList = {}
  self.love = params.love
  self.tree = params.tree
  self.skipDetail = params.skipDetail
  self.quickChose = params.quickChose
  self.quickChoseList = {}
  if not self.quickChose then
    for i = 1, 4 do
      self["StarsBtn" .. i]:hide()
    end
  end
  
  local function multiChose()
    if self.multiChoose then
      self.okBtn:show()
      self.okBtn:setCallback(function()
        local list = self.format and self.formatList or self.chooseList
        local result = self.chooseCallback(list)
        if not result then
          BackManager:pop()
        end
      end)
    else
      self.okBtn:hide()
    end
  end
  
  multiChose()
  if not self.format then
    self.changeBtn:hide()
  end
  self.changeBtn:setString({
    text = "快速编队",
    size = 22
  })
  self.changeBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#014b56"), 1)
  self.changeBtn:setTouchScale()
  self.changeBtn:setCallback(function()
    if not self.multiChoose then
      self.multiChoose = true
      self:refreshContent()
      self.changeBtn:setString({
        text = "普通编队",
        size = 22
      })
    else
      self.multiChoose = nil
      self:refreshContent()
      self.changeBtn:setString({
        text = "快速编队",
        size = 22
      })
    end
    multiChose()
  end)
  self:initShowOrHide(params)
  self.change = false
  if self.cure then
    self.okBtn:setString({text = "治疗", size = 32})
  end
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.order1:hide()
  self.typeBg:hide()
  if not UserData.heroFilter or game.role.majorGuideStep <= MAX_MAJOR_STEP then
    UserData.heroFilter = {
      ["0"] = {
        order1 = {},
        order2 = 1,
        order3 = 1
      },
      ["1"] = {
        order1 = {},
        order2 = 1,
        order3 = 1
      },
      ["2"] = {
        order1 = {},
        order2 = 3,
        order3 = 2
      },
      ["3"] = {
        order1 = {},
        order2 = 4,
        order3 = 1
      },
      ["4"] = {
        order1 = {},
        order2 = 3,
        order3 = 2
      },
      ["5"] = {
        order1 = {},
        order2 = 3,
        order3 = 2
      },
      ["6"] = {
        order1 = {},
        order2 = 1,
        order3 = 1
      },
      ["7"] = {
        order1 = {},
        order2 = 6,
        order3 = 1
      },
      ["11"] = {
        order1 = {},
        order2 = 3,
        order3 = 2
      },
      ["12"] = {
        order1 = {},
        order2 = 3,
        order3 = 2
      }
    }
  end
  local orderData = UserData.heroFilter[tostring(self.type)] or {
    order1 = {},
    order2 = 1,
    order3 = 1
  }
  self.professions = orderData.order1
  self.ruleFront = orderData.order2
  self.ruleAfter = orderData.order3
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = RuleFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.allHeros = params.heros or game.role.heros
  self.heroFilter = FilterLogic.new({
    heros = table.values(self.allHeros),
    sortRule = rule,
    special = self.type == 5
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
        self.change = true
        self:setFilter(param)
      end
    })
  end)
  self.order3:setCallback(function(sender)
    self.change = true
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
    local chooseSum = table.nums(self.chooseList) or 0
    local isSumFull = false
    local isExpFull = false
    local addExp, needNum = 0, 0
    for id, _ in pairs(self.chooseList) do
      local tempHero = self.allHeros[id]
      if tempHero then
        local unitData = unitCsv[tempHero.type]
        addExp = addExp + unitData.strengthExp
      end
    end
    local hero = self.allHeros[self.strengthId]
    if not hero then
      for i = 1, 4 do
        self["press" .. i] = false
        self.quickChoseList[i] = {}
        self["StarsBtn" .. i]:setCallback(function()
          if not self["press" .. i] then
            for _, _hero in pairs(self.quickHeros) do
              if _hero.unit.star == i + 1 and not globalCsv.blackHeroUnitIds[_hero.unit.type] then
                if filterHeros(_hero.id, self.allHeros) then
                  return
                end
                if self.max and chooseSum < self.max then
                  table.insert(self.quickChoseList[i], _hero.id, _hero.id)
                  chooseSum = chooseSum + 1
                else
                  break
                end
              end
            end
            self["StarsBtn" .. i]:setTitleText("取消选择")
            self["press" .. i] = true
          else
            for _, hero in pairs(self.quickHeros) do
              if hero.unit.star == i + 1 and self.quickChoseList[i][hero.id] then
                self.quickChoseList[i][hero.id] = nil
                chooseSum = chooseSum - 1
              end
            end
            self["StarsBtn" .. i]:setTitleText(string.format("快速选择%d星", i + 1))
            self["press" .. i] = false
          end
          self:refreshContent()
        end)
      end
      return
    end
    local maxLevel = heroExpCsv[hero.level].strengthLevel
    local curLevel = hero.strengthLevel
    local strengthData = strengthCsv[curLevel]
    local curExp = hero.strengthExp + addExp
    for i = 1, 4 do
      self["press" .. i] = false
      self.quickChoseList[i] = {}
      self["StarsBtn" .. i]:setCallback(function()
        if not self["press" .. i] then
          for _, _hero in pairs(self.quickHeros) do
            if _hero.unit.star == i + 1 then
              if filterHeros(_hero.id, self.allHeros) then
                return
              end
              local haveChosen = false
              for _, heroid in pairs(self.choosedList) do
                if heroid == _hero.id then
                  haveChosen = true
                  break
                end
              end
              if not haveChosen then
                isSumFull = 20 <= chooseSum
                while curExp >= strengthData.exp do
                  curLevel = curLevel + 1
                  if curLevel >= maxLevel then
                    curExp = 0
                  else
                    curExp = curExp - strengthData.exp
                    strengthData = strengthCsv[curLevel]
                  end
                end
                if curLevel >= maxLevel then
                  needNum = table.nums(self.chooseList)
                  isExpFull = true
                end
                if not isSumFull and not isExpFull then
                  table.insert(self.quickChoseList[i], _hero.id, _hero.id)
                  chooseSum = chooseSum + 1
                  local temphero = self.allHeros[_hero.id]
                  addExp = unitCsv[temphero.type].strengthExp
                  curExp = curExp + addExp
                else
                  break
                end
              end
            end
          end
          self["StarsBtn" .. i]:setTitleText("取消选择")
          self["press" .. i] = true
        else
          for _, hero in pairs(self.quickHeros) do
            if hero.unit.star == i + 1 then
              self.quickChoseList[i][hero.id] = nil
            end
          end
          for j, heroId in pairs(self.choosedList) do
            if self.allHeros[heroId].unit.star == i + 1 then
              self.choosedList[j] = nil
            end
          end
          for id, _ in pairs(self.chooseList) do
            if self.allHeros[id].unit.star == i + 1 then
              self.chooseList[id] = nil
            end
          end
          chooseSum = table.nums(self.chooseList)
          addExp = 0
          needNum = 0
          isSumFull = false
          isExpFull = false
          for id, _ in pairs(self.chooseList) do
            local tempHero = self.allHeros[id]
            if tempHero then
              local unitData = unitCsv[tempHero.type]
              addExp = addExp + unitData.strengthExp
            end
          end
          curLevel = hero.strengthLevel
          curExp = hero.strengthExp + addExp
          while curExp >= strengthData.exp do
            curLevel = curLevel + 1
            if curLevel >= maxLevel then
              curExp = 0
            else
              curExp = curExp - strengthData.exp
              strengthData = strengthCsv[curLevel]
            end
          end
          self["StarsBtn" .. i]:setTitleText(string.format("快速选择%d星", i + 1))
          self["press" .. i] = false
        end
        self:refreshContent()
      end)
    end
  end
end

function ChooseHeroLayer:updateQuickChoose()
  self.quickHeros = {}
  for i = 1, 4 do
    self["StarsBtn" .. i]:setTitleText(string.format("快速选择%d星", i + 1))
  end
  local heros = self.heroFilter:getResult()
  for index, hero in pairs(heros) do
    if self.ruleSort(hero) then
    else
      table.insert(self.quickHeros, hero)
    end
  end
end

function ChooseHeroLayer:initShowOrHide(params)
  self.ruleSort = params.rule or function()
    return false
  end
  if self.type ~= 1 and self.type ~= 7 and self.type ~= 8 then
    return
  end
  self.changeBtn:show()
  local hide = true
  local fontSize = self.type == 7 and 14 or 16
  self.changeBtn:setString({
    text = TextShow[self.type],
    size = fontSize
  })
  self.changeBtn:setTouchScale()
  self.changeBtn:setCallback(function()
    hide = not hide
    if hide then
      self.ruleSort = params.rule
      self.changeBtn:setString({
        text = TextShow[self.type],
        size = fontSize
      })
    else
      self.ruleSort = params.rule1
      self.changeBtn:setString({
        text = TextHide[self.type],
        size = fontSize
      })
    end
    self:refreshContent()
  end)
end

local cellSize = cc.size(200, 212)

function ChooseHeroLayer:refreshContent()
  self.list:removeAllChildren()
  self.heros = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  self.formatList = {}
  self.formatData = {}
  if self.choosedList then
    for _, heroId in pairs(self.choosedList) do
      if heroId and heroId ~= 0 then
        self.chooseList[heroId] = true
      end
    end
  end
  for i = 1, 4 do
    if self.quickChoseList and self.quickChoseList[i] then
      for _, heroId in pairs(self.quickChoseList[i]) do
        if heroId and heroId ~= 0 then
          self.chooseList[heroId] = true
        end
      end
    end
  end
  if self.format and not next(self.formatData) then
    self.formatData = game.role.formation[tostring(self.format)] or {
      list = {}
    }
    local tempFormat = table.nums(self.formatData.list) == 5 and {} or self.formatData.list
    local index = 1
    for slot = 1, 5 do
      local id = tempFormat[tostring(slot)]
      if id then
        self.formatList[index] = {slot = slot, id = id}
        if self.multiChoose then
          self.chooseList[id] = true
        end
        index = index + 1
      end
    end
  end
  local heros = self.heroFilter:getResult()
  if not self.multiChoose and self.heroId then
    table.insert(self.heros, 0)
  end
  for index, hero in pairs(heros) do
    if self.ruleSort(hero) then
    else
      table.insert(self.heros, hero.id)
    end
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

function ChooseHeroLayer:loadPage(topRow, buttomRow)
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

function ChooseHeroLayer:loadList(row)
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
  if self.strengthId then
    self:calculateCurStrength()
  end
  if self.cure then
    self:checkTreatSlot()
  end
  if self.format and self.multiChoose then
    self:checkFormationSlot()
  end
  if self.max then
    self:checkMax()
  end
end

function ChooseHeroLayer:createCard(curRow, heroId, index)
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
      hero = self.allHeros[heroId],
      cure = self.cure,
      showLove = self.love,
      strength = self.type == 1,
      tree = self.tree
    })
    if self.love then
      card:name("heroChoose" .. index)
    else
      card:name("heroChoose" .. heroId)
    end
    if game.role.majorGuideStep == 10 then
      card:setCallback(function()
        self:choose(heroId, card)
      end)
    else
      card:setNormalTouch(function()
        self:choose(heroId, card)
      end)
      card:setForcetouch(function()
        if self.skipDetail then
          return
        end
        local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
        self:hide()
        BackManager:push(function()
          card:checkMarry()
          layer:close()
          self:show()
          self:refreshContent()
          TopBar:show(TopBarType.full, "食灵编队")
        end)
      end)
    end
    if self.chooseList[heroId] then
      local choose = display.newSprite(chooseRes .. "choose.png"):scale(0.9):pos(98, 110):addTo(card):name("choose")
      if self.format and self.multiChoose then
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

function ChooseHeroLayer:choose(heroId, card)
  if filterHeros(heroId, self.allHeros) then
    return
  end
  if not self.multiChoose then
    local lock = card:getChildByName("lock")
    if lock and self.tree then
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
    if self.format then
      self.chooseCards[heroId] = nil
      self:calculateFormatSlot()
    end
  else
    local result = false
    if self.newRule then
      result = self.newRule(heroId)
    end
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
      if self.format then
        self.chooseCards[heroId] = card
        self:calculateFormatSlot()
      else
        display.newSprite(chooseRes .. "text.png"):center(choose):addTo(choose)
      end
    end
  end
  if self.strengthId then
    self:calculateCurStrength()
  end
  if self.cure then
    self:checkTreatSlot()
  end
  if self.format and self.multiChoose then
    self:checkFormationSlot()
  end
  if self.max then
    self:checkMax()
  end
end

function ChooseHeroLayer:checkMax()
  local isFull = table.nums(self.chooseList) >= self.max
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
          local bg = display.newSprite(chooseRes .. "text_bg.png"):pos(101, 114):addTo(lock)
          display.newTTFLabel({
            text = self.type == 4 and "已满足升品需要" or "达到选择上限",
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

function ChooseHeroLayer:checkTreatSlot()
  if not self.treatData then
    self.treatData = json.decode(game.role.treatJson or "[]")
  end
  local usedNum, selectNum = table.nums(self.treatData), table.nums(self.chooseList)
  local isFull = usedNum + selectNum >= game.role.treatSlot
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
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

function ChooseHeroLayer:checkFormationSlot()
  local isFull = table.nums(self.formatList) >= 5
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
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

function ChooseHeroLayer:calculateFormatSlot()
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

function ChooseHeroLayer:checkFormationSameHero(heroId)
  for index, data in ipairs(self.formatList) do
    local hero = self.allHeros[data.id]
    local curHero = self.allHeros[heroId]
    if hero.type == curHero.type then
      return true
    end
  end
  return false
end

function ChooseHeroLayer:findSlotById(heroId)
  for index, data in ipairs(self.formatList) do
    if heroId == data.id then
      return data.slot
    end
  end
end

function ChooseHeroLayer:calculateCurStrength()
  local isFull = table.nums(self.chooseList) >= 20
  local addExp, needNum = 0, 0
  for id, _ in pairs(self.chooseList) do
    local tempHero = self.allHeros[id]
    if tempHero then
      local unitData = unitCsv[tempHero.type]
      addExp = addExp + unitData.strengthExp
    end
  end
  local hero = self.allHeros[self.strengthId]
  local maxLevel = heroExpCsv[hero.level].strengthLevel
  local curLevel = hero.strengthLevel
  local strengthData = strengthCsv[curLevel]
  local curExp = hero.strengthExp + addExp
  while curExp >= strengthData.exp do
    curLevel = curLevel + 1
    if maxLevel <= curLevel then
      curExp = 0
    else
      curExp = curExp - strengthData.exp
      strengthData = strengthCsv[curLevel]
    end
  end
  if maxLevel <= curLevel then
    needNum = table.nums(self.chooseList)
    isFull = true
  end
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite("ui/kitchen/strength/mask.png"):scale(0.93):pos(101, 108):addTo(card):name("lock")
          if needNum ~= 0 then
            local bg = display.newSprite(chooseRes .. "text_bg.png"):pos(101, 114):addTo(lock)
            display.newTTFLabel({
              text = "强化经验已满",
              size = 20,
              color = UIHelper.hex2rgb("#ffffff")
            }):center(bg):addTo(bg)
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

function ChooseHeroLayer:setFilter(params)
  params = params or {}
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.love = self.ruleFront == 6
  self.heroFilter:orderByCondition({
    professions = self.professions,
    rule = RuleFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
  self:updateQuickChoose()
end

function ChooseHeroLayer:onExit()
  if self.change then
    local orderData = UserData.heroFilter[tostring(self.type)] or {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
    orderData.order1 = self.professions
    orderData.order2 = self.ruleFront
    orderData.order3 = self.ruleAfter
    if self.type == 20 then
      UserData.heroFilter[tostring(self.type)] = orderData
    end
    GameState.save(UserData)
  end
end

return ChooseHeroLayer
