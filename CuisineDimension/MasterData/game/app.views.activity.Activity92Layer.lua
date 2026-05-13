local ActivityManager = require("app.models.ActivityManager")
local ItemCsv = require("csvdata.item")
local activity92TaskCsv = require("csvdata.activity_92_task")
local activityType = "92"
local Show92Res = "ui/activity/92/"
local Activity92Layer = {}
Activity92Layer.mainLayer = nil

function Activity92Layer:init(mainLayer)
  Activity92Layer.mainLayer = mainLayer
  self.content = mainLayer.content
  self.activityStatus = game.role.activityStatus["92"] or {}
  local mainBg = display.newSprite(Show92Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(Show92Res, {"btn_go.png", "btn_go.png"})
  btnGo:anch(0.5, 0.5):pos(756, 70):addTo(mainBg)
  btnGo:setCallback(function()
    local needCount = game.role.diamond
    if needCount < globalCsv.activity92Cost then
      SysError(SYS_ERR_DIAMOND_SHORTAGE)
      return
    end
    MDialog:double({
      title = "提示",
      text = string.format("是否要消耗%d钻石进入游戏？", globalCsv.activity92Cost),
      okCallback = function()
        local layer = game:createView("activity.Activity92GameLayer", {})
        BackManager:push(function()
          TopBar:show(TopBarType.full, "活动")
          layer:close()
          self:showRewardCell()
        end)
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end)
  local btnShop = UIHelper.extend(ccui.Button:create())
  btnShop:setImages(Show92Res, {
    "btn_exchange.png",
    "btn_exchange.png"
  })
  btnShop:anch(0.5, 0.5):pos(585, 70):addTo(mainBg):setTouchScale()
  btnShop:setCallback(function()
    if not CommonHelper.funcOpen("box") then
      SysError(SYS_ERR_FUNCOPEN_DINER_SHOP)
      return
    end
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 6})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = string.format("消耗：%s钻石", globalCsv.activity92Cost),
    size = 18,
    color = UIHelper.hex2rgb("#fce9cb")
  }):anch(0.5, 0.5):pos(756, 27):addTo(mainBg)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(Show92Res, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 492):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "activity92"})
  end)
  self:showRewardCell()
end

function Activity92Layer:showRewardCell()
  self.activityStatus = game.role.activityStatus["92"] or {}
  local offsetY = 65
  for index, data in pairs(activity92TaskCsv) do
    local temCell = self.content:getChildByName("cell" .. index)
    if temCell then
      self.content:removeChildByName("cell" .. index)
    end
    local cell = UIHelper.extend(ccui.Button:create())
    cell:setImages(Show92Res, {
      "cell_bg.png",
      "cell_bg.png"
    })
    cell:pos(255, offsetY):addTo(self.content):name("cell" .. index)
    cell:setCallback(function()
      self:sendMsg()
    end)
    display.newTTFLabel({
      text = string.format("游玩游戏%d次", data.condition),
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(46, 46):addTo(cell)
    local unGot = self:checkGet(data.id)
    local canget = (self.activityStatus.count or 0) >= data.condition
    local item = data.gift:toArray("=", true)
    local icon = ItemIcon.new({
      type = item[1],
      count = item[2],
      showTip = true,
      selectCallback = function()
        if unGot and canget then
          self:sendMsg()
        end
      end
    }):scale(0.6):anch(0.5, 0.5):pos(300, 33):addTo(cell)
    offsetY = offsetY - 78
    if not unGot and canget then
      display.newSprite(Show92Res .. "got.png"):center(icon):addTo(icon)
    elseif unGot and canget then
      display.newSprite(Show92Res .. "canget.png"):center(icon):addTo(icon)
    end
    display.newTTFLabel({
      text = string.format("%d/%d", self.activityStatus.count or 0, data.condition),
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0, 0.5):pos(46, 23):addTo(cell)
  end
end

function Activity92Layer:checkGet(id)
  return id > (self.activityStatus.id or 0)
end

function Activity92Layer:sendMsg()
  local maxId = self:getMaxId()
  if maxId == 0 then
    SysError(SYS_ERR_REWARD_GOT)
    return
  end
  game:sendData(actionCodes.Activity_redEnvelopeGetRewardRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_redEnvelopeGetRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.codeMsg == "fail" then
      return
    end
    MedalRewardLayer.new({
      items = msg.reward
    })
    self:showRewardCell()
  end)
end

function Activity92Layer:getMaxId()
  local maxId = 0
  local curId = self.activityStatus.id or 0
  local curCount = self.activityStatus.count or 0
  for _, cfg in pairs(activity92TaskCsv) do
    if curId < cfg.id and curCount >= cfg.condition and maxId < cfg.id then
      maxId = cfg.id
    end
  end
  return maxId
end

return Activity92Layer
