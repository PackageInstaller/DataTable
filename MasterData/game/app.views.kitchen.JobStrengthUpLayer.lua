local ItemCsv = require("csvdata.item")
local jobItemCsv = require("csvdata.hero_job_item")
local jobRes = "ui/hero/job/"
local uiData = {
  csbFile = "ui/kitchen/JobStrengthUpLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    closeBtn = "popAction/closeBtn",
    btnCommon = "popAction/btnCommon"
  }
}
local JobStrengthUpLayer = class("JobStrengthUpLayer", UIBase)

function JobStrengthUpLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JobStrengthUpLayer:init(params)
  self.callBack = params.callBack or nil
  self.useList = params.userList or {}
  self.labelList = {}
  local posList = {
    [1] = 108,
    [2] = 273,
    [3] = 438,
    [4] = 603
  }
  for i = 1, 4 do
    self:createItemCell(i, posList[i])
  end
  self.btnCommon:setTouchScale()
  self.btnCommon:setCallback(function()
    if self.callBack then
      self.callBack(self.useList)
    end
    self:close()
  end)
  self.closeBtn:setTouchScale()
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function JobStrengthUpLayer:createItemCell(index, posx)
  local itemData = ItemCsv[globalCsv.heroJobItemIds[index]]
  local bg = display.newSprite(jobRes .. "cell.png"):addTo(self.popAction):pos(posx, 216)
  display.newTTFLabel({
    text = itemData.name,
    size = 14,
    align = cc.TEXT_ALIGNMENT_CENTER
  }):pos(77, 169):addTo(bg)
  ItemIcon.new({
    type = globalCsv.heroJobItemIds[index],
    count = game.role.items[globalCsv.heroJobItemIds[index]] or 0,
    showTip = true,
    needShowCount = true
  }):scale(0.73):pos(77.5, 105):addTo(bg)
  local input = UIHelper.newImageView(jobRes .. "input_bg.png"):pos(77.5, 41):addTo(bg)
  local numText = display.newTTFLabel({
    text = "" .. (self.useList[itemData.itemId] or 0),
    size = 22,
    align = cc.TEXT_ALIGNMENT_CENTER,
    color = UIHelper.hex2rgb("#6c4239")
  }):center(input):addTo(input)
  self.labelList[index] = numText
  input:setCallback(function()
    local layer = game:createView("common.InputLayer", {
      longth = 6,
      content = numText:getString(),
      inputMode = cc.EDITBOX_INPUT_MODE_NUMERIC,
      callback = function(str)
        if not self:isPureNumber(str) then
          SysError(SYS_ERR_NOT_NUMBER)
          return
        end
        local count = self:checkItemCount(index, str)
        numText:setString("" .. count)
        self.useList[globalCsv.heroJobItemIds[index]] = count
        BackManager:pop()
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  local btnSub = UIHelper.extend(ccui.Button:create())
  btnSub:setImages(jobRes, {"sub.png", "sub.png"})
  btnSub:pos(24, 41):addTo(bg)
  btnSub:setTouchScale()
  btnSub:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(index, -1, numText)
    end, 0.1)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(index, -1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(index, -1)
  end)
  local btnAdd = UIHelper.extend(ccui.Button:create())
  btnAdd:setImages(jobRes, {"add.png", "add.png"})
  btnAdd:pos(132, 41):addTo(bg)
  btnAdd:setTouchScale()
  btnAdd:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(index, 1)
    end, 0.1)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(index, 1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(index, 1)
  end)
end

function JobStrengthUpLayer:checkItemCount(index, countStr)
  local count = 0
  if tonumber(countStr) <= game.role.items[globalCsv.heroJobItemIds[index]] then
    count = 0 > tonumber(countStr) and 0 or tonumber(countStr)
  else
    count = game.role.items[globalCsv.heroJobItemIds[index]]
  end
  return count
end

function JobStrengthUpLayer:isPureNumber(str)
  return string.find(str, "^%d+$") ~= nil
end

function JobStrengthUpLayer:changeNum(index, num)
  local itemId = globalCsv.heroJobItemIds[index]
  self.useList[itemId] = self.useList[itemId] or 0
  local itemCount = game.role.items[itemId] or 0
  if self.useList[itemId] + num >= 0 and itemCount >= self.useList[itemId] + num then
    self.useList[itemId] = self.useList[itemId] + num
  end
  if self.labelList[index] then
    self.labelList[index]:setString(self.useList[itemId] .. "")
  end
end

return JobStrengthUpLayer
