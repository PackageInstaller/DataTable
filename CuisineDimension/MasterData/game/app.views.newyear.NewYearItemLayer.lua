local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/newyear/NewYearItemLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    btnAdd = "btnAdd",
    btnSub = "btnSub",
    cancel = "cancel",
    confirm = "confirm",
    itemNode = "itemNode",
    name = "name",
    costNode = "costNode",
    num = "numBg/num",
    desc = "descBg/desc"
  }
}
local NewYearItemLayer = class("NewYearItemLayer", UIBase)

function NewYearItemLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewYearItemLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:setTouchScale()
  self.btnSub:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.curNum = 1
  self.desc:setString(ItemCsv[64].desc)
  self.nameStr = ItemCsv[64].name
  self:refreshContent()
end

function NewYearItemLayer:showData(params)
  ItemIcon.new({type = 64}):addTo(self.itemNode)
  self.btnAdd:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(1)
    end, 0.1)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(1)
  end)
  self.btnSub:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(-1)
    end, 0.2)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(-1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(-1)
  end)
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    for i, value in pairs(globalCsv.ActivitySpecialCost:toNumMap()) do
      if game.role["material" .. i] < self.curNum * value then
        SysError(SYS_ERR_MOON_CARBON_BUY_QUAN_SOURCE_NOT_ENOUGH)
        return
      end
    end
    game:sendData(actionCodes.Activity_newYearFightUpRpc, MsgPack.pack({
      type = 1,
      count = self.curNum
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_newYearFightUpRpc, function(event)
      UIHelper.removeWaiting()
      local reward = {}
      reward[64] = self.curNum
      MedalRewardLayer.new({items = reward})
      if params.func then
        params.func()
      end
      self:close()
    end)
  end)
end

function NewYearItemLayer:refreshContent()
  self.costNode:removeAllChildren()
  self.name:setString(string.format("%sX%d", self.nameStr, self.curNum))
  local xPos = 0
  for i, value in ipairs(globalCsv.ActivitySpecialCost:toNumMap()) do
    display.newSprite("ui/newyear/main/dialog_item_bg.png"):pos(xPos, 0):addTo(self.costNode)
    display.newSprite(string.format("ui/global/base_%d.png", i)):pos(xPos, 5):addTo(self.costNode)
    display.newTTFLabel({
      text = value * self.curNum,
      size = 20,
      color = UIHelper.hex2rgb("#703902")
    }):pos(xPos, -23):addTo(self.costNode)
    xPos = xPos + 92
  end
  self.num:setString(self.curNum)
end

function NewYearItemLayer:changeNum(num)
  self.curNum = self.curNum + num
  if self.curNum < 1 then
    self.curNum = 1
  end
  if self.curNum > 99 then
    self.curNum = 99
  end
  self:refreshContent()
end

return NewYearItemLayer
