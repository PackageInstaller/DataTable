local uiData = {
  csbFile = "ui/tower/TowerRuleLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    closeBtn = "popAction/infoBg/closeBtn"
  }
}
local TowerRuleLayer = class("TowerRuleLayer", UIBase)

function TowerRuleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TowerRuleLayer:init(params)
  self.closeBtn:setTouchScale(true)
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function TowerRuleLayer:showData(params)
end

return TowerRuleLayer
