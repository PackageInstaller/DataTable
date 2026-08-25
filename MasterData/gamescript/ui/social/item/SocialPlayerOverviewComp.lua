local SocialPlayerOverviewComp, Super = System.NewComponent("SocialPlayerOverviewComp")

function SocialPlayerOverviewComp:ctor(res, model)
  Super.ctor(self)
  self.ui = UI_Social_Item_Data_OverviewResource(res)
  self.model = model
end

function SocialPlayerOverviewComp:OnBind(binder)
  self.binder = binder
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.leftComp = binder:BindComponent(SocialPlayerOverviewLeftComp(self.ui.UI_Social_Item_Data_Left, self.model))
  self.rightComp = binder:BindComponent(SocialPlayerOverviewRightComp(self.ui.UI_Social_Item_Data_Right, self.model))
  binder:BindEvent(EventMgr.Instance.OnPanelServerDataReturn, System.fn(self, self.UpdateOnceSetUI))
end

function SocialPlayerOverviewComp:UpdateOnceSetUI(plauerUid)
  if plauerUid ~= self.model.targetPlayerUid then
    return
  end
  self.model:InitAwakerDetailData()
  if self.leftComp then
    self.leftComp:UpdateOnceSetUI()
  end
  if self.rightComp then
    self.rightComp:UpdateOnceSetUI()
  end
end

function SocialPlayerOverviewComp:Show()
  if not self.ui or not self.ui.uiNode then
    return
  end
  if self.uiAnimationController and not self.isPlayedOpenAnim then
    self.isPlayedOpenAnim = true
    self.uiAnimationController:PlayState("UI_Social_Item_Data_Overview_Open")
    return
  end
  self.ui.uiNode:SetActive(true)
end

function SocialPlayerOverviewComp:Hide()
  self.isPlayedOpenAnim = false
  if not self.ui or not self.ui.uiNode then
    return
  end
  if self.uiAnimationController then
    self.uiAnimationController:PlayState("UI_Social_Item_Data_Overview_Close")
    return
  end
  self.ui.uiNode:SetActive(false)
end

function SocialPlayerOverviewComp:OnUnbind()
  self.isPlayedOpenAnim = false
  if self.leftComp then
    self.leftComp = nil
  end
  if self.rightComp then
    self.rightComp = nil
  end
end

return SocialPlayerOverviewComp
