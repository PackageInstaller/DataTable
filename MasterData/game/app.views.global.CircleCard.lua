local cookRes = "ui/kitchen/cook/"
local names = {
  [1] = "食油",
  [2] = "魔力",
  [3] = "食材",
  [4] = "调料"
}
local CircleCard = class("CircleCard", function()
  return UIHelper.extend(ccui.ImageView:create())
end)

function CircleCard:ctor(params)
  self:initData(params)
  self:uiLayout()
  self.clickCallback = params.callback
end

function CircleCard:initData(params)
  self.type = params.type
  self.rotate = params.rotate or 0
end

function CircleCard:uiLayout()
  self:setImage(cookRes .. "circle_white.png")
  self:name("circle" .. self.type)
  local size = self:getContentSize()
  self:setRotation(self.rotate)
  local icon = UIHelper.newImageView(cookRes .. string.format("material%d.png", self.type)):center(self):addTo(self)
  if self.type == 3 then
    icon:pos(75, 81)
  end
  if self.type == 4 then
    icon:pos(80, 80)
  end
  self.name = display.newTTFLabel({
    text = names[self.type],
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(size.width / 2, 147):addTo(self)
  self.valueBg = UIHelper.newImageView(cookRes .. "value_bg.png"):pos(size.width / 2, 15):addTo(self)
  self.valueLabel = display.newTTFLabel({
    text = UserData.materialTable[self.type],
    size = 26,
    color = UIHelper.hex2rgb("#61361e")
  }):pos(33, 20.5):addTo(self.valueBg)
  display.newTTFLabel({
    text = "g",
    size = 26,
    color = UIHelper.hex2rgb("#61361e")
  }):pos(68, 20.5):addTo(self.valueBg)
  if self.clickCallback then
    self:setCallback(function()
      self.clickCallback()
    end)
  end
  local offset = self.type % 2 == 0 and 20 or -20
  self:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(4, cc.p(0, offset)),
    cc.MoveBy:create(4, cc.p(0, -offset)),
    cc.MoveBy:create(4, cc.p(0, -offset)),
    cc.MoveBy:create(4, cc.p(0, offset))
  })))
end

function CircleCard:setHomeBg(image)
  self:setImage(image)
end

function CircleCard:setValue(value)
  self.valueLabel:setString(value)
end

function CircleCard:getValue()
  return tonumber(self.valueLabel:getString())
end

function CircleCard:getValueLabel()
  return self.valueLabel
end

function CircleCard:getHidePart()
  return self.name, self.valueBg
end

function CircleCard:hideValueLabel()
  self.valueBg:hide()
end

return CircleCard
