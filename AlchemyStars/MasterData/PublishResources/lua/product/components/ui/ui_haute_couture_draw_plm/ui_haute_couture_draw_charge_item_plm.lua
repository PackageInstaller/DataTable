_class("UIHauteCoutureDrawChargeItemPLM", UIHauteCoutureDrawChargeItemBase)
UIHauteCoutureDrawChargeItemPLM = UIHauteCoutureDrawChargeItemPLM

function UIHauteCoutureDrawChargeItemPLM:OnShow(uiParams)
  self:InitWidgets()
end

function UIHauteCoutureDrawChargeItemPLM:OnHide()
  self:ClearTimer()
end

function UIHauteCoutureDrawChargeItemPLM:InitWidgets(uiParams)
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawChargeItemPLM:PlayAnimIn(id)
  self._anim = self:GetUIComponent("Animation", "anim")
  self:StartTask(function(TT)
    YIELD(TT, id * 15)
    self._anim:Play("uieff_UIHauteCoutureDrawChargeItemPLM_in")
  end)
end

function UIHauteCoutureDrawChargeItemPLM:GetCountStrKey()
  return "str_senior_skin_draw_gift_count_gl"
end
