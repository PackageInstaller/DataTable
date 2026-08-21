require("base_state_node")
_class("Cartridge_NextStage", CTestRobot_Base)
Cartridge_NextStage = Cartridge_NextStage

function Cartridge_NextStage:OnWorking()
  local runData = self._manager:GetMissionRunData()
  runData:TickCartridgeStageIndex()
  if not runData:GetMissionID() then
    self.m_nLogicResult = 1
    self.m_nNodeState = Enum_ActionState.E_Down
    return
  end
  self.m_nLogicResult = 0
  self.m_nNodeState = Enum_ActionState.E_Down
end
