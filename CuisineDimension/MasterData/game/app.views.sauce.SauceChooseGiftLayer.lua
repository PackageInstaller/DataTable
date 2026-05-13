local uiData = {
  csbFile = "ui/sauce/SauceChooseGiftLayer.csb",
  popup = true,
  mask = true,
  widgets = {
    popAction = "popAction",
    cancel = "cancel",
    confirm = "confirm",
    itemNode = "itemNode",
    desc = "popAction/descBg/desc"
  }
}
local SauceChooseGiftLayer = class("SauceChooseGiftLayer", UIBase)

function SauceChooseGiftLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceChooseGiftLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.parent = params.parent
  self.desc:setString("领取后将会消耗一次挑战次数")
  self.cancel:setCallback(function()
    self.parent:close()
    params.cancelBack()
    self:close()
  end)
  self.confirm:setCallback(function()
    self.parent:close()
    params.okBack()
    self:close()
  end)
end

function SauceChooseGiftLayer:showData(params)
  local gift = params.gift:toTableArray()
  local xPos = -(#gift - 1) / 2 * 100
  for _, data in ipairs(gift) do
    ItemIcon.new({
      type = tonumber(data[1]),
      count = tonumber(data[2]),
      showTip = true
    }):pos(xPos, 0):addTo(self.itemNode)
    xPos = xPos + 100
  end
end

return SauceChooseGiftLayer
