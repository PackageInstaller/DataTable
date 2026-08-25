local UIAnimationController = CS.Z1Client.UIAnimationController
local CommonFloatTipsComponent, Super = System.NewComponent("CommonFloatTipsComponent")

function CommonFloatTipsComponent:ctor(uiNode, sDesc)
  Super.ctor(self)
  self.ui = UI_Common_Floating_WordsResource(uiNode)
  self.sDesc = sDesc
end

function CommonFloatTipsComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Obtain, self.sDesc)
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimationController:PlayState("Item_Battle_Floating_Words", function()
    local panel = UIManager.Instance:GetWindow(Urls.CommonFloatTipsPanel)
    if panel then
      panel:CountingShowTips()
      panel:CheckFinish()
    end
  end)
  binder:CheckUpdatePanelResource(self.ui.uiNode, DataCenter.gameData.CurrTextLanguage)
end

return CommonFloatTipsComponent
