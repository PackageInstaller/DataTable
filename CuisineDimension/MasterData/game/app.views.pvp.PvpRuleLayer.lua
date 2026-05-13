local uiData = {
  csbFile = "ui/pvp/PvpRuleLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    closeBtn = "popAction/infoBg/closeBtn"
  }
}
local PvpRuleLayer = class("PvpRuleLayer", UIBase)

function PvpRuleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpRuleLayer:init(params)
  self.closeBtn:setTouchScale(true)
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

return PvpRuleLayer
