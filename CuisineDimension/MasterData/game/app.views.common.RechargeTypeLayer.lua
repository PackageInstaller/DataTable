local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  popup = true,
  widgets = {touch = "touch"}
}
local RechargeTypeLayer = class("RechargeTypeLayer", UIBase)

function RechargeTypeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RechargeTypeLayer:init(params)
  self.callback = params.callback
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  local dialogBg = display.newScale9Sprite("ui/global/dialog_small.png")
  dialogBg:setCapInsets(CCRectMake(198, 54, 158, 120))
  dialogBg:setContentSize(cc.size(275, 351))
  dialogBg:pos(568 + self.dalteX, 320):addTo(self.touch)
  local backBtn = UIHelper.extend(ccui.Button:create())
  backBtn:setImages("ui/global/", {
    "btn_back_normal.png",
    "btn_back_selected.png"
  })
  backBtn:pos(258, 333):addTo(dialogBg)
  backBtn:setTouchScale()
  backBtn:setCallback(function()
    self:close()
  end)
  local names = {
    "   支付宝",
    "微信"
  }
  local xpos, ypos = 568 + self.dalteX, 384
  for rType, name in ipairs(names) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/global/", {
      "dialog_cancel.png",
      "dialog_cancel.png"
    })
    btn:pos(xpos, ypos):addTo(self.touch)
    btn:setTouchScale()
    btn:setCallback(function()
      self.callback(rType)
      self:close()
    end)
    local payIcon = display.newScale9Sprite("ui/global/" .. (name == "   支付宝" and "zfbIcon.png" or "wxIcon.png"))
    payIcon:setCapInsets(CCRectMake(0, 0, 260, 260))
    payIcon:setContentSize(cc.size(29, 29))
    payIcon:anch(0, 0):pos(14, 8):addTo(btn)
    display.newTTFLabel({text = name, size = 24}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 23):addTo(btn)
    ypos = ypos - 128
  end
end

return RechargeTypeLayer
