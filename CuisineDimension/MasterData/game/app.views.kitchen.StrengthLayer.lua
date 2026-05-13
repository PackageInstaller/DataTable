local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local starCsv = require("csvdata.star")
local heroExpCsv = require("csvdata.hero_exp")
local strengthCsv = require("csvdata.strength")
local professionCsv = require("csvdata.profession")
local heroRes = "ui/hero/"
local kitchenRes = "ui/kitchen/"
local cookRes = "ui/kitchen/cook/"
local detailRes = "ui/hero/detail/"
local qulaityRes = "ui/kitchen/quality/"
local strengthRes = "ui/kitchen/strength/"
local uiData = {
  csbFile = "ui/kitchen/StrengthLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    list = "mainBg1/list",
    mainBg3 = "mainBg1/mainBg3",
    evoBtn = "mainBg1/evoBtn",
    heroNum = "mainBg1/numBg/heroNum",
    mainBg2 = "mainBg2",
    circle = "mainBg2/circle",
    tipText = "mainBg2/desk/tip/text",
    heroNode = "mainBg2/desk/heroNode",
    addBtn = "mainBg2/desk/addBtn",
    panel = "panel",
    barBg = "panel/barBg",
    exp = "panel/exp",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2",
    maskNode = "maskNode"
  }
}
local StrengthLayer = class("StrengthLayer", UIBase)

function StrengthLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local attrs = {
  "atk",
  "phyDef",
  "hit",
  "miss"
}
local attrName = {
  "攻击",
  "防御",
  "命中",
  "闪避"
}

function StrengthLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom)
    self.mainBg1:setPositionX(self.mainBg1:getPositionX() + 200)
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
  end
  self.panel:hide()
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.heroNum:setString("食灵: 0")
  self.eatList = {}
  self.cards = {}
  self:showList()
  self.addBtn:setCallback(function()
    self:showChooseHero()
  end)
  local jianying = UIHelper.newImageView("ui/global/jianying.png"):center(self.addBtn):addTo(self.addBtn)
  jianying:setOpacity(0)
  jianying:runAction(cc.RepeatForever:create(transition.sequence({
    cc.FadeIn:create(1),
    cc.FadeOut:create(1)
  })))
  self.evoBtn:setTouchScale()
  self.evoBtn:setCallback(function()
    local heroIds = {}
    local showTip = {}
    for _, heroId in ipairs(self.eatList) do
      local hero = game.role.heros[heroId]
      if hero then
        heroIds[#heroIds + 1] = heroId
        if hero.unit.star == 1 then
          showTip[1] = "特殊"
        elseif hero.unit.star >= 4 then
          showTip[4] = "高星级"
        end
        if hero.treePoint ~= "" then
          showTip[2] = "升华"
        end
        if hero.quality >= 3 then
          showTip[3] = "高品质"
        end
      end
    end
    if not self.hero0 then
      SysError(SYS_ERR_STRENGTHEN_HERO_CHOOSE)
      return
    end
    if #heroIds == 0 then
      SysError(SYS_ERR_STRENGTHEN_NO_MATERIAL)
      return
    end
    
    local function sendRequest()
      local attrs = game.role.heros[self.hero0]:getTotalAttrValues()
      game:sendData(actionCodes.Hero_strengthRpc, MsgPack.pack({
        heroId = self.hero0,
        ids = heroIds
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_strengthRpc, function(event)
        UIHelper.removeWaiting()
        game:playMusic(1101)
        self.eatList = {}
        local msg = MsgPack.unpack(event.data)
        self:showAnimation(msg.up, attrs)
      end)
    end
    
    if next(showTip) then
      MDialog:double({
        text = string.format("选择的材料食灵中有<div color=#ff0000>%s</div>的食灵\n \n仍要进行强化吗？", table.concat(table.values(showTip), "/"))
      }, function()
        sendRequest()
      end)
      return
    end
    sendRequest()
  end)
  UIHelper.MoveToRight({
    node = self.mainBg2
  })
  UIHelper.MoveToLeft({
    node = self.mainBg1
  })
  UIHelper.MoveToUp({
    node = self.buttom,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.angel1,
    delay = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel2,
    delay = 0.3
  })
end

function StrengthLayer:showMainHero()
  self.heroNode:removeAllChildren()
  self.addBtn:hide()
  local hero = game.role.heros[self.hero0]
  if not hero then
    return
  end
  self.exp:removeAllChildren()
  self.barBg:removeAllChildren()
  self.tipText:setString("点击小人更换食灵")
  self.panel:show()
  self:showPanel()
  local nameBg = display.newSprite(strengthRes .. "name_bg.png"):pos(0, 250):addTo(self.heroNode)
  local isAdvanceMax = hero:isSauceAdvanceMax()
  display.newTTFLabel({
    text = "Lv " .. hero.level,
    size = 20,
    color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 190):addTo(self.heroNode)
  display.newTTFLabel({
    text = hero:getName(),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(120, 48):addTo(nameBg)
  local star = hero.unit.star
  local xPos = 120 - (star - 1) / 2 * 25
  local bMax = hero:isTreeMax()
  local isBlack = hero:isBlackHero()
  local isMengJing = hero:isMengJingHero()
  local isShengcan = hero:isShengcanHero()
  local temStar = math.min(star, 5)
  if isShengcan then
    for i = 1, temStar do
      display.newSprite(strengthRes .. (bMax and "star_tree_red.png" or "star.png")):pos(xPos + (i - 1) * 25, 15):addTo(nameBg)
    end
  else
    for i = 1, temStar do
      display.newSprite(strengthRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos(xPos + (i - 1) * 25, 15):addTo(nameBg)
    end
  end
  local proBg = UIHelper.newImageView(string.format("ui/global/profession_bg_%d.png", hero.quality)):pos(0, 48):addTo(nameBg)
  local imageName = hero:showTreeTag() and "ui/global/profession_s_%d.png" or "ui/global/profession_%d.png"
  UIHelper.newImageView(string.format(imageName, hero.unit.profession)):center(proBg):addTo(proBg)
  local spineNode = UIHelper.createSpineNode(hero:getDressType(), {})
  spineNode:addTo(self.heroNode)
  spineNode:setAnimation(0, "idle", true)
  local touchLayer = UIHelper.extend(ccui.Layout:create())
  touchLayer:size(150, 200):pos(-75, -50):addTo(spineNode)
  touchLayer:setCallback(function()
    self:showChooseHero()
  end)
end

function StrengthLayer:showList()
  self.heroNum:setString(string.format("食灵: %d/20", #self.eatList))
  self.list:removeAllChildren()
  self.cards = {}
  local cellSize = display.newSprite(strengthRes .. "bg_1.png"):getContentSize()
  cellSize.width = cellSize.width * 0.56 + 6
  cellSize.height = cellSize.height * 0.56
  for index, id in ipairs(self.eatList) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local card = StrengthCard.new({
      id = self.eatList[index]
    }):scale(0.56):center(viewNode):addTo(viewNode)
    card:setCallback(function()
      table.remove(self.eatList, index)
      self:showList()
      self:showPanel("choose")
    end)
    table.insert(self.cards, card)
  end
  local viewNode = ccui.Widget:create()
  viewNode:size(cellSize):addTo(self.list)
  local card = UIHelper.newImageView(heroRes .. "add_bg.png"):scale(0.56):center(viewNode):addTo(viewNode)
  UIHelper.newImageView(heroRes .. "add.png"):pos(78, 275):addTo(card)
  UIHelper.newText({
    text = "选择食灵",
    size = 28,
    color = UIHelper.hex2rgb("#bf9a77")
  }):pos(75, 230):addTo(card)
  card:setCallback(function()
    self:add()
  end)
  self.list:requestDoLayout()
end

function StrengthLayer:showPanel(type, up)
  local hero = game.role.heros[self.hero0]
  local ExpSet = heroExpCsv[hero.level]
  local title = self.exp:getChildByName("title")
  local bar = self.barBg:getChildByName("bar")
  local num = self.barBg:getChildByName("num")
  local progress = self.barBg:getChildByName("progress")
  local strengthSet = strengthCsv[hero.strengthLevel]
  local curMax = self:getTempMaxExp()
  local curMaxLeve = self:getCurMaxLevel(curMax)
  if type == "choose" then
    local colorT = #self.eatList == 0 and "#3a9721" or "#ff3d72"
    local colorN = #self.eatList == 0 and "#ffffff" or "#ff3d72"
    title:setString(string.format("强化进度 <div color=%s >%d</div> <div color=#3a9721 >/%d</div>", colorT, curMaxLeve, ExpSet.strengthLevel))
    num:setString(string.format("<div color=%s outline=1,#000000 >%d</div> <div color=#ffffff outline=1,#000000 >/%d</div>", colorN, curMax, strengthSet.exp))
    progress:stopAllActions()
    progress:setPercentage(curMax / strengthSet.exp * 100)
    progress:runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeTo:create(0.5, 100),
      cc.FadeTo:create(0.5, 255)
    })))
  elseif type == "send" then
    local action = {}
    if up then
      table.insert(action, cc.ProgressTo:create(0.5, 100))
      table.insert(action, cc.ProgressTo:create(0, 0))
    end
    table.insert(action, cc.ProgressTo:create(1, hero.strengthExp / strengthSet.exp * 100))
    bar:runAction(cc.Sequence:create(action))
    num:setString(string.format("<div color=#ffffff outline=1,#000000 >%d/%d</div>", hero.strengthExp, strengthSet.exp))
    title:setString(string.format("强化进度 <div color=#3a9721>%d/%d</div>", hero.strengthLevel, ExpSet.strengthLevel))
    progress:stopAllActions()
    progress:setPercentage(0)
  else
    progress = display.newProgressTimer(strengthRes .. "progress.png", 1):center(self.barBg):addTo(self.barBg):name("progress")
    progress:setMidpoint(cc.p(0, 0.5))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(curMax / strengthSet.exp * 100)
    bar = display.newProgressTimer(strengthRes .. "bar.png", 1):center(self.barBg):addTo(self.barBg):name("bar")
    bar:setMidpoint(cc.p(0, 0.5))
    bar:setBarChangeRate(cc.p(1, 0))
    bar:setPercentage(hero.strengthExp / strengthSet.exp * 100)
    num = MRichText.new({
      text = string.format("<div color=#ffffff outline=1,#000000 >%d/%d</div>", curMax, strengthSet.exp),
      size = 16
    }):anch(0.5, 0.5):pos(125, 10):addTo(self.barBg):name("num")
    title = MRichText.new({
      text = string.format("强化进度 <div color=#3a9721>%d/%d</div>", hero.strengthLevel, ExpSet.strengthLevel),
      color = UIHelper.hex2rgb("#703902"),
      size = 20
    }):anch(0.5, 0.5):addTo(self.exp):name("title")
  end
end

function StrengthLayer:showChooseHero()
  local function rule(hero)
    local states = hero:getState()
    
    if states[1] or states[2] or states[3] or hero.id == self.hero0 then
      return true
    end
    if hero.strengthLevel >= heroExpCsv[hero.level].strengthLevel then
      return true
    end
    return false
  end
  
  local function rule1(hero)
    local states = hero:getState()
    if states[1] or states[2] or states[3] or hero.id == self.hero0 then
      return true
    end
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    rule1 = rule1,
    type = 1,
    callback = function(choose)
      local hero = game.role.heros[choose]
      if hero then
        local state = hero:getState()
        if state[1] then
          SysError(SYS_ERR_HERO_LOCKED_CURE_STRENGTHEN)
          return true
        end
        if state[2] then
          SysError(SYS_ERR_HERO_LOCKED_FIGHT_STRENGTHEN)
          return true
        end
        if state[3] then
          SysError(SYS_ERR_HERO_LOCKED_CONSIGNATION_STRENGTHEN)
          return true
        end
        if hero.strengthLevel >= heroExpCsv[hero.level].strengthLevel then
          SysError(SYS_ERR_HERO_STRENGTH_LEVEL_MAX)
          return true
        end
      end
      self.barBg:removeAllChildren()
      self.hero0 = choose
      self.eatList = {}
      self:showMainHero()
      self:showList()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

function StrengthLayer:add()
  if not self.hero0 then
    SysError(SYS_ERR_STRENGTHEN_HERO_CHOOSE)
    return
  end
  local hero = game.role.heros[self.hero0]
  if hero.strengthLevel >= heroExpCsv[hero.level].strengthLevel then
    SysError(SYS_ERR_HERO_STRENGTH_LEVEL_MAX)
    return
  end
  
  local function rule(_hero)
    if _hero.id == self.hero0 or _hero.lock == 1 or _hero.formation > 0 then
      return true
    end
    if _hero.type == globalCsv.evolutionEssence or _hero.type == globalCsv.distillationEssence or _hero.type == globalCsv.awakeEssence then
      return true
    end
  end
  
  local function newrule(heroId)
    local hero = game.role.heros[heroId]
    local state = hero:getState()
    if state[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_STRENGTHEN_CHOOSEN)
      return true
    end
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    choosedList = self.eatList,
    quickChose = true,
    strengthId = self.hero0,
    multiChoose = true,
    rule = rule,
    type = 2,
    callback = function(chooseList)
      self.eatList = {}
      for id, _ in pairs(chooseList) do
        table.insert(self.eatList, id)
      end
      self:showPanel("choose")
      self:showList()
    end,
    newRule = newrule
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

function StrengthLayer:showAnimation(up, old)
  self.maskNode:removeAllChildren()
  local mask = UIHelper.newMask({
    size = cc.size(1877, 854)
  }):addTo(self.maskNode)
  mask:setCallback(function()
  end)
  for _, card in pairs(self.cards) do
    local effect = UIHelper.loadAnimation(strengthRes, "qianghua_card_", 7, 30)
    effect.sprite:scale(1.7857142857142856):center(card):addTo(card)
    effect.sprite:playAnimationOnce(effect.animation, true)
  end
  self.heroNode:runAction(transition.sequence({
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      self:showPanel("send", up)
      self:showList()
    end),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_kuang", 15, 30)
      effect.sprite:center(self.mainBg3):addTo(self.mainBg3)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(0.45),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_fazhen", 50, 30)
      effect.sprite:anch(1, 0):pos(685, 245):addTo(self.mainBg2)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_char", 34, 30)
      effect.sprite:scale(0.7):pos(0, 80):addTo(self.heroNode)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      if up then
        game:createView("kitchen.StrengthUpLevelLayer", {
          id = self.hero0,
          old = old
        })
      end
      self.maskNode:removeAllChildren()
    end)
  }))
end

function StrengthLayer:getTempMaxExp()
  local hero = game.role.heros[self.hero0]
  local addExp = hero.strengthExp
  for _, id in ipairs(self.eatList) do
    local tempHero = game.role.heros[id]
    if tempHero then
      local unitData = unitCsv[tempHero.type]
      addExp = addExp + unitData.strengthExp
    end
  end
  return addExp
end

function StrengthLayer:getCurMaxLevel(addExp)
  local hero = game.role.heros[self.hero0]
  local maxLevel = heroExpCsv[hero.level].strengthLevel
  local curLevel = hero.strengthLevel
  local strengthData = strengthCsv[curLevel]
  local nowExp = addExp
  while nowExp >= strengthData.exp do
    curLevel = curLevel + 1
    if maxLevel <= curLevel then
      nowExp = 0
    else
      nowExp = nowExp - strengthData.exp
      strengthData = strengthCsv[curLevel]
    end
  end
  return curLevel
end

return StrengthLayer
