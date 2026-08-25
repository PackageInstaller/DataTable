local AwakerVoiceController = NewClass("AwakerVoiceController", BaseController)

function AwakerVoiceController:OnInit()
end

function AwakerVoiceController:OnReset()
end

function AwakerVoiceController:ReqMarkPvpOpeningVoiceRead(pvpVoiceTidList, callback)
  local targetPvpVoiceTidList = {}
  for _, pvpVoiceTid in ipairs(pvpVoiceTidList) do
    if AwakerVoiceModel.Instance:GetPvpVoiceState(pvpVoiceTid) == CommonDefine.AwakerStoryVoiceState.Unlock then
      table.insert(targetPvpVoiceTidList, pvpVoiceTid)
    end
  end
  if 0 == #targetPvpVoiceTidList then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "MarkPvpOpeningVoiceRead", function(data)
    Logger.Info("========== MarkPvpOpeningVoiceRead Successful ==========\n", table.tostring(data or {}))
    for _, pvpVoiceTid in ipairs(targetPvpVoiceTidList) do
      AwakerVoiceModel.Instance:SetPvpVoiceState(pvpVoiceTid, CommonDefine.AwakerStoryVoiceState.Read)
    end
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== MarkPvpOpeningVoiceRead fail ==========\n", table.tostring(data or {}))
  end, targetPvpVoiceTidList)
end

function AwakerVoiceController:ReqUnlockPvpOpeningVoice(pvpVoiceTid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "UnlockPvpOpeningVoice", function(data)
    Logger.Info("========== UnlockPvpOpeningVoice Successful ==========\n", table.tostring(data or {}))
    AwakerVoiceModel.Instance:SetPvpVoiceState(pvpVoiceTid, CommonDefine.AwakerStoryVoiceState.Unlock)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== UnlockPvpOpeningVoice fail ==========\n", table.tostring(data or {}))
  end, pvpVoiceTid)
end

function AwakerVoiceController:ReqGetPvpOpeningVoices(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "GetPvpOpeningVoices", function(data)
    Logger.Info("========== GetPvpOpeningVoices Successful ==========\n", table.tostring(data or {}))
    AwakerVoiceModel.Instance:UpdatePvpVoiceStateDict(data.voices)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== GetPvpOpeningVoices fail ==========\n", table.tostring(data or {}))
  end)
end

return AwakerVoiceController
