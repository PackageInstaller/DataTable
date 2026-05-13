local ShopCsv = require("csvdata.shop_skin")
local ItemCsv = require("csvdata.item")
local DressCsv = require("csvdata.hero_skin")
local UnitCsv = require("csvdata.unit")
local ChargeCsv = require("csvdata.recharge")
local sdkInterface = require("sdk.SDKInterface")
local ShopRes = "ui/shop/main/"
local uiData = {
  csbFile = "ui/shop/ShopDressCountLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    cancel = "cancel",
    confirm = "confirm",
    title = "title"
  }
}
local ShopDressCountLayer = class("ShopDressCountLayer", UIBase)

function ShopDressCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShopDressCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.cancel:setLocalZOrder(10)
  self.has = params.has
  self.func = params.func
  self.title:setString("获取换装")
  if params.has then
    self.cancel:hide()
    self.confirm:setPositionX(350)
    self.confirm:setString({text = "确定"})
    display.newSprite(ShopRes .. "has.png"):pos(605, 225):addTo(self.popAction)
  end
end

function ShopDressCountLayer:showData(params)
  local data = ShopCsv[params.index]
  if data.type == 1 then
    self:showType1(data)
  elseif data.type == 2 then
    self:showType2(data)
  elseif data.type == 3 then
    self:showType3(data)
  elseif data.type == 4 then
    self:showType4(data)
  elseif data.type == 5 then
    self:showType5(data)
  end
  local itemData = ItemCsv[data.itemid]
  local dressData = DressCsv[tonumber(itemData.content)]
  local nameBg = display.newSprite("ui/hero/dress/text_bg.png"):anch(0, 0.5):pos(295, 195):addTo(self.popAction)
  display.newTTFLabel({
    text = dressData.name,
    size = 16,
    color = UIHelper.hex2rgb("#307902")
  }):anch(0, 0.5):pos(15, 15):addTo(nameBg)
  local descBg = display.newSprite("ui/hero/dress/text_bg.png"):anch(0, 0.5):pos(295, 160):addTo(self.popAction)
  display.newTTFLabel({
    text = dressData.desc,
    size = 16,
    color = UIHelper.hex2rgb("#307902")
  }):anch(0, 0.5):pos(15, 15):addTo(descBg)
  if data.liveTip ~= 0 then
    local bg = display.newSprite(ShopRes .. "live2d_mark.png"):anch(0, 0.5):pos(295, 127):addTo(self.popAction)
    display.newTTFLabel({
      text = "live 2D",
      size = 16,
      color = UIHelper.hex2rgb("#a26a3b")
    }):pos(50, 16):addTo(bg)
  end
  if data.effectTip ~= 0 then
    local bg = display.newSprite(ShopRes .. "live2d_mark.png"):anch(0, 0.5):pos(435, 127):addTo(self.popAction)
    display.newTTFLabel({
      text = "技能特效",
      size = 16,
      color = UIHelper.hex2rgb("#a26a3b")
    }):pos(50, 16):addTo(bg)
    if data.liveTip == 0 then
      bg:setPositionX(295)
    end
  end
  display.newSprite("ui/hero/handbook/fazhen.png"):pos(180, 160):addTo(self.popAction)
  display.newSprite(UIHelper.getCardRes("normal", data.hero, false)):scale(0.6):pos(10, 165):addTo(self.popAction)
  local unitSet = UnitCsv[data.hero]
  local spine = UIHelper.createSpineNode(unitSet.type)
  spine:setAnimation(0, "idle", true)
  spine:pos(180, 90):addTo(self.popAction)
end

function ShopDressCountLayer:showType1(data)
  local costData = ItemCsv[data.costId]
  local moneyBg = display.newSprite(ShopRes .. "money_bg.png"):pos(525, 95):addTo(self.popAction)
  display.newSprite(costData.icon):scale(0.42):pos(6, 13):addTo(moneyBg)
  display.newTTFLabel({
    text = data.cost,
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):pos(55, 14):addTo(moneyBg)
  display.newTTFLabel({
    text = "或",
    size = 24,
    color = UIHelper.hex2rgb("#703902")
  }):pos(430, 95):addTo(self.popAction)
  local moneyBg2 = display.newSprite(ShopRes .. "money_bg.png"):pos(355, 95):addTo(self.popAction)
  display.newSprite("ui/global/base_diamond.png"):pos(6, 13):addTo(moneyBg2)
  display.newTTFLabel({
    text = data.diamond,
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):pos(55, 14):addTo(moneyBg2)
  self.cancel:setCallback(function()
    if self.has then
      self:close()
    else
      if (game.role.diamond or 0) < data.diamond then
        UIHelper.showDiamondTip({parent = self})
        return
      end
      game:sendData(actionCodes.Store_itemBuyRpc, MsgPack.pack({
        index = data.id,
        costType = ItemType.Diamond
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_itemBuyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({items = msg})
        self.func()
        self:close()
      end)
    end
  end)
  self.confirm:setCallback(function()
    if self.has then
      self:close()
    else
      if (game.role.items[data.costId] or 0) < data.cost then
        SysError(SYS_ERR_HEROSKIN_SHORTAGE)
        return
      end
      game:sendData(actionCodes.Store_itemBuyRpc, MsgPack.pack({
        index = data.id,
        costType = ItemType.HeroSkin
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_itemBuyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({items = msg})
        self.func()
        self:close()
      end)
    end
  end)
end

function ShopDressCountLayer:showType2(data)
  local chargeData = ChargeCsv[data.rechargeId]
  display.newTTFLabel({
    text = "¥" .. chargeData.rmb,
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0, 0.5):pos(295, 97):addTo(self.popAction)
  self.cancel:setString({text = "取消"})
  self.confirm:setString({text = "购买"})
  self.cancel:setCallback(function()
    self:close()
  end)
  self.confirm:setCallback(function()
    if game.role:checkNotRechargeChannel() then
      return
    end
    if self.has then
      self:close()
    else
      if not game.role:checkCanCharge(chargeData.rmb) then
        return
      end
      game:sendData(actionCodes.Store_rechargeRpc, MsgPack.pack({
        id = chargeData.id,
        chan = CHANNEL_NAME
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_rechargeRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local purchaseData = {
          rechargeData = chargeData,
          order = msg.order,
          diamond = 0
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
            umeng.pay(chargeData.rmb, 20, chargeData.title, 1, chargeData.rmb)
            if msg.diamond > 0 then
              msg.reward[5] = (msg.reward[5] or 0) + msg.diamond
            end
            if next(msg.reward) then
              MedalRewardLayer.new({
                items = msg.reward
              })
            end
          elseif msg.result == "handled" then
          else
            return
          end
          self.func()
          self:close()
        end)
      end)
    end
  end)
end

function ShopDressCountLayer:showType3(data)
  self.cancel:hide()
  self.confirm:setPositionX(350)
  self.confirm:setString({text = "确定"})
  self.confirm:setCallback(function()
    self:close()
  end)
end

function ShopDressCountLayer:showType4(data)
  local moneyBg = display.newSprite(ShopRes .. "money_bg.png"):pos(355, 95):addTo(self.popAction)
  display.newSprite("ui/global/base_diamond.png"):pos(6, 13):addTo(moneyBg)
  display.newTTFLabel({
    text = data.diamond,
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):pos(55, 14):addTo(moneyBg)
  self.cancel:setString({text = "取消"})
  self.confirm:setString({text = "购买"})
  self.cancel:setCallback(function()
    self:close()
  end)
  self.confirm:setCallback(function()
    if self.has then
      self:close()
    else
      if (game.role.diamond or 0) < data.diamond then
        UIHelper.showDiamondTip({parent = self})
        return
      end
      game:sendData(actionCodes.Store_itemBuyRpc, MsgPack.pack({
        index = data.id,
        costType = ItemType.Diamond
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_itemBuyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({items = msg})
        self.func()
        self:close()
      end)
    end
  end)
end

function ShopDressCountLayer:showType5(data)
  local costData = ItemCsv[data.costId]
  local moneyBg = display.newSprite(ShopRes .. "money_bg.png"):pos(355, 95):addTo(self.popAction)
  display.newSprite(costData.icon):scale(0.42):pos(6, 13):addTo(moneyBg)
  display.newTTFLabel({
    text = data.cost,
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):pos(55, 14):addTo(moneyBg)
  self.cancel:setString({text = "取消"})
  self.confirm:setString({text = "购买"})
  self.cancel:setCallback(function()
    self:close()
  end)
  self.confirm:setCallback(function()
    if self.has then
      self:close()
    else
      if (game.role.items[data.costId] or 0) < data.cost then
        SysError(SYS_ERR_HEROSKIN_SHORTAGE)
        return
      end
      game:sendData(actionCodes.Store_itemBuyRpc, MsgPack.pack({
        index = data.id,
        costType = ItemType.HeroSkin
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_itemBuyRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({items = msg})
        self.func()
        self:close()
      end)
    end
  end)
end

return ShopDressCountLayer
