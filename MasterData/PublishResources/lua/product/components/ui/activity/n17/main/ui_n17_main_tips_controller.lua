_class("UIN17MainTipsController", UIController)
UIN17MainTipsController = UIN17MainTipsController

function UIN17MainTipsController:OnShow(uiParams)
  local duaration = 2000
  local lockName = "UIN17MainTipsController_OnShow"
  self:Lock(lockName)
  self:StartTask(function(TT)
    YIELD(TT, duaration)
    self:UnLock(lockName)
    self:CloseDialog()
  end)
end
