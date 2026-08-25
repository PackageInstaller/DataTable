local PopupTutorialAvgComp = System.NewClass("PopupTutorialAvgComp", PopupBaseComp)
local TutorialAvgStopUrls = {
  Urls.DBGMainCopyOutPanel,
  Urls.PvPBattleMainPanel,
  Urls.PvPBattleRankSettlePanel,
  Urls.PVPBattleDataSettlePanel
}

function PopupTutorialAvgComp:ctor()
  self.popTutorialAvgInfoList = {}
end

function PopupTutorialAvgComp:OnBind(binder)
  self.binder = binder
end

function PopupTutorialAvgComp:Clear()
  table.clear(self.popTutorialAvgInfoList)
end

function PopupTutorialAvgComp:InsertPopTutorialAvgInfo(avgTid, key)
  local targetInfo = {avgTid = avgTid, key = key}
  table.insert(self.popTutorialAvgInfoList, targetInfo)
end

function PopupTutorialAvgComp:ClearPopTutorialAvgInfo()
  self.popTutorialAvgInfoList = {}
end

function PopupTutorialAvgComp:CheckPopup()
  if not table.next(self.popTutorialAvgInfoList) or DataCenter.copiesData.copiesSettleData then
    return
  end
  for _, url in ipairs(TutorialAvgStopUrls) do
    if UIManager.Instance:GetWindow(url) then
      return
    end
  end
  local targetInfo = table.remove(self.popTutorialAvgInfoList, 1)
  local avgTid = targetInfo.avgTid
  local key = targetInfo.key
  if AvgTutorialManager.Instance:CheckIsPlayed(CommonDefine.ClientDataMainKey.AVG, key) then
    return
  end
  AvgTutorialManager.Instance:PlayTutorialAvgByKeyWord(avgTid, key)
  AvgStoryManager.Instance:WaitStoryFinish(nil, function()
    self:SetBusy(false)
  end)
  self:SetBusy(true)
end

function PopupTutorialAvgComp:_OnBusySafetyCheck()
  do return AvgStoryManager.Instance.IsPlaying end
  return AvgStoryManager.Instance.IsPlaying, AvgStoryManager.Instance
end

return PopupTutorialAvgComp
