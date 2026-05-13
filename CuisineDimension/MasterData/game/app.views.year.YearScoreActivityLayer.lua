local ChapterCsv = require("csvdata.moon_chapter_battle")
local ScoreCsv = require("csvdata.moon_scoregift")
local GiftCsv = require("csvdata.once_activity.newyear")
local TaskCsv = require("csvdata.moon_task")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/year/main/"
local uiData = {
  csbFile = "ui/year/YearScoreActivityLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    heroNode = "heroNode",
    btnsNode = "btnsNode",
    countBg1 = "countBg1",
    count1 = "countBg1/count",
    countBg2 = "countBg2",
    count2 = "countBg2/count",
    listBg = "listBg",
    list = "listBg/list",
    node = "listBg/node",
    btnInfo = "btnInfo",
    btnShop = "btnShop"
  }
}
local btnData = {
  [1] = {
    name = "活动任务",
    red = "task",
    func = function(self)
      self:showTaskLayer()
    end
  },
  [2] = {
    name = "积分奖励",
    red = "score",
    func = function(self)
      self:showScoreLayer()
    end
  },
  [3] = {
    name = "明日之梦",
    red = "carbon",
    func = function(self)
      self:showCarbonLayer()
    end
  }
}
local YearScoreActivityLayer = class("YearScoreActivityLayer", UIBase)

function YearScoreActivityLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function YearScoreActivityLayer:init(params)
  TopBar:show(TopBarType.full, AutumnTitleName)
  TopBar:showAnimation(true)
  display.newSprite(MainRes .. "main_icon.png"):pos(5, 20):addTo(self.countBg1)
  display.newSprite(MainRes .. "main_icon_2.png"):pos(5, 20):addTo(self.countBg2)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() - 55)
    self.listBg:setPositionX(self.listBg:getPositionX() + UIHelper.getMoveXForX())
    self.countBg1:setPositionX(self.countBg1:getPositionX() + UIHelper.getMoveXForX())
    self.countBg2:setPositionX(self.countBg2:getPositionX() + UIHelper.getMoveXForX())
    self.btnInfo:setPositionX(self.btnInfo:getPositionX() + UIHelper.getMoveXForX())
    self.btnShop:setPositionX(self.btnShop:getPositionX() + UIHelper.getMoveXForX())
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
    node = self.listBg,
    time = 0.6,
    pos = {600, 0}
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
  UIHelper.MoveToLeft({
    node = self.btnShop,
    time = 0.6,
    pos = {350, 0}
  })
  UIHelper.MoveToLeft({
    node = self.btnInfo,
    time = 0.6,
    pos = {350, 0}
  })
  self.countBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg1,
      itemType = 69,
      itemData = ItemCsv[69]
    })
  end)
  self.countBg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg2,
      itemType = 70,
      itemData = ItemCsv[70]
    })
  end)
  self.selected = game.role.moonBattleCurType or 1
  self.handlers = {}
  self.btns = {}
  self.cells = {}
  self:updateNum()
  self:initTaskData()
  local open = false
  for _, data in pairs(ChapterCsv) do
    if data.openTime ~= "" and game:nowTime() >= CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME)) then
      open = true
      break
    end
  end
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("ffffff"))
      text:enableOutline(UIHelper.hex2rgb("#a34e0f"), 1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("d0d0d0"))
      text:enableOutline(UIHelper.hex2rgb("#67310a"), 1)
    end
  })
  local yPos = -145
  for i, data in ipairs(btnData) do
    local btn = UIHelper.extend(ccui.Button:create()):anch(0, 0):pos(0, yPos):addTo(self.btnsNode)
    btn:setImages(MainRes, {
      "main_btn_a.png",
      "main_btn_b.png"
    })
    if i == 3 and not open then
      display.newTTFLabel({text = "待开放", size = 28}):pos(83, 39):addTo(btn):name("name")
    else
      display.newTTFLabel({
        text = data.name,
        size = 28
      }):pos(83, 39):addTo(btn):name("name")
    end
    btn:setName(string.format("index%d", i))
    btn:setGroup(group)
    btn:setCallback(function()
      if i == 3 and not open then
        group:chooseByName("index" .. self.selected)
        SysError(SYS_ERR_MOON_CARBON_TASK_LIMIT_TIME)
        return
      end
      game.role.moonBattleCurType = nil
      self.selected = i
      self:showData()
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.oneyear[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
    end
    yPos = yPos - 80
  end
  group:chooseByName("index" .. self.selected)
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "oneyear" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.oneyear[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
    end
  end))
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = MainRes .. (self.selected == 3 and "image_rule_2.png" or "image_rule_1.png")
    })
  end)
  self.btnShop:setTouchScale()
  self.btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 4})
    BackManager:push(function()
      TopBar:show(TopBarType.full, AutumnTitleName)
      layer:close()
    end)
  end)
end

function YearScoreActivityLayer:showData(params)
  if btnData[self.selected] then
    self.list:removeAllChildren()
    btnData[self.selected].func(self)
  end
  self.btnShop:setVisible(self.selected == 3)
  self.node:setVisible(self.selected == 1)
  self:initHero()
end

function YearScoreActivityLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "一年以来辛苦了，主厨！我们一起来为晚上的庆典做准备吧~",
    [2] = "嗯，我看看……还需要这些东西这些东西和这些东西……诶？别害怕嘛~都还蛮容易获得的吧？",
    [3] = "劳逸结合很重要呢~就像一口一口吃米饭一样地分解工作，做起来就会轻松又简单哦~"
  }
  local texts2 = {
    [1] = "JUST LIVE MORE！现在正是摘取战果的时刻哟！",
    [2] = "想成为天下无双的胜者？那就给我坚持走到最后！我可不需要半途而废的弱者对我指手画脚哦？",
    [3] = "呃……说些符合现在这个外貌的话吗？我想想……那就——加油哦！主厨~~~再可怜的猫咪也能摇身一变变成凶狠的猎手，不想被抓到遍体鳞伤就请努力加油哦？"
  }
  local texts3 = {
    [1] = "调查各地的传说、怪兽、未知生物、外星人、幽灵……哇！这不是很有意思的吗？快走啦快走啦！",
    [2] = "你问伟大灵魂对这次旅行提供了什么建议……吗？嗯……三文鱼的话，烟熏比刺身吃起来更安全——啊不对！！她说保持乐观很重要……总之快出发啦快出发啦！",
    [3] = "痛痛痛痛痛痛痛痛！不要再戳了啦……不就是刚见面的时候把你放在火上烤了烤吗怎么那么大的报复心呜……"
  }
  local heroId = self.selected == 1 and 99 or self.selected == 2 and 422 or 514
  local texts = self.selected == 1 and texts1 or self.selected == 2 and texts2 or texts3
  local card = UIHelper.newImageView(UIHelper.getCardRes("normal", heroId, false)):pos(60, -20):addTo(self.heroNode)
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
        label:playAnimation(20, nil, nil)
      end),
      cc.DelayTime:create(5),
      cc.Spawn:create(cc.FadeOut:create(0.5), cc.MoveBy:create(0.5, cc.p(0, 70))),
      cc.RemoveSelf:create()
    }))
  end)
end

function YearScoreActivityLayer:showTaskLayer()
  self.list:removeAllChildren()
  local status = game.role.activityStatus["48"].status or ""
  local pageData = self.taskData[self.indexTime[self.indexWeek]]
  local showStr = ""
  for idx, data in ipairs(pageData) do
    if data.pre == 0 then
      showStr = showStr:setv(data.id, 1)
    elseif status:getv(data.pre, 0) == -1 then
      showStr = showStr:delk(data.pre)
      showStr = showStr:setv(data.id, 1)
    end
  end
  local sortData = {}
  for id, _ in pairs(showStr:toNumMap()) do
    table.insert(sortData, TaskCsv[id])
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local cellSize = cc.size(690, 118)
  local rows = math.ceil(#sortData / 2)
  local xPos = 177
  for row = 1, rows do
    xPos = 177
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(self.list)
    for col = 1, 2 do
      local data = sortData[(row - 1) * 2 + col]
      if not data then
        break
      end
      local cell = display.newSprite(MainRes .. "task_cell.png"):pos(xPos, 60):addTo(viewNode)
      display.newTTFLabel({
        text = data.desc,
        size = 20,
        color = UIHelper.hex2rgb("#7a3024")
      }):anch(0, 0.5):pos(10, 90):addTo(cell)
      local x = 30
      for _, data in ipairs(data.gift:toTableArray()) do
        display.newSprite(ItemCsv[tonumber(data[1])].icon):scale(0.4):pos(x, 30):addTo(cell)
        display.newTTFLabel({
          text = "x" .. data[2],
          size = 30,
          color = UIHelper.hex2rgb("#7a3024")
        }):anch(0, 0.5):pos(x + 17, 30):addTo(cell)
        x = x + 85
      end
      local count = status:getv(data.id, 0)
      if count == -1 then
        display.newSprite(MainRes .. "task_image_done.png"):pos(265, 25):addTo(cell)
      else
        display.newTTFLabel({
          text = string.format("%d/%d", count, data.condition1),
          size = 20,
          color = UIHelper.hex2rgb("#7a3024")
        }):pos(280, 60):addTo(cell)
        if count < data.condition1 then
          local btn = display.newSprite(MainRes .. "task_btn_a.png"):pos(280, 25):addTo(cell)
          display.newTTFLabel({text = "未完成", size = 18}):enableOutline(UIHelper.hex2rgb("#984914"), 1):pos(48, 17):addTo(btn)
        else
          local btn = UIHelper.extend(ccui.Button:create()):pos(280, 25):addTo(cell)
          display.newTTFLabel({text = "领取", size = 18}):enableOutline(UIHelper.hex2rgb("#7a3024"), 1):pos(48, 17):addTo(btn)
          btn:setImages(MainRes, {
            "task_btn_b.png",
            "task_btn_b.png"
          })
          btn:setCallback(function()
            game:sendData(actionCodes.Activity_oneYearScoreRpc, MsgPack.pack({
              type = 1,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_oneYearScoreRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              btn:removeSelf()
              display.newSprite(MainRes .. "task_image_done.png"):pos(265, 25):addTo(cell)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self:showData()
              self:updateNum()
            end)
          end)
        end
      end
      xPos = xPos + 340
    end
  end
  self.list:requestDoLayout()
end

function YearScoreActivityLayer:showScoreLayer()
  local status = game.role.activityStatus["48"].gift or ""
  local have = game.role.items[69] or 0
  local selected = 0
  for row, Set in ipairs(ScoreCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(690, 118)):addTo(self.list)
    local bLock = false
    local cell = display.newSprite(MainRes .. (bLock and "score_cell_b.png" or "score_cell_a.png")):center(viewNode):addTo(viewNode)
    if bLock then
      local time = tonumber(Set[1].openTime) % 10000
      local month, day = math.floor(time / 100), time % 100
      local line = display.newSprite(MainRes .. "score_line.png"):pos(333, 102):addTo(cell)
      display.newTTFLabel({
        text = string.format("%d月%d日解锁", month, day),
        size = 20,
        color = UIHelper.hex2rgb("#908d7d")
      }):center(line):addTo(line)
    end
    local xPos, delta = bLock and 90 or 85, bLock and 170 or 167
    for index, data in ipairs(Set) do
      local done = status:getv(data.phase * 1000 + data.id, 0)
      local item = data.gift:toArray("=", true)
      if bLock then
        local bg = display.newSprite(MainRes .. "score_item_bg_lock.png"):pos(xPos, 49):addTo(cell)
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
        local bg = display.newSprite(MainRes .. "score_item_bg_open.png"):pos(xPos, 57):addTo(cell)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.85):pos(59, 65):addTo(bg)
        display.newTTFLabel({
          text = data.condition,
          size = 18
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):pos(62, 13):addTo(bg)
        if done == -1 then
          display.newSprite(MainRes .. "score_red.png"):pos(58, 40):addTo(bg)
        elseif have >= data.condition then
          if selected == 0 then
            selected = row
          end
          local red = display.newSprite(MainRes .. "score_green.png"):pos(58, 40):addTo(bg)
          local touch = UIHelper.extend(ccui.Layout:create())
          touch:setContentSize(cc.size(82, 78)):anch(0.5, 0.5):pos(56, 65):addTo(bg)
          touch:setSwallowTouches(true)
          touch:setCallback(function()
            game:sendData(actionCodes.Activity_oneYearScoreRpc, MsgPack.pack({
              type = 2,
              id = data.phase * 1000 + data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_oneYearScoreRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              red:setTexture(MainRes .. "score_red.png")
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
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 1), cc.p(0, 1))
  end
end

function YearScoreActivityLayer:showCarbonLayer()
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id % 10 == 1 or data.id % 10 == 0 then
      local temp = clone(data)
      temp.open = (temp.openLevel == 0 or 0 < game.role.midBattleCount:getv(temp.openLevel, 0)) and true or false
      temp.count = data.special == 1 and globalCsv.ActivitySpecialClear - game.role.midBattleCount:getv(-data.id, 0) or 1
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    local factorA = a.count > 0 and 10000 or 0
    local factorB = b.count > 0 and 10000 or 0
    return factorA - a.id > factorB - b.id
  end)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cc.size(690, 118)):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "carbon_cell.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 30,
      color = UIHelper.hex2rgb("#7a3024")
    }):anch(0, 0.5):pos(17, 80):addTo(cell)
    display.newTTFLabel({
      text = "推荐美味度: " .. data.enterPower,
      size = 18,
      color = UIHelper.hex2rgb("#fcf7ef")
    }):anch(0, 0.5):pos(17, 52):addTo(cell)
    if data.open then
      display.newSprite(MainRes .. "carbon_circle.png"):pos(515, 56):addTo(cell)
      display.newSprite(MainRes .. "carbon_entry.png"):pos(617, 22):addTo(cell)
      if data.special == 1 then
        display.newTTFLabel({
          text = "本日可净化次数:",
          size = 24,
          color = UIHelper.hex2rgb("#7a3024")
        }):anch(0, 0.5):pos(17, 20):addTo(cell)
        display.newTTFLabel({
          text = data.count,
          size = 24,
          color = UIHelper.hex2rgb("#7a3024")
        }):anch(0, 0.5):pos(200, 20):addTo(cell)
        local gift = data.levelGift:toArray("=", true)
        display.newSprite(ItemCsv[gift[1]].icon):scale(0.8):pos(515, 55):addTo(cell)
        display.newSprite(MainRes .. "carbon_image_drop.png"):pos(430, 75):addTo(cell)
        if game.role.moonBattle.carbonId == data.id then
          self.battle = display.newSprite("ui/autumn/main/battle.png"):pos(461, 95):addTo(cell)
          selected = index
        end
        cell:setCallback(function()
          if data.count < 1 then
            SysError(SYS_ERR_MOON_CARBON_BATTLE_COUNT_NOT_ENOUGH)
            return
          end
          self:goBattle(data.id)
        end)
      else
        display.newTTFLabel({
          text = "净化程度:",
          size = 24,
          color = UIHelper.hex2rgb("#7a3024")
        }):anch(0, 0.5):pos(17, 20):addTo(cell)
        local goalId = 0
        local mapId = math.floor(data.id / 10)
        local xPos = 150
        local able = false
        local state = game.role.midAutAreaTask:getv(mapId, 0)
        local gift = GiftCsv[mapId].gift:toArray("=", true)
        local item = ItemIcon.new({
          type = gift[1],
          count = gift[2]
        }):scale(0.8):pos(515, 55):addTo(cell)
        if game.role.moonBattle.carbonId and mapId == math.floor(game.role.moonBattle.carbonId / 10) and not self.battle then
          self.battle = display.newSprite("ui/autumn/main/battle.png"):pos(461, 95):addTo(cell)
          selected = index
        end
        for i = 1, 3 do
          local tempCount = game.role.midBattleCount:getv(mapId * 10 + i, 0)
          display.newSprite(MainRes .. (1 <= tempCount and "carbon_icon_b.png" or "carbon_icon_a.png")):pos(xPos, 20):addTo(cell)
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
          display.newSprite(MainRes .. "score_red.png"):pos(515, 19):addTo(cell)
        elseif able then
          display.newSprite(MainRes .. "score_green.png"):pos(515, 19):addTo(cell)
          item:setCallback(function()
            game:sendData(actionCodes.Activity_newYearOnceRewardRpc, MsgPack.pack({id = mapId}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_newYearOnceRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              self:showData()
              MedalRewardLayer.new({
                items = msg.reward
              })
            end)
          end)
        end
        cell:setCallback(function()
          self:goBattle(goalId)
        end)
      end
    else
      if data.openLevel ~= 0 then
        local tempData = ChapterCsv[data.openLevel] or {}
        display.newTTFLabel({
          text = string.format("完成 %s 后解锁", tempData.name),
          size = 18,
          color = UIHelper.hex2rgb("#8c4d15")
        }):anch(0, 0.5):pos(17, 22):addTo(cell)
      end
      display.newSprite(MainRes .. "carbon_image_lock.png"):pos(340, 10):addTo(cell)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 1), cc.p(0, 1))
  end
end

function YearScoreActivityLayer:goBattle(id)
  if not game.role:activityIsOpen(49) then
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
    if game.role.moonBattle.carbonId % 10 == 0 and game.role.moonBattle.carbonId ~= id then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if game.role.moonBattle.carbonId % 10 ~= 0 and math.floor(game.role.moonBattle.carbonId / 10) ~= math.floor(id / 10) then
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

function YearScoreActivityLayer:updateNum()
  self.count1:setString(game.role.items[69] or 0)
  self.count2:setString(game.role.items[70] or 0)
end

function YearScoreActivityLayer:initTaskData()
  self.taskData = {}
  self.indexTime = {}
  self.indexWeek = 1
  local btns = {}
  for _, data in ipairs(TaskCsv) do
    if not self.taskData[data.opentime] then
      self.taskData[data.opentime] = {}
      self.indexTime[#self.indexTime + 1] = data.opentime
    end
    table.insert(self.taskData[data.opentime], data)
  end
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#ffffff"))
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#c6c6c6"))
    end
  })
  for i, time in ipairs(self.indexTime) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {
      "week_btn_a.png",
      "week_btn_b.png"
    })
    btn:anch(0, 1):pos((i - 1) * 165, 2):addTo(self.node)
    if game:nowTime() < CommonHelper.toUnixtime(time .. string.format("%02x", RESET_TIME)) then
      local str = string.gsub(time, "2018", "")
      str = string.gsub(str, "09", "09/")
      display.newTTFLabel({
        text = string.format("%s开放", str),
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#4c1203"), 1):pos(75, 22):addTo(btn):name("name")
      btn:setCallback(function()
        SysError(SYS_ERR_MOON_TASK_LIMIT_TIME)
      end)
    else
      display.newTTFLabel({
        text = string.format("第%s周", UIHelper.translateNum(i)),
        size = 28
      }):enableOutline(UIHelper.hex2rgb("#4c1203"), 1):pos(75, 22):addTo(btn):name("name")
      btns[time] = btn
      local bShow = checkbool(game.role.redPoints.oneyear.task and game.role.redPoints.oneyear.task[time])
      UIHelper.showRedPoint(btn, bShow, cc.p(9, 1), 0.5)
      btn:setName("week" .. i)
      btn:setGroup(group)
      btn:setCallback(function()
        self.indexWeek = i
        self:showTaskLayer()
      end)
    end
  end
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "oneyear" then
      for red, btn in pairs(btns) do
        local bShow = checkbool(game.role.redPoints.oneyear.task and game.role.redPoints.oneyear.task[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(9, 1), 0.5)
      end
    end
  end))
  group:chooseByName("week" .. self.indexWeek)
end

function YearScoreActivityLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return YearScoreActivityLayer
