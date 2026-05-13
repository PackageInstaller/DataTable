local UnitCsv = require("csvdata.unit")
local RouGeAICsv = require("csvdata.rouge.rouge_ai")
local ResultRes = "ui/carbon/battleresult/"
local PvpRes = "ui/pvp/result/"
local uiData = {
  csbFile = "ui/rouge/RouGeBattleResultLayer.csb",
  mask = true,
  widgets = {
    exit = "exit",
    titleBg = "titleBg",
    mainBg = "mainBg",
    roleInfoNode = "roleInfo",
    body = "roleInfo/body",
    name = "roleInfo/name",
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
local RouGeBattleResultLayer = class("RouGeBattleResultLayer", UIBase)

function RouGeBattleResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RouGeBattleResultLayer:init(params)
  self.starNum = params.starNum or 0
  self.curScore = params.curScore or 0
  self.addScore = params.add or 0
  self.exit:setCallback(function()
    if Time then
      Time = nil
      game:enterScene("MainScene", {layer = "rouge"})
    else
      Time = 0
    end
  end)
end

function RouGeBattleResultLayer:showData()
  display.newSprite(ResultRes .. "txt_result.png"):anch(0, 0.5):pos(7, 23):addTo(self.titleBg)
  self.name:setString(game.role.name)
  self.expAdd:setString("+" .. (0 < self.starNum and globalCsv.RouGeMoneyReward or 0))
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

function RouGeBattleResultLayer:showRoleAndHeros()
  local aiData = RouGeAICsv[globalCsv.RouGeAIId]
  local teams = aiData.team:toTableArray(" ")
  local unitData = UnitCsv[tonumber(teams[1][1])]
  self.roleInfoNode:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.2, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      local cap = UIHelper.extend(ccui.ImageView:create())
      cap:setImage(UIHelper.getCardRes("normal", unitData.type, true, 5))
      cap:anch(0.5, 0):pos(280, -570):addTo(self.body)
      cap:opacity(0)
      cap:runAction(cc.FadeIn:create(Time or 0.5))
    end)
  }))
  self.downBg:runAction(cc.MoveBy:create(Time or 1, cc.p(0, 168)))
end

return RouGeBattleResultLayer
