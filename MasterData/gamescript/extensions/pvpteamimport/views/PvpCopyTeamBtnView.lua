local PvpCopyTeamBtnView, Super = NewClass("PvpCopyTeamBtnView", PvpBtnListView)
PvpCopyTeamBtnView.uiResCls = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_Copy_Formation.prefab"

function PvpCopyTeamBtnView:ctor(positionNode, recordData, selectedUid, offsetPosition)
  Super.ctor(self, positionNode, offsetPosition)
  self.recordData = recordData
  self.selectedUid = selectedUid
  self.btnList = self:GetBtnList()
end

function PvpCopyTeamBtnView:GetBtnList()
  local btnList = {
    {
      btnFunc = System.fn(self, self.OnCopyRecord),
      btnText = LT.Text("CopyRecording")
    }
  }
  if self.selectedUid then
    table.insert(btnList, {
      btnFunc = System.fn(self, self.OnCopyLineup),
      btnText = LT.Text("CopyLineup")
    })
  else
    table.insert(btnList, {
      btnFunc = System.fn(self, self.OnCopyLeftLineup),
      btnText = LT.Text("CopyLeftLineup")
    })
    table.insert(btnList, {
      btnFunc = System.fn(self, self.OnCopyRightLineup),
      btnText = LT.Text("CopyRightLineup")
    })
  end
  return btnList
end

function PvpCopyTeamBtnView:OnCopyRecord()
  local shareCode
  if self.recordData and self.recordData.selfUid and self.recordData.opponentUid then
    shareCode = PVPBattleReplayUtils.GetShareContent(self.recordData)
  else
    shareCode = PVPBattleReplayUtils.GetShareContentFromCurBattle()
  end
  if not shareCode then
    return
  end
  StrUtils.CopyToClipboard(shareCode)
  Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
end

function PvpCopyTeamBtnView:OnCopyLineup()
  print("------------------on copy lineup", table.tostring(self.recordData, 6))
  local data = self.recordData.statsData[self.selectedUid]
  if not data then
    Logger.Error("on copy lineup, data is nil")
    return
  end
  self:_CopyTeamShareCode(data)
end

function PvpCopyTeamBtnView:OnCopyLeftLineup()
  local selfUid = PlayerDataUtils.GetPlayerUid()
  local data = self.recordData.statsData[selfUid]
  if not data then
    Logger.Error("on copy lineup, data is nil")
    return
  end
  self:_CopyTeamShareCode(data)
end

function PvpCopyTeamBtnView:OnCopyRightLineup()
  local data
  for uid, _data in pairs(self.recordData.statsData) do
    if uid ~= PlayerDataUtils.GetPlayerUid() then
      data = _data
    end
  end
  if not data then
    Logger.Error("on copy lineup, data is nil")
    return
  end
  self:_CopyTeamShareCode(data)
  PvpController.Instance:ReqOnCopyOpponentDeck(-1)
end

function PvpCopyTeamBtnView:_CopyTeamShareCode(statsData)
  local awakerTids = {}
  local weaponTids = statsData.weaponList
  local keeperSkillTids = statsData.keeperSkillList
  for _, awakerInfo in ipairs(statsData.awakerList) do
    table.insert(awakerTids, {
      tid = awakerInfo.awakers.tid
    })
  end
  local shareCode = PvPTeamBuildDataUtils.GetTeamShareContent(awakerTids, weaponTids, keeperSkillTids)
  if not shareCode then
    Logger.Error("on copy lineup, share code is nil")
    return
  end
  StrUtils.CopyToClipboard(shareCode)
  Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
end

return PvpCopyTeamBtnView
