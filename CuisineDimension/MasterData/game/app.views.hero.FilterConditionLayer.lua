local FilterRes = "ui/hero/filter/"
local uiData = {
  csbFile = "ui/hero/FilterConditionLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    type0 = "mainBg/type0",
    type1 = "mainBg/type1",
    type2 = "mainBg/type2",
    type3 = "mainBg/type3",
    type4 = "mainBg/type4",
    type5 = "mainBg/type5",
    type6 = "mainBg/type6",
    rule1 = "mainBg/rule1",
    rule2 = "mainBg/rule2",
    rule3 = "mainBg/rule3",
    rule4 = "mainBg/rule4",
    rule5 = "mainBg/rule5",
    rule6 = "mainBg/rule6",
    rule7 = "mainBg/rule7",
    title = "mainBg/title",
    desc1 = "mainBg/desc1",
    desc2 = "mainBg/desc2",
    label1 = "mainBg/label1",
    label2 = "mainBg/label2",
    label3 = "mainBg/label3",
    cancel = "mainBg/cancel",
    ok = "mainBg/ok"
  }
}
local TypeNames = {}
local FrontNames = {}
local HeroTypeNames = {
  "主食",
  "主菜",
  "副菜",
  "甜点",
  "头盘",
  "汤饮"
}
local EquipTypeNames = {
  "食器",
  "厨具",
  "餐具"
}
local SauceTypeNames = HeroTypeNames
local FilterConditionLayer = class("FilterConditionLayer", UIBase)

function FilterConditionLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FilterConditionLayer:init(params)
  self.cancel:setTouchScale()
  self.ok:setTouchScale()
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.ok:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.desc1:setString("索引")
  self.desc2:setString("排序")
  local callback = params.callback
  self.endTypes = params.professions or {}
  self.ruleFront = params.ruleFront or 1
  local showType = params.showType or 1
  TypeNames = showType == 1 and HeroTypeNames or showType == 2 and EquipTypeNames or SauceTypeNames
  FrontNames = showType == 1 and RuleFrontNames or showType == 2 and EquipFrontNames or SauceFrontNames
  self:changeUI(showType)
  self:initBtns()
  self:reflashTypeBtns()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.ok:setCallback(function()
    if callback then
      local res = callback({
        professions = self.endTypes,
        ruleFront = self.ruleFront
      })
      if not res then
        self:close()
      end
    end
  end)
end

function FilterConditionLayer:changeUI(showType)
  for idx = 1, 7 do
    if idx > #TypeNames and idx ~= 7 then
      self["type" .. idx]:hide()
    end
    if idx > #FrontNames then
      self["rule" .. idx]:hide()
    end
  end
  if showType == 2 then
    self.label1:hide()
    self.label2:hide()
    self.label3:hide()
    self.type0:setPositionY(self.type0:getPositionY() + (3 - math.ceil(#TypeNames / 2)) * 65)
  end
end

function FilterConditionLayer:initBtns()
  for i, name in ipairs(TypeNames) do
    local btn = self["type" .. i]
    display.newSprite(FilterRes .. string.format("image_%d.png", i)):pos(35, 23):addTo(btn)
    display.newTTFLabel({text = name, size = 18}):enableOutline(UIHelper.hex2rgb("#a57219"), 1):pos(74, 23):addTo(btn)
    btn:setCallback(function()
      if self.endTypes[i] then
        self.endTypes[i] = nil
      else
        self.endTypes[i] = 1
      end
      self:reflashTypeBtns()
    end)
  end
  display.newTTFLabel({text = "全部", size = 18}):enableOutline(UIHelper.hex2rgb("#a57219"), 1):pos(60, 23):addTo(self.type0)
  self.type0:setCallback(function()
    self.endTypes = {}
    self:reflashTypeBtns()
  end)
  for i, name in ipairs(FrontNames) do
    local btn = self["rule" .. i]
    display.newTTFLabel({text = name, size = 18}):enableOutline(UIHelper.hex2rgb("#a57219"), 1):pos(65, 23):addTo(btn)
    if self.ruleFront == i then
      btn:setImage(FilterRes .. "btn_b.png")
    end
    btn:setCallback(function()
      if i == self.ruleFront then
        return
      end
      self["rule" .. self.ruleFront]:setImage(FilterRes .. "btn_a.png")
      btn:setImage(FilterRes .. "btn_b.png")
      self.ruleFront = i
    end)
  end
end

function FilterConditionLayer:reflashTypeBtns()
  if table.nums(self.endTypes) > 0 and table.nums(self.endTypes) < #TypeNames then
    self.type0:setImage(FilterRes .. "btn_a.png")
  else
    self.endTypes = {}
    self.type0:setImage(FilterRes .. "btn_b.png")
  end
  for i, _ in ipairs(TypeNames) do
    self["type" .. i]:setImage(FilterRes .. (self.endTypes[i] and "btn_b.png" or "btn_a.png"))
  end
end

return FilterConditionLayer
