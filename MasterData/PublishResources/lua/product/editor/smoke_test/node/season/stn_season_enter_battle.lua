require("common_async_base")
_class("Season_EnterBattle", Common_AsyncBase)
Season_EnterBattle = Season_EnterBattle

function Season_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = runData:GetMissionID()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonObj = seasonModule:GetCurSeasonObj()
  local seasonMissionComponent = seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local componentID = seasonMissionComponent:GetCampaignMissionComponentId()
  local paramKeyMap = seasonMissionComponent:GetCampaignMissionParamKeyMap()
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_Season, {
    missionID,
    componentID,
    paramKeyMap
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_Season, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end
