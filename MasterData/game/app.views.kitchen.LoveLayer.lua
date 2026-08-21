local LoveCsv = require("csvdata.love_plus")
local LoveExpCsv = require("csvdata.love_exp")
local ItemCsv = require("csvdata.item")
local EffectCsv = require("csvdata.love_effect")
local StoryBookCsv = require("csvdata.storybook")
local unitCsv = require("csvdata.unit")
local LoveExtraCsv = require("csvdata.love_extra")
local expCsv = require("csvdata.hero_exp")
local LoveInnateCsv = require("csvdata.love_innate")
local evolutionCsv = require("csvdata.evolution")
local DetailRes = "ui/hero/detail/"
local LoveRes = "ui/kitchen/love/"
local GlobalRes = "ui/global/"
local uiData = {
  csbFile = "ui/kitchen/LoveLayer.csb",
  widgets = {
    touch = "touch",
    heroNode = "heroNode",
    innateBg = "innateBg",
    innateLv = "innateBg/level",
    infoBg = "infoBg",
    name = "infoBg/name",
    level = "infoBg/level",
    desc = "infoBg/desc",
    text2 = "infoBg/text2",
    loveNode = "infoBg/loveNode",
    barBg = "infoBg/barBg",
    bar = "infoBg/barBg/bar",
    desc1 = "infoBg/desc1",
    text3 = "infoBg/text3",
    barBg1 = "infoBg/barBg1",
    bar1 = "infoBg/barBg1/bar",
    itemsBg = "itemsBg",
    btnLove = "itemsBg/btnLove",
    btnOther = "itemsBg/btnOther",
    btnExp = "itemsBg/btnExp",
    btnInnate = "itemsBg/btnInnate",
    itemsList = "itemsBg/itemsList",
    listBg = "listBg",
    descList = "listBg/descList",
    btnGift = "btnGift",
    btnAttr = "btnAttr",
    btnEvent = "btnEvent",
    btnChange = "btnChange"
  }
}
local Values = {
  [1] = {
    limit = 10,
    state = "moren",
    res = "spine/story/maopao_yinfu"
  },
  [2] = {
    limit = 60,
    state = "xi",
    res = "spine/story/maopao_aixin"
  },
  [3] = {
    limit = 100,
    state = "xiu",
    res = "spine/story/maopao_lianhong"
  }
}
local names = {
  [1] = "btnLove",
  [2] = "btnOther",
  [3] = "btnExp",
  [4] = "btnGift",
  [5] = "btnAttr",
  [6] = "btnEvent",
  [7] = "btnInnate"
}
local LoveLayer = class("LoveLayer", UIBase)

function LoveLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LoveLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.btnChange:setPositionX(self.btnChange:getPositionX() + 125)
    self.btnGift:setPositionX(self.btnGift:getPositionX() + 125)
    self.btnAttr:setPositionX(self.btnAttr:getPositionX() + 125)
    self.btnEvent:setPositionX(self.btnEvent:getPositionX() + 125)
  end
  self.hero = params.hero
  self.loveBreak = 0
  self.sendWaiting = false
  self.group1 = MRadioGroup:create()
  self.group2 = MRadioGroup:create()
  self.btnLove:setLocalZOrder(-1)
  self.btnOther:setLocalZOrder(-1)
  for index, name in ipairs(names) do
    local btn = self[name]
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#490909"), 1)
    btn:name("btn" .. index)
    if index < 4 or index == 7 then
      btn:setGroup(self.group1)
      btn:setCallback(function()
        self:showItems(index)
      end)
    else
      btn:setTouchScale()
      btn:setGroup(self.group2)
    end
  end
  
  local function rule(hero)
    if self.hero and hero.id == self.hero.id or LoveCsv[hero.type].limit == 0 then
      return true
    end
    if hero.love == EffectCsv[hero.loveBreak].fullValue or hero.loveBreak >= LoveCsv[hero.type].limit then
      return true
    end
    return false
  end
  
  local function rule1(hero)
    if self.hero and hero.id == self.hero.id or LoveCsv[hero.type].limit == 0 then
      return true
    end
    return false
  end
  
  self.btnChange:hide()
  self.btnChange:setTouchScale()
  self.btnChange:setCallback(function()
    if self.bChange then
      return
    end
    local layer = game:createView("hero.ChooseHeroLayer", {
      rule = rule,
      rule1 = rule1,
      love = true,
      type = 7,
      callback = function(choose)
        self.index = nil
        self.hero = game.role.heros[choose]
        self.expValue:setString("")
        self:showData()
      end
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "食灵")
    end)
  end)
  self.btnEye = UIHelper.extend(ccui.Button:create())
  self.btnEye:setImages("ui/home/btns/", {"eye_a.png", "eye_a.png"})
  self.btnEye:pos(55, 35):addTo(self)
  self.btnEye:setTouchScale()
  self.btnEye:setCallback(function()
    self:changeUI()
  end)
  self.btnGift:setCallback(function()
    if self.bChange then
      return
    end
    self:showGift()
  end)
  self.btnAttr:setCallback(function()
    if self.bChange then
      return
    end
    self:showAttr()
  end)
  self.btnEvent:setCallback(function()
    if self.bChange then
      return
    end
    self:showEvent()
  end)
  self.group1:chooseByName("btn1")
  self.group2:chooseByName("btn4")
end

function LoveLayer:showData(params)
  self.heroNode:removeAllChildren()
  if not self.hero then
    local function rule(hero)
      if LoveCsv[hero.type].limit == 0 then
        return true
      end
      if hero.love == EffectCsv[hero.loveBreak].fullValue or hero.loveBreak >= LoveCsv[hero.type].limit then
        return true
      end
      return false
    end
    
    local function rule1(hero)
      if self.hero and hero.id == self.hero.id or LoveCsv[hero.type].limit == 0 then
        return true
      end
      return false
    end
    
    local function newLayer()
      local layer = game:createView("hero.ChooseHeroLayer", {
        rule = rule,
        rule1 = rule1,
        love = true,
        type = 7,
        callback = function(choose)
          self.hero = game.role.heros[choose]
          self.btnChange:show()
          self:showData()
        end
      })
      BackManager:push(function()
        layer:close()
        TopBar:show(TopBarType.full, "食灵")
      end)
    end
    
    local addBg = UIHelper.newImageView(LoveRes .. "add_bg.png"):pos(0, 0):addTo(self.heroNode)
    addBg:setCallback(function()
      newLayer()
    end)
    local circle = display.newSprite(LoveRes .. "circle.png"):pos(0, 0):addTo(self.heroNode)
    circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
    local btn = UIHelper.extend(ccui.Button:create()):name("chooseHeroBtn")
    btn:setImages(LoveRes, {
      "btn_add.png",
      "btn_add.png"
    })
    btn:setTouchScale()
    btn:pos(3, 9):addTo(self.heroNode)
    btn:setCallback(function()
      newLayer()
    end)
    if UIHelper.isiPhoneX() then
      UIHelper.fitForiPhoneX(addBg)
      addBg:setPositionX(addBg:getPositionX() + 115)
      circle:setPositionX(circle:getPositionX() + 115)
      btn:setPositionX(btn:getPositionX() + 115)
    end
    local nodes = {
      "infoBg",
      "itemsBg",
      "listBg",
      "btnChange",
      "btnGift",
      "btnAttr",
      "btnEvent",
      "btnEye",
      "innateBg"
    }
    for _, node in pairs(nodes) do
      self[node]:hide()
    end
    UIHelper.MoveToLeft({
      node = self.heroNode,
      time = 0.3,
      pos = {200, 0}
    })
  else
    if self.hero.unit.star ~= 6 then
      self.btnInnate:hide()
      self.innateBg:hide()
    else
      self.btnInnate:show()
      self.innateBg:show()
      self.innateLv:setString("Lv" .. self.hero.innate + evolutionCsv[self.hero.quality].innateLevel)
      UIHelper.MoveToRight({
        node = self.innateBg,
        time = 0.2
      })
    end
    self.group1:chooseByName("btn1")
    self.group2:chooseByName("btn4")
    self:showItems(1)
    self.heroSpine = UIHelper.createHeroCard(self.hero.type, {}):pos(-50, -430):addTo(self.heroNode)
    self.heroSpine:setToSetupPose()
    self.heroSpine:setAnimation(0, "moren", true)
    self:initHeroInfo()
    local shows = {
      "infoBg",
      "itemsBg",
      "btnGift",
      "btnAttr",
      "btnEvent",
      "btnEye"
    }
    for _, node in pairs(shows) do
      self[node]:show()
    end
    self.listBg:hide()
    self.loveBreak = 0
    local heroBooks = game.role.storyBook["2"] or {}
    for id, data in pairs(heroBooks) do
      local storySet = StoryBookCsv[2][tonumber(id)]
      if storySet.style == self.hero.type then
        self.loveBreak = data.loveBreak
        break
      end
    end
    if not self.first then
      self.first = true
      UIHelper.MoveToRight({
        node = self.btnEye,
        time = 0.2,
        offset = {250, 0}
      })
      UIHelper.MoveToRight({
        node = self.infoBg,
        time = 0.2,
        offset = {500, 0}
      })
      UIHelper.MoveToUp({
        node = self.itemsBg,
        time = 0.2,
        offset = {500, 0}
      })
      local btnNames = {
        "btnGift",
        "btnAttr",
        "btnEvent",
        "btnChange"
      }
      for _, name in pairs(btnNames) do
        UIHelper.MoveToLeft({
          node = self[name],
          time = 0.2,
          offset = {150, 0}
        })
      end
    end
  end
end

function LoveLayer:initHeroInfo()
  self.name:removeAllChildren()
  self.text2:removeAllChildren()
  self.name:setString(self.hero:getName())
  self.level:setString("Lv" .. self.hero.level)
  display.newSprite(LoveRes .. string.format("profession_%d.png", self.hero.unit.profession)):pos(-15, 10):addTo(self.name)
  self.desc:setString(LoveCsv[self.hero.type].desc)
  self.loveValue = MRichText.new({
    text = string.format("<div color=4ea409>%d</div>/%d", 0, 0),
    size = 18,
    color = UIHelper.hex2rgb("#ff474f")
  }):anch(0, 0.5):pos(62, 8):addTo(self.text2)
  self.expValue = MRichText.new({
    text = "",
    size = 18,
    color = UIHelper.hex2rgb("#ff474f")
  }):anch(0, 0.5):pos(80, 8):addTo(self.text3)
  self:showHeart()
  self:showLoveExp()
end

function LoveLayer:showLoveExp()
  local curLevel = self.hero.level
  if curLevel >= self.hero:getLevelLimit() then
    self.bar1:setPercent(100)
    local expStr = "max"
    self.expValue:setString(expStr)
  else
    self.bar1:setPercent(self.hero.exp / expCsv[self.hero.level].exp * 100)
    local expStr = string.format("<div color=4ea409>%d</div>/%d", self.hero.exp, expCsv[self.hero.level].exp)
    self.expValue:setString(expStr)
  end
  self.level:setString("Lv" .. self.hero.level)
end

function LoveLayer:showHeart()
  local limit = LoveCsv[self.hero.type].limit
  if limit <= self.hero.loveBreak then
    self.loveValue:setString("MAX")
    self.barBg:hide()
  else
    local str = string.format("<div color=#4ea409>%d</div>/%d", math.floor(self.hero.love), EffectCsv[self.hero.loveBreak].fullValue)
    self.loveValue:setString(str)
    self.barBg:show()
    local preData = EffectCsv[self.hero.loveBreak - 1] or {fullValue = 0}
    local curData = EffectCsv[self.hero.loveBreak]
    self.bar:setPercent((self.hero.love - preData.fullValue) / (curData.fullValue - preData.fullValue) * 100)
  end
  self.loveNode:removeAllChildren()
  local heart = display.newSprite("ui/global/heart.png"):pos(0, 0):addTo(self.loveNode)
  display.newTTFLabel({
    text = math.min(limit, self.hero.loveBreak),
    size = 24,
    color = UIHelper.hex2rgb("#5b0a15")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
  if self.hero.loveBreak >= 5 then
    display.newSprite("ui/global/marry.png"):center(heart):addTo(heart)
  end
end

function LoveLayer:showItems(btnType)
  self.itemsList:removeAllChildren()
  self.delay = 0
  local canCrit = game.role:activityIsOpen(41)
  local items, size = {}, cc.size(115, 90)
  local expItems, size = {}, cc.size(115, 90)
  local innateItems, size = {}, cc.size(115, 90)
  local data = LoveCsv[self.hero.type]
  local prefers = data.prefer:toNumMap()
  for id, num in pairs(game.role.items) do
    if (ItemCsv[id].type == ItemType.LoveItem or ItemCsv[id].type == ItemType.PangCi) and (btnType == 1 and prefers[id] or btnType == 2 and not prefers[id]) then
      table.insert(items, {id = id, num = num})
    end
    if ItemCsv[id].type == ItemType.LoveExp and btnType == 3 and LoveExpCsv[id] then
      table.insert(expItems, {id = id, num = num})
    end
    if ItemCsv[id].type == ItemType.InnateItem and btnType == 7 and LoveInnateCsv[id] then
      table.insert(innateItems, {id = id, num = num})
    end
  end
  if not (next(items) and next(expItems)) or not next(innateItems) then
    local text
    
    local function genTxt()
      local bg = display.newSprite(LoveRes .. "no_tip_bg.png"):center(self.itemsList):addTo(self.itemsList)
      display.newTTFLabel({
        text = text,
        size = 18,
        color = UIHelper.hex2rgb("#592c0c")
      }):center(bg):addTo(bg)
    end
    
    if not next(items) and btnType < 3 then
      text = btnType == 1 and "暂时没有偏爱礼物" or "暂时没有其他礼物"
      genTxt()
    end
    if not next(expItems) and btnType == 3 then
      text = "暂时没有加经验礼物"
      genTxt()
    end
    if not next(innateItems) and btnType == 7 then
      text = "暂时没有升级天赋礼物"
      genTxt()
    end
    self.itemsList:requestDoLayout()
    if not next(items) and not next(expItems) and not next(innateItems) then
      return
    end
  end
  for index, data in ipairs(items) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.itemsList)
    local card = ItemIcon.new({
      type = data.id,
      count = 1
    }):pos(50, 42):addTo(viewNode)
    local num = display.newTTFLabel({
      text = data.num,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(card)
    local nameBg = display.newSprite(LoveRes .. "name_bg.png"):pos(100, 45):addTo(card)
    MRichText.new({
      text = ItemCsv[data.id].name,
      size = 14,
      maxWidth = 20
    }):anch(0.5, 0.5):pos(11, 40):addTo(nameBg)
    nameBg:setLocalZOrder(-1)
    if canCrit and LoveExtraCsv[data.id] then
      display.newSprite(LoveRes .. "image_up.png"):pos(77, 75):addTo(card)
    end
    card:setCallbackTotal(function(sender)
      self.addHandler = scheduler.scheduleGlobal(function()
        self:addValue(prefers[data.id], num, data.id, btnType)
      end, 0.05)
    end, nil, function(sender)
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self.delay = 1
      self:addValue(prefers[data.id], num, data.id, btnType)
      self.delay = 0
      self.sendWaiting = false
    end, function(sender)
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self.delay = 0
      self.sendWaiting = false
    end)
    self.itemsList:requestDoLayout()
  end
  if btnType == 3 then
    for index, data in ipairs(expItems) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.itemsList)
      local card = ItemIcon.new({
        type = data.id,
        count = 1
      }):pos(50, 42):addTo(viewNode)
      local num = display.newTTFLabel({
        text = data.num,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(card)
      local nameBg = display.newSprite(LoveRes .. "name_bg.png"):pos(100, 45):addTo(card)
      MRichText.new({
        text = ItemCsv[data.id].name,
        size = 14,
        maxWidth = 20
      }):anch(0.5, 0.5):pos(11, 40):addTo(nameBg)
      nameBg:setLocalZOrder(-1)
      card:setCallbackTotal(function()
        self.addHandler = scheduler.scheduleGlobal(function()
          self:addExpValue(num, data.id)
        end, 0.05)
      end, nil, function(sender)
        if self.addHandler then
          scheduler.unscheduleGlobal(self.addHandler)
        end
        self.delay = 1
        self:addExpValue(num, data.id)
        self.delay = 0
        self.sendWaiting = false
      end, function(sender)
        if self.addHandler then
          scheduler.unscheduleGlobal(self.addHandler)
        end
        self.delay = 0
        self.sendWaiting = false
      end)
      self.itemsList:requestDoLayout()
    end
  end
  if btnType == 7 then
    for index, data in ipairs(innateItems) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.itemsList)
      local card = ItemIcon.new({
        type = data.id,
        count = 1
      }):pos(50, 42):addTo(viewNode)
      local num = display.newTTFLabel({
        text = data.num,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(card)
      local nameBg = display.newSprite(LoveRes .. "name_bg.png"):pos(100, 45):addTo(card)
      MRichText.new({
        text = ItemCsv[data.id].name,
        size = 14,
        maxWidth = 20
      }):anch(0.5, 0.5):pos(11, 40):addTo(nameBg)
      nameBg:setLocalZOrder(-1)
      card:setCallbackTotal(function()
        self.addHandler = scheduler.scheduleGlobal(function()
          self:addInnateValue(num, data.id)
        end, 0.05)
      end, nil, function(sender)
        if self.addHandler then
          scheduler.unscheduleGlobal(self.addHandler)
        end
        self.delay = 1
        self:addInnateValue(num, data.id)
        self.delay = 0
        self.sendWaiting = false
      end, function(sender)
        if self.addHandler then
          scheduler.unscheduleGlobal(self.addHandler)
        end
        self.delay = 0
        self.sendWaiting = false
      end)
      self.itemsList:requestDoLayout()
    end
  end
end

function LoveLayer:addInnateValue(label, itemId)
  if self.sendWaiting then
    return
  end
  self.delay = self.delay + 0.15
  if self.delay < 1 then
    return
  end
  if self.hero.innate == 14 then
    SysError(SYS_ERR_TALENT_IS_FULL)
    return
  end
  self.sendWaiting = true
  game:sendData(actionCodes.Hero_innateUpByItemRpc, MsgPack.pack({
    mainHeroId = self.hero.id,
    useItemId = itemId
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_innateUpByItemRpc, function(event)
    UIHelper.removeWaiting()
    self.sendWaiting = false
    local count = game.role.items[itemId] or 0
    if not tolua.isnull(label) then
      label:setString(count)
    end
    if count == 0 then
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:showItems(7)
    end
    self.innateLv:setString("Lv" .. self.hero.innate + evolutionCsv[self.hero.quality].innateLevel)
    if not self.animation then
      self:showHeroAnimation(80, 2)
    end
  end)
end

function LoveLayer:addExpValue(label, itemId)
  if self.sendWaiting then
    return
  end
  self.delay = self.delay + 0.15
  if self.delay < 1 then
    return
  end
  local curLevel = self.hero.level
  if curLevel >= self.hero:getLevelLimit() then
    self:showLoveExp()
    SysError(SYS_ERR_FARM_HERO_LEVEL_NOT_ENOUGH)
    return
  end
  self.sendWaiting = true
  game:sendData(actionCodes.Hero_giftExpRpc, MsgPack.pack({
    index = itemId,
    heroId = self.hero.id,
    heroType = self.hero.type
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_giftExpRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.sendWaiting = false
    local count = game.role.items[itemId] or 0
    if not tolua.isnull(label) then
      label:setString(count)
    end
    if count == 0 then
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:showItems(3)
    end
    local Set = globalCsv.giftExpPlus:toNumMap()
    local value = Set[ItemCsv[itemId].star]
    if msg.crit then
      local xPos, yPos = math.random(-150, 150), math.random(-130, 120)
      game:playMusic(1103)
      local animat = UIHelper.loadAnimation(LoveRes, "love_heart", 30, 30)
      animat.sprite:pos(xPos, yPos):addTo(self.heroNode)
      animat.sprite:playAnimationOnce(animat.animation, true)
    end
    self:showLoveExp()
    if not self.animation then
      self:showHeroAnimation(value, 2)
    end
  end)
end

function LoveLayer:addValue(prefer, label, itemId, btnType)
  if self.sendWaiting then
    return
  end
  self.delay = self.delay + 0.15
  if self.delay < 1 then
    return
  end
  if not self:checkCanUseItem() then
    if self.hero.loveBreak == LoveCsv[self.hero.type].limit then
      SysError(SYS_ERR_LOVE_BREAK_LIMIT)
      return
    end
    local tip = LoveCsv[self.hero.type]["full" .. self.hero.loveBreak + 1]
    if tip and tip ~= "" and tolua.isnull(self.dialog) then
      if self.hero.loveBreak == 4 and self.hero.love == EffectCsv[4].fullValue then
        self.dialog = MDialog:single({
          title = "好感度提升",
          text = tip,
          size = 20,
          okText = "确定"
        })
        return
      end
      self.dialog = MDialog:double({
        title = "好感度提升",
        text = tip,
        size = 20,
        okText = "前往",
        okCallback = function()
          game:enterScene("MainScene", {layer = "mission", index = 4})
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end
    return
  end
  self.sendWaiting = true
  game:sendData(actionCodes.Hero_loveItemRpc, MsgPack.pack({
    index = itemId,
    heroId = self.hero.id
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_loveItemRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.sendWaiting = false
    local count = game.role.items[itemId] or 0
    if not tolua.isnull(label) then
      label:setString(count)
    end
    if count == 0 then
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:showItems(btnType)
    end
    self:showHeart()
    local Set = globalCsv.giftPlus:toNumMap()
    local value = Set[ItemCsv[itemId].star]
    if prefer then
      value = math.ceil(Set[ItemCsv[itemId].star] * (1 + globalCsv.preferGift / 100))
    end
    local xPos, yPos = math.random(-150, 150), math.random(-130, 120)
    game:playMusic(1103)
    local animat = UIHelper.loadAnimation(LoveRes, "love_heart", 30, 30)
    animat.sprite:pos(xPos, yPos):addTo(self.heroNode)
    animat.sprite:playAnimationOnce(animat.animation, true)
    if msg.crit then
      local big = UIHelper.createSpineNodeByRes(LoveRes .. "gift_up")
      big:setAnimation(0, "special", false)
      big:center(display.getRunningScene()):addTo(display.getRunningScene())
      if UIHelper.isiPhoneX() then
        UIHelper.fitForiPhoneX(big)
      end
    end
    if not self.animation then
      self:showHeroAnimation(value, 1)
    end
  end)
end

function LoveLayer:showHeroAnimation(value, loveType)
  self.animation = true
  if not value then
    return
  end
  for index, data in ipairs(Values) do
    if value <= data.limit then
      Data = data
      break
    end
  end
  if not Data then
    return
  end
  self.heroSpine:setToSetupPose()
  self.heroSpine:setAnimation(0, Data.state, true)
  local spine = UIHelper.createSpineNodeByRes(Data.res):setScaleX(-1):pos(610, 450):addTo(self)
  spine:setAnimation(0, "moren", true)
  spine:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self.animation = nil
      self.heroSpine:setToSetupPose()
      self.heroSpine:setAnimation(0, "moren", true)
      if loveType == 1 and not self:checkCanUseItem() then
        local tip = LoveCsv[self.hero.type]["full" .. self.hero.loveBreak + 1]
        if tip and tip ~= "" and tolua.isnull(self.dialog) then
          if self.hero.loveBreak == 4 and self.hero.love == EffectCsv[4].fullValue then
            self.dialog = MDialog:single({
              title = "好感度提升",
              text = tip,
              size = 20,
              okText = "确定"
            })
            return
          end
          self.dialog = MDialog:double({
            title = "好感度提升",
            text = tip,
            size = 20,
            okText = "前往",
            okCallback = function()
              game:enterScene("MainScene", {layer = "mission", index = 4})
              return true
            end,
            cancelCallback = function()
              return true
            end
          })
        end
      end
    end),
    cc.RemoveSelf:create()
  }))
end

function LoveLayer:checkCanUseItem()
  local limit = LoveCsv[self.hero.type].limit
  if limit <= self.hero.loveBreak then
    return false
  end
  local effectData = EffectCsv[self.hero.loveBreak]
  if self.hero.loveBreak < 5 and self.hero.love >= effectData.fullValue then
    return false
  end
  return true
end

function LoveLayer:showGift()
  self.itemsBg:show()
  self.listBg:hide()
  UIHelper.MoveToUp({
    node = self.itemsBg,
    time = 0.2
  })
  self.innateBg:runAction(cc.MoveTo:create(0.2, cc.p(203, 401)))
end

function LoveLayer:showAttr()
  self.descList:removeAllChildren()
  local attrs = {
    "hp",
    "atk",
    "phyDef",
    "hit",
    "miss"
  }
  local limit = LoveCsv[self.hero.type].limit
  local unitData = unitCsv[self.hero.type]
  local cellSize = display.newSprite(LoveRes .. "cell_bg_a.png"):getContentSize()
  cellSize.height = cellSize.height
  for id, effectData in ipairs(EffectCsv) do
    if id ~= 1 and id ~= 3 and id <= limit then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cellSize):addTo(self.descList)
      local image = id <= self.hero.loveBreak and "cell_bg_a.png" or "cell_bg_b.png"
      local color = id <= self.hero.loveBreak and UIHelper.hex2rgb("#a84807") or UIHelper.hex2rgb("#b9b9b9")
      local cell = display.newSprite(LoveRes .. image):center(viewNode):addTo(viewNode)
      local heart = display.newSprite("ui/global/heart.png"):pos(42, 71):addTo(cell)
      display.newTTFLabel({
        text = id,
        size = 24,
        color = UIHelper.hex2rgb("#5b0a15")
      }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
      if 5 <= id then
        display.newSprite("ui/global/marry.png"):center(heart):addTo(heart)
      end
      display.newTTFLabel({
        text = "额外增加属性",
        size = 16,
        color = color
      }):anch(0, 0.5):pos(75, 78):addTo(cell)
      local xPos, yPos = 21, 43
      for index, attr in ipairs(attrs) do
        display.newTTFLabel({
          text = string.format("%s+%.01f", AttrDesc[index], (unitData[attr] or 0) * (effectData[attr] or 0)),
          size = 16,
          color = color
        }):anch(0, 0.5):pos(xPos, yPos):addTo(cell)
        xPos = xPos + 85
        if index == 3 then
          xPos = 21
          yPos = 22
        end
      end
    end
  end
  self.descList:requestDoLayout()
  self.descList:jumpToTop()
  self.itemsBg:hide()
  self.listBg:show()
  UIHelper.MoveToRight({
    node = self.listBg,
    time = 0.2
  })
  self.innateBg:runAction(cc.MoveTo:create(0.2, cc.p(203, 471)))
end

function LoveLayer:showEvent()
  self.descList:removeAllChildren()
  local limit = LoveCsv[self.hero.type].limit
  local cellSize = display.newSprite(LoveRes .. "cell_bg_a.png"):getContentSize()
  cellSize.height = cellSize.height
  for id = 1, #EffectCsv do
    local effectData = EffectCsv[id]
    if effectData and id <= limit then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cellSize):addTo(self.descList)
      local image = id <= self.loveBreak and "cell_bg_a.png" or "cell_bg_b.png"
      local color = id <= self.loveBreak and UIHelper.hex2rgb("#a84807") or UIHelper.hex2rgb("#b9b9b9")
      local cell = display.newSprite(LoveRes .. image):center(viewNode):addTo(viewNode)
      local heart = display.newSprite("ui/global/heart.png"):pos(42, 71):addTo(cell)
      display.newTTFLabel({
        text = id,
        size = 24,
        color = UIHelper.hex2rgb("#5b0a15")
      }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
      if 5 <= id then
        display.newSprite("ui/global/marry.png"):center(heart):addTo(heart)
      end
      MRichText.new({
        text = effectData.desc,
        size = 16,
        color = color,
        maxWidth = 275
      }):anch(0, 1):pos(27, 50):addTo(cell)
    end
  end
  self.descList:requestDoLayout()
  self.descList:jumpToTop()
  self.itemsBg:hide()
  self.listBg:show()
  UIHelper.MoveToRight({
    node = self.listBg,
    time = 0.2
  })
  self.innateBg:runAction(cc.MoveTo:create(0.2, cc.p(203, 471)))
end

function LoveLayer:changeUI()
  if not self.bChange then
    self.bChange = true
    self.btnEye:setCallback(function()
    end)
    self.btnEye:runAction(cc.MoveBy:create(0.2, cc.p(-260, 0)))
    self.infoBg:runAction(cc.MoveBy:create(0.2, cc.p(-545, 0)))
    self.listBg:runAction(cc.MoveBy:create(0.2, cc.p(-545, 0)))
    self.itemsBg:runAction(cc.MoveBy:create(0.2, cc.p(0, -200)))
    self.btnChange:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(160, 0)),
      cc.CallFunc:create(function()
        self.touch:setCallback(function()
          self:changeUI()
        end)
      end)
    }))
    for index = 3, 5 do
      self[names[index]]:runAction(cc.MoveBy:create(0.2, cc.p(160, 0)))
    end
  else
    self.touch:setCallback(function()
    end)
    self.btnEye:runAction(cc.MoveBy:create(0.2, cc.p(260, 0)))
    self.infoBg:runAction(cc.MoveBy:create(0.2, cc.p(545, 0)))
    self.listBg:runAction(cc.MoveBy:create(0.2, cc.p(545, 0)))
    self.itemsBg:runAction(cc.MoveBy:create(0.2, cc.p(0, 200)))
    self.btnChange:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(-160, 0)),
      cc.CallFunc:create(function()
        self.bChange = nil
        self.btnEye:setCallback(function()
          self:changeUI()
        end)
      end)
    }))
    for index = 3, 5 do
      self[names[index]]:runAction(cc.MoveBy:create(0.2, cc.p(-160, 0)))
    end
  end
end

return LoveLayer
