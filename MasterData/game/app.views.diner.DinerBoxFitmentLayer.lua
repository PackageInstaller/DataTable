local FilterLogic = import(".FilterFitmentLogic")
local ItemCsv = require("csvdata.item")
local FitCsv = require("csvdata.diner_fitment")
local BoxCsv = require("csvdata.diner_box")
local SortCsv = require("csvdata.diner_fitment_sort")
local MainRes = "ui/diner/main/"
local StoreRes = "ui/diner/store/"
local ChooseRes = "ui/diner/choose/"
local uiData = {
  csbFile = "ui/diner/DinerBoxFitmentLayer.csb",
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    mask = "mask",
    maskNode = "maskNode",
    btnOrder1 = "btnOrder1",
    btnOrder2 = "btnOrder2",
    list = "chooseBg/list",
    btnMode = "chooseBg/btnMode",
    countBg = "chooseBg/countBg",
    node = "chooseBg/node",
    count = "chooseBg/countBg/count",
    fitName = "btnOrder1/fitName",
    themeName = "btnOrder2/themeName",
    modeName = "chooseBg/btnMode/modeName"
  }
}
local DinerBoxFitmentLayer = class("DinerBoxFitmentLayer", UIBase)

function DinerBoxFitmentLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxFitmentLayer:init(params)
  self.chooseList = {}
  self.unChooseList = {}
  self.btnFitState = true
  self.btnThemeState = true
  self.btnModeState = true
  self.max = params.max or 5
  self.showId = 0
  self.using = {}
  self.desc = params.desc or "符合条件种类: "
  self.countBg:hide()
  self.maskNode:setLocalZOrder(50)
  self.modeName:setString("回收")
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.FitFilter = FilterLogic.new({
    fits = self:getFitSource()
  })
  self.FitFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:initSortRule()
  self.btnOrder1:setCallback(function()
    self:showFitTypeSelect()
  end)
  self.btnOrder2:setCallback(function()
    self:showThemeTypeSelect()
  end)
  self.btnMode:setCallback(function()
    self:changeMode()
  end)
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

function DinerBoxFitmentLayer:initSortRule()
  self.orderData1 = SortCsv[1]
  self.orderData2 = SortCsv[2]
  self.FitType = self.orderData1[1].content
  self.ThemeType = self.orderData2[1].content
  self.fitName:setString(self.orderData1[1].name)
  self.themeName:setString(self.orderData2[1].name)
  self:setFilter()
end

function DinerBoxFitmentLayer:getFitSource()
  local fits = {}
  local using = {}
  for boxId = 1, game.role.diner.dinerBoxMaxNum do
    local temp = json.decode(game.role.diner["box" .. boxId]) or {}
    for _, data in pairs(temp.rugs or {}) do
      using[data.item] = (using[data.item] or 0) + 1
    end
    for _, data in pairs(temp.fitments or {}) do
      using[data.item] = (using[data.item] or 0) + 1
    end
    for _, data in pairs(temp.wallItems or {}) do
      using[data.item] = (using[data.item] or 0) + 1
    end
  end
  for id, count in pairs(game.role.diner.item_fitment) do
    local tempNum = count - (using[id] or 0)
    if 0 < tempNum then
      table.insert(fits, {id = id, count = tempNum})
    end
  end
  return fits
end

function DinerBoxFitmentLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 7
  for index = (row - 1) * colCount + 1, colCount * row do
    if index > #self.fits then
      break
    end
    local col = index - (row - 1) * colCount
    self:createCard(index, row):anch(0, 0):pos(5 + (col - 1) * 120, 1):addTo(viewNode)
  end
  self.rowLoaded[row] = true
  if self.max then
    self:checkMax()
  end
end

function DinerBoxFitmentLayer:loadPage(topRow, buttomRow)
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

function DinerBoxFitmentLayer:refreshContent()
  self.list:removeAllChildren()
  self.showId = 0
  self.rowViews = {}
  self.rowLoaded = {}
  self.chooseList = {}
  self.unChooseList = {}
  self.fits = self.FitFilter:getResult()
  local maxCount = #self.fits
  if maxCount == 0 then
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
  for row = 1, math.ceil(#self.fits / 7) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(cc.size(838, 142)):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function DinerBoxFitmentLayer:createCard(index, curRow)
  local fit = self.fits[index]
  local card = FitIcon.new({
    id = fit.id,
    big = true,
    count = fit.count
  })
  if not self.unChooseList[curRow] then
    self.unChooseList[curRow] = {}
  end
  if self.chooseList[fit.id] then
    self:addExtraFunc(card, fit)
  end
  if self.btnModeState and self.showId == 0 or self.showId == fit.id then
    self.selectImage = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
    self:showFitDetail(fit.id)
  elseif not self.btnModeState and self.showId == 0 then
    self.showId = fit.id
    self:showRecycle()
  end
  card:setCallback(function()
    local lock = card:getChildByName("lock")
    if lock then
      return
    end
    if self.btnModeState then
      self.selectImage:removeSelf()
      self.selectImage = display.newSprite(ChooseRes .. "select.png"):center(card):addTo(card)
      self:showFitDetail(fit.id)
      return
    end
    if not self.chooseList[fit.id] then
      self.chooseList[fit.id] = fit.count
      self:addExtraFunc(card, fit)
      self:showRecycle()
    end
  end)
  self.unChooseList[curRow][fit.id] = card
  return card
end

function DinerBoxFitmentLayer:addExtraFunc(card, fit)
  local bg = display.newSprite(StoreRes .. "fit_choose.png"):center(card):addTo(card, nil, 100)
  display.newSprite(StoreRes .. "fit_circle.png"):pos(14, 15):addTo(bg)
  local num = display.newTTFLabel({
    text = fit.count,
    size = 24,
    color = UIHelper.hex2rgb("#ffd800")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(12, 16):addTo(bg)
  local btnSub = UIHelper.extend(ccui.Button:create())
  btnSub:setImages(StoreRes, {
    "fit_btn_add.png",
    "fit_btn_add.png"
  })
  btnSub:pos(14, 120):addTo(bg)
  btnSub:setTouchScale()
  btnSub:setCallback(function()
    self.chooseList[fit.id] = self.chooseList[fit.id] - 1
    if self.chooseList[fit.id] < 1 then
      self.chooseList[fit.id] = nil
      bg:removeSelf()
      self:checkMax()
    else
      num:setString(self.chooseList[fit.id])
    end
    self:showRecycle()
  end)
  if self.max then
    self:checkMax()
  end
end

function DinerBoxFitmentLayer:showFitDetail(fitId)
  if self.showId == fitId then
    return
  end
  self.showId = fitId
  self.node:removeAllChildren()
  local fitSet = FitCsv[fitId]
  FitIcon.new({id = fitId}):scale(0.85):pos(55, 0):addTo(self.node)
  local texts = {
    "类别:",
    "主题:",
    "占格:",
    "满足度:"
  }
  local yPos = 30
  for index, text in ipairs(texts) do
    display.newSprite(StoreRes .. (index == 4 and "tal_block.png" or "fit_block.png")):pos(125, yPos):addTo(self.node)
    display.newTTFLabel({
      text = text,
      size = 16,
      color = UIHelper.hex2rgb(index == 4 and "#de550a" or "#a99e94")
    }):anch(0, 0.5):pos(140, yPos):addTo(self.node)
    yPos = yPos - 20
  end
  display.newTTFLabel({
    text = FitmentDesc[fitSet.type],
    size = 16,
    color = UIHelper.hex2rgb("#a99e94")
  }):anch(0, 0.5):pos(210, 30):addTo(self.node)
  display.newTTFLabel({
    text = BoxCsv[fitSet.box][game.role.boxLevel].name,
    size = 16,
    color = UIHelper.hex2rgb("#a99e94")
  }):anch(0, 0.5):pos(210, 10):addTo(self.node)
  display.newTTFLabel({
    text = fitSet.xw * fitSet.yw,
    size = 16,
    color = UIHelper.hex2rgb("#a99e94")
  }):anch(0, 0.5):pos(210, -10):addTo(self.node)
  display.newTTFLabel({
    text = fitSet.desc,
    size = 16,
    color = UIHelper.hex2rgb("#de550a")
  }):anch(0, 0.5):pos(210, -30):addTo(self.node)
end

function DinerBoxFitmentLayer:showRecycle()
  self.node:removeAllChildren()
  display.newTTFLabel({
    text = "获得\n材料",
    size = 20,
    color = UIHelper.hex2rgb("#a99e94")
  }):pos(44, 0):addTo(self.node)
  local itemId, count = 0, 0
  if not next(self.chooseList) then
    itemId, _ = FitCsv[1].recycle:match("(%d+)=(%d+)")
  else
    for id, num in pairs(self.chooseList) do
      local tempId, tempNum = FitCsv[id].recycle:match("(%d+)=(%d+)")
      itemId = tempId
      count = count + tonumber(tempNum) * num
    end
  end
  ItemIcon.new({
    type = tonumber(itemId),
    count = count,
    showTip = true
  }):scale(0.85):pos(115, 0):addTo(self.node)
  display.newTTFLabel({
    text = string.format("已选择种类:%d/%d", table.nums(self.chooseList), self.max),
    size = 18,
    color = UIHelper.hex2rgb("#745419")
  }):anch(0, 0.5):pos(215, 0):addTo(self.node)
  if not next(self.chooseList) then
    return
  end
  local btnCancel = UIHelper.extend(ccui.Button:create())
  btnCancel:setImages(MainRes, {
    "btn_common.png",
    "btn_common.png"
  })
  btnCancel:pos(615, 2):addTo(self.node)
  btnCancel:setTouchScale()
  btnCancel:setCallback(function()
    self:setFilter()
  end)
  display.newTTFLabel({text = "取消", size = 18}):enableOutline(UIHelper.hex2rgb("#886213"), 1):pos(59, 23):addTo(btnCancel)
  local btnSend = UIHelper.extend(ccui.Button:create())
  btnSend:setImages(MainRes, {
    "btn_common.png",
    "btn_common.png"
  })
  btnSend:pos(770, 2):addTo(self.node)
  btnSend:setTouchScale()
  btnSend:setCallback(function()
    game:sendData(actionCodes.Diner_recycleFitmentsRpc, MsgPack.pack({
      fitments = self.chooseList
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_recycleFitmentsRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self.FitFilter:setSource(self:getFitSource())
    end)
  end)
  display.newTTFLabel({text = "回收", size = 18}):enableOutline(UIHelper.hex2rgb("#886213"), 1):pos(59, 23):addTo(btnSend)
end

function DinerBoxFitmentLayer:checkMax()
  local isFull = table.nums(self.chooseList) >= self.max
  for _, rowData in pairs(self.unChooseList) do
    for fitId, card in pairs(rowData) do
      if isFull and not self.chooseList[fitId] then
        local mask = card:getChildByName("lock")
        if not mask then
          mask = display.newSprite(ChooseRes .. "mask.png"):center(card):addTo(card):name("lock")
          local bg = display.newSprite(ChooseRes .. "text_bg.png"):pos(56, 78):addTo(mask)
          display.newTTFLabel({
            text = "选择达到上限",
            size = 14
          }):center(bg):addTo(bg)
        end
      else
        local mask = card:getChildByName("lock")
        if mask then
          mask:removeSelf()
        end
      end
    end
  end
end

function DinerBoxFitmentLayer:showFitTypeSelect()
  self.btnFitState = not self.btnFitState
  if self.btnFitState then
    self.maskNode:removeAllChildren()
    self.btnOrder1:setLocalZOrder(1)
    self.btnOrder1:setImage(StoreRes .. "image_up.png")
    return
  end
  self.btnOrder1:setLocalZOrder(100)
  self.btnOrder1:setImage(StoreRes .. "image_down.png")
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(77)
  mask:anch(0.5, 0.5):addTo(self.maskNode)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(mask, true)
  end
  local list = ccui.ListView:create()
  list:size(cc.size(174, 350))
  list:setInnerContainerSize(cc.size(174, 350))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 1):pos(-310, 225):addTo(self.maskNode)
  for _, data in ipairs(self.orderData1) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(174, 40)):addTo(list)
    local btn = UIHelper.newImageView(StoreRes .. "name_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 18,
      color = UIHelper.hex2rgb("#60220d")
    }):pos(83, 18):addTo(btn)
    btn:setCallback(function()
      self:showFitTypeSelect()
      if self.FitType == data.content then
        return
      end
      self.fitName:setString(data.name)
      self.FitType = data.content
      self:setFilter()
    end)
  end
end

function DinerBoxFitmentLayer:showThemeTypeSelect()
  self.btnThemeState = not self.btnThemeState
  if self.btnThemeState then
    self.maskNode:removeAllChildren()
    self.btnOrder2:setLocalZOrder(1)
    self.btnOrder2:setImage(StoreRes .. "image_up.png")
    return
  end
  self.btnOrder2:setLocalZOrder(100)
  self.btnOrder2:setImage(StoreRes .. "image_down.png")
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(77)
  mask:anch(0.5, 0.5):addTo(self.maskNode)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(mask, true)
  end
  local list = ccui.ListView:create()
  list:size(cc.size(174, 350))
  list:setInnerContainerSize(cc.size(174, 350))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 1):pos(-125, 225):addTo(self.maskNode)
  for _, data in ipairs(self.orderData2) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(174, 40)):addTo(list)
    local btn = UIHelper.newImageView(StoreRes .. "name_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 18,
      color = UIHelper.hex2rgb("#60220d")
    }):pos(83, 18):addTo(btn)
    btn:setCallback(function()
      self:showThemeTypeSelect()
      if self.ThemeType == data.content then
        return
      end
      self.themeName:setString(data.name)
      self.ThemeType = data.content
      self:setFilter()
    end)
  end
end

function DinerBoxFitmentLayer:changeMode()
  self.btnModeState = not self.btnModeState
  self:initSortRule()
  if self.btnModeState then
    self.modeName:setString("回收")
    return
  end
  self.modeName:setString("取消")
end

function DinerBoxFitmentLayer:setFilter()
  self.FitFilter:filterByType({
    fit = self.FitType,
    theme = self.ThemeType
  })
end

return DinerBoxFitmentLayer
