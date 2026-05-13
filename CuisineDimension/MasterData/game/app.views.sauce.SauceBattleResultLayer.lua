local ItemCsv = require("csvdata.item")
local ResultRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/sauce/SauceBattleResultLayer.csb",
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
    label1 = "roleInfoNode/label1",
    label2 = "roleInfoNode/label2"
  }
}
local Time
local SauceBattleResultLayer = class("SauceBattleResultLayer", UIBase)

function SauceBattleResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceBattleResultLayer:init(params)
  self.passTime = params.passTime
  self.formatVal = params.format
  self.starNum = params.starNum
  self.brokenCount = params.brokenCount
  self.gift = params.gift
  self.homeBack = params.homeBack or function()
  end
  self.sendBack = params.sendBack or function()
  end
  self.exit:setCallback(function()
    if Time then
      Time = nil
      self:showChooseLayer()
    else
      Time = 0
    end
  end)
  self.point:removeAllChildren()
  if self.starNum > 0 then
    game:playMusic(1016)
  else
    game:playMusic(1017)
  end
end

function SauceBattleResultLayer:showData()
  self.name:setString(game.role.name)
  self.format:setString(string.format("套餐%d", self.formatVal))
  self.titleBg:runAction(cc.MoveBy:create(Time or 0.3, cc.p(330, 0)))
  self.mainBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.3, cc.p(-1100, 0)),
    cc.CallFunc:create(function()
      self:showRole()
    end)
  }))
end

function SauceBattleResultLayer:showRole()
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
    end),
    cc.DelayTime:create(Time or 0.5),
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
      local time = UIHelper.getTimeStr(self.passTime, true)
      time = string.gsub(time, ":", "分")
      time = time .. "秒"
      self.label1:setString("用时：" .. time)
      self.label2:setString("大破：" .. self.brokenCount)
    end)
  }))
end

function SauceBattleResultLayer:showChooseLayer()
  if self.gift == "" then
    self.homeBack()
    return
  end
  game:createView("sauce.SauceChooseGiftLayer", {
    gift = self.gift,
    cancelBack = self.homeBack,
    okBack = self.sendBack,
    parent = self
  })
end

return SauceBattleResultLayer
