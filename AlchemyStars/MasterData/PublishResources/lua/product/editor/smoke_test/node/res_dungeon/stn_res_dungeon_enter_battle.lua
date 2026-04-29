require("common_async_base")
_class("ResDungeon_EnterBattle", Common_AsyncBase)
ResDungeon_EnterBattle = ResDungeon_EnterBattle

function ResDungeon_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local resDungeonModule = self:GetModule(ResDungeonModule)
  for i = 1, 3 do
    local res = resDungeonModule:StartMatchTask(TT, runData:GetMissionID(), TestConst.MissionTeamIndex)
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
