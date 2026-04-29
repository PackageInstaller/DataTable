require("common_async_base")
_class("Tale_EnterBattle", Common_AsyncBase)
Tale_EnterBattle = Tale_EnterBattle

function Tale_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local stage1Id = runData:GetMissionID()
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_TalePet, stage1Id)
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_TalePet, TestConst.MissionTeamIndex, createInfo)
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
