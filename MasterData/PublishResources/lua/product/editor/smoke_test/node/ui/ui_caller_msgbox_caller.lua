require("stn_ui_caller_base")
_class("CTestRobot_MsgBoxCaller", CTestRobot_UICaller)
CTestRobot_MsgBoxCaller = CTestRobot_MsgBoxCaller

function CTestRobot_MsgBoxCaller:_FindUI(stName)
  local pUIManger = self.m_pGameCenter.UIStateManager()
  return pUIManger:GetUIMessageBox(nil, stName)
end
