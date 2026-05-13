local EquipCsv = require("csvdata.equip")
local SuitCsv = require("csvdata.equip_suit")
local EquipRes = "ui/equip/card/"
local GlobalRes = "ui/global/"
local EquipSmallCard = class("EquipSmallCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function EquipSmallCard:ctor(params)
  self:initEquipData(params)
  self:uiLayout()
  self.clickCallback = params.callback
end

function EquipSmallCard:initEquipData(params)
  local equipId = params.equipId
  self.hideHero = params.hideHero or false
  self.equip = game.role.equips[equipId]
end

function EquipSmallCard:uiLayout()
  local unitData = EquipCsv[self.equip.type]
  local star = unitData.star - 2
  self:setImage(EquipRes .. "card_fram.png")
  local iconBg = display.newSprite(EquipRes .. string.format("equip_bg_%d.png", star)):pos(75, 95):addTo(self, -1)
  local typeBg = display.newSprite(EquipRes .. string.format("equip_pro_bg_%d.png", star)):scale(0.7):pos(17, 169):addTo(self)
  display.newSprite(EquipRes .. string.format("profession_tag_%d.png", unitData.profession)):center(typeBg):addTo(typeBg)
  MRichText.new({
    text = self.equip:getName(),
    size = 14
  }):anch(0.5, 0.5):pos(72, 16):addTo(self)
  self.lock = display.newSprite("ui/equip/detail/image_lock.png"):pos(130, 168):addTo(self)
  self.lock:setVisible(self.equip.lock == 1)
  display.newSprite(unitData.cardIcon):center(iconBg):addTo(iconBg)
  local base = unitData.baseValue:toTableArray()
  local all = #base + unitData.entryNum
  local xPos, yPos = math.floor(80 - (all - 1) / 2 * 23), 168
  for index = 1, #base do
    local image = self.equip:getAttrLevel(index, true) == 0 and "base_off.png" or "base_on.png"
    display.newSprite(EquipRes .. image):pos(xPos, yPos):addTo(self)
    xPos = xPos + 23
  end
  for index = 1, unitData.entryNum do
    local image = self.equip:getAttrLevel(index, false) == 0 and "ex_off.png" or "ex_on.png"
    display.newSprite(EquipRes .. image):pos(xPos, yPos):addTo(self)
    xPos = xPos + 23
  end
  local titles = {
    "食\n器",
    "厨\n具",
    "餐\n具"
  }
  local proBg = display.newSprite(GlobalRes .. string.format("des_bg_%d.png", star)):anch(0.5, 1):pos(18, 156):addTo(self)
  display.newTTFLabel({
    text = titles[unitData.profession],
    size = 14
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(10, 25):addTo(proBg)
  local xPos, yPos = 13, 30
  for index = 1, self.equip.washLimit do
    local image = index <= self.equip.washCount and "green.png" or "grey.png"
    display.newSprite(EquipRes .. image):anch(0, 0.5):pos(xPos, yPos):addTo(self)
    xPos = xPos + 16
  end
  if 0 < self.equip.masterId and not self.hideHero then
    local hero = game.role.heros[self.equip.masterId]
    local heroBg = display.newSprite(EquipRes .. "hero_bg.png"):scale(0.8):pos(104, 65):addTo(self)
    UIHelper.getClipNode({
      steRes = "ui/global/mask_2.png",
      clipRes = UIHelper.getCardRes("book", hero:getDressType(), nil, hero.quality)
    }):scale(0.55):center(heroBg):addTo(heroBg)
    display.newSprite(EquipRes .. "hero_fram.png"):scale(0.8):pos(98, 69):addTo(self)
  end
  self.timeNode = display.newNode():addTo(self)
end

function EquipSmallCard:checkLock()
  self.lock:setVisible(self.equip.lock == 1)
end

function EquipSmallCard:refresh()
  self:checkLock()
end

function EquipSmallCard:setForcetouch(forcetouch, time)
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

function EquipSmallCard:clearTimeHandler()
  if self.timeHandler then
    scheduler.unscheduleGlobal(self.timeHandler)
    self.timeHandler = nil
  end
  self:scale(1)
  self.timeNode:removeAllChildren()
end

function EquipSmallCard:setNormalTouch(callback)
  self.clickCallback = callback
  self:setCallback(self.clickCallback)
end

return EquipSmallCard
