local ShowCsv = require("csvdata.equip_show")
local ShowRes = "ui/equip/show/"
local uiData = {
  csbFile = "ui/equip/EquipShowInfoLayer.csb",
  mask = true,
  popup = true,
  opacity = 115,
  maskClick = true,
  widgets = {
    title = "showBg/title",
    node = "showBg/node",
    desc = "showBg/desc",
    list = "showBg/listBg/list"
  }
}
local EquipShowInfoLayer = class("EquipShowInfoLayer", UIBase)

function EquipShowInfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipShowInfoLayer:init(params)
  self.title:setString("改造信息")
end

function EquipShowInfoLayer:showData(params)
  local names = {
    1,
    3,
    2,
    4,
    5,
    6,
    8
  }
  local descs = {
    "食器限定",
    "食器限定",
    "厨具限定"
  }
  local sortData = {}
  for _, data in ipairs(ShowCsv) do
    if not sortData[data.type] then
      sortData[data.type] = {}
    end
    table.insert(sortData[data.type], data)
  end
  local xPos = 0
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 7)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 7)
    end
  })
  for index, name in ipairs(names) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ShowRes, {"btn_a.png", "btn_b.png"})
    btn:anch(0, 0):pos(xPos, 0):addTo(self.node):name("btn" .. index)
    btn:setGroup(group)
    display.newTTFLabel({
      text = AttrDesc[name],
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(43, 23):addTo(btn)
    btn:setCallback(function()
      self.desc:setString(descs[index] or "")
      self:showList(sortData[index] or {})
    end)
    xPos = xPos + 92
  end
  group:chooseByName("btn1")
  self.desc:setString(descs[1])
  self:showList(sortData[1])
end

function EquipShowInfoLayer:showList(listData)
  self.list:removeAllChildren()
  local cellSize = cc.size(662, 60)
  for _, data in ipairs(listData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(self.list)
    local cell = display.newSprite(ShowRes .. "cell.png"):center(viewNode):addTo(viewNode)
    display.newSprite(ShowRes .. "star.png"):pos(25, 29):addTo(cell)
    display.newTTFLabel({
      text = data.star,
      size = 18,
      color = UIHelper.hex2rgb("#915b3d")
    }):pos(42, 29):addTo(cell)
    display.newTTFLabel({
      text = data.scale,
      size = 18,
      color = UIHelper.hex2rgb("#915b3d")
    }):anch(0, 0.5):pos(83, 29):addTo(cell)
  end
  self.list:requestDoLayout()
end

return EquipShowInfoLayer
