local ChapterCsv = require("csvdata.moon_chapter_battle")
local TaskCsv = require("csvdata.moon_task")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/palace/main/"
local uiData = {
  csbFile = "ui/palace/PalaceMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    heroNode = "heroNode",
    node = "node",
    countBg1 = "countBg1",
    value1 = "countBg1/value",
    countBg2 = "countBg2",
    value2 = "countBg2/value",
    btnsNode = "btnsNode",
    btn1 = "btnsNode/btn1",
    btn2 = "btnsNode/btn2",
    btn3 = "btnsNode/btn3",
    panel = "panel",
    list = "panel/list",
    btnInfo = "panel/btnInfo",
    btnShop = "panel/btnShop"
  }
}
local btnData = {
  [1] = {
    name = "活动剧情",
    red = "chapter",
    func = function(self)
      self:showCarbon()
    end
  },
  [2] = {
    name = "活动任务",
    red = "taskNormal",
    func = function(self)
      self:showTaskNormal()
    end
  },
  [3] = {
    name = "地宫探险",
    red = "taskSpecial",
    func = function(self)
      self:showTaskSpecial()
    end,
    err = ""
  }
}
local PalaceMainLayer = class("PalaceMainLayer", UIBase)

function PalaceMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PalaceMainLayer:init(params)
  TopBar:show(TopBarType.full, "夏日作战")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() - UIHelper.getMoveXForX())
    self.panel:setPositionX(self.panel:getPositionX() + UIHelper.getMoveXForX())
    self.countBg1:setPositionX(self.countBg1:getPositionX() + UIHelper.getMoveXForX())
    self.countBg2:setPositionX(self.countBg2:getPositionX() + UIHelper.getMoveXForX())
    self.node:setPositionX(self.node:getPositionX() + UIHelper.getMoveXForX())
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
    node = self.panel,
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
  self.countBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg1,
      itemType = 66,
      itemData = ItemCsv[66]
    })
  end)
  self.countBg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg2,
      itemType = 67,
      itemData = ItemCsv[67]
    })
  end)
  self:updateNum()
  self.selected = game.role.moonBattleCurType or 1
  self.handlers = {}
  self.btns = {}
  self.cells = {}
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("ffffff"))
      text:enableOutline(UIHelper.hex2rgb("#5a2b06"), 1)
      sender:scale(1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("d99361"))
      text:enableOutline(UIHelper.hex2rgb("#000000"), 1)
      sender:scale(0.8)
    end
  })
  for i, data in ipairs(btnData) do
    local btn = self["btn" .. i]
    display.newTTFLabel({
      text = data.name,
      size = 26
    }):pos(83, 42):addTo(btn):name("name")
    btn:setName(string.format("index%d", i))
    btn:setGroup(group)
    btn:setCallback(function()
      self.selected = i
      self:showData()
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.palace[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(5, -30), 0.8)
    end
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
    if event.type == "palace" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.palace[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(5, -30), 0.8)
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
      TopBar:show(TopBarType.full, "夏日作战")
      layer:close()
    end)
  end)
  self:requestData()
end

function PalaceMainLayer:showData(params)
  if btnData[self.selected] then
    self.list:removeAllChildren()
    self.node:removeAllChildren()
    btnData[self.selected].func(self)
  end
  self:initHero()
end

function PalaceMainLayer:showCarbon()
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id < 1460 and data.id % 10 == 1 then
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
  local size = cc.size(510, 102)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_1.png"):pos(255, 50):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#8c4d15")
    }):anch(0, 0.5):pos(22, 72):addTo(cell)
    if data.open then
      display.newTTFLabel({
        text = "推荐美味度: " .. data.enterPower,
        size = 18,
        color = UIHelper.hex2rgb("#8c4d15")
      }):anch(0, 0.5):pos(22, 45):addTo(cell)
      display.newTTFLabel({
        text = "净化程度:",
        size = 18,
        color = UIHelper.hex2rgb("#8c4d15")
      }):anch(0, 0.5):pos(22, 22):addTo(cell)
      display.newSprite(MainRes .. "entry_1.png"):pos(435, 25):addTo(cell)
      local mapId = math.floor(data.id / 10)
      local xPos = 120
      if game.role.moonBattle.carbonId and mapId == math.floor(game.role.moonBattle.carbonId / 10) then
        display.newSprite("ui/autumn/main/battle.png"):pos(461, 85):addTo(cell)
        selected = index
      end
      local goalId = 0
      for i = 1, 3 do
        local tempCount = game.role.midBattleCount:getv(mapId * 10 + i, 0)
        display.newSprite(MainRes .. (1 <= tempCount and "tag_done.png" or "tag_bg.png")):pos(xPos, 20):addTo(cell)
        if goalId == 0 and tempCount == 0 then
          goalId = mapId * 10 + i
        end
        xPos = xPos + 25
      end
      if goalId == 0 then
        goalId = mapId * 10 + 3
      end
      cell:setCallback(function()
        self:goBattle(goalId)
      end)
    else
      if data.openTime ~= "" and game:nowTime() < CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME)) then
        local time = CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME))
        local timeT = CommonHelper.date(time, nil, true)
        display.newTTFLabel({
          text = string.format("将于%s年%s月%s日开放", timeT.year, timeT.month, timeT.day),
          size = 18,
          color = UIHelper.hex2rgb("#8c4d15")
        }):anch(0, 0.5):pos(22, 45):addTo(cell)
      elseif data.openLevel ~= 0 then
        local tempData = ChapterCsv[data.openLevel] or {}
        display.newTTFLabel({
          text = string.format("完成 %s 后解锁", tempData.name),
          size = 18,
          color = UIHelper.hex2rgb("#8c4d15")
        }):anch(0, 0.5):pos(22, 45):addTo(cell)
      end
      display.newSprite(MainRes .. "image_lock_1.png"):pos(240, 23):addTo(cell)
      display.newSprite(MainRes .. "lock_mask.png"):center(cell):addTo(cell)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.65), cc.p(0, -0.5))
  end
end

function PalaceMainLayer:showTaskNormal()
  local selected = 0
  local sortData = {}
  self.cells = {}
  for _, data in pairs(TaskCsv) do
    if data.openTime == "" then
      local open, count = self:getTaskStatus(data)
      local temp = clone(data)
      temp.open = open
      temp.count = count
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    local factorA = a.count == -1 and 10000 or 0
    local factorB = b.count == -1 and 10000 or 0
    return a.id + factorA < b.id + factorB
  end)
  local size = cc.size(510, 102)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_2.png"):pos(255, 50):addTo(viewNode)
    if data.open then
      display.newTTFLabel({
        text = data.desc,
        size = 18,
        color = UIHelper.hex2rgb("#54770b")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      local gifts = data.gift:toTableArray()
      if 1 < #gifts then
        local image = UIHelper.newImageView(MainRes .. "image_gift.png"):scale(0.64):pos(365, 46):addTo(cell)
        image:setCallback(function()
          ItemRewardLayer.new({
            items = gifts,
            preView = true,
            ignore = true
          })
        end)
      else
        ItemIcon.new({
          type = tonumber(gifts[1][1]),
          count = tonumber(gifts[1][2]),
          showTip = true
        }):scale(0.64):pos(362, 45):addTo(cell)
      end
      if data.count == -1 then
        display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
      elseif data.count >= data.condition1 then
        local label = display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#54770b")
        }):pos(440, 67):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create())
        btn:setImages(MainRes, {
          "btn_get.png",
          "btn_get.png"
        })
        btn:pos(440, 39):addTo(cell):setTouchScale()
        btn:setString({text = "领取", size = 18})
        btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
        btn:setCallback(function()
          if not game.role:activityIsOpen(42) then
            SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
            return
          end
          game:sendData(actionCodes.Activity_christmasRewardRpc, MsgPack.pack({
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_christmasRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            self:updateNum()
            btn:removeFromParent()
            label:removeFromParent()
            display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
            MedalRewardLayer.new({
              items = msg.reward,
              callback = function()
                self:refresh("#54770b")
              end
            })
          end)
        end)
      else
        display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#54770b")
        }):pos(440, 60):addTo(cell)
        display.newTTFLabel({
          text = "完成进度",
          size = 18,
          color = UIHelper.hex2rgb("#54770b")
        }):pos(440, 38):addTo(cell)
      end
    else
      display.newSprite(MainRes .. "image_lock_2.png"):pos(248, 23):addTo(cell)
      display.newTTFLabel({
        text = data.unlockDesc,
        size = 18,
        color = UIHelper.hex2rgb("#54770b")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      self.cells[data.id] = cell
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.5), cc.p(0, -0.5))
  end
end

function PalaceMainLayer:showTaskSpecial()
  local value = self:getFitValue()
  local barBg = UIHelper.newImageView(MainRes .. "bar_bg.png"):anch(0, 0.5):addTo(self.node)
  local bar = display.newProgressTimer(MainRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(value / globalCsv.ActivityExtraLimit[66] * 100)
  display.newSprite(MainRes .. "bar_frame.png"):center(barBg):addTo(barBg)
  barBg:setRotation(-90)
  barBg:setCallback(function()
    UIHelper.showOnleImgTip(MainRes .. "image_info.png")
  end)
  display.newTTFLabel({
    text = string.format("掉落追加%d", value),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#410604"), 1):anch(0.5, 1):addTo(self.node)
  local selected = 0
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id > 1460 then
      table.insert(sortData, clone(data))
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(510, 102)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_3.png"):pos(255, 50):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 20,
      color = UIHelper.hex2rgb("#8a4992")
    }):anch(0, 0.5):pos(20, 72):addTo(cell)
    display.newTTFLabel({
      text = "推荐美味度: " .. data.enterPower,
      size = 18,
      color = UIHelper.hex2rgb("#8a4992")
    }):anch(0, 0.5):pos(20, 47):addTo(cell)
    display.newTTFLabel({
      text = "关卡掉落:",
      size = 18,
      color = UIHelper.hex2rgb("#8a4992")
    }):anch(0, 0.5):pos(20, 25):addTo(cell)
    display.newSprite(MainRes .. "entry_3.png"):pos(435, 25):addTo(cell)
    local xPos = 105
    for _, set in ipairs(data.levelGift:toTableArray()) do
      local bg = display.newSprite(MainRes .. (set[1] == "66" and "small_bg_1.png" or "small_bg_2.png")):anch(0, 0.5):pos(xPos, 25):addTo(cell)
      display.newTTFLabel({
        text = "x" .. set[2],
        size = 18,
        color = UIHelper.hex2rgb("#8a4992")
      }):pos(42, 15):addTo(bg)
      xPos = xPos + 72
    end
    if data.gift2see ~= "" then
      xPos = 355
      for index, itemId in ipairs(data.gift2see:toArray("=", true)) do
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.65):pos(xPos, 45):addTo(cell)
        xPos = xPos - 65
      end
      display.newSprite(MainRes .. "image_tip.png"):pos(xPos + 7, 45):addTo(cell)
    end
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

function PalaceMainLayer:refresh(color)
  for taskId, cell in pairs(self.cells) do
    local data = TaskCsv[taskId]
    local open, count = self:getTaskStatus(data)
    if open then
      local flash = display.newSprite(MainRes .. "cell_flash.png"):center(cell):addTo(cell)
      flash:setOpacity(0)
      flash:runAction(transition.sequence({
        cc.FadeIn:create(0.4),
        cc.CallFunc:create(function()
          cell:removeAllChildren()
          display.newTTFLabel({
            text = data.desc,
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):anch(0, 0.5):pos(10, 64):addTo(cell)
          local gifts = data.gift:toTableArray()
          if 1 < #gifts then
            local image = UIHelper.newImageView(MainRes .. "image_gift.png"):scale(0.64):pos(365, 46):addTo(cell)
            image:setCallback(function()
              ItemRewardLayer.new({
                items = gifts,
                preView = true,
                ignore = true
              })
            end)
          else
            ItemIcon.new({
              type = tonumber(gifts[1][1]),
              count = tonumber(gifts[1][2]),
              showTip = true
            }):scale(0.64):pos(362, 45):addTo(cell)
          end
          display.newTTFLabel({
            text = count .. "/" .. data.condition1,
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):pos(440, 60):addTo(cell)
          display.newTTFLabel({
            text = "完成进度",
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):pos(440, 38):addTo(cell)
        end),
        cc.FadeOut:create(0.2),
        cc.RemoveSelf:create()
      }))
    end
  end
end

function PalaceMainLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "若是选择主动救济世人，就没办法独善其身了啊，努力去做“正义的一方”吧——要上了！唔……啊啊请稍微等下……在这个地宫里真的是很容易饿啊……",
    [2] = "像风一般潇洒地出现，再在夕阳下潇洒的离开……虽说这里没有夕阳，但是也请加油挑战眼前的难关吧！嗯……在我饿昏过去之前……",
    [3] = "我是僧人，不是乞丐，一切食物都要靠缘分化来呢……啊……啊！这、这个我可以吃的吗！？大感谢！"
  }
  local texts2 = {
    [1] = "这、这些就是罗汉斋师傅开出的修行建议吗？为了让自己成长起来……我会努力的……！",
    [2] = "相较于中秋的苦行而言这些真是轻松多了……请和我一起加油……！嗯嗯，身高超过月饼——也是可以期待的！",
    [3] = "呜……有没有那种能一下子让我变高变大变漂亮的魔法呢……唉？还是资源更重要一些？我……我知道啦！"
  }
  local texts3 = {
    [1] = "你终于来啦！很好，让我看看你能坚持多久吧，蹦的越高的蟋蟀价值也就越高呢~~",
    [2] = "这里可是最深的地狱，没有任何苟存之路的哦？不过你要是哭着脸来求我……说不定我会大发慈悲来帮帮你？",
    [3] = "究竟是“嘲笑你”还是“可怜你”，就要看你的努力了……“这两个没区别”？不是的哦~~虽然都是失败，不过你足够努力的话还是能取悦我的。"
  }
  local heroId = self.selected == 1 and 314 or self.selected == 2 and 308 or 215
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

function PalaceMainLayer:goBattle(id)
  if not game.role:activityIsOpen(42) then
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

function PalaceMainLayer:getCarbonStatus(chapter)
  local res, count = false, game.role.midBattleCount:getv(chapter.id, 0)
  if chapter.openLevel ~= 0 then
    res = game.role.midBattleCount:getv(chapter.openLevel, 0) >= 1
  else
    res = true
  end
  if chapter.openTime ~= "" then
    res = res and game:nowTime() >= CommonHelper.toUnixtime(chapter.openTime .. string.format("%02x", RESET_TIME))
  end
  return res, count
end

function PalaceMainLayer:getTaskStatus(task)
  local count = game.role.midAutAreaTask:getv(task.id, 0)
  if task.openTime ~= "" and game:nowTime() < CommonHelper.toUnixtime(task.openTime .. string.format("%02x", RESET_TIME)) then
    return false, count
  end
  if task.openTask ~= 0 then
    local temp = TaskCsv[task.openTask]
    local tempCount = game.role.midAutAreaTask:getv(temp.id, 0)
    if tempCount ~= -1 then
      return false, count
    end
  end
  return true, count
end

function PalaceMainLayer:getFitValue()
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
  sum = math.min(sum, globalCsv.ActivityExtraLimit[66] or 0)
  return sum
end

function PalaceMainLayer:updateNum()
  self.value1:setString(game.role.items[66] or 0)
  self.value2:setString(game.role.items[67] or 0)
end

function PalaceMainLayer:requestData()
  game.role:requestDinerInfo(function()
    if self.selected == 3 then
      self:showTaskSpecial()
    end
  end)
end

function PalaceMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return PalaceMainLayer
