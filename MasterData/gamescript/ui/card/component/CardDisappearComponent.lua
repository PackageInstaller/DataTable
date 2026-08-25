local Animator = typeof(CS.UnityEngine.Animator)
local CardDisappearComponent, Super = System.NewComponent("CardDisappearComponent")

function CardDisappearComponent:ctor(uiNode, configId)
  Super.ctor(self)
  self.configId = Vue.ref(configId)
  self.ui = Disapper_ItemCardBaseResource(uiNode)
  self.animTime = 0
end

function CardDisappearComponent:OnBind(binder)
  self.binder = binder
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, 0, self.configId.value))
  self.animTime = CS.Framework.UIUtilTool.GetTotalClipTime(self.ui.uiNode:GetComponent(Animator))
end

function CardDisappearComponent:ResetConfigId(configId)
  self.configId.value = configId
end

function CardDisappearComponent:PlayAnimationClip()
  self.ui.uiNode:GetComponent(Animator):Play("CardDisapper")
end

return CardDisappearComponent
