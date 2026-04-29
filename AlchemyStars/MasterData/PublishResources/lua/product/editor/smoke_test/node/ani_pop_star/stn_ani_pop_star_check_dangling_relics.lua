require("base_state_node")
_class("AniPopStar_CheckDanglingRelics", CTestRobot_Base)
AniPopStar_CheckDanglingRelics = AniPopStar_CheckDanglingRelics

function AniPopStar_CheckDanglingRelics:OnWorking()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local aniPopInfo = anipopModule:GetAniPopInfo()
  local nRelicCount = table.count(aniPopInfo.relic_info.dangling_relics)
  nRelicCount = 0
  if 0 < nRelicCount then
    self.m_nLogicResult = 1
    self.m_pReturnData = aniPopInfo.relic_info.dangling_relics
  else
    self.m_nLogicResult = 0
  end
  return AniPopStar_CheckDanglingRelics.super.OnWorking(self)
end
