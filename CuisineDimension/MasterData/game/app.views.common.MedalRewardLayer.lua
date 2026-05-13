local ItemCsv = require("csvdata.item")
local MedalCsv = require("csvdata.achievement")
local uiData = {
  csbFile = "ui/global/MedalRewardLayer.csb",
  popup = true,
  mask = true,
  widgets = {
    popAction = "popAction",
    touch = "touch",
    mainBg = "mainBg",
    node = "node",
    content = "content"
  }
}
local MedalRewardLayer = class("MedalRewardLayer", UIBase)

function MedalRewardLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
  self.callback = params.callback
  if UIHelper.isiPhoneX() then
    self:setPositionX(UIHelper.getMoveXForX())
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.mainBg:setCallback(function()
    self:autoClose()
  end)
  self.touch:setCallback(function()
    self:autoClose()
  end)
end

function MedalRewardLayer:autoClose()
  if self.callback then
    self.callback()
  end
  self:close()
end

function MedalRewardLayer:init(params)
  game:playMusic(1023)
  self.showSuit = params.equip
  self.items = params.items or {}
  self.bShow = params.bShow or false
  self.check = params.check or false
  self.notShowEffect = params.notShowEffect or false
  local heros = {}
  local awakeHeros = {}
  for itemId, count in pairs(self.items) do
    local data = ItemCsv[itemId] or {}
    if data.type == ItemType.Hero and (not self.check or self.check and CommonHelper.showHeroAnimation(itemId - ItemStartId.hero, count)) then
      table.insert(heros, itemId)
    elseif data.type == ItemType.AwakeHero and (not self.check or self.check and CommonHelper.showHeroAnimation(math.floor((itemId - ItemStartId.awakeHero) / 10), count)) then
      table.insert(awakeHeros, itemId)
    else
      self.bShow = true
    end
  end
  if next(heros) and not self.notShowEffect then
    self:hide()
    self:checkHero(heros)
  elseif next(awakeHeros) and not self.notShowEffect then
    self:hide()
    self:checkAwakeHero(awakeHeros)
  else
    self:showItems()
  end
end

function MedalRewardLayer:checkHero(heros)
  if next(heros) then
    HeroRewardLayer.new({
      type = heros[1] - ItemStartId.hero,
      callback = function()
        table.remove(heros, 1)
        self:checkHero(heros)
      end
    })
  else
    if not self.bShow then
      self:autoClose()
      return
    end
    self:show()
    self.popAction:scale(0.4)
    self.popAction:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
    self:showItems()
  end
end

function MedalRewardLayer:checkAwakeHero(heros)
  if next(heros) then
    HeroRewardLayer.new({
      type = math.floor((heros[1] - ItemStartId.awakeHero) / 10),
      callback = function()
        table.remove(heros, 1)
        self:checkAwakeHero(heros)
      end
    })
  else
    if not self.bShow then
      self:autoClose()
      return
    end
    self:show()
    self.popAction:scale(0.4)
    self.popAction:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
    self:showItems()
  end
end

function MedalRewardLayer:showItems()
  local num = table.nums(self.items)
  local xPos, interval = (num - 1) / 2 * -100, 100
  local index = 0
  if num <= 6 then
    for id, count in pairs(self.items) do
      if count ~= 0 then
        if (ItemCsv[id].type == ItemType.Equip or ItemCsv[id].type == ItemType.NewEquip) and self.showSuit then
          ItemIcon.new({
            type = id,
            count = 1,
            showTip = true,
            equipId = count
          }):pos(xPos + index * interval, 0):addTo(self.node)
        else
          ItemIcon.new({
            type = id,
            count = count,
            showTip = true
          }):pos(xPos + index * interval, 0):addTo(self.node)
        end
        index = index + 1
      end
    end
  else
    local size = self.content:getContentSize()
    local list = ccui.ListView:create()
    list:size(size)
    list:setInnerContainerSize(size)
    list:setClippingEnabled(true)
    list:anch(0, 0):pos(0, 0):addTo(self.content)
    list:setDirection(2)
    for id, count in pairs(self.items) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(100, 100)):addTo(list)
      local giftImage = ItemIcon.new({
        type = tonumber(id),
        count = tonumber(count),
        showTip = true
      }):pos(50, 50):addTo(viewNode)
    end
  end
end

return MedalRewardLayer
