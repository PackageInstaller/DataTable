local WasteRes = "ui/wasteland/"
local NewCarbonRes = "ui/general/newcarbon/"
local WasteCsv = require("csvdata.wasteland_draw")
local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/wasteland/WastelandLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    mainBg = "mainBg",
    heroBg = "heroBg",
    normalBtn = "normalBtn",
    specialBtn = "specialBtn",
    exit = "mainBg/exit",
    drawItemInfo = "mainBg/drawItemInfo",
    help = "mainBg/help",
    draw1Btn = "mainBg/draw1Btn",
    draw1Item = "mainBg/draw1Btn/drawItem",
    draw10Btn = "mainBg/draw10Btn",
    draw10Item = "mainBg/draw10Btn/drawItem",
    rewardMask = "rewardMask",
    rewardInfoBg = "rewardInfoBg",
    scrollView = "rewardInfoBg/priceScrollView"
  }
}
local WastelandLayer = class("WastelandLayer", UIBase)

function WastelandLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function WastelandLayer:init(params)
  self.rewardMask:setVisible(false)
  self.rewardInfoBg:setVisible(false)
  self.heroBg:setContentSize(cc.size(906, 908))
  self.heroBg:setScale(0.7)
  self.curStatus = game.role.activityStatus["78"]
  self.select = params.select or 1
  self.drawId = self.select == 1 and 45001 or 45002
  self.drawCountBg = UIHelper.newImageView(NewCarbonRes .. "btn_add2_bg.png"):anch(0.5, 0.5):pos(120, 330):addTo(self.mainBg)
  
  local function initdrawCountBg()
    self.drawCountBg:removeAllChildren()
    display.newSprite(ItemCsv[self.drawId].icon):scale(0.5):pos(5, 21):addTo(self.drawCountBg)
    self.drawCountBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = self.drawCountBg,
        itemType = self.drawId,
        itemData = ItemCsv[self.drawId]
      })
    end)
    local couponLabel = display.newTTFLabel({
      text = game.role.items[self.drawId] or 0,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(77, 17):addTo(self.drawCountBg)
  end
  
  initdrawCountBg()
  local tempBtn = self.select == 1 and self.normalBtn or self.specialBtn
  tempBtn:setPositionX(tempBtn:getPositionX() - 30)
  self.normalBtn:setCallback(function()
    if self.select == 1 then
      return
    end
    self.select = 1
    self.drawId = 45001
    initdrawCountBg()
    self.normalBtn:setPositionX(self.normalBtn:getPositionX() - 30)
    self.specialBtn:setPositionX(self.normalBtn:getPositionX() + 30)
    self.mainBg:setImage(WasteRes .. "bg1.png")
    self.draw1Item:setImage(WasteRes .. "drawpool1.png")
    self.draw10Item:setImage(WasteRes .. "drawpool1.png")
  end)
  self.specialBtn:setCallback(function()
    if self.select == 2 then
      return
    end
    self.select = 2
    self.drawId = 45002
    initdrawCountBg()
    self.normalBtn:setPositionX(self.normalBtn:getPositionX() + 30)
    self.specialBtn:setPositionX(self.normalBtn:getPositionX() - 30)
    self.mainBg:setImage(WasteRes .. "bg2.png")
    self.draw1Item:setImage(WasteRes .. "drawpool2.png")
    self.draw10Item:setImage(WasteRes .. "drawpool2.png")
  end)
  self.exit:setCallback(function()
    self:close()
  end)
  self.drawItemInfo:setCallback(function()
    local haveDraw = self.select == 1 and self.curStatus.haveDraw1 or self.curStatus.haveDraw2
    self.rewardMask:setVisible(true)
    self.scrollView:removeAllChildren()
    self.scrollView:setScrollBarEnabled(false)
    if self.bigPriceItemList then
      for _, node in pairs(self.bigPriceItemList) do
        node:removeSelf()
      end
    end
    local csvData = WasteCsv[self.select]
    local bigPriceList = {}
    local priceList = {}
    self.bigPriceItemList = {}
    for i = 1, #csvData do
      if csvData[i].extraReward == 0 then
        if csvData[i].prize == 1 then
          bigPriceList[#bigPriceList + 1] = csvData[i]
        else
          priceList[#priceList + 1] = csvData[i]
        end
      end
    end
    for i = 1, #bigPriceList do
      local giftData = bigPriceList[i].gift:toArray("=", true)
      local itemNode = ItemIcon.new({
        type = giftData[1],
        count = giftData[2],
        showTip = true
      }):scale(0.8):pos(80 * ((i - 1) % 7 + 1), 320):addTo(self.rewardInfoBg)
      self.bigPriceItemList[#self.bigPriceItemList + 1] = itemNode
      if haveDraw:getv(bigPriceList[i].id, 0) >= bigPriceList[i].group then
        display.newSprite(WasteRes .. "done.png"):anch(0.5, 0.5):pos(45, 45):addTo(itemNode)
      end
    end
    local maxHeight = (math.floor((#priceList - 1) / 7) + 1) * 80
    self.scrollView:setInnerContainerSize(cc.size(600, 200 < maxHeight and maxHeight or 200))
    for i = 1, #priceList do
      priceList[i].isDrawed = haveDraw:getv(priceList[i].id, 0) >= priceList[i].group
    end
    table.sort(priceList, function(a, b)
      if a.isDrawed and not b.isDrawed then
        return false
      end
      if not a.isDrawed and b.isDrawed then
        return true
      end
      return a.id < b.id
    end)
    for i = 1, #priceList do
      local giftData = priceList[i].gift:toArray("=", true)
      local itemNode = ItemIcon.new({
        type = giftData[1],
        count = giftData[2],
        showTip = true
      }):scale(0.8):pos(80 * ((i - 1) % 7 + 1) - 20, (200 < maxHeight and maxHeight or 200) - 40 - 80 * math.floor((i - 1) / 7)):addTo(self.scrollView)
      if priceList[i].isDrawed then
        display.newSprite(WasteRes .. "done.png"):anch(0.5, 0.5):pos(45, 45):addTo(itemNode)
      end
    end
    self.rewardInfoBg:setVisible(true)
  end)
  self.rewardMask:setCallback(function()
    self.rewardMask:setVisible(false)
    self.rewardInfoBg:setVisible(false)
  end)
  self.help:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_78"
    })
  end)
  self.draw1Btn:setCallback(function()
    if (game.role.items[self.drawId] or 0) < 1 then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_wastelandDrawRpc, MsgPack.pack({
      id = self.select,
      count = 1
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_wastelandDrawRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self.curStatus = game.role.activityStatus["78"]
      initdrawCountBg()
      self:showAnimation()
    end)
  end)
  self.draw10Btn:setCallback(function()
    if (game.role.items[self.drawId] or 0) < 10 then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_wastelandDrawRpc, MsgPack.pack({
      id = self.select,
      count = 10
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_wastelandDrawRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self.curStatus = game.role.activityStatus["78"]
      initdrawCountBg()
      self:showAnimation()
    end)
  end)
end

function WastelandLayer:showAnimation()
  self.mask = UIHelper.extend(ccui.Layout:create())
  local isIphonex = false
  if UIHelper.isiPhoneX() then
    isIphonex = true
    self.mask:size(display.width + UIHelper.getMoveXForX() * 2, display.height)
  else
    self.mask:size(display.width, display.height)
  end
  self.mask:setBackGroundColorType(1)
  self.mask:setBackGroundColor(cc.c3b(0, 0, 0))
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:setBackGroundColorOpacity(0)
  self.mask:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  local spine = UIHelper.createSpineNodeByRes("ui/diner/draw/feichuan")
  spine:setAnimation(0, "bg", false)
  spine:pos(self.mask:getContentSize().width / 2, display.cy + 4):addTo(self.mask)
  if isIphonex then
    UIHelper.fitForiPhoneX(spine)
  end
  spine:runAction(transition.sequence({
    cc.DelayTime:create(10),
    cc.CallFunc:create(function()
      self.mask:setBackGroundColorOpacity(191)
      self.mask:removeSelf()
    end),
    cc.RemoveSelf:create()
  }))
  self.mask:setCallback(function()
    if not tolua.isnull(spine) then
      spine:stopAllActions()
      self.mask:removeAllChildren()
      self.mask:setBackGroundColorOpacity(191)
      self.mask:removeSelf()
    end
  end)
end

function WastelandLayer:isHaveEnoughPool(tryCount)
  local haveDraw = self.select == 1 and self.curStatus.haveDraw1 or self.curStatus.haveDraw2
  local csvData = WasteCsv[self.select]
  local bigPriceList = {}
  local priceList = {}
  local drawed = 0
  for i = 1, #csvData do
    if csvData[i].extraReward == 0 then
      if csvData[i].prize == 1 then
        bigPriceList[#bigPriceList + 1] = csvData[i]
      else
        priceList[#priceList + 1] = csvData[i]
      end
    end
  end
  local bigPriceLength = #bigPriceList
  local priceLength = #priceList
  for i = 1, bigPriceLength do
    bigPriceList[i].isDrawed = haveDraw:getv(bigPriceList[i].id, 0) >= bigPriceList[i].group
    if bigPriceList[i].isDrawed then
      drawed = drawed + 1
    end
  end
  for i = 1, priceLength do
    priceList[i].isDrawed = haveDraw:getv(priceList[i].id, 0) >= priceList[i].group
    if priceList[i].isDrawed then
      drawed = drawed + 1
    end
  end
  return tryCount <= bigPriceLength + priceLength - drawed
end

return WastelandLayer
