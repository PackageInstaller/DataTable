local PriceCsv = require("csvdata.trade_price")
local BuildingCsv = require("csvdata.farm_building")
local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/trade/TradeSellLayer.csb",
  popup = true,
  mask = true,
  widgets = {
    popAction = "popAction",
    node = "node",
    cancel = "cancel",
    slotStr = "slotStr",
    confirm = "confirm"
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
local TradeSellLayer = class("TradeSellLayer", UIBase)

function TradeSellLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TradeSellLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#6d2b15"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#6d2b15"), 1)
end

function TradeSellLayer:showData(params)
  local slot = 0
  local slots = game.role.tradeSellStatus:toNumMap()
  local temp = 0
  for index, value in ipairs(slots) do
    if value == 0 then
      slot = slot + 1
      if temp == 0 then
        temp = index
      end
    end
  end
  self.slotStr:setString(string.format("剩余栏位: %d", slot))
  local items = params.items:toArray("=", true)
  local pyId = items[1]
  local count = items[2]
  local sellData = PriceCsv[pyId]
  local moneyData = moneyType[sellData.currency]
  ItemIcon.new({
    type = sellData.item,
    count = count,
    showTip = true
  }):addTo(self.node)
  display.newTTFLabel({
    text = sellData.name,
    size = 18,
    color = UIHelper.hex2rgb("#7f480c")
  }):pos(0, -58):addTo(self.node)
  display.newTTFLabel({
    text = "已拥有: ",
    size = 18,
    color = UIHelper.hex2rgb("#1f8200")
  }):pos(-15, -90):addTo(self.node)
  display.newTTFLabel({
    text = self:getItemCount(sellData.item),
    size = 18,
    color = UIHelper.hex2rgb("#1f8200")
  }):pos(35, -90):addTo(self.node)
  display.newSprite(moneyData.res):pos(0, -120):addTo(self.node)
  local money = math.floor(sellData.price * count * (100 - globalCsv.tradeTax + BuildingCsv[5][game.role.tradeLevel].taxOff) / 100)
  display.newTTFLabel({
    text = money,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(50, -120):addTo(self.node)
  local autoBattle = params.autoBattle or false
  if UserData.autoBattleLoop == 1 and autoBattle and params.battleType == BattleType.PvE then
    local function autoGiveUp()
      game:sendData(actionCodes.Trade_giveUpRpc, MsgPack.pack({}))
      
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Trade_giveUpRpc, function(event)
        UIHelper.removeWaiting()
        BackManager:pop()
      end)
    end
    
    local time = 5
    self.cancel:setTitleText(string.format("自己用(%d)", time))
    
    local function timeTick()
      self.cancel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          if 0 < time then
            self.cancel:setTitleText(string.format("自己用(%d)", time))
            time = time - 1
            timeTick()
          else
            autoGiveUp()
          end
        end)
      }))
    end
    
    timeTick()
  end
  self.cancel:setCallback(function()
    self:hide()
    MDialog:rich({
      title = "放弃寄售",
      text = "确定放弃寄售？",
      type = 2,
      desc = "(放弃寄售将直接获得奖励物品，无法再次寄售)"
    }, function()
      game:sendData(actionCodes.Trade_giveUpRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Trade_giveUpRpc, function(event)
        UIHelper.removeWaiting()
        local items = {}
        items[sellData.item] = count
        MedalRewardLayer.new({
          items = items,
          callback = function()
            BackManager:pop()
          end
        })
      end)
      return true
    end, function()
      self:show()
      return true
    end)
  end)
  self.confirm:setCallback(function()
    if slot == 0 then
      SysError(SYS_ERR_TRADE_SELL_SLOT_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Trade_sellRpc, MsgPack.pack({pyId = pyId, slot = temp}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Trade_sellRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TRADE_SELL_SUCCESS)
      BackManager:pop()
    end)
  end)
end

function TradeSellLayer:getItemCount(itemId)
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

return TradeSellLayer
