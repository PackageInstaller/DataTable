local ItemCsv = require("csvdata.item")
local activityRes = "ui/activity/109/"
local uiData = {
  csbFile = "ui/activity/CommonLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {RootNode = "Root"}
}
local PopActivity109Layer = class("PopActivity109Layer", UIBase)

function PopActivity109Layer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PopActivity109Layer:init(params)
  self:initSpine()
end

function PopActivity109Layer:addMask()
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
  self.mask:addTo(self.RootNode)
end

function PopActivity109Layer:initSpine()
  self:addMask()
  self.spine = UIHelper.createSpineNodeByRes(activityRes .. "envelop")
  self.spine:setAnimation(0, "fade_in", false)
  self.spine:pos(self.mask:getContentSize().width / 2, display.cy + 4):addTo(self.mask)
  self.spine:runAction(transition.sequence({
    cc.DelayTime:create(2),
    cc.CallFunc:create(function()
      self.spine:setAnimation(0, "idle", true)
      self:initOpenBtn()
    end)
  }))
end

function PopActivity109Layer:initOpenBtn()
  local openBtn = UIHelper.extend(ccui.Button:create())
  openBtn:setImages(activityRes, {
    "open_btn.png",
    "open_btn.png"
  })
  openBtn:anch(0.5, 0.5):pos(-1, -1.5):addTo(self.spine)
  openBtn:setTouchScale()
  openBtn:setCallback(function()
    self.spine:setAnimation(0, "open", false)
    openBtn:hide()
    self.spine:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        self:initClaimBtn()
      end)
    }))
  end)
end

function PopActivity109Layer:initClaimBtn()
  local claimBtn = UIHelper.extend(ccui.Button:create())
  claimBtn:setImages(activityRes, {
    "claim_btn.png",
    "claim_btn.png"
  })
  claimBtn:anch(0.5, 0.5):pos(164, -99):addTo(self.spine)
  claimBtn:setTouchScale()
  claimBtn:setCallback(function()
    game:sendData(actionCodes.Activity_act109GetRewardRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_act109GetRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self:close()
    end)
  end)
end

return PopActivity109Layer
