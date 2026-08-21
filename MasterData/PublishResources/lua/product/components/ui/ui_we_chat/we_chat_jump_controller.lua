_class("UIWeChatJumpController", UIController)
UIWeChatJumpController = UIWeChatJumpController

function UIWeChatJumpController:OnShow(uiParams)
  self.talk = uiParams[1]
  self.jumpId = self.talk.jumpId
  local txt = StringTable.Get(self.talk.jumpDesc)
  self.txt = self:GetUIComponent("UILocalizationText", "desc")
  self.txt:SetText(txt)
end

function UIWeChatJumpController:OnHide()
end

function UIWeChatJumpController:bgOnClick(go)
  self:CloseDialog()
end

function UIWeChatJumpController:btnEnsureOnClick(go)
  local module = GameGlobal.GetModule(RoleModule)
  local _enable = module:CheckModuleUnlock(GameModuleID.MD_Aircraft)
  if _enable then
    local jumpModule = self:GetModule(QuestModule).uiModule
    jumpModule:Goto(self.jumpId, FromUIType.NormalUI, "UIWeChatController", UIStateType.UIMain)
  else
    ToastManager.ShowLockTip()
  end
end
