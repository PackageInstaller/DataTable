local BattleCsv = require("csvdata.moon_chapter_battle")
local TaskCsv = require("csvdata.loop_activity.newyear_task")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/newyear/firstday/"
local uiData = {
  csbFile = "ui/newyear/FirstDayMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    heroNode = "heroNode",
    btnInfo = "btnInfo",
    btnShop = "btnShop",
    bottom = "bottom",
    countBg1 = "countBg1",
    value1 = "countBg1/value",
    countBg2 = "countBg2",
    value2 = "countBg2/value",
    btnsBg = "btnsBg",
    btn1 = "btnsBg/btn1",
    btn2 = "btnsBg/btn2",
    panel = "panel",
    list = "panel/list"
  }
}
local btnData = {
  [1] = {
    name = "区域",
    red = "",
    func = function(self)
      self:showCarbon()
    end
  },
  [2] = {
    name = "任务",
    red = "task",
    func = function(self)
      self:showTask()
    end
  }
}
local FirstDayMainLayer = class("FirstDayMainLayer", UIBase)

function FirstDayMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FirstDayMainLayer:init(params)
  TopBar:show(TopBarType.full, "开年活动")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX())
    self.bottom:setPositionX(self.bottom:getPositionX() + UIHelper.getMoveXForX())
    self.panel:setPositionX(self.panel:getPositionX() + UIHelper.getMoveXForX())
    self.countBg1:setPositionX(self.countBg1:getPositionX() + UIHelper.getMoveXForX())
    self.countBg2:setPositionX(self.countBg2:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToDown({
    node = self.btnsBg,
    time = 0.5
  })
  UIHelper.MoveToLeft({
    node = self.panel,
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
  display.newSprite(ItemCsv[159].icon):scale(0.6):pos(23, 19):addTo(self.countBg1)
  display.newSprite(ItemCsv[160].icon):scale(0.6):pos(23, 19):addTo(self.countBg2)
  UIHelper.newImageView("ui/christmas/main/btn_add.png"):pos(180, 19):addTo(self.countBg1)
  local btnAdd1 = UIHelper.newMask({
    size = cc.size(50, 30),
    color = "#000000",
    opacity = 0
  })
  btnAdd1:anch(0.5, 0.5):pos(168, 19):addTo(self.countBg1)
  btnAdd1:setTouchEnabled(true)
  btnAdd1:setSwallowTouches(true)
  btnAdd1:setCallback(function()
    game:createView("shop.CommonItemCountLayer", {
      showType = "moon",
      data = {itemId = 159},
      callback = function(num)
        game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
          type = 5,
          itemId = 159,
          count = num
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
          UIHelper.removeWaiting()
          self.value1:setString(game.role.items[159] or 0)
          MedalRewardLayer.new({
            items = {
              [159] = num
            }
          })
        end)
      end
    })
  end)
  UIHelper.newImageView("ui/christmas/main/btn_add.png"):pos(180, 19):addTo(self.countBg2)
  local btnAdd2 = UIHelper.newMask({
    size = cc.size(50, 30),
    color = "#000000",
    opacity = 0
  })
  btnAdd2:anch(0.5, 0.5):pos(168, 19):addTo(self.countBg2)
  btnAdd2:setTouchEnabled(true)
  btnAdd2:setSwallowTouches(true)
  btnAdd2:setCallback(function()
    game:createView("shop.ShopItemCountLayer", {
      index = 1017,
      func = function()
        self.value2:setString(game.role.items[160] or 0)
      end
    })
  end)
  local snow = UIHelper.createSpineNodeByRes("spine/home_skin/sdzc_snow")
  snow:setAnimation(0, "idle", true)
  snow:center(self.mainBg):addTo(self.mainBg)
  self.countBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg1,
      itemType = 159,
      itemData = ItemCsv[159]
    })
  end)
  self.countBg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg2,
      itemType = 160,
      itemData = ItemCsv[160]
    })
  end)
  self.value1:setString(game.role.items[159] or 0)
  self.value2:setString(game.role.items[160] or 0)
  self.selected = 1
  self.handlers = {}
  self.btns = {}
  self.cells = {}
  self.score = {}
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTTFConfig({
        fontFilePath = display.DEFAULT_TTF_FONT,
        fontSize = 30,
        outlineSize = 1
      })
      text:enableOutline(UIHelper.hex2rgb("#ab2d22"), 1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTTFConfig({
        fontFilePath = display.DEFAULT_TTF_FONT,
        fontSize = 24,
        outlineSize = 1
      })
      text:enableOutline(UIHelper.hex2rgb("#784c2f"), 1)
    end
  })
  for i, data in ipairs(btnData) do
    local btn = self["btn" .. i]
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#620707"), 1):pos(79, 38):addTo(btn):name("name")
    btn:setName(string.format("index%d", i))
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.selected = i
      self:showData()
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.firstday[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
    end
  end
  self.group:chooseByName("index" .. self.selected)
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "firstday" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.firstday[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
    end
  end))
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = MainRes .. "image_rule.png"
    })
  end)
  self.btnShop:setTouchScale()
  self.btnShop:setCallback(function()
    game:enterScene("MainScene", {layer = "activity", selected = 55})
  end)
end

function FirstDayMainLayer:showData(params)
  self.bottom:removeAllChildren()
  self:initHero()
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
end

function FirstDayMainLayer:showCarbon()
  self.list:removeAllChildren()
  local selected = 0
  local sortData = {}
  for _, data in pairs(BattleCsv) do
    local open, count, tag = self:getCarbonStatus(data)
    local temp = clone(data)
    temp.open = open
    temp.count = count
    temp.tag = tag
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(510, 98)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height + 4):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_1_lock.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#8e4943"), 2):anch(0, 0.5):pos(20, 74):addTo(cell)
    if data.open then
      cell:setImage(MainRes .. "cell_1_open.png")
      display.newTTFLabel({
        text = string.format("推荐美味度:%d", data.enterPower),
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#8e4943"), 1):anch(0, 0.5):pos(20, 45):addTo(cell)
      display.newTTFLabel({
        text = "净化程度:",
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#8e4943"), 1):anch(0, 0.5):pos(20, 21):addTo(cell)
      if game.role.moonBattle.carbonId and data.id == game.role.moonBattle.carbonId then
        display.newSprite("ui/autumn/main/battle.png"):pos(461, 85):addTo(cell)
        selected = index
      end
      display.newSprite(MainRes .. (data.count >= 1 and "tree_w.png" or "tree_r.png")):pos(135, 21):addTo(cell)
      cell:setCallback(function()
        game:createView("christmas.ChristmasDetailLayer", {
          id = data.id,
          resetBg = MainRes .. "detail_bg.png"
        })
      end)
    else
      display.newSprite(MainRes .. "image_lock.png"):pos(248, 23):addTo(cell)
      cell:setCallback(function()
        if data.tag == 1 then
          MFlashMsg:show({
            text = string.format("请完成%s", BattleCsv[data.openLevel].name)
          })
        elseif data.tag == 2 then
          local opentime = CommonHelper.date(CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME)))
          MFlashMsg:show({
            text = string.format("关卡于%d年%d月%d日%d时开放", opentime.year, opentime.month, opentime.day, opentime.hour)
          })
        end
      end)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.65), cc.p(0, -0.5))
  end
  self:initBuffUse()
end

function FirstDayMainLayer:initBuffUse()
  local items = {159, 160}
  local idx = 1
  local useId = game.role.midBattleCount:getv(1, 0)
  for i, itemId in ipairs(items) do
    if useId == itemId then
      idx = i
    end
  end
  local btn = UIHelper.newImageView(MainRes .. "btn_use_bg.png"):pos(435, 30):addTo(self.bottom)
  
  local function updateUse()
    useId = game.role.midBattleCount:getv(1, 0)
    btn:removeAllChildren()
    display.newSprite(ItemCsv[items[idx]].icon):scale(0.4):pos(132, 22):addTo(btn)
    if useId == items[idx] then
      display.newSprite(MainRes .. "btn_use_yes.png"):pos(23, 24):addTo(btn)
    end
    local btnFlash = UIHelper.newImageView(MainRes .. "btn_flash.png"):pos(175, 20):addTo(btn)
    btnFlash:setCallback(function()
      idx = idx % 2 + 1
      updateUse()
    end)
  end
  
  btn:setCallback(function()
    if (game.role.items[items[idx]] or 0) < 1 then
      SysError(SYS_ERR_MOON_CARBON_QUAN_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
      type = 4,
      itemId = items[idx]
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
      UIHelper.removeWaiting()
      updateUse()
    end)
  end)
  updateUse()
end

function FirstDayMainLayer:showTask()
  self.list:removeAllChildren()
  local selected = 0
  local sortData = {}
  self.cells = {}
  for _, data in pairs(TaskCsv) do
    local temp = clone(data)
    temp.count = game.role.midAutAreaTask:getv(temp.id, 0)
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    local factorA = a.count == -1 and 10000 or a.count >= a.condition1 and 0 or a.id + 5000
    local factorB = b.count == -1 and 10000 or b.count >= b.condition1 and 0 or b.id + 5000
    return a.id + factorA < b.id + factorB
  end)
  local size = cc.size(510, 98)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height + 4):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_1_open.png"):center(viewNode):addTo(viewNode)
    local desc = display.newTTFLabel({
      text = data.desc,
      size = 18,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(10, 64):addTo(cell)
    UIHelper.setMaxWidth(desc, 322)
    local xPos = 362
    for _, set in ipairs(data.gift:toTableArray()) do
      ItemIcon.new({
        type = tonumber(set[1]),
        count = tonumber(set[2]),
        showTip = true
      }):scale(0.64):pos(xPos, 45):addTo(cell)
      xPos = xPos - 65
    end
    if data.count == -1 then
      display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
    elseif data.count >= data.condition1 then
      local label = display.newTTFLabel({
        text = data.count .. "/" .. data.condition1,
        size = 20,
        color = UIHelper.hex2rgb("#ba471a")
      }):pos(440, 65):addTo(cell)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MainRes, {
        "btn_get.png",
        "btn_get.png"
      })
      btn:pos(440, 36):addTo(cell):setTouchScale()
      btn:setString({text = "领取", size = 20})
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
      btn:setCallback(function()
        if not game.role:activityIsOpen(54) then
          SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
          return
        end
        game:sendData(actionCodes.Activity_firstDayRewardRpc, MsgPack.pack({
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_firstDayRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          self:showData()
        end)
      end)
    else
      local desc = display.newTTFLabel({
        text = string.format("进度:%d/%d", data.count, data.condition1),
        size = 20,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(398, 65):addTo(cell)
      UIHelper.setMaxWidth(desc, 88)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MainRes, {"btn_go.png", "btn_go.png"})
      btn:pos(440, 36):addTo(cell):setTouchScale()
      btn:setCallback(function()
        if data.type == 4 then
          self.selected = 1
          self:showData()
          self.group:chooseByName("index" .. self.selected)
        else
          self:showForward(data)
        end
      end)
      display.newTTFLabel({text = "前往", size = 20}):enableOutline(UIHelper.hex2rgb("#984914"), 1):pos(48, 17):addTo(btn)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.5), cc.p(0, -0.5))
  end
end

function FirstDayMainLayer:showForward(data)
  local jumpType = data.type
  local cond = data.type and (data.condition2 ~= 0 and data.condition1 or 0) or data.link
  if data.type == 1 then
    jumpType = 4
    if data.condition1 ~= 0 then
      cond = data.condition1
    end
  elseif data.type == 2 then
    jumpType = 19
  elseif data.type == 3 then
    local toIdx = {
      8,
      4,
      7
    }
    jumpType = toIdx[data.condition1]
  elseif data.type == 4 then
    jumpType = 4
  end
  CommonHelper.jumpLayer(jumpType, function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "开年活动")
    self:show()
    self:showData()
  end, cond)
end

function FirstDayMainLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "不愧是我，新一年里第一个出场——咳咳、你以为我会这么说？才不会！",
    [2] = "圣夜的事情不要在意，毕竟，嘛、这个那个……啊！你看去年是圣诞元旦连在一起过的嘛！所以说新年才是我的主场！",
    [3] = "新年的训练场里好像多了很多新建筑呢……我只是在自言自语，感兴趣的话你自己去问薇琪！"
  }
  local texts2 = {
    [1] = "说到奖励，那就是猫罐头了……啊不，是抽奖券，还需要再去抽一下的说……",
    [2] = "厨房里有很多鱼的味道……看起来可以多去几次！呃……主厨也要去吗？",
    [3] = "为什么在这里出现……鱼香肉丝也不是很懂啦……大概是想年年有鱼、什么的……？"
  }
  local heroId = self.selected == 1 and 213 or 210
  local texts = self.selected == 1 and texts1 or texts2
  local card = UIHelper.newImageView(UIHelper.getCardRes("normal", heroId, false)):pos(80, 0):addTo(self.heroNode)
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
        label:playAnimation(30, nil, nil)
      end),
      cc.DelayTime:create(5),
      cc.Spawn:create(cc.FadeOut:create(0.5), cc.MoveBy:create(0.5, cc.p(0, 70))),
      cc.RemoveSelf:create()
    }))
  end)
end

function FirstDayMainLayer:getCarbonStatus(chapter)
  local res, count = false, game.role.midBattleCount:getv(chapter.id, 0)
  if chapter.openTime ~= "" and game:nowTime() < CommonHelper.toUnixtime(chapter.openTime .. string.format("%02x", RESET_TIME)) then
    return false, count, 2
  end
  if chapter.openLevel ~= 0 and game.role.midBattleCount:getv(chapter.openLevel, 0) == 0 then
    return false, count, 1
  end
  return true, count
end

function FirstDayMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return FirstDayMainLayer
