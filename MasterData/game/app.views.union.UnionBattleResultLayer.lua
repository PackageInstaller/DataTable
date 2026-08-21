local HeroExpCsv = require("csvdata.hero_exp")
local UnitCsv = require("csvdata.unit")
local RankCsv = require("csvdata.pvp_rank")
local ResultRes = "ui/carbon/battleresult/"
local PvpRes = "ui/pvp/result/"
local uiData = {
  csbFile = "ui/union/UnionBattleResultLayer.csb",
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
local Head = class("Head", function(params)
  local hero = params.hero
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
    text = "Lv" .. hero.level,
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
  return content
end)
local UnionBattleResultLayer = class("UnionBattleResultLayer", UIBase)

function UnionBattleResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionBattleResultLayer:init(params)
  self.starNum = params.starNum or 0
  self.curScore = params.curScore or 0
  self.addScore = params.add or 0
  self.exit:setCallback(function()
    if Time then
      Time = nil
      game:enterScene("MainScene", {
        layer = "unionBattle"
      })
    else
      Time = 0
    end
  end)
end

function UnionBattleResultLayer:showData()
  local formatInfo = game.role.activityStatus["89"].formatInfo
  self.format = formatInfo.list or {}
  display.newSprite(PvpRes .. "image_title.png"):anch(0, 0.5):pos(7, 23):addTo(self.titleBg)
  self.name:setString(game.role.name)
  self.expAdd:setString("+" .. self.addScore)
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

function UnionBattleResultLayer:showRoleAndHeros()
  self.curExp:setString(string.format("%d", self.curScore))
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
  local xPos, interval = 0, 220
  for index = 1, 5 do
    local heroId = self.format[tostring(index)]
    local hero = heroId and game.role.heros[heroId]
    if hero then
      Head.new({hero = hero}):pos(xPos, 0):addTo(self.head)
      xPos = xPos + interval
    end
  end
  self.downBg:runAction(cc.MoveBy:create(Time or 1, cc.p(0, 168)))
end

return UnionBattleResultLayer
