local ShopCsv = require("csvdata.union_shop")
local BookCsv = require("csvdata.handbook")
local ItemCsv = require("csvdata.item")
local ShopScoreCsv = require("csvdata.shop_score")
local ShopRes = "ui/shop/main/"
local IconRes = "icon/union_shop/"
local uiData = {
  csbFile = "ui/union/UnionShopLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    topBar = "topBar",
    panel1 = "panel1",
    heroNode = "panel1/heroNode",
    content1 = "panel1/contentBg/content",
    normalList = "panel1/contentBg/list",
    normalBtn1 = "panel1/btn1",
    normalBtn2 = "panel1/btn2",
    normalBtn3 = "panel1/btn3"
  }
}
local UnionShopLayer = class("UnionShopLayer", UIBase)

function UnionShopLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionShopLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
  end
  self.mainBg:setTouchEnabled(true)
  self.mainBg:setSwallowTouches(true)
  TopBar:show(TopBarType.shop, "公会商店")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.union = game.role.unionData
  self:initLayerButton()
  self:initUnionList()
  self:initHeroCard()
end

function UnionShopLayer:initLayerButton()
  self.buttonData = {
    [1] = {
      name = "协会商店",
      callback = handler(self, self.initUnionList)
    },
    [2] = {
      name = "个人商店",
      callback = handler(self, self.initSelfList)
    },
    [3] = {
      name = "竞赛商店",
      callback = handler(self, self.initBattleList)
    }
  }
  local group1 = MRadioGroup:create()
  for index, data in ipairs(self.buttonData) do
    local btn = self["normalBtn" .. index]
    btn:name("btn" .. index)
    btn:setCallback(function()
      data.callback(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(75, 23):addTo(btn)
    btn:setGroup(group1)
  end
  group1:chooseByName("btn" .. 1)
end

function UnionShopLayer:initHeroCard()
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
end

function UnionShopLayer:initUnionList()
  self.normalList:removeAllChildren()
  self.content1:removeAllChildren()
  local bg = UIHelper.newImageView(ShopRes .. "skin_num_bg_1.png"):addTo(self.content1)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = 123,
      itemData = ItemCsv[123]
    })
  end)
  display.newSprite(IconRes .. "caifu.png"):scale(0.4):pos(5, 12):addTo(bg)
  self.moneyText = display.newTTFLabel({
    text = self.union.money,
    size = 24
  }):pos(47, 14):addTo(bg)
  local showCsv = {}
  for _, data in pairs(ShopCsv) do
    if data.id < 1000 then
      table.insert(showCsv, data)
    end
  end
  table.sort(showCsv, function(a, b)
    return a.id < b.id
  end)
  local unionShopBuyData = self.union.unionShop:toNumMap()
  for index, data in pairs(showCsv) do
    for buyId, buydata in pairs(unionShopBuyData) do
      if index == buyId then
        data.buy = buydata
        break
      end
    end
    if not data.buy then
      data.buy = 0
    end
  end
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
        type = data.itemId
      }):pos(104, 145):addTo(cell)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite(IconRes .. "caifu.png"):scale(0.5):pos(80, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0.5, 0.5):pos(123, 25):addTo(cell)
      if data.id == 1 then
        display.newTTFLabel({
          text = "已拥有: " .. self.union.techCore,
          size = 17,
          color = UIHelper.hex2rgb("#1f8200")
        }):pos(104, 90):addTo(cell)
      end
      if data.preId ~= 0 and (self.union.unionTech:getv(data.preId, -1) ~= 1 or self.union.unionTechHaveCost ~= 1) then
        display.newSprite(ShopRes .. "cell_bg_mask_1.png"):anch(0, 0):pos(0, 0):addTo(cell)
      elseif data.buy >= data.limit then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
      else
        local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
        display.newTTFLabel({
          text = string.format("可\n购\n买\n%d\n次", data.limit - data.buy),
          size = 16,
          align = ui.TEXT_ALIGN_CENTER,
          color = UIHelper.hex2rgb("#7f3014")
        }):pos(13, 54):addTo(countBg)
        cell:setCallback(function()
          local manageLevel = self.union.managers:getv(game.role.id, 0)
          if manageLevel ~= 0 then
            game:createView("union.UnionShopCountLayer", {
              index = data.id,
              money = self.union.money,
              func = function()
                self.moneyText:setString(self.union.money)
                self:initUnionList()
              end
            })
          else
            SysError(SYS_ERR_UNION_NOT_BOSS)
          end
        end)
      end
    end
  end
  self.normalList:requestDoLayout()
end

function UnionShopLayer:initSelfList()
  self.normalList:removeAllChildren()
  self.content1:removeAllChildren()
  local bg = UIHelper.newImageView(ShopRes .. "skin_num_bg_1.png"):addTo(self.content1)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = bg,
      itemType = 124,
      itemData = ItemCsv[124]
    })
  end)
  display.newSprite(IconRes .. "gongxian.png"):scale(0.4):pos(5, 12):addTo(bg)
  self.moneyText = display.newTTFLabel({
    text = game.role.unionScore,
    size = 24
  }):pos(47, 14):addTo(bg)
  local showCsv = {}
  for _, data in pairs(ShopCsv) do
    if data.id > 1000 and data.id <= 2000 then
      table.insert(showCsv, data)
    end
  end
  local unionSelfShopBuyData = game.role.unionSelfShop:toNumMap()
  for index, data in pairs(showCsv) do
    for buyId, buydata in pairs(unionSelfShopBuyData) do
      if data.id == buyId then
        data.buy = buydata
        break
      end
    end
    if not data.buy then
      data.buy = 0
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
      ItemIcon.new({
        type = data.itemId
      }):pos(104, 145):addTo(cell)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite(IconRes .. "gongxian.png"):scale(0.5):pos(80, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0.5, 0.5):pos(123, 25):addTo(cell)
      if data.preId ~= 0 and (self.union.unionTech:getv(data.preId, -1) ~= 1 or self.union.unionTechHaveCost ~= 1) then
        display.newSprite(ShopRes .. "cell_bg_mask_1.png"):anch(0, 0):pos(0, 0):addTo(cell)
      elseif data.buy >= data.limit then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
      else
        local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
        display.newTTFLabel({
          text = string.format("可\n购\n买\n%d\n次", data.limit - data.buy),
          size = 16,
          align = ui.TEXT_ALIGN_CENTER,
          color = UIHelper.hex2rgb("#7f3014")
        }):pos(13, 54):addTo(countBg)
        cell:setCallback(function()
          game:createView("union.UnionShopCountLayer", {
            index = data.id,
            money = game.role.unionScore,
            func = function()
              self.moneyText:setString(game.role.unionScore)
              self:initSelfList()
            end
          })
        end)
      end
    end
  end
  self.normalList:requestDoLayout()
end

function UnionShopLayer:initBattleList()
  self.content1:removeAllChildren()
  self.normalList:removeAllChildren()
  local showCsv = {}
  for _, data in pairs(ShopCsv) do
    if data.id > 10000 then
      table.insert(showCsv, data)
    end
  end
  for index, data in pairs(showCsv) do
    local buyCount = game.role.shopScoreRecord:getv(data.id, 0)
    data.buy = buyCount
    if not data.buy then
      data.buy = 0
    end
  end
  table.sort(showCsv, function(a, b)
    return a.order < b.order
  end)
  local costIds = ""
  
  local function showCoin()
    if costIds ~= "" then
      print("costId", costIds)
      local items = costIds:toTableArray()
      local xPos = -110 * (#items - 1)
      for _, set in ipairs(items) do
        local bg = UIHelper.newImageView(ShopRes .. "skin_num_bg_1.png"):pos(xPos, 0):addTo(self.content1)
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
  end
  
  local size = display.newSprite(ShopRes .. "cell_bg_1.png"):getContentSize()
  local rows = math.ceil(#showCsv / 4)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(850, size.height + 4):addTo(self.normalList)
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = showCsv[index]
      if not data then
        showCoin()
        self.normalList:requestDoLayout()
        return
      end
      if costIds:getv(data.costId, 0) == 0 then
        costIds = costIds:setv(data.costId, 1)
      end
      local set = data.gift:toArray("=", true)
      local cell = UIHelper.newImageView(ShopRes .. "cell_bg_1.png"):anch(0, 0):pos(3 + (col - 1) * 212, 3):addTo(viewNode)
      display.newSprite(ShopRes .. "cell_image_bg.png"):pos(104, 145):addTo(cell)
      ItemIcon.new({
        type = data.itemId,
        count = tonumber(set[2]),
        showTip = true
      }):pos(104, 145):addTo(cell)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#c44507")
      }):pos(104, 67):addTo(cell)
      display.newSprite(ItemCsv[data.costId].icon):scale(0.4):pos(80, 24):addTo(cell)
      display.newTTFLabel({
        text = data.cost,
        size = 22,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0.5, 0.5):pos(123, 25):addTo(cell)
      if data.buy >= data.limit then
        display.newSprite(ShopRes .. "cell_image_out.png"):pos(105, 130):addTo(cell)
      else
        local countBg = display.newSprite(ShopRes .. "cell_times_bg.png"):pos(24, 135):addTo(cell)
        display.newTTFLabel({
          text = string.format("可\n购\n买\n%d\n次", data.limit - data.buy),
          size = 16,
          align = ui.TEXT_ALIGN_CENTER,
          color = UIHelper.hex2rgb("#7f3014")
        }):pos(13, 54):addTo(countBg)
        local left = data.limit - game.role.shopScoreRecord:getv(data.id, 0)
        cell:setCallback(function()
          game:createView("shop.CommonItemCountLayer", {
            data = data,
            showType = "special",
            left = left,
            callback = function(num)
              game:sendData(actionCodes.Activity_shopBuyRpc, MsgPack.pack({
                id = data.id,
                type = "unionBattle",
                count = num,
                resident = true
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_shopBuyRpc, function(event)
                UIHelper.removeWaiting()
                local msg = MsgPack.unpack(event.data)
                MedalRewardLayer.new({
                  items = msg.reward
                })
                self:initBattleList()
              end)
            end
          })
        end)
      end
    end
  end
  showCoin()
  self.normalList:requestDoLayout()
end

function UnionShopLayer:showMoveText(parent)
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

return UnionShopLayer
