local MissionCsv = require("csvdata.once_activity.lucky")
local ItemCsv = require("csvdata.item")
local ActivityRes = "ui/mission/activity/"
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  widgets = {touch = "touch"}
}
local ActivityMissionLayer = class("ActivityMissionLayer", UIBase)

function ActivityMissionLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ActivityMissionLayer:init(params)
  self.mainBg = UIHelper.newImageView(ActivityRes .. "main_bg.png"):pos(display.cx, 320):addTo(self.touch)
  self.node = display.newNode():pos(0, 0):addTo(self)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.mainBg, true)
  end
  self.up = display.newSprite("ui/hero/up_bar.png"):anch(0.5, 1):pos(display.cx, 640):addTo(self.touch)
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  TopBar:show(TopBarType.full, "成为吉祥物")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
end

function ActivityMissionLayer:showData(params)
  self.node:removeAllChildren()
  self.mainBg:setImage(ActivityRes .. "main_bg.png")
  local image = UIHelper.extend(ccui.ImageView:create())
  image:setImage("card/normal/jhj_sdxl_bb.png")
  image:scale(0.8):pos(200, 260):addTo(self.node)
  image:setOpacity(0)
  image:runAction(cc.FadeIn:create(0.5))
  display.newSprite(ActivityRes .. "image.png"):pos(220, 110):addTo(self.node)
  local done = true
  local xPos = 550
  for idx = 1, 3 do
    local card = self:createCard(idx):pos(xPos, 310):addTo(self.node)
    local bShow = checkbool(game.role.redPoints.lucky[idx])
    UIHelper.showRedPoint(card, bShow, cc.p(12, 5), 0.8)
    local cur, all = self:getProgress(idx)
    if cur < all then
      done = false
    end
    xPos = xPos + 230
  end
  local btnGot = UIHelper.newImageView(ActivityRes .. "btn_got.png"):pos(385, 45):addTo(self.node)
  if done and self:getCount(0) ~= -1 then
    btnGot:setCallback(function()
      game:sendData(actionCodes.Activity_activityLuckyRpc, MsgPack.pack({period = 0, id = 0}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_activityLuckyRpc, function(event)
        UIHelper.removeWaiting()
        btnGot:removeFromParent()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward
        })
      end)
    end)
  else
    UIHelper.setImageViewGray(btnGot)
  end
end

function ActivityMissionLayer:createCard(idx)
  local card = UIHelper.newImageView(ActivityRes .. string.format("card_%d.png", idx))
  card:setCallback(function()
    self:showMissionList(idx)
    BackManager:push(function()
      self:showData()
    end)
  end)
  local cur, all = self:getProgress(idx - 1)
  local desc = "未解锁"
  if all <= cur then
    cur, all = self:getProgress(idx)
    desc = cur >= all and "全部完成" or string.format("%d/%d 已完成", cur, all)
  else
    card:setTouchEnabled(false)
  end
  display.newTTFLabel({text = desc, size = 20}):pos(104, 60):addTo(card)
  card:hide()
  card:runAction(transition.sequence({
    cc.DelayTime:create((idx - 1) * 0.2),
    cc.CallFunc:create(function()
      card:show()
    end),
    cc.OrbitCamera:create(0.3, 1, 0, 0, 360, 0, 0)
  }))
  return card
end

function ActivityMissionLayer:getProgress(idx)
  local csv = MissionCsv[idx] or {}
  local cur = 0
  for _, data in pairs(csv) do
    if self:getCount(data.period * 100 + data.task) == -1 then
      cur = cur + 1
    end
  end
  return cur, #csv
end

function ActivityMissionLayer:getCount(taskId)
  return (game.role.activityStatus["61"] or ""):getv(taskId, 0)
end

local cellSize = cc.size(140, 280)

function ActivityMissionLayer:showMissionList(idx)
  self.node:removeAllChildren()
  self.mainBg:setImage(ActivityRes .. string.format("main_bg_%d.png", idx))
  local width = math.ceil(self.mainBg:getContentSize().width * self.mainBg:getScaleX())
  local list = ccui.ListView:create()
  list:size(cc.size(width, 280))
  list:setInnerContainerSize(cc.size(width, 280))
  list:setClippingEnabled(true)
  list:anch(0, 0):pos(-self.dalteX, 100):addTo(self.node)
  list:setDirection(2)
  local csv = MissionCsv[idx] or {}
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cellSize):addTo(list)
  display.newSprite(ActivityRes .. "bar_bg.png"):pos(70, 40):addTo(viewNode)
  display.newSprite(ActivityRes .. "bar.png"):pos(70, 40):addTo(viewNode)
  local selectIdx
  for _, data in ipairs(csv) do
    if data.task == #csv then
      break
    end
    local cell, idx = self:createCell(data, data.task == #csv - 1)
    cell:addTo(list)
    if idx then
      selectIdx = idx
    end
  end
  local lastData = csv[#csv]
  local count = self:getCount(lastData.period * 100 + lastData.task)
  local status = count == -1 and 3 or count < lastData.condition1 and 1 or 2
  local gift = lastData.gift:toTableArray()
  local image = ItemIcon.new({
    type = tonumber(gift[1][1]),
    showTip = true
  }):scale(0.9)
  local itemBg = UIHelper.newImageView(ActivityRes .. "item_bg_big.png"):anch(1, 0):pos(1136 + self.dalteX, 385):addTo(self.node)
  image:pos(81, 87):addTo(itemBg)
  if status == 2 then
    local btnDraw = UIHelper.newImageView(ActivityRes .. "btn_draw.png"):pos(210, 40):addTo(itemBg)
    btnDraw:setCallback(function()
      game:sendData(actionCodes.Activity_activityLuckyRpc, MsgPack.pack({
        period = lastData.period,
        id = lastData.task
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_activityLuckyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward
        })
        btnDraw:removeFromParent()
        display.newSprite(ActivityRes .. "image_done.png"):pos(240, 40):addTo(itemBg)
      end)
    end)
  elseif status == 3 then
    display.newSprite(ActivityRes .. "image_done.png"):pos(240, 40):addTo(itemBg)
  end
  list:doLayout()
  if selectIdx then
    list:scrollToItem(selectIdx - 1, cc.p(0, 0.53), cc.p(0, 0))
  end
end

function ActivityMissionLayer:createCell(data, lastOne)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cellSize)
  local idx
  local count = self:getCount(data.period * 100 + data.task)
  local status = count == -1 and 3 or count < data.condition1 and 1 or 2
  if not lastOne then
    local barBg = display.newSprite(ActivityRes .. "bar_bg.png"):pos(70, 40):addTo(viewNode)
    if status == 3 then
      idx = data.task
      display.newSprite(ActivityRes .. "bar.png"):center(barBg):addTo(barBg)
    end
  end
  display.newScale9Sprite(ActivityRes .. "line.png", 0, 0, cc.size(2, 130)):anch(0, 0):pos(0, 40):addTo(viewNode)
  local circle = display.newSprite(ActivityRes .. string.format("circle_%d.png", status)):pos(0, 40):addTo(viewNode)
  local gift = data.gift:toTableArray()
  local item = ItemCsv[tonumber(gift[1][1])]
  local image
  if 1 < #gift then
    image = display.newSprite("ui/carbon/chooseTravel/box_6.png")
  elseif item.type == ItemType.Hero or item.type == ItemType.Sauce then
    image = ItemIcon.new({
      type = item.itemId
    }):scale(0.9)
  else
    image = UIHelper.newImageView(item.icon):scale(0.8)
  end
  local itemBg = UIHelper.newImageView(ActivityRes .. "item_bg.png"):pos(0, 205):addTo(viewNode)
  image:pos(47, 60):addTo(itemBg)
  display.newTTFLabel({
    text = data.desc,
    size = 16
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(47, 9):addTo(itemBg)
  itemBg:setCallback(function()
    if data.task ~= 1 and self:getCount(data.period * 100 + data.task - 1) ~= -1 then
      MFlashMsg:show({
        text = "主厨，先完成前面的任务吧~"
      })
      return
    end
    if status == 3 then
      return
    end
    if status == 2 then
      game:sendData(actionCodes.Activity_activityLuckyRpc, MsgPack.pack({
        period = data.period,
        id = data.task
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_activityLuckyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward
        })
        self:showMissionList(data.period)
      end)
      return
    end
    self:showTask(data)
  end)
  return viewNode, idx
end

function ActivityMissionLayer:showTask(data)
  local mask, taskBg = UIHelper.showOnleImgTip(ActivityRes .. "task_bg.png")
  taskBg:setTouchEnabled(true)
  taskBg:setSwallowTouches(true)
  taskBg:scale(0.4)
  taskBg:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
  local gift = data.gift:toTableArray()
  local xPos = 319 - (#gift - 1) / 2 * 120
  display.newTTFLabel({
    text = data.desc2,
    size = 26,
    color = UIHelper.hex2rgb("#702803")
  }):pos(319, 238):addTo(taskBg)
  for _, item in ipairs(gift) do
    ItemIcon.new({
      type = tonumber(item[1]),
      count = tonumber(item[2]),
      showTip = true
    }):pos(xPos, 140):addTo(taskBg)
    xPos = xPos + 120
  end
  local btnGo = UIHelper.newImageView(ActivityRes .. "btn_go.png"):pos(320, 45):addTo(taskBg)
  btnGo:setCallback(function()
    mask:removeSelf()
    if data.type == 200 then
      return
    end
    self:showForward(data)
  end)
end

function ActivityMissionLayer:showForward(data)
  local types = data.jumpto:toArray("=", true)
  CommonHelper.jumpLayer(types[1], function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "成为吉祥物")
    CommonHelper.playHomeBGM()
    self:showMissionList(data.period)
    self:show()
  end, types[2])
end

function ActivityMissionLayer:onExit()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return ActivityMissionLayer
