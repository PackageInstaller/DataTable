require("common_async_base")
_class("DifficultyMission_EnterBattleWithParam", Common_AsyncBase)
DifficultyMission_EnterBattleWithParam = DifficultyMission_EnterBattleWithParam

function DifficultyMission_EnterBattleWithParam:Constructor(pManger, nodeID, missionID, missionComponentID, campaignComponentCfgID)
  self._nodeID = nodeID
  self._missionID = missionID
  self._missionComponentID = missionComponentID
  self._campaignComponentCfgID = campaignComponentCfgID
end

function DifficultyMission_EnterBattleWithParam:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo
  createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, {
    self._nodeID,
    self._missionID,
    self._missionComponentID,
    self._campaignComponentCfgID
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_DifficultyMission, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
    YIELD(TT, 5000)
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end
