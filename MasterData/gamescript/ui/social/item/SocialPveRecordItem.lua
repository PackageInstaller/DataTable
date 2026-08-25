local SocialPveRecordItem, Super = System.NewComponent("SocialPveRecordItem")

function SocialPveRecordItem:ctor(go, recordData, facade)
  Super.ctor(self)
  self.ui = UIBaseResource(go)
  self.recordData = recordData
  self.facade = facade
end

function SocialPveRecordItem:OnBind(binder)
  self.binder = binder
  if not self.recordData then
    return
  end
  binder:LoadAllLangFont(self.ui.Text_BattleType)
  binder:BindToVisible(self.ui.Image_Victory_Str, function()
    do return self.IsWin end
    return self.IsWin, self
  end)
  binder:BindToVisible(self.ui.Image_Fail_Str, function()
    do return self.IsFail end
    return self.IsFail, self
  end)
  binder:BindToText(self.ui.Text_BattleType, function()
    return self.facade.name
  end)
  binder:BindToText(self.ui.Text_BattleTime, System.fn(self, self.GetBattleTime))
  binder:BindToText(self.ui.Text_StageName, System.fn(self, self.GetStageName))
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnViewDetailInfo))
  binder:BindButtonClick(self.ui.Btn_Replay, System.fn(self, self.OnBtnReplay))
  binder:BindButtonClick(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
  self:SetAwakerData()
  self:SetKeeperSkill()
  self:BindPlayerHeadIcon()
end

function SocialPveRecordItem:OnUnbind()
  Super.OnUnbind(self)
end

function SocialPveRecordItem:GetBattleResult()
  local teamData = self.recordData and self.recordData.teamData
  local recordStageData = teamData and teamData.recordStageData
  local exitList = recordStageData and recordStageData.battleStatPackExitList
  if type(exitList) ~= "table" then
    return nil
  end
  local lastResult
  local lastIndex = -1
  for key, exitRow in pairs(exitList) do
    if type(exitRow) == "table" and exitRow.result ~= nil then
      local index = tonumber(exitRow.battleIndex) or tonumber(key) or 0
      if lastIndex <= index then
        lastIndex = index
        lastResult = exitRow.result
      end
    end
  end
  return lastResult
end

function SocialPveRecordItem:IsWin()
  local result = self:GetBattleResult()
  if nil == result then
    return true
  end
  return 1 == result
end

function SocialPveRecordItem:IsFail()
  local result = self:GetBattleResult()
  if nil == result then
    return false
  end
  return 1 ~= result
end

function SocialPveRecordItem:GetPlayerName()
  do return end
  return PlayerDataUtils.GetName
end

function SocialPveRecordItem:BindPlayerHeadIcon()
  self.binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.facade.avatarFrame)
  })))
end

function SocialPveRecordItem:GetBattleTime()
  local time = self.recordData.timestamp
  local date = TimeUtils.GetServerDate(time or 0)
  local dateStr = string.format("%s/%s/%s %s:%s", date.year, date.month, date.day, date.hour, date.min < 10 and "0" .. date.min or date.min)
  return dateStr
end

function SocialPveRecordItem:GetStageName()
  local stageTid = self.recordData.stageTid
  local stageCfg = CopyDataUtils.GetStageCfg(stageTid)
  local stageName = stageCfg and stageCfg.Name
  if self.recordData.extParam and 1 == self.recordData.extParam.isAbyssExtra then
    stageName = stageName .. LT.Text("AbyssChallengeHistoricalRecord")
  end
  return stageName
end

function SocialPveRecordItem:SetAwakerData()
  local awakerList = self.recordData.awakerOutlineList
  for i = 1, CommonDefine.TeamAwakerCount do
    local awakerData = awakerList[i]
    local name = "Awaker_" .. i
    local awakerGo = self.ui[name]
    if awakerGo then
      self.binder:SetActive(awakerGo, nil ~= awakerData)
      if not awakerData then
      else
        self.binder:BindComponent(PvpRecordAwakerItem(awakerGo, awakerData.tid, awakerData.curSkin))
      end
    end
  end
end

function SocialPveRecordItem:SetKeeperSkill()
  local keeperSkill = self.recordData.teamData and self.recordData.teamData.keeperSkill
  if not keeperSkill then
    self.binder:SetActive(self.ui.KeyToken, false)
    return
  end
  self.binder:SetActive(self.ui.KeyToken, true)
  self.binder:BindComponent(RecordKeeperSkillItem(self.ui.KeyToken, keeperSkill))
end

function SocialPveRecordItem:OnViewDetailInfo()
  CopyRecordsController.Instance:OpenRecordDetailPanel(self.recordData.stageTid, self.recordData.wid, self.recordData.playerId, self.facade)
end

function SocialPveRecordItem:OnBtnReplay()
  CopyRecordsController.Instance:ReqPVEBattleRecord(self.recordData.battleUuid)
end

function SocialPveRecordItem:OnBtnCopy()
  if not self.recordData then
    return
  end
  PVEBattleReplayUtils.GetShareContent(self.recordData, function(shareCode)
    StrUtils.CopyToClipboard(shareCode)
    Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
  end)
end

return SocialPveRecordItem
