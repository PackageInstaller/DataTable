require("common_async_base")
_class("ExtraMission_EnterBattle", Common_AsyncBase)
ExtraMission_EnterBattle = ExtraMission_EnterBattle

function ExtraMission_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local stage1Id = runData:GetMissionID()
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_ExtMission, {
    runData:GetExtChapterID(),
    runData:GetExtMissionID()
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_ExtMission, TestConst.MissionTeamIndex, createInfo)
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
