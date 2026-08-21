require("common_async_base")
_class("PopStarPro_EnterBattle", Common_AsyncBase)
PopStarPro_EnterBattle = PopStarPro_EnterBattle

function PopStarPro_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local params = {
    runData:GetMissionID(),
    runData:GetComponentEnumID(),
    {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = runData:GetComponentConfigID()
    }
  }
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_PopStarPro, params)
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_PopStarPro, TestConst.MissionTeamIndex, createInfo)
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
