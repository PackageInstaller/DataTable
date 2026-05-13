local ChapterCsv = require("csvdata.moon_chapter_battle")
local GiftCsv = require("csvdata.once_activity.newyear")
local TaskCsv = require("csvdata.moon_task")
local DrawCsv = require("csvdata.loop_activity.loop_drawgift")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/newyear/main/"
local SummerRes = "ui/newyear/summer/"
local DrawRes = "ui/diner/draw/"
local uiData = {
  csbFile = "ui/newyear/SummerLayer.csb",
  widgets = {
    touch = "touch",
    up = "up",
    mainBg = "mainBg",
    heroNode = "heroNode",
    barNode = "barNode",
    panel1 = "panel1",
    list = "panel1/list",
    panel2 = "panel2",
    node = "panel2/node",
    btnDraw1 = "panel2/btnDraw1",
    btnDraw2 = "panel2/btnDraw2",
    btnClose = "panel2/btnClose",
    leftBg = "panel2/leftBg",
    leftNum = "panel2/leftBg/leftNum",
    leftTip = "panel2/leftBg/leftTip",
    countBg1 = "countBg1",
    value1 = "countBg1/value",
    countBg2 = "countBg2",
    value2 = "countBg2/value",
    btnAdd = "countBg2/btnAdd",
    btnsNode = "btnsNode",
    btn1 = "btnsNode/btn1",
    btn2 = "btnsNode/btn2",
    btn3 = "btnsNode/btn3",
    btnUse = "btnUse",
    btnRule = "btnRule",
    btnDraw = "btnDraw"
  }
}
local btnData = {
  [1] = {
    name = "夏日作战",
    red = "chapter",
    func = function(self)
      self:showChapter()
    end
  },
  [2] = {
    name = "活动任务",
    red = "task",
    func = function(self)
      self:showTask()
    end
  },
  [3] = {
    name = "沙滩拾贝",
    red = "",
    func = function(self)
      self:showArea()
    end
  }
}
local SummerLayer = class("SummerLayer", UIBase)

function SummerLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SummerLayer:init(params)
  TopBar:show(TopBarType.full, "夏日作战")
  TopBar:showAnimation(true)
  game:playMusic(31)
  self.touch:setSwallowTouches(true)
  local names = {
    "btnDraw1",
    "btnDraw2",
    "btnClose",
    "btnRule",
    "btnDraw",
    "btnAdd"
  }
  for _, name in pairs(names) do
    self[name]:setTouchScale()
  end
  local id, count = globalCsv.ActivityDrawCost_1:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(36, 34):addTo(self.btnDraw1)
  id, count = globalCsv.ActivityDrawCost_10:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(36, 34):addTo(self.btnDraw2)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch, true)
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() - UIHelper.getMoveXForX())
    self.panel1:setPositionX(self.panel1:getPositionX() + UIHelper.getMoveXForX())
    self.panel2:setPositionX(self.panel2:getPositionX() + UIHelper.getMoveXForX())
    self.btnUse:setPositionX(self.btnUse:getPositionX() + UIHelper.getMoveXForX())
    self.btnDraw:setPositionX(self.btnDraw:getPositionX() + UIHelper.getMoveXForX())
    self.btnRule:setPositionX(self.btnRule:getPositionX() + UIHelper.getMoveXForX())
    self.countBg1:setPositionX(self.countBg1:getPositionX() + UIHelper.getMoveXForX())
    self.countBg2:setPositionX(self.countBg2:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToDown({
    node = self.btnsNode,
    time = 0.5,
    pos = {0, 200}
  })
  UIHelper.MoveToLeft({
    node = self.panel1,
    time = 0.6,
    pos = {650, 0}
  })
  UIHelper.MoveToLeft({
    node = self.countBg1,
    time = 0.6,
    pos = {350, 0}
  })
  UIHelper.MoveToLeft({
    node = self.countBg2,
    time = 0.6,
    pos = {350, 0}
  })
  self.selected = game.role.moonBattleCurType or 1
  self.uiNormal = true
  self.drawGroup = 1
  self.handlers = {}
  self.btns = {}
  local open = true or game:nowTime() >= CommonHelper.toUnixtime(ChapterCsv[1015].openTime .. string.format("%02x", RESET_TIME))
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("ffffff"))
      text:enableOutline(UIHelper.hex2rgb("#a46823"), 2)
      sender:scale(1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("c0c0c0"))
      text:enableOutline(UIHelper.hex2rgb("#6e4c17"), 2)
      sender:scale(0.88)
    end
  })
  for i, data in ipairs(btnData) do
    local btn = self["btn" .. i]
    display.newTTFLabel({
      text = data.name,
      size = 28
    }):pos(78, 37):addTo(btn):name("name")
    btn:setName(string.format("btn%d", i))
    btn:setGroup(group)
    btn:setCallback(function()
      if i == 3 and not open then
        group:chooseByName("btn" .. self.selected)
        SysError(SYS_ERR_MOON_CARBON_AREA_LIMIT_TIME)
        return
      end
      self.barNode:removeAllChildren()
      self.selected = i
      self:showData()
    end)
    if i == 3 and not open then
      display.newTTFLabel({text = "未解锁", size = 16}):enableOutline(UIHelper.hex2rgb("#6e4c17"), 1):pos(64, 20):addTo(btn)
    end
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.newyear[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(20, -35), 0.8)
    end
  end
  group:chooseByName("btn" .. self.selected)
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "newyear" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.newyear[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(20, -35), 0.8)
      end
    end
  end))
  self.countBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg1,
      itemType = 15,
      itemData = ItemCsv[15]
    })
  end)
  self.countBg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg2,
      itemType = 64,
      itemData = ItemCsv[64]
    })
  end)
  self.btnDraw:setCallback(function()
    self.barNode:hide()
    self:changeUI()
  end)
  self.btnClose:setCallback(function()
    self.barNode:show()
    self:changeUI()
  end)
  self.btnRule:setCallback(function()
    game:createView("global.RuleLayer", {
      res = SummerRes .. (self.selected == 3 and "image_rule_2.png" or "image_rule_1.png")
    })
  end)
  self.leftBg:setCallback(function()
    game:createView("newyear.NewYearDrawInfoLayer", {
      group = self.drawGroup
    })
  end)
  self.btnDraw1:setCallback(function()
    self:draw(1)
  end)
  self.btnDraw2:setCallback(function()
    self:draw(10)
  end)
  self.btnAdd:setCallback(function()
    game:createView("newyear.NewYearItemLayer", {
      func = function()
        self:updateNum()
      end
    })
  end)
  self.btnUse:setCallback(function()
    if (game.role.items[64] or 0) < 1 then
      SysError(SYS_ERR_MOON_CARBON_QUAN_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_newYearFightUpRpc, MsgPack.pack({type = 2}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_newYearFightUpRpc, function(event)
      UIHelper.removeWaiting()
      self:initBuff()
    end)
  end)
  self:initBuff()
  self:updateNum()
  self:updateDrawNum()
end

function SummerLayer:initBuff()
  if game.role.midBattleCount:getv(1, 0) == 1 then
    display.newSprite(MainRes .. "area_image_yes.png"):pos(28, 29):addTo(self.btnUse)
  else
    self.btnUse:removeAllChildren()
  end
end

function SummerLayer:showData(params)
  if self.selected ~= 3 and not self.uiNormal then
    self:changeUI()
  end
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
  self:initHero()
  self:showExtraBtns()
end

function SummerLayer:showChapter()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_1.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_1.png")
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id < 1600 and data.id % 10 == 1 then
      local open, count = self:getCarbonStatus(data)
      local temp = clone(data)
      temp.open = open
      temp.count = count
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(500, 116)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(SummerRes .. "chapter_cell.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 26,
      color = UIHelper.hex2rgb("#e2570b")
    }):anch(0, 0.5):pos(15, 82):addTo(cell)
    display.newSprite(SummerRes .. "enter.png"):pos(450, 23):addTo(cell)
    if data.open then
      display.newTTFLabel({
        text = "推荐美味度: " .. data.enterPower,
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):anch(0, 0.5):pos(15, 55):addTo(cell)
      display.newTTFLabel({
        text = "净化程度:",
        size = 18,
        color = UIHelper.hex2rgb("#e2570b")
      }):anch(0, 0.5):pos(15, 27):addTo(cell)
      local mapId = math.floor(data.id / 10)
      local xPos = 120
      local able = false
      local state = game.role.midAutAreaTask:getv(mapId, 0)
      local gift = GiftCsv[mapId].gift:toArray("=", true)
      local item = ItemIcon.new({
        type = gift[1],
        count = gift[2]
      }):scale(0.8):pos(380, 58):addTo(cell)
      if game.role.moonBattle.carbonId and mapId == math.floor(game.role.moonBattle.carbonId / 10) then
        display.newSprite("ui/autumn/main/battle.png"):pos(461, 95):addTo(cell)
        selected = index
      end
      local goalId = 0
      for i = 1, 3 do
        local tempCount = game.role.midBattleCount:getv(mapId * 10 + i, 0)
        display.newSprite(SummerRes .. (1 <= tempCount and "chapter_cell_mark_2.png" or "chapter_cell_mark_1.png")):pos(xPos, 24):addTo(cell)
        if goalId == 0 and tempCount == 0 then
          goalId = mapId * 10 + i
        end
        able = 1 <= tempCount
        xPos = xPos + 35
      end
      if goalId == 0 then
        goalId = mapId * 10 + 3
      end
      if state == -1 then
        display.newSprite(MainRes .. "image_red.png"):pos(380, 23):addTo(cell)
      elseif able then
        display.newSprite(MainRes .. "image_green.png"):pos(380, 23):addTo(cell)
        item:setCallback(function()
          game:sendData(actionCodes.Activity_newYearOnceRewardRpc, MsgPack.pack({id = mapId}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_newYearOnceRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            self:showChapter()
            self:updateNum()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        end)
      end
      cell:setCallback(function()
        self:goBattle(goalId)
      end)
    else
      if data.openLevel ~= 0 then
        local tempData = ChapterCsv[data.openLevel] or {}
        display.newTTFLabel({
          text = string.format("完成 %s 后解锁", tempData.name),
          size = 18,
          color = UIHelper.hex2rgb("#ffffff")
        }):anch(0, 0.5):pos(15, 55):addTo(cell)
      end
      display.newSprite(SummerRes .. "chapter_cell_mask.png"):center(cell):addTo(cell)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.6), cc.p(0, -0.5))
  end
end

function SummerLayer:showTask()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_1.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_1.png")
  local selected = 0
  local group = 0
  local xPos = 88, 60
  local cell
  local size = cc.size(500, 144)
  for _, data in ipairs(TaskCsv) do
    local open = game:nowTime() >= CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME))
    if data.group ~= group then
      xPos = 88
      group = data.group
      local viewNode = ccui.Widget:create()
      viewNode:size(size.width, size.height):addTo(self.list)
      cell = UIHelper.newImageView(SummerRes .. "task_cell.png"):center(viewNode):addTo(viewNode)
      if open then
        display.newTTFLabel({
          text = data.desc,
          size = 20,
          color = UIHelper.hex2rgb("#e2570b")
        }):anch(0, 0.5):pos(33, 121):addTo(cell)
        display.newSprite(MainRes .. "task_cell_line.png"):pos(245, 108):addTo(cell)
      else
        display.newSprite(SummerRes .. "task_cell_tip_bg.png"):pos(245, 70):addTo(cell)
        display.newTTFLabel({
          text = data.unlockDesc,
          size = 18,
          color = UIHelper.hex2rgb("#e2570b")
        }):pos(245, 72):addTo(cell)
      end
    end
    if open then
      local gift = data.gift:toArray("=", true)
      local state = game.role.midAutScoreGift:getv(data.id, 0)
      local tip = display.newSprite(MainRes .. "image_red.png"):pos(xPos, 48):addTo(cell)
      local bg = UIHelper.newImageView(SummerRes .. "task_cell_item_bg.png"):pos(xPos + 2, 60):addTo(cell)
      local icon = ItemIcon.new({
        type = gift[1],
        count = gift[2]
      }):scale(0.68):pos(xPos, 65):addTo(cell)
      display.newSprite(SummerRes .. "task_cell_num_bg.png"):pos(43, 6):addTo(bg)
      display.newTTFLabel({
        text = data.condition1 .. "次",
        size = 16
      }):enableOutline(UIHelper.hex2rgb("#672806"), 1):pos(43, 8):addTo(bg)
      if state == -1 then
        tip = display.newSprite(MainRes .. "image_red.png"):pos(xPos, 48):addTo(cell)
        bg:setCallback(function()
          MTip:show({
            type = MTipType.item,
            node = bg,
            itemType = gift[1],
            itemData = ItemCsv[gift[1]]
          })
        end)
      elseif state >= data.condition1 then
        if selected == 0 then
          selected = group
        end
        tip = display.newSprite(MainRes .. "image_green.png"):pos(xPos, 48):addTo(cell)
        bg:setCallback(function()
          if not game.role:activityIsOpen(38) then
            SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
            return
          end
          game:sendData(actionCodes.Activity_newYearTaskRewardRpc, MsgPack.pack({
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_newYearTaskRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            bg:setCallback(function()
              MTip:show({
                type = MTipType.item,
                node = bg,
                itemType = gift[1],
                itemData = ItemCsv[gift[1]]
              })
            end)
            self:updateNum()
            tip:setTexture(MainRes .. "image_red.png")
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        end)
      else
        bg:setCallback(function()
          MTip:show({
            type = MTipType.item,
            node = bg,
            itemType = gift[1],
            itemData = ItemCsv[gift[1]]
          })
        end)
      end
      xPos = xPos + 105
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 1), cc.p(0, 1))
  end
end

function SummerLayer:showArea()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_2.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_2.png")
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id > 1600 then
      table.insert(sortData, clone(data))
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(500, 116)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(SummerRes .. "area_cell.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 30,
      color = UIHelper.hex2rgb("#e2570b")
    }):anch(0, 0.5):pos(40, 72):addTo(cell)
    display.newTTFLabel({
      text = "推荐美味度: " .. data.enterPower,
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(167, 46):addTo(cell)
    if game.role.moonBattle.carbonId and data.id == game.role.moonBattle.carbonId then
      display.newSprite("ui/autumn/main/battle.png"):pos(461, 95):addTo(cell)
      selected = index
    end
    cell:setCallback(function()
      self:goBattle(data.id)
    end)
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 1), cc.p(0, 1))
  end
  self:showBar()
end

function SummerLayer:showBar()
  self.barNode:show()
  local value = self:getFitValue()
  local barBg = UIHelper.newImageView(SummerRes .. "bar_bg.png"):anch(0.5, 0):addTo(self.barNode)
  local bar = display.newProgressTimer(SummerRes .. "bar.png", 1):setRotation(-90):anch(0, 0.5):pos(57, 7):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(value / globalCsv.ActivityExtraLimit[15] * 100)
  display.newTTFLabel({
    text = string.format("掉落加成:%d", value),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#157185"), 1):pos(0, -10):addTo(self.barNode)
  barBg:setCallback(function()
    UIHelper.showOnleImgTip(SummerRes .. "image_info.png")
  end)
end

function SummerLayer:getFitValue()
  game.role.diner = game.role.diner or {}
  local fits = game.role.diner.item_fitment or {}
  local boxs = game.role.diner.item_box or {}
  local sum = 0
  for itemId, set in pairs(globalCsv.ActivityExtraFurniture) do
    local itemData = ItemCsv[itemId]
    if itemData.type == ItemType.DinerBox then
      if boxs[tonumber(itemData.content)] then
        sum = sum + set.add
      end
    elseif itemData.type == ItemType.Fitment then
      sum = sum + (fits[tonumber(itemData.content)] or 0) * set.add
    end
  end
  sum = math.min(sum, globalCsv.ActivityExtraLimit[15])
  return sum
end

function SummerLayer:getCarbonStatus(chapter)
  local res, count = false, game.role.midBattleCount:getv(chapter.id, 0)
  if chapter.openTime == "" then
    if chapter.openLevel ~= 0 then
      res = game.role.midBattleCount:getv(chapter.openLevel, 0) >= 1
    else
      res = true
    end
    return res, count
  end
  return game:nowTime() >= CommonHelper.toUnixtime(chapter.openTime .. string.format("%02x", RESET_TIME)), count
end

function SummerLayer:draw(num)
  local now, level, group = self:getDrawNum()
  if now >= group[level] then
    SysError(SYS_ERR_CARBON_ACTIVITY_DRAW_OUT)
    return
  elseif num == 10 and level == #group and group[level] - now < 10 then
    SysError(SYS_ERR_CARBON_ACTIVITY_NOT_ENOUGH_DRAW_TEN)
    return
  end
  local str = num == 1 and globalCsv.ActivityDrawCost_1 or globalCsv.ActivityDrawCost_10
  local cost = str:toArray("=", true)
  if (game.role.items[cost[1]] or 0) < cost[2] then
    SysError(SYS_ERR_CARBON_ACTIVITY_DRAW_SOUCE_NOT_ENOUGH)
    return
  end
  game:sendData(actionCodes.Activity_newYearDrawRewardRpc, MsgPack.pack({
    type = num == 1 and 1 or 2,
    reward2 = false
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_newYearDrawRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.reward = msg.reward
    self.closeCount = 0
    self.needCloseCount = #self.reward
    for i = 1, #self.reward do
      if self.reward[i].changeId then
        self.needCloseCount = self.needCloseCount + 1
      end
    end
    self:updateNum()
    self:updateDrawNum()
    self:showAnimation()
  end)
end

function SummerLayer:showAnimation()
  self.mask = UIHelper.extend(ccui.Layout:create())
  local isIphonex = false
  if UIHelper.isiPhoneX() then
    isIphonex = true
    self.mask:size(display.width + UIHelper.getMoveXForX() * 2, display.height)
  else
    self.mask:size(display.width, display.height)
  end
  self.mask:setBackGroundColorType(1)
  self.mask:setBackGroundColor(cc.c3b(0, 0, 0))
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:setBackGroundColorOpacity(0)
  self.mask:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  local spine = UIHelper.createSpineNodeByRes(DrawRes .. "feichuan")
  spine:setAnimation(0, "bg", false)
  spine:pos(self.mask:getContentSize().width / 2, display.cy + 4):addTo(self.mask)
  if isIphonex then
    UIHelper.fitForiPhoneX(spine)
  end
  spine:runAction(transition.sequence({
    cc.DelayTime:create(10),
    cc.CallFunc:create(function()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end),
    cc.RemoveSelf:create()
  }))
  self.mask:setCallback(function()
    if not tolua.isnull(spine) then
      spine:stopAllActions()
      self.mask:removeAllChildren()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end
  end)
end

function SummerLayer:showItems()
  self.Pos = {}
  if #self.reward == 1 then
    self.Pos[1] = {
      display.cx,
      display.cy - 10
    }
    if UIHelper.isiPhoneX() then
      self.Pos[1][1] = self.Pos[1][1] + UIHelper.getMoveXForX()
    end
  else
    local xPos, yPos = 270, 390
    if UIHelper.isiPhoneX() then
      xPos = xPos + UIHelper.getMoveXForX()
    end
    for index = 1, 10 do
      self.Pos[index] = {xPos, yPos}
      xPos = xPos + 150
      if index == 5 then
        xPos = 270
        if UIHelper.isiPhoneX() then
          xPos = xPos + UIHelper.getMoveXForX()
        end
        yPos = 210
      end
    end
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  local di = display.newSprite(MainRes .. "area_draw_result_bg.png"):pos(cx, display.cy):addTo(self.mask)
  di:setScaleY(0)
  di:runAction(transition.sequence({
    cc.ScaleTo:create(0.1, 1, 1),
    cc.CallFunc:create(function()
      self:open(1)
    end)
  }))
end

function SummerLayer:open(index)
  if index > #self.Pos then
    return
  end
  local itemType = ItemCsv[self.reward[index].id].type
  local bg
  if self.reward[index].prize == 1 then
    bg = display.newSprite(DrawRes .. "card_bg2.png")
    local flash = UIHelper.loadAnimation(DrawRes, "draw", 10, 10)
    flash.sprite:center(bg):addTo(bg)
    flash.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
    flash.sprite:playAnimationForever(flash.animation)
  else
    bg = display.newSprite(MainRes .. "area_draw_card_bg.png")
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  bg:pos(cx, display.cy):addTo(self.mask, nil, index):setScale(0)
  local name = display.newTTFLabel({
    text = ItemCsv[self.reward[index].id].name,
    size = 20,
    color = UIHelper.hex2rgb("#763636")
  }):pos(70, 22):addTo(bg)
  local countLab = display.newTTFLabel({
    text = "x" .. self.reward[index].count,
    size = 18,
    color = UIHelper.hex2rgb("#763636")
  }):anch(1, 0.5):pos(132, 50):addTo(bg):hide()
  local icon
  if itemType == ItemType.DinerCar or itemType == ItemType.DinerBox or itemType == ItemType.Fitment then
    icon = UIHelper.newImageView(ItemCsv[self.reward[index].id].icon):pos(70, 105):addTo(bg)
    icon:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = itemType,
        itemData = ItemCsv[self.reward[index].id],
        count = 0
      })
    end)
    if 1 < self.reward[index].count then
      countLab:show()
    end
  else
    icon = ItemIcon.new({
      type = self.reward[index].id,
      count = self.reward[index].count,
      showTip = true
    }):pos(70, 105):addTo(bg)
  end
  local action = {
    transition.sequence({
      cc.EaseExponentialOut:create(cc.ScaleTo:create(0.05, 1)),
      cc.DelayTime:create(0.1),
      cc.MoveTo:create(0.1, cc.p(self.Pos[index][1], self.Pos[index][2])),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    }),
    transition.sequence({
      cc.DelayTime:create(0.15),
      cc.CallFunc:create(function()
        self:open(index + 1)
      end)
    })
  }
  if self.reward[index].changeId then
    action[#action + 1] = transition.sequence({
      cc.DelayTime:create(0.15 * (#self.reward - index) + 0.5),
      cc.ScaleTo:create(0.1, 0, 1),
      cc.CallFunc:create(function()
        icon:removeSelf()
        ItemIcon.new({
          type = self.reward[index].changeId,
          count = self.reward[index].changeCount,
          showTip = true
        }):pos(70, 105):addTo(bg)
        name:setString(ItemCsv[self.reward[index].changeId].name)
        countLab:hide()
      end),
      cc.ScaleTo:create(0.05, 1, 1),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    })
  end
  bg:runAction(cc.Spawn:create(action))
end

function SummerLayer:checkCanClose()
  self.closeCount = self.closeCount + 1
  if self.closeCount >= self.needCloseCount then
    self.mask:setCallback(function()
      self.mask:removeSelf()
    end)
  end
end

function SummerLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "哇哦……！沙滩！大海！展现着肉体之美学的动人少女们！要说夏天的精华全在此地也一点都不为过！",
    [2] = "泳池当然也很棒啦……但是大海与沙滩的自然美才更能够衬托出肉体之美啊！",
    [3] = "……什么啊！各种麻烦的限制……真是的！我一定让所有小可爱都快快穿上泳——啊啊，是主厨啊……你刚刚……什么都没听到！"
  }
  local texts2 = {
    [1] = "既然通过了试炼，给予奖励也是必须的呢……拿去吧，去享受舞台带来的荣耀吧。",
    [2] = "老是想着“快点走完”是不行的，试着用自己的方法完成它……在舞台之上，保持自己的风格很重要。",
    [3] = "欲望与勇气是正相关的。快去努力攀爬最高的舞台——来让我见识下你们的潜力吧。"
  }
  local texts3 = {
    [1] = "辛苦了，这里有冰镇的饮料哦，喝下去能够缓解疲劳、提高力量，快去分发给辛苦战斗的食灵们吧……给～",
    [2] = "真是美丽的贝壳……穿在一起就可以做成梦里的贝壳项链，怪不得它被当成是这里的宝物啊。",
    [3] = "欢迎回来！你也要来一些冰镇饮料吗？"
  }
  local heroId = self.selected == 1 and 618 or self.selected == 2 and 622 or 623
  local texts = self.selected == 1 and texts1 or self.selected == 2 and texts2 or texts3
  local card = UIHelper.newImageView(UIHelper.getCardRes("normal", heroId, false)):pos(40, 0):addTo(self.heroNode)
  card:setCallback(function()
    if not tolua.isnull(self.talkBg) then
      return
    end
    self.talkBg = display.newSprite("ui/home/talk_bg.png"):pos(-85, -120):addTo(self.heroNode)
    self.talkBg:setCascadeOpacityEnabled(true)
    self.talkBg:setOpacity(0)
    self.talkBg:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 50))),
      cc.CallFunc:create(function()
        local index = math.random(1, #texts)
        local label = MRichText.new({
          text = texts[index],
          color = UIHelper.hex2rgb("#000000"),
          size = 18,
          maxWidth = 265
        }):pos(20, 100):addTo(self.talkBg)
        label:playAnimation(15, nil, nil)
      end),
      cc.DelayTime:create(5),
      cc.Spawn:create(cc.FadeOut:create(0.5), cc.MoveBy:create(0.5, cc.p(0, 70))),
      cc.RemoveSelf:create()
    }))
  end)
end

function SummerLayer:changeUI()
  if self.uiNormal then
    self.uiNormal = false
    self.touch:show()
    self.btnDraw:hide()
    self.btnUse:hide()
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(700, 0)))
    self.panel2:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(-700, 0)),
      cc.CallFunc:create(function()
        self.touch:hide()
      end)
    }))
  else
    self.uiNormal = true
    self.touch:show()
    self.btnDraw:show()
    self.btnUse:show()
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(-700, 0)))
    self.panel2:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(700, 0)),
      cc.CallFunc:create(function()
        self.touch:hide()
      end)
    }))
  end
end

function SummerLayer:goBattle(id)
  if not game.role:activityIsOpen(38) then
    SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
    return
  end
  if next(json.decode(game.role.battleInfo) or {}) then
    SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
    return
  end
  if next(json.decode(game.role.paradiseBattleInfo) or {}) then
    SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
    return
  end
  if game.role.moonBattle.carbonId then
    if self.selected == 1 then
      if math.floor(game.role.moonBattle.carbonId / 10) ~= math.floor(id / 10) then
        SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
        return
      end
    elseif game.role.moonBattle.carbonId ~= id then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
  end
  if not game.role.moonBattle.carbonId and game.role:isMaxHero() then
    UIHelper.showExtraTip({type = 1, parent = self})
    return
  end
  game.role.moonBattleCurType = self.selected
  local chapterData = ChapterCsv[id]
  if game.role.midBattleCount:getv(id, 0) == 0 and not game.role.moonBattle.carbonId and chapterData.story1 ~= 0 then
    game:createView("talk.PlotTalkLayer", {
      talkId = chapterData.story1,
      csvNo = chapterData.readcsv or 0,
      onComplete = function()
        game:enterScene("MoonScene", {carbonId = id})
      end
    })
    self:close()
    return
  end
  game:enterScene("MoonScene", {carbonId = id})
  self:close()
end

function SummerLayer:updateNum()
  self.value1:setString(game.role.items[15] or 0)
  self.value2:setString(game.role.items[64] or 0)
end

function SummerLayer:getDrawNum()
  local now, level, group = 0, 0, {}
  local temp = 0
  for _, data in ipairs(DrawCsv) do
    temp = temp + data.limit
    now = now + game.role.midAutDailyTask:getv(data.id, 0)
    group[data.group] = temp
  end
  for i, value in ipairs(group) do
    if value > now then
      level = i
      break
    end
  end
  if level == 0 then
    level = #group
  end
  return now, level, group
end

function SummerLayer:updateDrawNum()
  self.node:removeAllChildren()
  local now, level, group = self:getDrawNum()
  self.drawGroup = level
  self.leftTip:setString(string.format("当前%d/%d阶段", level, #group))
  self.leftNum:setString(string.format("奖励剩余: %d", group[level] - now))
  display.newSprite(SummerRes .. string.format("area_draw_image_%d.png", level)):addTo(self.node)
end

function SummerLayer:showExtraBtns()
  local bShow = self.selected == 3 and true or false
  self.btnDraw:setVisible(bShow)
  self.btnUse:setVisible(bShow)
  self.countBg1:setVisible(bShow)
  self.countBg2:setVisible(bShow)
end

function SummerLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return SummerLayer
