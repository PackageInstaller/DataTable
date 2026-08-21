local ShopCsv = require("csvdata.shop")
local ShopSkinCsv = require("csvdata.shop_skin")
local ItemCsv = require("csvdata.item")
local RechargeCsv = require("csvdata.recharge")
local DressCsv = require("csvdata.hero_skin")
local BookCsv = require("csvdata.handbook")
local PvpCsv = require("csvdata.shop_pvp")
local DinerCsv = require("csvdata.shop_diner")
local ScoreCsv = require("csvdata.shop_score")
local EijiCsv = require("csvdata.awaken_shop")
local SauceShopCsv = require("csvdata.sauce_shop")
local sdkInterface = require("sdk.SDKInterface")
local ShopRes = "ui/shop/main/"
local GlobalRes = "ui/global/"
local uiData = {
  csbFile = "ui/shop/ShopLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    topBar = "topBar",
    angle = "angle",
    btnChange = "angle/btnChange",
    panel1 = "panel1",
    heroNode = "panel1/heroNode",
    content1 = "panel1/contentBg/content",
    normalList = "panel1/contentBg/list",
    normalBtn1 = "panel1/btn1",
    normalBtn2 = "panel1/btn2",
    normalBtn3 = "panel1/btn3",
    normalBtn4 = "panel1/btn4",
    normalBtn5 = "panel1/btn5",
    panel2 = "panel2",
    content2 = "panel2/contentBg/content",
    specialBg = "panel2/contentBg",
    specialList = "panel2/contentBg/list",
    specialBtn1 = "panel2/btn1",
    specialBtn2 = "panel2/btn2",
    specialBtn3 = "panel2/btn3",
    specialBtn4 = "panel2/btn4",
    specialBtn5 = "panel2/btn5",
    specialBtn6 = "panel2/btn6",
    specialBtn7 = "panel2/btn7",
    imageNode = "panel2/imageNode"
  }
}
local changeRechargeId = {
  ["49"] = 1,
  ["35"] = 1,
  ["37"] = 1,
  ["45"] = 1
}
local changeToId = {
  [7] = 109,
  [8] = 110,
  [9] = 113,
  [10] = 120,
  [11] = 112,
  [12] = 115,
  [13] = 104
}
local btnsNames1 = {
  [1] = {
    name = "钻石",
    func = function(self)
      self:showRechargeLayer()
    end
  },
  [2] = {
    name = "礼包",
    func = function(self)
      self:showGiftLayer()
    end
  },
  [3] = {
    name = "道具",
    func = function(self)
      self:showItemsLayer()
    end
  },
  [4] = {
    name = "功能",
    func = function(self)
      self:showExtrLayer()
    end
  },
  [5] = {
    name = "换装",
    func = function(self)
      self:showDressLayer()
    end
  }
}
local btnsNames2 = {
  [1] = {
    name = "学员中心",
    func = function(self)
      self:showPvpLayer()
    end
  },
  [2] = {
    name = "酱料坊",
    func = function(self)
      self:showSauceLayer()
    end
  },
  [3] = {
    name = "次元集市",
    func = function(self)
      self:showDinerLayer()
    end
  },
  [4] = {
    name = "异界商城",
    func = function(self)
      self:showEijiLayer()
    end
  },
  [5] = {
    name = "限定兑换",
    func = function(self)
      self:showSpecialExtraLayer()
    end
  },
  [6] = {
    name = "活动商城",
    func = function(self)
      self:showSpecialLayer()
    end
  },
  [7] = {
    name = "兑换商店",
    func = function(self)
      self:showSpecialTempLayer()
    end
  }
}
local time1 = {
  [0] = "可\n购\n买\n%d\n次",
  [1] = "本\n周\n剩\n余\n%d\n次",
  [2] = "本\n月\n剩\n余\n%d\n次",
  [3] = "本\n日\n剩\n余\n%d\n次"
}
local time2 = {
  [0] = "可\n购\n买\n%d\n次",
  [1] = "本\n日\n剩\n余\n%d\n次",
  [2] = "本\n周\n剩\n余\n%d\n次",
  [3] = "本\n月\n剩\n余\n%d\n次"
}
local ShopLayer = class("ShopLayer", UIBase)

function ShopLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShopLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.topBar, true)
    self.angle:setPositionX(self.angle:getPositionX() - UIHelper.getMoveXForX())
  end
  self.mainBg:setTouchEnabled(true)
  self.mainBg:setSwallowTouches(true)
  TopBar:show(TopBarType.shop, "商城")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToUp({
    node = self.angle,
    time = 0.3
  })
  self.selected = params.selected or 1
  self.curType = params.curType or 1
  self.isHide = params.isHide or false
  if game.role:activityIsOpen(13) then
  end
  self.changeSkin = false
  if not game.role:activityIsOpen(100) then
  end
  local closeLimit = false
  if closeLimit then
    self.specialBtn5:hide()
    self.specialBtn6:pos(672, 24)
  end
  if self.changeSkin then
    self.specialBg:setTexture(ShopRes .. "shop_bg_2.png")
  end
  local group1 = MRadioGroup:create()
  for index, data in ipairs(btnsNames1) do
    local btn = self["normalBtn" .. index]
    btn:name("btn" .. index)
    btn:setCallback(function()
      self.normalList:setDirection(1)
      self.normalList:jumpToTop()
      self.content1:removeAllChildren()
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#4c1203"), 1):pos(75, 23):addTo(btn):name("text")
    btn:setGroup(group1)
  end
  local group2
  if self.changeSkin then
    group2 = MRadioGroup:create({
      chooseCb = function(sender)
        local text = sender:getChildByName("text")
        text:enableOutline(UIHelper.hex2rgb("#ab4710"), 1)
      end,
      unchooseCb = function(sender)
        local text = sender:getChildByName("text")
        text:enableOutline(UIHelper.hex2rgb("#00576e"), 1)
      end
    })
  else
    group2 = MRadioGroup:create()
  end
  for index, data in ipairs(btnsNames2) do
    local btn = self["specialBtn" .. index]
    btn:name("btn" .. index)
    btn:setCallback(function()
      if index == 2 then
        if not CommonHelper.funcOpen("sauce") then
          SysError(SYS_ERR_FUNCOPEN_SAUCE_CARBON)
          group2:chooseByName("btn" .. self.selected)
          return
        end
      elseif index == 3 and not CommonHelper.funcOpen("box") then
        SysError(SYS_ERR_FUNCOPEN_DINER_SHOP)
        group2:chooseByName("btn" .. self.selected)
        return
      end
      self.content2:removeAllChildren()
      self.specialList:jumpToTop()
      self.selected = index
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 18
    }):pos(50, 23):addTo(btn):name("text"):enableOutline(UIHelper.hex2rgb("#4c1203"), 1)
    btn:setGroup(group2)
    if self.changeSkin then
      btn:setImages(ShopRes, {
        "btn_a_2.png",
        "btn_b_2.png"
      })
    end
  end
  self.btnChange:setImage(ShopRes .. (self.curType == 1 and "change_a.png" or "change_b.png"))
  self.btnChange:setCallback(function()
    self.selected = 1
    if self.curType == 1 then
      self.curType = 2
      self.panel1:hide()
      self.panel2:show()
      self.content2:removeAllChildren()
      self.btnChange:setImage(ShopRes .. "change_b.png")
      group2:chooseByName("btn1")
      if self.changeSkin then
        self.topBar:hide()
        self.mainBg:setImage(ShopRes .. "special_bg.png")
      end
    else
      self.curType = 1
      self.panel1:show()
      self.panel2:hide()
      self.content1:removeAllChildren()
      self.btnChange:setImage(ShopRes .. "change_a.png")
      self.normalList:setDirection(1)
      group1:chooseByName("btn1")
      if self.changeSkin then
        self.topBar:show()
        self.mainBg:setImage("ui/hero/bg.png")
      end
    end
    self:showData()
  end)
  if self.curType == 1 then
    self.panel2:hide()
    group1:chooseByName("btn" .. self.selected)
  else
    self.panel1:hide()
    self.topBar:hide()
    group2:chooseByName("btn" .. self.selected)
    if self.changeSkin then
      self.mainBg:setImage(ShopRes .. "special_bg.png")
    end
  end
  if not game.role.shopGirl then
    local data
    repeat
      data = BookCsv[math.random(1, #BookCsv)]
    until data.open == 1
    game.role.shopGirl = data.id
  end
  local heroCard = HeroBigCard.new({
    type = game.role.shopGirl,
    showPic = true
  }):scale(0.83):addTo(self.heroNode)
  heroCard:setCallback(function()
    self:showMoveText(self.heroNode)
  end)
  if self.changeSkin then
  else
    local image = HeroBigCard.new({
      type = game.role.shopGirl,
      showPic = true
    }):scale(0.83):addTo(self.imageNode)
    image:setCallback(function()
      self:showMoveText(self.imageNode)
    end)
  end
  if self.isHide then
    group1:hide()
    group2:hide()
    self.angle:hide()
  end
  self:showMoveText(self.heroNode)
end

function ShopLayer:showData(params)
  local data = self.curType == 1 and btnsNames1[self.selected] or btnsNames2[self.selected]
  data.func(self)
end

function ShopLayer:showRechargeLayer()
  self.normalList:removeAllChildren()
  local showCsv = {}
  for key, data in pairs(RechargeCsv) do
    if data.type == 1 and data.id ~= 98 and CommonHelper.showProduct(data.id) then
      table.insert(showCsv, data)
    end
  end
  table.sort(showCsv, function(a, b)
    return a.order < b.order
  end)
  local size = display.newSprite(ShopRes .. "cell_bg_1.png"):getContentSize()
  local rows = math.ceil(#showCsv / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 4):addTo(self.normalList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = showCsv[index]
      if not data then
        self.normalList:requestDoLayout()
        return
      end
      local cell = UIHelper.newImageView(ShopRes .. "cell_bg_1.png"):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
      display.newSprite(ShopRes .. "diamond_image_bg.png"):pos(104, 145):addTo(cell)
      display.newSprite(ShopRes .. "circle_bg.png"):pos(104, 145):addTo(cell)
      display.newSprite(data.icon ~= "" and data.icon or string.format("%sdiamond_%d.png", ShopRes, data.id)):pos(104, 145):addTo(cell)
      display.newTTFLabel({
        text = "￥" .. data.rmb,
        size = 20,
        color = UIHelper.hex2rgb("#7f3014")
      }):pos(100, 25):addTo(cell)
      local countBg = display.newSprite(ShopRes .. "cell_count_bg.png"):pos(104, 54):addTo(cell)
      countBg:hide()
      local diamondCount = data.diamond
      if data.id == 99 then
        countBg:show()
        display.newSprite(ShopRes .. "month_tip.png"):anch(0, 1):pos(2, 227):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 80):addTo(cell)
        display.newTTFLabel({
          text = data.desc,
          size = 16,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 55):addTo(cell)
        if game:nowTime() < game.role.monthCardDeadline then
          local days = math.ceil((game.role.monthCardDeadline - game:nowTime()) / 86400)
          local str = string.format("剩余%d天", days)
          if days == 1 then
            local tasks = game.role.dailyTaskStatusNew:toNumMap()
            if tasks[1000] and tasks[1000] == -1 or tasks[globalCsv.monthCardTask] and tasks[globalCsv.monthCardTask] == -1 then
              str = "已到期"
            end
          end
          display.newTTFLabel({
            text = str,
            size = 16,
            color = UIHelper.hex2rgb("#c44507")
          }):anch(1, 0.5):pos(195, 210):addTo(cell)
        end
      elseif data.id == 199 then
        countBg:show()
        display.newSprite(ShopRes .. "month_tip.png"):anch(0, 1):pos(2, 227):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 80):addTo(cell)
        display.newTTFLabel({
          text = data.desc,
          size = 16,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 55):addTo(cell)
        if game:nowTime() < game.role.resMonthCardDeadline then
          local days = math.ceil((game.role.resMonthCardDeadline - game:nowTime()) / 86400)
          local str = string.format("剩余%d天", days)
          if days == 1 then
            local tasks = game.role.dailyTaskStatusNew:toNumMap()
            if tasks[globalCsv.resMonthCardTask] and tasks[globalCsv.resMonthCardTask] == -1 then
              str = "已到期"
            end
          end
          display.newTTFLabel({
            text = str,
            size = 16,
            color = UIHelper.hex2rgb("#c44507")
          }):anch(1, 0.5):pos(195, 210):addTo(cell)
        end
      elseif data.id == 299 then
        countBg:show()
        display.newSprite(ShopRes .. "month_tip.png"):anch(0, 1):pos(2, 227):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 80):addTo(cell)
        display.newTTFLabel({
          text = data.desc,
          size = 16,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 55):addTo(cell)
        if game:nowTime() < game.role.mengJingMonthCardDeadline then
          local days = math.ceil((game.role.mengJingMonthCardDeadline - game:nowTime()) / 86400)
          local str = string.format("剩余%d天", days)
          if days == 1 then
            local tasks = game.role.dailyTaskStatusNew:toNumMap()
            if tasks[globalCsv.mengJingMonthCardTask] and tasks[globalCsv.mengJingMonthCardTask] == -1 then
              str = "已到期"
            end
          end
          display.newTTFLabel({
            text = str,
            size = 16,
            color = UIHelper.hex2rgb("#c44507")
          }):anch(1, 0.5):pos(195, 210):addTo(cell)
        end
      elseif data.id == 98 then
        if game:nowTime() < (game.role.subCardDeadline or 0) then
          display.newTTFLabel({
            text = "已订阅",
            size = 16,
            color = UIHelper.hex2rgb("#c44507")
          }):anch(1, 0.5):pos(195, 210):addTo(cell)
        end
      elseif data.diamond == 0 then
        if game.role.rechargeStatus:getv(data.id, 0) == 0 and data.id ~= 110 then
          display.newSprite(ShopRes .. "suggest.png"):anch(0, 1):pos(1, 235):addTo(cell)
          display.newTTFLabel({text = "热销", size = 24}):enableOutline(UIHelper.hex2rgb("#930d1a"), 1):pos(34, 219):addTo(cell)
        end
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 65):addTo(cell)
      else
        local str = ""
        local yPos = 65
        if game.role.rechargeStatus:getv(data.id, 0) == 0 then
          if 0 < data.diamondFirst then
            countBg:show()
            display.newSprite(ShopRes .. "suggest.png"):anch(0, 1):pos(1, 235):addTo(cell)
            display.newTTFLabel({text = "热销", size = 24}):enableOutline(UIHelper.hex2rgb("#930d1a"), 1):pos(34, 219):addTo(cell)
            str = string.format("%d钻石+赠%d钻石", diamondCount, data.diamondFirst)
            diamondCount = diamondCount + data.diamondFirst
            yPos = 80
          end
        elseif 0 < data.diamondExtra then
          countBg:show()
          str = string.format("%d钻石+赠%d钻石", diamondCount, data.diamondExtra)
          diamondCount = diamondCount + data.diamondExtra
          yPos = 80
        end
        display.newTTFLabel({
          text = diamondCount .. "钻石",
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, yPos):addTo(cell)
        display.newTTFLabel({
          text = str,
          size = 16,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(104, 55):addTo(cell)
      end
      cell:setCallback(function()
        if game.role:checkNotRechargeChannel() then
          return
        end
        if not game.role:checkCanCharge(data.rmb) then
          return
        end
        if data.id == 99 then
          local days = math.ceil((game.role.monthCardDeadline - game:nowTime()) / 86400)
          if days + 30 > globalCsv.monthCardLimit then
            SysError(SYS_ERR_SHOP_MONTH_CARD_IS_FULL)
            return
          end
        elseif data.id == 98 then
          game:createView("farm.SubMainLayer", {
            callback = function()
              self:showRechargeLayer()
            end
          })
          return
        elseif data.id == 199 then
          local days = math.ceil((game.role.resMonthCardDeadline - game:nowTime()) / 86400)
          if days + 14 > globalCsv.resMonthCardLimit then
            SysError(SYS_ERR_SHOP_MONTH_CARD_IS_FULL)
            return
          end
        elseif data.id == 299 then
          local days = math.ceil((game.role.mengJingMonthCardDeadline - game:nowTime()) / 86400)
          if days + 14 > globalCsv.mengJingMonthCardLimit then
            SysError(SYS_ERR_SHOP_MONTH_CARD_IS_FULL)
            return
          end
        end
        game:sendData(actionCodes.Store_rechargeRpc, MsgPack.pack({
          id = data.id,
          chan = CHANNEL_NAME
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Store_rechargeRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          local purchaseData = {
            rechargeData = data,
            order = msg.order,
            diamond = diamondCount
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
              umeng.pay(data.rmb, 20, data.title, 1, data.rmb)
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
            self:showRechargeLayer()
          end)
        end)
      end)
    end
  end
  self.normalList:requestDoLayout()
end

function ShopLayer:showGiftLayer()
  self.content1:removeAllChildren()
  self.normalList:removeAllChildren()
  local bg = UIHelper.newImageView(ShopRes .. "skin_num_bg_1.png"):addTo(self.content1)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = 60,
      itemData = ItemCsv[60]
    })
  end)
  display.newSprite(ItemCsv[60].icon):scale(0.4):pos(5, 12):addTo(bg)
  display.newTTFLabel({
    text = game.role.items[60] or 0,
    size = 24
  }):pos(51, 14):addTo(bg)
  local showCsv = {}
  local time = game:nowTime()
  for key, data in pairs(ShopCsv) do
    if data.type == 3 then
      local temp = clone(data)
      local field = temp.rechargeId == 0 and "shopStatus" or "rechargeStatus"
      local id = temp.rechargeId == 0 and temp.id or temp.rechargeId
      local left = temp.limit == 0 and 999 or temp.limit - game.role[field]:getv(id, 0)
      if globalCsv.repeatGiftItemId ~= 0 and data.id > 20000 and data.id < 20100 then
        left = game.role.items[globalCsv.repeatGiftItemId] and 0 or 1
      end
      if globalCsv.repeatGiftItemId2 ~= 0 and data.id > 3800 and data.id <= 3900 then
        left = game.role.items[globalCsv.repeatGiftItemId2] and 0 or 1
      end
      temp.left = left
      temp.factor = left < 1 and 1 or 0
      if not (game.role.level >= temp.unlock) or temp.reset == 0 and left == 0 or 0 < temp.rechargeId and not CommonHelper.showProduct(temp.rechargeId) then
      elseif temp.time == "" then
        table.insert(showCsv, temp)
      else
        local times = temp.time:toArray("=", false)
        if time >= CommonHelper.toUnixtime(times[1] .. string.format("%02x", RESET_TIME)) and time <= CommonHelper.toUnixtime(times[2] .. string.format("%02x", RESET_TIME)) then
          table.insert(showCsv, temp)
        end
      end
    end
  end
  table.sort(showCsv, function(a, b)
    return a.factor * 100000 + a.order < b.factor * 100000 + b.order
  end)
  local size = display.newSprite(ShopRes .. "cell_bg_3.png"):getContentSize()
  local rows = math.ceil(#showCsv / 3)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 4):addTo(self.normalList)
    for col = 1, 3 do
      local index = (row - 1) * 3 + col
      local data = showCsv[index]
      if not data then
        self.normalList:requestDoLayout()
        return
      end
      local special = data.id > 3800 and data.id <= 3900 or data.id > 20000 and data.id < 20100
      if data.id == globalCsv.homeBoxId then
        special = true
      end
      local cell = UIHelper.newImageView(ShopRes .. "cell_bg_3.png"):anch(0, 0):pos(3 + (col - 1) * 285, 3):addTo(viewNode)
      if not special then
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(140, 54):addTo(cell)
      end
      display.newSprite(data.icon):pos(138, special and 155 or 127):addTo(cell)
      if data.reward ~= "" then
        local items = data.reward:toNumMap()
        display.newSprite(ShopRes .. (1 < table.nums(items) and "image_extra_2.png" or "image_extra_1.png")):anch(0.5, 1):pos(242, 214):addTo(cell)
        local yPos = 153
        for itemId, num in pairs(items) do
          local circle = display.newSprite(ShopRes .. "extra_item_bg.png"):pos(242, yPos):addTo(cell)
          display.newSprite(ItemCsv[itemId].icon):scale(0.45):center(circle):addTo(circle)
          display.newTTFLabel({text = num, size = 20}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(24, 12):addTo(circle)
          yPos = yPos - 50
        end
      end
      local off
      if data.off ~= 0 then
        off = display.newSprite(ShopRes .. (50 >= data.off and "off_1.png" or "off_2.png")):pos(58, 206):addTo(cell)
        if 50 >= data.off then
          display.newTTFLabel({
            text = data.off .. "%",
            size = 32
          }):enableOutline(UIHelper.hex2rgb("#af3e00"), 1):pos(37, 45):addTo(off)
        else
          display.newTTFLabel({
            text = math.ceil(100 / (100 - data.off)) .. "倍",
            size = 28
          }):enableOutline(UIHelper.hex2rgb("#bc0a13"), 1):pos(37, 45):addTo(off)
        end
      end
      local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
      countBg:hide()
      local times
      if data.time ~= "" then
        times = data.time:toArray("=", false)
        if special then
          display.newSprite(ShopRes .. "cell_count_bg.png"):pos(140, 54):addTo(cell)
          display.newTTFLabel({
            text = string.format("剩余%d天", math.ceil((CommonHelper.toUnixtime(times[2] .. string.format("%02x", RESET_TIME)) - time) / 86400)),
            size = 16,
            color = UIHelper.hex2rgb("#c44507")
          }):pos(138, 56):addTo(cell)
        else
          display.newTTFLabel({
            text = string.format("剩余%d天", math.ceil((CommonHelper.toUnixtime(times[2] .. string.format("%02x", RESET_TIME)) - time) / 86400)),
            size = 14,
            color = UIHelper.hex2rgb("#78ff00")
          }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(138, 73):addTo(cell)
        end
      end
      local levelDi
      if data.rechargeId == 0 then
        if data.id > 10000 then
          display.newSprite(ItemCsv[60].icon):scale(0.3):pos(117, 24):addTo(cell)
        else
          display.newSprite("ui/global/base_diamond.png"):scale(0.75):pos(117, 24):addTo(cell)
        end
        local costLab = display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb("#703902")
        }):anch(0, 0.5):pos(132, 25):addTo(cell)
        if data.unlock ~= 0 then
          local endTime = game.role.levelGiftStatus:getv(data.id, 0) + data.saleTime * 3600
          local lastTime = endTime - time
          if 0 < lastTime then
            if off then
              off:hide()
            end
            costLab:setString(data.sale)
            local yuanjia = display.newTTFLabel({
              text = "原价" .. data.cost,
              size = 14
            }):anch(1, 0.5):enableOutline(UIHelper.hex2rgb("#703902"), 1):pos(80, 25):addTo(cell)
            display.newSprite(ShopRes .. "line.png"):anch(1, 0.5):pos(yuanjia:getContentSize().width + 5, yuanjia:getContentSize().height / 2):addTo(yuanjia)
            levelDi = display.newSprite(ShopRes .. "level_di.png"):pos(108, 210):addTo(cell)
            local levelTime = display.newTTFLabel({
              text = string.format("萌新特惠剩余%02d:%02d:%02d", math.floor(lastTime / 3600), math.floor(lastTime % 3600 / 60), math.ceil(lastTime % 3600 % 60)),
              size = 20,
              color = UIHelper.hex2rgb("ffffff")
            }):anch(0, 0.5):pos(5, 32):addTo(levelDi)
            levelTime:enableOutline(UIHelper.hex2rgb("#bc1119"))
            levelDi:runAction(cc.RepeatForever:create(transition.sequence({
              cc.DelayTime:create(1),
              cc.CallFunc:create(function()
                lastTime = endTime - game:nowTime()
                if 0 < lastTime then
                  levelTime:setString(string.format("萌新特惠剩余%02d:%02d:%02d", math.floor(lastTime / 3600), math.floor(lastTime % 3600 / 60), math.ceil(lastTime % 3600 % 60)))
                else
                  levelDi:removeSelf()
                  yuanjia:removeSelf()
                  if off then
                    off:show()
                  end
                  costLab:setString(data.cost)
                end
              end)
            })))
          end
        end
        if data.limit ~= 0 and 1 > data.left then
          if levelDi then
            levelDi:hide()
          end
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(138, 130):addTo(cell)
        else
          local limitTitle
          if data.limit ~= 0 then
            countBg:show()
            limitTitle = display.newTTFLabel({
              text = string.format(time1[data.reset], data.left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            if data.time ~= "" and CommonHelper.toUnixtime(times[2] .. string.format("%02x", RESET_TIME)) < game:nowTime() then
              SysError(SYS_ERR_SHOP_GIFT_TIME_IS_OUT)
              return
            end
            if data.left < 1 then
              return
            end
            game:createView("shop.ShopGiftCountLayer", {
              index = data.id,
              func = function(chooseId)
                game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({
                  index = data.id,
                  num = 1,
                  chooseId = chooseId
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  if msg.change then
                    MDialog:single({
                      title = "提示",
                      text = "获得的重复外观已自动折算为等值物品"
                    }, function()
                      MedalRewardLayer.new({
                        items = msg.items
                      })
                    end)
                  else
                    MedalRewardLayer.new({
                      items = msg.items
                    })
                  end
                  data.left = data.left - 1
                  if limitTitle then
                    limitTitle:setString(string.format(time1[data.reset], data.left))
                  end
                  if data.left < 1 then
                    countBg:hide()
                    display.newSprite(ShopRes .. "cell_image_out.png"):pos(138, 130):addTo(cell)
                  end
                end)
              end
            })
          end)
        end
      else
        local index = data.id
        local rechargeData = RechargeCsv[data.rechargeId]
        display.newTTFLabel({
          text = "￥" .. rechargeData.rmb,
          size = 20,
          color = UIHelper.hex2rgb("#7f3014")
        }):pos(138, 25):addTo(cell)
        local left = rechargeData.limit - game.role.rechargeStatus:getv(rechargeData.id, 0)
        if left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(138, 130):addTo(cell)
        else
          if not special then
            countBg:show()
          end
          display.newTTFLabel({
            text = string.format(time1[data.reset], left),
            size = 16,
            align = ui.TEXT_ALIGN_CENTER,
            color = UIHelper.hex2rgb("#7f3014")
          }):pos(13, 54):addTo(countBg)
          cell:setCallback(function()
            if game.role:checkNotRechargeChannel() then
              return
            end
            if rechargeData.time ~= "" and CommonHelper.toUnixtime(times[2] .. string.format("%02x", RESET_TIME)) < game:nowTime() then
              SysError(SYS_ERR_SHOP_GIFT_TIME_IS_OUT)
              return
            end
            if not game.role:checkCanCharge(rechargeData.rmb) then
              return
            end
            game:createView("shop.ShopGiftCountLayer", {
              index = index,
              func = function()
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
                      umeng.pay(rechargeData.rmb, 20, rechargeData.title, 1, rechargeData.rmb)
                      if msg.change then
                        MDialog:single({
                          title = "提示",
                          text = "获得的重复外观已自动折算为等值物品"
                        }, function()
                          MedalRewardLayer.new({
                            items = msg.reward
                          })
                        end)
                      else
                        MedalRewardLayer.new({
                          items = msg.reward
                        })
                      end
                    elseif msg.result == "handled" then
                    else
                      return
                    end
                    self:showGiftLayer()
                  end)
                end)
              end
            })
          end)
        end
      end
    end
  end
  if not next(showCsv) then
    local size = self.normalList:getContentSize()
    local viewNode = ccui.Widget:create()
    self.viewNode:size(size):addTo(normalList)
    local tip = display.newSprite("ui/hero/tip_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = "主厨您现在没有任何礼包可买哦",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(435, 147):addTo(tip)
  end
  self.normalList:requestDoLayout()
end

function ShopLayer:showItemsLayer()
  self.normalList:removeAllChildren()
  local showCsv = {}
  for key, data in pairs(ShopCsv) do
    if data.type == 1 then
      local temp = clone(data)
      temp.left = data.limit == 0 and 999 or data.limit - game.role.shopStatus:getv(data.id, 0)
      table.insert(showCsv, temp)
    end
  end
  table.sort(showCsv, function(a, b)
    local factorA = a.left == 0 and 10000 or 0
    local factorB = b.left == 0 and 10000 or 0
    return a.order + factorA < b.order + factorB
  end)
  local size = display.newSprite(ShopRes .. "cell_bg_1.png"):getContentSize()
  local rows = math.ceil(#showCsv / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 4):addTo(self.normalList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = showCsv[index]
      if not data then
        self.normalList:requestDoLayout()
        return
      end
      local cell = UIHelper.newImageView(ShopRes .. "cell_bg_1.png"):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
      display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 145):addTo(cell)
      ItemIcon.new({
        type = data.itemid
      }):pos(104, 145):addTo(cell)
      display.newTTFLabel({
        text = data.desc,
        size = 22,
        color = UIHelper.hex2rgb("#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite("ui/global/base_diamond.png"):scale(0.75):pos(85, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0, 0.5):pos(100, 25):addTo(cell)
      if 1 > data.left then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        cell:setCallback(function()
          SysError(SYS_ERR_SHOP_BUY_LIMIT)
        end)
      else
        if data.limit ~= 0 then
          local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
          display.newTTFLabel({
            text = string.format(time1[data.reset], data.left),
            size = 16,
            align = ui.TEXT_ALIGN_CENTER,
            color = UIHelper.hex2rgb("#7f3014")
          }):pos(13, 54):addTo(countBg)
        end
        cell:setCallback(function()
          game:createView("shop.ShopItemCountLayer", {
            index = data.id,
            func = function()
              self:showItemsLayer()
            end
          })
        end)
      end
    end
  end
  self.normalList:requestDoLayout()
end

function ShopLayer:showExtrLayer()
  self.normalList:removeAllChildren()
  local showCsv, types = {}, {}
  for key, data in pairs(ShopCsv) do
    if data.type == 2 then
      local curNum = game.role.shopStatus:getv(data.id, 0)
      local preNum = game.role.shopStatus:getv(data.pre, 0)
      if data.pre == 0 then
        types[data.itemid] = data.id
      end
      if preNum ~= 0 and curNum == 0 or data.pre == 0 and curNum == 0 then
        table.insert(showCsv, data)
      end
    end
  end
  for key, index in pairs(types) do
    local add = true
    for _, data in pairs(showCsv) do
      if data.itemid == key then
        add = false
        break
      end
    end
    if add then
      table.insert(showCsv, ShopCsv[index])
    end
  end
  table.sort(showCsv, function(a, b)
    return a.id < b.id
  end)
  local size = display.newSprite(ShopRes .. "cell_bg_1.png"):getContentSize()
  local rows = math.ceil(#showCsv / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 4):addTo(self.normalList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = showCsv[index]
      if not data then
        self.normalList:requestDoLayout()
        return
      end
      local cell = UIHelper.newImageView(ShopRes .. "cell_bg_1.png"):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
      display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 145):addTo(cell)
      display.newSprite(ItemCsv[data.itemid].icon):anch(0.5, 0):pos(104, 95):addTo(cell)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite("ui/global/base_diamond.png"):scale(0.75):pos(85, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0, 0.5):pos(100, 25):addTo(cell)
      if game.role.shopStatus:getv(data.id, 0) >= data.limit then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        cell:setCallback(function()
          SysError(SYS_ERR_SHOP_BUY_LIMIT)
        end)
      else
        cell:setCallback(function()
          game:createView("shop.ShopItemCountLayer", {
            index = data.id,
            func = function()
              self:showExtrLayer()
            end
          })
        end)
      end
    end
  end
  if not next(showCsv) then
    local size = self.normalList:getContentSize()
    local viewNode = ccui.Widget:create()
    self.viewNode:size(size):addTo(normalList)
    local tip = display.newSprite("ui/hero/tip_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = "主厨您现在没有任何扩充功能券可买哦",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(435, 147):addTo(tip)
  end
  self.normalList:requestDoLayout()
end

function ShopLayer:showDressLayer()
  self.normalList:removeAllChildren()
  self.normalList:setDirection(2)
  local bg = UIHelper.newImageView(ShopRes .. "skin_num_bg_1.png"):addTo(self.content1)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = 11,
      itemData = ItemCsv[11]
    })
  end)
  display.newSprite("ui/global/base_11.png"):pos(5, 12):addTo(bg)
  display.newTTFLabel({
    text = game.role.items[11] or 0,
    size = 24
  }):pos(51, 14):addTo(bg)
  local sortData = {}
  for _, data in pairs(ShopSkinCsv) do
    local temp = clone(data)
    local itemData = ItemCsv[data.itemid]
    local dressData = DressCsv[tonumber(itemData.content)]
    temp.skinExist = game.role.dressBook[dressData.id] and 1 or 0
    if 0 < data.rechargeId and not CommonHelper.showProduct(data.rechargeId) then
    else
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    return a.skinExist * 1000 + a.order < b.skinExist * 1000 + b.order
  end)
  local size = cc.size(220, 470)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.normalList)
    local cell = UIHelper.newImageView(data.res):center(viewNode):addTo(viewNode)
    local heroExist = false
    for _, hero in pairs(game.role.heros) do
      if hero.type == data.exist then
        heroExist = true
        break
      end
    end
    if not heroExist then
      display.newSprite(ShopRes .. "has_not.png"):pos(108, 435):addTo(cell)
    end
    if data.skinExist == 1 then
      cell:setColor(cc.c3b(114, 114, 114))
      display.newSprite(ShopRes .. "has.png"):pos(105, 26):addTo(cell)
    else
      if data.type == 1 then
        itemData = ItemCsv[data.costId]
        local moneyBg = display.newSprite(ShopRes .. "skin_num_bg_1.png"):pos(165, 20):addTo(cell)
        display.newSprite(itemData.icon):scale(0.42):pos(13, 13):addTo(moneyBg)
        display.newTTFLabel({
          text = data.cost,
          size = 22
        }):pos(55, 13):addTo(moneyBg):enableOutline(UIHelper.hex2rgb("#692807"), 1)
        display.newTTFLabel({text = "或", size = 18}):pos(105, 23):addTo(cell):enableOutline(UIHelper.hex2rgb("#692807"), 1)
        local moneyBg2 = display.newSprite(ShopRes .. "skin_num_bg_1.png"):pos(50, 20):addTo(cell)
        display.newSprite("ui/global/base_diamond.png"):pos(13, 13):addTo(moneyBg2)
        display.newTTFLabel({
          text = data.diamond,
          size = 22
        }):pos(55, 13):addTo(moneyBg2):enableOutline(UIHelper.hex2rgb("#692807"), 1)
        if data.diamond2 ~= 0 then
          display.newTTFLabel({
            text = "原价" .. data.diamond2,
            size = 14
          }):enableOutline(UIHelper.hex2rgb("#692807"), 1):pos(47, 34):addTo(moneyBg2)
          display.newSprite(ShopRes .. "line.png"):pos(62, 33):addTo(moneyBg2)
        end
      elseif data.type == 2 then
        local chargeData = RechargeCsv[data.rechargeId]
        display.newTTFLabel({
          text = "¥" .. chargeData.rmb,
          size = 22
        }):pos(105, 23):addTo(cell):enableOutline(UIHelper.hex2rgb("#692807"), 1)
      elseif data.type == 3 then
        display.newTTFLabel({
          text = data.desc,
          size = 22
        }):pos(110, 23):addTo(cell):enableOutline(UIHelper.hex2rgb("#692807"), 1)
      elseif data.type == 4 then
        local moneyBg = display.newSprite(ShopRes .. "skin_num_bg_1.png"):pos(105, 20):addTo(cell)
        display.newSprite("ui/global/base_diamond.png"):pos(13, 13):addTo(moneyBg)
        display.newTTFLabel({
          text = data.diamond,
          size = 22
        }):pos(55, 13):addTo(moneyBg):enableOutline(UIHelper.hex2rgb("#692807"), 1)
        if data.diamond2 ~= 0 then
          display.newTTFLabel({
            text = "原价" .. data.diamond2,
            size = 14
          }):enableOutline(UIHelper.hex2rgb("#692807"), 1):pos(47, 34):addTo(moneyBg)
          display.newSprite(ShopRes .. "line.png"):pos(62, 33):addTo(moneyBg)
        end
      elseif data.type == 5 then
        itemData = ItemCsv[data.costId]
        local moneyBg = display.newSprite(ShopRes .. "skin_num_bg_1.png"):pos(105, 20):addTo(cell)
        display.newSprite(itemData.icon):scale(0.42):pos(13, 13):addTo(moneyBg)
        display.newTTFLabel({
          text = data.cost,
          size = 22
        }):pos(55, 13):addTo(moneyBg):enableOutline(UIHelper.hex2rgb("#692807"), 1)
      end
      cell:setCallback(function()
        game:createView("shop.ShopDressCountLayer", {
          index = data.id,
          has = skinExist,
          func = function()
            self.content1:removeAllChildren()
            self:showDressLayer()
          end
        })
      end)
    end
  end
  self.normalList:requestDoLayout()
end

function ShopLayer:showPvpLayer()
  self.specialList:removeAllChildren()
  local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):addTo(self.content2)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = 13,
      itemData = ItemCsv[13]
    })
  end)
  display.newSprite(ShopRes .. "pvp_small_icon.png"):pos(5, 13):addTo(bg)
  display.newTTFLabel({
    text = game.role.items[13] or 0,
    size = 24
  }):pos(49, 14):addTo(bg)
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local rows = math.ceil(#PvpCsv / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = PvpCsv[index]
      if not data then
        self.specialList:requestDoLayout()
        return
      end
      local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
      display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
      display.newSprite(data.icon):pos(104, 140):addTo(cell)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite(ShopRes .. "pvp_small_icon.png"):pos(85, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
      }):anch(0, 0.5):pos(100, 25):addTo(cell)
      local left = data.limit - game.role.pvpInfo.pvpShop:getv(data.id, 0)
      if left < 1 then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
      else
        local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
        display.newTTFLabel({
          text = string.format(time2[2], left),
          size = 16,
          align = ui.TEXT_ALIGN_CENTER,
          color = UIHelper.hex2rgb("#7f3014")
        }):pos(13, 54):addTo(countBg)
        cell:setCallback(function()
          game:createView("shop.PvpGiftCountLayer", {
            index = data.id,
            func = function()
              self.content2:removeAllChildren()
              self:showPvpLayer()
            end
          })
        end)
      end
    end
  end
  self.specialList:requestDoLayout()
end

function ShopLayer:showSauceLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local sortData = {}
  for _, data in pairs(table.values(SauceShopCsv)) do
    data.left = data.limit == 0 and 999 or data.limit - game.role.sauceShop:getv(data.id, 0)
    table.insert(sortData, data)
  end
  table.sort(sortData, function(a, b)
    return (a.order or a.id) + (a.left == 0 and 10000 or 0) < (b.order or b.id) + (b.left == 0 and 10000 or 0)
  end)
  local rows = math.ceil(#sortData / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = sortData[index]
      if data then
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local icon = ItemIcon.new({
          type = data.gift:toArray("=", true)[1]
        })
        icon:pos(104, 140):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        if costId:getv(data.costId, 0) == 0 then
          costId = costId:setv(data.costId, 1)
        end
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        local left = data.limit == 0 and 999 or data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        if data.left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format("可\n购\n买\n%d\n次\n哦", data.left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            game:createView("shop.SauceItemCountLayer", {
              data = data,
              left = data.left,
              callback = function(num)
                game:sendData(actionCodes.Sauce_shopBuyRpc, MsgPack.pack({
                  id = data.id,
                  count = num
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Sauce_shopBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  local posY = self.specialList:getInnerContainerPosition().y
                  self.content2:removeAllChildren()
                  self:showSauceLayer(posY)
                  MedalRewardLayer.new({
                    items = msg.dropItems
                  })
                end)
              end
            })
          end)
        end
      end
    end
  end
  if costId ~= "" then
    local items = costId:toTableArray()
    local xPos = -110 * (#items - 1)
    for _, set in ipairs(items) do
      local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
      bg:setCallback(function()
        MTip:show({
          type = MTipType.path,
          node = bg,
          itemType = tonumber(set[1]),
          itemData = ItemCsv[tonumber(set[1])]
        })
      end)
      display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
      display.newTTFLabel({
        text = game.role.items[tonumber(set[1])] or 0,
        size = 24
      }):pos(49, 14):addTo(bg)
      xPos = xPos + 110
    end
  end
  self.specialList:forceDoLayout()
  self.specialList:stopAutoScroll()
  posY = posY or self.specialList:getInnerContainerPosition().y
  self.specialList:setInnerContainerPosition({x = 0, y = posY})
end

function ShopLayer:showEijiLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local sortData = {}
  for _, data in pairs(table.values(EijiCsv)) do
    data.left = data.limit == 0 and 999 or data.limit - game.role.sauceShop:getv(data.id, 0)
    table.insert(sortData, data)
  end
  table.sort(sortData, function(a, b)
    return (a.order or a.id) + (a.left == 0 and 10000 or 0) < (b.order or b.id) + (b.left == 0 and 10000 or 0)
  end)
  local rows = math.ceil(#sortData / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = sortData[index]
      if data then
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local icon = ItemIcon.new({
          type = data.gift:toArray("=", true)[1]
        })
        icon:pos(104, 140):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        if costId:getv(data.costId, 0) == 0 then
          costId = costId:setv(data.costId, 1)
        end
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        local left = data.limit == 0 and 999 or data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        if data.left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format("可\n购\n买\n%d\n次\n哦", data.left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            game:createView("shop.CommonItemCountLayer", {
              data = data,
              showType = "special",
              left = data.left,
              callback = function(num)
                game:sendData(actionCodes.Carbon_EijiBuyRpc, MsgPack.pack({
                  id = data.id,
                  count = num
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Carbon_EijiBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  local posY = self.specialList:getInnerContainerPosition().y
                  self.content2:removeAllChildren()
                  self:showEijiLayer(posY)
                  MedalRewardLayer.new({
                    items = msg.dropItems
                  })
                end)
              end
            })
          end)
        end
      end
    end
  end
  if costId ~= "" then
    local items = costId:toTableArray()
    local xPos = -110 * (#items - 1)
    for _, set in ipairs(items) do
      local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
      bg:setCallback(function()
        MTip:show({
          type = MTipType.path,
          node = bg,
          itemType = tonumber(set[1]),
          itemData = ItemCsv[tonumber(set[1])]
        })
      end)
      display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
      display.newTTFLabel({
        text = game.role.items[tonumber(set[1])] or 0,
        size = 24
      }):pos(49, 14):addTo(bg)
      xPos = xPos + 110
    end
  end
  self.specialList:forceDoLayout()
  self.specialList:stopAutoScroll()
  posY = posY or self.specialList:getInnerContainerPosition().y
  self.specialList:setInnerContainerPosition({x = 0, y = posY})
end

function ShopLayer:showDinerLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  game.role:requestDinerInfo(function()
    local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
    local sortArr = {}
    for _, data in pairs(DinerCsv) do
      local bShow, left = self:checkDinerSellItemShow(data)
      if bShow then
        local temp = clone(data)
        temp.left = left
        sortArr[#sortArr + 1] = temp
      end
    end
    table.sort(sortArr, function(a, b)
      local conditionA = a.left < 1 and a.limit ~= 0 and 10000 or 0
      local conditionB = b.left < 1 and b.limit ~= 0 and 10000 or 0
      return a.order + conditionA < b.order + conditionB
    end)
    local rows = math.ceil(#sortArr / 4)
    for row = 1, rows do
      local viewNode = ccui.Widget:create()
      viewNode:size(850, size.height + 7):addTo(self.specialList)
      for col = 1, 4 do
        local index = (row - 1) * 4 + col
        local data = sortArr[index]
        if not data then
          break
        end
        if costId:getv(data.costId, 0) == 0 then
          costId = costId:setv(data.costId, 1)
        end
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local gift = data.gift:toArray("=", true)
        if data.icon and data.icon ~= "" then
          display.newSprite(data.icon):pos(104, 140):addTo(cell)
        else
          ItemIcon.new({
            type = gift[1]
          }):pos(104, 140):addTo(cell)
        end
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        if data.left < 1 and data.limit ~= 0 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format(time2[data.refresh], data.left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            local posY = self.specialList:getInnerContainerPosition().y
            game:createView("shop.DinerGiftCountLayer", {
              index = data.id,
              func = function()
                self.content2:removeAllChildren()
                self:showDinerLayer(posY)
              end
            })
          end)
        end
      end
    end
    if costId ~= "" then
      local items = costId:toTableArray()
      local xPos = -110 * (#items - 1)
      for _, set in ipairs(items) do
        local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
        bg:setCallback(function()
          MTip:show({
            type = MTipType.path,
            node = bg,
            itemType = tonumber(set[1]),
            itemData = ItemCsv[tonumber(set[1])]
          })
        end)
        display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
        display.newTTFLabel({
          text = game.role.items[tonumber(set[1])] or 0,
          size = 24
        }):pos(49, 14):addTo(bg)
        xPos = xPos + 110
      end
    end
    self.specialList:forceDoLayout()
    self.specialList:stopAutoScroll()
    posY = posY or self.specialList:getInnerContainerPosition().y
    self.specialList:setInnerContainerPosition({x = 0, y = posY})
  end)
end

function ShopLayer:showSpecialLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local sortData, temp = {}, {}
  for _, data in pairs(table.values(ScoreCsv)) do
    if data.tag == 2 then
      if data.preId == 0 then
        table.insert(temp, data.id)
      elseif ScoreCsv[data.preId].limit == game.role.shopScoreRecord:getv(ScoreCsv[data.preId].id, 0) and data.limit > game.role.shopScoreRecord:getv(data.id, 0) then
        table.insert(sortData, data)
      end
    end
  end
  for _, index in pairs(temp) do
    local add = true
    for _, data in pairs(sortData) do
      if ScoreCsv[index].title == data.title and ScoreCsv[index].costId == data.costId then
        add = false
      end
    end
    if add then
      table.insert(sortData, ScoreCsv[index])
    end
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local rows = math.ceil(#sortData / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = sortData[index]
      if data then
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local icon
        if data.icon == "" then
          icon = ItemIcon.new({
            type = data.gift:toArray("=", true)[1],
            count = tonumber(data.gift:toArray("=", true)[2])
          })
        else
          icon = display.newSprite(data.icon)
        end
        icon:pos(104, 140):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        if costId:getv(data.costId, 0) == 0 and data.costId > 5 then
          costId = costId:setv(data.costId, 1)
        end
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        local left = data.limit == 0 and 999 or data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        if left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format("可\n购\n买\n%d\n次\n哦", left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            game:createView("shop.CommonItemCountLayer", {
              data = data,
              showType = "special",
              left = left,
              callback = function(num)
                if not game.role:activityIsOpen(100) then
                  SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_OPEN)
                  return true
                end
                game:sendData(actionCodes.Activity_shopBuyRpc, MsgPack.pack({
                  id = data.id,
                  count = num
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Activity_shopBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  local posY = self.specialList:getInnerContainerPosition().y
                  self.content2:removeAllChildren()
                  self:showSpecialLayer(posY)
                  MedalRewardLayer.new({
                    items = msg.reward
                  })
                end)
              end
            })
          end)
        end
      end
    end
  end
  if costId ~= "" then
    local items = costId:toTableArray()
    local xPos = -97 * (#items - 1)
    for _, set in ipairs(items) do
      local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
      bg:setCallback(function()
        MTip:show({
          type = MTipType.path,
          node = bg,
          itemType = tonumber(set[1]),
          itemData = ItemCsv[tonumber(set[1])]
        })
      end)
      display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
      display.newTTFLabel({
        text = game.role.items[tonumber(set[1])] or 0,
        size = 24
      }):pos(49, 14):addTo(bg)
      xPos = xPos + 97
    end
  end
  self.specialList:forceDoLayout()
  self.specialList:stopAutoScroll()
  posY = posY or self.specialList:getInnerContainerPosition().y
  self.specialList:setInnerContainerPosition({x = 0, y = posY})
end

function ShopLayer:showSpecialTempLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local sortData, temp = {}, {}
  for _, data in pairs(table.values(ScoreCsv)) do
    if data.tag == 99 then
      if data.preId == 0 then
        table.insert(temp, data.id)
      elseif ScoreCsv[data.preId].limit == game.role.shopScoreRecord:getv(ScoreCsv[data.preId].id, 0) and data.limit > game.role.shopScoreRecord:getv(data.id, 0) then
        table.insert(sortData, data)
      end
    end
  end
  for _, index in pairs(temp) do
    local add = true
    for _, data in pairs(sortData) do
      if ScoreCsv[index].title == data.title and ScoreCsv[index].costId == data.costId then
        add = false
      end
    end
    if add then
      table.insert(sortData, ScoreCsv[index])
    end
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local rows = math.ceil(#sortData / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = sortData[index]
      if data then
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local icon
        if data.icon == "" then
          icon = ItemIcon.new({
            type = data.gift:toArray("=", true)[1]
          })
        else
          icon = display.newSprite(data.icon)
        end
        icon:pos(104, 140):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        if costId:getv(data.costId, 0) == 0 and data.costId > 5 then
          costId = costId:setv(data.costId, 1)
        end
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        local left = data.limit == 0 and 999 or data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        if left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format("可\n购\n买\n%d\n次\n哦", left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          cell:setCallback(function()
            game:createView("shop.CommonItemCountLayer", {
              data = data,
              showType = "special",
              left = left,
              callback = function(num)
                if not game.role:activityIsOpen(100) then
                  SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_OPEN)
                  return true
                end
                game:sendData(actionCodes.Activity_shopBuyRpc, MsgPack.pack({
                  id = data.id,
                  count = num
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Activity_shopBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  local posY = self.specialList:getInnerContainerPosition().y
                  self.content2:removeAllChildren()
                  self:showSpecialTempLayer(posY)
                  MedalRewardLayer.new({
                    items = msg.reward
                  })
                end)
              end
            })
          end)
        end
      end
    end
  end
  if costId ~= "" then
    local items = costId:toTableArray()
    local xPos = -97 * (#items - 1)
    for _, set in ipairs(items) do
      local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
      bg:setCallback(function()
        MTip:show({
          type = MTipType.path,
          node = bg,
          itemType = tonumber(set[1]),
          itemData = ItemCsv[tonumber(set[1])]
        })
      end)
      display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
      display.newTTFLabel({
        text = game.role.items[tonumber(set[1])] or 0,
        size = 24
      }):pos(49, 14):addTo(bg)
      xPos = xPos + 97
    end
  end
  self.specialList:forceDoLayout()
  self.specialList:stopAutoScroll()
  posY = posY or self.specialList:getInnerContainerPosition().y
  self.specialList:setInnerContainerPosition({x = 0, y = posY})
end

function ShopLayer:showSpecialExtraLayer(posY)
  self.specialList:removeAllChildren()
  local costId = ""
  local size = display.newSprite(ShopRes .. "cell_bg_small_2.png"):getContentSize()
  local sortData, temp = {}, {}
  for _, data in pairs(table.values(ScoreCsv)) do
    if data.tag == 3 then
      if data.preId == 0 then
        table.insert(temp, data.id)
      elseif ScoreCsv[data.preId].limit == game.role.shopScoreRecord:getv(ScoreCsv[data.preId].id, 0) and data.limit > game.role.shopScoreRecord:getv(data.id, 0) then
        table.insert(sortData, data)
      end
    end
  end
  for _, index in pairs(temp) do
    local add = true
    for _, data in pairs(sortData) do
      if ScoreCsv[index].title == data.title and ScoreCsv[index].costId == data.costId then
        add = false
      end
    end
    if add then
      table.insert(sortData, ScoreCsv[index])
    end
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local rows = math.ceil(#sortData / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 7):addTo(self.specialList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = sortData[index]
      if data then
        local cell = UIHelper.newImageView(ShopRes .. (self.changeSkin and "cell_bg_small_2.png" or "cell_bg_small_1.png")):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
        display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 140):addTo(cell)
        local icon
        if data.icon == "" then
          icon = ItemIcon.new({
            type = data.gift:toArray("=", true)[1]
          })
        else
          icon = display.newSprite(data.icon)
        end
        icon:pos(104, 140):addTo(cell)
        display.newTTFLabel({
          text = data.title,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#c44507")
        }):pos(104, 67):addTo(cell)
        if costId:getv(data.costId, 0) == 0 and data.costId > 5 then
          costId = costId:setv(data.costId, 1)
        end
        display.newSprite(ItemCsv[data.costId].icon):scale(0.3):pos(85, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb(self.changeSkin and "#1464c0" or "#692807")
        }):anch(0, 0.5):pos(100, 25):addTo(cell)
        local left = data.limit == 0 and 999 or data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        if left < 1 then
          display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
        else
          if data.limit ~= 0 then
            local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
            display.newTTFLabel({
              text = string.format("可\n购\n买\n%d\n次\n哦", left),
              size = 16,
              align = ui.TEXT_ALIGN_CENTER,
              color = UIHelper.hex2rgb("#7f3014")
            }):pos(13, 54):addTo(countBg)
          end
          if data.id == 3487 then
            left = 1
          end
          cell:setCallback(function()
            game:createView("shop.CommonItemCountLayer", {
              data = data,
              showType = "special",
              left = left,
              callback = function(num)
                game:sendData(actionCodes.Activity_shopBuyRpc, MsgPack.pack({
                  id = data.id,
                  count = num,
                  resident = true
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Activity_shopBuyRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  local posY = self.specialList:getInnerContainerPosition().y
                  self.content2:removeAllChildren()
                  self:showSpecialExtraLayer(posY)
                  MedalRewardLayer.new({
                    items = msg.reward,
                    notShowEffect = true
                  })
                end)
              end
            })
          end)
        end
      end
    end
  end
  if costId ~= "" then
    local items = costId:toTableArray()
    local xPos = -110 * (#items - 1)
    for _, set in ipairs(items) do
      local bg = UIHelper.newImageView(ShopRes .. (self.changeSkin and "skin_num_bg_2.png" or "skin_num_bg_1.png")):pos(xPos, 0):addTo(self.content2)
      bg:setCallback(function()
        MTip:show({
          type = MTipType.path,
          node = bg,
          itemType = tonumber(set[1]),
          itemData = ItemCsv[tonumber(set[1])]
        })
      end)
      display.newSprite(ItemCsv[tonumber(set[1])].icon):scale(0.35):pos(5, 13):addTo(bg)
      display.newTTFLabel({
        text = game.role.items[tonumber(set[1])] or 0,
        size = 24
      }):pos(49, 14):addTo(bg)
      xPos = xPos + 110
    end
  end
  self.specialList:forceDoLayout()
  self.specialList:stopAutoScroll()
  posY = posY or self.specialList:getInnerContainerPosition().y
  self.specialList:setInnerContainerPosition({x = 0, y = posY})
end

function ShopLayer:showMoveText(parent)
  local bg = parent:getChildByName("tip")
  if bg then
    return
  end
  local bg = display.newSprite(ShopRes .. "tip_bg.png"):pos(0, -120):addTo(parent)
  bg:name("tip")
  bg:setOpacity(0)
  bg:setCascadeOpacityEnabled(true)
  display.newTTFLabel({
    text = "主厨，欢迎光临",
    size = 20
  }):pos(85, 28):addTo(bg)
  bg:runAction(transition.sequence({
    cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 30)), cc.FadeIn:create(0.2)),
    cc.DelayTime:create(1),
    cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 30)), cc.FadeOut:create(0.4)),
    cc.RemoveSelf:create()
  }))
end

function ShopLayer:checkDinerSellItemShow(data)
  local bShow = true
  local had = false
  local left = data.limit - game.role.diner.dinerShop:getv(data.id, 0)
  if data.gift == "" then
    if left == 0 and data.ownedFade == 1 then
      had = true
    end
  else
    local set = data.gift:toArray("=", true)
    local itemData = ItemCsv[set[1]]
    local endId = tonumber(itemData.content)
    if itemData.type == ItemType.DinerBox and game.role.diner.item_box[endId] and 0 < game.role.diner.item_box[endId] or itemData.type == ItemType.DinerCar and game.role.diner.item_car[endId] and 0 < game.role.diner.item_car[endId] or itemData.type == ItemType.Fitment and game.role.diner.item_fitment[endId] and 0 < game.role.diner.item_fitment[endId] then
      had = true
    elseif itemData.type == ItemType.Accessory then
      for _, acc in pairs(game.role.diner.accessories) do
        if acc.type == endId then
          had = true
          break
        end
      end
    elseif itemData.type == ItemType.Dress then
      if game.role.dressBook[endId] then
        had = true
      end
    elseif game.role.items[set[1]] and 0 < game.role.items[set[1]] then
      had = true
    end
  end
  if had and data.ownedFade == 1 then
    bShow = false
  end
  return bShow, left
end

return ShopLayer
