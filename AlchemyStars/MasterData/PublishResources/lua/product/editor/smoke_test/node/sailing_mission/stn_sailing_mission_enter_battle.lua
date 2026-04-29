require("common_async_base")
_class("SailingMission_EnterBattle", Common_AsyncBase)
SailingMission_EnterBattle = SailingMission_EnterBattle

function SailingMission_EnterBattle:TaskFunc(TT, status)
  local sailingModule = GameGlobal.GetModule(SailingMissionModule)
  sailingModule:CacheHistoryMissionCount()
  local runData = self.m_pManager:GetMissionRunData()
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_SailingMission, {
    runData:GetLayerID(),
    runData:GetMissionID()
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_SailingMission, TestConst.MissionTeamIndex, createInfo)
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
