require("common_async_base")
_class("Tower_EnterBattle", Common_AsyncBase)
Tower_EnterBattle = Tower_EnterBattle

function Tower_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local stage1Id = runData:GetMissionID()
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_Tower, runData:GetMissionID())
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_Tower, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
    YIELD(TT, 10000)
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end
