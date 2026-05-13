local UnitCsv = require("csvdata.unit")
local BookCsv = require("csvdata.handbook")
local ChooseRes = "ui/shop/choose/"
local DetailRes = "ui/hero/detail/"
local HandRes = "ui/hero/handbook/"
local uiData = {
  csbFile = "ui/shop/ChooseItemLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    title = "popAction/title",
    confirm = "popAction/confirm",
    cancel = "popAction/cancel",
    cardNode = "popAction/cardNode",
    heroSpine = "popAction/heroSpine",
    starNode = "popAction/starBg/starNode",
    attrNode = "popAction/attrsBg/attrNode",
    nameBg = "popAction/nameBg",
    name = "popAction/name",
    head1 = "popAction/head1",
    head2 = "popAction/head2",
    head3 = "popAction/head3",
    head4 = "popAction/head4",
    head5 = "popAction/head5"
  }
}
local HandDesc = {
  [1] = "技能",
  [2] = "装盘",
  [3] = "生命",
  [4] = "攻击",
  [5] = "攻速",
  [6] = "命中",
  [7] = "防御",
  [8] = "闪避"
}
local AttsEnumExtra = {
  [1] = "skill",
  [2] = "formation",
  [3] = "hp",
  [4] = "atk",
  [5] = "atkSpeed",
  [6] = "hit",
  [7] = "phyDef",
  [8] = "miss"
}
local ChooseItemLayer = class("ChooseItemLayer", UIBase)

function ChooseItemLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChooseItemLayer:init(params)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  if params.title then
    self.title:setString(params.title)
  end
  self.callback = params.callback
  self.items = params.items
  self.type = 0
  self.confirm:setCallback(function()
    if not self.callback(ItemStartId.hero + self.type) then
      self:close()
    end
  end)
  self.cancel:setCallback(function()
    self:close()
  end)
end

function ChooseItemLayer:showData(params)
  self.heads = {}
  local items = self.items:toArray("=", true)
  for index, itemId in ipairs(items) do
    local heroType = itemId - ItemStartId.hero
    local card = UIHelper.newImageView(ChooseRes .. "head_bg.png"):addTo(self["head" .. index])
    UIHelper.getClipNode({
      steRes = "ui/global/mask_3.png",
      clipRes = UIHelper.getCardRes("book", heroType)
    }):scale(0.6):center(card):addTo(card)
    display.newSprite(ChooseRes .. "head_frame.png"):center(card):addTo(card)
    card:setCallback(function()
      if self.type == heroType then
        return
      end
      self.type = heroType
      self.select:removeSelf()
      self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
      self:initDetail()
    end)
    self.heads[index] = card
    if self.type == 0 then
      self.type = heroType
      self.select = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
    end
  end
  self:initDetail()
end

function ChooseItemLayer:initDetail()
  local bookCsv
  for _, data in pairs(BookCsv) do
    if data.id == self.type then
      bookCsv = data
      break
    end
  end
  if not bookCsv then
    return
  end
  self.cardNode:removeAllChildren()
  self.heroSpine:removeAllChildren()
  self.starNode:removeAllChildren()
  self.attrNode:removeAllChildren()
  self.nameBg:removeAllChildren()
  display.newSprite(UIHelper.getCardRes("normal", self.type, false)):scale(0.6):addTo(self.cardNode)
  local spineNode = UIHelper.createSpineNode(self.type):addTo(self.heroSpine)
  spineNode:setAnimation(0, "idle", true)
  local unitData = UnitCsv[self.type]
  self.name:setString(unitData.name)
  local proBg = display.newSprite(string.format("ui/global/profession_bg_%d.png", 0)):scale(0.75):pos(10, 18):addTo(self.nameBg)
  display.newSprite(string.format("ui/global/profession_%d.png", unitData.profession)):center(proBg):addTo(proBg)
  local isBlack = globalCsv.blackHeroUnitIds[unitData.type] == 1
  local star, interval = unitData.star, 30
  local temStar = math.min(star, 5)
  local isMengJing = globalCsv.mengJingHeroUnitIds[unitData.type] == 1
  for index = 1, temStar do
    local offset = index == 1 and 0 or -interval / 2
    display.newSprite(DetailRes .. (isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos((index - (temStar + 1) / 2) * interval, 0):addTo(self.starNode)
  end
  for index = 1, 8 do
    local name = AttsEnumExtra[index]
    local xPos = math.floor((index - 1) % 2) * 100
    local yPos = math.floor((index - 1) / 2) * -22
    local color = 2 < index and "#b78262" or "#3a220a"
    yPos = 2 < index and yPos - 8 or yPos
    display.newSprite(DetailRes .. name .. ".png"):pos(xPos, yPos):addTo(self.attrNode)
    display.newTTFLabel({
      text = HandDesc[index] .. ":",
      size = 16,
      color = UIHelper.hex2rgb(color)
    }):pos(35 + xPos, yPos + 2):addTo(self.attrNode)
    display.newSprite(HandRes .. "score_" .. bookCsv[name] .. ".png"):pos(75 + xPos, yPos):addTo(self.attrNode)
  end
end

return ChooseItemLayer
