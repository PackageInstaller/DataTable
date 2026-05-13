local UnitCsv = require("csvdata.unit")
local HeroExpCsv = require("csvdata.hero_exp")
local ItemCsv = require("csvdata.item")
local MonsterCsv = require("csvdata.monster")
local AutoBattleCsv = require("csvdata.auto_battle")
local ResultRes = "ui/carbon/battleresult/"
local WorldbossRes = "ui/activity/worldboss/"
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  widgets = {touch = "touch"}
}
local NewBattleResultLayer = class("NewBattleResultLayer", UIBase)

function NewBattleResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewBattleResultLayer:init(params)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.actions = {}
  self.roleInfo = params.roleInfo
  self.herosInfo = params.herosInfo
  self.roleAddExp = params.roleAddExp or 0
  self.dropItems = params.dropItems or {}
  self.formatVal = params.format
  self.starNum = params.starNum
  self.enemyDead = params.enemyDead or 0
  self.carbonId = params.carbonId
  self.carbonType = params.carbonType
  self.modeType = params.modeType
  self.autoBattle = params.autoBattle
  self.hurt = params.hurt
  self.herosHurtValue = params.herosHurtValue or {}
  if not self.autoBattle then
    if self.carbonType == BattleType.Moon then
      game.role.moonBattleInfoCache.endResult = params.endResult
      game.role.moonBattleInfoCache.events = params.events
      game.role.moonBattleInfoCache.battle = nil
    elseif self.carbonType == BattleType.Paradise then
      game.role.paradiseBattleInfoCache.endResult = params.endResult
      game.role.paradiseBattleInfoCache.events = params.events
      game.role.paradiseBattleInfoCache.battle = nil
    elseif self.carbonType == BattleType.MJ or self.carbonType == BattleType.EJ or self.carbonType == BattleType.Worldboss or self.carbonType == BattleType.NewWorldboss then
      self.bossType = params.bossType
      self.bossDegree = params.bossDegree
    elseif self.carbonType == BattleType.ShenYuan then
      self.bossType = params.bossType
      self.bossDegree = params.bossDegree
    elseif self.carbonType == BattleType.ActCarbon then
    else
      game.role.battleInfoCache.endResult = params.endResult
      game.role.battleInfoCache.events = params.events
      game.role.battleInfoCache.battle = nil
    end
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

function NewBattleResultLayer:showData(params)
  self:hide()
  self.heros = {}
  for itemId, count in pairs(self.dropItems) do
    if ItemCsv[itemId].type == ItemType.Hero and CommonHelper.showHeroAnimation(itemId - ItemStartId.hero, count) then
      self.heros[itemId] = count
    end
  end
  self:showItems()
end

function NewBattleResultLayer:initDelay()
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
  game:playMusic(0 < self.starNum and 1016 or 1017)
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
  local time = self.autoBattle and 5 or 15
  local label = display.newTTFLabel({
    text = string.format("%d秒后自动关闭", time),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(568 + self.dalteX, 25):addTo(self.buttom)
  
  local function timeTick()
    self.touch:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if 0 < time then
          label:setString(string.format("%d秒后自动关闭", time))
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

function NewBattleResultLayer:initBaseInfo()
  local yPos = 310
  if self.roleAddExp > 0 then
    yPos = 320
  end
  display.newSprite(ResultRes .. "front.png"):pos(130, yPos):addTo(self.panel)
  display.newTTFLabel({
    text = game.role.name,
    size = 22,
    color = UIHelper.hex2rgb("#FFF7BC")
  }):anch(0, 0.5):pos(150, yPos):addTo(self.panel)
  display.newSprite(ResultRes .. "txt_result.png"):pos(141, 35):addTo(self.titleBg)
end

function NewBattleResultLayer:initRoleInfo()
  local formation = game.role.formation[tostring(self.formatVal)]
  local heroId = formation.list["1"]
  local hero = game.role.heros[heroId]
  if hero then
    local image = HeroBigCard.new({
      heroId = heroId,
      quality = hero.quality
    }):anch(0.5, 0):pos(0, -570):addTo(self.heroNode)
    image:setOpacity(0)
    image:runAction(cc.FadeIn:create(0.5))
  end
end

function NewBattleResultLayer:initPanelInfo()
  local time = self.skipAnimation and 0 or 0.2
  local dtime = self.skipAnimation and 0 or 0.2
  local delay = 0
  local image1 = display.newSprite("ui/carbon/carbonresult/tip2.png"):anch(0, 0.5):pos(85, 260):addTo(self.panel)
  display.newSprite(ResultRes .. "jiesuan_6.png"):pos(64, 20):addTo(image1)
  UIHelper.MoveToLeft({
    node = image1,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  if self.carbonType == BattleType.Worldboss then
    display.newTTFLabel({
      text = "造成的总伤害:" .. (self.hurt or 0),
      size = 20,
      color = UIHelper.hex2rgb("#2ee009")
    }):anch(0, 0.5):pos(205, 190):addTo(self.panel)
    display.newTTFLabel({
      text = "x" .. math.min(globalCsv.WorldBossPtMax, math.floor((self.hurt or 0) / globalCsv.WorldBossGiftRole)),
      size = 20,
      color = UIHelper.hex2rgb("#2ee009")
    }):anch(0, 0.5):pos(275, 65):addTo(self.panel)
    display.newSprite(WorldbossRes .. "fragment.png"):anch(0.5, 0.5):scale(0.65):pos(245, 65):addTo(self.panel)
  else
    local desc = {
      "B级:战胜所有敌人",
      "A级:本场战斗队伍总生命损失小于60%",
      "S级:本场战斗队伍总生命损失小于30%"
    }
    for idx = 3, 1, -1 do
      local label = display.newTTFLabel({
        text = desc[idx],
        size = 20,
        color = UIHelper.hex2rgb(idx <= self.starNum and "#2ee009" or "#ababab")
      }):anch(0, 0.5):pos(205, 160 + (idx - 1) * 30):addTo(self.panel)
      UIHelper.MoveToLeft({
        node = label,
        delay = delay,
        time = time,
        pos = {380, 0}
      })
      delay = delay + dtime
    end
    local image3 = display.newSprite(ResultRes .. string.format("point%d.png", self.starNum)):scale(1.5):pos(30, 155):addTo(self.panel)
    image3:setOpacity(0)
    image3:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.CallFunc:create(function()
        game:playMusic(1700)
        image3:setOpacity(255)
      end),
      cc.Spawn:create(cc.MoveTo:create(time, cc.p(150, 187)), cc.ScaleTo:create(time, 0.9))
    }))
  end
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

function NewBattleResultLayer:initHeroInfo()
  local formation = game.role.formation[tostring(self.formatVal)]
  local xPos = 568 + self.dalteX - (table.nums(formation.list) - 1) / 2 * 220
  local allHurt = 0
  for _, value in pairs(self.herosHurtValue) do
    allHurt = allHurt + value
  end
  for index = 1, 5 do
    local heroId = formation.list[tostring(index)]
    if heroId then
      if self.carbonType == BattleType.Worldboss then
        local head = self:boss_CreateHeroHead({
          hero = game.role.heros[heroId],
          info = self.herosInfo[heroId]
        }):anch(0.5, 0.5):pos(xPos, 120):addTo(self.buttom)
      else
        local head = self:createHeroHead({
          hero = game.role.heros[heroId],
          info = self.herosInfo[heroId],
          heroHurt = self.herosHurtValue[heroId],
          allHurt = allHurt
        }):anch(0.5, 0.5):pos(xPos, 130):addTo(self.buttom)
      end
      xPos = xPos + 220
    end
  end
end

function NewBattleResultLayer:showItems()
  if next(self.heros) and not self.autoBattle then
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

function NewBattleResultLayer:nextCallBack()
  if self.carbonType == BattleType.Moon then
    game:enterScene("MoonScene", {
      carbonId = self.carbonId
    })
  elseif self.carbonType == BattleType.Paradise then
    game:enterScene("ParadiseScene", {
      carbonId = self.carbonId
    })
  elseif self.carbonType == BattleType.MJ then
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonType = 3,
      bossType = self.bossType,
      bossDegree = self.bossDegree,
      skipMusic = true
    })
  elseif self.carbonType == BattleType.EJ then
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonType = 4,
      bossType = self.bossType,
      bossDegree = self.bossDegree,
      skipMusic = true
    })
  elseif self.carbonType == BattleType.ShenYuan then
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonType = 5,
      bossType = self.bossType,
      bossDegree = self.bossDegree,
      skipMusic = true
    })
  elseif self.autoBattle then
    self:autoBattleNext()
  elseif self.carbonType == BattleType.Worldboss then
    game:enterScene("MainScene", {layer = "worldboss", type = 3})
  elseif self.carbonType == BattleType.ActCarbon then
    game:enterScene("MainScene", {layer = "act_carbon"})
  else
    game:enterScene("CarbonScene", {
      carbonId = self.carbonId,
      modeType = self.modeType
    })
  end
end

function NewBattleResultLayer:resetUI()
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

function NewBattleResultLayer:boss_CreateHeroHead(params)
  local hero = params.hero
  local unit = UnitCsv[hero.type]
  local attrs = hero:getTotalAttrValues()
  local info = params.info or {
    origLevel = hero.level,
    origExp = hero.exp,
    death = true
  }
  local death = info.death
  local hpPercent = info.hp or hero.hpPercent
  local isRed = hpPercent <= 300
  local content = display.newSprite(ResultRes .. (isRed and "new_head_frame1.png" or "new_head_frame.png"))
  local size = content:getContentSize()
  display.newTTFLabel({
    text = hero:getName(),
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 1):pos(10, 0):addTo(content)
  display.newSprite(UIHelper.getCardRes("cutin", hero:getDressType(), nil, hero.quality)):pos(size.width / 2, 78):addTo(content)
  display.newTTFLabel({
    text = "生命",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(10, 29):addTo(content)
  local lv = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(10, 6):addTo(content)
  local hpBarBg = display.newSprite(ResultRes .. "new_hero_slot.png"):anch(0, 0):pos(60, 29):addTo(content)
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
  local expBarBg = display.newSprite(ResultRes .. "new_hero_slot.png"):anch(0, 0):pos(60, 6):addTo(content)
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
  }):pos(138, 10):anch(1, 0):addTo(expBarBg)
  table.insert(self.actions, {
    bar = expBar,
    upLevel = hero.exp - (info.exp or 0) <= 0,
    maxLevel = hero.level >= hero:getLevelLimit(),
    addExp = death and 0 or info.exp or 0,
    endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100,
    label = expLabel,
    lv = lv,
    num = hero.level,
    who = 1
  })
  return content
end

function NewBattleResultLayer:createHeroHead(params)
  local hero = params.hero
  local unit = UnitCsv[hero.type]
  local attrs = hero:getTotalAttrValues()
  local info = params.info or {
    origLevel = hero.level,
    origExp = hero.exp,
    death = true
  }
  local death = info.death
  local hpPercent = info.hp or hero.hpPercent
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
  }):anch(0, 0):pos(10, 52):addTo(content)
  local lv = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(10, 29):addTo(content)
  display.newTTFLabel({
    text = "伤害",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(10, 6):addTo(content)
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
  }):pos(138, 10):anch(1, 0):addTo(expBarBg)
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
    addExp = death and 0 or info.exp or 0,
    endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100,
    label = expLabel,
    lv = lv,
    num = hero.level,
    who = 1
  })
  return content
end

function NewBattleResultLayer:barRunAnimation(params)
  local seq, time = {}, self.skipAnimation and 0 or 0.5
  table.insert(seq, cc.DelayTime:create(1))
  if params.maxLevel then
    if 0 < params.addExp or 0 >= params.addExp and params.who == 2 then
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
  elseif 0 < params.addExp or 0 >= params.addExp and params.who == 2 then
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

function NewBattleResultLayer:autoBattleNext()
  local autoIdxs = game.role.autoBattle.idxs:toArray("=", true)
  local teams = game.role.autoBattle.teams:toArray("=", true)
  if autoIdxs[2] ~= 0 and autoIdxs[3] ~= 0 then
    local enemys = AutoBattleCsv[self.carbonId].monsterSet:toArray("=", true)
    local enemyData
    for i, id in ipairs(enemys) do
      if autoIdxs[2] == i then
        enemyData = MonsterCsv[id]
      end
    end
    game:enterScene("BattleScene", {
      type = BattleType.PvE,
      carbonId = self.carbonId,
      modeType = self.modeType,
      masterId = enemyData.id,
      leftInfo = game.role:getBattleAttrs(teams[autoIdxs[3]], BattleType.PvE),
      format = teams[autoIdxs[3]],
      energy = 0,
      buff = {},
      bossId = 0,
      weatherFactor = enemyData.type == MonsterType.Dregs,
      battleKey = game.role.autoBattle.key or "zhaolu",
      activityBuff = {},
      autoBattle = true
    })
    return
  end
  local result
  if autoIdxs[2] == 0 then
    result = true
  end
  if autoIdxs[3] == 0 then
    result = false
  end
  game:sendData(actionCodes.Carbon_autoEndGameRpc, MsgPack.pack({
    key = game.role.autoBattle.key,
    win = result
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Carbon_autoEndGameRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg then
      self:close()
      game:createView("carbon.AutoCarbonBattleLayer", {
        endResult = msg,
        carbonId = msg.carbonId,
        isTopBar = true
      })
    else
      return
    end
  end)
end

return NewBattleResultLayer
