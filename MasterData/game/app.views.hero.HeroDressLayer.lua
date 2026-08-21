local UnitCsv = require("csvdata.unit")
local DressCsv = require("csvdata.hero_skin")
local DressRes = "ui/hero/dress/"
local uiData = {
  csbFile = "ui/hero/HeroDressLayer.csb",
  mask = true,
  widgets = {
    spineNode = "spineNode",
    center = "center",
    mask = "mask",
    up_bar = "up_bar",
    downBar = "downBar",
    angle2 = "angle2",
    angle3 = "angle3",
    nameLabel = "text3/nameLabel",
    descLabel = "text1/descLabel",
    unlockLabel = "text2/unlockLabel",
    featureNode = "featureNode",
    card0 = "card0",
    card1 = "card1",
    card2 = "card2",
    card3 = "card3",
    okBtn = "okBtn",
    selectTag = "selectTag",
    heroNode = "heroNode"
  }
}
local HeroDressLayer = class("HeroDressLayer", UIBase)

function HeroDressLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HeroDressLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.mask)
    UIHelper.fitForiPhoneX(self.up_bar, true)
    UIHelper.fitForiPhoneX(self.downBar, true)
    self.mask:setPositionX(self.mask:getPositionX() - UIHelper.getMoveXForX())
    self.angle2:setPositionX(self.angle2:getPositionX() - UIHelper.getMoveXForX())
    self.angle3:setPositionX(self.angle3:getPositionX() + UIHelper.getMoveXForX())
  end
  self.hero = game.role.heros[params.heroId]
  self.dress = self.hero.dress
end

function HeroDressLayer:showData(params)
  self.okBtn:setTouchScale()
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  for slot = 0, 3 do
    local card = self["card" .. slot]
    card:removeAllChildren()
    local dressId = self.hero.type * 10 + slot
    local dressSet = DressCsv[dressId]
    if dressSet then
      display.newSprite(dressSet.smallPic):center(card):addTo(card)
      if 0 < slot and not game.role.dressBook[dressId] then
        display.newSprite(DressRes .. "mask.png"):center(card):addTo(card)
      end
      card:setCallback(function()
        if self.dress == slot then
          return
        end
        self.dress = slot
        self:showHeros()
      end)
    else
      display.newSprite(DressRes .. "lock.png"):center(card):addTo(card)
    end
  end
  self.okBtn:setCallback(function()
    if self.hero.dress == self.dress then
      return
    end
    local dressId = self.hero.type * 10 + self.dress
    if self.dress > 0 and not game.role.dressBook[dressId] then
      return
    end
    game:sendData(actionCodes.Hero_changeDressRpc, MsgPack.pack({
      heroId = self.hero.id,
      slot = self.dress
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_changeDressRpc, function(event)
      UIHelper.removeWaiting()
      self.change = true
      game.role:dispatchEvent({
        name = "onChangeDress",
        heroId = self.hero.id
      })
      BackManager:pop()
    end)
  end)
  self:showHeros()
end

function HeroDressLayer:showHeros()
  self.spineNode:removeAllChildren()
  self.heroNode:removeAllChildren()
  self.featureNode:removeAllChildren()
  local dressId = self.hero.type * 10 + self.dress
  local dressSet = DressCsv[dressId]
  local unitSet = UnitCsv[dressSet.hero]
  self.nameLabel:setString(dressSet.name)
  self.descLabel:setString(dressSet.desc)
  self.unlockLabel:setString(dressSet.unlockDesc)
  local xPos = 0
  if 0 < dressSet.liveTip then
    local bg = display.newSprite(DressRes .. "feature.png"):anch(0, 0.5):pos(xPos, 0):addTo(self.featureNode)
    display.newTTFLabel({
      text = "Live 2D",
      size = 16,
      color = UIHelper.hex2rgb("#939393")
    }):pos(32, 13):addTo(bg)
    xPos = xPos + 80
  end
  if 0 < dressSet.effectTip then
    local bg = display.newSprite(DressRes .. "feature.png"):anch(0, 0.5):pos(xPos, 0):addTo(self.featureNode)
    display.newTTFLabel({
      text = "技能特效",
      size = 16,
      color = UIHelper.hex2rgb("#939393")
    }):pos(32, 13):addTo(bg)
  end
  HeroBigCard.new({
    type = unitSet.type
  }):addTo(self.heroNode)
  local spine = UIHelper.createSpineNode(unitSet.type)
  spine:setAnimation(0, "idle", true)
  spine:addTo(self.spineNode)
  local card = self["card" .. self.dress]
  self.selectTag:pos(card:getPosition())
end

function HeroDressLayer:needUpdate()
  return self.change
end

return HeroDressLayer
