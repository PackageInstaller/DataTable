local ActivityManager = require("app.models.ActivityManager")
local ItemCsv = require("csvdata.item")
local activity106TaskCsv = require("csvdata.activity_106_task")
local RechargeCsv = require("csvdata.recharge")
local activityType = "106"
local Show106Res = "ui/activity/106/"
local sdkInterface = require("sdk.SDKInterface")
local Activity106Layer = {}
Activity106Layer.mainLayer = nil

function Activity106Layer:init(mainLayer)
  Activity106Layer.mainLayer = mainLayer
  self.content = mainLayer.content
  self.activityStatus = game.role.activityStatus[activityType] or {}
  self.mainBg = display.newSprite(Show106Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local heroId = game.role.crown
  if heroId == 0 then
    return
  end
  self.heroId = heroId
  self.bigcard = HeroBigCard.new({heroId = heroId, showPic = true})
  self.bigcard:pos(180, 236):scale(0.8):addTo(self.mainBg)
  self.bigcard:setCascadeOpacityEnabled(true)
  if (self.activityStatus.unlock or ""):getv(1, 0) == 0 then
    local unlockBtn1 = UIHelper.extend(ccui.Button:create())
    unlockBtn1:setImages(Show106Res, {
      "btn_unlocak1.png",
      "btn_unlocak1.png"
    })
    unlockBtn1:anch(0.5, 0.5):pos(416, 53):addTo(self.mainBg)
    unlockBtn1:setCallback(function()
      local unlock = self.activityStatus.unlock or ""
      if unlock:getv(1, 0) == 1 then
        MFlashMsg:show({
          text = "潮翻浪涌奖励已解锁"
        })
        return
      end
      MDialog:double({
        text = "是否支付￥" .. globalCsv.activity106UnlockCoust1 .. "解锁潮翻浪涌奖励？"
      }, function()
        local rechargeData = RechargeCsv[globalCsv.Activity106RechargeId1]
        self:sendBuyMsg(rechargeData, function()
          self:showTasks()
          if unlockBtn1 then
            unlockBtn1:removeSelf()
          end
        end)
      end)
    end)
  end
  if (self.activityStatus.unlock or ""):getv(2, 0) == 0 then
    local unlockBtn2 = UIHelper.extend(ccui.Button:create())
    unlockBtn2:setImages(Show106Res, {
      "btn_unlocak2.png",
      "btn_unlocak2.png"
    })
    unlockBtn2:anch(0.5, 0.5):pos(596, 53):addTo(self.mainBg)
    unlockBtn2:setCallback(function()
      local unlock = self.activityStatus.unlock or ""
      if unlock:getv(2, 0) == 1 then
        MFlashMsg:show({
          text = "篝火欢歌奖励已解锁"
        })
        return
      end
      MDialog:double({
        text = "是否支付￥" .. globalCsv.activity106UnlockCoust2 .. "解锁篝火欢歌奖励？"
      }, function()
        local rechargeData = RechargeCsv[globalCsv.Activity106RechargeId2]
        self:sendBuyMsg(rechargeData, function()
          self:showTasks()
          if unlockBtn2 then
            unlockBtn2:removeSelf()
          end
        end)
      end)
    end)
  end
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(Show106Res, {"btn_go.png", "btn_go.png"})
  btnGo:anch(0.5, 0.5):pos(776, 53):addTo(self.mainBg)
  btnGo:setCallback(function()
    local layer = game:createView("activity.Activity106GameLayer", {
      heroId = self.heroId
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
      self:showTasks()
    end)
  end)
  local btnChange = UIHelper.extend(ccui.Button:create())
  btnChange:setImages(Show106Res, {
    "btn_change.png",
    "btn_change.png"
  })
  btnChange:anch(0.5, 0.5):pos(60, 50):addTo(self.mainBg):setTouchScale()
  btnChange:setCallback(function()
    self:chooseMainHero()
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(Show106Res, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 492):addTo(self.mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity106"
    })
  end)
  local taskBg = display.newSprite(Show106Res .. "task_bg.png"):pos(265, 83):anch(0, 0):addTo(self.mainBg)
  self.taskList = ccui.ListView:create()
  self.taskList:size(cc.size(430, 270))
  self.taskList:setInnerContainerSize(cc.size(430, 270))
  self.taskList:setClippingEnabled(true)
  self.taskList:setBounceEnabled(true)
  self.taskList:anch(0, 0):pos(394, 135):addTo(self.mainBg)
  self:showTasks()
end

function Activity106Layer:showTasks()
  self.taskList:removeAllChildren()
  self.activityStatus = game.role.activityStatus[activityType] or {}
  local offsetY = 65
  local taskDataList = {}
  local unlock = self.activityStatus.unlock or ""
  for _, data in pairs(activity106TaskCsv) do
    table.insert(taskDataList, data)
  end
  table.sort(taskDataList, function(a, b)
    return a.order < b.order
  end)
  for i, data in ipairs(taskDataList) do
    self:createTaskCell(data, unlock):addTo(self.taskList)
  end
  self.taskList:doLayout()
end

function Activity106Layer:createTaskCell(data, unlock)
  local viewNode = ccui.Widget:create()
  viewNode:size(429, 84)
  local cellBg = display.newSprite(Show106Res .. "cell_bg.png"):center(viewNode):addTo(viewNode)
  local count = data.type == 1 and self.activityStatus.gCount or data.type == 2 and self.activityStatus.fmCount or self.activityStatus.ACount
  count = math.min(count, data.condition1)
  local desc = string.format([[
%s
<div color=#FF9F52>%d</div>/%d]], data.desc, count, data.condition1)
  MRichText.new({
    text = desc,
    size = 18,
    lineSpace = 2,
    color = UIHelper.hex2rgb("#6087E4")
  }):anch(0, 0.5):pos(27, 43):addTo(cellBg)
  local gift = {
    data.gift1,
    data.gift2,
    data.gift3
  }
  local pos = {
    {
      196,
      42,
      0.9
    },
    {
      280,
      42,
      0.9
    },
    {
      374,
      44,
      1
    }
  }
  for i, v in ipairs(gift) do
    local item = v:toArray("=", true)
    local hasgot = self:CheckHasGot(data, i)
    local canget = self:checkIndexCanGet(data, i)
    local icon = self:createItem(data, i, item[1], item[2]):scale(pos[i][3]):anch(0.5, 0.5):pos(pos[i][1], pos[i][2]):addTo(cellBg)
    icon:setCallback(function()
      if not hasgot and canget then
        self:sendMsg(data.id)
        return
      end
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = item[1],
        itemData = ItemCsv[item[1]]
      })
    end)
    if not hasgot and canget then
      display.newSprite(Show106Res .. "canget.png"):center(icon):addTo(icon)
    end
    if hasgot then
      display.newSprite(Show106Res .. "got.png"):center(icon):addTo(icon)
    end
  end
  return viewNode
end

function Activity106Layer:createItem(data, index, id, count)
  local bg = UIHelper.newImageView(Show106Res .. "item_bg.png")
  local item = display.newSprite(ItemCsv[id].icon):scale(0.6):center(bg):addTo(bg)
  local count = display.newTTFLabel({
    text = "x" .. count,
    size = 18,
    color = UIHelper.hex2rgb("#3E52B1")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(34, 10):addTo(bg)
  local activityStatus = game.role.activityStatus[activityType] or {}
  local unlock = activityStatus.unlock or ""
  if 1 < index and unlock:getv(index - 1, 0) == 0 then
    display.newSprite(Show106Res .. "lock.png"):pos(60, 60):addTo(bg)
  end
  return bg
end

function Activity106Layer:checkIndexCanGet(data, index)
  local activityStatus = game.role.activityStatus[activityType] or {}
  local status1 = activityStatus.status1 or ""
  local status2 = activityStatus.status2 or ""
  local status3 = activityStatus.status3 or ""
  local gCount = activityStatus.gCount or 0
  local fmCount = activityStatus.fmCount or 0
  local ACount = activityStatus.ACount or 0
  local unlock = activityStatus.unlock or ""
  if index == 1 then
    return status1:getv(data.id, 0) == 0 and (gCount >= data.condition1 and data.type == 1 or fmCount >= data.condition1 and data.type == 2 or ACount >= data.condition1 and data.type == 3)
  elseif index == 2 then
    return unlock:getv(1, 0) == 1 and status2:getv(data.id, 0) == 0 and (gCount >= data.condition1 and data.type == 1 or fmCount >= data.condition1 and data.type == 2 or ACount >= data.condition1 and data.type == 3)
  elseif index == 3 then
    return unlock:getv(2, 0) == 1 and status3:getv(data.id, 0) == 0 and (gCount >= data.condition1 and data.type == 1 or fmCount >= data.condition1 and data.type == 2 or ACount >= data.condition1 and data.type == 3)
  end
  return false
end

function Activity106Layer:CheckHasGot(data, index)
  local activityStatus = game.role.activityStatus[activityType] or {}
  local status1 = activityStatus.status1 or ""
  local status2 = activityStatus.status2 or ""
  local status3 = activityStatus.status3 or ""
  local gCount = activityStatus.gCount or 0
  local fmCount = activityStatus.fmCount or 0
  local ACount = activityStatus.ACount or 0
  local unlock = activityStatus.unlock or ""
  if index == 1 then
    return status1:getv(data.id, 0) == 1
  elseif index == 2 then
    return unlock:getv(1, 0) == 1 and status2:getv(data.id, 0) == 1
  elseif index == 3 then
    return unlock:getv(2, 0) == 1 and status3:getv(data.id, 0) == 1
  end
  return false
end

function Activity106Layer:checkCanGet(data)
  local activityStatus = game.role.activityStatus[activityType] or {}
  local status1 = activityStatus.status1 or ""
  local status2 = activityStatus.status2 or ""
  local status3 = activityStatus.status3 or ""
  local gCount = activityStatus.gCount or 0
  local fmCount = activityStatus.fmCount or 0
  local ACount = activityStatus.ACount or 0
  local unlock = activityStatus.unlock or ""
  
  local function check(type, count, id)
    if data.type == type and count >= data.condition1 and (status1:getv(id, 0) == 0 or unlock:getv(1, 0) == 1 and status2:getv(id, 0) == 0 or unlock:getv(2, 0) == 1 and status3:getv(id, 0) == 0) then
      return true
    end
  end
  
  local counts = {
    gCount,
    fmCount,
    ACount
  }
  for i = 1, #counts do
    if check(i, counts[i], data.id) then
      return true
    end
  end
end

function Activity106Layer:sendMsg(id)
  game:sendData(actionCodes.Activity_act106GetRewardRpc, MsgPack.pack({id = id}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act106GetRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.codeMsg == "fail" then
      return
    end
    MedalRewardLayer.new({
      items = msg.reward
    })
    self:showTasks()
  end)
end

function Activity106Layer:chooseMainHero()
  local function rule(hero)
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    type = 20,
    callback = function(choose)
      local hero = game.role.heros[choose]
      self.heroId = hero.id
      self:ShowChooseHeroImage(hero)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "活动")
  end)
end

function Activity106Layer:ShowChooseHeroImage(hero)
  local type = hero:getDressType()
  self.bigcard:setImage(UIHelper.getCardRes("normal", type, false, 5))
end

function Activity106Layer:sendBuyMsg(rechargeData, _callBack)
  if not game.role:checkCanCharge(rechargeData.rmb) then
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
        MFlashMsg:show({
          text = rechargeData.title .. "奖励解锁成功"
        })
        if msg.diamond > 0 then
          msg.reward[5] = (msg.reward[5] or 0) + msg.diamond
        end
        if next(msg.reward) then
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
        self.activityStatus = game.role.activityStatus[activityType]
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

return Activity106Layer
