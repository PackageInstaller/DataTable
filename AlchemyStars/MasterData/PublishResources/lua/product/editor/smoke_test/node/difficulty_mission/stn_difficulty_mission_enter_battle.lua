require("common_async_base")
_class("DifficultyMission_EnterBattle", Common_AsyncBase)
DifficultyMission_EnterBattle = DifficultyMission_EnterBattle

function DifficultyMission_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo
  if runData:GetComponentConfigID() then
    createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, {
      runData:GetNodeID(),
      runData:GetMissionID(),
      runData:GetMissionComponentID(),
      runData:GetCampaignComponentCfgID()
    })
  else
    createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, {
      runData:GetNodeID(),
      runData:GetMissionID()
    })
  end
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
