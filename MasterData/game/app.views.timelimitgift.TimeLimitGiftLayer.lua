local ActivityCsv = require("csvdata.time_limit_gift")
local ActivityRes = "ui/timelimitgift/"
local uiData = {
  csbFile = "ui/timelimitgift/TimeLimitGiftLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    mainBg = "mainBg",
    remainTime = "mainBg/remainTime",
    btn = "mainBg/btn"
  }
}
local TimeLimitGiftLayer = class("TimeLimitGiftLayer", UIBase)

function TimeLimitGiftLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TimeLimitGiftLayer:init(params)
  self.activityType = params.type
  self.startTime = params.startTime
  self.mainBg:setImage(ActivityRes .. "main" .. params.type .. ".png")
  local costType = ActivityCsv[self.activityType].costType
  local cost = ActivityCsv[self.activityType].cost
  self.btn:setCallback(function()
    local costname
    if costType == 60 then
      costname = "礼包券"
    elseif costType == 5 then
      costname = "钻石"
    end
    if (game.role.items[costType] or 0) < cost then
      MDialog:double({
        title = costname .. "不足",
        text = costname .. "不足，是否跳转商城购买？",
        okCallback = function()
          local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
          BackManager:push(function()
            TopBar:show(TopBarType.money)
            layer:close()
          end)
          self:close()
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      MDialog:double({
        title = "礼包购买",
        text = "确认要购买" .. ActivityCsv[self.activityType].desc .. "吗？",
        okCallback = function()
          game:sendData(actionCodes.Activity_timeLimitGiftBuyRpc, MsgPack.pack({
            activityType = self.activityType
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_timeLimitGiftBuyRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward
            })
            self:close()
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end
  end)
  self:updateTime()
end

function TimeLimitGiftLayer:updateTime()
  self:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local remainTime = self.startTime + ActivityCsv[self.activityType].time - game:nowTime()
      if 0 <= remainTime then
        local timeTab = os.date("!*t", remainTime)
        self.remainTime:setString(string.format("%d时%d分%d秒", timeTab.hour, timeTab.min, timeTab.sec))
      else
        self:close()
      end
    end)
  })))
end

return TimeLimitGiftLayer
