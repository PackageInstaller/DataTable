local ItemCsv = require("csvdata.item")
local ChapterCsv = require("csvdata.moon_chapter_battle")
local TaskCsv = require("csvdata.moon_task")
local CarbonDrawRes = "ui/activity/59/"
local CarbonRes = "ui/general/carbon/"
local NewCarbonRes = "ui/general/newcarbon/"
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
local CARBON_BEGIN_ID = globalCsv.generalFirstBegin
local CARBON_NUMBER = globalCsv.generalFirstNum
local CARBON_MIDDLE_ID = globalCsv.generalSecondBegin
local items = {
  159,
  160,
  158
}
local buys = {
  [159] = 1,
  [160] = 1016
}
local buffs = {159, 160}
local couPonItems = {160}
local btnsData = {
  [1] = {
    name = "冒险区域",
    red = "",
    func = function(self)
      self:showFuncOne()
    end
  },
  [2] = {
    name = "高难挑战",
    red = "",
    func = function(self)
      self:showFuncTwo()
    end
  },
  [3] = {
    name = "活动任务",
    red = "task",
    func = function(self)
      self:showFuncThree()
    end
  }
}
local GeneralCarbonLayer = class("GeneralCarbonLayer", UIBase)

function GeneralCarbonLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function GeneralCarbonLayer:init(params)
  TopBar:show(TopBarType.full, AutumnTitleName)
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
    time = 0.6,
    pos = {650, 0}
  })
  UIHelper.MoveToLeft({
    node = self.itemNode,
    time = 0.6,
    pos = {350, 0}
  })
end

function GeneralCarbonLayer:initElements()
  self.bufferLabels = {}
  self.bufferBtn = {}
  self.mainBg = display.newSprite(CarbonRes .. "main_bg.png"):addTo(self.bgNode)
  if globalCsv.generalCarbonId1 ~= 0 then
    self.bufferCouponLeftBg = UIHelper.newImageView(NewCarbonRes .. "btn_add2_bg.png"):anch(0.5, 0.5):pos(-416, -7):addTo(self.itemNode)
    display.newSprite(ItemCsv[globalCsv.generalCarbonId1].icon):scale(0.5):pos(5, 21):addTo(self.bufferCouponLeftBg)
    self.bufferCouponLeftBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = self.bufferCouponLeftBg,
        itemType = globalCsv.generalCarbonId1,
        itemData = ItemCsv[globalCsv.generalCarbonId1]
      })
    end)
    local couponLabel = display.newTTFLabel({
      text = game.role.items[globalCsv.generalCarbonId1] or 0,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(77, 19):addTo(self.bufferCouponLeftBg)
    self.bufferLabels[globalCsv.generalCarbonId1] = couponLabel
  end
  if globalCsv.generalCarbonId2 ~= 0 then
    self.bufferCouponBigBg = UIHelper.newImageView(CarbonRes .. "btn_add2_bg.png"):anch(0.5, 0.5):pos(-226, -7):addTo(self.itemNode)
    display.newSprite(ItemCsv[globalCsv.generalCarbonId2].icon):scale(0.5):pos(5, 21):addTo(self.bufferCouponBigBg)
    self.bufferCouponBigBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = self.bufferCouponBigBg,
        itemType = globalCsv.generalCarbonId2,
        itemData = ItemCsv[globalCsv.generalCarbonId2]
      })
    end)
    local couponLabel = display.newTTFLabel({
      text = game.role.items[globalCsv.generalCarbonId2] or 0,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(77, 19):addTo(self.bufferCouponBigBg)
    self.bufferLabels[globalCsv.generalCarbonId2] = couponLabel
  end
  if globalCsv.generalCarbonId3 ~= 0 then
    self.bufferCouponSmallBg = UIHelper.newImageView(NewCarbonRes .. "btn_add2_bg.png"):anch(0.5, 0.5):pos(-46, -7):addTo(self.itemNode)
    display.newSprite(ItemCsv[globalCsv.generalCarbonId3].icon):scale(0.8):pos(5, 21):addTo(self.bufferCouponSmallBg)
    self.bufferCouponSmallBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = self.bufferCouponSmallBg,
        itemType = globalCsv.generalCarbonId3,
        itemData = ItemCsv[globalCsv.generalCarbonId3]
      })
    end)
    local couponLabel = display.newTTFLabel({
      text = game.role.items[globalCsv.generalCarbonId3] or 0,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(77, 17):addTo(self.bufferCouponSmallBg)
    self.bufferLabels[globalCsv.generalCarbonId3] = couponLabel
  end
  self.panelBg = display.newSprite(NewCarbonRes .. "panel_bg.png"):pos(17, -30):addTo(self.panelNode)
  self.list = ccui.ListView:create()
  self.list:size(cc.size(500, 425))
  self.list:setInnerContainerSize(cc.size(500, 445))
  self.list:setClippingEnabled(true)
  self.list:setBounceEnabled(true)
  self.list:anch(0.5, 0.5):pos(23, -10):addTo(self.panelNode)
  self.selected = game.role.moonBattleCurType or 1
  self.btns = {}
  self.handlers = {}
  local yPos = -90
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("ffc041"))
      text:enableOutline(UIHelper.hex2rgb("#232323"), 2)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("ffffff"))
      text:enableOutline(UIHelper.hex2rgb("#232323"), 2)
    end
  })
  for idx, data in ipairs(btnsData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(NewCarbonRes, {"btn_a.png", "btn_b.png"})
    btn:pos(0, yPos):addTo(self.btnsNode)
    btn:name("btn" .. idx)
    btn:setCallback(function()
      self.selected = idx
      self:showData()
    end)
    display.newTTFLabel({
      text = data.name,
      size = 28,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(76, 35):addTo(btn):name("name")
    btn:setGroup(self.group)
    btn:setLocalZOrder(-idx)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.general1[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(20, -45), 0.8)
    end
    yPos = yPos - 90
  end
  self.group:chooseByName("btn" .. self.selected)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "general1" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.general1[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(20, -45), 0.8)
      end
    end
  end))
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  display.newTTFLabel({
    text = "自动消耗:",
    size = 23,
    color = UIHelper.hex2rgb("#000000")
  }):anch(1, 0.5):pos(-120, -273):addTo(self.panelNode)
  
  local function updateBuyCheck()
    local useItem = game.role.midBattleCount:getv(1, 0)
    for tempId, btn in pairs(self.bufferBtn) do
      local yes = btn:getChildByName("yes")
      yes:setVisible(useItem == tempId)
    end
  end
  
  local bufferXPos = 70
  for _, itemId in ipairs(buffs) do
    local btn = UIHelper.newImageView(NewCarbonRes .. "btn_use_bg.png"):anch(1, 0.5):pos(bufferXPos, -273):addTo(self.panelNode)
    display.newSprite(ItemCsv[itemId].icon):scale(0.5):pos(58, 22):addTo(btn)
    if buys[itemId] then
      local btnAdd = UIHelper.extend(ccui.Button:create())
      btnAdd:setImages(NewCarbonRes, {
        "btn_add.png",
        "btn_add.png"
      })
      btnAdd:pos(160, 22):addTo(btn)
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
    display.newSprite(NewCarbonRes .. "btn_use_yes.png"):pos(20, 22):addTo(btn):name("yes")
    local bufferLabel = display.newTTFLabel({
      text = game.role.items[itemId] or 0,
      size = 30,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(104, 22):addTo(btn)
    self.bufferLabels[itemId] = bufferLabel
    self.bufferBtn[itemId] = btn
    bufferXPos = bufferXPos + 190
    btn:setCallback(function()
      if (game.role.items[itemId] or 0) < 1 then
        SysError(SYS_ERR_MOON_CARBON_QUAN_NOT_ENOUGH)
        return
      end
      game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({type = 4, itemId = itemId}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
        UIHelper.removeWaiting()
        updateBuyCheck()
      end)
    end)
  end
  updateBuyCheck()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(NewCarbonRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(-610, -460):addTo(self.extraNode)
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "carbon"})
  end)
  local btnJump = UIHelper.extend(ccui.Button:create())
  btnJump:setImages(NewCarbonRes, {
    "btn_extra.png",
    "btn_extra.png"
  })
  btnJump:pos(-610, -375):addTo(self.extraNode)
  btnJump:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 6})
    BackManager:push(function()
      TopBar:show(TopBarType.full, AutumnTitleName)
      self:show()
      self:updateNum()
      layer:close()
    end)
  end)
  UIHelper.MoveToLeft({
    node = btnInfo,
    time = 0.6,
    pos = {650, 0}
  })
  UIHelper.MoveToLeft({
    node = btnJump,
    time = 0.6,
    pos = {650, 0}
  })
end

function GeneralCarbonLayer:doorTicket()
  local bill = UIHelper.newImageView(CarbonRes .. "bill.png"):anch(0.5, 0.5):pos(-50, 440):addTo(self.panelBg)
  local billNum = display.newTTFLabel({
    text = game.role.items[30001] or 0,
    size = 28
  }):pos(133, 27):addTo(bill):enableOutline(UIHelper.hex2rgb("#000000"), 2)
  bill:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 3})
    self:hide()
    BackManager:push(function()
      TopBar:show(TopBarType.full, AutumnTitleName)
      self:show()
      self:updateNum()
      layer:close()
    end)
  end)
end

function GeneralCarbonLayer:showData(params)
  self:initHero()
  btnsData[self.selected].func(self)
end

function GeneralCarbonLayer:getCarbonStatus(chapter)
  local count = game.role.midBattleCount:getv(chapter.id, 0)
  if chapter.openTime ~= "" and game:nowTime() < CommonHelper.toUnixtime(chapter.openTime .. string.format("%02x", RESET_TIME)) then
    return false, count, true
  end
  if chapter.openLevel ~= 0 and game.role.midBattleCount:getv(chapter.openLevel, 0) == 0 then
    return false, count
  end
  return true, count
end

function GeneralCarbonLayer:getTimeStr(str)
  local timeTab = CommonHelper.date(CommonHelper.toUnixtime(str .. "04"))
  return string.format("%d年%d月%d日 开放", timeTab.year, timeTab.month, timeTab.day)
end

function GeneralCarbonLayer:showFuncOne()
  self.panelBg:removeAllChildren()
  self.list:removeAllChildren()
  local sortData = {}
  for idx = 1, CARBON_NUMBER do
    local data = ChapterCsv[CARBON_BEGIN_ID + (idx - 1) * 2]
    if data then
      sortData[idx] = data
    else
      break
    end
  end
  local selected = 0
  local cellSize = cc.size(500, 128)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize.width, cellSize.height):addTo(self.list)
    local cell = UIHelper.newImageView(NewCarbonRes .. "cell_2.png"):center(viewNode):addTo(viewNode)
    local nameText = display.newTTFLabel({
      text = data.name,
      size = 25,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(13, 100):addTo(cell)
    nameText:enableOutline(UIHelper.hex2rgb("#864C21"), 2)
    local text = display.newTTFLabel({
      text = string.format("%d", data.enterPower),
      size = 18,
      color = UIHelper.hex2rgb("#fccd5a")
    }):anch(0.5, 0.5):pos(440, 96):addTo(cell)
    text:enableOutline(UIHelper.hex2rgb("#462917"), 2)
    if data.gift2see == nil or data.gift2see == "" then
    else
      local dropGifts = data.gift2see:toArray("=", true)
      local xPos, yPos = 130, 40
      for i, itemId in ipairs(dropGifts) do
        if 4 < i then
          break
        end
        ItemIcon.new({type = itemId, showTip = true}):scale(0.5):pos(xPos, 40):addTo(cell)
        xPos = xPos + 50
      end
    end
    local open, _, time = self:getCarbonStatus(data)
    if open then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(NewCarbonRes, {
        "btn_battle.png",
        "btn_battle.png"
      })
      btn:pos(400, 41):addTo(cell)
      btn:setCallback(function()
        self:goBattle(data.id)
      end)
      if game.role.moonBattle.carbonId and data.id == game.role.moonBattle.carbonId then
        display.newSprite(CarbonRes .. "battle.png"):pos(450, 65):addTo(cell)
        selected = index
      end
    else
      display.newSprite(NewCarbonRes .. "cell_mask.png"):center(cell):addTo(cell)
      if time then
        display.newTTFLabel({
          text = self:getTimeStr(data.openTime),
          size = 26,
          color = UIHelper.hex2rgb("#ffffff")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):center(cell):addTo(cell)
      elseif data.openLevel ~= 0 then
        local tempData = ChapterCsv[data.openLevel] or {}
        display.newTTFLabel({
          text = string.format("完成 %s 后解锁", tempData.name),
          size = 24,
          color = UIHelper.hex2rgb("#ffffff")
        }):enableOutline(UIHelper.hex2rgb("#3d3d3d"), 2):anch(0.5, 0.5):center(cell):addTo(cell)
      end
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.6), cc.p(0, -0.5))
  end
end

function GeneralCarbonLayer:showFuncTwo()
  self.panelBg:removeAllChildren()
  self.list:removeAllChildren()
  local sortData = {}
  for _, data in pairs(ChapterCsv) do
    if data.id >= CARBON_MIDDLE_ID then
      table.insert(sortData, clone(data))
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local selected = 0
  local cellSize = cc.size(500, 128)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize.width, cellSize.height):addTo(self.list)
    local cell = UIHelper.newImageView(NewCarbonRes .. "cell_2_hard.png"):center(viewNode):addTo(viewNode)
    local nameText = display.newTTFLabel({
      text = data.name,
      size = 25,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(13, 100):addTo(cell)
    nameText:enableOutline(UIHelper.hex2rgb("#864C21"), 2)
    local text = display.newTTFLabel({
      text = string.format("%d", data.enterPower),
      size = 18,
      color = UIHelper.hex2rgb("#fccd5a")
    }):anch(0.5, 0.5):pos(440, 96):addTo(cell)
    text:enableOutline(UIHelper.hex2rgb("#462917"), 2)
    if data.gift2see == nil or data.gift2see == "" then
    else
      local dropGifts = data.gift2see:toArray("=", true)
      local xPos, yPos = 130, 40
      for i, itemId in ipairs(dropGifts) do
        if 4 < i then
          break
        end
        ItemIcon.new({type = itemId, showTip = true}):scale(0.5):pos(xPos, 40):addTo(cell)
        xPos = xPos + 50
      end
    end
    local open = self:getCarbonStatus(data)
    if open then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(NewCarbonRes, {
        "btn_battle.png",
        "btn_battle.png"
      })
      btn:pos(400, 41):addTo(cell)
      btn:setCallback(function()
        local billNum = game.role.items[30001] or 0
        if billNum < data.bill and data.id ~= game.role.moonBattle.carbonId then
          SysError(SYS_ERR_GENERALCARBON_NOBILL)
        else
          self:goBattle(data.id)
        end
      end)
      if game.role.moonBattle.carbonId and data.id == game.role.moonBattle.carbonId then
        display.newSprite(CarbonRes .. "battle.png"):pos(450, 65):addTo(cell)
        selected = index
      end
    else
      display.newSprite(NewCarbonRes .. "cell_mask.png"):center(cell):addTo(cell)
      if data.openLevel ~= 0 then
        local tempData = ChapterCsv[data.openLevel] or {}
        display.newTTFLabel({
          text = string.format("通关关卡%s后开放", tempData.name),
          size = 24,
          color = UIHelper.hex2rgb("#ffffff")
        }):enableOutline(UIHelper.hex2rgb("#3d3d3d"), 2):anch(0.5, 0.5):center(cell):addTo(cell)
      end
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 1), cc.p(0, 1))
  end
end

function GeneralCarbonLayer:showFuncThree()
  self.panelBg:removeAllChildren()
  self.list:removeAllChildren()
  local sortData = {}
  local status = game.role.midAutDailyTask:toNumMap()
  for tempId, value in pairs(status) do
    local type, id = math.floor(tempId / 1000), tempId % 1000
    local data = TaskCsv[type][id]
    if data ~= nil then
      data.factor = value == -1 and tempId + 10000 or value >= data.condition1 and data.id or tempId + 1000
      if data.openTask == 0 or status[type * 1000 + data.openTask] == -1 then
        table.insert(sortData, data)
      end
    end
  end
  table.sort(sortData, function(a, b)
    return a.factor < b.factor
  end)
  local cellSize = cc.size(500, 128)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(NewCarbonRes .. "cell_1.png"):center(viewNode):addTo(viewNode)
    local desc = display.newTTFLabel({
      text = data.desc,
      size = 25,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(13, 105):addTo(cell)
    desc:enableOutline(UIHelper.hex2rgb("#3d3d3d"), 2)
    local dataMap = data.gift
    local posX = 50
    for idx, count in pairs(dataMap:toNumMap()) do
      if idx ~= nil then
        ItemIcon.new({
          type = idx,
          count = count,
          showTip = true
        }):scale(0.7):pos(posX, 51):addTo(cell)
      end
      posX = posX + 70
    end
    local cur = status[data.time * 1000 + data.id]
    if cur == -1 then
      display.newSprite(CarbonRes .. "image_done.png"):pos(440, 40):addTo(cell)
    elseif cur < data.condition1 then
      local text = display.newTTFLabel({
        text = string.format("%d/%d", cur, data.condition1),
        size = 24,
        color = UIHelper.hex2rgb("#fccd5a")
      }):anch(0.5, 0.5):pos(420, 96):addTo(cell)
      text:enableOutline(UIHelper.hex2rgb("#462917"), 2)
      if data.condition1 == 0 then
        text:setVisible(false)
      end
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(NewCarbonRes, {"btn_go.png", "btn_go.png"})
      btn:pos(418, 40):addTo(cell)
      btn:setCallback(function()
        if data.type == 101 or data.type == 102 or data.type == 103 or data.type == 201 or data.type == 202 or data.type == 203 then
          if data.condition2 > 1000 and data.condition2 < 2000 then
            self.selected = 1
          elseif data.condition2 > 2000 and data.condition2 < 3000 then
            self.selected = 2
          else
            self.selected = 2
          end
          print("select:", self.selected)
          self.group:chooseByName("btn" .. self.selected)
          self:showData()
          return
        end
        CommonHelper.jumpLayer(data.type, function()
          CommonHelper.playHomeBGM()
          self:hide()
        end, function()
          TopBar:show(TopBarType.full, AutumnTitleName)
          game:playMusic(31)
          self:show()
          self:showFuncThree()
        end, data.condition2)
      end)
    else
      local lab = display.newTTFLabel({
        text = string.format("%d/%d", cur, data.condition1),
        size = 24,
        color = UIHelper.hex2rgb("#fccd5a")
      }):anch(0.5, 0.5):pos(420, 96):addTo(cell)
      lab:enableOutline(UIHelper.hex2rgb("#462917"), 2)
      if data.condition1 == 0 then
        lab:setVisible(false)
      end
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(NewCarbonRes, {
        "btn_get.png",
        "btn_get.png"
      })
      btn:pos(418, 40):addTo(cell)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
          type = 2,
          id = data.time * 1000 + data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          lab:removeSelf()
          btn:removeSelf()
          display.newSprite(CarbonRes .. "image_done.png"):pos(440, 40):addTo(cell)
          self:updateNum()
          self:showFuncThree()
        end)
      end)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
end

function GeneralCarbonLayer:dropTip(dropGiftData, dropspecialData)
  local mask, image = UIHelper.showOnleImgTip(CarbonDrawRes .. "draw_info_bg.png")
  local node1 = display.newNode():pos(76, 395):addTo(image)
  local dropGifts, dropspecial
  if dropGiftData == nil and dropspecialData == nil then
    return
  end
  if dropGiftData == nil then
    return
  else
    dropGifts = dropGiftData:toArray("=", true)
    local xPos, yPos = 6, 0
    for i, itemId in ipairs(dropGifts) do
      if 6 < i then
        break
      end
      ItemIcon.new({type = itemId, showTip = true}):scale(0.8):pos(xPos, 10):addTo(node1)
      xPos = xPos + 110
    end
  end
  if dropspecialData == nil then
    return
  else
    dropspecial = dropspecialData:toArray("=", true)
  end
  local list = ccui.ListView:create()
  list:size(cc.size(690, 306))
  list:setInnerContainerSize(cc.size(690, 306))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(10, 10):addTo(image)
  for row = 1, math.ceil(#dropspecial / 6) do
    xPos = 30
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(690, 90)):addTo(list)
    for i = 1, 6 do
      local itemId = dropspecial[(row - 1) * 6 + i]
      if not itemId then
        break
      end
      ItemIcon.new({type = itemId, showTip = true}):scale(0.8):anch(0, 0.5):pos(xPos, 50):addTo(viewNode)
      xPos = xPos + 110
    end
  end
  list:requestDoLayout()
end

function GeneralCarbonLayer:goBattle(chapterId)
  if not game.role:activityIsOpen(58) then
    SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
    return
  end
  if game.role:getAutoBattleId() then
    SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
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
      if math.floor(game.role.moonBattle.carbonId / 10) ~= math.floor(chapterId / 10) then
        SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
        return
      end
      if game.role.moonBattle.carbonId ~= chapterId then
        SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
        return
      end
    elseif game.role.moonBattle.carbonId ~= chapterId then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
  end
  if not game.role.moonBattle.carbonId and game.role:isMaxHero() then
    UIHelper.showExtraTip({type = 1, parent = self})
    return
  end
  game.role.moonBattleCurType = self.selected
  local chapterData = ChapterCsv[chapterId]
  if game.role.midBattleCount:getv(chapterId, 0) == 0 and not game.role.moonBattle.carbonId and chapterData.story1 ~= 0 then
    game:createView("talk.PlotTalkLayer", {
      talkId = chapterData.story1,
      csvNo = chapterData.readcsv or 0,
      reportSkip = true,
      onComplete = function()
        game:enterScene("MoonScene", {carbonId = chapterId})
      end
    })
    self:close()
    return
  end
  game:enterScene("MoonScene", {carbonId = chapterId})
  self:close()
end

function GeneralCarbonLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = textByKey("general_Hero_1_1"),
    [2] = textByKey("general_Hero_1_2"),
    [3] = textByKey("general_Hero_1_3")
  }
  local texts2 = {
    [1] = textByKey("general_Hero_2_1"),
    [2] = textByKey("general_Hero_2_2"),
    [3] = textByKey("general_Hero_2_3")
  }
  local texts3 = {
    [1] = textByKey("general_Hero_3_1"),
    [2] = textByKey("general_Hero_3_2"),
    [3] = textByKey("general_Hero_3_3")
  }
  local heroGet = globalCsv.generalCarbon_hero_select
  local heroId
  for wday, count in pairs(heroGet:toNumMap()) do
    if wday == self.selected then
      heroId = count
    end
  end
  local texts = self.selected == 1 and texts1 or self.selected == 2 and texts2 or texts3
  local imageSrc = UIHelper.getCardRes("normal", heroId, false)
  local cardUI = heroId
  if self.selected == 1 then
    imageSrc = string.gsub(imageSrc, "lt_n", "hbdhz_n")
  end
  if self.selected == 2 then
    imageSrc = string.gsub(imageSrc, "hyzxjd", "ntkfhz2")
  end
  if self.selected == 3 then
    imageSrc = string.gsub(imageSrc, "mf", "mkkfhz2")
  end
  local card = UIHelper.newImageView(imageSrc):pos(50, -50):addTo(self.heroNode)
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
          maxWidth = 266
        }):pos(20, 107):addTo(self.talkBg)
        label:playAnimation(15, nil, nil)
      end),
      cc.DelayTime:create(5),
      cc.Spawn:create(cc.FadeOut:create(0.5), cc.MoveBy:create(0.5, cc.p(0, 70))),
      cc.RemoveSelf:create()
    }))
  end)
end

function GeneralCarbonLayer:updateNum()
  for itemId, lab in pairs(self.bufferLabels) do
    lab:setString(game.role.items[itemId] or 0)
  end
end

function GeneralCarbonLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return GeneralCarbonLayer
