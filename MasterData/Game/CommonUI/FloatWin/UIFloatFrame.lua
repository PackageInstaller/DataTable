local UIFloatFrame = class("UIFloatFrame", UIBaseWindow)
local base = UIBaseWindow
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")

function UIFloatFrame:OnInit()
  self.floatFrame = UINFloatUINode.New()
  self.floatFrame:Init(self.ui.frame.gameObject)
end

function UIFloatFrame:SetTitleAndContext(title, context)
  self.ui.tex_Title.gameObject:SetActive(title ~= nil)
  self.ui.tex_Title.text = title
  self.ui.tex_Content.gameObject:SetActive(context ~= nil)
  self.ui.tex_Content.text = context
end

function UIFloatFrame:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY, customTargetCamer)
  self.floatFrame:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY, customTargetCamer)
  if self.timer ~= nil then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
  end
  self.timer = TimerManager:StartTimer(1, function()
    self.floatFrame:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY, customTargetCamer)
  end, nil, true, true, true)
end

function UIFloatFrame:Copy3DModifier(comp_3dModifier)
  self.ui.comp_3dModifier.rotation = comp_3dModifier.rotation
  self.ui.comp_3dModifier.position = comp_3dModifier.position
  self.ui.comp_3dModifier:RefreshGraphics()
end

function UIFloatFrame:Clean3DModifier()
  self.ui.comp_3dModifier.rotation = Vector3.New()
  self.ui.comp_3dModifier.position = Vector3.New()
  self.ui.comp_3dModifier:RefreshGraphics()
end

function UIFloatFrame:OnDelete()
  if self.timer ~= nil then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
  end
  base.OnDelete(self)
end

return UIFloatFrame
