require("base_state_node")
_class("UIToast", CTestRobot_Base)
UIToast = UIToast

function UIToast:Constructor(pManger, stText)
  self.m_stText = stText
end

function UIToast:OnWorking()
  ToastManager.ShowToast(self.m_stText)
  return UIToast.super.OnWorking(self)
end
