local UnitDataSet = require("csvdata.unit")
local HeroExpCsv = require("csvdata.hero_exp")
local EvolutionCsv = require("csvdata.evolution")
local EffectCsv = require("csvdata.love_effect")
local globalRes = "ui/global/"
local heroDetailRes = "ui/hero/detail/"
local SmallCard = class("SmallCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function SmallCard:ctor(params)
  self.cure = params.cure
  self.love = params.showLove
  self.tower = params.tower
  self.strength = params.strength
  self.tree = params.tree
  self.hero = params.hero or game.role.heros[params.heroId]
  self.hpPercent = params.hpPercent or self.hero.hpPercent
  self.type = self.hero:getDressType()
  self.unitData = UnitDataSet[self.type]
  self:uiLayout()
  self.clickCallback = params.callback
  self._scale = 1
end

function SmallCard:uiLayout()
  local hero = self.hero
  local quality = hero.quality
  local attrValues = hero:getTotalAttrValues()
  self:setImage(globalRes .. string.format("small_card_bg_%d.png", quality))
  local size = self:getContentSize()
  local herosInfo = json.decode(game.role.towerData.herosInfo)
  local hp, big
  hp = attrValues.hp * self.hpPercent / 1000
  hp = self.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  big = self.hpPercent <= 300
  UIHelper.newImageView(UIHelper.getCardRes("book", self.unitData.type, big, self.hero.quality)):scale(0.92):pos(size.width / 2, 146):addTo(self)
  local isAdvanceMax = hero:isSauceAdvanceMax()
  display.newTTFLabel({
    text = string.format("Lv%d", self.hero.level),
    size = 24,
    color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#000000")
  }):enableOutline(UIHelper.hex2rgb(isAdvanceMax and "#000000" or "#ffffff"), isAdvanceMax and 1 or 2):anch(0, 0.5):pos(10, 108):addTo(self)
  local awakeLogoPath = CommonHelper.getAwakeTypePath(self.hero.id)
  if awakeLogoPath then
    display.newSprite(string.format("ui/hero/awake/awake%d.png", awakeLogoPath)):pos(170, 109):addTo(self)
  end
  local starBg = UIHelper.newImageView(string.format(globalRes .. "star_bg_%d.png", quality)):pos(98, 85):addTo(self)
  local star, xInterval = self.unitData.star, 20
  local temStar = math.min(star, 5)
  local xBegin = starBg:getContentSize().width / 2 - (temStar - 1) * xInterval / 2 + 1
  local bMax = hero:isTreeMax()
  local isBlack = hero:isBlackHero()
  local isMengJing = hero:isMengJingHero()
  local isShengcan = hero:isShengcanHero()
  if isShengcan then
    for index = 1, temStar do
      local starName = bMax and "star_tree_red.png" or "star.png"
      UIHelper.newImageView(globalRes .. starName):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  else
    for index = 1, temStar do
      local starName = bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png"
      UIHelper.newImageView(globalRes .. starName):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  end
  UIHelper.newText({
    text = self.hero:getName(),
    size = 20
  }):pos(size.width / 2, 57):addTo(self):enableOutline(display.COLOR_BLACK, 1)
  if self.cure then
    UIHelper.newText({
      text = "治疗时间: ",
      size = 16,
      color = display.COLOR_BLACK
    }):pos(9, 38):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
    UIHelper.newText({
      text = UIHelper.getTimeStr(hero:getCureTime()),
      size = 16,
      color = UIHelper.hex2rgb("#267f03")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):pos(90, 38):anch(0, 0.5):addTo(self)
  elseif self.strength then
    UIHelper.newText({
      text = string.format("强化进度: %d/%d", self.hero.strengthLevel, self.hero.level),
      size = 16,
      color = display.COLOR_BLACK
    }):pos(9, 38):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
  elseif self.love then
    UIHelper.newText({
      text = "好感度: " .. math.floor(self.hero.love),
      size = 16,
      color = display.COLOR_BLACK
    }):pos(9, 38):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
  elseif self.tree then
    UIHelper.newText({
      text = "天赋阶段: " .. self.hero:getTreeStep(),
      size = 16,
      color = display.COLOR_BLACK
    }):pos(9, 38):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
  else
    UIHelper.newText({
      text = "美味度: " .. self.hero:getAllValue(),
      size = 16,
      color = display.COLOR_BLACK
    }):pos(9, 38):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
  end
  UIHelper.newText({
    text = "生命:",
    size = 16,
    color = display.COLOR_BLACK
  }):pos(10, 20):enableOutline(display.COLOR_WHITE, 1):anch(0, 0.5):addTo(self)
  local hpBarBg = UIHelper.newImageView(heroDetailRes .. "bgbar.png"):pos(116, 19):addTo(self)
  local hpBar = display.newProgressTimer(heroDetailRes .. (big and "hpbar_red.png" or "hpbar.png"), 1):center(hpBarBg):addTo(hpBarBg)
  hpBar:setMidpoint(cc.p(0, 0.5))
  hpBar:setBarChangeRate(cc.p(1, 0))
  hpBar:setPercentage(self.hpPercent / 10)
  UIHelper.newText({
    text = string.format("%d/%d", hp, attrValues.hp),
    size = 16,
    color = display.COLOR_WHITE
  }):enableOutline(UIHelper.hex2rgb("#3d0235"), 1):center(hpBarBg):addTo(hpBarBg)
  self.marryBg = display.newSprite(globalRes .. "small_card_marry_bg.png"):center(self):addTo(self)
  if 5 <= self.hero.loveBreak then
    display.newSprite(globalRes .. "small_card_marry.png"):center(self.marryBg):addTo(self.marryBg)
    local sweep = UIHelper.loadAnimation(globalRes, "small_card_love_effect", 30, 15)
    sweep.sprite:center(self.marryBg):addTo(self.marryBg)
    sweep.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
    sweep.sprite:runAction(cc.RepeatForever:create(transition.sequence({
      cc.DelayTime:create(math.randomFloat(0.5, 3)),
      cc.Animate:create(sweep.animation),
      cc.DelayTime:create(1)
    })))
  elseif hero.loveBreak == 4 and hero.love == EffectCsv[4].fullValue then
    self.heart = display.newSprite(globalRes .. "heart.png"):anch(0.5, 0):pos(34, 131):addTo(self.marryBg)
    self.heart:runAction(cc.RepeatForever:create(transition.sequence({
      cc.RotateBy:create(0.05, -10),
      cc.RotateBy:create(0.1, 20),
      cc.RotateBy:create(0.1, -20),
      cc.RotateBy:create(0.05, 10),
      cc.DelayTime:create(2)
    })))
  end
  if not self.tower then
    local state = hero:getState()
    if state[1] then
      UIHelper.newImageView(globalRes .. "treat_1.png"):scale(0.92):pos(size.width / 2, 114):addTo(self)
    elseif state[2] then
      UIHelper.newImageView(globalRes .. "battle_1.png"):scale(0.92):pos(size.width / 2, 114):addTo(self)
    elseif state[3] then
      UIHelper.newImageView(globalRes .. "entrust_1.png"):scale(0.92):pos(size.width / 2, 114):addTo(self)
    end
    if self.hero.formation ~= 0 then
      local formatBg = UIHelper.newImageView(globalRes .. "title_bg.png"):pos(50, 193):addTo(self)
      local xPos = self.hero.formation == 4 and 17 or 18
      UIHelper.newText({
        text = self.hero.formation,
        size = 24,
        color = display.COLOR_WHITE
      }):enableOutline(display.COLOR_BLACK, 1):pos(xPos, 22):addTo(formatBg)
      UIHelper.newText({
        text = "套餐",
        size = 18,
        color = display.COLOR_WHITE
      }):enableOutline(display.COLOR_BLACK, 1):pos(60, 20):addTo(formatBg)
      if self.hero.captain then
        UIHelper.newImageView(globalRes .. "captain.png"):anch(0, 0.5):pos(-7, 180):addTo(self)
      end
    end
  end
  if self.hero.lock == 1 then
    UIHelper.newImageView(globalRes .. "lock.png"):pos(175, 37):addTo(self):name("lockIcon")
  end
  local proTag = UIHelper.getProfessionTag(self.unitData.profession, quality, 18, self.hero:showTreeTag()):scale(0.9):pos(176, 193):addTo(self)
  if self.clickCallback then
    self:setCallback(self.clickCallback)
  end
end

function SmallCard:checkLock()
  local heroId = self.hero.id
  self.hero = game.role.heros[heroId]
  local lock = self:getChildByName("lockIcon")
  if self.hero.lock == 1 and not lock then
    UIHelper.newImageView(globalRes .. "lock.png"):pos(189, 43):addTo(self):name("lockIcon")
  end
  if self.hero.lock == 0 and lock then
    lock:removeSelf()
  end
end

function SmallCard:setForcetouch(forcetouch, time)
  time = time or 1
  self:setCallbackTotal(function(sender)
    self.touchBegin = socket.gettime()
    self.touchPos = sender:getTouchBeganPosition()
    self:clearTimeHandler()
    self:setScale(self._scale * 0.95)
    self.timeHandler = scheduler.performWithDelayGlobal(forcetouch, time)
  end, function(sender)
    local pos = sender:getTouchMovePosition()
    if math.abs(pos.y - self.touchPos.y) > 5 then
      self.touchCancel = true
    end
    if self.touchCancel then
      self:clearTimeHandler()
    end
  end, function(sender)
    self:clearTimeHandler()
    if self.touchCancel then
      self.touchCancel = nil
      return
    end
    if socket.gettime() - self.touchBegin < time and self.clickCallback then
      self.clickCallback()
    end
  end, function(sender)
    self.touchCancel = nil
    self:clearTimeHandler()
  end)
end

function SmallCard:clearTimeHandler()
  if self.timeHandler then
    scheduler.unscheduleGlobal(self.timeHandler)
    self.timeHandler = nil
  end
  self:setScale(self._scale)
end

function SmallCard:setNormalTouch(callback)
  self.clickCallback = callback
  self:setCallback(self.clickCallback)
end

function SmallCard:checkMarry()
  local heroId = self.hero.id
  self.hero = game.role.heros[heroId]
  if self.hero.loveBreak ~= 5 then
    return
  end
  if tolua.isnull(self.heart) then
    return
  end
  self.heart:stopAllActions()
  self.heart:removeSelf()
  display.newSprite(globalRes .. "small_card_marry.png"):center(self.marryBg):addTo(self.marryBg)
  local sweep = UIHelper.loadAnimation(globalRes, "small_card_love_effect", 30, 15)
  sweep.sprite:center(self.marryBg):addTo(self.marryBg)
  sweep.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
  sweep.sprite:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(math.randomFloat(0.5, 3)),
    cc.Animate:create(sweep.animation),
    cc.DelayTime:create(1)
  })))
end

function SmallCard:scale(value)
  self._scale = value
  self:setScale(self._scale)
  return self
end

return SmallCard
