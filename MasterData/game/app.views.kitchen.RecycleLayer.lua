local recycleCsv = require("csvdata.recycle")
local ItemCsv = require("csvdata.item")
local globalRes = "ui/global/"
local qulaityRes = "ui/kitchen/quality/"
local uiData = {
  csbFile = "ui/kitchen/RecycleLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    list = "mainBg1/list",
    backBtn = "mainBg1/backBtn",
    ren = "ren",
    mainBg2 = "mainBg2",
    circle = "mainBg2/circle2",
    angel = "angel",
    mainBg = "mainBg",
    items = "mainBg/items",
    angel = "angel"
  }
}
local RecycleLayer = class("RecycleLayer", UIBase)

function RecycleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RecycleLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.mainBg1:setPositionX(self.mainBg1:getPositionX() + UIHelper.getMoveXForX() + 80)
    self.angel:setPositionX(self.angel:getPositionX() + UIHelper.getMoveXForX() + 80)
  end
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
  self.specialHero = globalCsv.recycleHeroSpecial:toNumMap()
  self.eatList = {}
  self:showList()
  self:showPanel()
  self.backBtn:setTouchScale()
  self.backBtn:setCallback(function()
    local heroIds = {}
    local showTip = {}
    for _, id in pairs(self.eatList) do
      local hero = game.role.heros[id]
      if hero then
        heroIds[#heroIds + 1] = id
        if hero.unit.star == 1 then
          showTip[1] = "特殊"
        elseif hero.unit.star >= 4 then
          showTip[4] = "高星级"
        end
        if hero.treePoint ~= "" then
          showTip[2] = "升华"
        end
        if hero.quality >= 3 then
          showTip[3] = "高品质"
        end
      end
    end
    if #heroIds == 0 then
      SysError(SYS_ERR_RECYCLE_NO_HEROS)
      return
    end
    
    local function sendRequest()
      game:sendData(actionCodes.Hero_decomposeRpc, MsgPack.pack({ids = heroIds}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_decomposeRpc, function(event)
        UIHelper.removeWaiting()
        self.eatList = {}
        self:showList()
        self:showPanel()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.items
        })
      end)
    end
    
    if next(showTip) then
      MDialog:double({
        text = string.format("选择回收的食灵中有<div color=#ff0000>%s</div>的食灵,仍要进行回收吗？", table.concat(table.values(showTip), "/"))
      }, function()
        sendRequest()
      end)
      return
    end
    sendRequest()
  end)
end

function RecycleLayer:showList()
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

function RecycleLayer:showPanel()
  self.items:removeAllChildren()
  local num, special = 4, false
  local values = {
    0,
    0,
    0,
    0
  }
  for _, id in ipairs(self.eatList) do
    local hero = game.role.heros[id]
    if hero then
      local recData = recycleCsv[hero.type]
      values[1] = values[1] + recData.material1
      values[2] = values[2] + recData.material2
      values[3] = values[3] + recData.material3
      values[4] = values[4] + recData.material4
      if hero.unit.star == 3 or hero.unit.star == 4 or self.specialHero[hero.type] or hero.type == 99 or hero.type == 98 then
        num = 5
      end
      if hero.unit.star == 5 and not self.specialHero[hero.type] then
        special = true
      end
    end
  end
  local xPos = (num + (special and 1 or 0) - 1) / 2 * -64
  for i = 1, num do
    local itemBg = UIHelper.newImageView("ui/kitchen/recycle/item_bg.png"):scale(0.67):pos(xPos, 0):addTo(self.items)
    if i < 5 then
      display.newSprite(globalRes .. string.format("%d.png", i)):center(itemBg):addTo(itemBg)
      display.newTTFLabel({
        text = values[i],
        size = 22
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(78, 15):addTo(itemBg)
      itemBg:setCallback(function()
        MTip:show({
          type = MTipType.item,
          node = itemBg,
          itemType = i,
          itemData = ItemCsv[i]
        })
      end)
    else
      display.newSprite("ui/kitchen/recycle/gift.png"):center(itemBg):addTo(itemBg)
      display.newTTFLabel({text = "??", size = 22}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(78, 15):addTo(itemBg)
      itemBg:setCallback(function()
        MTip:show({
          type = MTipType.item,
          node = itemBg,
          itemType = 53,
          itemData = ItemCsv[53]
        })
      end)
    end
    xPos = xPos + 64
  end
  if special then
    local itemBg = UIHelper.newImageView("ui/kitchen/recycle/item_bg.png"):scale(0.67):pos(xPos, 0):addTo(self.items)
    display.newSprite(globalRes .. "9.png"):center(itemBg):addTo(itemBg)
    display.newTTFLabel({text = "??", size = 22}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(78, 15):addTo(itemBg)
    itemBg:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = itemBg,
        itemType = 9,
        itemData = ItemCsv[9]
      })
    end)
  end
end

function RecycleLayer:refreshListWithDelay()
  if self.rowCount > math.ceil(#self.eatList / 5) then
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
  local nodeSize = cc.size(cellSize.width * 4 + 5 * interval, cellSize.height + 12)
  local viewNode = ccui.Widget:create()
  viewNode:size(nodeSize):addTo(self.list)
  for index = row * colCount + 1, colCount * (row + 1) do
    if index <= #self.eatList then
      local col = index - row * colCount
      if self.eatList[index] == 0 then
        local card = UIHelper.newImageView(qulaityRes .. "bg_1.png")
        UIHelper.newImageView(globalRes .. "item_frame.png"):center(card):addTo(card)
        UIHelper.newImageView(globalRes .. "add.png"):pos(46, 53):addTo(card)
        card:anch(0, 0):pos(3 + (cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        local desc = display.newTTFLabel({
          text = "添加食灵",
          size = 14,
          color = UIHelper.hex2rgb("#b3a27e")
        }):pos(45, 25):addTo(card)
        card:setCallback(function()
          self:add()
        end)
      else
        local card = HeroHead.new({
          heroId = self.eatList[index],
          loveEffect = true
        })
        card:anch(0, 0):pos(3 + (cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        card:setCallback(function()
          table.remove(self.eatList, #self.eatList)
          table.remove(self.eatList, index)
          self:showList()
          self:showPanel()
        end)
      end
    end
  end
  self.rowCount = self.rowCount + 1
end

function RecycleLayer:add()
  local function rule(_hero)
    local states = _hero:getState()
    
    for key, value in pairs(states) do
      if value then
        return true
      end
    end
    for index, id in ipairs(self.eatList) do
      if id == _hero.id then
        return true
      end
    end
    if _hero.lock == 1 or _hero.formation > 0 then
      return true
    end
  end
  
  local function newrule(heroId)
    local hero = game.role.heros[heroId]
    local state = hero:getState()
    if state[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_RECYCLE)
      return true
    end
    if state[2] then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_RECYCLE)
      return true
    end
    if state[3] then
      SysError(SYS_ERR_HERO_LOCKED_CONSIGNATION_RECYCLE)
      return true
    end
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    multiChoose = true,
    quickChose = true,
    rule = rule,
    type = 5,
    max = 50,
    callback = function(chooseList)
      table.remove(self.eatList, #self.eatList)
      for id, _ in pairs(chooseList) do
        table.insert(self.eatList, id)
      end
      self:showList()
      self:showPanel()
    end,
    newRule = newrule
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "厨房")
  end)
end

function RecycleLayer:showData(params)
end

function RecycleLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return RecycleLayer
