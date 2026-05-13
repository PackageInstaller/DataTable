local UnionDetailRes = "ui/union/detail/"
local UnionMainRes = "ui/union/main/"
local uiData = {
  csbFile = "ui/union/UnionSearchLayer.csb",
  mask = true,
  widgets = {
    touch = "touch",
    panel = "panel",
    mask = "panel/mask",
    title = "panel/title",
    btnClose = "panel/btnClose",
    confirm = "panel/confirm",
    cancel = "panel/cancel"
  }
}
local UnionSearchLayer = class("UnionSearchLayer", UIBase)

function UnionSearchLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionSearchLayer:init(params)
  self.mask:setSwallowTouches(true)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.callback = params.callback or function()
  end
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
  self.confirm:setCallback(function()
    self:applyShow()
  end)
  self.searchData = params.data
  self:showDetail()
end

function UnionSearchLayer:showDetail()
  display.newTTFLabel({text = "Lv:", size = 45}):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(196, 215):addTo(self.panel)
  local Lv = display.newTTFLabel({
    text = self.searchData.level,
    size = 45,
    color = UIHelper.hex2rgb("#f3db0c")
  }):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(261, 215):addTo(self.panel)
  display.newTTFLabel({
    text = self.searchData.name,
    size = 30
  }):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(50, 23):addTo(Lv)
  local iconBg = display.newSprite(UnionDetailRes .. "image_block.png"):pos(115, 170):addTo(self.panel)
  display.newSprite(UnionMainRes .. string.format("icon_%d.png", self.searchData.headId)):scale(0.8):pos(68, 71):addTo(iconBg)
  local smallTxtBg1 = display.newSprite(UnionDetailRes .. "desc_bg.png"):pos(305, 173):addTo(self.panel)
  display.newTTFLabel({
    text = "协会成员" .. ":" .. self.searchData.limit,
    size = 18,
    color = UIHelper.hex2rgb("#5B361B")
  }):pos(55, 12):addTo(smallTxtBg1)
  local smallTxtBg2 = display.newSprite(UnionDetailRes .. "desc_bg.png"):pos(518, 173):addTo(self.panel)
  display.newTTFLabel({
    text = "Lv:" .. self.searchData.limit .. "以上",
    size = 18,
    color = UIHelper.hex2rgb("#5B361B")
  }):pos(48, 12):addTo(smallTxtBg2)
  local bigTxtBg = display.newScale9Sprite(UnionMainRes .. "multi_input.png", 0, 0, cc.size(424, 56)):anch(0, 0.5):pos(200, 130):addTo(self.panel)
  display.newTTFLabel({
    text = self.searchData.desc,
    size = 18,
    dimensions = cc.size(380, 0)
  }):anch(0, 1):pos(15, 52):addTo(bigTxtBg)
end

function UnionSearchLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

function UnionSearchLayer:applyShow()
  self.callback()
end

return UnionSearchLayer
