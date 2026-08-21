local taskCsv = require("csvdata.activity_101_task")
local drawCsv = require("csvdata.activity_101_drawgift")
local itemCsv = require("csvdata.item")
local shopCsv = require("res.csvdata.shop")
local JiejiMainRes = "ui/jieji/main2/"
local uiData = {
  csbFile = "ui/jieji/JiejiMainLayer2.csb",
  widgets = {
    content = "content",
    bg = "content/bg",
    mainTitle = "content/mainTitle",
    itemBg = "content/itemBg",
    bigHeroNode = "content/bigHeroNode",
    jiejiHandle = "content/jiejiHandle",
    jiejiBg = "content/jiejiBg",
    jiejiTime = "content/jiejiTime",
    taskList = "content/taskList",
    taskMask = "content/taskMask",
    draw10 = "content/draw10",
    draw1 = "content/draw1",
    infoBtn = "content/infoBtn",
    backBtn = "content/backBtn"
  }
}
local activityType = "101"
local JiejiMainLayer = class("JiejiMainLayer", UIBase)

function JiejiMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JiejiMainLayer:init(params)
  TopBar:show(TopBarType.hide)
  self.taskMask:hide()
  self.jiejiTime:hide()
  self.backBtn:setTouchScale()
  self.backBtn:setCallback(function()
    BackManager:pop()
  end)
  self.selectList = {}
  self.select2List = {}
  self.labelList = {}
  self.isDrawing = false
  local costId = globalCsv.Activity101CostItem
  self.countLabel = display.newTTFLabel({
    text = game.role.activityStatus[activityType].coin or 0,
    size = 24,
    align = ui.TEXT_ALIGN_CENTER
  }):pos(100, 23):addTo(self.itemBg)
  self.itemBg:setCallback(function()
    MTip:show({
      type = MTipType.item,
      node = self.itemBg,
      itemType = costId,
      itemData = itemCsv[costId]
    })
  end)
  local add = UIHelper.newImageView(JiejiMainRes .. "add.png"):pos(170, 23):addTo(self.itemBg)
  add:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
    BackManager:push(function()
      self.countLabel:setString(game.role.activityStatus[activityType].coin or 0)
      TopBar:show(TopBarType.hide)
      layer:close()
    end)
  end)
  self.infoBtn:setTouchScale()
  self.infoBtn:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_101"
    })
  end)
  local startPosx = -388
  local offsetX = 112
  local drawData = self:getDrawData()
  local rewards = drawData.rewards:toArray()
  table.sort(rewards, function(a, b)
    local dataA = a:toArray("=", true)
    local dataB = b:toArray("=", true)
    return dataA[3] < dataB[3]
  end)
  for i, data in ipairs(rewards) do
    self:createdarwCell(data:toArray("=", true), {
      startPosx + offsetX * (i - 1),
      0
    }, i)
  end
  self:showTaskList()
  self.draw1:setTouchScale()
  self.draw1:setCallback(function()
    if self.isDrawing then
      return
    end
    self.isDrawing = true
    self:drawItemMsg(1)
  end)
  self.draw10:setTouchScale()
  self.draw10:setCallback(function()
    if self.isDrawing then
      return
    end
    self.isDrawing = true
    self:drawItemMsg(10)
  end)
end

function JiejiMainLayer:showTaskList()
  self.taskList:removeAllChildren()
  self.taskList:setDirection(2)
  local unGotList = {}
  local GotList = {}
  local record = game.role.activityStatus[activityType].record or ""
  for i, data in ipairs(taskCsv) do
    if 0 < record:getv(data.id, 0) then
      table.insert(GotList, data)
    else
      table.insert(unGotList, data)
    end
  end
  for i, data in ipairs(unGotList) do
    self:createTaskCell(data):addTo(self.taskList)
  end
  for i, data in ipairs(GotList) do
    self:createTaskCell(data):addTo(self.taskList)
  end
  self.taskList:doLayout()
end

function JiejiMainLayer:createTaskCell(data)
  local set = data.gift:toArray("=", true)
  local itemData = itemCsv[set[1]]
  local count = game.role.activityStatus[activityType].count or 0
  count = math.min(data.condition, count)
  local record = game.role.activityStatus[activityType].record or ""
  local viewNode = ccui.Widget:create():setContentSize(cc.size(110, 110))
  local bgStr = 0 < record:getv(data.id, 0) and "task_item_3.png" or count >= data.condition and "task_item_2.png" or "task_item_1.png"
  local bg = UIHelper.newImageView(JiejiMainRes .. bgStr):center(viewNode):addTo(viewNode)
  local icon = display.newSprite(itemData.icon):scale(0.7):pos(60, 50):addTo(bg)
  if 0 < record:getv(data.id, 0) then
    display.newSprite(JiejiMainRes .. "got.png"):scale(1.4285714285714286):center(icon):addTo(icon)
    bg:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = set[1],
        itemData = itemCsv[set[1]]
      })
    end)
  else
    bg:setCallback(function()
      if count >= data.condition then
        self:getRewardMsg(data.id)
      else
        MTip:show({
          type = MTipType.item,
          node = icon,
          itemType = set[1],
          itemData = itemCsv[set[1]]
        })
      end
    end)
  end
  local text = string.format("投币%d/%d", count, data.condition)
  display.newTTFLabel({
    text = text,
    size = 16,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(4, 98):addTo(viewNode)
  local str1 = string.format("<div shadow=0,-2,0.5,#AC8C77 outline=1,#E3E3E3 >%s</div>", set[2])
  local str2 = string.format("<div shadow=0,-2,0.5,#AC8C77 outline=1,#E3E3E3 >%s</div>", set[2])
  MRichText.new({
    text = count >= data.condition and str2 or str1,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(58, 15):addTo(viewNode)
  return viewNode
end

function JiejiMainLayer:showSelect(index)
  for _, data in pairs(self.selectList) do
    if data.index == (index - 1) % 8 + 1 and index ~= -1 then
      data.selectNode:show()
    else
      data.selectNode:hide()
    end
  end
  for _, data in pairs(self.select2List) do
    if data.index == (index - 1) % 8 + 1 and index ~= -1 then
      data.selectNode:show()
    else
      data.selectNode:hide()
    end
  end
  for _, data in pairs(self.labelList) do
    if data.index == (index - 1) % 8 + 1 and index ~= -1 then
      data.labelNode:setString(data.label2)
    else
      data.labelNode:setString(data.label1)
    end
  end
end

function JiejiMainLayer:createdarwCell(data, pos, index)
  local itemData = itemCsv[data[1]]
  local bg = UIHelper.newImageView(JiejiMainRes .. "jieji_item_bg.png"):pos(pos[1], pos[2]):addTo(self.jiejiBg)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.item,
      node = bg,
      itemType = data[1],
      itemData = itemCsv[data[1]]
    })
  end)
  local select = display.newSprite(JiejiMainRes .. "jieji_item_select.png"):pos(61.5, 63):addTo(bg)
  select:hide()
  table.insert(self.selectList, {index = index, selectNode = select})
  display.newSprite(itemData.icon):pos(62, 70):addTo(bg)
  local bg2 = UIHelper.newImageView(JiejiMainRes .. "jieji_item_bg_2.png"):center(bg):addTo(bg)
  local select2 = display.newSprite(JiejiMainRes .. "jieji_item_select_2.png"):center(bg):addTo(bg)
  select2:hide()
  table.insert(self.select2List, {index = index, selectNode = select2})
  local str1 = string.format("<div shadow=0,-2,0.5,#3A664D outline=1,#386152 >%s</div>", itemData.name)
  local str2 = string.format("<div shadow=0,-2,0.5,#721F1D outline=1,#A91515 >%s</div>", itemData.name)
  local label = MRichText.new({
    text = str1,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):rotate(-1):anch(0.5, 0.5):pos(62, 26):addTo(bg)
  table.insert(self.labelList, {
    index = index,
    labelNode = label,
    label1 = str1,
    label2 = str2
  })
end

function JiejiMainLayer:getDrawData()
  local count = game.role.activityStatus[activityType].count or 0
  for i, data in ipairs(drawCsv) do
    if count <= data.limit then
      return data
    end
  end
  return drawCsv[#drawCsv]
end

function JiejiMainLayer:getRewardMsg(_index)
  local record = game.role.activityStatus[activityType].record or ""
  if 0 < record:getv(_index, 0) then
    return
  end
  game:sendData(actionCodes.Activity_act96GetRewardRpc, MsgPack.pack({
    index = _index,
    actId = tonumber(activityType)
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act96GetRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    self:showTaskList()
  end)
end

function JiejiMainLayer:drawItemMsg(_count)
  local hasCoin = game.role.activityStatus[activityType].coin or 0
  if _count > hasCoin then
    self.isDrawing = false
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
    BackManager:push(function()
      self.countLabel:setString(game.role.activityStatus[activityType].coin or 0)
      TopBar:show(TopBarType.hide)
      layer:close()
    end)
    return
  end
  game:sendData(actionCodes.Activity_act96DrawRpc, MsgPack.pack({
    count = _count,
    actId = tonumber(activityType)
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act96DrawRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local count = math.randomInt(3, 8) * 8 + msg.best
    print("次数：", count)
    local posList = self:getRunPosData(count)
    self:handleAction(function()
      self:selectNodeRunAction(posList, 1, function()
        game:createView("jieji.JiejiRewardDialog2", {
          rewards = msg.reward,
          callBack = function()
            self.countLabel:setString(game.role.activityStatus[activityType].coin or 0)
            self:showSelect(-1)
            self:showTaskList()
          end
        })
        self.isDrawing = false
      end)
    end)
  end)
end

function JiejiMainLayer:handleAction(callBack)
  game:playMusic(1033)
  self.jiejiHandle:runAction(transition.sequence({
    cc.RotateBy:create(0.3, 50),
    cc.RotateBy:create(0.3, -50),
    cc.DelayTime:create(0.2),
    cc.CallFunc:create(function()
      callBack()
    end)
  }))
end

function JiejiMainLayer:selectNodeRunAction(posList, index, callBack)
  if index > #posList then
    if callBack then
      callBack()
    end
    return
  end
  self:showSelect(index)
  local delayTime = #posList - index < 10 and 10 - (#posList - index) or 0
  game:playMusic(1032)
  scheduler.performWithDelayGlobal(function()
    index = index + 1
    self:selectNodeRunAction(posList, index, callBack)
  end, 0.03 + delayTime * 0.04)
end

function JiejiMainLayer:getRunPosData(count)
  local x = 90
  local offsetX = 105
  local startPosX = 90
  local endPosX = 825
  local posXlist = {}
  local index = 1
  local lastPosX = x - offsetX
  while count > #posXlist do
    local posX = lastPosX + offsetX
    if endPosX < posX then
      posX = startPosX
    end
    lastPosX = posX
    table.insert(posXlist, {index = index, posx = posX})
    index = index + 1
  end
  table.sort(posXlist, function(a, b)
    return a.index < b.index
  end)
  return posXlist
end

return JiejiMainLayer
