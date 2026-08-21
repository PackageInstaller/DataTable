local ItemCsv = require("csvdata.item")
local TaskCsv = require("csvdata.activity_85_task")
local RewardCsv = require("csvdata.activity_85_reward")
local SupportCsv = require("csvdata.activity_85_support")
local LtyRes = "ui/lty/main/"
local TopDinerRes = "ui/topDiner/"
local uiData = {
  csbFile = "ui/topDiner/TopDinerMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    up = "up",
    numBg1 = "numBg1",
    num1 = "numBg1/num1",
    btn1 = "leftBtnBg/btn1",
    btn2 = "leftBtnBg/btn2",
    mainFrame1 = "mainFrame1",
    list = "mainFrame1/taskBg/list",
    btnInfo1 = "mainFrame1/btnInfo1",
    mainFrame2 = "mainFrame2",
    submitNum = "mainFrame2/iconBg/num",
    submitText = "mainFrame2/submitText",
    submitBtn = "mainFrame2/submit",
    getMore = "mainFrame2/getMore",
    point0 = "mainFrame2/point0",
    point1 = "mainFrame2/point1",
    point2 = "mainFrame2/point2",
    point3 = "mainFrame2/point3",
    point4 = "mainFrame2/point4",
    point5 = "mainFrame2/point5",
    point6 = "mainFrame2/point6",
    point7 = "mainFrame2/point7",
    point8 = "mainFrame2/point8",
    heroNode = "mainFrame2/heroNode",
    btnInfo2 = "mainFrame2/btnInfo2"
  }
}
local btnData = {
  [1] = {
    name = "每日备餐室",
    red = "task"
  },
  [2] = {
    name = "主厨之路",
    red = "road"
  }
}
local TopDinerMainLayer = class("TopDinerMainLayer", UIBase)

function TopDinerMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TopDinerMainLayer:init(params)
  TopBar:show(TopBarType.full, "顶级盛宴")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  UIHelper.MoveToDown({
    node = self.up
  })
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  self.selected = 1
  self:showData1()
  self:updateIconNum()
  self.btns = {}
  self.handlers = {}
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      local text1 = sender:getChildByName("1")
      text1:setTextColor(UIHelper.hex2rgb("#401708"))
    end,
    unchooseCb = function(sender)
      local text1 = sender:getChildByName("1")
      text1:setTextColor(UIHelper.hex2rgb("#f5d281"))
    end
  })
  for index, data in ipairs(btnData) do
    local btn = self["btn" .. index]
    display.newTTFLabel({
      text = data.name,
      size = 23
    }):pos(85, 30):addTo(btn):name("1")
    btn:name("btn" .. index)
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.selected = index
      if index == 1 then
        self:showData1()
      else
        self:showData2()
      end
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.topDiner[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(-12, 15), 0.8)
    end
  end
  self.group:chooseByName("btn" .. self.selected)
  self.numBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.numBg1,
      itemType = globalCsv.topDinerItemId,
      itemData = ItemCsv[globalCsv.topDinerItemId]
    })
  end)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "topDiner" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.topDiner[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(-12, 15), 0.8)
      end
    end
  end))
end

function TopDinerMainLayer:showData1()
  self.list:removeAllChildren()
  self.mainFrame1:show()
  self.mainFrame2:hide()
  local sortData = {}
  local taskStatusOld = game.role.activityStatus["85"].taskStatus:toNumMap()
  local taskStatus = {}
  local curDay = 0
  for tempId, value in pairs(taskStatusOld) do
    local id = 0
    curDay, id = math.floor(tempId / 1000), tempId % 1000
    taskStatus[id] = value
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[curDay][id]
    if data and data.pre ~= 0 then
      if taskStatus[data.pre] == -1 then
        taskStatus[data.pre] = nil
      else
        taskStatus[id] = nil
      end
    end
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[curDay][id]
    local temp = clone(data)
    temp.value = value
    temp.status = value == -1 and -1 or value >= data.condition1 and 1 or 0
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.order - 100 * a.status < b.order - 100 * b.status
  end)
  local cellSize = cc.size(482, 82)
  for index = 1, #sortData do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(self.list)
    local data = sortData[index]
    if not data then
      break
    end
    local cell = UIHelper.newImageView(TopDinerRes .. "td_taskitem_bg.png"):pos(241, 41):addTo(viewNode)
    display.newSprite(TopDinerRes .. "td_icon_bg.png"):pos(42, 39):addTo(cell)
    display.newSprite(TopDinerRes .. "td_pt1.png"):pos(42, 39):scale(0.6, 0.6):addTo(cell)
    display.newTTFLabel({
      text = data.desc,
      size = 22,
      color = UIHelper.hex2rgb("#7b3a09")
    }):anch(0, 0.5):pos(90, 55):addTo(cell)
    local gift = data.gift:toTableArray()
    for _, temp in ipairs(gift) do
      display.newTTFLabel({
        text = "x" .. temp[2],
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):anch(0, 0.5):pos(45, 20):addTo(cell)
    end
    local done = data.value == -1
    if done then
      display.newSprite(TopDinerRes .. "td_finish.png"):pos(410, 39):addTo(cell)
    else
      if data.type == 107 then
        data.value = 1
        data.condition1 = 1
      end
      local numbg = display.newSprite(TopDinerRes .. "td_task_number_bg.png"):pos(125, 25):addTo(cell)
      display.newTTFLabel({
        text = string.format("%d/%d", data.value, data.condition1),
        size = 16
      }):center(numbg):addTo(numbg)
      local btn = UIHelper.extend(ccui.Button:create()):pos(410, 39):addTo(cell)
      if data.value < data.condition1 then
        btn:setImages(TopDinerRes, {"td_go.png", "td_go.png"})
        cell:setCallback(function()
          self:showForward(data)
        end)
        btn:setCallback(function()
          self:showForward(data)
        end)
        display.newTTFLabel({text = "前往", size = 20}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(54, 17):addTo(btn)
      else
        display.newTTFLabel({text = "领取", size = 20}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(54, 17):addTo(btn)
        btn:setImages(TopDinerRes, {"td_get.png", "td_get.png"})
        btn:setCallback(function()
          game:sendData(actionCodes.Activity_TopDinerRewardRpc, MsgPack.pack({
            id = data.time * 1000 + data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_TopDinerRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            btn:removeSelf()
            display.newSprite(TopDinerRes .. "td_finish.png"):pos(410, 39):addTo(cell)
            MedalRewardLayer.new({
              items = msg.reward
            })
            self:showData1()
            self:updateIconNum()
          end)
        end)
      end
    end
  end
  self.list:requestDoLayout()
  self.btnInfo1:setTouchScale()
  self.btnInfo1:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_85"
    })
  end)
end

function TopDinerMainLayer:showData2()
  self.mainFrame2:show()
  self.mainFrame1:hide()
  self.getMore:hide()
  self.point0:removeAllChildren()
  local curStatus = game.role.activityStatus["85"]
  local curPoint = curStatus.curPoint
  local curSubmitCount = curStatus.curSubmitCount
  display.newSprite(TopDinerRes .. "td_road_start.png"):pos(0, 15):addTo(self.point0)
  self:createMapReward(curPoint)
  if curPoint + 1 > #RewardCsv then
    self:createFinishReward()
  end
  self.heroNode:removeAllChildren()
  local smallHero = UIHelper.createSpineNodeByRes(globalCsv.topDinerSmallHero)
  smallHero:setAnimation(0, "idle", true)
  smallHero:pos(0, 0):scale(0.6, 0.6):addTo(self.heroNode):name("smallHero")
  self.heroNode:setPosition(self["point" .. curPoint]:getPosition())
  self.submitNum:setString(string.format("已提交x%s", curSubmitCount))
  self.submitText:setString(string.format("提交%s个厨师帽可获得下一份奖励", RewardCsv[curPoint + 1 > #RewardCsv and curPoint or curPoint + 1].condition))
  self.submitText:setTextColor(UIHelper.hex2rgb("#c14a15"))
  self.submitBtn:setTouchScale()
  self.submitBtn:setCallback(function()
    if self.submitRun then
      return
    end
    self.submitRun = true
    local curCount = game.role.items[globalCsv.topDinerItemId]
    local needCount = RewardCsv[curPoint + 1 > #RewardCsv and curPoint or curPoint + 1].condition
    if curCount < needCount then
      SysError(SYS_ERR_ACTIVITY85_ITEM_SHORTAGE)
      self.submitRun = false
      return
    end
    game:sendData(actionCodes.Activity_TopDinerSubmitRpc, MsgPack.pack({curPoint = curPoint, submitCount = needCount}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_TopDinerSubmitRpc, function(event)
      UIHelper.removeWaiting()
      smallHero:setAnimation(0, "move", true)
      local msg = MsgPack.unpack(event.data)
      if msg.curPoint > curPoint then
        self:changeHeroZOrder(2)
        local toPos = cc.p(self["point" .. curPoint + 1]:getPositionX(), self["point" .. curPoint + 1]:getPositionY())
        self.heroNode:runAction(transition.sequence({
          cc.MoveTo:create(2, toPos),
          cc.CallFunc:create(function()
            smallHero:setAnimation(0, "idle", true)
            self:changeHeroZOrder(4)
            self:showData2()
            self:updateIconNum()
            MedalRewardLayer.new({
              items = msg.reward,
              callback = function()
                self.submitRun = false
              end
            })
          end)
        }))
      else
        MedalRewardLayer.new({
          items = msg.reward
        })
        self:showData2()
        self:updateIconNum()
        self.submitRun = false
      end
    end)
  end)
  self.getMore:setTouchScale()
  self.getMore:setCallback(function()
    self.selected = 1
    self:showData1()
    self.group:chooseByName("btn" .. self.selected)
  end)
  self.btnInfo2:setTouchScale()
  self.btnInfo2:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_85"
    })
  end)
end

function TopDinerMainLayer:createFinishReward()
  local tabData = RewardCsv[#RewardCsv]
  local btn = UIHelper.extend(ccui.Button:create()):anch(0.5, 1):pos(0, -15):addTo(self.point8)
  btn:setImages(TopDinerRes, {
    "td_road_reward_bg2.png",
    "td_road_reward_bg2.png"
  })
  local icon = display.newSprite(tabData.icon):pos(33.5, 30):scale(0.6, 0.6):addTo(btn)
  btn:setCallback(function()
    ItemRewardLayer.new({
      items = tabData.gift:toTableArray(),
      preView = true
    })
  end)
end

function TopDinerMainLayer:createMapReward(curPoint)
  for index = 1, 8 do
    self["point" .. index]:removeAllChildren()
  end
  for index, tabData in ipairs(RewardCsv) do
    local point = self["point" .. index]
    if curPoint > index - 1 then
      display.newSprite(TopDinerRes .. "td_road_got.png"):pos(0, 0):addTo(point)
    elseif curPoint <= index - 1 then
      display.newSprite(TopDinerRes .. "td_road_point.png"):pos(0, 0):addTo(point)
      local btn = UIHelper.extend(ccui.Button:create()):anch(0.5, 0):pos(0, 10):addTo(point)
      btn:setImages(TopDinerRes, {
        "td_road_reward_bg.png",
        "td_road_reward_bg.png"
      })
      local icon = display.newSprite(tabData.icon):pos(33.5, 45):scale(0.6, 0.6):addTo(btn)
      btn:setCallback(function()
        ItemRewardLayer.new({
          items = RewardCsv[index].gift:toTableArray(),
          preView = true
        })
      end)
    end
  end
end

function TopDinerMainLayer:showForward(data)
  local jumpType = data.type
  local cond = 0
  if data.type == 101 or data.type == 105 then
    self.selected = 1
    self:showData1()
    self.group:chooseByName("btn" .. self.selected)
    return
  end
  if data.type == 102 then
    jumpType = 5
  elseif data.type == 103 then
    jumpType = 0
    cond = 71
  elseif data.type == 109 then
    jumpType = 40
  elseif data.type == 104 then
    jumpType = 21
  elseif data.type == 108 then
    jumpType = 0
    cond = 10
  elseif data.type == 106 then
    jumpType = 40
  elseif data.type == 110 then
    jumpType = 0
    cond = 56
  end
  CommonHelper.jumpLayer(jumpType, function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "顶级盛宴")
    self:show()
    self:showData1()
    game:playMusic(3)
  end, cond)
end

function TopDinerMainLayer:changeHeroZOrder(zIndex)
  for i = 1, 9 do
    if i % 2 == 0 then
      self["point" .. i - 1]:setLocalZOrder(1)
    else
      self["point" .. i - 1]:setLocalZOrder(3)
    end
  end
  self.heroNode:setLocalZOrder(zIndex)
end

function TopDinerMainLayer:updateIconNum()
  self.num1:setString(game.role.items[globalCsv.topDinerItemId] or 0)
end

function TopDinerMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return TopDinerMainLayer
