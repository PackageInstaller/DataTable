local FilterLogic = import(".FilterEquipLogic")
local unitCsv = require("csvdata.unit")
local starCsv = require("csvdata.star")
local heroExpCsv = require("csvdata.hero_exp")
local professionCsv = require("csvdata.profession")
local LevelCsv = require("csvdata.equip_level")
local StarExpCsv = require("csvdata.equip_starexp")
local EquipCsv = require("csvdata.equip")
local heroRes = "ui/hero/"
local chooseEquipRes = "ui/equip/choose/"
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
local tipData = {
  [0] = {
    title = "暂时没有适用的装备"
  },
  [2] = {
    title = "暂时没有可改造的装备"
  },
  [3] = {
    title = "暂时没有可强化的装备"
  },
  [4] = {
    title = "暂时没有可用于强化的材料装备"
  },
  [5] = {
    title = "暂时没有可用于回收的装备"
  }
}
local ChooseEquipLayer = class("ChooseEquipLayer", UIBase)

function ChooseEquipLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseEquipLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    self.extrBg:setPositionX(self.extrBg:getPositionX() + 125)
  end
  TopBar:show(TopBarType.full, "装备列表")
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.okBtn:setTouchScale()
  local backBtn = TopBar:getBackBtn():getChildByName("heroListBack")
  if backBtn then
    backBtn:hide()
  end
  self.ruleSort = params.rule or function()
    return false
  end
  self.chooseCallback = params.callback
  self.multiChoose = params.multiChoose
  self.choosedList = params.choosedList or {}
  self.equipId = params.equipId
  self.profession = params.profession
  self.type = params.type or 0
  self.format = params.format
  self.desc = params.desc or "符合要求装备:"
  self.max = params.max
  self.unChooseList = {}
  self.chooseList = {}
  self.curChoose = 0
  self.strengthId = params.strengthId
  self.isBase = params.isBase
  self.slot = params.slot
  self.quickChose = params.quickChose
  self.quickChoseList = {}
  self.change = false
  if not self.quickChose then
    for i = 1, 4 do
      self["StarsBtn" .. i]:hide()
    end
  end
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.order1:hide()
  self.typeBg:hide()
  if not UserData.equipFilter or game.role.majorGuideStep <= MAX_MAJOR_STEP then
    UserData.equipFilter = {}
  end
  if not UserData.equipFilter["0"] then
    UserData.equipFilter["0"] = {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
    UserData.equipFilter["2"] = {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
    UserData.equipFilter["3"] = {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
    UserData.equipFilter["4"] = {
      order1 = {},
      order2 = 1,
      order3 = 2
    }
    UserData.equipFilter["5"] = {
      order1 = {},
      order2 = 1,
      order3 = 2
    }
  end
  local orderData = UserData.equipFilter[tostring(self.type)]
  self.professions = orderData.order1
  self.ruleFront = orderData.order2
  self.ruleAfter = orderData.order3
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = EquipFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.equipFilter = FilterLogic.new({
    heros = table.values(game.role.equips),
    sortRule = rule
  })
  self.equipFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  if self.profession then
    self.professions[self.profession] = 1
  end
  self:setFilter()
  self.order2:setCallback(function()
    local layer = game:createView("hero.FilterConditionLayer", {
      professions = self.professions,
      showType = 2,
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
    local equip = game.role.equips[self.strengthId]
    local chooseSum = table.nums(self.chooseList) or 0
    if not equip then
      for i = 1, 4 do
        self["press" .. i] = false
        self.quickChoseList[i] = {}
        self["StarsBtn" .. i]:setCallback(function()
          if not self["press" .. i] then
            for _, _equip in pairs(self.quickEquips) do
              if _equip.csvData.star == i + 1 then
                if self.max and chooseSum < self.max then
                  table.insert(self.quickChoseList[i], _equip.id, _equip.id)
                  chooseSum = chooseSum + 1
                else
                  break
                end
              end
            end
            self["StarsBtn" .. i]:setTitleText("取消选择")
            self["press" .. i] = true
          else
            for _, _equip in pairs(self.quickEquips) do
              if _equip.csvData.star == i + 1 and self.quickChoseList[i][_equip.id] then
                self.quickChoseList[i][_equip.id] = nil
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
    local isExpFull = false
    local addExp = 0
    local curLevel = equip:getAttrLevel(self.slot, self.isBase)
    local curBaseExp = equip:getAttrExp(self.slot, self.isBase)
    if 0 < #self.chooseList then
      for _, id in pairs(self.chooseList) do
        local tempEquip = game.role.equips[id]
        if tempEquip then
          addExp = addExp + StarExpCsv[tempEquip.csvData.star].selfexp + tempEquip:getAllExp() * globalCsv.equipStrength_ExpLose
        end
      end
    end
    local maxExp = LevelCsv[#LevelCsv].exp
    local maxLevel = LevelCsv[#LevelCsv].id
    local levelData = LevelCsv[curLevel]
    local curExp = curBaseExp + addExp
    for i = 1, 4 do
      self["press" .. i] = false
      self.quickChoseList[i] = {}
      self["StarsBtn" .. i]:setCallback(function()
        if not self["press" .. i] then
          for _, _equip in pairs(self.quickEquips) do
            if _equip and _equip.csvData.star == i + 1 then
              local haveChose = false
              for _, equipId in pairs(self.choosedList) do
                if equipId == equip.id then
                  haveChose = true
                  break
                end
              end
              if not haveChose then
                if curExp >= maxExp then
                  isExpFull = true
                end
                if not isExpFull then
                  table.insert(self.quickChoseList[i], _equip.id, _equip.id)
                  local tempEquip = game.role.equips[_equip.id]
                  addExp = StarExpCsv[tempEquip.csvData.star].selfexp + tempEquip:getAllExp() * globalCsv.equipStrength_ExpLose
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
          for _, equip in pairs(self.quickEquips) do
            if equip.csvData.star == i + 1 then
              self.quickChoseList[i][equip.id] = nil
            end
          end
          for k, equipId in pairs(self.choosedList) do
            if game.role.equips[equipId].csvData.star == i + 1 then
              self.choosedList[k] = nil
            end
          end
          for id, _ in pairs(self.chooseList) do
            if game.role.equips[id].csvData.star == i + 1 then
              self.chooseList[id] = nil
            end
          end
          addExp = 0
          isExpFull = false
          if #self.chooseList > 0 then
            for id, _ in pairs(self.chooseList) do
              local tempEquip = game.role.euqips[id]
              if tempEquip then
                addExp = addExp + StarExpCsv[tempEquip.csvData.star].selfexp + tempEquip:getAllExp() * globalCsv.equipStrength_ExpLose
              end
            end
          end
          curLevel = equip:getAttrLevel(self.slot, self.isBase)
          curExp = equip:getAttrExp(self.slot, self.isBase) + addExp
          self["StarsBtn" .. i]:setTitleText(string.format("快速选择%d星", i + 1))
          self["press" .. i] = false
        end
        self:refreshContent()
      end)
    end
  end
end

function ChooseEquipLayer:updateQuickChoose()
  self.quickEquips = {}
  for i = 1, 4 do
    self["StarsBtn" .. i]:setTitleText(string.format("快速选择%d星", i + 1))
  end
  local equips = self.equipFilter:getResult()
  for index, equip in pairs(equips) do
    if self.ruleSort(equip) then
    elseif self.type == 4 or self.type == 5 then
      if equip.masterId ~= 0 then
      else
        table.insert(self.quickEquips, equip)
      end
    else
      table.insert(self.quickEquips, equip)
    end
  end
end

local cellSize = cc.size(150, 190)

function ChooseEquipLayer:refreshContent()
  self.list:removeAllChildren()
  self.equips = {}
  self.chooseList = {}
  self.chooseCards = {}
  self.unChooseList = {}
  local equips = self.equipFilter:getResult()
  if not self.multiChoose and self.equipId then
    table.insert(self.equips, 0)
  end
  for index, equip in pairs(equips) do
    if self.ruleSort(equip) then
    elseif self.type == 3 then
      local isAllMax = true
      for i = 1, 2 do
        local baselevel = equip:getAttrLevel(i, true)
        local exlevel = equip:getAttrLevel(i, false)
        local baselimit = 10
        if 3 >= equip.star and i == 2 then
          baselimit = 0
        end
        if baselevel ~= baselimit then
          isAllMax = false
        end
        local exlimit = 10
        if equip.star <= 4 and i == 2 or 2 >= equip.star and i == 1 then
          exlimit = 0
        end
        if exlevel ~= exlimit then
          isAllMax = false
        end
      end
      if not isAllMax then
        table.insert(self.equips, equip.id)
      end
    elseif self.type == 4 or self.type == 5 then
      if equip.masterId ~= 0 then
      else
        table.insert(self.equips, equip.id)
      end
    else
      table.insert(self.equips, equip.id)
    end
  end
  if self.multiChoose and next(self.choosedList) then
    for _, id in pairs(self.choosedList) do
      self.chooseList[id] = true
    end
  end
  for i = 1, 4 do
    if self.quickChoseList and self.quickChoseList[i] then
      for _, euqipId in pairs(self.quickChoseList[i]) do
        if euqipId and euqipId ~= 0 then
          self.chooseList[euqipId] = true
        end
      end
    end
  end
  self.rowViews = {}
  self.rowLoaded = {}
  local maxCount = #self.equips
  self.num:setString(string.format("%s %d", self.desc, maxCount - (self.equipId and 1 or 0)))
  if maxCount == 0 then
    local tip = tipData[self.type]
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

function ChooseEquipLayer:loadPage(topRow, buttomRow)
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

function ChooseEquipLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.equips then
      local equipId = self.equips[index]
      local col = index - (row - 1) * colCount
      local card = self:createCard(row, equipId, index)
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
    end
  end
  self.rowLoaded[row] = true
  if self.strengthId then
    self:calculateCurStrength()
  end
  if self.max then
    self:checkMax()
  end
end

function ChooseEquipLayer:createCard(curRow, equipId, index)
  local card = EquipSmallCard.new({equipId = equipId, hideLock = true})
  card:setCallback(function()
    self:choose(equipId, card)
  end)
  card:name("equipChoose" .. index)
  if self.chooseList[equipId] then
    local choose = display.newSprite(chooseEquipRes .. "choose.png"):pos(75, 100):addTo(card):name("choose")
  end
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  if self.curChoose == equipId then
    self.select = display.newSprite("ui/equip/main/select.png"):center(card):addTo(card)
  end
  self.unChooseList[curRow][equipId] = card
  return card
end

function ChooseEquipLayer:choose(equipId, card)
  self:cleanSelected()
  self.select = display.newSprite("ui/equip/main/select.png"):center(card):addTo(card)
  self.detailNode:removeAllChildren()
  game:createView("equip.EquipDetailLayer", {
    scene = self.detailNode,
    equipId = equipId,
    showHero = true,
    hideLock = true
  })
  if not self.multiChoose then
    self.curChoose = equipId
    return
  end
  if self.chooseList[equipId] then
    game:playMusic(1025)
    card:removeChildByName("choose")
    self.chooseList[equipId] = nil
  else
    local lock = card:getChildByName("lock")
    if lock then
      return
    end
    game:playMusic(1024)
    self.chooseList[equipId] = true
    local choose = display.newSprite(chooseEquipRes .. "choose.png"):pos(75, 100):addTo(card):name("choose")
  end
  if self.strengthId then
    self:calculateCurStrength()
  end
  if self.max then
    self:checkMax()
  end
end

function ChooseEquipLayer:setFilter(params)
  params = params or {}
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.equipFilter:filterByConditions({
    professions = self.professions,
    rule = EquipFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
  self:updateQuickChoose()
  self:cleanSelected()
  self.detailNode:removeAllChildren()
  game:createView("equip.EquipDetailLayer", {
    scene = self.detailNode,
    hideLock = true
  })
end

function ChooseEquipLayer:cleanSelected()
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

function ChooseEquipLayer:checkMax()
  local isFull = table.nums(self.chooseList) >= self.max
  for _, rowData in pairs(self.unChooseList) do
    for heroId, card in pairs(rowData) do
      if isFull and not self.chooseList[heroId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite(chooseEquipRes .. "mask.png"):anch(0, 0):pos(-1, 0):addTo(card):name("lock")
          local bg = display.newSprite(chooseEquipRes .. "text_bg.png"):pos(76, 100):addTo(lock)
          display.newTTFLabel({
            text = "选择达到上限",
            size = 20,
            color = UIHelper.hex2rgb("#ffffff")
          }):pos(63, 18):addTo(bg)
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

function ChooseEquipLayer:calculateCurStrength()
  local equip = game.role.equips[self.strengthId]
  if not equip then
    return
  end
  local curExp = equip:getAttrExp(self.slot, self.isBase)
  for equipId, _ in pairs(self.chooseList) do
    local temp = game.role.equips[equipId]
    if temp then
      curExp = curExp + StarExpCsv[temp.csvData.star].selfexp + temp:getAllExp() * globalCsv.equipStrength_ExpLose
    end
  end
  local isFull = curExp >= LevelCsv[#LevelCsv].exp
  for _, rowData in pairs(self.unChooseList) do
    for equipId, card in pairs(rowData) do
      if isFull and not self.chooseList[equipId] then
        local lock = card:getChildByName("lock")
        if not lock then
          lock = display.newSprite(chooseEquipRes .. "mask.png"):anch(0, 0):pos(-1, 0):addTo(card):name("lock")
          if needNum ~= 0 then
            local bg = display.newSprite(chooseEquipRes .. "text_bg.png"):pos(76, 100):addTo(lock)
            display.newTTFLabel({
              text = "强化经验已满",
              size = 20,
              color = UIHelper.hex2rgb("#ffffff")
            }):pos(63, 18):addTo(bg)
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

function ChooseEquipLayer:onExit()
  if self.change then
    local orderData = UserData.equipFilter[tostring(self.type)] or {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
    orderData.order1 = self.professions
    orderData.order2 = self.ruleFront
    orderData.order3 = self.ruleAfter
    GameState.save(UserData)
  end
end

return ChooseEquipLayer
