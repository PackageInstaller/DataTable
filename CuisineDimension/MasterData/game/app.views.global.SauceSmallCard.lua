local ItemCsv = require("csvdata.item")
local SauceBreakCsv = require("csvdata.sauce_break")
local SauceRes = "ui/sauce/card/"
local GlobalRes = "ui/global/"
local SauceSmallCard = class("SauceSmallCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function SauceSmallCard:ctor(params)
  self:initEquipData(params)
  self:uiLayout()
  self.clickCallback = params.callback
end

function SauceSmallCard:initEquipData(params)
  local sauceId = params.sauceId
  self.hideHero = params.hideHero or false
  self.sauce = game.role.sauces[sauceId]
end

function SauceSmallCard:uiLayout()
  local unitData = ItemCsv[self.sauce:getItemId()]
  self:setImage(SauceRes .. string.format("card_fram_%d.png", unitData.star))
  local iconBg = display.newSprite(SauceRes .. string.format("card_bg_%d.png", unitData.star)):pos(75, 75):addTo(self, -1)
  display.newSprite(string.format("ui/global/profession_%d.png", self.sauce.csvData.profession)):scale(0.6):pos(16, 168):addTo(self)
  display.newTTFLabel({
    text = self.sauce:getName(),
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(72, 169):addTo(self)
  display.newSprite(self.sauce:getSmallImg()):center(iconBg):addTo(iconBg)
  display.newTTFLabel({
    text = self.sauce.breakL >= #SauceBreakCsv[self.sauce.type] and "MAX" or string.format("Lv%d", self.sauce.breakL),
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(3, 3):addTo(iconBg)
  self.lock = display.newSprite("ui/equip/detail/image_lock.png"):pos(130, 168):addTo(self)
  self.lock:setVisible(self.sauce.lock == 1)
  local xPos, yPos = 25, 150
  for index = 1, 6 do
    local image = index <= self.sauce.advanceL and "green.png" or "grey.png"
    display.newSprite(SauceRes .. image):anch(0, 0.5):pos(xPos, yPos):addTo(self)
    xPos = xPos + 16
  end
  if 0 < self.sauce.masterId and not self.hideHero then
    local hero = game.role.heros[self.sauce.masterId]
    if hero then
      local heroBg = display.newSprite(SauceRes .. "hero_bg.png"):scale(0.8):pos(104, 38):addTo(self)
      UIHelper.getClipNode({
        steRes = "ui/global/mask_2.png",
        clipRes = UIHelper.getCardRes("book", hero:getDressType(), nil, hero.quality)
      }):scale(0.55):center(heroBg):addTo(heroBg)
      display.newSprite(SauceRes .. "hero_fram.png"):scale(0.8):pos(98, 42):addTo(self)
    end
  end
  self.timeNode = display.newNode():addTo(self)
end

function SauceSmallCard:setForcetouch(forcetouch, time)
  time = time or 1
  self:setCallbackTotal(function(sender)
    self.touchPos = sender:getTouchBeganPosition()
    self:clearTimeHandler()
    self.touchBegin = socket.gettime()
    self:scale(0.95)
    self.timeHandler = scheduler.performWithDelayGlobal(forcetouch, time)
  end, function(sender)
    local pos = sender:getTouchMovePosition()
    if math.abs(pos.y - self.touchPos.y) > 5 then
      self.touchCancel = true
    end
    if self.touchCancel and self.timeHandler then
      scheduler.unscheduleGlobal(self.timeHandler)
      self.timeHandler = nil
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

function SauceSmallCard:checkLock()
  self.lock:setVisible(self.sauce.lock == 1)
end

function SauceSmallCard:refresh()
  self:checkLock()
end

function SauceSmallCard:clearTimeHandler()
  if self.timeHandler then
    scheduler.unscheduleGlobal(self.timeHandler)
    self.timeHandler = nil
  end
  self:scale(1)
  self.timeNode:removeAllChildren()
end

function SauceSmallCard:setNormalTouch(callback)
  self.clickCallback = callback
  self:setCallback(self.clickCallback)
end

return SauceSmallCard
