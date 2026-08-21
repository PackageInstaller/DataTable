local RoleInfo = require("csvdata.role_info")
local UnitCsv = require("csvdata.unit")
local HeroExpCsv = require("csvdata.hero_exp")
local ItemCsv = require("csvdata.item")
local ResultRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/carbon/BattleResultLayer.csb",
  mask = true,
  widgets = {
    exit = "exit",
    titleBg = "titleBg",
    mainBg = "mainBg",
    roleInfoNode = "roleInfoNode",
    body = "roleInfoNode/body",
    name = "roleInfoNode/name",
    format = "roleInfoNode/format",
    point = "roleInfoNode/point",
    enemyDie = "roleInfoNode/enemyDie",
    selfDie = "roleInfoNode/selfDie",
    downBg = "downBg",
    head = "downBg/head"
  }
}
local Time
local upMusic = false

local function barAnimation(bar, upLevel, maxLevel, addExp, endProcess, label, lv, num, who)
  local seq, time = {}, Time or 0.5
  table.insert(seq, cc.DelayTime:create(Time or 1.5))
  if maxLevel then
    if 0 < addExp or addExp <= 0 and who == 2 then
      table.insert(seq, cc.CallFunc:create(function()
        UIHelper.numVaryEffect({
          node = label,
          repeatTimes = 10,
          stringFormat = "+%d",
          endNum = 0,
          effectTime = time
        })
      end))
    end
  elseif 0 < addExp or addExp <= 0 and who == 2 then
    table.insert(seq, cc.CallFunc:create(function()
      UIHelper.numVaryEffect({
        node = label,
        repeatTimes = 10,
        stringFormat = "+%d",
        endNum = addExp,
        effectTime = time
      })
    end))
  end
  if 0 < addExp then
    if upLevel then
      time = time / 2
      table.insert(seq, cc.ProgressTo:create(time / 4, 100))
      table.insert(seq, cc.ProgressTo:create(0, 0))
      table.insert(seq, cc.CallFunc:create(function()
        lv:setString("Lv" .. num)
        if who == 1 then
          local levelUp = UIHelper.loadAnimation("battleEff/carbon/", "level_up", 47, 30)
          levelUp.sprite:pos(100, 138):addTo(lv:getParent())
          levelUp.sprite:playAnimationOnce(levelUp.animation, true)
        end
        if not upMusic then
          upMusic = true
          game:playMusic(1002)
        end
      end))
      table.insert(seq, cc.DelayTime:create(time / 5))
    end
    table.insert(seq, cc.ProgressTo:create(time / 2, maxLevel and 100 or endProcess))
  end
  bar:runAction(cc.Sequence:create(seq))
end

local Head = class("Head", function(params)
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
  local content = display.newSprite(ResultRes .. (isRed and "head_frame1.png" or "head_frame.png"))
  local size = content:getContentSize()
  display.newTTFLabel({
    text = hero:getName(),
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 1):pos(10, 0):addTo(content)
  display.newSprite(UIHelper.getCardRes("cutin", hero:getDressType(), nil, hero.quality)):pos(size.width / 2, 73):addTo(content)
  display.newTTFLabel({
    text = "生命",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(6, 26):addTo(content)
  local lv = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(6, 6):addTo(content)
  local hpBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 26):addTo(content)
  local hpBar = display.newProgressTimer(ResultRes .. (isRed and "hero_red_bar.png" or "hero_hp_bar.png"), 1):center(hpBarBg):addTo(hpBarBg)
  hpBar:setBarChangeRate(cc.p(1, 0))
  hpBar:setMidpoint(cc.p(0, 0.5))
  hpBar:setPercentage(hpPercent / 10)
  local hp = attrs.hp * hpPercent / 1000
  hp = 500 < hpPercent and math.floor(hp) or math.ceil(hp)
  display.newTTFLabel({
    text = string.format("%d/%d", hp, attrs.hp),
    size = 14,
    color = display.COLOR_WHITE
  }):pos(0, 5):anch(0, 0):addTo(hpBarBg)
  local expBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 6):addTo(content)
  local expBar = display.newProgressTimer(ResultRes .. "hero_exp_bar.png", 1):center(expBarBg):addTo(expBarBg)
  expBar:setBarChangeRate(cc.p(1, 0))
  expBar:setMidpoint(cc.p(0, 0.5))
  if hero.level >= hero:getLevelLimit() then
    expBar:setPercentage(100)
    display.newTTFLabel({
      text = "max",
      size = 14,
      color = display.COLOR_WHITE
    }):pos(0, 5):anch(0, 0):addTo(expBarBg)
  else
    expBar:setPercentage(info.origExp / HeroExpCsv[info.origLevel].exp * 100)
    display.newTTFLabel({
      text = string.format("%d/%d", hero.exp, HeroExpCsv[hero.level].exp),
      size = 14,
      color = display.COLOR_WHITE
    }):pos(0, 5):anch(0, 0):addTo(expBarBg)
  end
  local expLabel = display.newTTFLabel({
    text = "",
    size = 14,
    color = UIHelper.hex2rgb("09fe09")
  }):pos(149, 5):anch(1, 0):addTo(expBarBg)
  local bMaxLevel = hero.level >= hero:getLevelLimit()
  local upLevel = hero.exp - (info.exp or 0) <= 0
  local endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100
  barAnimation(expBar, upLevel, bMaxLevel, death and 0 or info.exp or 0, endProcess, expLabel, lv, hero.level, 1)
  return content
end)
local BattleResultLayer = class("BattleResultLayer", UIBase)

function BattleResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BattleResultLayer:init(params)
  self.roleInfo = params.roleInfo
  self.herosInfo = params.herosInfo
  self.herosHurtValue = params.herosHurtValue or {}
  self.roleAddExp = params.roleAddExp or 0
  self.dropItems = params.dropItems or {}
  self.formatVal = params.format
  self.starNum = params.starNum
  self.enemyDead = params.enemyDead or 0
  self.carbonId = params.carbonId
  self.carbonType = params.carbonType
  if self.carbonType == BattleType.Moon then
    game.role.moonBattleInfoCache.endResult = params.endResult
    game.role.moonBattleInfoCache.events = params.events
    game.role.moonBattleInfoCache.battle = nil
  elseif self.carbonType == BattleType.Paradise then
    game.role.paradiseBattleInfoCache.endResult = params.endResult
    game.role.paradiseBattleInfoCache.events = params.events
    game.role.paradiseBattleInfoCache.battle = nil
  elseif self.carbonType == BattleType.MJ or self.carbonType == BattleType.EJ then
    self.bossType = params.bossType
    self.bossDegree = params.bossDegree
  else
    game.role.battleInfoCache.endResult = params.endResult
    game.role.battleInfoCache.events = params.events
    game.role.battleInfoCache.battle = nil
  end
  self.exit:setCallback(function()
    if Time then
      Time = nil
      self:showItems()
    else
      Time = 0
    end
  end)
  self.point:removeAllChildren()
  if 0 < self.starNum then
    game:playMusic(1016)
  else
    game:playMusic(1017)
  end
end

function BattleResultLayer:showData()
  self.name:setString(game.role.name)
  self.format:setString(string.format("套餐%d", self.formatVal))
  self.titleBg:runAction(cc.MoveBy:create(Time or 0.3, cc.p(330, 0)))
  self.mainBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.3, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      self:showRoleAndHeros()
    end)
  }))
end

function BattleResultLayer:showRoleAndHeros()
  local formation = game.role.formation[tostring(self.formatVal)]
  local heroId = formation.list["1"]
  local hero = game.role.heros[heroId]
  self.roleInfoNode:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.2, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      local cap = HeroBigCard.new({
        heroId = heroId,
        quality = hero.quality
      }):anch(0.5, 0):pos(280, -570):addTo(self.body)
      cap:opacity(0)
      cap:runAction(cc.FadeIn:create(Time or 0.5))
    end)
  }))
  local xPos, interval = 0, 220
  for index = 1, 5 do
    local heroId = formation.list[tostring(index)]
    if heroId then
      local head = Head.new({
        hero = game.role.heros[heroId],
        info = self.herosInfo[heroId]
      }):pos(xPos, 0):addTo(self.head)
      xPos = xPos + interval
    end
  end
  self.downBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 1, cc.p(0, 168)),
    cc.DelayTime:create(Time or 1.5),
    cc.CallFunc:create(function()
      local signSprite = display.newSprite(ResultRes .. string.format("point%d.png", self.starNum)):scale(1.5):pos(90, -10):addTo(self.point)
      local actions = {}
      game:playMusic(1700)
      actions[#actions + 1] = cc.MoveTo:create(Time or 0.4, cc.p(0, 0))
      actions[#actions + 1] = cc.ScaleTo:create(Time or 0.4, 1)
      signSprite:runAction(cc.Spawn:create(actions[1], actions[2]))
      self.point:runAction(transition.sequence({
        cc.DelayTime:create(Time or 1),
        cc.CallFunc:create(function()
          Time = 0
        end)
      }))
      local selfCount = self:herosDieCount()
      UIHelper.numVaryEffect({
        node = self.selfDie,
        repeatTimes = 5,
        stringFormat = "%d",
        endNum = selfCount,
        effectTime = Time or 0.5
      })
      UIHelper.numVaryEffect({
        node = self.enemyDie,
        repeatTimes = 5,
        stringFormat = "%d",
        endNum = self.enemyDead,
        effectTime = Time or 0.5
      })
    end)
  }))
end

function BattleResultLayer:showItems()
  if next(self.dropItems) then
    MedalRewardLayer.new({
      items = self.dropItems,
      check = true,
      bShow = true,
      callback = function()
        self.dropItems = {}
        self:showItems()
      end
    })
  elseif self.carbonType == BattleType.Moon then
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
  else
    game:enterScene("CarbonScene", {
      carbonId = self.carbonId
    })
  end
end

function BattleResultLayer:herosDieCount()
  local count = 0
  for id, data in pairs(self.herosInfo) do
    local hero = game.role.heros[id]
    if hero and hero.hpPercent == 0 then
      count = count + 1
    end
  end
  return count
end

return BattleResultLayer
