local SocialPvpRecordItem, Super = System.NewComponent("SocialPvpRecordItem")

function SocialPvpRecordItem:ctor(go, recordData, facade)
  Super.ctor(self)
  self.ui = UIBaseResource(go)
  self.recordData = recordData
  self.playerUid = recordData.selfUid
  self.facade = facade
end

function SocialPvpRecordItem:OnBind(binder)
  self.binder = binder
  if not self.recordData then
    return
  end
  binder:LoadAllLangFont(self.ui.Text_PlayerName)
  binder:LoadAllLangFont(self.ui.Text_EnemyName)
  binder:BindToVisible(self.ui.Image_Victory_Str, function()
    do return self.IsWin end
    return self.IsWin, self
  end)
  binder:BindToVisible(self.ui.Image_Fail_Str, function()
    do return self.IsFail end
    return self.IsFail, self
  end)
  binder:BindToText(self.ui.Text_BattleType, function()
    do return self.GetPVPGameplayType end
    return self.GetPVPGameplayType, self
  end)
  binder:BindToText(self.ui.Text_BattleTime, function()
    do return PvPSeasonDataUtils.GetPvpBattleTimeDesc end
    return PvPSeasonDataUtils.GetPvpBattleTimeDesc, self.recordData.timestamp
  end)
  binder:BindToText(self.ui.Text_PlayerName, function()
    return self.facade.name
  end)
  binder:BindToText(self.ui.Text_EnemyName, function()
    do return self.GetEnemyName end
    return self.GetEnemyName, self
  end)
  binder:BindToText(self.ui.Text_Value, function()
    do return self.GetDeltaScoreText end
    return self.GetDeltaScoreText, self
  end)
  binder:BindZ1Button(self.ui.Btn_Click, function()
    self:OnViewDetailInfo()
  end)
  binder:BindButtonClick(self.ui.Btn_Replay, function()
    self:OnClickReplay()
  end)
  binder:BindButtonClick(self.ui.Btn_Copy, function()
    self:OnBtnCopy()
  end)
  self:SetPlayerInfo()
  self:SetEnemyInfo()
  self:SetPVPGameType()
end

function SocialPvpRecordItem:OnUnbind()
  Super.OnUnbind(self)
end

function SocialPvpRecordItem:IsWin()
  local winnerId = self.recordData.winnerId
  return self.playerUid == winnerId
end

function SocialPvpRecordItem:IsFail()
  local winnerId = self.recordData.winnerId
  return self.playerUid ~= winnerId
end

function SocialPvpRecordItem:GetDeltaScoreText()
  local playerData = self:GetPvpRecordData(self.playerUid)
  local score = playerData.score
  local finalScore = playerData.finalScore
  local deltaScore = 0
  if score and finalScore then
    deltaScore = finalScore - score
  end
  if deltaScore > 0 then
    return "+" .. deltaScore
  elseif 0 == deltaScore then
    if self:IsWin() then
      return "+" .. deltaScore
    else
      return "-" .. deltaScore
    end
  end
  return deltaScore
end

function SocialPvpRecordItem:GetPVPGameplayType()
  local PVPGameplayType = self.recordData.PVPGameplayType
  if PVPGameplayType == CommonDefine.PVPGameplayType.Match then
    do return LT.Text end
    return LT.Text, "PvpMatchBattle"
  end
  if PVPGameplayType == CommonDefine.PVPGameplayType.Friend then
    do return LT.Text end
    return LT.Text, "PvpFriendBattle"
  end
  return ""
end

function SocialPvpRecordItem:GetEnemyName()
  local enemyUid = self.recordData.opponentUid
  if enemyUid then
    local data = self:GetPvpRecordData(enemyUid)
    return data and data.name
  end
  return ""
end

function SocialPvpRecordItem:SetPVPGameType()
  local pvpModeName = PvpDefine.GetPVPModeName(self.recordData.matchType, self.recordData.pvpType)
  self.binder:SetText(self.ui.Text_BattleType, pvpModeName)
end

function SocialPvpRecordItem:SetPlayerInfo()
  local roleId = self.playerUid
  local awakerList = self:GetPvpRecordData(roleId).awakerList
  self:SetAwakerData(awakerList)
  self.binder:BindComponent(CommonHeadItem(self.ui.UI_Common_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.facade.avatarFrame)
  }))
end

function SocialPvpRecordItem:SetEnemyInfo()
  local roleId = self.recordData.opponentUid
  local awakerList = self:GetPvpRecordData(roleId).awakerList
  self:SetAwakerData(awakerList, true)
end

function SocialPvpRecordItem:GetPvpRecordData(playerUid)
  local statsData = self.recordData.statsData
  if statsData and statsData[playerUid] then
    return statsData[playerUid]
  end
  return {}
end

function SocialPvpRecordItem:SetAwakerData(awakerList, isEnemy)
  if not awakerList then
    return
  end
  local bindAwakerList = awakerList
  if not isEnemy then
    bindAwakerList = {}
    for i = 1, #awakerList do
      bindAwakerList[i] = awakerList[#awakerList - i + 1]
    end
  end
  for i, awakerData in ipairs(bindAwakerList) do
    local name = "Awaker_" .. i
    if isEnemy then
      name = "Enemy_" .. name
    end
    local awakerGo = self.ui[name]
    if awakerGo then
      self.binder:SetActive(awakerGo, nil ~= awakerData)
      if not awakerData then
      else
        self.binder:BindComponent(PvpRecordAwakerItem(awakerGo, awakerData.awakers.tid))
      end
    end
  end
end

function SocialPvpRecordItem:OnClickReplay()
  if not self.recordData then
    return
  end
  UIManager.Instance:Reopen(Urls.PvpReplayAnglePanel, self.recordData)
end

function SocialPvpRecordItem:OnViewDetailInfo()
  local svrData = {
    statsData = self.recordData.statsData,
    settleRewards = {}
  }
  PvPSettleDataUtils.InitByServerData(svrData)
  PvPSettleDataUtils.OpenPvPBattleDataSettlePanel(nil, nil, self.recordData)
end

function SocialPvpRecordItem:OnBtnCopy()
  if not self.recordData then
    return
  end
  local shareCode = PVPBattleReplayUtils.GetShareContent(self.recordData)
  if not shareCode then
    return
  end
  StrUtils.CopyToClipboard(shareCode)
  Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
end

return SocialPvpRecordItem
