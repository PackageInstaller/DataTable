local SauceCsv = require("csvdata.sauce")
local uiData = {
  csbFile = "ui/equip/EquipRecycleLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    list = "mainBg1/list",
    backBtn = "mainBg1/backBtn",
    titleBg = "mainBg1/titleBg",
    ren = "ren",
    mainBg2 = "mainBg2",
    circle = "mainBg2/circle2",
    angel = "angel",
    mainBg = "mainBg",
    items = "mainBg/items",
    angel = "angel"
  }
}
local SauceRecycleLayer = class("SauceRecycleLayer", UIBase)

function SauceRecycleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceRecycleLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.mainBg1:setPositionX(self.mainBg1:getPositionX() + UIHelper.getMoveXForX() + 80)
    self.angel:setPositionX(self.angel:getPositionX() + UIHelper.getMoveXForX() + 80)
  end
  self.titleBg:hide()
  UIHelper.MoveToLeft({
    node = self.mainBg1
  })
  UIHelper.MoveToUp({
    node = self.mainBg
  })
  UIHelper.MoveToRight({
    node = self.mainBg2,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.ren,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel,
    time = 0.3
  })
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.eatList = {}
  self:showList()
  self.backBtn:setTouchScale()
  self.backBtn:setCallback(function()
    if self.eatList[#self.eatList] == 0 then
      table.remove(self.eatList, #self.eatList)
    end
    if not next(self.eatList) then
      SysError(SYS_ERR_SAUCE_CHOOSE_FIRST)
      return
    end
    local bQuality = false
    for _, sauceId in pairs(self.eatList) do
      local sauce = game.role.sauces[sauceId]
      if sauce.csvData.rare >= 4 then
        bQuality = true
        break
      end
    end
    local bxxq = false
    for _, sauceId in pairs(self.eatList) do
      local sauce = game.role.sauces[sauceId]
      if sauce and (sauce.csvData.type == "" or sauce.csvData.type == "9999") then
        bxxq = true
        break
      end
    end
    
    local function send()
      game:sendData(actionCodes.Sauce_decomposeRpc, MsgPack.pack({
        sauceIds = self.eatList
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_decomposeRpc, function(event)
        UIHelper.removeWaiting()
        self.eatList = {}
        self:showList()
        self:showBackNum()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward
        })
      end)
    end
    
    if bQuality then
      MDialog:double({
        text = string.format("当前选中的酱料中包含高品质酱料%s，确定要继续分解吗？", bxxq and "和<div color=#ff0000>香香球</div>" or "")
      }, function()
        send()
      end)
    else
      send()
    end
  end)
  self:showBackNum()
end

function SauceRecycleLayer:showList()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.rowCount = 0
  self.list:removeAllChildren()
  table.insert(self.eatList, 0)
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:refreshListWithDelay()
  end, 0.016666666666666666)
end

function SauceRecycleLayer:refreshListWithDelay()
  if self.rowCount > math.ceil(table.nums(self.eatList) / 5) then
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
      self.refreshHandler = nil
    end
    self.list:requestDoLayout()
    return
  end
  local row, colCount = self.rowCount, 5
  local interval = 3
  local cellSize = display.newSprite("ui/global/item_bg.png"):getContentSize()
  local nodeSize = cc.size(cellSize.width * 5 + 4 * interval, cellSize.height + 12)
  local viewNode = ccui.Widget:create()
  viewNode:size(nodeSize):addTo(self.list)
  for index = row * colCount + 1, colCount * (row + 1) do
    if index <= table.nums(self.eatList) then
      local col = index - row * colCount
      if self.eatList[index] == 0 then
        local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png")
        UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
        UIHelper.newImageView("ui/global/add.png"):pos(46, 53):addTo(card)
        card:anch(0, 0):pos((cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        local desc = display.newTTFLabel({
          text = "添加酱料",
          size = 14,
          color = UIHelper.hex2rgb("#b3a27e")
        }):pos(45, 25):addTo(card)
        card:setCallback(function()
          self:add()
        end)
      else
        local card = SauceIcon.new({
          id = self.eatList[index]
        })
        card:anch(0, 0):pos((cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        card:setCallback(function()
          table.remove(self.eatList, table.nums(self.eatList))
          table.remove(self.eatList, index)
          self:showList()
          self:showBackNum()
        end)
      end
    end
  end
  self.rowCount = self.rowCount + 1
end

function SauceRecycleLayer:add()
  local function rule(sauce)
    local msaterId = sauce.masterId
    
    if msaterId and 0 < msaterId and game.role.heros[msaterId] then
      return true
    end
    if sauce.lock == 1 then
      return true
    end
    return false
  end
  
  local layer = game:createView("sauce.ChooseSauceLayer", {
    multiChoose = true,
    rule = rule,
    type = 6,
    quickChose = true,
    max = 50,
    choosedList = self.eatList,
    callback = function(chooseList)
      self.eatList = {}
      for id, _ in pairs(chooseList) do
        self.eatList[#self.eatList + 1] = id
      end
      self:showList()
      self:showBackNum()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "厨房")
  end)
end

function SauceRecycleLayer:showBackNum()
  self.items:removeAllChildren()
  local nums = {
    [193] = 0
  }
  for _, id in pairs(self.eatList) do
    local sauce = game.role.sauces[id]
    if sauce then
      for Type, count in pairs(sauce.csvData.recycle:toNumMap()) do
        nums[Type] = (nums[Type] or 0) + count
      end
    end
  end
  local xPos = -(table.nums(nums) - 1) / 2 * 80
  for Type, count in pairs(nums) do
    local icon = ItemIcon.new({type = Type, showTip = true}):scale(0.8):pos(xPos, 0):addTo(self.items)
    display.newTTFLabel({text = count, size = 20}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(83, 15):addTo(icon)
    xPos = xPos + 80
  end
end

function SauceRecycleLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return SauceRecycleLayer
