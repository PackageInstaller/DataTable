local PriceCsv = require("csvdata.trade_price")
local AchieveCsv = require("csvdata.achievement")
local BuildingCsv = require("csvdata.farm_building")
local ItemCsv = require("csvdata.item")
local BuyRes = "ui/trade/buy/"
local SellRes = "ui/trade/sell/"
local BillRes = "ui/trade/bill/"
local HeroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/trade/TradeMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    angel1 = "angel1",
    angel2 = "angel2",
    btnsBg = "btnsBg",
    buyBtn = "buyBtn",
    list = "btnsBg/list",
    content = "contentBg/content"
  }
}
local btnsData = {
  [1] = {
    title = "购买",
    callback = function(self)
      self:showBuy()
    end
  },
  [2] = {
    title = "寄售",
    callback = function(self)
      self:showSell()
    end
  },
  [3] = {
    title = "账单",
    callback = function(self)
      self:showBill()
    end
  }
}
local moneyType = {
  [1] = {
    field = "material1",
    res = "ui/global/base_1.png"
  },
  [2] = {
    field = "material2",
    res = "ui/global/base_2.png"
  },
  [3] = {
    field = "material3",
    res = "ui/global/base_3.png"
  },
  [4] = {
    field = "material4",
    res = "ui/global/base_4.png"
  },
  [5] = {
    field = "diamond",
    res = "ui/global/base_diamond.png"
  }
}
local TradeMainLayer = class("TradeMainLayer", UIBase)

function TradeMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TradeMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.angel1:setPositionX(self.angel1:getPositionX() - UIHelper.getMoveXForX())
    self.angel2:setPositionX(self.angel2:getPositionX() + UIHelper.getMoveXForX())
  end
  TopBar:show(TopBarType.full, "交易所")
  game:playMusic(9)
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToRight({
    node = self.btnsBg,
    delay = 0.3,
    time = 0.2
  })
  self.buyBtn:setTouchScale()
  self.data = BuildingCsv[5][game.role.tradeLevel]
  local btnSize = UIHelper.newImageView(HeroRes .. "taocan_1.png"):getContentSize()
  self.group = MRadioGroup:create()
  local delay = 0.4
  for index = 1, #btnsData do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.list)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(HeroRes, {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:center(viewNode):addTo(viewNode)
    btn:setString({
      text = btnsData[index].title,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:setCallback(function()
      self.buyBtn:hide()
      self.selected = index
      self:showData()
    end)
    btn:setName(string.format("btn%d", index))
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    btn:setGroup(self.group)
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.1
  end
  self.selected = params.selected or 1
  if game.role.tradeBuyNew then
    game.role.tradeBuyNew = nil
    game.role:setRedDirty("trade")
  end
end

function TradeMainLayer:showData(params)
  self.content:removeAllChildren()
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self)
end

function TradeMainLayer:showBuy()
  self.buyBtn:show()
  local buyData = game.role.tradeData.buy
  local xPos, dalt = 4, 200
  for index = 1, 4 do
    local x = xPos + (index - 1) * 230
    local card = display.newSprite(BuyRes .. "card_lock.png"):pos(x, 10):anch(0, 0):addTo(self.content)
    self:showBuyCard(index, buyData[index], card)
  end
  local desc = "高"
  if game.role.tradeData.hot < 100 then
    desc = "低"
  elseif 200 > game.role.tradeData.hot then
    desc = "中"
  end
  local tempBg = UIHelper.newImageView(BuyRes .. "temp_bg.png"):pos(85, 393):addTo(self.content)
  display.newTTFLabel({
    text = "当前活跃度:",
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(100, 23):addTo(tempBg)
  display.newTTFLabel({
    text = desc,
    size = 20,
    color = UIHelper.hex2rgb("#58ef1c")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(170, 23):addTo(tempBg)
  tempBg:setCallback(function()
    game:createView("trade.TradeHotTipLayer")
  end)
  self.buyBtn:setCallback(function()
    game:createView("trade.TradeShowBuyPermitLayer")
  end)
  local btnBg = display.newSprite(BuyRes .. "btn_bg.png"):pos(460, -27):addTo(self.content)
  display.newTTFLabel({
    text = "今日可清空次数：",
    size = 18,
    color = UIHelper.hex2rgb("#bd681d")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(80, 18):addTo(btnBg)
  local leftTimes = display.newTTFLabel({
    text = game.role.dailyTradeReflash,
    size = 18,
    color = UIHelper.hex2rgb("#41ff15")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(150, 18):addTo(btnBg)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(BuyRes, {"btn_a.png", "btn_a.png"})
  btn:pos(225, 18):addTo(btnBg)
  btn:setString({
    text = "清空订单",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  })
  btn:setCallback(function()
    if game.role.dailyTradeReflash < 1 then
      SysError(SYS_ERR_TRADE_REFLASH_NOT_ENOUGH)
      return
    end
    MDialog:double({
      title = "清空订单",
      text = "清空订单后将尝试获取一次新订单（成功获得新订单概率受活跃度影响），确定要清空订单么？",
      okCallback = function()
        game:sendData(actionCodes.Trade_cleanBuyRpc, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Trade_cleanBuyRpc, function(event)
          UIHelper.removeWaiting()
          leftTimes:setString(game.role.dailyTradeReflash)
          game:sendData(actionCodes.Trade_getInfoRpc, MsgPack.pack({}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Trade_getInfoRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            game.role.tradeData = msg
            self:showData()
          end)
        end)
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end)
  btn:setTouchScale()
  btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
end

function TradeMainLayer:showBuyCard(slot, data, card)
  card:removeAllChildren()
  if data then
    card:setTexture(BuyRes .. "card_normal.png")
    if next(data) then
      local priceData = PriceCsv[data.pyId]
      display.newSprite(BuyRes .. "frame_1.png"):pos(123, 247):addTo(card)
      display.newSprite(BuyRes .. "name_bg.png"):pos(123, 155):addTo(card)
      display.newSprite(BuyRes .. "name_bg.png"):pos(123, 120):addTo(card)
      display.newTTFLabel({
        text = "来自神秘主厨的交易订单",
        size = 16,
        color = UIHelper.hex2rgb("#703803")
      }):anch(0, 0.5):pos(33, 155):addTo(card)
      display.newTTFLabel({
        text = "剩余时间:",
        size = 18,
        color = UIHelper.hex2rgb("#703803")
      }):anch(0, 0.5):pos(33, 120):addTo(card)
      local countBg = display.newSprite(BuyRes .. "num_bg.png"):anch(1, 1):pos(235, 353):addTo(card)
      display.newTTFLabel({
        text = "已持有: " .. self:getItemCount(priceData.item),
        size = 16,
        color = UIHelper.hex2rgb("#7f480c")
      }):pos(63, 17):addTo(countBg)
      ItemIcon.new({
        type = priceData.item,
        showTip = true
      }):pos(123, 252):addTo(card)
      display.newTTFLabel({
        text = string.format("%sx%d", priceData.name, data.pyNum),
        size = 18,
        color = UIHelper.hex2rgb("#7f480c")
      }):pos(123, 195):addTo(card)
      local bEnough = true
      if priceData.proof ~= 0 and 1 > (game.role.items[priceData.proof] or 0) then
        bEnough = false
        display.newSprite(BuyRes .. "tip_no.png"):anch(0, 0.5):pos(11, 247):addTo(card)
      end
      local time = display.newTTFLabel({
        text = "00:00:00",
        size = 16,
        color = UIHelper.hex2rgb("#496800")
      }):anch(0, 0.5):pos(130, 120):addTo(card)
      
      local function setTime()
        local left = data.activeTime - game:nowTime()
        if 0 < left then
          time:setString(UIHelper.getTimeStr(left))
          time:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.CallFunc:create(function()
              setTime()
            end)
          }))
        else
          time:setString("00:00:00")
        end
      end
      
      setTime()
      local moneyData = moneyType[priceData.currency]
      local moneyBg = display.newSprite(BuyRes .. "money_bg.png"):pos(127, 80):addTo(card)
      display.newSprite(moneyData.res):pos(3, 13):addTo(moneyBg)
      display.newTTFLabel({
        text = math.ceil(priceData.price * data.pyNum * (1 - self.data.buyOff / 100)),
        size = 20,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 13):addTo(moneyBg)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages("ui/carbon/boss/", {
        "anniu_1.png",
        "anniu_1.png"
      })
      btn:pos(123, 40):addTo(card):setTouchScale()
      btn:setCallback(function()
        if data.activeTime <= game:nowTime() then
          SysError(SYS_ERR_TRADE_BUY_TIME_OUT)
          return
        end
        if not bEnough then
          SysError(SYS_ERR_TRADE_BUY_PERMIT_NOT_ENOUGH)
          return
        end
        if game.role[moneyData.field] < math.ceil(priceData.price * data.pyNum * (1 - self.data.buyOff / 100)) then
          SysError(SYS_ERR_TRADE_BUY_MONEY_NOT_ENOUGH)
          return
        end
        MDialog:double({
          title = "提示",
          text = "是否确定购买此物品？",
          okCallback = function()
            game:sendData(actionCodes.Trade_buyRpc, MsgPack.pack({slot = slot}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Trade_buyRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              if msg.result == 0 then
                local items = {}
                items[priceData.item] = data.pyNum
                game.role.tradeData.buy[slot] = {}
                MedalRewardLayer.new({items = items})
                self:showBuyCard(slot, {}, card)
              else
                SysError(msg.result)
              end
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      end)
      display.newTTFLabel({text = "购买", size = 22}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):center(btn):addTo(btn)
    else
      display.newSprite(BuyRes .. "frame_2.png"):pos(123, 247):addTo(card)
      display.newSprite(BuyRes .. "name_bg.png"):pos(123, 120):addTo(card)
      display.newTTFLabel({
        text = "暂时没有收到交易资讯",
        size = 18,
        color = UIHelper.hex2rgb("#7f480c")
      }):pos(123, 120):addTo(card)
    end
  else
    display.newTTFLabel({
      text = "暂未开放购买栏",
      size = 18,
      color = UIHelper.hex2rgb("#777777")
    }):pos(123, 120):addTo(card)
  end
  self:cardAnimation(card, slot)
end

function TradeMainLayer:cardAnimation(card, slot)
  card:hide()
  local mask = display.newSprite(BuyRes .. "card_mask.png"):anch(0, 0):pos(card:getPosition()):addTo(self.content)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03 * (slot - 1)),
    cc.MoveBy:create(0, cc.p(-8, -8)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(8, 8))),
    cc.CallFunc:create(function()
      card:show()
    end),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

function TradeMainLayer:showSell()
  local sellData = game.role.tradeData.sell
  local list = ccui.ListView:create()
  list:size(cc.size(930, 370))
  list:setInnerContainerSize(cc.size(930, 370))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(13, 0):addTo(self.content)
  local cellSize = display.newSprite(SellRes .. "cell.png"):getContentSize()
  cellSize.width = cellSize.width + 6
  for slot = 1, 4 do
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(list)
    local card = display.newSprite(SellRes .. "cell.png"):center(viewNode):addTo(viewNode)
    self:showSellCard(slot, sellData[slot], card)
  end
  local textBg = display.newSprite(BuyRes .. "text_bg.png"):pos(470, -27):addTo(self.content)
  display.newTTFLabel({
    text = "寄售道具将在寄售时间结束后统一于凌晨4时返还",
    size = 18,
    color = UIHelper.hex2rgb("#a36d44")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):center(textBg):addTo(textBg)
end

function TradeMainLayer:showSellCard(slot, data, card)
  if data then
    if next(data) then
      local priceData = PriceCsv[data.pyId]
      ItemIcon.new({
        type = priceData.item,
        count = data.pyNum,
        showTip = true
      }):pos(55, 53):addTo(card)
      local bg1 = display.newSprite(SellRes .. "normal_bg.png"):anch(0, 0.5):pos(120, 70):addTo(card)
      display.newTTFLabel({
        text = priceData.name,
        size = 24,
        color = UIHelper.hex2rgb("#500303")
      }):anch(0, 0.5):pos(15, 16):addTo(bg1)
      local bg2 = display.newSprite(SellRes .. "normal_bg.png"):anch(0, 0.5):pos(120, 30):addTo(card)
      local moneyData = moneyType[priceData.currency]
      local moneyBg = display.newSprite(BuyRes .. "money_bg.png"):pos(130, 15):addTo(bg2)
      display.newTTFLabel({
        text = "收入: ",
        size = 20,
        color = UIHelper.hex2rgb("#500303")
      }):anch(0, 0.5):pos(15, 15):addTo(bg2)
      display.newSprite(moneyData.res):pos(3, 12):addTo(moneyBg)
      display.newTTFLabel({
        text = math.floor(priceData.price * data.pyNum * (100 - globalCsv.tradeTax + self.data.taxOff) / 100),
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 13):addTo(moneyBg)
      local label = display.newTTFLabel({
        text = "寄售剩余时间: ",
        size = 20,
        color = UIHelper.hex2rgb("#500303")
      }):anch(0, 0.5):pos(590, 53):addTo(card)
      local time = display.newTTFLabel({
        text = "00:00:00",
        size = 20,
        color = UIHelper.hex2rgb("#5f8500")
      }):pos(785, 53):addTo(card)
      
      local function setTime()
        local left = data.activeTime - game:nowTime()
        if 0 < left then
          time:setString(UIHelper.getTimeStr(left))
          time:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.CallFunc:create(function()
              setTime()
            end)
          }))
        else
          label:removeSelf()
          time:removeSelf()
          display.newTTFLabel({
            text = "正在返还中",
            size = 20,
            color = UIHelper.hex2rgb("#500303")
          }):pos(785, 53):addTo(card)
        end
      end
      
      setTime()
    else
      display.newSprite(SellRes .. "icon_normal.png"):pos(55, 53):addTo(card)
      display.newSprite(SellRes .. "normal_bg.png"):pos(465, 50):addTo(card)
      display.newTTFLabel({
        text = "暂无寄售物品",
        size = 24,
        color = UIHelper.hex2rgb("#500303")
      }):pos(430, 52):addTo(card)
    end
  else
    display.newSprite(SellRes .. "lock.png"):pos(455, 60):addTo(card)
    display.newTTFLabel({
      text = "暂未开放寄售栏",
      size = 18,
      color = UIHelper.hex2rgb("#8a6b6b")
    }):pos(455, 20):addTo(card)
  end
end

function TradeMainLayer:showBill()
  local billData = {}
  local list = ccui.ListView:create()
  list:size(cc.size(930, 370))
  list:setInnerContainerSize(cc.size(930, 370))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(13, 0):addTo(self.content)
  local cellSize = display.newSprite(SellRes .. "cell.png"):getContentSize()
  cellSize.width = cellSize.width + 6
  game:sendData(actionCodes.Trade_getInfoRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Trade_getInfoRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    game.role.tradeData = msg
    if next(msg) then
      local temp = msg.log
      for _, data in pairs(temp) do
        table.insert(billData, json.decode(data))
      end
      if next(billData) then
        table.sort(billData, function(a, b)
          return a.time > b.time
        end)
        for _, data in ipairs(billData) do
          local viewNode = ccui.Widget:create()
          viewNode:size(cellSize):addTo(list)
          local card = display.newSprite(SellRes .. "cell.png"):center(viewNode):addTo(viewNode)
          self:showBillCard(data, card)
        end
      else
        local tipBg = display.newSprite("ui/hero/tip_bg.png"):center(list):addTo(list)
        display.newTTFLabel({
          text = "主厨您暂时还是没有账单记录呦",
          size = 26,
          color = UIHelper.hex2rgb("#481203")
        }):pos(445, 130):addTo(tipBg)
      end
      list:requestDoLayout()
    end
  end)
end

function TradeMainLayer:showBillCard(data, card)
  local image = data.buy and "buy.png" or "sell.png"
  local dir1 = data.buy and "花费: " or "收入: "
  local dir2 = data.buy and "购买时间: " or "出售时间: "
  display.newSprite(BillRes .. image):pos(70, 53):addTo(card)
  local priceData = PriceCsv[data.pyId]
  ItemIcon.new({
    type = priceData.item,
    count = data.pyNum,
    showTip = true
  }):pos(190, 53):addTo(card)
  local bg1 = display.newSprite(SellRes .. "normal_bg.png"):anch(0, 0.5):pos(265, 70):addTo(card)
  display.newTTFLabel({
    text = priceData.name,
    size = 24,
    color = UIHelper.hex2rgb("#500303")
  }):anch(0, 0.5):pos(15, 18):addTo(bg1)
  local bg2 = display.newSprite(SellRes .. "normal_bg.png"):anch(0, 0.5):pos(265, 30):addTo(card)
  local moneyData = moneyType[priceData.currency]
  local moneyBg = display.newSprite(BuyRes .. "money_bg.png"):pos(130, 15):addTo(bg2)
  display.newTTFLabel({
    text = dir1,
    size = 20,
    color = UIHelper.hex2rgb("#500303")
  }):anch(0, 0.5):pos(15, 15):addTo(bg2)
  display.newSprite(moneyData.res):pos(3, 12):addTo(moneyBg)
  display.newTTFLabel({
    text = data.price,
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(45, 12):addTo(moneyBg)
  local bg3 = display.newSprite(SellRes .. "normal_bg.png"):anch(0, 0.5):pos(640, 55):addTo(card)
  display.newTTFLabel({
    text = dir2,
    size = 20,
    color = UIHelper.hex2rgb("#500303")
  }):anch(0, 0.5):pos(10, 15):addTo(bg3)
  local time = CommonHelper.date(data.time)
  local timeStr = time.year .. "/" .. time.month .. "/" .. time.day
  display.newTTFLabel({
    text = timeStr,
    size = 20,
    color = UIHelper.hex2rgb("#500303")
  }):pos(148, 15):addTo(bg3)
end

function TradeMainLayer:checkActiveCups()
  local actives = {}
  local ids = {}
  for id, data in pairs(AchieveCsv) do
    local cur, all = game.role.missionTaskStatus:getv(data.id, 0), data.condition2
    if all ~= -1 and 10000 < id and cur >= all then
      local item = data.item:toArray("=", true)
      actives[item[1]] = item[2]
      ids[tostring(data.id)] = 1
    end
  end
  if next(actives) then
    game:sendData(actionCodes.Role_missionRpc, MsgPack.pack({
      ids = json.encode(ids)
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_missionRpc, function(event)
      UIHelper.removeWaiting()
      self:showData()
    end)
  end
end

function TradeMainLayer:getItemCount(itemId)
  local count = 0
  if ItemCsv[itemId].type == ItemType.Hero then
    local type = itemId - ItemStartId.hero
    for _, hero in pairs(game.role.heros) do
      if hero.type == type then
        count = count + 1
      end
    end
  else
    count = game.role.items[itemId] or count
  end
  return count
end

return TradeMainLayer
