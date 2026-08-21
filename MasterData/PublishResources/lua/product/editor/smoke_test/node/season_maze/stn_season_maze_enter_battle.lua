require("common_async_base")
_class("SeasonMaze_EnterBattle", Common_AsyncBase)
SeasonMaze_EnterBattle = SeasonMaze_EnterBattle

function SeasonMaze_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = runData:GetMissionID()
  local componentID = runData:GetComponentID()
  local game = GameGlobal.GetModule(GameMatchModule)
  local paramRoomID = 9001003
  local paramComponentID = 22
  local paramKeyMap = {componentID}
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_SeasonMaze, {
    paramRoomID,
    missionID,
    paramComponentID,
    paramKeyMap
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_SeasonMaze, TestConst.MissionTeamIndex, createInfo)
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
