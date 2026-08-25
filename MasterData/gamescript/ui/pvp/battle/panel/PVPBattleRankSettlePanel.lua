local UIAnimationController = CS.Z1Client.UIAnimationController
local DOTween = CS.DG.Tweening.DOTween
local Ease = CS.DG.Tweening.Ease
local Vector3 = CS.UnityEngine.Vector3
local STAR_SHOW_DELTA_FRAME = 13
local PvPBattleRankSettlePanel, Super = System.NewClass("PvPBattleRankSettlePanel", UIBasePanel)
PvPBattleRankSettlePanel.uiResCls = UI_Pvp_Panel_OutResource

function PvPBattleRankSettlePanel:ctor(isWin, closeCb)
  Super.ctor(self)
  self.isWin = isWin
  self.closeCb = closeCb
end

function PvPBattleRankSettlePanel:OnBind(binder)
  self:Init(binder)
  self:OnBindWinFailTitle()
  self:OnBindLeftRankStar()
  self:OnBindRightSettleData()
  if PvPSettleDataUtils.GetSettleReason() == CommonDefine.PvpSettleReason.GiveUpPrepare then
    binder:SetText(self.ui.Text_C_Show, LT.Text("Common_Button_Confirm"))
  end
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnClose))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
end

function PvPBattleRankSettlePanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(PvPBattleRankSettlePanelModel)
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local prefab = self.binder:LoadAsset("UI/UI_Pvp/UI_Pvp_Prefab/UI_Vx_Pvp_Popup_Dan_Fx01.prefab")
  self.binder:Instantiate(prefab, self.ui.UI_Vx_Pvp_Popup_Dan_Fx01.transform)
end

function PvPBattleRankSettlePanel:OnBindWinFailTitle()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Victory, function()
    do return LT.Text end
    return LT.Text, "Battle_Win_Title_CHN"
  end)
  binder:BindToText(self.ui.Text_Fail, function()
    do return LT.Text end
    return LT.Text, "Battle_Defeated_Title_CHN"
  end)
  binder:BindToVisible(self.ui.Image_Fail, function()
    return not self.isWin
  end)
  binder:BindToVisible(self.ui.Image_Fail_Str, function()
    return not self.isWin
  end)
  binder:BindToVisible(self.ui.Image_Victory, function()
    return self.isWin
  end)
  binder:BindToVisible(self.ui.Image_Victory_Str, function()
    return self.isWin
  end)
  binder:BindToVisible(self.ui.Effect_Victory, function()
    return self.isWin
  end)
  binder:BindToVisible(self.ui.Effect_Fail, function()
    return not self.isWin
  end)
end

function PvPBattleRankSettlePanel:OnBindLeftRankStar()
  local binder, model = self.binder, self.model
  local isDraftPvp = PvPSettleDataUtils.GetPvpType() == PvpDefine.PvpType.Draft
  binder:SetActive(self.ui.Image_Score_Pvp, not isDraftPvp)
  binder:SetActive(self.ui.Image_Score_RotationMode, isDraftPvp)
  binder:BindToText(self.ui.Text_Result, function()
    local showText = self.isWin and LT.Text("PVPMatchVictory") or LT.Text("PVPMatchDefeat")
    local symbol = model.battleRstStarNum > 0 and "+" or "-"
    if 0 == model.battleRstStarNum then
      symbol = self.isWin and "+" or "-"
    end
    do return string.format, "%s%s%s", showText, symbol, math.abs(model.battleRstStarNum) end
    return string.format, "%s%s%s", showText, symbol, math.abs(model.battleRstStarNum)
  end)
  binder:BindTimer(2, 0, nil, function()
    self:PlayScoreAnim()
  end)
end

function PvPBattleRankSettlePanel:PlayScoreAnim()
  local preScore = PvPSettleDataUtils.GetPvpPreScore() or 0
  local curScore = DataCenter.pvpSettleData.finalScore
  local preNums = self:SplitScore(preScore)
  local curNums = self:SplitScore(curScore)
  local needMoveCount = 0
  if curScore - preScore > 10 then
    needMoveCount = #self:SplitScore(math.abs(curScore - preScore))
  end
  self:ResetScoreNums()
  for i = 1, 5 do
    local upperTextObj = self.ui["Text_ScoreUpper" .. i]
    local downTextObj = self.ui["Text_ScoreDown" .. i]
    local isShow = i <= #curNums
    upperTextObj:SetActive(isShow)
    downTextObj:SetActive(isShow)
  end
  local luaCenterGroup = AddLuaCompOnce(self.ui.GroupUpperNumber, LuaCenterGroupComp)
  luaCenterGroup:HorizontalCenterChildren(40, 0)
  local luaCenterGroup = AddLuaCompOnce(self.ui.GroupDownNumber, LuaCenterGroupComp)
  luaCenterGroup:HorizontalCenterChildren(40, 0)
  for i = 1, #curNums do
    if preScore < curScore then
      self:PlayIncreaseSingleNumAnim(i, preNums[i] or 0, curNums[i], needMoveCount >= i)
    else
      self:PlayDecreaseSingleNumAnim(i, preNums[i] or 0, curNums[i], needMoveCount >= i)
    end
  end
end

function PvPBattleRankSettlePanel:SplitScore(score)
  local splitNums = {}
  if 0 == score then
    return {0}
  end
  while score > 0 do
    table.insert(splitNums, score % 10)
    score = score // 10
  end
  return splitNums
end

function PvPBattleRankSettlePanel:ResetScoreNums()
  local sizeY = self.ui.Text_ScoreUpper1.transform.sizeDelta.y
  for i = 1, 5 do
    local tf = self.ui["Text_ScoreUpper" .. i].transform
    local pos = tf.localPosition
    tf.localPosition = Vector3(pos.x, sizeY, pos.z)
    local tf = self.ui["Text_ScoreDown" .. i].transform
    local pos = tf.localPosition
    tf.localPosition = Vector3(pos.x, 0, pos.z)
  end
  if self.numTwSequence then
    self.numTwSequence:Kill()
    self.numTwSequence = nil
  end
end

function PvPBattleRankSettlePanel:PlayDecreaseSingleNumAnim(index, preNum, curNum, isAddCircle)
  local upperTextObj = self.ui["Text_ScoreUpper" .. index]
  local downTextObj = self.ui["Text_ScoreDown" .. index]
  self.binder:SetText(upperTextObj, 9 == preNum and 0 or preNum + 1)
  self.binder:SetText(downTextObj, preNum)
  if preNum == curNum and not isAddCircle then
    return
  end
  local pos = downTextObj.transform.localPosition
  local sizeY = downTextObj.transform.sizeDelta.y
  local rectSizeY = sizeY * 2
  preNum = (isAddCircle or preNum <= curNum) and preNum + 10 or preNum
  local delta = curNum - preNum
  self.numTwSequence = self.numTwSequence or DOTween.Sequence(self)
  self.numTwSequence:Insert(0.3 * (index - 1), DOTween.To(function()
    return 0
  end, function(y)
    local v = (y - sizeY) // rectSizeY
    local num = math.floor(v * 2 + preNum + 2) % 10
    self.binder:SetText(downTextObj, num)
    local v = y // rectSizeY
    local upNum = math.floor(v * 2 + preNum + 1) % 10
    self.binder:SetText(upperTextObj, upNum)
    downTextObj.transform.localPosition = Vector3(pos.x, (y + sizeY) % rectSizeY - sizeY, pos.z)
    upperTextObj.transform.localPosition = Vector3(pos.x, y % rectSizeY - sizeY, pos.z)
  end, delta * sizeY, 2.5 - index * 0.6, self):SetEase(Ease.InOutSine):OnStart(function()
    upperTextObj:SetActive(true)
    downTextObj:SetActive(true)
  end))
end

function PvPBattleRankSettlePanel:PlayIncreaseSingleNumAnim(index, preNum, curNum, isAddCircle)
  local backupTextObj = self.ui["Text_ScoreUpper" .. index]
  local curTextObj = self.ui["Text_ScoreDown" .. index]
  self.binder:SetText(backupTextObj, 0 == preNum and 9 or preNum - 1)
  self.binder:SetText(curTextObj, preNum)
  if preNum == curNum and not isAddCircle then
    return
  end
  local pos = curTextObj.transform.localPosition
  local sizeY = curTextObj.transform.sizeDelta.y
  local rectSizeY = sizeY * 2
  curNum = (isAddCircle or curNum <= preNum) and curNum + 10 or curNum
  local delta = preNum - curNum
  self.numTwSequence = self.numTwSequence or DOTween.Sequence(self)
  self.numTwSequence:Insert(0.3 * (index - 1), DOTween.To(function()
    return 0
  end, function(y)
    local v = (y - sizeY) // rectSizeY * -1
    local num = math.floor(v * 2 + preNum - 2) % 10
    if num < 0 then
      num = 9
    end
    self.binder:SetText(curTextObj, num)
    local v = y // rectSizeY * -1
    local upNum = math.floor(v * 2 + preNum - 1) % 10
    if upNum < 0 then
      upNum = 9
    end
    self.binder:SetText(backupTextObj, upNum)
    y = -y
    curTextObj.transform.localPosition = Vector3(pos.x, (y + sizeY) % rectSizeY - sizeY, pos.z)
    backupTextObj.transform.localPosition = Vector3(pos.x, (y + sizeY + sizeY) % rectSizeY - sizeY, pos.z)
  end, delta * sizeY, 2.5 - index * 0.6, self):SetEase(Ease.InOutSine):OnStart(function()
    backupTextObj:SetActive(true)
    curTextObj:SetActive(true)
  end))
end

function PvPBattleRankSettlePanel:OnBindRightSettleData()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Image_Description, function()
    return not self.isWin
  end)
  binder:BindToText(self.ui.Text_Tale, function()
    do return LT.Text end
    return LT.Text, "PVPFailTips"
  end)
  if PvPSettleDataUtils.GetSettleReason() == CommonDefine.PvpSettleReason.GiveUpPrepare then
    binder:SetActive(self.ui.Group_Awaker_Favor, false)
  else
    binder:SetActive(self.ui.Group_Awaker_Favor, true)
    local likeItems = PvPSettleDataUtils.GetSettleRewardByTid(CommonDefine.CurrencyType.AwakerLike)
    binder:BindComponent(UICompAwakerFavor(self.ui.Group_Awaker_Favor, likeItems, true, {isShowDetailBtn = true}))
  end
  binder:BindToCircularListView(self.ui.ScrollView_Article_Award, function()
    return model.battleRewards
  end, function(itemBinder, item, index)
    local rewardsData = model.battleRewards[index]
    itemBinder:BindComponent(PvpSettleDataItem(item, rewardsData))
  end)
end

function PvPBattleRankSettlePanel:StarUpAction()
  AudioManager.Instance:PostSoundEvent("Play_VFX_PVP_Scoring_Flash")
  self.model:SetShowingStarNum(self.model.showingStarNum + 1)
end

function PvPBattleRankSettlePanel:StarDownAction()
  AudioManager.Instance:PostSoundEvent("Play_VFX_PVP_Scoring_Minus")
  self.model:SetShowingStarNum(self.model.showingStarNum - 1)
end

function PvPBattleRankSettlePanel:OnStoryEnd()
  UIAudioManager.Instance:SetMainSceneMusicState(true)
  UIAudioManager.Instance:SetLastTopFullUI(Urls.MainPanelPVP)
  UIAudioManager.Instance:PlayTopUIAudioEvent()
end

function PvPBattleRankSettlePanel:OnClose()
  PvpDraftModel.Instance:ClearData()
  if self.closeCb then
    self.closeCb()
    self.closeCb = nil
  end
  self:Close()
end

function PvPBattleRankSettlePanel:CheckIsHighestRank(rankId)
  local rankCfg = DT.PVPRank[rankId]
  return not PvPTeamBuildDataUtils.GetPvpRankCfgBySortId(rankCfg.BaseSortID + 1)
end

return PvPBattleRankSettlePanel
