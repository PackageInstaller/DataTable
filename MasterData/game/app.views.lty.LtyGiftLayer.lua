local GiftCsv = require("csvdata.lty.lty_gift")
local ItemCsv = require("csvdata.item")
local ShopCsv = require("csvdata.shop")
local LtyGiftRes = "ui/lty/gift/"
local LtyCarbonRes = "ui/lty/carbon/"
local GlobalRes = "ui/global/"
local ShopRes = "ui/shop/main/"
local ScoreRes = "ui/autumn/score/"
local uiData = {
  csbFile = "ui/lty/LtyGiftLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    panel1 = "panel1",
    heroNode = "panel1/heroNode",
    content = "panel1/contentBg/content",
    normalList = "panel1/contentBg/list",
    normalBtn1 = "panel1/btn1",
    normalBtn2 = "panel1/btn2",
    normalBtn3 = "panel1/btn3",
    normalBtn4 = "panel1/btn4"
  }
}
local btnsNames = {
  [1] = {
    name = "上半场",
    func = function(self)
      self:showGiftLayer(1)
    end
  },
  [2] = {
    name = "下半场",
    func = function(self)
      self:showGiftLayer(2)
    end
  },
  [3] = {
    name = "灵感物质",
    func = function(self)
      self:showGiftLayer(3)
    end
  },
  [4] = {
    name = "禁忌物质",
    func = function(self)
      self:showGiftLayer(4)
    end
  }
}
local LtyGiftLayer = class("LtyGiftLayer", UIBase)

function LtyGiftLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LtyGiftLayer:init(params)
  self.mainBg:setTouchEnabled(true)
  self.mainBg:setSwallowTouches(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  self.mainBg:loadTexture(LtyCarbonRes .. "bj.png")
  TopBar:show(TopBarType.shop, LtyTitleName)
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.selected = params.selected or 1
  local group = MRadioGroup:create({
    chooseCb = function(sender)
    end,
    unchooseCb = function(sender)
    end
  })
  local type2Open
  for _, data in ipairs(GiftCsv) do
    if data.type == 2 then
      type2Open = data.open
    end
  end
  for index, data in ipairs(btnsNames) do
    local btn = self["normalBtn" .. index]
    btn:name("btn" .. index)
    btn:setCallback(function()
      if index == 2 or index == 4 then
        local temp = json.decode(game.role.activityBackStatus)
        local timeData = temp["29"]
        if game:nowTime() < timeData.start + type2Open * 86400 then
          SysError(SYS_ERR_LTY_CARBON_NOT_OPEN)
          group:chooseByName("btn" .. self.selected)
          return
        end
      end
      self.normalList:setDirection(1)
      self.content:removeAllChildren()
      self.selected = index
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#4c1203"), 1):pos(78, 22):addTo(btn):name("text")
    btn:setGroup(group)
  end
  group:chooseByName("btn" .. self.selected)
  local heroCard = UIHelper.newImageView(globalCsv.ltyHeroGiftCardName):pos(110, 0):addTo(self.heroNode):pos(-30, -65)
  heroCard:setCallback(function()
    self:showMoveText(self.heroNode)
  end)
  self:showMoveText(self.heroNode)
end

function LtyGiftLayer:showData(params)
  btnsNames[self.selected].func(self)
end

function LtyGiftLayer:showGiftLayer(type)
  self.normalList:removeAllChildren()
  local coinId = {
    166,
    167,
    166,
    167
  }
  local bg = UIHelper.newImageView("ui/lty/main/icon_num_bg.png"):addTo(self.content)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = coinId[type],
      itemData = ItemCsv[coinId[type]]
    })
  end)
  display.newSprite(ItemCsv[coinId[type]].icon):scale(0.8):pos(5, 22):addTo(bg)
  display.newTTFLabel({
    text = game.role.items[coinId[type]] or 0,
    size = 24,
    color = UIHelper.hex2rgb("#A3543A")
  }):pos(81, 23):addTo(bg)
  local sortArr = {}
  for _, data in ipairs(GiftCsv) do
    if data.type == type then
      sortArr[#sortArr + 1] = data
    end
  end
  local rows = math.ceil(#sortArr / 5)
  for row = 1, rows do
    local viewNode = UIHelper.newImageView(LtyGiftRes .. "cell_bg_" .. type .. ".png"):addTo(self.normalList)
    for col = 1, 5 do
      local index = (row - 1) * 5 + col
      local data = sortArr[index]
      if not data then
        break
      end
      local cell = UIHelper.newImageView(LtyGiftRes .. "cell_one_" .. type .. ".png"):anch(0.5, 0):pos(viewNode:getContentSize().width / 5 * (col - 1) + viewNode:getContentSize().width / 10, 20):addTo(viewNode)
      local reward = data.gift:toArray("=", true)
      local posYOffset = 10
      local item = ItemIcon.new({
        type = reward[1],
        count = reward[2]
      }):scale(0.9):anch(0.5, 0):pos(cell:getContentSize().width / 2, 33 + posYOffset):addTo(cell)
      local desDi = display.newSprite(LtyGiftRes .. "cell_des_" .. type .. ".png"):pos(cell:getContentSize().width / 2, 10 + posYOffset):addTo(cell)
      display.newTTFLabel({
        text = data.desc,
        size = 14,
        color = UIHelper.hex2rgb("#ffffff")
      }):pos(desDi:getContentSize().width / 2, desDi:getContentSize().height / 2 + 1):addTo(desDi)
      local coinDi = display.newSprite(LtyGiftRes .. "coin_num_" .. type .. ".png"):pos(cell:getContentSize().width / 2, -16 + posYOffset):addTo(cell)
      display.newSprite(LtyGiftRes .. "coin_" .. type .. ".png"):pos(4, coinDi:getContentSize().height / 2):addTo(coinDi)
      display.newTTFLabel({
        text = data.condition,
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):pos(coinDi:getContentSize().width / 2 + 2, coinDi:getContentSize().height / 2 + 2):addTo(coinDi)
      local extraNeed = true
      if data.condition2 ~= "" then
        local temp = data.condition2:toArray("=", true)
        extraNeed = (game.role.items[temp[1]] or 0) >= temp[2]
        if not extraNeed then
          local lock = UIHelper.newImageView(LtyGiftRes .. "item_lock.png"):pos(47, 47):addTo(item)
          local rechargeItemId
          if type == 3 then
            rechargeItemId = globalCsv.ltyGiftItemId3
          elseif type == 4 then
            rechargeItemId = globalCsv.ltyGiftItemId4
          else
            print("type error")
          end
          local rechargeItem = ShopCsv[rechargeItemId]
          lock:setCallback(function()
            MDialog:double({
              text = "是否花费礼包券x" .. rechargeItem.cost .. "购买" .. rechargeItem.title .. "以解锁本页奖励？"
            }, function()
              if (game.role.items[60] or 0) < rechargeItem.cost then
                SysError(SYS_ERR_SHOP_SAUCE_MONEY_NOT_ENOUGH)
                return
              end
              game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({index = rechargeItemId, num = 1}))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
                UIHelper.removeWaiting()
                local msg = MsgPack.unpack(event.data)
                MedalRewardLayer.new({
                  items = msg.items
                })
                self:showGiftLayer(type)
              end)
            end)
          end)
        end
      end
      if game.role.ltyScoreGift:getv(data.id, 0) == -1 or reward[1] == 207 and game.role.items[207] then
        display.newSprite(ScoreRes .. "done.png"):anch(0.5, 0):pos(cell:getContentSize().width / 2, 70):addTo(cell):name("red")
        item:setCallback(function()
          MTip:show({
            type = MTipType.item,
            node = item,
            itemType = reward[1],
            itemData = ItemCsv[reward[1]]
          })
        end)
      elseif (game.role.items[coinId[type]] or 0) >= data.condition then
        if extraNeed then
          display.newSprite(ScoreRes .. "red.png"):anch(0.5, 0):pos(cell:getContentSize().width / 2, 70):addTo(cell):name("red")
        end
        cell:setCallback(function(sender)
          if not extraNeed then
            SysError(SYS_ERR_MOON_ITEM_NOT_ENOUGH)
            return
          end
          game:sendData(actionCodes.Activity_ltyScoreGiftRpc, MsgPack.pack({
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_ltyScoreGiftRpc, function(event)
            UIHelper.removeWaiting()
            sender:setTouchEnabled(false)
            local spr = sender:getChildByName("red")
            if spr then
              spr:setTexture(ScoreRes .. "done.png")
            end
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward
            })
            item:setCallback(function()
              MTip:show({
                type = MTipType.item,
                node = item,
                itemType = reward[1],
                itemData = ItemCsv[reward[1]]
              })
            end)
          end)
        end)
      else
        item:setCallback(function()
          MTip:show({
            type = MTipType.item,
            node = item,
            itemType = reward[1],
            itemData = ItemCsv[reward[1]]
          })
        end)
      end
    end
  end
  self.normalList:forceDoLayout()
  self.normalList:stopAutoScroll()
end

function LtyGiftLayer:showMoveText(parent)
  local bg = parent:getChildByName("tip")
  if bg then
    return
  end
  local bg = display.newSprite(ShopRes .. "tip_bg.png"):pos(0, -120):addTo(parent)
  bg:name("tip")
  bg:setOpacity(0)
  bg:setCascadeOpacityEnabled(true)
  display.newTTFLabel({
    text = "主厨，欢迎领奖~",
    size = 20
  }):pos(85, 28):addTo(bg)
  bg:runAction(transition.sequence({
    cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 30)), cc.FadeIn:create(0.2)),
    cc.DelayTime:create(1),
    cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 30)), cc.FadeOut:create(0.4)),
    cc.RemoveSelf:create()
  }))
end

return LtyGiftLayer
