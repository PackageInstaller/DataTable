local RoleInfo = require("csvdata.role_info")
local UnitCsv = require("csvdata.unit")
local HeroExpCsv = require("csvdata.hero_exp")
local ResultRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/carbon/TaskResultLayer.csb",
  mask = true,
  widgets = {
    exit = "exit",
    titleBg = "titleBg",
    mainBg = "mainBg",
    roleInfoNode = "roleInfo",
    body = "roleInfo/body",
    name = "roleInfo/name",
    level = "roleInfo/level",
    expAdd = "roleInfo/expAdd",
    items = "roleInfo/items",
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
  local content = display.newSprite(ResultRes .. "head_frame.png")
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
  local lvLabel = display.newTTFLabel({
    text = "Lv" .. info.origLevel,
    size = 18,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(6, 6):addTo(content)
  local hpBarBg = display.newSprite(ResultRes .. "hero_slot.png"):anch(0, 0):pos(50, 26):addTo(content)
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
  local upLevel = 0 >= hero.exp - info.exp
  local endProcess = hero.exp / HeroExpCsv[hero.level].exp * 100
  barAnimation(expBar, upLevel, bMaxLevel, info.exp, endProcess, expLabel, lvLabel, hero.level, 1)
  return content
end)
local TaskResultLayer = class("TaskResultLayer", UIBase)

function TaskResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TaskResultLayer:init(params)
  self.big = params.big
  self.roleInfo = params.roleInfo
  self.herosInfo = params.herosInfo
  self.roleAddExp = params.roleAddExp or 0
  self.dropItems = params.dropItems
  self.format = params.format
  self.exit:setCallback(function()
    if Time then
      Time = nil
      BackManager:pop()
    else
      Time = 0
    end
  end)
end

function TaskResultLayer:showData()
  self.name:setString(game.role.name)
  self.level:setString("Lv" .. self.roleInfo.origLevel)
  self.expAdd:setString("")
  if self.big then
    display.newSprite("ui/carbon/task/text_task.png"):anch(0, 0.5):pos(7, 23):addTo(self.titleBg)
  else
    display.newSprite("ui/carbon/task/text_task_0.png"):anch(0, 0.5):pos(7, 23):addTo(self.titleBg)
  end
  self.titleBg:runAction(cc.MoveBy:create(Time or 0.3, cc.p(330, 0)))
  self.mainBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.3, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      self:showRoleAndHeros()
    end)
  }))
  if self.big then
    game:playMusic(1018)
  else
    game:playMusic(1501)
  end
end

function TaskResultLayer:showRoleAndHeros()
  local expBarBg = display.newSprite(ResultRes .. "exp_slot.png"):anch(0, 0):pos(-370, 58):addTo(self.roleInfoNode)
  local expBar = display.newProgressTimer(ResultRes .. "ext_bar.png", 1):center(expBarBg):addTo(expBarBg)
  expBar:setBarChangeRate(cc.p(1, 0))
  expBar:setMidpoint(cc.p(0, 0.5))
  expBar:setPercentage(self.roleInfo.origExp / RoleInfo[self.roleInfo.origLevel].exp * 100)
  local bMaxLevel = game.role.level >= globalCsv.roleLevelLimit
  local upLevel = 0 < game.role.level - self.roleInfo.origLevel
  local endProcess = game.role.exp / RoleInfo[game.role.level].exp * 100
  barAnimation(expBar, upLevel, bMaxLevel, self.roleAddExp, endProcess, self.expAdd, self.level, game.role.level)
  local formation = game.role.formation[tostring(self.format)]
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
  self:showItems()
  local xPos, interval = 0, 220
  for index = 1, 5 do
    local heroId = formation.list[tostring(index)]
    local hero = heroId and game.role.heros[heroId]
    if hero and self.herosInfo[heroId] then
      Head.new({
        hero = hero,
        info = self.herosInfo[heroId]
      }):pos(xPos, 0):addTo(self.head)
      xPos = xPos + interval
    end
  end
  self.downBg:runAction(cc.MoveBy:create(Time or 1, cc.p(0, 168)))
end

function TaskResultLayer:showItems()
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

function TaskResultLayer:onExit()
  CommonHelper.stopCV()
end

return TaskResultLayer
