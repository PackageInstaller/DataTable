local ItemCsv = require("csvdata.item")
local ScoreCsv = require("csvdata.activity_scoregift")
local CarbonRes = "ui/general/carbon/"
local ScoreRes = "ui/general/score/"
local items = {}
local buys = {
  [47] = 1,
  [48] = 1019
}
local buffs = {47, 48}
local uiData = {
  csbFile = "ui/general/GeneralCarbonLayer.csb",
  widgets = {
    up = "up",
    bgNode = "bgNode",
    heroNode = "heroNode",
    panelNode = "panelNode",
    itemNode = "itemNode",
    btnsNode = "btnsNode",
    extraNode = "extraNode"
  }
}
local GeneralScoreLayer = class("GeneralScoreLayer", UIBase)

function GeneralScoreLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function GeneralScoreLayer:init(params)
  TopBar:show(TopBarType.full, "魂界幻想")
  TopBar:showAnimation(true)
  game:playMusic(31)
  self:initElements()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() - UIHelper.getMoveXForX())
    self.panelNode:setPositionX(self.panelNode:getPositionX() + UIHelper.getMoveXForX())
    self.extraNode:setPositionX(self.extraNode:getPositionX() + UIHelper.getMoveXForX())
    self.itemNode:setPositionX(self.itemNode:getPositionX() + UIHelper.getMoveXForX())
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
    node = self.panelNode,
    time = 0.5,
    pos = {650, 0}
  })
  UIHelper.MoveToLeft({
    node = self.itemNode,
    time = 0.5,
    pos = {350, 0}
  })
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
end

function GeneralScoreLayer:initElements()
  self.mainBg = display.newSprite(ScoreRes .. "main_bg.png"):addTo(self.bgNode)
  self.labels = {}
  local xPos = 30
  for _, itemId in ipairs(items) do
    local bg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):anch(1, 0.5):pos(xPos, -140):addTo(self.itemNode)
    bg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = bg,
        itemType = itemId,
        itemData = ItemCsv[itemId]
      })
    end)
    display.newSprite(ItemCsv[itemId].icon):scale(0.5):pos(17, 18):addTo(bg)
    if buys[itemId] then
      local btnAdd = UIHelper.extend(ccui.Button:create())
      btnAdd:setImages(CarbonRes, {
        "btn_add.png",
        "btn_add.png"
      })
      btnAdd:pos(185, 18):addTo(bg)
      btnAdd:setCallback(function()
        if buys[itemId] == 1 then
          game:createView("shop.CommonItemCountLayer", {
            showType = "moon",
            data = {itemId = itemId},
            callback = function(num)
              game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
                type = 5,
                itemId = itemId,
                count = num
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
                UIHelper.removeWaiting()
                self:updateNum()
                MedalRewardLayer.new({
                  items = {
                    [itemId] = num
                  }
                })
              end)
            end
          })
        else
          game:createView("shop.ShopItemCountLayer", {
            index = buys[itemId],
            func = function()
              self:updateNum()
            end
          })
        end
      end)
    end
    local label = display.newTTFLabel({
      text = game.role.items[itemId] or 0,
      size = 22
    }):pos(104, 19):addTo(bg)
    self.labels[itemId] = label
    xPos = xPos - 220
  end
  self.panelBg1 = display.newSprite(ScoreRes .. "panel_bg_1.png"):pos(-80, 200):addTo(self.panelNode)
  local panelBg2 = display.newSprite(ScoreRes .. "panel_bg_2.png"):pos(-80, -50):addTo(self.panelNode)
  self.list = ccui.ListView:create()
  self.list:size(cc.size(690, 304))
  self.list:setInnerContainerSize(cc.size(690, 304))
  self.list:setClippingEnabled(true)
  self.list:setBounceEnabled(true)
  self.list:anch(0, 0):pos(10, 4):addTo(panelBg2)
  local tLabel = display.newTTFLabel({
    text = "每日任务 00:00:00后刷新",
    size = 20,
    color = UIHelper.hex2rgb("#065855")
  }):anch(0, 0.5):pos(10, 322):addTo(panelBg2)
  local tT = CommonHelper.date(game:nowTime() + 86400)
  local endTime = CommonHelper.time({
    year = tT.year,
    month = tT.month,
    day = tT.day,
    hour = 4
  })
  
  local function refreshTime()
    local left = (endTime - game:nowTime()) % 86400
    if 0 < left then
      tLabel:setString("每日任务 " .. UIHelper.getTimeStr(left) .. "后刷新")
      tLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          refreshTime()
        end)
      }))
    else
      self:initPanel2()
    end
  end
  
  refreshTime()
  local offsetX = 140
  display.newTTFLabel({
    text = globalCsv.Activity60Time,
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#1661a7"), 1):anch(1, 0.5):pos(-300 + offsetX, -465):addTo(self.extraNode)
  local btnJump = UIHelper.extend(ccui.Button:create())
  btnJump:setImages(ScoreRes, {"btn_go.png", "btn_go.png"})
  btnJump:pos(-230 + offsetX, -465):addTo(self.extraNode)
  btnJump:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 6})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "魂界幻想")
      self:updateNum()
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "前往兑换",
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(60, 25):addTo(btnJump)
end

function GeneralScoreLayer:showData(params)
  self:initHero()
  self:initPanel1()
  self:initPanel2()
end

function GeneralScoreLayer:initPanel1()
  self.panelBg1:removeAllChildren()
  local Csv = ScoreCsv[1]
  display.newTTFLabel({
    text = Csv[1].desc,
    size = 20,
    color = UIHelper.hex2rgb("#065855")
  }):anch(0, 0.5):pos(10, 81):addTo(self.panelBg1)
  local barBg = display.newSprite(ScoreRes .. "bar_bg.png"):anch(0, 0.5):pos(15, 40):addTo(self.panelBg1)
  local bar = display.newProgressTimer(ScoreRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  local status = game.role.activityStatus["60"]["1"]
  local all, longth = Csv[#Csv].condition1, bar:getContentSize().width
  local progress = status:getv(#Csv, 0)
  if progress == -1 then
    progress = all
  end
  bar:setPercentage(progress / all * 100)
  for index, data in ipairs(Csv) do
    local xPos = data.condition1 / all * longth - 10
    display.newTTFLabel({
      text = data.condition1 < 10000 and data.condition1 or string.format("%0.1f万", data.condition1 / 10000),
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#1661a7"), 1):pos(xPos, -20):addTo(bar)
    local curNum = status:getv(data.id, 0)
    local btn = UIHelper.newImageView(ScoreRes .. "bar_icon.png"):pos(xPos, 6):addTo(bar)
    if curNum == -1 then
      display.newSprite(ScoreRes .. "image_got.png"):pos(xPos, 6):addTo(bar)
    elseif curNum >= data.condition1 then
      local red = display.newSprite("ui/global/msg_new.png"):anch(0, 0):pos(xPos, 7):addTo(bar)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 60,
          id = data.id,
          part = data.part
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          display.newSprite(ScoreRes .. "image_got.png"):pos(xPos, 6):addTo(bar)
          red:removeSelf()
          btn:setTouchEnabled(false)
          self:updateNum()
          MedalRewardLayer.new({
            items = data.gift:toNumMap()
          })
        end)
      end)
    else
      btn:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    end
  end
end

function GeneralScoreLayer:initPanel2()
  self.list:removeAllChildren()
  local status = game.role.activityStatus["60"]["2"]
  local Csv = ScoreCsv[2]
  local size = display.newSprite(ScoreRes .. "cell_bg.png"):getContentSize()
  local lastTask = {}
  for i = 1, #Csv do
    if status:getv(Csv[i].id, 0) == -1 and Csv[i].after == 0 or status:getv(Csv[i].id, 0) ~= -1 and (status:getv(Csv[i].pre, 0) == -1 or Csv[i].pre == 0) then
      table.insert(lastTask, Csv[i])
    end
  end
  table.sort(lastTask, function(a, b)
    local curA = status:getv(a.id, 0)
    local factorA = curA == -1 and 100000 or curA >= a.condition1 and 0 or 1000
    local curB = status:getv(b.id, 0)
    local factorB = curB == -1 and 100000 or curB >= b.condition1 and 0 or 1000
    return factorA + a.id < factorB + b.id
  end)
  local rows = math.ceil(#lastTask / 2)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(690, size.height):addTo(self.list)
    for col = 1, 2 do
      local data = lastTask[(row - 1) * 2 + col]
      if data then
        local xPos = 178 + (col - 1) * 340
        local cell = display.newSprite(ScoreRes .. "cell_bg.png"):pos(xPos, 50):addTo(viewNode)
        display.newTTFLabel({
          text = data.desc,
          size = 24
        }):enableOutline(UIHelper.hex2rgb("#31709d"), 1):anch(0, 0.5):pos(20, 76):addTo(cell)
        local gift = data.gift:toArray("=", true)
        display.newSprite(ItemCsv[gift[1]].icon):scale(0.5):pos(30, 27):addTo(cell)
        display.newTTFLabel({
          text = "x" .. gift[2],
          size = 24
        }):enableOutline(UIHelper.hex2rgb("#31709d"), 1):anch(0, 0.5):pos(53, 25):addTo(cell)
        local curNum = status:getv(data.id, 0)
        if curNum == -1 then
          display.newSprite(ScoreRes .. "image_done.png"):anch(1, 0.5):pos(320, 23):addTo(cell)
        else
          display.newTTFLabel({
            text = string.format("%d/%d", curNum, data.condition1),
            size = 24,
            color = UIHelper.hex2rgb("#146496")
          }):pos(275, 55):addTo(cell)
          local done = curNum >= data.condition1
          local image = done and "btn_2.png" or "btn_1.png"
          local str = done and "领取" or "前往"
          local color = done and "#517100" or "#4c3605"
          local btn = UIHelper.extend(ccui.Button:create())
          btn:setImages(ScoreRes, {image, image})
          btn:setString({
            text = str,
            size = 20,
            color = UIHelper.hex2rgb("ffffff")
          })
          btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb(color), 1)
          btn:pos(275, 25):addTo(cell):setTouchScale()
          btn:setCallback(function()
            if done then
              game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
                type = 60,
                id = data.id,
                part = data.part
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
                UIHelper.removeWaiting()
                self:initPanel2()
                self:updateNum()
                MedalRewardLayer.new({
                  items = data.gift:toNumMap()
                })
              end)
            else
              CommonHelper.jumpLayer(data.link == 0 and data.type or data.link, function()
                self:hide()
              end, function()
                TopBar:show(TopBarType.full, "魂界幻想")
                self:initPanel2()
                game:playMusic(31)
                self:show()
              end, data.condition2)
            end
          end)
        end
      end
    end
  end
end

function GeneralScoreLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts = {
    [1] = textByKey(globalCsv.Activity60HeroTalk1),
    [2] = textByKey(globalCsv.Activity60HeroTalk2),
    [3] = textByKey(globalCsv.Activity60HeroTalk3)
  }
  local card = UIHelper.newImageView(UIHelper.getCardRes("normal", globalCsv.Activity60HeroUnitId, false)):pos(-30, 0):addTo(self.heroNode)
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

function GeneralScoreLayer:updateNum()
  for itemId, lab in pairs(self.labels) do
    lab:setString(game.role.items[itemId] or 0)
  end
end

function GeneralScoreLayer:onExit()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return GeneralScoreLayer
