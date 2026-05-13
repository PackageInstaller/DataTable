local AccessCsv = require("csvdata.diner_accessory")
local MainRes = "ui/diner/main/"
local RecycleRes = "ui/diner/recycle/"
local AccessoryRecycleLayer = class("AccessoryRecycleLayer", function()
  return UIHelper.newImageView(RecycleRes .. "recycle_bg.png")
end)

function AccessoryRecycleLayer:ctor(params)
  self:pos(350, 0):addTo(params.root)
  self:showData(params)
end

function AccessoryRecycleLayer:showData(params)
  local final = {}
  display.newTTFLabel({
    text = "获得\n材料",
    size = 22,
    color = UIHelper.hex2rgb("#745419")
  }):pos(60, 55):addTo(self)
  display.newTTFLabel({
    text = string.format("已选择: %d/%d", table.nums(params.list), params.max),
    size = 18,
    color = UIHelper.hex2rgb("#745419")
  }):anch(0, 0.5):pos(355, 55):addTo(self)
  local btnOk = UIHelper.extend(ccui.Button:create())
  btnOk:setImages(MainRes, {
    "btn_common.png",
    "btn_common.png"
  })
  btnOk:pos(533, 55):addTo(self)
  btnOk:setTouchScale()
  btnOk:setCallback(function()
    params.callback()
  end)
  display.newTTFLabel({text = "回收", size = 18}):enableOutline(UIHelper.hex2rgb("#886213"), 1):pos(61, 23):addTo(btnOk)
  if next(params.list) then
    for id, _ in pairs(params.list) do
      local access = game.role.diner.accessories[id]
      local set = AccessCsv[access.type].recycle:toTableArray()
      for _, data in ipairs(set) do
        if tonumber(data[1]) == access.level then
          final[tonumber(data[2])] = (final[tonumber(data[2])] or 0) + tonumber(data[3])
          break
        end
      end
    end
  else
    display.newSprite(RecycleRes .. "image_normal.png"):pos(135, 58):addTo(self)
    return
  end
  local xPos = 135
  for type, num in pairs(final) do
    ItemIcon.new({
      type = type,
      count = num,
      showTip = true
    }):scale(0.73):pos(xPos, 58):addTo(self)
    xPos = xPos + 72
  end
end

return AccessoryRecycleLayer
