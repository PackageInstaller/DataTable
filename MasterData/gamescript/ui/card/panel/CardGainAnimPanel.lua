local Animator = CS.UnityEngine.Animator
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local CardGainAnimPanel, Super = System.NewClass("CardGainAnimPanel", UIBasePanel)
CardGainAnimPanel.uiResCls = Panel_Operating_Card_EmptyResource

function CardGainAnimPanel:ctor(tid, callback, source)
  Super.ctor(self)
  self.tid = tid
  self.callback = callback
  self.source = source
end

function CardGainAnimPanel:OnBind(binder)
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  self.animator.enabled = false
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, 0, self.tid))
  AnimatorUtils.SetStateEndInBehavior(self.animator, "Gain", function()
    self:ClosePanel()
  end)
  AnimatorUtils.SetStateEndInBehavior(self.animator, "Destory", function()
    self:ClosePanel()
  end)
  self:PlayAnim()
end

function CardGainAnimPanel:PlayAnim()
  if self.animator then
    self.animator.enabled = true
    local stateName
    if self.source == CommonDefine.CardOperationType.Gain then
      stateName = "Base Layer.UA_Card_Info_MoveToBag"
    elseif self.source == CommonDefine.CardOperationType.Remove then
      stateName = "Base Layer.UA_Card_Destory"
    end
    if not stateName then
      return
    end
    AnimatorUtils.PlayState(self.animator, stateName)
    return
  end
  self:ClosePanel()
end

function CardGainAnimPanel:ClosePanel()
  self:Close()
end

return CardGainAnimPanel
