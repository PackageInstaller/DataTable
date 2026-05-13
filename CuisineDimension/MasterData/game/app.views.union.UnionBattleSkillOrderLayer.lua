local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local profCsv = require("csvdata.profession")
local treatRes = "ui/treat/"
local GlobalRes = "ui/global/"
local skillOrderRes = "ui/pvp/skillOrder/"
local uiData = {
  csbFile = "ui/pvp/PvpSkillOrderLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    hero = "hero",
    btnOk = "ok",
    cancel = "cancel"
  }
}
local PvpSkillOrderLayer = class("PvpSkillOrderLayer", UIBase)

function PvpSkillOrderLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpSkillOrderLayer:init(params)
  self.index = params.index
  self.formationData = game.role.activityStatus["89"].formatInfo or {
    list = {},
    skillOrder = {}
  }
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btnOk:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:setTouchScale()
  self.btnOk:setTouchScale()
  self:initHeroInfo()
  self:showOrder()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.btnOk:setCallback(function()
    if params.callback then
      local result = {}
      local change = false
      for i = 1, #self.cards do
        result[self.cards[i].slot] = self.cards[i].skillOrder
        if not change and self.cards[i].choose then
          change = true
        end
      end
      if change then
        params.callback(result)
      end
      self:close()
    end
  end)
end

function PvpSkillOrderLayer:initHeroInfo()
  local x, y, interval = 0, -4, 111
  self.hero:removeAllChildren()
  self.cards = {}
  local count = 1
  for i = 1, 5 do
    local slot = tostring(i)
    if self.formationData.list[slot] and game.role.heros[self.formationData.list[slot]] then
      local hero = game.role.heros[self.formationData.list[slot]]
      local card = HeroHead.new({
        type = hero:getDressType(),
        level = hero.level,
        quality = hero.quality
      }):pos(x + (count - 1) * interval, y):addTo(self.hero)
      card.choose = false
      card.slot = slot
      card.skillOrder = self.formationData.skillOrder[slot]
      card:setCallback(function()
        card.choose = not card.choose
        self:refreshOrder(card)
        self:showOrder()
      end)
      self.cards[#self.cards + 1] = card
      count = count + 1
    end
  end
end

function PvpSkillOrderLayer:refreshOrder(card)
  local haveChoose = 0
  for i = 1, #self.cards do
    if self.cards[i].choose then
      haveChoose = haveChoose + 1
    end
  end
  if card.choose then
    card.skillOrder = haveChoose
  else
    local skillOrder = card.skillOrder
    for i = 1, #self.cards do
      if self.cards[i].choose and skillOrder < self.cards[i].skillOrder then
        self.cards[i].skillOrder = self.cards[i].skillOrder - 1
      end
    end
  end
  for i = 1, #self.cards do
    if not self.cards[i].choose then
      haveChoose = haveChoose + 1
      self.cards[i].skillOrder = haveChoose
    end
  end
end

function PvpSkillOrderLayer:showOrder()
  for i = 1, #self.cards do
    if self.cards[i]:getChildByName("order") then
      self.cards[i]:removeChildByName("order")
    end
    local spr = display.newSprite(skillOrderRes .. string.format("order%d.png", self.cards[i].skillOrder)):center(self.cards[i]):addTo(self.cards[i], 1000000):name("order")
    if not self.cards[i].choose then
      spr:setOpacity(110)
    end
  end
end

function PvpSkillOrderLayer:showData()
end

return PvpSkillOrderLayer
