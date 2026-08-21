local ItemCsv = require("csvdata.item")
local activityRes = "ui/home/activity/"
local uiData = {
  csbFile = "ui/home/HomePopLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    closeBtn = "popAction/closeBtn",
    jumpBtn = "popAction/jumpBtn"
  }
}
local activityData = {
  [1] = {
    actId = 1,
    name = "acitivty_bg_",
    closeName = "acitivty_close_",
    closePos = {100, 100},
    jumpName = "acitivty_jump_",
    jumpPos = {400, 100},
    func = function(self)
      self:jumpShopLayer()
    end
  }
}
local HomePopLayer = class("HomePopLayer", UIBase)

function HomePopLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HomePopLayer:init(params)
  local actId = params.activityId or 0
  local curData = activityData[actId]
  if curData then
    self.closeBtn:setCallback(function()
      self:close()
    end)
    self.jumpBtn:setCallback(function()
      if curData.func then
        curData.func(self)
        self:close()
      end
    end)
  else
    self:close()
  end
end

function HomePopLayer:jumpShopLayer()
  local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
  BackManager:push(function()
    TopBar:show(TopBarType.money)
    layer:close()
  end)
end

return HomePopLayer
