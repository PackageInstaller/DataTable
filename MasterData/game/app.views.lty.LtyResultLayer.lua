local UnitCsv = require("csvdata.unit")
local ItemCsv = require("csvdata.item")
local HeroExpCsv = require("csvdata.hero_exp")
local CarbonRes = "ui/carbon/carbonresult/"
local ResultRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  widgets = {touch = "touch"}
}
local LtyResultLayer = class("LtyResultLayer", UIBase)

function LtyResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LtyResultLayer:init(params)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.actions = {}
  self.herosInfo = params.herosInfo
  self.reward = params.reward or {}
  self.endReward = params.endReward or {}
  self.win = params.win
  self.herosHurtValue = params.herosHurtValue or {}
  self.dropItems = {}
  for itemId, count in pairs(self.reward) do
    self.dropItems[itemId] = count
  end
  for itemId, count in pairs(self.endReward) do
    self.dropItems[itemId] = (self.dropItems[itemId] or 0) + count
  end
  self.skipAnimation = false
  self.skipLvMusic = false
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.actionNode = display.newNode():center(self):addTo(self)
  self.heroNode = display.newNode():pos(250, 280):addTo(self)
  self.panel = display.newSprite(ResultRes .. "main_bg.png"):anch(0.55, 0.5):pos(1136 + self.dalteX, 395):addTo(self)
  self.buttom = display.newScale9Sprite(ResultRes .. "down.png", 0, 0, cc.size(1136 + self.dalteX * 2, 168)):anch(0, 0):pos(-self.dalteX, 0):addTo(self)
  self.titleBg = display.newSprite(ResultRes .. "title_bg.png"):anch(0, 0.5):pos(-self.dalteX, 570):addTo(self)
  self:initBaseInfo()
  self:initRoleInfo()
  self:initHeroInfo()
end

function LtyResultLayer:showData()
  self:hide()
  self.heros = {}
  for itemId, count in pairs(self.dropItems) do
    if ItemCsv[itemId].type == ItemType.Hero and CommonHelper.showHeroAnimation(itemId - ItemStartId.hero, count) then
      self.heros[itemId] = count
    end
  end
  self:showItems()
end

function LtyResultLayer:initDelay()
  self:show()
  UIHelper.MoveToRight({
    node = self.titleBg,
    time = 0.2
  })
  UIHelper.MoveToRight({
    node = self.heroNode,
    delay = 0.1,
    time = 0.2,
    pos = {250, 0}
  })
  UIHelper.MoveToLeft({
    node = self.panel,
    delay = 0.3,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.buttom,
    delay = 0.5,
    time = 0.3,
    pos = {0, 200}
  })
  local delayTime = 1
  self.touch:setCallback(function()
    if not self.skipAnimation then
      self.skipAnimation = true
      self:resetUI()
    elseif delayTime <= 0 then
      self:nextCallBack()
    end
  end)
  self.actionNode:runAction(transition.sequence({
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      self:initPanelInfo()
      for _, data in ipairs(self.actions) do
        self:barRunAnimation(data)
      end
    end),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self.skipAnimation = true
    end)
  }))
  local time = 5
  local label = display.newTTFLabel({
    text = string.format("%s秒后自动关闭", time),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(568 + self.dalteX, 25):addTo(self.buttom)
  
  local function timeTick()
    self.touch:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if 0 < time then
          label:setString(string.format("%s秒后自动关闭", time))
          time = time - 1
          delayTime = delayTime - 1
          timeTick()
        else
          self:nextCallBack()
        end
      end)
    }))
  end
  
  timeTick()
end

function LtyResultLayer:initBaseInfo()
  local yPos = 310
  display.newSprite(ResultRes .. "front.png"):pos(130, yPos):addTo(self.panel)
  display.newTTFLabel({
    text = game.role.name,
    size = 22,
    color = UIHelper.hex2rgb("#FFF7BC")
  }):anch(0, 0.5):pos(150, yPos):addTo(self.panel)
  display.newSprite(ResultRes .. "txt_result.png"):anch(0, 0.5):pos(10, 35):addTo(self.titleBg)
end

function LtyResultLayer:initRoleInfo()
  local formation = json.decode(game.role.ltyFormatInfo) or {}
  local hpInfo = json.decode(game.role.ltyHerosInfo) or {}
  local heroId = formation.list["1"]
  local hero = game.role.heros[heroId]
  if hero then
    local image = HeroBigCard.new({
      heroId = heroId,
      hp = hpInfo[tostring(heroId)] or 1000,
      quality = hero.quality
    }):anch(0.5, 0):pos(0, -570):addTo(self.heroNode)
    image:setOpacity(0)
    image:runAction(cc.FadeIn:create(0.5))
  end
end

function LtyResultLayer:initPanelInfo()
  local time = self.skipAnimation and 0 or 0.2
  local dtime = self.skipAnimation and 0 or 0.2
  local delay = 0
  local image1 = display.newSprite("ui/carbon/carbonresult/tip2.png"):anch(0, 0.5):pos(85, 260):addTo(self.panel)
  display.newSprite(ResultRes .. "jiesuan_8.png"):pos(64, 20):addTo(image1)
  UIHelper.MoveToLeft({
    node = image1,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  display.newTTFLabel({
    text = string.format("食灵经验+%d%%", 50),
    size = 30,
    color = UIHelper.hex2rgb("#2ee909")
  }):anch(0, 0.5):pos(120, 190):addTo(self.panel)
  local image2 = display.newSprite("ui/carbon/carbonresult/tip2.png"):anch(0, 0.5):pos(85, 115):addTo(self.panel)
  display.newSprite(ResultRes .. "jiesuan_7.png"):pos(64, 20):addTo(image2)
  UIHelper.MoveToLeft({
    node = image2,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  local list = ccui.ListView:create()
  list:size(cc.size(480, 84))
  list:setInnerContainerSize(cc.size(480, 84))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:setDirection(2)
  list:anch(0, 0.5):pos(100, 55):addTo(self.panel)
  for itemId, count in pairs(self.dropItems) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(86, 84)):addTo(list)
    local icon = ItemIcon.new({
      type = itemId,
      count = count,
      showTip = true
    }):scale(0.8):center(viewNode):addTo(viewNode)
    UIHelper.MoveToLeft({
      node = icon,
      delay = delay,
      time = time,
      pos = {480, 0}
    })
    delay = delay + dtime
  end
  list:doLayout()
end

function LtyResultLayer:initHeroInfo()
  local formation = json.decode(game.role.ltyFormatInfo) or {}
  local hpInfo = json.decode(game.role.ltyHerosInfo) or {}
  formation.list = formation.list or {}
  local xPos = 568 + self.dalteX - (table.nums(formation.list) - 1) / 2 * 220
  local allHurt = 0
  for _, value in pairs(self.herosHurtValue) do
    allHurt = allHurt + value
  end
  for index = 1, 5 do
    local heroId = formation.list[tostring(index)]
    if heroId then
      local head = self:createHeroHead({
        hero = game.role.heros[heroId],
        info = self.herosInfo[heroId],
        hpPercent = hpInfo[tostring(heroId)] or 1000,
        heroHurt = self.herosHurtValue[heroId],
        allHurt = allHurt
      }):anch(0.5, 0.5):pos(xPos, 120):addTo(self.buttom)
      xPos = xPos + 220
    end
  end
end

function LtyResultLayer:showItems()
  if next(self.heros) then
    MedalRewardLayer.new({
      items = self.heros,
      callback = function()
        self:initDelay()
      end
    })
  else
    self:initDelay()
  end
end

function LtyResultLayer:nextCallBack()
  game:enterScene("LtyScene", {
    success = self.win
  })
end

function LtyResultLayer:resetUI()
  local xPos = {
    0,
    250,
    1136 + self.dalteX
  }
  for idx, name in ipairs({
    "titleBg",
    "heroNode",
    "panel",
    "buttom"
  }) do
    self[name]:stopAllActions()
    self[name]:setOpacity(255)
    if idx == 4 then
      self[name]:setPositionY(0)
    else
      self[name]:setPositionX(xPos[idx])
    end
  end
end

function LtyResultLayer:createHeroHead(params)
  local hero = params.hero
  local unit = UnitCsv[hero.type]
  local attrs = hero:getTotalAttrValues()
  local info = params.info or {
    origLevel = hero.level,
    origExp = hero.exp
  }
  local hpPercent = params.hpPercent
  local isRed = hpPercent <= 300
  local heroHurt = params.heroHurt or 0
  local allHurt = params.allHurt == 0 and 1 or params.allHurt
  local content = display.newSprite(ResultRes .. (isRed and "new_head_frame_big1.png" or "new_head_frame_big.png"))
  local size = content:getContentSize()
  display.newTTFLabel({
    text = hero:getName(),
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 1):pos(10, 0):addTo(content)
  display.newSprite(UIHelper.getCardRes("cutin", hero:getDressType(), nil, hero.quality)):pos(size.width / 2, 101):addTo(content)
  display.newTTFLabel({
    text = "生命",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(2, 52):addTo(content)
  local lv = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(2, 29):addTo(content)
  display.newTTFLabel({
    text = "伤害",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(2, 6):addTo(content)
  local hpBarBg = display.newSprite(ResultRes .. "new_hero_slot.png"):anch(0, 0):pos(60, 52):addTo(content)
  local hpBar = display.newProgressTimer(ResultRes .. (isRed and "new_hero_red_bar.png" or "new_hero_hp_bar.png"), 1):center(hpBarBg):addTo(hpBarBg)
  hpBar:setBarChangeRate(cc.p(1, 0))
  hpBar:setMidpoint(cc.p(0, 0.5))
  hpBar:setPercentage(hpPercent / 10)
  local hp = attrs.hp * hpPercent / 1000
  hp = 500 < hpPercent and math.floor(hp) or math.ceil(hp)
  display.newTTFLabel({
    text = string.format("%d/%d", hp, attrs.hp),
    size = 14,
    color = display.COLOR_WHITE
  }):pos(0, 10):anch(0, 0):addTo(hpBarBg)
  local expBarBg = display.newSprite(ResultRes .. "new_hero_slot.png"):anch(0, 0):pos(60, 29):addTo(content)
  local expBar = display.newProgressTimer(ResultRes .. "new_hero_exp_bar.png", 1):center(expBarBg):addTo(expBarBg)
  expBar:setBarChangeRate(cc.p(1, 0))
  expBar:setMidpoint(cc.p(0, 0.5))
  if hero.level >= hero:getLevelLimit() then
    expBar:setPercentage(100)
    display.newTTFLabel({
      text = "max",
      size = 14,
      color = display.COLOR_WHITE
    }):pos(0, 10):anch(0, 0):addTo(expBarBg)
  else
    expBar:setPercentage(info.origExp / HeroExpCsv[info.origLevel].exp * 100)
    display.newTTFLabel({
      text = string.format("%d/%d", hero.exp, HeroExpCsv[hero.level].exp),
      size = 14,
      color = display.COLOR_WHITE
    }):pos(0, 10):anch(0, 0):addTo(expBarBg)
  end
  local expLabel = display.newTTFLabel({
    text = "",
    size = 14,
    color = UIHelper.hex2rgb("09fe09")
  }):pos(138, 5):anch(1, 0):addTo(expBarBg)
  local hurtBarBg = display.newSprite(ResultRes .. "new_hero_slot.png"):anch(0, 0):pos(60, 6):addTo(content)
  local hurtBar = display.newProgressTimer(ResultRes .. "new_hero_hurt_bar.png", 1):center(hurtBarBg):addTo(hurtBarBg)
  hurtBar:setBarChangeRate(cc.p(1, 0))
  hurtBar:setMidpoint(cc.p(0, 0.5))
  hurtBar:setPercentage(heroHurt / allHurt * 100)
  display.newTTFLabel({
    text = string.format("%d/%d", heroHurt, params.allHurt),
    size = 14,
    color = display.COLOR_WHITE
  }):pos(0, 10):anch(0, 0):addTo(hurtBarBg)
  table.insert(self.actions, {
    bar = expBar,
    upLevel = hero.exp - (info.exp or 0) <= 0,
    maxLevel = hero.level >= hero:getLevelLimit(),
    addExp = info.exp,
    endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100,
    label = expLabel,
    lv = lv,
    num = hero.level,
    who = 1
  })
  return content
end

function LtyResultLayer:barRunAnimation(params)
  local seq, time = {}, self.skipAnimation and 0 or 0.5
  table.insert(seq, cc.DelayTime:create(1))
  if params.maxLevel then
    if 0 < params.addExp then
      table.insert(seq, cc.CallFunc:create(function()
        UIHelper.numVaryEffect({
          node = params.label,
          repeatTimes = 10,
          stringFormat = "+%d",
          endNum = 0,
          effectTime = time
        })
      end))
    end
  elseif 0 < params.addExp then
    table.insert(seq, cc.CallFunc:create(function()
      UIHelper.numVaryEffect({
        node = params.label,
        repeatTimes = 10,
        stringFormat = "+%d",
        endNum = params.addExp,
        effectTime = time
      })
    end))
  end
  if 0 < params.addExp then
    if params.upLevel then
      time = time / 2
      table.insert(seq, cc.ProgressTo:create(time / 4, 100))
      table.insert(seq, cc.ProgressTo:create(0, 0))
      table.insert(seq, cc.CallFunc:create(function()
        params.lv:setString("Lv" .. params.num)
        if params.who == 1 then
          local levelUp = UIHelper.loadAnimation("battleEff/carbon/", "level_up", 47, 30)
          levelUp.sprite:pos(100, 138):addTo(params.lv:getParent())
          levelUp.sprite:playAnimationOnce(levelUp.animation, true)
        end
        if not self.skipLvMusic then
          self.skipLvMusic = true
          game:playMusic(1002)
        end
      end))
      table.insert(seq, cc.DelayTime:create(time / 5))
    end
    table.insert(seq, cc.ProgressTo:create(time / 2, params.maxLevel and 100 or params.endProcess))
  end
  params.bar:runAction(cc.Sequence:create(seq))
end

return LtyResultLayer
