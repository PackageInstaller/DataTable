local GuideNoteController = NewClass("GuideNoteController", BaseController)

function GuideNoteController:OnInit()
end

function GuideNoteController:OnReset()
end

function GuideNoteController:ReqOnOpenGuideNote(forceReq)
  local model = GuideNoteModel and GuideNoteModel.Instance
  if not forceReq and model and model.HasGuideNoteData and model:HasGuideNoteData() then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenGuideNote", function(data)
    Logger.Info("[GuideNote][Controller] OnOpenGuideNote rsp=%s", table.tostring(data))
    GuideNoteModel.Instance:UpdateGuideNoteData(data)
  end, function(errData)
    Logger.Debug("[GuideNote][Controller] OnOpenGuideNote failed err=%s", table.tostring(errData))
  end)
end

function GuideNoteController:ReqOnPrepareAwakerStrengthStageData(stageGroupIdList)
  if not stageGroupIdList or 0 == #stageGroupIdList then
    return
  end
  local needRequestList = CopyDataUtils.CollectGuideNoteNeedRequestStageGroupIds(stageGroupIdList)
  if not needRequestList or 0 == #needRequestList then
    return
  end
  CopyDataUtils.ReqCopyDataList(needRequestList)
end

function GuideNoteController:ReqOnGetGuideNoteReward(levelType, level)
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetGuideNoteReward", function()
  end, nil, levelType, level)
end

return GuideNoteController
