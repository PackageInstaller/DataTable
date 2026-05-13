local BattleCsv = require("csvdata.moon_chapter_battle")
local GiftPack = require("csvdata.moon_gift")
local TaskCsv = require("csvdata.moon_task")
local ScoreCsv = require("csvdata.moon_scoregift")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/autumn/main/"
local CarbonRes = "ui/autumn/carbon/"
local TaskRes = "ui/autumn/task/"
local ScoreRes = "ui/autumn/score/"
local uiData = {
  csbFile = "ui/autumn/MidAutumnMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    bgNode = "bgNode",
    mainFrame = "mainFrame",
    btnList = "btnList",
    newLayer = "newLayer",
    extra = "extra"
  }
}
local btnData = {
  [1] = {
    name = "中秋副本",
    red = "carbonGift",
    func = function(self)
      self:showCarbon()
    end
  },
  [2] = {
    name = "每日任务",
    red = "task",
    func = function(self)
      self:showTask()
    end
  },
  [3] = {
    name = "累计奖励",
    red = "score",
    func = function(self)
      self:showScore()
    end
  }
}
local err = {
  [2] = "“眉月”关卡将于 %s 月 %s 日 凌晨 4 点开放。",
  [3] = "“弦月”关卡将于 %s 月 %s 日 凌晨 4 点开放。",
  [4] = "“凸月”关卡将于 %s 月 %s 日 凌晨 4 点开放。",
  [5] = "“满月”关卡将于 %s 月 %s 日 凌晨 4 点开放。",
  [6] = "“EX1”关卡将于 %s 月 %s 日 凌晨 4 点开放。",
  [7] = "“EX2”关卡将于 %s 月 %s 日 凌晨 4 点开放。"
}
local CARBON_BEGIN_ID = 1020
local MidAutumnMainLayer = class("MidAutumnMainLayer", UIBase)

function MidAutumnMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MidAutumnMainLayer:init(params)
  TopBar:show(TopBarType.full, AutumnTitleName)
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  self.deltaX = 0
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.mainFrame)
    self.btnList:setPositionX(self.btnList:getPositionX() - UIHelper.getMoveXForX() + 35)
    self.extra:setPositionX(self.extra:getPositionX() - UIHelper.getMoveXForX())
    self.newLayer:setPositionX(self.newLayer:getPositionX() - UIHelper.getMoveXForX())
    self.deltaX = UIHelper.getMoveXForX() + 30
  end
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  self.selected = params.selected or 1
  self.first = true
  self.handlers = {}
  self.carbonHandler = {}
  self.btns = {}
  self.group = MRadioGroup:create()
  local delay = 0.2
  local btnSize = display.newSprite(MainRes .. "btn_a.png"):getContentSize()
  btnSize.height = btnSize.height + 4
  for index, data in ipairs(btnData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {"btn_a.png", "btn_b.png"})
    btn:setName(string.format("index%d", index))
    btn:setGroup(self.group)
    btn:setCallback(function()
      if next(self.carbonHandler) then
        for _, tag in pairs(self.carbonHandler) do
          game.role:removeEventListener(tag)
        end
        self.carbonHandler = {}
      end
      self.selected = index
      self:showData()
    end)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(82, 32):addTo(btn)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.moon[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
    end
    btn:center(viewNode):addTo(viewNode)
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.1
  end
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "moon" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.moon[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
    end
  end))
  self.group:chooseByName(string.format("index%d", self.selected))
  self:showExtra()
  self:updateCount()
  self.openId = 1
  for i = 1, table.nums(BattleCsv) do
    local carbonData = BattleCsv[i + CARBON_BEGIN_ID]
    local lock = game:nowTime() < CommonHelper.toUnixtime(carbonData.openTime .. string.format("%02x", RESET_TIME))
    if not lock then
      self.openId = i
    end
  end
  local moon = display.newSprite(MainRes .. string.format("moon_%d.png", math.min(5, self.openId))):pos(900 + self.deltaX, 405):addTo(self.bgNode)
  moon:setOpacity(0)
  moon:runAction(cc.FadeIn:create(0.5))
  local yinghuo = cc.ParticleSystemQuad:create("ui/battle/yinghuo.plist")
  yinghuo:setPositionType(cc.POSITION_TYPE_RELATIVE)
  yinghuo:pos(610, 50):addTo(self.bgNode)
  self.extra:runAction(cc.RepeatForever:create(transition.sequence({
    cc.CallFunc:create(function()
      self:sendLight()
    end),
    cc.DelayTime:create(10)
  })))
end

function MidAutumnMainLayer:showData(params)
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
end

function MidAutumnMainLayer:showExtra()
  display.newSprite(MainRes .. "tuzi.png"):anch(0.5, 0):pos(1000 + self.deltaX, 5):addTo(self.extra)
  local circle2 = display.newSprite(MainRes .. "circle_2.png"):pos(75, 45):addTo(self.extra)
  local circle1 = display.newSprite(MainRes .. "circle_1.png"):pos(20, 30):addTo(self.extra)
  local circle4 = display.newSprite(MainRes .. "circle_4.png"):pos(1150 + self.deltaX, 30):addTo(self.extra)
  local circle3 = display.newSprite(MainRes .. "circle_3.png"):pos(1080 + self.deltaX, 45):addTo(self.extra)
  circle2:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 30)))
  circle1:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, -40)))
  circle4:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 40)))
  circle3:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, -30)))
  local flowerBg = UIHelper.newImageView(MainRes .. "flower_num_bg.png"):pos(785, 580):addTo(self.extra)
  display.newSprite(MainRes .. "flower.png"):scale(0.45):pos(0, 13):addTo(flowerBg)
  self.count = display.newTTFLabel({text = "", size = 22}):pos(75, 14):addTo(flowerBg)
  local btnInfo = UIHelper.newImageView(MainRes .. "btn_info.png"):pos(965, 581):addTo(self.extra)
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = "ui/autumn/main/rule.png"
    })
  end)
  self.limit = display.newTTFLabel({
    text = "",
    size = 16,
    color = UIHelper.hex2rgb("#fff4b0")
  }):pos(83, 24):addTo(btnInfo)
end

function MidAutumnMainLayer:showCarbon()
  self.newLayer:removeAllChildren()
  local btnsBg = display.newSprite(CarbonRes .. "btns_bg.png"):anch(0.5, 0):pos(430 + self.deltaX, 0):addTo(self.newLayer)
  local detailBg = display.newSprite(CarbonRes .. "carbon_bg.png"):pos(360 + self.deltaX, 320):addTo(self.newLayer)
  local btns = {}
  local redData = game.role.redPoints.moon.carbonGift or {}
  local group = MRadioGroup:create()
  local xPos, yPos, delay = 80, 44, 0.3
  local selected = game.role.moonBattle.carbonId or game.role.lastMoonCarbonId or CARBON_BEGIN_ID + self.openId
  local nowTimeStr = CommonHelper.date(nil, "Ymd", true)
  for index = 1, table.nums(BattleCsv) do
    local carbonData = BattleCsv[index + CARBON_BEGIN_ID]
    local btn = UIHelper.extend(ccui.Button:create())
    local lock = game:nowTime() < CommonHelper.toUnixtime(carbonData.openTime .. string.format("%02x", RESET_TIME))
    if not lock then
      btn:setImages(CarbonRes, {
        string.format("btn%d_a.png", index),
        string.format("btn%d_b.png", index)
      })
      btn:setName(string.format("map%d", carbonData.id))
      btn:setGroup(group)
      btn:setCallback(function()
        self:showCarbonDetail(carbonData.id, detailBg)
      end)
      btns[carbonData.id] = btn
      UIHelper.showRedPoint(btn, redData[carbonData.id], cc.p(12, 6), 0.8)
      if nowTimeStr == carbonData.openTime and not game.role.moonCarbonTip and game.role.midBattleCount:getv(carbonData.id, 0) == 0 then
        local tip = display.newSprite("ui/global/msg_new.png"):scale(0.8):pos(84, 77):addTo(btn)
        tip:runAction(transition.sequence({
          cc.DelayTime:create(5),
          cc.CallFunc:create(function()
            game.role.moonCarbonTip = true
          end),
          cc.RemoveSelf:create()
        }))
      end
    else
      display.newSprite(CarbonRes .. "lock.png"):pos(23, 18):addTo(btn)
      btn:setImages(CarbonRes, {
        string.format("btn%d_a.png", index),
        string.format("btn%d_a.png", index)
      })
      btn:setCallback(function()
        MFlashMsg:show({
          text = string.format(err[index], string.sub(carbonData.openTime, 5, 6), string.sub(carbonData.openTime, 7, 8))
        })
      end)
    end
    if game.role.moonBattle.carbonId == carbonData.id then
      display.newSprite(MainRes .. "battle.png"):anch(0.5, 0):pos(45, 75):addTo(btn)
    end
    btn:pos(xPos, yPos):addTo(btnsBg)
    xPos = xPos + 110
    UIHelper.MoveToUp({
      node = btn,
      delay = delay,
      time = 0.2,
      pos = {0, 120}
    })
    delay = delay + 0.1
  end
  table.insert(self.carbonHandler, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "moon" then
      local redSet = game.role.redPoints.moon.carbonGift or {}
      for red, btn in pairs(btns) do
        local bShow = checkbool(redSet[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
    end
  end))
  self:showCarbonDetail(selected, detailBg, true)
  group:chooseByName("map" .. selected)
end

function MidAutumnMainLayer:showCarbonDetail(mapId, detailBg, animate)
  detailBg:stopAllActions()
  detailBg:pos(340 + self.deltaX, 320)
  detailBg:removeAllChildren()
  local chapterData = BattleCsv[mapId]
  local texts = {
    "区域任务",
    "区域简介",
    "可能掉落"
  }
  local posY = {
    340,
    210,
    115
  }
  for i, y in ipairs(posY) do
    display.newTTFLabel({
      text = texts[i],
      size = 16
    }):enableOutline(UIHelper.hex2rgb("#79664f"), 1):anch(0, 0.5):pos(50, y):addTo(detailBg)
  end
  local valueBg = display.newSprite(CarbonRes .. "battle_bg.png"):anch(1, 0.5):pos(642, 310):addTo(detailBg)
  display.newTTFLabel({
    text = "推荐美味度:" .. chapterData.enterPower,
    size = 20
  }):anch(0, 0.5):pos(20, 13):addTo(valueBg)
  local itemData = chapterData.levelGift:toArray("=", true)
  display.newTTFLabel({
    text = "区域净化奖励：",
    size = 16,
    color = UIHelper.hex2rgb("#bd6713")
  }):anch(0, 0.5):pos(35, 140):addTo(detailBg)
  display.newSprite(CarbonRes .. "small_flower.png"):pos(150, 140):addTo(detailBg)
  display.newTTFLabel({
    text = "X " .. itemData[2],
    size = 16,
    color = UIHelper.hex2rgb("#725c44")
  }):pos(175, 140):addTo(detailBg)
  display.newTTFLabel({
    text = chapterData.desc,
    size = 16,
    color = UIHelper.hex2rgb("#a69c90", 1),
    dimensions = cc.size(600, 40)
  }):anch(0, 1):pos(35, 190):addTo(detailBg)
  local specials = chapterData.special2see:toNumMap()
  local xPos = 80
  for _, itemId in ipairs(chapterData.gift2see:toArray("=", true)) do
    local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.78):pos(xPos, 60):addTo(detailBg)
    if specials[itemId] then
      display.newSprite("ui/carbon/detail/limit.png"):pos(73, 73):addTo(icon)
    end
    xPos = xPos + 78
  end
  local gift = {}
  local all, cur, desc = 0, game.role.midBattleCount:getv(mapId, 0), ""
  for _, data in pairs(GiftPack) do
    if data.unlockLevel == mapId then
      if all < data.conditon then
        all = data.conditon
      end
      table.insert(gift, data)
    end
  end
  table.sort(gift, function(a, b)
    return a.id < b.id
  end)
  local progressBg = display.newSprite(MainRes .. "bar_bg.png"):anch(0, 0.5):pos(60, 235):addTo(detailBg)
  local progressBar = display.newProgressTimer(MainRes .. "bar_red.png", 1):center(progressBg):addTo(progressBg)
  progressBar:setMidpoint(cc.p(0, 0.5))
  progressBar:setBarChangeRate(cc.p(1, 0))
  progressBar:setPercentage(cur / all * 100)
  local longth = progressBg:getContentSize().width
  for _, data in ipairs(gift) do
    desc = data.desc
    local xPos = data.conditon / all * longth
    local di = display.newSprite(CarbonRes .. (cur >= data.conditon and "progress_b.png" or "progress_a.png")):pos(xPos, 7):addTo(progressBg)
    display.newTTFLabel({
      text = data.conditon,
      size = 18
    }):enableOutline(UIHelper.hex2rgb(cur >= data.conditon and "#b2220a" or "#74583b"), 1):pos(12, 18):addTo(di)
    local items = data.gift:toTableArray()
    local image
    if 1 < #items then
      image = UIHelper.newImageView("ui/carbon/chooseTravel/box_5.png"):scale(0.6):pos(xPos, 42):addTo(progressBg)
      image:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    else
      image = ItemIcon.new({
        type = tonumber(items[1][1]),
        count = 0,
        showTip = true
      }):scale(0.48):pos(xPos, 42):addTo(progressBg)
      display.newTTFLabel({
        text = "x" .. items[1][2],
        size = 14,
        color = UIHelper.hex2rgb("#562403")
      }):anch(0, 0.5):pos(xPos + 22, 32):addTo(progressBg)
    end
    if game.role.midAutAreaTask:getv(data.id, 0) == -1 then
      display.newSprite(MainRes .. "had.png"):anch(0.5, 0.5):scale(0.7):pos(xPos, 42):addTo(progressBg)
    elseif cur >= data.conditon then
      local touch = UIHelper.extend(ccui.Layout:create())
      touch:setContentSize(cc.size(63, 60)):anch(0.5, 0.5):pos(xPos, 42):addTo(progressBg)
      touch:setSwallowTouches(true)
      UIHelper.showRedPoint(touch, true, cc.p(18, 15), 0.8)
      touch:setCallback(function()
        game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
          type = 1,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
          UIHelper.removeWaiting()
          display.newSprite(MainRes .. "had.png"):anch(0.5, 0.5):scale(0.7):pos(xPos, 42):addTo(progressBg)
          local msg = MsgPack.unpack(event.data)
          touch:removeSelf()
          MedalRewardLayer.new({
            items = msg.reward
          })
          self:updateCount()
        end)
      end)
    end
  end
  display.newTTFLabel({
    text = desc,
    size = 18,
    color = UIHelper.hex2rgb("#725c44")
  }):anch(0, 0.5):pos(42, 311):addTo(detailBg)
  local btnStart = UIHelper.extend(ccui.Button:create())
  btnStart:setImages(CarbonRes, {
    "btn_start.png",
    "btn_start.png"
  })
  btnStart:pos(660, 20):addTo(detailBg)
  btnStart:setTouchScale()
  btnStart:setCallback(function()
    if not game.role:activityIsOpen(16) then
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
    if game.role.moonBattle.carbonId and game.role.moonBattle.carbonId ~= mapId then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if not game.role.moonBattle.carbonId and game.role:isMaxHero() then
      UIHelper.showExtraTip({type = 1, parent = self})
      return
    end
    if game.role.midBattleCount:getv(mapId, 0) == 0 and not game.role.moonBattle.carbonId and chapterData.story1 ~= 0 then
      game:createView("talk.PlotTalkLayer", {
        talkId = chapterData.story1,
        csvNo = chapterData.readcsv or 0,
        onComplete = function()
          game:enterScene("MoonScene", {carbonId = mapId, back = "moon"})
        end
      })
      return
    end
    game:enterScene("MoonScene", {carbonId = mapId})
    game.role.lastMoonCarbonId = mapId
  end)
  if animate then
    UIHelper.MoveToRight({
      node = detailBg,
      pos = {
        900 + self.deltaX,
        0
      },
      delay = 0.1,
      time = 0.3
    })
  end
end

function MidAutumnMainLayer:showTask()
  self.newLayer:removeAllChildren()
  local taskBg = display.newSprite(TaskRes .. "task_bg.png"):pos(360 + self.deltaX, 320):addTo(self.newLayer)
  local list = ccui.ListView:create()
  list:size(cc.size(676, 404))
  list:setInnerContainerSize(cc.size(676, 404))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(24, 27):addTo(taskBg)
  local sortData = {}
  for tempId, _ in pairs(game.role.midAutDailyTask:toNumMap()) do
    local type, id = math.floor(tempId / 1000), tempId % 1000
    local data = TaskCsv[type][id]
    table.insert(sortData, data)
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local cellSize = cc.size(680, 120)
  local rows = math.ceil(#sortData / 2)
  local xPos = 165, 55
  for row = 1, rows do
    xPos = 165
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    for col = 1, 2 do
      local data = sortData[(row - 1) * 2 + col]
      if not data then
        break
      end
      local cell = display.newSprite(TaskRes .. "cell.png"):pos(xPos, 55):addTo(viewNode)
      display.newTTFLabel({
        text = data.desc,
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#984914"), 1):anch(0, 0.5):pos(15, 90):addTo(cell)
      local x = 43
      for itemId, count in pairs(data.gift:toNumMap()) do
        ItemIcon.new({
          type = itemId,
          count = 0,
          showTip = true
        }):scale(0.7):pos(x, 38):addTo(cell)
        display.newTTFLabel({text = count, size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(x + 25, 18):addTo(cell)
        x = x + 70
      end
      local cur = self:getTaskTimes(data.time * 1000 + data.id)
      if data.type == 103 and cur ~= -1 then
        cur = game.role.items[17] or 0
      end
      local done = cur == -1
      if done then
        display.newSprite(TaskRes .. "image_done.png"):pos(265, 30):addTo(cell)
      else
        display.newTTFLabel({
          text = string.format("%d/%d", cur, data.condition1),
          size = 24,
          color = UIHelper.hex2rgb("#984914")
        }):pos(280, 67):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create())
        if cur < data.condition1 then
          display.newTTFLabel({text = "未完成", size = 18}):enableOutline(UIHelper.hex2rgb("#984914"), 1):pos(48, 17):addTo(btn)
          btn:setImages(TaskRes, {"btn_a.png", "btn_a.png"})
        else
          display.newTTFLabel({text = "领取", size = 18}):enableOutline(UIHelper.hex2rgb("#517100"), 1):pos(48, 17):addTo(btn)
          btn:setImages(TaskRes, {"btn_b.png", "btn_b.png"})
          btn:setCallback(function()
            game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
              type = 2,
              id = data.time * 1000 + data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              btn:removeSelf()
              display.newSprite(TaskRes .. "image_done.png"):pos(265, 30):addTo(cell)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self:updateCount()
            end)
          end)
        end
        btn:pos(280, 30):addTo(cell)
      end
      xPos = xPos + 340
    end
  end
  list:requestDoLayout()
  UIHelper.MoveToRight({
    node = taskBg,
    pos = {
      900 + self.deltaX,
      0
    },
    delay = 0.1,
    time = 0.3
  })
end

function MidAutumnMainLayer:showScore()
  self.newLayer:removeAllChildren()
  local taskBg = display.newSprite(TaskRes .. "task_bg.png"):pos(360 + self.deltaX, 320):addTo(self.newLayer)
  local list = ccui.ListView:create()
  list:size(cc.size(676, 404))
  list:setInnerContainerSize(cc.size(676, 404))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(27, 28):addTo(taskBg)
  local have = game.role.items[17] or 0
  local cellSize = display.newSprite(ScoreRes .. "cell_a.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  for line, Set in ipairs(ScoreCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local bLock = game:nowTime() < CommonHelper.toUnixtime(Set[1].openTime .. string.format("%02x", RESET_TIME))
    local cell = display.newSprite(ScoreRes .. (bLock and "cell_b.png" or "cell_a.png")):center(viewNode):addTo(viewNode)
    if bLock then
      local time = tonumber(Set[1].openTime) % 10000
      local month, day = math.floor(time / 100), time % 100
      local line = display.newSprite(ScoreRes .. "line.png"):pos(333, 102):addTo(cell)
      display.newTTFLabel({
        text = string.format("%d月%d日解锁", month, day),
        size = 20,
        color = UIHelper.hex2rgb("#908d7d")
      }):center(line):addTo(line)
    end
    local xPos, delta = bLock and 90 or 85, bLock and 170 or 167
    for index, data in ipairs(Set) do
      local done = game.role.midAutScoreGift:getv(data.phase * 1000 + data.id, 0)
      local item = data.gift:toArray("=", true)
      if bLock then
        local bg = display.newSprite(ScoreRes .. "item_bg_lock.png"):pos(xPos, 49):addTo(cell)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.7):pos(45, 53):addTo(bg)
        display.newTTFLabel({
          text = data.condition,
          size = 18
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0, 0.5):pos(30, 12):addTo(bg)
      else
        local bg = display.newSprite(ScoreRes .. "item_bg_open.png"):pos(xPos, 57):addTo(cell)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.85):pos(56, 65):addTo(bg)
        display.newTTFLabel({
          text = data.condition,
          size = 18
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0, 0.5):pos(42, 14):addTo(bg)
        if done == -1 then
          display.newSprite(ScoreRes .. "done.png"):pos(57, 40):addTo(bg)
        elseif have >= data.condition then
          local red = display.newSprite(ScoreRes .. "red.png"):pos(57, 40):addTo(bg)
          local touch = UIHelper.extend(ccui.Layout:create())
          touch:setContentSize(cc.size(82, 78)):anch(0.5, 0.5):pos(56, 65):addTo(bg)
          touch:setSwallowTouches(true)
          touch:setCallback(function()
            game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
              type = 3,
              id = data.phase * 1000 + data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              red:setTexture(ScoreRes .. "done.png")
              MedalRewardLayer.new({
                items = msg.reward
              })
              touch:removeSelf()
            end)
          end)
        end
      end
      xPos = xPos + delta
    end
  end
  list:doLayout()
  UIHelper.MoveToRight({
    node = taskBg,
    pos = {
      900 + self.deltaX,
      0
    },
    delay = 0.1,
    time = 0.3
  })
end

function MidAutumnMainLayer:getTaskTimes(id)
  return game.role.midAutDailyTask:getv(id, 0)
end

function MidAutumnMainLayer:updateCount()
  local limitSet
  for _, Set in ipairs(ScoreCsv) do
    if tonumber(CommonHelper.date(nil, "Ymd", true)) >= tonumber(Set[1].openTime) then
      limitSet = Set
    else
      break
    end
  end
  local limit = limitSet and limitSet[#limitSet].condition or 0
  self.limit:setString(string.format("本周上限%d", limit))
  self.count:setString(string.format("%d/%d", game.role.items[17] or 0, limit))
end

function MidAutumnMainLayer:sendLight()
  local num = math.random(1, 3)
  for index = 1, num do
    self:createLight()
  end
end

function MidAutumnMainLayer:createLight()
  local startX, startY = math.random(120, 850), 25
  local endX, endY = startX + math.random(100, 200), 645
  local time = math.random(30, 60)
  local scaleXY = math.random(4, 10) / 10
  if scaleXY < 0.5 then
    time = time + 40
  end
  local light = display.newSprite(MainRes .. "light.png"):scale(scaleXY):pos(startX, startY):addTo(self.bgNode)
  light:runAction(transition.sequence({
    cc.Spawn:create(cc.MoveTo:create(time, cc.p(endX, endY)), cc.ScaleTo:create(time, scaleXY / 2)),
    cc.RemoveSelf:create()
  }))
end

function MidAutumnMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  for _, tag in pairs(self.carbonHandler) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return MidAutumnMainLayer
