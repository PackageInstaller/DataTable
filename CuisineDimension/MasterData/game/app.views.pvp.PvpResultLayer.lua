local HeroExpCsv = require("csvdata.hero_exp")
local UnitCsv = require("csvdata.unit")
local RankCsv = require("csvdata.pvp_rank")
local ResultRes = "ui/carbon/battleresult/"
local PvpRes = "ui/pvp/result/"
local uiData = {
  csbFile = "ui/pvp/PvpResultLayer.csb",
  mask = true,
  widgets = {
    exit = "exit",
    titleBg = "titleBg",
    mainBg = "mainBg",
    roleInfoNode = "roleInfo",
    body = "roleInfo/body",
    name = "roleInfo/name",
    curExp = "roleInfo/curExp",
    expAdd = "roleInfo/expAdd",
    items = "roleInfo/items",
    point = "roleInfo/node",
    downBg = "downBg",
    head = "downBg/head"
  }
}
local Time
local upMusic = false

local function barAnimation(bar, upLevel, maxLevel, addExp, endProcess, label, lv, num, who, group)
  local seq, time = {}, Time or 0.5
  local endNum = maxLevel and who == 1 and 0 or addExp
  table.insert(seq, cc.DelayTime:create(Time or 1.5))
  table.insert(seq, cc.CallFunc:create(function()
    UIHelper.numVaryEffect({
      node = label,
      repeatTimes = 10,
      stringFormat = "+%d",
      endNum = addExp,
      effectTime = time
    })
  end))
  if 0 < addExp then
    if upLevel then
      time = time / 2
      table.insert(seq, cc.ProgressTo:create(time / 4, 100))
      table.insert(seq, cc.ProgressTo:create(0, 0))
      table.insert(seq, cc.CallFunc:create(function()
        if who == 1 then
          lv:setString("Lv" .. num)
          local levelUp = UIHelper.loadAnimation("battleEff/carbon/", "level_up", 47, 30)
          levelUp.sprite:pos(100, 138):addTo(lv:getParent())
          levelUp.sprite:playAnimationOnce(levelUp.animation, true)
        else
          lv:removeAllChildren()
          display.newSprite(RankCsv[game.role.pvpInfo.group or 1].res):scale(0.8):pos(-30, 5):addTo(lv)
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
  table.insert(seq, cc.CallFunc:create(function()
    Time = 0
  end))
  bar:runAction(cc.Sequence:create(seq))
end

local Head = class("Head", function(params)
  local hero = params.hero
  local info = params.info
  local unit = UnitCsv[hero.type]
  local attrs = hero:getTotalAttrValues()
  local heroHurt = params.heroHurt or 0
  local allHurt = params.allHurt == 0 and 1 or params.allHurt
  local content = display.newSprite(ResultRes .. "new_head_frame_big.png")
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
  }):anch(0, 0):pos(6, 52):addTo(content)
  local lvLabel = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(6, 29):addTo(content)
  display.newTTFLabel({
    text = "伤害",
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(6, 6):addTo(content)
  local hpBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 52):addTo(content)
  local hpBar = display.newProgressTimer(ResultRes .. "hero_hp_bar.png", 1):center(hpBarBg):addTo(hpBarBg)
  hpBar:setBarChangeRate(cc.p(1, 0))
  hpBar:setMidpoint(cc.p(0, 0.5))
  local hp = hero.hpPercent * attrs.hp / 1000
  hp = hero.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  hpBar:setPercentage(hero.hpPercent / 10)
  display.newTTFLabel({
    text = string.format("%d/%d", hp, attrs.hp),
    size = 14,
    color = display.COLOR_WHITE
  }):pos(0, 5):anch(0, 0):addTo(hpBarBg)
  local expBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 29):addTo(content)
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
  local hurtBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 6):addTo(content)
  local hurtBar = display.newProgressTimer(ResultRes .. "hero_hurt_bar.png", 1):center(hurtBarBg):addTo(hurtBarBg)
  hurtBar:setBarChangeRate(cc.p(1, 0))
  hurtBar:setMidpoint(cc.p(0, 0.5))
  hurtBar:setPercentage(heroHurt / allHurt * 100)
  display.newTTFLabel({
    text = string.format("%d/%d", heroHurt, params.allHurt),
    size = 14,
    color = display.COLOR_WHITE
  }):pos(0, 6):anch(0, 0):addTo(hurtBarBg)
  local bMaxLevel = hero.level >= hero:getLevelLimit()
  local upLevel = hero.level > info.origLevel
  local endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100
  barAnimation(expBar, upLevel, bMaxLevel, info.exp, endProcess, expLabel, lvLabel, hero.level, 1)
  return content
end)
local PvpResultLayer = class("PvpResultLayer", UIBase)

function PvpResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpResultLayer:init(params)
  self.starNum = params.starNum
  self.roleInfo = params.roleInfo
  self.herosInfo = params.herosInfo
  self.roleAddExp = params.roleAddScore or 0
  self.dropItems = params.dropItems
  self.herosHurtValue = params.herosHurtValue or {}
  self.exit:setCallback(function()
    if Time then
      Time = nil
      game:enterScene("MainScene", {
        layer = "carbon",
        selected = 4,
        skipMusic = true
      })
    else
      Time = 0
    end
  end)
end

function PvpResultLayer:showData()
  local formatInfo = json.decode(game.role.pvpInfo.formatInfo)
  self.format = formatInfo.list or {}
  display.newSprite(PvpRes .. "image_title.png"):anch(0, 0.5):pos(7, 23):addTo(self.titleBg)
  self.name:setString(game.role.name)
  self.expAdd:setString("")
  if game.role.pvpInfo.winCount > 1 then
    display.newTTFLabel({
      text = string.format("%d连胜", game.role.pvpInfo.winCount),
      size = 24,
      color = UIHelper.hex2rgb("#e5d92c")
    }):addTo(self.point)
  end
  self.titleBg:runAction(cc.MoveBy:create(Time or 0.3, cc.p(330, 0)))
  self.mainBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.3, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      self:showRoleAndHeros()
    end)
  }))
  if 0 < self.starNum then
    game:playMusic(1016)
  else
    game:playMusic(1017)
  end
end

function PvpResultLayer:showRoleAndHeros()
  local scores = RankCsv[self.roleInfo.oldGroup].score:toArray("=", true)
  local expBarBg = display.newSprite(PvpRes .. "bar_bg.png"):anch(0, 0):pos(-360, -20):addTo(self.roleInfoNode)
  local expBar = display.newProgressTimer(PvpRes .. "bar.png", 1):center(expBarBg):addTo(expBarBg)
  expBar:setBarChangeRate(cc.p(1, 0))
  expBar:setMidpoint(cc.p(0, 0.5))
  expBar:setPercentage((self.roleInfo.oldScore - scores[1] + 1) / (scores[2] - scores[1] + 1) * 100)
  display.newSprite(RankCsv[self.roleInfo.oldGroup].res):scale(0.8):pos(-30, 5):addTo(self.curExp)
  scores = RankCsv[game.role.pvpInfo.group or 1].score:toArray("=", true)
  local bMaxLevel = (game.role.pvpInfo.group or 1) >= #RankCsv
  local upLevel = (game.role.pvpInfo.group or 1) > self.roleInfo.oldGroup
  local endProcess = (game.role.pvpInfo.score - scores[1] + 1) / (scores[2] - scores[1] + 1) * 100
  barAnimation(expBar, upLevel, bMaxLevel, self.roleAddExp, endProcess, self.expAdd, self.curExp, scores[2])
  self.curExp:setString(string.format("%d/%d", game.role.pvpInfo.score, scores[2]))
  local heroId = self.format["1"] or self.format["2"] or self.format["3"] or self.format["4"] or self.format["5"]
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
  self:showItems()
  local allHurt = 0
  for _, value in pairs(self.herosHurtValue) do
    allHurt = allHurt + value
  end
  local xPos, interval = 0, 220
  for index = 1, 5 do
    local heroId = self.format[tostring(index)]
    local hero = heroId and game.role.heros[heroId]
    if hero and self.herosInfo[heroId] then
      Head.new({
        hero = hero,
        info = self.herosInfo[heroId],
        allHurt = allHurt,
        heroHurt = self.herosHurtValue[heroId]
      }):pos(xPos, 10):addTo(self.head)
      xPos = xPos + interval
    end
  end
  self.downBg:runAction(cc.MoveBy:create(Time or 1, cc.p(0, 168)))
end

function PvpResultLayer:showItems()
  if table.nums(self.dropItems) > 0 then
    local x = 0
    for id, count in pairs(self.dropItems) do
      if tonumber(count) ~= 0 then
        local icon = ItemIcon.new({
          type = tonumber(id),
          count = tonumber(count),
          showTip = true
        }):scale(0.83)
        if x < 3 then
          icon:pos(x * 90, 0):addTo(self.items)
        else
          icon:pos((x - 3) * 90, -90):addTo(self.items)
        end
        x = x + 1
      end
    end
  end
end

return PvpResultLayer
