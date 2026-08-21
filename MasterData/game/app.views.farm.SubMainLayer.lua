local RechargeCsv = require("csvdata.recharge")
local sdkInterface = require("sdk.SDKInterface")
local SubRes = "ui/farm/sub/"
local SubMainLayer = class("SubMainLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function SubMainLayer:ctor(params)
  self:size(display.width, display.height)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(191)
  mask:anch(0.5, 0.5):center(self):addTo(self)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(mask, true)
  end
  self:showData(params)
end

function SubMainLayer:showData(params)
  local mainBg = display.newSprite(SubRes .. "main_bg.png"):pos(580, 315):addTo(self)
  local btnClose = UIHelper.extend(ccui.Button:create())
  btnClose:setImages("ui/home/roleDetail/", {"close.png", "close.png"})
  btnClose:pos(900, 506):addTo(mainBg)
  btnClose:setTouchScale()
  btnClose:setCallback(function()
    self:removeFromParent()
  end)
  local image = UIHelper.newImageView(SubRes .. "image_a.png"):pos(765, 42):addTo(mainBg)
  if game:nowTime() < (game.role.subCardDeadline or 0) then
    image:setImage(SubRes .. "image_b.png")
  else
    image:setCallback(function()
      if game.role:checkNotRechargeChannel() then
        return
      end
      local data = RechargeCsv[98]
      if not game.role:checkCanCharge(data.rmb) then
        return
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
            umeng.pay(data.rmb, 20, data.title, 1, data.rmb)
          elseif msg.result == "handled" then
          else
            return
          end
          MedalRewardLayer.new({
            items = {
              [202] = 1
            }
          })
          params.callback()
          image:setImage(SubRes .. "image_b.png")
          image:setTouchEnabled(false)
        end)
      end)
    end)
  end
end

return SubMainLayer
