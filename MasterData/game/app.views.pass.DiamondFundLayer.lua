local taskCsv = require("csvdata.diamondfund_task")
local levelCsv = require("csvdata.diamondfund_level")
local rewardCsv = require("csvdata.diamondfund_reward")
local ItemCsv = require("csvdata.item")
local RechargeCsv = require("csvdata.recharge")
local sdkInterface = require("sdk.SDKInterface")
local CtrlCsv = require("csvdata.activity_ctrl")
local RewardRes = "ui/common/reward/"
local passRes = "ui/pass/pass2/"
local activityType = "91"
local DiamondFundLayer = {}
DiamondFundLayer.mainLayer = nil

function DiamondFundLayer:initView(mainLayer, mainNode)
  DiamondFundLayer.mainLayer = mainLayer
  self.mainNode = DiamondFundLayer.mainLayer.diamondNode
  self:init()
end

function DiamondFundLayer:init()
  DiamondFundLayer.mainLayer.bg:setImage(passRes .. "bg.png")
  self.curStatus = game.role.activityStatus[activityType] or {
    level = 1,
    exp = 0,
    status = "",
    reward = ""
  }
  UIHelper.newImageView(passRes .. "bg_2.png"):anch(0, 0):pos(170, 70):addTo(self.mainNode)
  local title = UIHelper.newImageView(passRes .. "title.png"):anch(0, 0):pos(158, 505):addTo(self.mainNode)
  local level = display.newTTFLabel({
    text = self.curStatus.level .. "级",
    size = 40,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(240, 476):addTo(self.mainNode)
  local timeStr = CommonHelper.calculateActRemain()
  self.timerHandler = scheduler.scheduleGlobal(function()
    timeStr = CommonHelper.calculateActRemain()
    if self.timeLabel then
      self.timeLabel:setString("本期剩余时间：" .. timeStr)
    end
  end, 1)
  local dateBg = UIHelper.newImageView(passRes .. "bg_date.png"):anch(0, 0):pos(680, 518):addTo(self.mainNode)
  self.timeLabel = display.newTTFLabel({
    text = "本期剩余时间：" .. timeStr,
    size = 18,
    align = ui.TEXT_ALIGNMENT_CENTER
  }):center(dateBg):addTo(dateBg)
  local barBg = display.newSprite(passRes .. "bar_bg.png"):pos(560, 462):addTo(self.mainNode)
  local bar = display.newProgressTimer(passRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(self.curStatus.exp / levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp * 100)
  local lab = display.newTTFLabel({
    text = string.format("%d/%d", self.curStatus.exp, levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp),
    size = 22,
    align = ui.TEXT_ALIGNMENT_RIGHT
  }):anch(1, 0.5):pos(496, 25):addTo(barBg)
  local desc = display.newTTFLabel({
    text = "完成任务提升基金等级可获得丰厚奖励",
    size = 16,
    color = UIHelper.hex2rgb("#7f706f"),
    align = ui.TEXT_ALIGNMENT_LEFT
  }):anch(0, 0.5):pos(0, 25):addTo(barBg)
  local getExpBtn = UIHelper.extend(ccui.Button:create())
  getExpBtn:setImages(passRes, {
    "btn_getexp.png",
    "btn_getexp.png"
  })
  getExpBtn:pos(887, 475):addTo(self.mainNode)
  getExpBtn:setTouchScale()
  display.newTTFLabel({
    text = "获取经验",
    size = 18,
    color = UIHelper.hex2rgb("#342c2a")
  }):center(getExpBtn):addTo(getExpBtn)
  getExpBtn:setCallback(function()
    local mask, bg = UIHelper.showOnleImgTip(passRes .. "bg_1.png")
    display.newTTFLabel({
      text = "获取经验",
      size = 26
    }):pos(345, 338):addTo(bg)
    local list = ccui.ListView:create()
    list:size(cc.size(676, 290))
    list:setInnerContainerSize(cc.size(676, 290))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(10, 18):addTo(bg)
    local rows = math.ceil(#taskCsv / 2)
    for row = 1, rows do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(676, 108)):addTo(list)
      for col = 1, 2 do
        local xPos = (col - 1) * 334
        local data = taskCsv[(row - 1) * 2 + col]
        if not data then
          break
        end
        local cell = display.newSprite(passRes .. "cell.png"):anch(0, 0.5):pos(xPos, 50):addTo(viewNode)
        display.newTTFLabel({
          text = data.desc,
          size = 22
        }):enableOutline(UIHelper.hex2rgb("#734211"), 2):anch(0, 0.5):pos(18, 75):addTo(cell)
        display.newTTFLabel({
          text = string.format("获得赛季经验值x%s", data.gift),
          size = 18,
          color = UIHelper.hex2rgb("#8e450f")
        }):pos(168, 33):addTo(cell)
      end
    end
    list:requestDoLayout()
  end)
  local cell_title = UIHelper.newImageView(passRes .. "cell_title.png"):anch(0, 0):pos(170, 78):addTo(self.mainNode)
  local rechargeData = RechargeCsv[globalCsv.DiamondFundRechargeId]
  cell_title:setCallback(function()
    if self.curStatus.status == 1 then
      return
    end
    self:showBuyPop()
  end)
  display.newTTFLabel({
    text = "普通基金",
    size = 18,
    color = UIHelper.hex2rgb("#6e5045")
  }):pos(70, 240):addTo(cell_title)
  display.newTTFLabel({
    text = "豪华基金",
    size = 18,
    color = UIHelper.hex2rgb("#6e5045")
  }):pos(70, 62):addTo(cell_title)
  if self.curStatus.status ~= 1 then
    self.notbuy = display.newSprite(passRes .. "lock.png"):pos(70, 30):scale(0.82):addTo(cell_title)
  end
  local size = cc.size(760, 359)
  self.list = ccui.ListView:create()
  self.list:size(size)
  self.list:setInnerContainerSize(size)
  self.list:setClippingEnabled(true)
  self.list:anch(0, 0):pos(311, 78):addTo(self.mainNode)
  self.list:setDirection(2)
  self:initList()
  UIHelper.newImageView(passRes .. "bg_r.png"):anch(0, 0):pos(1042, 66):addTo(self.mainNode)
  display.newSprite(passRes .. "down_title.png"):anch(0, 0):pos(168, 18):addTo(self.mainNode)
  local getAllBtn = UIHelper.extend(ccui.Button:create())
  getAllBtn:setImages(passRes, {
    "btn_get.png",
    "btn_get.png"
  })
  getAllBtn:pos(1004, 36):addTo(self.mainNode)
  getAllBtn:setTouchScale()
  display.newTTFLabel({
    text = "一键领取",
    size = 20,
    color = UIHelper.hex2rgb("#342b2a")
  }):pos(96, 33):addTo(getAllBtn)
  getAllBtn:setCallback(function()
    local canSend = false
    for _, data in pairs(rewardCsv) do
      if data.level <= self.curStatus.level and data.reward ~= "" and self.curStatus.reward:getv(data.id, 0) ~= -1 and (data.need == 0 or self.curStatus.status == 1) then
        canSend = true
        break
      end
    end
    if not canSend then
      SysError(SYS_ERR_PASS_NOTCANGET)
      return
    end
    game:sendData(actionCodes.Activity_diamondFundRewardRpc, MsgPack.pack({all = true, actId = activityType}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_diamondFundRewardRpc, function(event)
      UIHelper.removeWaiting()
      self.curStatus = game.role.activityStatus[activityType]
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self:initList()
    end)
  end)
  if self.curStatus and self.curStatus.status ~= 1 then
    local buyBtn = UIHelper.extend(ccui.Button:create())
    buyBtn:setImages(passRes, {
      "btn_buy.png",
      "btn_buy.png"
    })
    buyBtn:pos(796, 36):addTo(self.mainNode):name("buyBtn")
    buyBtn:setTouchScale()
    display.newTTFLabel({
      text = "￥48 购买",
      size = 20,
      color = UIHelper.hex2rgb("#342b2a")
    }):pos(96, 33):addTo(buyBtn)
    local rechargeData = RechargeCsv[globalCsv.DiamondFundRechargeId]
    buyBtn:setCallback(function()
      if self.curStatus.status == 1 then
        return
      end
      self:showBuyPop()
    end)
  end
end

function DiamondFundLayer:initList(notAni)
  self.list:removeAllChildren()
  self.iconItems = {}
  local sortData = {}
  for _, data in ipairs(rewardCsv) do
    if not sortData[data.level] then
      sortData[data.level] = {}
    end
    table.insert(sortData[data.level], #sortData[data.level] + 1, data)
  end
  local index, rewardStatus = 0, self.curStatus.reward or ""
  for idx, set in ipairs(sortData) do
    local getStatus = self:checkCanGet(set)
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(134, 359)):addTo(self.list)
    local cell = UIHelper.newImageView(passRes .. "cell_bg_" .. getStatus .. ".png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = idx .. "级",
      size = 20,
      color = UIHelper.hex2rgb("#3A302E")
    }):anch(0.5, 0.5):pos(67, 335):addTo(cell)
    if idx == 69 then
      print("dd")
    end
    local yPos = 274
    for _, data in ipairs(set) do
      if data.reward ~= "" then
        local gifts = data.reward:toTableArray()
        local offsetY = 0
        self.iconItems[data.id] = {}
        for _, gift in pairs(gifts) do
          local icon = ItemIcon.new({
            type = tonumber(gift[1]),
            count = tonumber(gift[2]),
            showTip = true
          }):scale(0.82):pos(67, yPos + offsetY):addTo(cell)
          table.insert(self.iconItems[data.id], icon)
          local itemData = ItemCsv[tonumber(gift[1])]
          icon.status = rewardStatus:getv(data.id, 0)
          if icon.status ~= -1 and self.curStatus.level >= data.level and (data.need == 0 or self.curStatus.status == 1) then
            if index == 0 then
              index = idx
            end
            local canget = self:showCanGetAni(icon)
            icon:setCallback(function()
              if icon.status == -1 then
                return
              end
              game:sendData(actionCodes.Activity_diamondFundRewardRpc, MsgPack.pack({
                all = false,
                id = data.id,
                actId = activityType
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_diamondFundRewardRpc, function(event)
                UIHelper.removeWaiting()
                self.curStatus = game.role.activityStatus[activityType]
                local msg = MsgPack.unpack(event.data)
                MedalRewardLayer.new({
                  items = msg.reward
                })
                self:initList(true)
              end)
            end)
          end
          if icon.status == -1 then
            display.newSprite(passRes .. "had.png"):center(icon):addTo(icon):scale(0.94)
          end
          if data.need == 1 and self.curStatus.status ~= 1 then
            display.newSprite(passRes .. "lock.png"):pos(5, 88):addTo(icon)
          end
          offsetY = offsetY + 26
          yPos = yPos - 120
        end
      else
        yPos = yPos - 120
      end
    end
  end
  self.list:doLayout()
  if 0 < index then
    self.list:runAction(transition.sequence({
      cc.DelayTime:create(notAni and 0 or 0.1),
      cc.CallFunc:create(function()
        self.list:scrollToItem(index - 1, cc.p(0, 0.5), cc.p(0, 0))
      end)
    }))
  else
    self.list:requestDoLayout()
  end
end

function DiamondFundLayer:sendBuyMsg(rechargeData, _callBack)
  if not game.role:checkCanCharge(rechargeData.rmb) then
    return
  end
  if self.curStatus.status == 1 then
    return
  end
  game:sendData(actionCodes.Store_rechargeRpc, MsgPack.pack({
    id = rechargeData.id,
    chan = CHANNEL_NAME
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Store_rechargeRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local purchaseData = {
      rechargeData = rechargeData,
      order = msg.order,
      diamond = rechargeData.diamond
    }
    if game.role:showNewPayLayer(CHANNEL_NAME) then
      game:createView("common.RechargeTypeLayer", {
        callback = function(rtype)
          purchaseData.rtype = rtype
          sdkInterface:purchase(purchaseData)
        end
      })
    else
      sdkInterface:purchase(purchaseData)
    end
    game:addResponseHandler(actionCodes.Store_ayncPurchaseRpc, function(event)
      local msg = MsgPack.unpack(event.data)
      if msg.result == "success" then
        if msg.diamond > 0 then
          msg.reward[5] = (msg.reward[5] or 0) + msg.diamond
        end
        if next(msg.reward) then
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
        self.curStatus = game.role.activityStatus[activityType]
        if type(_callBack) == "function" then
          _callBack()
        end
      elseif msg.result == "handled" then
      else
        return
      end
    end)
  end)
end

function DiamondFundLayer:showBuyPop()
  local function loadList(rewards, list)
    for id, value in pairs(rewards) do
      local viewNode = ccui.Widget:create()
      
      viewNode:setContentSize(cc.size(90, 90)):addTo(list)
      local icon = ItemIcon.new({
        type = id,
        count = value,
        showTip = true
      }):scale(0.88):pos(50, 50):addTo(viewNode)
    end
  end
  
  local mask, bg = UIHelper.showOnleImgTip(passRes .. "buy_pop.png")
  local labelbg = display.newSprite(passRes .. "buy_label.png"):pos(238, 403):addTo(bg)
  local level = display.newTTFLabel({
    text = "购买豪华基金可立即领取",
    size = 20,
    color = UIHelper.hex2rgb("#fbfada")
  }):anch(0, 0):pos(4, 2):addTo(labelbg)
  local size = cc.size(240, 90)
  local list1 = ccui.ListView:create()
  list1:size(size)
  list1:setInnerContainerSize(size)
  list1:setClippingEnabled(true)
  list1:anch(0, 0):pos(122, 270):addTo(bg)
  list1:setDirection(2)
  local reward1 = self:getCanGetReward()
  loadList(reward1, list1)
  list1:doLayout()
  local labelbg = display.newSprite(passRes .. "buy_label.png"):pos(238, 199):addTo(bg)
  local level = display.newTTFLabel({
    text = "购买豪华基金总计可领取",
    size = 20,
    color = UIHelper.hex2rgb("#fbfada")
  }):anch(0, 0):pos(4, 2):addTo(labelbg)
  local list2 = ccui.ListView:create()
  list2:size(size)
  list2:setInnerContainerSize(size)
  list2:setClippingEnabled(true)
  list2:anch(0, 0):pos(122, 66):addTo(bg)
  list2:setDirection(2)
  local reward2 = self:getAllGetReward()
  loadList(reward2, list2)
  list2:doLayout()
  local buyBtn = UIHelper.extend(ccui.Button:create())
  buyBtn:setImages(passRes, {
    "btn_buy.png",
    "btn_buy.png"
  })
  buyBtn:pos(240, 5):addTo(bg)
  buyBtn:setTouchScale()
  display.newTTFLabel({
    text = "￥48 购买",
    size = 20,
    color = UIHelper.hex2rgb("#342b2a")
  }):pos(96, 33):addTo(buyBtn)
  buyBtn:setCallback(function()
    local rechargeData = RechargeCsv[globalCsv.DiamondFundRechargeId]
    self:sendBuyMsg(rechargeData, function()
      if self.notbuy then
        self.notbuy:removeSelf()
        self:initList()
      end
      mask:removeSelf()
      local buyBtn = self.mainNode:getChildByName("buyBtn")
      if buyBtn then
        buyBtn:removeSelf()
      end
    end)
  end)
end

function DiamondFundLayer:getCanGetReward()
  local reward = {}
  for _, data in pairs(rewardCsv) do
    if data.level <= self.curStatus.level and data.need == 1 and data.reward ~= "" and self.curStatus.reward:getv(data.id, 0) ~= -1 then
      local items = data.reward:toTableArray()
      for _, gift in pairs(items) do
        local itemId = tonumber(gift[1])
        local count = tonumber(gift[2])
        if reward[itemId] then
          reward[itemId] = reward[itemId] + count
        else
          reward[itemId] = count
        end
      end
    end
  end
  return reward
end

function DiamondFundLayer:getAllGetReward()
  local reward = {}
  for _, data in pairs(rewardCsv) do
    if data.need == 1 then
      local items = data.reward:toTableArray()
      for _, gift in pairs(items) do
        local itemId = tonumber(gift[1])
        local count = tonumber(gift[2])
        if reward[itemId] then
          reward[itemId] = reward[itemId] + count
        else
          reward[itemId] = count
        end
      end
    end
  end
  return reward
end

function DiamondFundLayer:showCanGetAni(parent)
  local sprite = display.newSprite(passRes .. "canget.png"):scale(0.94):center(parent):addTo(parent)
  local fadeOut = cc.FadeTo:create(1, 120)
  local fadeIn = cc.FadeTo:create(0.5, 255)
  local fadeSequence = cc.Sequence:create(fadeOut, fadeIn)
  local repeatForever = cc.RepeatForever:create(fadeSequence)
  sprite:runAction(repeatForever)
  return sprite
end

function DiamondFundLayer:checkCanGet(setData)
  for _, data in pairs(setData) do
    if self.curStatus.level < data.level then
      return 1
    end
    if data.reward ~= "" and self.curStatus.reward:getv(data.id, 0) == -1 then
      return 3
    end
  end
  return 1
end

function DiamondFundLayer:closeTimerHandler()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return DiamondFundLayer
