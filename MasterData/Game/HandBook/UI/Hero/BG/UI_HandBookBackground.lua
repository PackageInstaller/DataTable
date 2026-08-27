local UI_HandBookBackground = class("UI_HandBookBackground", UIBaseWindow)
local base = UIBaseWindow

function UI_HandBookBackground:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
end

function UI_HandBookBackground:HBBGPalyerEnterTween()
  self:__PlayDoTweenAnimation("bg_fromBlack")
  self:__PlayDoTweenAnimation("bg_grigUp")
end

function UI_HandBookBackground:__PlayDoTweenAnimation(id)
  self.ui.DoTweenAnimation:DORestartAllById(id)
end

function UI_HandBookBackground:HBBGSetTop(index, viewLayerList)
  if self.ui.tex_Top == nil then
    return
  end
  self.ui.tex_Top:SetIndex(index, viewLayerList[1], viewLayerList[2], viewLayerList[3])
end

function UI_HandBookBackground:__OnClickBack()
  self:Delete()
end

function UI_HandBookBackground:OnDelete()
end

return UI_HandBookBackground
