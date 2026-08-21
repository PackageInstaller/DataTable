local ChapterCsv = require("csvdata.moon_chapter_battle")
local GiftCsv = require("csvdata.once_activity.newyear")
local TaskCsv = require("csvdata.moon_task")
local DrawCsv = require("csvdata.loop_activity.loop_drawgift")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/newyear/main/"
local DrawRes = "ui/diner/draw/"
local uiData = {
  csbFile = "ui/newyear/NewYearLayer.csb",
  widgets = {
    touch = "touch",
    up = "up",
    lineUp = "lineUp",
    mainBg = "mainBg",
    heroNode = "heroNode",
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
    btnsBg = "btnsBg",
    btn1 = "btnsBg/btn1",
    btn2 = "btnsBg/btn2",
    btn3 = "btnsBg/btn3",
    btnUse = "btnUse",
    btnRule = "btnRule",
    btnDraw = "btnDraw",
    image1 = "image1",
    image2 = "image2",
    image3 = "image3"
  }
}
local btnData = {
  [1] = {
    name = "关卡",
    red = "chapter",
    func = function(self)
      self:showChapter()
    end
  },
  [2] = {
    name = "任务",
    red = "task",
    func = function(self)
      self:showTask()
    end
  },
  [3] = {
    name = "区域",
    red = "",
    func = function(self)
      self:showArea()
    end
  }
}
local NewYearLayer = class("NewYearLayer", UIBase)

function NewYearLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewYearLayer:init(params)
  TopBar:show(TopBarType.full, "新年活动")
  TopBar:showAnimation(true)
  CommonHelper.playHomeBGM()
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
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX())
    self.image1:setPositionX(self.image1:getPositionX() - UIHelper.getMoveXForX())
    self.image2:setPositionX(self.image2:getPositionX() - UIHelper.getMoveXForX())
    self.image3:setPositionX(self.image3:getPositionX() + UIHelper.getMoveXForX())
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
    node = self.lineUp,
    time = 0.5,
    pos = {0, 90}
  })
  UIHelper.MoveToDown({
    node = self.btnsBg,
    time = 0.5
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
  local open = game:nowTime() >= CommonHelper.toUnixtime(ChapterCsv[1301].openTime .. string.format("%02x", RESET_TIME))
  local group = MRadioGroup:create()
  for i, data in ipairs(btnData) do
    local btn = self["btn" .. i]
    btn:setName(string.format("btn%d", i))
    btn:setGroup(group)
    btn:setCallback(function()
      if i == 3 and not open then
        group:chooseByName("btn" .. self.selected)
        SysError(SYS_ERR_MOON_CARBON_AREA_LIMIT_TIME)
        return
      end
      self.selected = i
      self:showData()
    end)
    if i == 3 and not open then
      display.newSprite(MainRes .. "btn_lock.png"):center(btn):addTo(btn)
    end
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.newyear[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
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
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
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
    self:changeUI()
  end)
  self.btnClose:setCallback(function()
    self:changeUI()
  end)
  self.btnRule:setCallback(function()
    game:createView("global.RuleLayer", {
      res = MainRes .. (self.selected == 3 and "image_rule_2.png" or "image_rule_1.png")
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

function NewYearLayer:initBuff()
  if game.role.midBattleCount:getv(1, 0) == 64 then
    display.newSprite(MainRes .. "area_image_yes.png"):pos(28, 29):addTo(self.btnUse)
  else
    self.btnUse:removeAllChildren()
  end
  display.newSprite(ItemCsv[64].icon):scale(0.5):pos(145, 22):addTo(self.btnUse)
end

function NewYearLayer:showData(params)
  if self.selected ~= 3 and not self.uiNormal then
    self:changeUI()
  end
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
  self:initHero()
  self:showExtraBtns()
end

function NewYearLayer:showChapter()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_1.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_1.png")
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id < 1300 and data.id % 10 == 1 then
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
  local size = cc.size(500, 104)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "chapter_cell.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#900808")
    }):anch(0, 0.5):pos(45, 79):addTo(cell)
    if data.open then
      display.newTTFLabel({
        text = "推荐美味度: " .. data.enterPower,
        size = 18,
        color = UIHelper.hex2rgb("#900808")
      }):anch(0, 0.5):pos(45, 49):addTo(cell)
      display.newTTFLabel({
        text = "净化程度:",
        size = 18,
        color = UIHelper.hex2rgb("#900808")
      }):anch(0, 0.5):pos(45, 24):addTo(cell)
      local mapId = math.floor(data.id / 10)
      local xPos = 150
      local able = false
      local state = game.role.midAutAreaTask:getv(mapId, 0)
      local gift = GiftCsv[mapId].gift:toArray("=", true)
      local item = ItemIcon.new({
        type = gift[1],
        count = gift[2],
        showTip = true
      }):scale(0.8):pos(432, 51):addTo(cell)
      if game.role.moonBattle.carbonId and mapId == math.floor(game.role.moonBattle.carbonId / 10) then
        display.newSprite("ui/autumn/main/battle.png"):pos(461, 85):addTo(cell)
        selected = index
      end
      local goalId = 0
      for i = 1, 3 do
        local tempCount = game.role.midBattleCount:getv(mapId * 10 + i, 0)
        display.newSprite(MainRes .. (1 <= tempCount and "chapter_cell_mark_2.png" or "chapter_cell_mark_1.png")):pos(xPos, 24):addTo(cell)
        if goalId == 0 and tempCount == 0 then
          goalId = mapId * 10 + i
        end
        able = 1 <= tempCount
        xPos = xPos + 30
      end
      if goalId == 0 then
        goalId = mapId * 10 + 3
      end
      if state == -1 then
        display.newSprite(MainRes .. "image_red.png"):pos(432, 19):addTo(cell)
      elseif able then
        display.newSprite(MainRes .. "image_green.png"):pos(432, 19):addTo(cell)
        item:setCallback(function()
          game:sendData(actionCodes.Activity_newYearOnceRewardRpc, MsgPack.pack({id = mapId}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_newYearOnceRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            self:showChapter()
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
          color = UIHelper.hex2rgb("#900808")
        }):anch(0, 0.5):pos(45, 50):addTo(cell)
      end
      display.newSprite(MainRes .. "chapter_cell_mask.png"):center(cell):addTo(cell)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.65), cc.p(0, -0.5))
  end
end

function NewYearLayer:showTask()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_1.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_1.png")
  local selected = 0
  local group = 0
  local xPos = 88, 60
  local cell
  local size = cc.size(500, 144)
  for _, data in ipairs(TaskCsv) do
    local open = true
    if data.group ~= group then
      xPos = 88
      group = data.group
      local viewNode = ccui.Widget:create()
      viewNode:size(size.width, size.height):addTo(self.list)
      cell = UIHelper.newImageView(MainRes .. "task_cell.png"):center(viewNode):addTo(viewNode)
      if open then
        display.newTTFLabel({
          text = data.desc,
          size = 20,
          color = UIHelper.hex2rgb("#900808")
        }):anch(0, 0.5):pos(33, 122):addTo(cell)
        display.newSprite(MainRes .. "task_cell_line.png"):pos(245, 108):addTo(cell)
      else
        display.newSprite(MainRes .. "task_cell_tip_bg.png"):pos(245, 70):addTo(cell)
        display.newTTFLabel({
          text = data.unlockDesc,
          size = 20,
          color = UIHelper.hex2rgb("#e21c38")
        }):pos(245, 70):addTo(cell)
      end
    end
    if open then
      local gift = data.gift:toArray("=", true)
      local state = game.role.midAutScoreGift:getv(data.id, 0)
      local tip = display.newSprite(MainRes .. "image_red.png"):pos(xPos, 48):addTo(cell)
      local bg = UIHelper.newImageView(MainRes .. "task_cell_item_bg.png"):pos(xPos, 60):addTo(cell)
      ItemIcon.new({
        type = gift[1],
        count = gift[2]
      }):scale(0.68):pos(xPos, 60):addTo(cell)
      display.newSprite(MainRes .. "task_cell_num_bg.png"):pos(43, 5):addTo(bg)
      display.newTTFLabel({
        text = data.condition1 .. "次",
        size = 16
      }):pos(43, 5):addTo(bg)
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
            bg:setTouchEnabled(false)
            tip:setTexture(MainRes .. "image_red.png")
            MedalRewardLayer.new({
              items = msg.reward
            })
            bg:setCallback(function()
              MTip:show({
                type = MTipType.item,
                node = bg,
                itemType = gift[1],
                itemData = ItemCsv[gift[1]]
              })
            end)
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

function NewYearLayer:showArea()
  self.list:removeAllChildren()
  self.btnRule:loadTextureNormal(MainRes .. "btn_rule_2.png")
  self.btnRule:loadTexturePressed(MainRes .. "btn_rule_2.png")
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id > 1300 then
      table.insert(sortData, clone(data))
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(500, 104)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "area_cell.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#df2937")
    }):anch(0, 0.5):pos(61, 63):addTo(cell)
    display.newTTFLabel({
      text = "推荐美味度: " .. data.enterPower,
      size = 18,
      color = UIHelper.hex2rgb("#df2937")
    }):anch(0, 0.5):pos(61, 37):addTo(cell)
    if game.role.moonBattle.carbonId and data.id == game.role.moonBattle.carbonId then
      display.newSprite("ui/autumn/main/battle.png"):pos(461, 85):addTo(cell)
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
end

function NewYearLayer:getCarbonStatus(chapter)
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

function NewYearLayer:draw(num)
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
    self.heros = {}
    for _, data in pairs(self.reward) do
      if ItemCsv[data.id].type == ItemType.Hero then
        self.heros[data.id] = (self.heros[data.id] or 0) + data.count
      end
    end
    self:updateNum()
    self:updateDrawNum()
    self:showAnimation()
  end)
end

function NewYearLayer:showAnimation()
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

function NewYearLayer:showItems()
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

function NewYearLayer:open(index)
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

function NewYearLayer:checkCanClose()
  self.closeCount = self.closeCount + 1
  if self.closeCount >= self.needCloseCount then
    self.mask:setCallback(function()
      self.mask:removeSelf()
      if next(self.heros) then
        MedalRewardLayer.new({
          items = self.heros
        })
      end
    end)
  end
end

function NewYearLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "……预热活动？啊！我知道了，是不是像做晚宴一样，要去重新加热一下最早做出来的那些菜？",
    [2] = "我们和主厨相遇居然都有一整年了吗？啊、说起来刚刚好像看见了汤圆了，主厨有没有和她契约来着？",
    [3] = "喂喂、主厨，我在这里哦——在这里……之后记得戴上四喜丸子准备的丸子~"
  }
  local texts2 = {
    [1] = "唔……为什么还没到我出场啊……怎么还有让顶尖设计师等人的耶……！",
    [2] = "对了对了！看那个！九层糕的衣服可是我的得意作品哦！哈？你、你已经见过了？",
    [3] = "好好看，好好做，请以成为顶尖设计师的助手为不懈目标努力……所以说不要看我啦！看任务，看任务！"
  }
  local texts3 = {
    [1] = "新年快乐，主厨，现在种下种子，等待收获果实吧。啊对了，说到新年，我就想到最适合喝的茶是……诶诶！不要走嘛！",
    [2] = "新年，一年之始，抛弃陈旧的东西，迎接新的事物，不是很棒吗……说起来要来点新茶吗？",
    [3] = "我、我不是来做茶叶推销的啦……嗯，是引导……唔唔，等一下，茶园导购是什么……"
  }
  local heroId = self.selected == 1 and 316 or self.selected == 2 and 320 or 619
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

function NewYearLayer:changeUI()
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

function NewYearLayer:goBattle(id)
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

function NewYearLayer:updateNum()
  self.value1:setString(game.role.items[15] or 0)
  self.value2:setString(game.role.items[64] or 0)
end

function NewYearLayer:getDrawNum()
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

function NewYearLayer:updateDrawNum()
  self.node:removeAllChildren()
  local now, level, group = self:getDrawNum()
  self.drawGroup = level
  self.leftTip:setString(string.format("当前%d/%d阶段", level, #group))
  self.leftNum:setString(string.format("奖励剩余: %d", group[level] - now))
  display.newSprite(MainRes .. string.format("area_draw_image_%d.png", 1)):addTo(self.node)
end

function NewYearLayer:showExtraBtns()
  local bShow = self.selected == 3 and true or false
  self.btnDraw:setVisible(bShow)
  self.btnUse:setVisible(bShow)
  self.countBg1:setVisible(bShow)
  self.countBg2:setVisible(bShow)
end

function NewYearLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return NewYearLayer
