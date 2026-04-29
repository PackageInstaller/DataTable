_class("UICN7N36PostGameClosingTipsController", UIController)
UICN7N36PostGameClosingTipsController = UICN7N36PostGameClosingTipsController

function UICN7N36PostGameClosingTipsController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN7N36PostGameClosingTipsController:OnShow(uiParams)
  self.txt = uiParams[1]
  self.CancelCB = uiParams[2]
  self.ConfirmCB = uiParams[3]
  self:InitWidget()
  self:ShowDetail()
end

function UICN7N36PostGameClosingTipsController:InitWidget()
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self.anim = self:GetUIComponent("Animation", "Anim")
end

function UICN7N36PostGameClosingTipsController:ShowDetail()
  self._tips:SetText(self.txt)
  local lockName = "UICN7N36PostGameClosingTipsController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self.anim:Play("uieff_UICN7N36PostGameClosingTipsController_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UICN7N36PostGameClosingTipsController:CancelBtnOnClick(go)
  local lockName = "UICN7N36PostGameClosingTipsController_AnimOUT"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self.anim:Play("uieff_UICN7N36PostGameClosingTipsController_out")
    YIELD(TT, 200)
    self:UnLock(lockName)
    self:CloseDialog()
    if self.CancelCB then
      self.CancelCB()
    end
  end)
end

function UICN7N36PostGameClosingTipsController:ConfirmBtnOnClick(go)
  local lockName = "UICN7N36PostGameClosingTipsController_AnimOUT"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self.anim:Play("uieff_UICN7N36PostGameClosingTipsController_out")
    YIELD(TT, 200)
    self:UnLock(lockName)
    self:CloseDialog()
    if self.ConfirmCB then
      self.ConfirmCB()
    end
  end)
end
