local PvpReplayAngleItem, Super = System.NewComponent("PvpReplayAngleItem")
local UNIT_MAX_NUM = 5

function PvpReplayAngleItem:ctor(go, model, recordData, isWin, isEnemy)
  Super.ctor(self)
  self.ui = UIBaseResource(go)
  self.recordData = recordData
  self.isWin = isWin
  self.isEnemy = isEnemy
  self.model = model
  local playerHighestVal = self.model:GetTeamSettleDataGroupHigestVal(self.model.playerTeamSettleDataGroup)
  local enerMyHighestVal = self.model:GetTeamSettleDataGroupHigestVal(self.model.enermyTeamSettleDataGroup)
  self.highestVal = math.max(playerHighestVal, enerMyHighestVal)
end

function PvpReplayAngleItem:OnBind(binder)
  self.binder = binder
  if not self.recordData then
    return
  end
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClickSelected))
  binder:SetActive(self.ui.Image_Victory_Str, self.isWin)
  binder:SetActive(self.ui.Image_Fail_Str, not self.isWin)
  binder:BindToText(self.ui.Text_Name, function()
    return self.recordData.name
  end)
  binder:BindToText(self.ui.Text_Score, function()
    return self.recordData.finalScore
  end)
  binder:BindToText(self.ui.Text_Value, function()
    do return self.SetValue end
    return self.SetValue, self
  end)
  binder:BindButtonClick(self.ui.Btn_HeadClick, function()
    if self.recordData.isAI then
      if ApplicationUtils.IsEditor() then
        Alert.ShowStr(LT.Text("PvPReplay_CheckBot"))
      end
      return
    end
    local uid = self.recordData.uid
    SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, uid)
  end)
  binder:BindComponent((CommonHeadItem(self.ui.Own_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.recordData.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.recordData.avatarFrame)
  })))
  self:SetPlayerSettleData()
  binder:BindEvent(EventMgr.Instance.BattleReplayTargetUid, System.fn(self, self.OnSelectedUid))
end

function PvpReplayAngleItem:OnUnbind()
end

function PvpReplayAngleItem:OnClickSelected()
  EventMgr.Instance.BattleReplayTargetUid:Dispatch(self.recordData.uid)
end

function PvpReplayAngleItem:OnSelectedUid(uid)
  self.ui.Image_Select:SetActive(self.recordData.uid == uid)
end

function PvpReplayAngleItem:SetValue()
  local score = self.recordData.score
  local finalScore = self.recordData.finalScore
  local value = finalScore - score
  local greenColor = "#74ce96"
  local redColor = "#bb646d"
  if value > 0 then
    do return string.format, "<color=%s>+%s</color>", greenColor end
    return string.format, "<color=%s>+%s</color>", greenColor, value
  elseif value < 0 then
    do return string.format, "<color=%s>%s</color>", redColor end
    return string.format, "<color=%s>%s</color>", redColor, value
  else
    return ""
  end
end

function PvpReplayAngleItem:SetPlayerSettleData()
  for i = 1, UNIT_MAX_NUM do
    local unitSettleData = self.model.playerTeamSettleDataGroup[i]
    if self.isEnemy then
      unitSettleData = self.model.enermyTeamSettleDataGroup[i]
    end
    local obj = self.ui["Player_Score_" .. i]
    self:_OnBindScoreColumComp(self.binder, obj, unitSettleData, self.highestVal)
    local parentNode = self.ui["Player_Content_" .. i]
    self.binder:BindNewComponent(parentNode, PVPCollectUnitItem, UI_Social_Item_PvpDispositionResource, unitSettleData.tid1)
    self.binder:BindNewComponent(parentNode, PVPCollectUnitItem, UI_Social_Item_PvpDispositionResource, unitSettleData.tid2)
  end
end

function PvpReplayAngleItem:_OnBindScoreColumComp(binder, obj, unitSettleData, highestVal)
  local itemData = {
    damage = unitSettleData.settleData.damage,
    heal = unitSettleData.settleData.heal,
    shield = unitSettleData.settleData.shield,
    columPercent = self.model:GetSettleDataTotalVal(unitSettleData.settleData) / highestVal
  }
  binder:BindComponent(PvPSettleScoreColumItem(obj, itemData))
end

return PvpReplayAngleItem
