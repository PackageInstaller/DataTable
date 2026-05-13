local ItemCsv = require("csvdata.item")
local jobItemCsv = require("csvdata.hero_job_item")
local StoreRes = "ui/diner/store/"
local ChooseRes = "ui/diner/choose/"
local uiData = {
  csbFile = "ui/kitchen/TreePackageLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    list = "chooseBg/list",
    node = "chooseBg/node",
    countBg = "chooseBg/countBg",
    count = "chooseBg/countBg/count"
  }
}
local JobPackageLayer = class("JobPackageLayer", UIBase)

function JobPackageLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JobPackageLayer:init(params)
  self.showId = 0
  local num = 0
  self.items = {}
  for _, data in pairs(jobItemCsv) do
    local count = game.role.items[data.id] or 0
    if 0 < count then
      num = num + count
      table.insert(self.items, {
        id = data.id,
        count = count
      })
    end
  end
  table.sort(self.items, function(a, b)
    return a.id < b.id
  end)
  self.countBg:hide()
  self.count:setString(string.format("当前拥有:%d", num))
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
      self:loadPage(topRow + 1, bottomRow + 1)
    end
  end)
end

function JobPackageLayer:showData(params)
  self:refreshContent()
end

function JobPackageLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 7
  for index = (row - 1) * colCount + 1, colCount * row do
    if index > #self.items then
      break
    end
    local col = index - (row - 1) * colCount
    self:createCard(index, row):anch(0, 0):pos(5 + (col - 1) * 120, 1):addTo(viewNode)
  end
  self.rowLoaded[row] = true
end

function JobPackageLayer:loadPage(topRow, buttomRow)
  topRow = math.max(1, topRow)
  buttomRow = math.min(#self.rowViews, buttomRow)
  if topRow == buttomRow and topRow < #self.rowViews then
    return
  end
  local rows = {}
  for row = topRow, buttomRow do
    if not self.rowLoaded[row] then
      self:loadList(row)
    end
    rows[row] = true
  end
  for row, _ in pairs(self.rowLoaded) do
    if not rows[row] then
      self.rowLoaded[row] = nil
      self.rowViews[row]:removeAllChildren()
      if self.unChooseList[row] then
        self.unChooseList[row] = {}
      end
    end
  end
end

function JobPackageLayer:refreshContent()
  self.list:removeAllChildren()
  self.rowViews = {}
  self.rowLoaded = {}
  self.unChooseList = {}
  if #self.items == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    local tip = display.newSprite("ui/hero/tip_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = "主厨,您现在还没有符合条件的物品哦",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(435, 147):addTo(tip)
    self.list:requestDoLayout()
    return
  end
  for row = 1, math.ceil(#self.items / 7) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(cc.size(838, 142)):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function JobPackageLayer:createCard(index, curRow)
  local data = self.items[index]
  local card = TreeIcon.new({
    itemId = data.id,
    big = true,
    count = data.count
  })
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  if self.showId == data.id or self.showId == 0 then
    self.showId = data.id
    self.selectImage = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
    self:showItemDetail(data.id)
  end
  card:setCallback(function()
    if self.showId == id then
      return
    end
    self.selectImage:removeSelf()
    self.selectImage = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
    self:showItemDetail(data.id)
  end)
  return card
end

function JobPackageLayer:showItemDetail(id)
  self.showId = id
  self.node:removeAllChildren()
  TreeIcon.new({itemId = id}):scale(0.85):pos(55, 0):addTo(self.node)
  local texts = {
    "道具名字:",
    "道具用途:"
  }
  local yPos = 13
  for index, text in ipairs(texts) do
    display.newSprite(StoreRes .. (index == 4 and "tal_block.png" or "fit_block.png")):pos(125, yPos):addTo(self.node)
    display.newTTFLabel({
      text = text,
      size = 16,
      color = UIHelper.hex2rgb(index == 4 and "#de550a" or "#a99e94")
    }):anch(0, 0.5):pos(140, yPos):addTo(self.node)
    display.newTTFLabel({
      text = index == 1 and ItemCsv[id].name or ItemCsv[id].desc,
      size = 16,
      color = UIHelper.hex2rgb("#a99e94")
    }):anch(0, 0.5):pos(220, yPos):addTo(self.node)
    yPos = yPos - 26
  end
end

return JobPackageLayer
