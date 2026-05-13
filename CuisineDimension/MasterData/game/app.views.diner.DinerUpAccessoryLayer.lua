local AccessCsv = require("csvdata.diner_accessory")
local EntryCsv = require("csvdata.diner_entry")
local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/diner/DinerUpAccessoryLayer.csb",
  popup = true,
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    title = "title",
    node1 = "node1",
    node2 = "node2",
    confirm = "confirm",
    cancel = "cancel"
  }
}
local DinerUpAccessoryLayer = class("DinerUpAccessoryLayer", UIBase)

function DinerUpAccessoryLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerUpAccessoryLayer:init(params)
  self.title:setString("配件升级")
  display.newTTFLabel({text = "取消", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.cancel)
  display.newTTFLabel({text = "升级", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.confirm)
  self.cancel:setTouchScale()
  self.confirm:setTouchScale()
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
end

function DinerUpAccessoryLayer:showData(params)
  self.node1:removeAllChildren()
  self.node2:removeAllChildren()
  local access = game.role.diner.accessories[params.id]
  local data = AccessCsv[access.type]
  AccessIcon.new({
    id = params.id
  }):pos(67, 0):addTo(self.node1)
  display.newTTFLabel({
    text = data.name,
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0, 0.5):pos(127, 35):addTo(self.node1)
  local id, value = access.baseAttr:match("(%d+%.?%d*)=(%d+%.?%d*)")
  local entry = EntryCsv[tonumber(id)]
  local texts = {
    "能量属性:",
    "基础属性:"
  }
  local yPos = 5
  for i, text in ipairs(texts) do
    display.newSprite("ui/diner/info/image_block.png"):pos(135, yPos):addTo(self.node1)
    display.newTTFLabel({
      text = text,
      size = 18,
      color = UIHelper.hex2rgb("#753613")
    }):anch(0, 0.5):pos(148, yPos):addTo(self.node1)
    for index = 1, 4 do
      display.newSprite("ui/kitchen/quality/arrow.png"):pos(465 + (index - 1) * 6, yPos - 2):addTo(self.node1)
    end
    yPos = yPos - 31
    if not entry then
      break
    end
  end
  local rate1 = globalCsv.dinnerEntryStrengthRange:getv(access.level, 1)
  local rate2 = globalCsv.dinnerEntryStrengthRange:getv(access.level + 1, 1)
  local tip = data.type == 1 and "电池提供动力:" or "配件消耗动力:"
  display.newTTFLabel({
    text = tip .. math.floor(data.energy * rate1),
    size = 18,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0, 0.5):pos(232, 5):addTo(self.node1)
  display.newTTFLabel({
    text = math.floor(data.energy * rate2),
    size = 18,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0, 0.5):pos(495, 5):addTo(self.node1)
  local percent = {
    [1] = 1,
    [2] = 1,
    [5] = 1,
    [6] = 1,
    [9] = 1,
    [10] = 1,
    [13] = 1,
    [14] = 1,
    [19] = 1,
    [20] = 1
  }
  if entry then
    local value1 = string.format(entry.desc, string.format("%0.1f", tonumber(value) * rate1))
    display.newTTFLabel({
      text = value1,
      size = 18,
      color = UIHelper.hex2rgb("#753613")
    }):anch(0, 0.5):pos(232, -26):addTo(self.node1)
    local str = ""
    if percent[entry.type] then
      str = "%"
    end
    display.newTTFLabel({
      text = string.format("%0.1f", tonumber(value) * rate2) .. str,
      size = 18,
      color = UIHelper.hex2rgb("#753613")
    }):anch(0, 0.5):pos(495, -26):addTo(self.node1)
  end
  local cost = {}
  local costSet = data.cost:toTableArray()
  display.newTTFLabel({
    text = "消耗:",
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):pos(80, 0):addTo(self.node2)
  local bg1 = display.newSprite("ui/diner/up/num_bg.png"):pos(355, 71):addTo(self.node1)
  display.newSprite(string.format("ui/diner/up/type_%d.png", data.type)):pos(5, 15):addTo(bg1)
  display.newTTFLabel({
    text = game.role.items[tonumber(costSet[access.level + 1][2])] or 0,
    size = 22
  }):pos(62, 15):addTo(bg1)
  display.newSprite(ItemCsv[tonumber(costSet[access.level + 1][2])].icon):scale(0.6):pos(170, 0):addTo(self.node2)
  display.newTTFLabel({
    text = costSet[access.level + 1][3],
    size = 22,
    color = UIHelper.hex2rgb("#753213")
  }):anch(0, 0.5):pos(200, 0):addTo(self.node2)
  cost[tonumber(costSet[access.level + 1][2])] = tonumber(costSet[access.level + 1][3])
  local set = data.moneyCost:toTableArray()
  local temp
  for _, data in ipairs(set) do
    if access.level == tonumber(data[1]) then
      temp = data
    end
  end
  if temp then
    display.newSprite(ItemCsv[tonumber(temp[2])].icon):scale(0.6):pos(285, 0):addTo(self.node2)
    display.newTTFLabel({
      text = temp[3],
      size = 22,
      color = UIHelper.hex2rgb("#753213")
    }):anch(0, 0.5):pos(315, 0):addTo(self.node2)
    cost[tonumber(temp[2])] = tonumber(temp[3])
    local bg2 = display.newSprite("ui/diner/up/num_bg.png"):pos(495, 71):addTo(self.node1)
    display.newSprite("ui/diner/up/money.png"):pos(5, 15):addTo(bg2)
    display.newTTFLabel({
      text = game.role.items[tonumber(temp[2])] or 0,
      size = 22
    }):pos(62, 15):addTo(bg2)
  end
  self.confirm:setCallback(function()
    if not costSet[access.level + 1] then
      SysError(SYS_ERR_DINER_CAR_UP_MAX_LEVEL)
      return
    end
    local enough = true
    for type, count in pairs(cost) do
      if count > (game.role.items[type] or 0) then
        enough = false
      end
    end
    if not enough then
      SysError(SYS_ERR_DINER_CAR_UP_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Diner_upLevelAccessoryRpc, MsgPack.pack({
      id = params.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_upLevelAccessoryRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_DINER_CAR_UP_SUCCESS)
      BackManager:pop()
    end)
  end)
end

function DinerUpAccessoryLayer:close()
  self:removeSelf()
end

return DinerUpAccessoryLayer
