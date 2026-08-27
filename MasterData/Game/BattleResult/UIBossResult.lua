local UIBossResult = class("UIBossResult", UIBaseWindow)
local base = UIBaseWindow

function UIBossResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_next, self, self.NextSectionExploration)
  UIUtil.AddButtonListener(self.ui.btn_continue, self, self.ContinueSectionExploration)
  UIUtil.AddButtonListener(self.ui.btn_exit, self, self.ExitSectionExploration)
  UIUtil.AddButtonListener(self.ui.btn_complete, self, self.CompleteSectionExploration)
end

function UIBossResult:SetBtnNextClickAction(nextAction)
  self.onNextAction = nextAction
end

function UIBossResult:SetBtnContinueClickAction(continueAction)
  self.onContinueAction = continueAction
end

function UIBossResult:SetBtnExitClickAction(exitAction)
  self.onExitAction = exitAction
end

function UIBossResult:SetBtnCompleteClickAction(completeAction)
  self.onCompleteAction = completeAction
end

function UIBossResult:ShowBossResult()
  if self.onNextAction == nil and self.onContinueAction == nil and self.onExitAction == nil and self.onCompleteAction == nil then
    self.onNextAction = BindCallback(self, self.__DefaultAction)
  end
  self.ui.tex_tier:SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1))
  self.ui.btn_next.gameObject:SetActive(self.onNextAction ~= nil and true or false)
  self.ui.btn_continue.gameObject:SetActive(self.onContinueAction ~= nil and true or false)
  self.ui.btn_exit.gameObject:SetActive(self.onExitAction ~= nil and true or false)
  self.ui.btn_complete.gameObject:SetActive(self.onCompleteAction ~= nil and true or false)
end

function UIBossResult:NextSectionExploration()
  if self.onNextAction ~= nil then
    self.onNextAction()
  end
  self:__AfterClick()
end

function UIBossResult:ContinueSectionExploration()
  if self.onContinueAction ~= nil then
    self.onContinueAction()
  end
  self:__AfterClick()
end

function UIBossResult:ExitSectionExploration()
  if self.onExitAction ~= nil then
    self.onExitAction()
  end
  self:__AfterClick()
end

function UIBossResult:CompleteSectionExploration()
  if self.onCompleteAction ~= nil then
    self.onCompleteAction()
  end
  self:__AfterClick()
end

function UIBossResult:__DefaultAction()
  ExplorationManager:EnterNextSectionExploration()
  self:__AfterClick()
end

function UIBossResult:__AfterClick()
  self.onNextAction = nil
  self.onContinueAction = nil
  self.onExitAction = nil
  self.onCompleteAction = nil
  self:Delete()
end

function UIBossResult:OnDelete()
  base.OnDelete(self)
end

return UIBossResult
