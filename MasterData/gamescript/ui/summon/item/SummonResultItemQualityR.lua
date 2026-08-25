local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonResultItemQualityR, Super = System.NewComponent("SummonResultItemQualityR")

function SummonResultItemQualityR:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Show_RLogoResource(uiNode)
end

function SummonResultItemQualityR:OnBind(binder)
  self.binder = binder
end

function SummonResultItemQualityR:Display(_, onEndOfAnimation)
  local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  animController:PlayMultiState("UI_Summon_Popup_Show_RLogo", function()
    onEndOfAnimation()
  end, 1, false)
end

function SummonResultItemQualityR:StopDisplay()
  local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  animController:ClearCompleteCb()
  animController:StopPlayableGraph()
end

return SummonResultItemQualityR
