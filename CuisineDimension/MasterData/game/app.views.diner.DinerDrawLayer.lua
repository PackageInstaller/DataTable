local ItemCsv = require("csvdata.item")
local DinerBoxCsv = require("csvdata.diner_box")
local DrawRes = "ui/diner/draw/"
local FarmRes = "ui/farm/main/"
local OrderBuyRes = "ui/activity/30/"
local uiData = {
  csbFile = "ui/diner/DinerDrawLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    yunNode = "yunNode",
    bgNode = "bgNode",
    drawBg = "drawBg",
    btnPool_1 = "btnPool_1",
    btnPool_2 = "btnPool_2",
    btnOnce = "drawBg/btnOnce",
    btnTen = "drawBg/btnTen",
    imgNode = "drawBg/imgNode",
    countBg = "countBg",
    count = "countBg/count",
    btnBuy = "countBg/btnBuy"
  }
}
local DinerDrawLayer = class("DinerDrawLayer", UIBase)

function DinerDrawLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerDrawLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
  end
  TopBar:show(TopBarType.full, "邮购艇")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    delay = 0.1,
    time = 0.4
  })
  self:initAnimate()
  self.btnOnce:setTouchScale()
  self.btnOnce:setCallback(function()
    self:draw(1)
  end)
  self.btnTen:setTouchScale()
  self.btnTen:setCallback(function()
    self:draw(10)
  end)
  self.count:setString(game.role.items[7] or 0)
  self.countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg,
      itemType = 7,
      itemData = ItemCsv[7]
    })
  end)
  self.btnBuy:setCallback(function()
    game:createView("shop.ShopItemCountLayer", {
      index = 1005,
      func = function()
        self.count:setString(game.role.items[7] or 0)
      end
    })
  end)
  self.btnInfo = UIHelper.extend(ccui.Button:create())
  self.btnInfo:setImages("ui/tower/main/", {
    "btn_info.png",
    "btn_info.png"
  })
  self.btnInfo:pos(570, 379):addTo(self.drawBg)
  self.btnInfo:setTouchScale()
end

function DinerDrawLayer:showData(params)
  self.poolId = game.role:activityIsOpen(30) and 2 or 1
  if self.poolId == 2 then
    local group = MRadioGroup:create()
    local btnText = {
      "餐\n车\n邮\n购",
      "主\n题\n邮\n购"
    }
    for i = 1, 2 do
      local btn = self["btnPool_" .. i]
      btn:name("btn" .. i)
      btn:setCallback(function()
        if i == 2 and not game.role:activityIsOpen(30) then
          SysError(SYS_ERR_DINER_DRAW_POOL_NO_OPEN)
          group:chooseByName("btn" .. self.poolId)
          return
        end
        self.poolId = i
        self:showPool()
      end)
      display.newTTFLabel({
        text = btnText[i],
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(25, 73):addTo(btn):name("text")
      btn:setGroup(group)
    end
    group:chooseByName("btn" .. self.poolId)
  else
    self.btnPool_1:hide()
    self.btnPool_2:hide()
  end
  self:showPool()
end

function DinerDrawLayer:showPool()
  if self.poolId == 1 then
    self.btnInfo:setCallback(function()
      game:createView("global.RuleLayer", {typeStr = "diner_car"})
    end)
  else
    self.btnInfo:setCallback(function()
      game:createView("global.RuleLayer", {typeStr = "diner_box"})
    end)
  end
  if self.checkBtn then
    if self.poolId == 1 then
      self.checkBtn:hide()
    else
      self.checkBtn:show()
    end
  elseif self.poolId == 2 then
    self.checkBtn = UIHelper.extend(ccui.Button:create())
    self.checkBtn:setImages("ui/tower/main/", {
      "btn_check.png",
      "btn_check.png"
    })
    self.checkBtn:pos(550, 85):addTo(self.drawBg)
    self.checkBtn:setTouchScale()
    self.checkBtn:setCallback(function()
      local itemId = tonumber(globalCsv.specialBasePool:toArray("=", true)[1])
      local themeId = itemId % 5000
      local boxData = DinerBoxCsv[themeId][1]
      game:createView("diner.DinerTalentLayer", {boxData = boxData})
    end)
  end
  self.imgNode:removeAllChildren()
  self.btnOnce:removeAllChildren()
  self.btnTen:removeAllChildren()
  local draw_cost_1 = {
    globalCsv.dinerDraw_1,
    globalCsv.specialDinerDraw_1
  }
  local draw_cost_10 = {
    globalCsv.dinerDraw_10,
    globalCsv.specialDinerDraw_10
  }
  local price = 120
  local id1, count1 = draw_cost_1[self.poolId]:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count1, size = 26}):enableOutline(UIHelper.hex2rgb("#441603"), 1):pos(30, 34):addTo(self.btnOnce)
  display.newTTFLabel({text = "邮购1次", size = 26}):enableOutline(UIHelper.hex2rgb("#441603"), 1):pos(160, 34):addTo(self.btnOnce)
  local id2, count2 = draw_cost_10[self.poolId]:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count2, size = 26}):enableOutline(UIHelper.hex2rgb("#441603"), 1):pos(30, 34):addTo(self.btnTen)
  display.newTTFLabel({
    text = "邮购10次",
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#441603"), 1):pos(160, 34):addTo(self.btnTen)
  if price > tonumber(count1) then
    display.newSprite(DrawRes .. string.format("off_%d.png", (price - tonumber(count1)) / price * 100)):pos(135, 58):addTo(self.btnOnce)
  end
  if tonumber(count2) < price * 10 then
    display.newSprite(DrawRes .. string.format("off_%d.png", (price * 10 - tonumber(count2)) / (price * 10) * 100)):pos(135, 58):addTo(self.btnTen)
  end
  display.newSprite(DrawRes .. "image_bg_" .. self.poolId .. ".png"):addTo(self.imgNode)
  if self.poolId == 1 then
    local num = game.role.diner.drawEnsure + 1
    display.newSprite(OrderBuyRes .. "count_bg.png"):pos(0, -150):addTo(self.imgNode)
    local lab = display.newTTFLabel({
      text = "邮购:" .. num .. "/" .. "100",
      size = 22,
      color = UIHelper.hex2rgb("#fff112")
    }):pos(0, -150):addTo(self.imgNode):name("drawNum")
  elseif self.poolId == 2 then
    local Data = game.role.activityStatus["30"] or ""
    display.newSprite(OrderBuyRes .. "count_bg.png"):pos(0, -150):addTo(self.imgNode)
    local lab = display.newTTFLabel({
      text = "邮购:" .. Data:getv(0, 0) .. "/" .. globalCsv.specialBaseNum,
      size = 22,
      color = UIHelper.hex2rgb("#fff112")
    }):pos(0, -150):addTo(self.imgNode):name("drawNum")
    if Data:getv(0, 0) == -1 then
      lab:setString("已完成")
    end
  end
end

function DinerDrawLayer:initAnimate()
  local cloud = UIHelper.createSpineNodeByRes("spine/ui/farm/yun_hou"):pos(0, 0):addTo(self.yunNode)
  cloud:setAnimation(0, "special", true)
  display.newSprite(FarmRes .. "bg2.png"):anch(1, 0):pos(990, -1080):addTo(self.bgNode)
  local spine = UIHelper.createSpineNodeByRes(FarmRes .. "feichuan")
  spine:setAnimation(0, "idle", true)
  spine:pos(300, 255):addTo(self.bgNode)
  display.newSprite(FarmRes .. "bg_part.png"):anch(0, 0):pos(-60, -260):addTo(self.bgNode)
end

function DinerDrawLayer:draw(num)
  if self.poolId == 2 and not game.role:activityIsOpen(30) then
    SysError(SYS_ERR_DINER_DRAW_POOL_NO_OPEN)
    return
  end
  if game.role:isMaxAccess() then
    SysError(SYS_ERR_DINER_DRAW_ACCESS_FULL)
    return
  end
  local id, count = globalCsv[(self.poolId == 1 and "dinerDraw_" or "specialDinerDraw_") .. num]:match("(%d+)=(%d+)")
  local have = game.role.items[tonumber(id)] or 0
  local need = tonumber(count)
  if have < need then
    local num = math.ceil((need - have) / 120)
    local str = string.format("金币不足，是否花费 <img src='ui/global/5.png' scale=0.4 />x%d 购买 <img src='ui/global/7.png' scale=0.4 />x%d？", num * 80, num * 120)
    MDialog:double({
      title = "提示",
      text = str,
      okCallback = function()
        if (game.role.diamond or 0) < num * 80 then
          UIHelper.showDiamondTip({parent = self})
        else
          if num < 1 then
            return
          end
          game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({index = 1005, num = num}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.items
            })
            self.count:setString(game.role.items[7] or 0)
          end)
        end
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
    return
  end
  game:sendData(actionCodes.Diner_drawRewardRpc, MsgPack.pack({
    id = self.poolId,
    type = num == 1 and 1 or 2
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Diner_drawRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.count:setString(game.role.items[7] or 0)
    self.reward = msg.reward
    self.closeCount = 0
    self.needCloseCount = #self.reward
    for i = 1, #self.reward do
      if self.reward[i].changeId then
        self.needCloseCount = self.needCloseCount + 1
      end
    end
    local numLabel = self.imgNode:getChildByName("drawNum")
    if numLabel then
      if self.poolId == 1 then
        local num = game.role.diner.drawEnsure + 1
        numLabel:setString("邮购:" .. num .. "/" .. "100")
      elseif self.poolId == 2 then
        local Data = game.role.activityStatus["30"] or ""
        if Data:getv(0, 0) == -1 then
          numLabel:setString("已完成")
        else
          numLabel:setString("邮购:" .. Data:getv(0, 0) .. "/" .. globalCsv.specialBaseNum)
        end
      end
    end
    self:showAnimation()
  end)
end

function DinerDrawLayer:showAnimation()
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
  local spine = UIHelper.createSpineNodeByRes(DrawRes .. "feichuan")
  spine:setAnimation(0, "bg", false)
  spine:pos(self.mask:getContentSize().width / 2, display.cy + 4):addTo(self.mask)
  if isIphonex then
    UIHelper.fitForiPhoneX(spine)
  end
  spine:runAction(transition.sequence({
    cc.DelayTime:create(10),
    cc.CallFunc:create(function()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end),
    cc.RemoveSelf:create()
  }))
  self.mask:setCallback(function()
    if not tolua.isnull(spine) then
      spine:stopAllActions()
      self.mask:removeAllChildren()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end
  end)
end

function DinerDrawLayer:showItems()
  self.Pos = {}
  local backStr = ""
  if #self.reward == 1 then
    self.Pos[1] = {
      display.cx,
      display.cy
    }
    if UIHelper.isiPhoneX() then
      self.Pos[1][1] = self.Pos[1][1] + UIHelper.getMoveXForX()
    end
    backStr = globalCsv.dinerDrawBack_1
  else
    local xPos, yPos = 270, 425
    if UIHelper.isiPhoneX() then
      xPos = xPos + UIHelper.getMoveXForX()
    end
    for index = 1, 10 do
      self.Pos[index] = {xPos, yPos}
      xPos = xPos + 150
      if index == 5 then
        xPos = 270
        if UIHelper.isiPhoneX() then
          xPos = xPos + UIHelper.getMoveXForX()
        end
        yPos = 245
      end
    end
    backStr = globalCsv.dinerDrawBack_10
  end
  local drawBack
  for _, backReward in pairs(backStr:toArray(" ", false)) do
    local temp = backReward:toArray("=", true)
    if temp[1] == self.poolId then
      drawBack = temp
      break
    end
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  local di = display.newSprite(DrawRes .. "reward_bg.png"):pos(cx, display.cy + 53):addTo(self.mask)
  di:setScaleY(0)
  di:runAction(transition.sequence({
    cc.ScaleTo:create(0.1, 1, 1),
    cc.CallFunc:create(function()
      self:open(1)
      if drawBack then
        MRichText.new({
          text = string.format("<div color=#ffffff outline=1,#441603>额外获得<img src=" .. ItemCsv[drawBack[2]].icon .. " scale=0.3 />x" .. drawBack[3] .. "</div>", globalCsv.tourRewardTimes - game.role.dailyExploreBox),
          size = 18,
          color = UIHelper.hex2rgb("#51a6d0")
        }):anch(0.5, 0.5):pos(cx, 135):addTo(self.mask)
      end
    end)
  }))
end

function DinerDrawLayer:open(index)
  if index > #self.Pos then
    return
  end
  local itemType = ItemCsv[self.reward[index].id].type
  local bg
  if itemType == ItemType.DinerCar or itemType == ItemType.DinerBox or itemType == ItemType.Fitment then
    bg = display.newSprite(DrawRes .. "card_bg2.png")
    if itemType == ItemType.DinerCar or itemType == ItemType.DinerBox then
      local flash = UIHelper.loadAnimation(DrawRes, "draw", 10, 10)
      flash.sprite:center(bg):addTo(bg)
      flash.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      flash.sprite:playAnimationForever(flash.animation)
    end
  else
    bg = display.newSprite(DrawRes .. "card_bg.png")
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  bg:pos(cx, display.cy):addTo(self.mask, nil, index):setScale(0)
  local name = display.newTTFLabel({
    text = ItemCsv[self.reward[index].id].name,
    size = 20,
    color = UIHelper.hex2rgb("#763636")
  }):pos(70, 22):addTo(bg)
  local countLab = display.newTTFLabel({
    text = "x" .. self.reward[index].count,
    size = 18,
    color = UIHelper.hex2rgb("#763636")
  }):anch(1, 0.5):pos(132, 50):addTo(bg):hide()
  local icon
  if itemType == ItemType.DinerCar or itemType == ItemType.DinerBox or itemType == ItemType.Fitment then
    icon = UIHelper.newImageView(ItemCsv[self.reward[index].id].icon):pos(70, 105):addTo(bg)
    icon:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = itemType,
        itemData = ItemCsv[self.reward[index].id],
        count = 0
      })
    end)
    if self.reward[index].count > 1 then
      countLab:show()
    end
  else
    icon = ItemIcon.new({
      type = self.reward[index].id,
      count = 0,
      showTip = true
    }):pos(70, 105):addTo(bg)
  end
  local action = {
    transition.sequence({
      cc.EaseExponentialOut:create(cc.ScaleTo:create(0.05, 1)),
      cc.DelayTime:create(0.1),
      cc.MoveTo:create(0.1, cc.p(self.Pos[index][1], self.Pos[index][2])),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    }),
    transition.sequence({
      cc.DelayTime:create(0.15),
      cc.CallFunc:create(function()
        self:open(index + 1)
      end)
    })
  }
  if self.reward[index].changeId then
    action[#action + 1] = transition.sequence({
      cc.DelayTime:create(0.15 * (#self.reward - index) + 0.5),
      cc.ScaleTo:create(0.1, 0, 1),
      cc.CallFunc:create(function()
        icon:removeSelf()
        ItemIcon.new({
          type = self.reward[index].changeId,
          count = self.reward[index].changeCount,
          showTip = true
        }):pos(70, 105):addTo(bg)
        name:setString(ItemCsv[self.reward[index].changeId].name)
        countLab:hide()
      end),
      cc.ScaleTo:create(0.05, 1, 1),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    })
  end
  bg:runAction(cc.Spawn:create(action))
end

function DinerDrawLayer:checkCanClose()
  self.closeCount = self.closeCount + 1
  if self.closeCount >= self.needCloseCount then
    self.mask:setCallback(function()
      self.mask:removeSelf()
    end)
  end
end

return DinerDrawLayer
