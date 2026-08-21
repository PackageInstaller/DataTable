local uiData = {
  csbFile = "ui/kitchen/BuildHerosCostLayer.csb",
  mask = true,
  popup = true,
  opacity = 115,
  widgets = {
    content = "content",
    title = "title",
    okBtn = "confirm",
    cancelBtn = "cancel",
    btnClose = "btnClose"
  }
}
local BuildHerosCostLayer = class("BuildHerosCostLayer", UIBase)

function BuildHerosCostLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BuildHerosCostLayer:init(params)
  self.btnClose:setTouchScale()
  self.okBtn:setTouchScale()
  self.cancelBtn:setTouchScale()
  self.costData = params.cost
  self.title:setString("烹饪消耗")
  self.okBtn:getTitleRenderer():setString("去商城")
  self.cancelBtn:getTitleRenderer():setString("补齐")
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btnClose:setCallback(function()
    self:close()
  end)
  self.okBtn:setCallback(function()
    if params.okCallback then
      params.okCallback()
    end
    self:close()
  end)
  self.cancelBtn:setCallback(function()
    if params.cancleCallback then
      params.cancleCallback()
    end
    self:close()
  end)
end

function BuildHerosCostLayer:showData(params)
  MRichText.new({
    text = string.format("确定花费 <img src='ui/global/5.png' scale=0.5 />x%d 补齐资源吗？", params.all),
    color = UIHelper.hex2rgb("#633c25"),
    size = 20,
    maxWidth = 600
  }):anch(0, 0.5):pos(0, 0):addTo(self.content)
  local itemIds = {
    1,
    2,
    3,
    4,
    28,
    31
  }
  local icons = {
    "base_1.png",
    "base_2.png",
    "base_3.png",
    "base_4.png",
    "base_herobuild.png",
    "base_quick1.png"
  }
  local cur, xPos, yPos = 0, 0, -40
  for index, itemId in ipairs(itemIds) do
    if self.costData[itemId] then
      local rate = globalCsv.cook_autocomplete[itemId]
      local bg = display.newSprite("ui/kitchen/build/build_cost_item_bg.png"):anch(0, 0.5):pos(xPos, yPos):addTo(self.content)
      display.newSprite("ui/global/" .. icons[index]):pos(15, 17):addTo(bg)
      display.newTTFLabel({
        text = self.costData[itemId] / rate.cost * rate.count,
        size = 20,
        color = UIHelper.hex2rgb("#633c25")
      }):anch(0, 0.5):pos(35, 16):addTo(bg)
      display.newTTFLabel({
        text = "=",
        size = 20,
        color = UIHelper.hex2rgb("#633c25")
      }):anch(0, 0.5):pos(165, 15):addTo(bg)
      display.newSprite("ui/global/base_diamond.png"):scale(0.64):pos(200, 17):addTo(bg)
      display.newTTFLabel({
        text = self.costData[itemId],
        size = 20,
        color = UIHelper.hex2rgb("#633c25")
      }):anch(0, 0.5):pos(215, 16):addTo(bg)
      xPos = xPos + 300
      if cur % 2 == 1 then
        xPos = 0
        yPos = yPos - 40
      end
      cur = cur + 1
    end
  end
end

return BuildHerosCostLayer
