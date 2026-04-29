require("common_async_base")
_class("GoldbergEvent_ExpensionSupport", Common_AsyncBase)
GoldbergEvent_ExpensionSupport = GoldbergEvent_ExpensionSupport

function GoldbergEvent_ExpensionSupport:TaskFunc(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self._manager:GetMissionRunData()
  if not runData.GetExpensionType or not runData:GetExpensionType() then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
    return
  end
  local expensionType = runData:GetExpensionType()
  if expensionType == STGoldbergRunDataExpension.N12HardAffix then
    if not runData.GetN12HardAffix or not runData:GetN12HardAffix() then
      Log.exception(self._className, "N12 hard affix expension parse failed. ")
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    return self:_N12HardAffixSupport(TT, status)
  end
end

function GoldbergEvent_ExpensionSupport:_N12HardAffixSupport(TT, status)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    Log.exception(self._className, "load campaign info failed: ", res.m_result)
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local runData = self._manager:GetMissionRunData()
  self._challengeMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  local resHandleClearAffix = AsyncRequestRes:New()
  self._challengeMissionComponent:HandleClearAffix(TT, resHandleClearAffix, runData:GetMissionID())
  if not resHandleClearAffix:GetSucc() then
    Log.exception(self._className, "clear affix failed: ", resHandleClearAffix.m_result)
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local affix = runData:GetN12HardAffix()
  if #affix == 0 then
    Log.info(self._className, "No affix selected, skipping. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
    return
  end
  local resSelectAffix = AsyncRequestRes:New()
  self._challengeMissionComponent:HandleSelectAffix(TT, resSelectAffix, runData:GetMissionID(), affix)
  if not resSelectAffix:GetSucc() then
    Log.exception(self._className, "select affix failed: ", resHandleClearAffix.m_result)
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end
