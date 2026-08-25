local Animator = typeof(CS.UnityEngine.Animator)
local CardDisappearMultiComponent, Super = System.NewComponent("CardDisappearMultiComponent")

function CardDisappearMultiComponent:ctor(uiNode, configId)
  Super.ctor(self)
  self.configId = Vue.ref(configId)
  self.ui = Disapper_MoreCardBaseItemResource(uiNode)
  self.animTime = 0
end

function CardDisappearMultiComponent:OnBind(binder)
  self.frontCardItem = binder:BindComponent(CardDisappearComponent(self.ui.FrontCardItem, self.configId.value))
  self.backCardItem = binder:BindComponent(CardDisappearComponent(self.ui.BackCardItem, self.configId.value))
  self.animTime = CS.Framework.UIUtilTool.GetTotalClipTime(self.ui.uiNode:GetComponent(Animator))
end

function CardDisappearMultiComponent:PlayAnimationClip()
  self.ui.uiNode:GetComponent(Animator):Play("MoreCardDisapper")
end

function CardDisappearMultiComponent:ResetConfigId(configId)
  self.configId.value = configId
end

return CardDisappearMultiComponent
