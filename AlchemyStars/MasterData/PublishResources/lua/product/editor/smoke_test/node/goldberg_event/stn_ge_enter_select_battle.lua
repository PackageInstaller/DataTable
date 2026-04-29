require("common_async_base")
_class("GoldbergEvent_EnterSelectBattle", Common_AsyncBase)
GoldbergEvent_EnterSelectBattle = GoldbergEvent_EnterSelectBattle

function GoldbergEvent_EnterSelectBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local params = {
    runData:GetNeedMissionID(),
    1,
    {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = runData:GetComponentConfigID()
    }
  }
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_Campaign, params)
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_Campaign, TestConst.MissionTeamIndex, createInfo)
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
