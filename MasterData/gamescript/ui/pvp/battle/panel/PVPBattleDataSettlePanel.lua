local BattleResult = CommonDefine.BattleResult
local Vector3 = CS.UnityEngine.Vector3
local Z1ButtonState = CommonDefine.Z1ButtonState
local UNIT_MAX_NUM = 5
local PVPBattleDataSettlePanel, Super = System.NewClass("PVPBattleDataSettlePanel", UIBasePanel)
PVPBattleDataSettlePanel.uiResCls = UI_Pvp_Panel_SettlementResource

function PVPBattleDataSettlePanel:ctor(closeCb, battleRst, battleRecordData)
  Super.ctor(self)
  self.closeCb = closeCb
  self.battleRst = battleRst
  self.battleRecordData = battleRecordData
end

function PVPBattleDataSettlePanel:OnBind(binder)
  self:Init(binder)
  binder:LoadAllLangFont(self.ui.Text_Name_1)
  binder:LoadAllLangFont(self.ui.Text_Name_2)
  binder:BindEvent(EventMgr.Instance.PvPMatchEnded, System.fn(self, self.OnOneMoreGameStart))
  binder:BindEvent(EventMgr.Instance.SocialReceiveGood, System.fn(self, self._ShowEnermyGood))
  binder:BindEvent(EventMgr.Instance.PvpMoreGameBeRefuse, System.fn(self, self.OnPvpMoreGameBeRefused))
  binder:BindEvent(EventMgr.Instance.PvpMoreGameClickRefuse, System.fn(self, self.PvpMoreGameClickRefuse))
  local playerHighestVal = self.model:GetTeamSettleDataGroupHigestVal(self.model.playerTeamSettleDataGroup)
  local enerMyHighestVal = self.model:GetTeamSettleDataGroupHigestVal(self.model.enermyTeamSettleDataGroup)
  self.highestVal = math.max(playerHighestVal, enerMyHighestVal)
  self:_OnBindSocialElement()
  self:_OnBindPlayerSettleData()
  self:_OnBindEnermySettleData()
  self:_OnBindMoreGameBtn()
  binder:BindToVisible(self.ui.Image_Victory, function()
    return self.battleRst == BattleResult.Win
  end)
  binder:BindToVisible(self.ui.Image_Fail, function()
    return self.battleRst == BattleResult.Fail
  end)
  binder:SetText(self.ui.Text_Integral_01, DataCenter.pvpSettleData.finalScore)
  binder:SetText(self.ui.Text_Integral_02, DataCenter.pvpSettleData.opponentScore)
  self:_BindScoresVar(binder)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self._OnClickConfirmFunc), function()
    return Z1ButtonState.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end)
  self:_BindCopyBattleRecord(binder)
end

function PVPBattleDataSettlePanel:_BindCopyBattleRecord(binder)
  if not self.ui.Btn_Copy then
    return
  end
  self.ui.Btn_Copy:SetActive(true)
  binder:BindButtonClick(self.ui.Btn_Copy, function()
    local opponentUid
    local recordData = self.battleRecordData
    recordData = recordData or PvPSettleDataUtils.GetSettleData()
    print("------------------on btn copy", opponentUid, table.tostring(recordData, 6))
    UIManager.Instance:Reopen(Urls.PvpCopyTeamBtnView, self.ui.Btn_Copy, recordData, opponentUid, Vector3(0, 50))
  end)
end

function PVPBattleDataSettlePanel:_OnBindSocialElement()
  local isAI = self.model.enermyInfo.isAI
  self.ui.Btn_Commend:SetActive(not self.battleRecordData)
  self.ui.Btn_Attention:SetActive(not self.battleRecordData)
  self.binder:SetButtonState(self.ui.Btn_Commend, Z1ButtonState.Normal)
  self.binder:BindZ1Button(self.ui.Btn_Commend, function()
    if self.binder:GetButtonState(self.ui.Btn_Commend) == Z1ButtonState.Normal then
      local function callback()
        self:_ShowPlayerGood()
        
        self.binder:SetButtonState(self.ui.Btn_Commend, Z1ButtonState.Unclickable)
      end
      
      local targetUid = isAI and 0 or self.model.enermyInfo.uid
      PvpController.Instance:ReqGoodAi(targetUid, callback)
      if not isAI then
        SocialDataUtils.ReqOnSocialGood(self.model.enermyInfo.uid, 1, SocialDefine.GoodReason.PVP)
      end
    else
      Alert.ShowStr(LT.Text("PVPGoodBtnUnClickableStateTips"))
    end
  end)
  local btnState = SocialDataUtils.CheckIsAttentionRelation(self.model.enermyInfo.relation) and Z1ButtonState.Unclickable or Z1ButtonState.Normal
  if isAI then
    btnState = Z1ButtonState.Unclickable
  end
  self.binder:SetButtonState(self.ui.Btn_Attention, btnState)
  self.binder:BindZ1Button(self.ui.Btn_Attention, function()
    if isAI then
      return
    end
    if self.binder:GetButtonState(self.ui.Btn_Attention) == Z1ButtonState.Normal then
      SocialDataUtils.ReqOnSocialAttention(self.model.enermyInfo.uid, function()
        self.binder:SetButtonState(self.ui.Btn_Attention, Z1ButtonState.Unclickable)
      end)
    else
      Alert.ShowStr(LT.Text("PVPAttentionBtnUnClickableStateTips"))
    end
  end)
end

function PVPBattleDataSettlePanel:_OnBindMoreGameBtn()
  if self.model.enermyInfo.isAI then
    self.model:Set_moreGameState(CommonDefine.PvPMoreGameState.AiOpponent)
  end
  self.ui.UI_Common_Btn_Level2:SetActive(true)
  self.binder:BindZ1Button(self.ui.UI_Common_Btn_Level2, System.fn(self, self._OnClickOneMoreGame), System.fn(self, self._GetMoreGameBtnState), function()
    do return LT.Text end
    return LT.Text, "PvPMoreGame"
  end)
end

function PVPBattleDataSettlePanel:_BindScoresVar(binder)
  if PvPSettleDataUtils.GetIsFriendGame() then
    binder:SetText(self.ui.Text_Integral_03, "")
    binder:SetText(self.ui.Text_Integral_04, "")
    return
  end
  local scoreVar_1 = DataCenter.pvpSettleData.finalScore - DataCenter.pvpSettleData.lastFinalScore
  local scoreVar_2 = DataCenter.pvpSettleData.opponentScore - DataCenter.pvpSettleData.lastOpponentScore
  local greenColor = "#74ce96"
  local redColor = "#bb646d"
  if scoreVar_1 > 0 then
    binder:SetText(self.ui.Text_Integral_03, string.format("<color=%s>+%s</color>", greenColor, scoreVar_1))
  elseif scoreVar_1 < 0 then
    binder:SetText(self.ui.Text_Integral_03, string.format("<color=%s>%s</color>", redColor, scoreVar_1))
  elseif self.battleRst == BattleResult.Win then
    binder:SetText(self.ui.Text_Integral_03, string.format("<color=%s>+%s</color>", greenColor, scoreVar_1))
  else
    binder:SetText(self.ui.Text_Integral_03, string.format("<color=%s>-%s</color>", redColor, scoreVar_1))
  end
  if scoreVar_2 > 0 then
    binder:SetText(self.ui.Text_Integral_04, string.format("<color=%s>+%s</color>", greenColor, scoreVar_2))
  elseif scoreVar_2 < 0 then
    binder:SetText(self.ui.Text_Integral_04, string.format("<color=%s>%s</color>", redColor, scoreVar_2))
  elseif self.battleRst == BattleResult.Win then
    binder:SetText(self.ui.Text_Integral_04, string.format("<color=%s>-%s</color>", redColor, scoreVar_2))
  else
    binder:SetText(self.ui.Text_Integral_04, string.format("<color=%s>+%s</color>", greenColor, scoreVar_2))
  end
end

function PVPBattleDataSettlePanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(PvPBattleDataSettlePanelModel)
  self.playerScoreUIGroup = {
    self.ui.Player_Score_5,
    self.ui.Player_Score_4,
    self.ui.Player_Score_3,
    self.ui.Player_Score_2,
    self.ui.Player_Score_1
  }
  self.playerContentGroup = {
    self.ui.Player_Content_5,
    self.ui.Player_Content_4,
    self.ui.Player_Content_3,
    self.ui.Player_Content_2,
    self.ui.Player_Content_1
  }
  self.enermyScoreUIGroup = {
    self.ui.Enermy_Score_5,
    self.ui.Enermy_Score_4,
    self.ui.Enermy_Score_3,
    self.ui.Enermy_Score_2,
    self.ui.Enermy_Score_1
  }
  self.enermyContentGroup = {
    self.ui.Enermy_Content_5,
    self.ui.Enermy_Content_4,
    self.ui.Enermy_Content_3,
    self.ui.Enermy_Content_2,
    self.ui.Enermy_Content_1
  }
end

function PVPBattleDataSettlePanel:_OnBindPlayerSettleData()
  local binder, model = self.binder, self.model
  binder:BindToText(self.ui.Text_Name_1, function()
    do return LT.Text end
    return LT.Text, model.playerInfo.name
  end)
  binder:BindComponent((CommonHeadItem(self.ui.Own_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(model.playerInfo.icon),
    frameIcon = ItemDataUtils.GetItemIcon(model.playerInfo.avatarFrame)
  })))
  local isDraftPvp = PvPSettleDataUtils.GetPvpType() == PvpDefine.PvpType.Draft
  binder:SetActive(self.ui.Image_MySelf_Pvp, not isDraftPvp)
  binder:SetActive(self.ui.Image_MySelf_RotationMode, isDraftPvp)
  for i = 1, UNIT_MAX_NUM do
    local unitSettleData = self.model.playerTeamSettleDataGroup[i]
    local obj = self.playerScoreUIGroup[i]
    self:_OnBindScoreColumComp(binder, obj, unitSettleData, self.highestVal)
    if unitSettleData.type == CommonDefine.PvPUnitSettleType.Awaker then
      self:_OnBindAwakerUnitCompGroup(self.playerContentGroup[i], unitSettleData)
    elseif unitSettleData.type == CommonDefine.PvPUnitSettleType.Keeper then
      self:_OnBindKeeperUnitCompGroup(self.playerContentGroup[i], unitSettleData)
    end
  end
end

function PVPBattleDataSettlePanel:_OnBindEnermySettleData()
  local binder, model = self.binder, self.model
  binder:BindToText(self.ui.Text_Name_2, function()
    do return LT.Text end
    return LT.Text, model.enermyInfo.name
  end)
  binder:BindComponent((CommonHeadItem(self.ui.Enemy_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(model.enermyInfo.icon),
    frameIcon = ItemDataUtils.GetItemIcon(model.enermyInfo.avatarFrame)
  })))
  local isDraftPvp = PvPSettleDataUtils.GetPvpType() == PvpDefine.PvpType.Draft
  binder:SetActive(self.ui.Image_Enemy_Pvp, not isDraftPvp)
  binder:SetActive(self.ui.Image_Enemy_RotationMode, isDraftPvp)
  for i = 1, UNIT_MAX_NUM do
    local unitSettleData = self.model.enermyTeamSettleDataGroup[i]
    local obj = self.enermyScoreUIGroup[i]
    self:_OnBindScoreColumComp(binder, obj, unitSettleData, self.highestVal)
    if unitSettleData.type == CommonDefine.PvPUnitSettleType.Awaker then
      self:_OnBindAwakerUnitCompGroup(self.enermyContentGroup[i], unitSettleData)
    elseif unitSettleData.type == CommonDefine.PvPUnitSettleType.Keeper then
      self:_OnBindKeeperUnitCompGroup(self.enermyContentGroup[i], unitSettleData)
    end
  end
end

function PVPBattleDataSettlePanel:_OnBindScoreColumComp(binder, obj, unitSettleData, highestVal)
  local itemData = {
    damage = unitSettleData.settleData.damage,
    heal = unitSettleData.settleData.heal,
    shield = unitSettleData.settleData.shield,
    columPercent = self.model:GetSettleDataTotalVal(unitSettleData.settleData) / highestVal
  }
  binder:BindComponent(PvPSettleScoreColumItem(obj, itemData))
end

function PVPBattleDataSettlePanel:_OnBindAwakerUnitCompGroup(parentNode, unitSettleData)
  self:_OnBindNewUnitComp(parentNode, function()
    local img = DT.PVPCollect[unitSettleData.tid1].CollectImage
    if unitSettleData.curSkin and 0 ~= unitSettleData.curSkin then
      local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(unitSettleData.tid1)
      if awakerTid then
        img = AwakerDataUtils.ReplaceSkinTidRes(img, awakerTid, unitSettleData.curSkin)
      end
    end
    return img
  end, function()
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, unitSettleData.tid1
  end, DT.PVPCollect[unitSettleData.tid1].Type, function()
    do return PVPCollectionDataUtils.GetPositionColorFrameImage end
    return PVPCollectionDataUtils.GetPositionColorFrameImage, unitSettleData.tid1
  end)
  self:_OnBindNewUnitComp(parentNode, function()
    local skillId = PVPCollectionDataUtils.GetCollectWeaponSkillId(unitSettleData.tid2)
    return skillId and DT.Skill[skillId].Icon or nil
  end, function()
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, unitSettleData.tid2
  end, DT.PVPCollect[unitSettleData.tid2].Type, function()
    do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
    return PVPCollectionDataUtils.GetCollectionNameFrameImage, unitSettleData.tid2
  end)
end

function PVPBattleDataSettlePanel:_OnBindKeeperUnitCompGroup(parentNode, unitSettleData)
  self:_OnBindNewUnitComp(parentNode, function()
    do return PVPCollectionDataUtils.GetCollectionPotrait end
    return PVPCollectionDataUtils.GetCollectionPotrait, unitSettleData.tid1
  end, function()
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, unitSettleData.tid1
  end, DT.PVPCollect[unitSettleData.tid1].Type, function()
    do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
    return PVPCollectionDataUtils.GetCollectionNameFrameImage, unitSettleData.tid1
  end)
  self:_OnBindNewUnitComp(parentNode, function()
    do return PVPCollectionDataUtils.GetCollectionPotrait end
    return PVPCollectionDataUtils.GetCollectionPotrait, unitSettleData.tid2
  end, function()
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, unitSettleData.tid2
  end, DT.PVPCollect[unitSettleData.tid2].Type, function()
    do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
    return PVPCollectionDataUtils.GetCollectionNameFrameImage, unitSettleData.tid2
  end)
end

function PVPBattleDataSettlePanel:_OnBindNewUnitComp(parentNode, iconFunc, nameFunc, collectionType, nameFrameFunc)
  local itemData = {
    iconFunc = iconFunc,
    nameFunc = nameFunc,
    collectionType = collectionType,
    nameFrameFunc = nameFrameFunc
  }
  self.binder:BindNewComponent(parentNode, PvpTeamUnitItem, UI_Pvp_Item_DispositionResource, itemData)
end

function PVPBattleDataSettlePanel:_OnClickConfirmFunc()
  self:OnClose()
end

function PVPBattleDataSettlePanel:_ShowPlayerGood()
  self.ui.Image_Own_Respectable:SetActive(true)
  AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Emoji_Send_GG")
end

function PVPBattleDataSettlePanel:_ShowEnermyGood()
  self.ui.Image_Respectable:SetActive(true)
  AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Emoji_Receive_GG")
end

local MoreGameState2AlertContnetMap = {
  [CommonDefine.PvPMoreGameState.Refuse] = LT.Text("PvPMoreGameBtnRefuseStateTips"),
  [CommonDefine.PvPMoreGameState.ClickRefuse] = LT.Text("PvPMoreGameBtnActiveRefuseStateTips"),
  [CommonDefine.PvPMoreGameState.NoMoreGame] = LT.Text("PvPMoreGameBtnOverWinStateTips"),
  [CommonDefine.PvPMoreGameState.AiOpponent] = LT.Text("PVP_Opponent_Exited")
}

function PVPBattleDataSettlePanel:_OnClickOneMoreGame()
  local tips = MoreGameState2AlertContnetMap[self.model.moreGameState]
  if tips and "" ~= tips then
    Alert.ShowStr(tips)
    return
  end
  if self.model.moreGameState ~= CommonDefine.PvPMoreGameState.CanPlay then
    return
  end
  PvPSettleDataUtils.ReqLaunchMoreGame(self.model.enermyInfo.uid, self.model.enermyInfo.name, nil, function()
    self.model:Set_moreGameState(CommonDefine.PvPMoreGameState.CantPlay)
  end)
end

function PVPBattleDataSettlePanel:_GetMoreGameBtnState()
  return self.model.moreGameState == CommonDefine.PvPMoreGameState.CanPlay and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
end

function PVPBattleDataSettlePanel:OnOneMoreGameStart()
  UIManager.Instance:CloseByUrl(Urls.AlertConfirm2Panel)
  self:OnClose()
end

function PVPBattleDataSettlePanel:OnPvpMoreGameBeRefused()
  self.model:Set_moreGameState(CommonDefine.PvPMoreGameState.Refuse)
end

function PVPBattleDataSettlePanel:PvpMoreGameClickRefuse()
  self.model:Set_moreGameState(CommonDefine.PvPMoreGameState.ClickRefuse)
end

function PVPBattleDataSettlePanel:OnClose()
  PvPSettleDataUtils.ReqExitPvpSettlePanel()
  if self.closeCb then
    self.closeCb()
    self.closeCb = nil
  end
  self:Close()
end

return PVPBattleDataSettlePanel
