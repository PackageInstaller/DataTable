local WorldDailyChallengeComp = System.NewClass("WorldDailyChallengeComp", WorldStageComp)

function WorldDailyChallengeComp:EnterWorldStage(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnDailyChallenge", function(copyData)
    if callback then
      callback()
    end
    self:HandleEnterWorldData(copyData)
  end, function(data, errcode)
    Logger.Error(string.format("WorldDailyChallengeComp进入副本失败:%s errcode:%s", table.tostring(data or {}), table.tostring(errcode or {})))
  end, table.deepclone(self.stageData.chooseTalents))
end

return WorldDailyChallengeComp
