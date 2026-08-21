local BoxCsv = require("csvdata.diner_box")
local TalentCsv = require("csvdata.diner_talent_type")
local TelantRes = "ui/diner/talent/"
local uiData = {
  csbFile = "ui/diner/DinerTalentLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    node = "node",
    name = "nameBg/name",
    label = "imageDown/label",
    num = "imageDown/num",
    specialDescBg = "specialDescBg",
    specialDesc = "specialDescBg/specialDesc",
    barBg = "barBg",
    bar = "barBg/bar",
    descNode = "descNode"
  }
}
local DinerTalentLayer = class("DinerTalentLayer", UIBase)

function DinerTalentLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerTalentLayer:init(params)
  self.specialDescBg:hide()
  self.label:setString("满足度")
  self.boxId = params.boxId
  self.comfort = params.comfort or 0
end

function DinerTalentLayer:showData(params)
  local BoxData = params.boxData and params.boxData or BoxCsv[self.boxId][game.role.boxLevel]
  local talents = BoxData.talent:toTableArray()
  local max = tonumber(talents[#talents][1])
  local long = self.barBg:getContentSize().width
  self.name:setString(BoxData.name)
  self.num:setString(string.format("%d/%d", self.comfort, max))
  self.bar:setPercent(self.comfort / max * 100)
  display.newSprite(BoxData.pic):anch(0, 0):addTo(self.node)
  for index, data in ipairs(talents) do
    local value, id = tonumber(data[1]), tonumber(data[2])
    local done = value <= self.comfort
    local numBg = display.newSprite(TelantRes .. (done and "num_bg_1.png" or "num_bg_2.png")):anch(0.5, 0):pos(long * value / max - 3, 12):addTo(self.barBg)
    numBg:setLocalZOrder(-1)
    display.newTTFLabel({text = value, size = 20}):enableOutline(UIHelper.hex2rgb("#410d08"), 1):pos(long * value / max - 5, 30):addTo(self.barBg)
    display.newTTFLabel({text = index, size = 28}):pos(19, 41):addTo(numBg)
    local descBg = display.newSprite(TelantRes .. (done and "desc_bg_1.png" or "desc_bg_2.png")):anch(0, 1):pos(0, -45 * (index - 1)):addTo(self.descNode)
    display.newTTFLabel({text = index, size = 28}):pos(17, 22):addTo(descBg)
    display.newTTFLabel({
      text = TalentCsv[id].name,
      size = 18,
      color = UIHelper.hex2rgb(done and "7ad617" or "#c15f2a")
    }):anch(0, 0.5):pos(40, 23):addTo(descBg)
  end
  if BoxData.special ~= 0 then
    self.specialDescBg:show()
    self.specialDesc:setString(TalentCsv[BoxData.special].name)
  end
end

return DinerTalentLayer
