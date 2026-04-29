_class("UICN17N46FishingScoreItem", UICustomWidget)
UICN17N46FishingScoreItem = UICN17N46FishingScoreItem

function UICN17N46FishingScoreItem:Constructor()
  self._rewards = nil
end

function UICN17N46FishingScoreItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN17N46FishingScoreItem:InitWidget()
  self.score = self:GetUIComponent("UILocalizationText", "score")
  self._receiveBtn = self:GetUIComponent("Image", "receiveBtn")
  self._reward = self:GetUIComponent("UISelectObjectPath", "Reward")
  self._scoreTypeText = self:GetUIComponent("UILocalizationText", "scoreTypeText")
  self._scoreOutLine = self:GetUIComponent("Outline", "scoreTypeText")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
  self._redPoint = self:GetGameObject("RedPoint")
  self._receiveBtnGo = self:GetGameObject("uieff_receiveBtn")
end

function UICN17N46FishingScoreItem:ReceiveBtnOnClick()
  if self.rewardState == FishingGameRewardState.NotReceive then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN14FishingGameRewardItemReceived, self.socreType)
  end
end

function UICN17N46FishingScoreItem:RefreshRewards(scoretype, mission_info, cfg)
  self.socreType = scoretype
  local rewards
  self._current_stage_cfg = cfg
  if scoretype == ScoreType.B then
    rewards = self._current_stage_cfg.ScoreBReward
    self.score.text = cfg.Score[1]
    self._scoreTypeText.text = "B"
    self._scoreOutLine.effectColor = Color(0.23921568627450981, 0.8666666666666667, 1.0)
  elseif scoretype == ScoreType.A then
    rewards = self._current_stage_cfg.ScoreAReward
    self.score.text = cfg.Score[2]
    self._scoreTypeText.text = "A"
    self._scoreOutLine.effectColor = Color(1.0, 0.49019607843137253, 0.23921568627450981)
  elseif scoretype == ScoreType.S then
    rewards = self._current_stage_cfg.ScoreSReward
    self.score.text = cfg.Score[3]
    self._scoreTypeText.text = "S"
    self._scoreOutLine.effectColor = Color(1.0, 1.0, 0.23921568627450981)
  end
  local count = table.count(rewards)
  if 0 < count then
    self._reward:SpawnObjects("UICN17N46FishingGameRewardItem", count)
    self._rewards = self._reward:GetAllSpawnList()
    for i = 1, #self._rewards do
      self._rewards[i]:SetData(rewards[i], scoretype, mission_info)
    end
  end
  self:_ReceiveRewardBtnState(mission_info, scoretype)
end

function UICN17N46FishingScoreItem:_ReceiveRewardBtnState(mission_info, scoretype)
  self._redPoint:SetActive(false)
  self.rewardState = FishingGameRewardState.NotReach
  if scoretype > mission_info.mission_grade then
    self.rewardState = FishingGameRewardState.NotReach
  elseif mission_info.reward_mask & scoretype == 0 then
    self.rewardState = FishingGameRewardState.NotReceive
  else
    self.rewardState = FishingGameRewardState.HasReceive
  end
  if self.rewardState == FishingGameRewardState.NotReach then
    self._receiveBtn.sprite = self._atlas:GetSprite("n14_fish_btn_receive1")
  elseif self.rewardState == FishingGameRewardState.HasReceive then
    self._receiveBtn.sprite = self._atlas:GetSprite("pass_jiangli_icon3")
  elseif self.rewardState == FishingGameRewardState.NotReceive then
    self._receiveBtn.sprite = self._atlas:GetSprite("n14_fish_btn_receive2")
    self._redPoint:SetActive(true)
  end
  self._receiveBtnGo:SetActive(self.rewardState == FishingGameRewardState.NotReceive)
end

function UICN17N46FishingScoreItem:_ShowRewardTips(id, pos)
  self._tips:SetData(id, pos)
end
