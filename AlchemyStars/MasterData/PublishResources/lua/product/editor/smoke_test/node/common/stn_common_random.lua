require("base_state_node")
_class("Common_Random", CTestRobot_Base)
Common_Random = Common_Random

function Common_Random:Constructor(pManager, nMin, nMax)
  self.m_nRangeMin = nMin
  self.m_nRangeMax = nMax
end

function Common_Random:OnWorking()
  self.m_pReturnData = math.random(self.m_nRangeMin, self.m_nRangeMax)
  return Infrastructure_Begin.super.OnWorking(self)
end
