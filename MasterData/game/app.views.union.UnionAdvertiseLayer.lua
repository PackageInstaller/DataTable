local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/union/UnionAdvertiseLayer.csb",
  mask = true,
  widgets = {
    touch = "touch",
    panel = "panel",
    mask = "panel/mask",
    title = "panel/title",
    btnClose = "panel/btnClose",
    confirm = "panel/confirm",
    cancel = "panel/cancel"
  }
}
local UnionAdvertiseLayer = class("UnionAdvertiseLayer", UIBase)

function UnionAdvertiseLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionAdvertiseLayer:init(params)
  self.mask:setSwallowTouches(true)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
  local adId, adCount = globalCsv.UnionAdCost:match("(%d+)=(%d+)")
  local costId = tonumber(adId)
  display.newTTFLabel({
    text = "是否花费" .. adCount,
    size = 20,
    color = UIHelper.hex2rgb("#612D06")
  }):pos(222, 232):addTo(self.panel)
  display.newSprite(ItemCsv[costId].icon):scale(0.4):pos(308, 232):addTo(self.panel)
  display.newTTFLabel({
    text = "租赁一周的广告位",
    size = 20,
    color = UIHelper.hex2rgb("#612D06")
  }):pos(430, 232):addTo(self.panel)
  display.newTTFLabel({
    text = "使用协会后在系统推荐中处于高优先级，并享有专门的广告位页签",
    size = 16,
    color = UIHelper.hex2rgb("#A68B71")
  }):pos(334, 118):addTo(self.panel)
  self:showDetail()
end

function UnionAdvertiseLayer:showDetail()
  local unionAdvertiseTxt = "请在此处输入最多20个文字"
  local userInput = ccui.EditBox:create(cc.size(585, 90), "ui/home/roleDetail/name_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(20)
  userInput:setMaxLength(20)
  userInput:setPlaceHolder(unionAdvertiseTxt)
  userInput:setPlaceholderFontSize(20)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb("#cac0b8"))
  userInput:anch(0.5, 0.5):pos(336, 173):addTo(self.panel)
  userInput:setFontColor(UIHelper.hex2rgb("#6f4925"))
  self.confirm:setCallback(function()
    local txtStr = userInput:getText()
    local len = self:getLength(self:stringToTab(txtStr))
    if len == 0 then
      SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
      return
    end
    local cost = globalCsv.UnionAdCost:toArray("=", true)
    if cost[1] == 5 then
      if cost[2] > game.role.diamond then
        UIHelper.showDiamondTip()
        return
      end
    elseif cost[2] > (role:getItemCount(cost[2]) or 0) then
      SysError(SYS_ERR_UNION_CREATE_ITEM_NULL)
      return
    end
    game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 5, desc = txtStr}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
      UIHelper.removeWaiting()
      BackManager:pop()
      SysError(SYS_ERR_UNION_HANDLE_SUCCESS)
    end)
  end)
end

function UnionAdvertiseLayer:stringToTab(str)
  local tab = {}
  if not str then
    return tab
  end
  for utfChar in string.gmatch(str, "[%z\001-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function UnionAdvertiseLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

return UnionAdvertiseLayer
