local CopyRecordsItem, Super = NewViewComponent("CopyRecordsItem")

function CopyRecordsItem:ctor(uiNode, view, recordData)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self.recordData = recordData
end

function CopyRecordsItem:RegisterNotifications()
end

function CopyRecordsItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Detail, System.fn(self, self.OnBtnDetail))
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self.OnBtnReplay))
  self:AddButtonClickListener(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
end

function CopyRecordsItem:OnBuildComponent()
  Super.OnBuildComponent(self)
end

function CopyRecordsItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:LoadAllLangFont(self.ui.Text_PlayerName)
  self:SetAwakerData()
  self:SetKeeperSkill()
  self:SetTime()
  self:SetBout()
  self:SetPlayerIcon()
end

function CopyRecordsItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopyRecordsItem:SetAwakerData()
  local awakerList = self.recordData.awakerOutlineList
  for i = 1, CommonDefine.TeamAwakerCount do
    local name = "Awaker_" .. i
    local awakerGo = self.ui[name]
    if awakerGo then
      local awakerData = awakerList[i]
      local isEmpty = nil == awakerData or 0 == awakerData.tid
      self:SetActive(awakerGo, not isEmpty)
      if isEmpty then
      else
        self:AddViewComponentOnce(awakerGo, CopyRecordsAwakertem, awakerData)
      end
    end
  end
end

function CopyRecordsItem:SetKeeperSkill()
  local keeperSkill = self.recordData.teamData.keeperSkill
  local isEmpty = nil == keeperSkill or 0 == keeperSkill
  self:SetActive(self.ui.KeyToken, not isEmpty)
  if isEmpty then
    return
  end
  local itemCfg = ItemDataUtils.GetItemConfig(keeperSkill)
  if not itemCfg then
    self:SetActive(self.ui.KeyToken, false)
    return
  end
  self:AddViewComponentOnce(self.ui.KeyToken, CopyRecordsKeeperSkillItem, keeperSkill)
end

function CopyRecordsItem:SetTime()
  local time = self.recordData.timestamp
  local date = TimeUtils.GetServerDate(time or 0)
  local dateStr = string.format("%s/%s/%s %s:%s", date.year, date.month, date.day, date.hour, date.min < 10 and "0" .. date.min or date.min)
  self:SetText(self.ui.Text_BattleTime, dateStr)
end

function CopyRecordsItem:SetBout()
  local isAbyssExtra = self.recordData.extParam and 1 == self.recordData.extParam.isAbyssExtra
  local totalBoutStr = isAbyssExtra and LT.Text("PvEReplayAddRoundsNum") or LT.Text("PvEReplayRoundsNum")
  self:SetText(self.ui.Text_Rounds, totalBoutStr .. ":" .. self.recordData.totalBout)
end

function CopyRecordsItem:SetPlayerIcon()
  local playerId = self.recordData.playerId
  local facade = CopyRecordsModel.Instance:GetRecordFacade(playerId)
  if not facade then
    return
  end
  self:SetText(self.ui.Text_PlayerName, facade.name)
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(facade.avatarFrame),
    clickCb = System.fn(self, self._OnAvatarClick)
  })
end

function CopyRecordsItem:_OnAvatarClick()
  local playerUid = self.recordData.playerId
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, playerUid)
end

function CopyRecordsItem:OnBtnDetail()
  local facade = CopyRecordsModel.Instance:GetRecordFacade(self.recordData.playerId)
  CopyRecordsController.Instance:OpenRecordDetailPanel(self.recordData.stageTid, self.recordData.wid, self.recordData.playerId, facade)
end

function CopyRecordsItem:OnBtnReplay()
  CopyRecordsController.Instance:ReqPVEBattleRecord(self.recordData.battleUuid)
end

function CopyRecordsItem:OnBtnCopy()
  PVEBattleReplayUtils.GetShareContent(self.recordData, function(shareCode)
    StrUtils.CopyToClipboard(shareCode)
    Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
  end)
end

return CopyRecordsItem
