_class("UIBlackFightMainBtn", UICustomWidget)
UIBlackFightMainBtn = UIBlackFightMainBtn

function UIBlackFightMainBtn:Constructor()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN7BlackFightData()
end

function UIBlackFightMainBtn:OnShow()
  self.animation = self:GetGameObject():GetComponent("Animation")
  self.rootRect = self:GetGameObject("root"):GetComponent("RectTransform")
  self.offset = self:GetGameObject("offset")
  self.offsetRect = self.offset:GetComponent("RectTransform")
  self.imgBG = self:GetUIComponent("Image", "offset")
  self.txtDiff = self:GetUIComponent("UILocalizationText", "txtDiff")
  self.txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self.score = self:GetGameObject("score")
  self.txtReputation = self:GetUIComponent("UILocalizationText", "txtReputation")
  self.txtReputationGlow = self:GetUIComponent("UILocalizationText", "txtReputationGlow")
  self.atlas = self:GetAsset("UIN7.spriteatlas", LoadType.SpriteAtlas)
end

function UIBlackFightMainBtn:OnHide()
end

function UIBlackFightMainBtn:Init(diff, pos)
  self.diff = diff
  self.offsetRect.anchoredPosition = pos
  self.imgBG.sprite = self.atlas:GetSprite("n7_box_stage" .. diff)
  self.txtDiff:SetText(StringTable.Get("str_n7_black_fight_level_" .. diff))
end

function UIBlackFightMainBtn:Flush()
  local level, max = self.data:GetRoundInfoByDifficulty(self.diff)
  self.txtProgress:SetText(StringTable.Get("str_n7_black_fight_cur_progress", level, max))
  local d, maxReputation = self.data:GetTodayMaxReputation()
  if 0 < maxReputation and d == self.diff then
    self.score:SetActive(true)
    local str = StringTable.Get("str_n7_black_fight_today_highest_reputation", self.data.difficultyList[self.diff].reputaion)
    self.txtReputation:SetText(str)
    self.txtReputationGlow:SetText(str)
  else
    self.score:SetActive(false)
  end
end

function UIBlackFightMainBtn:PlayAnimIn()
  self.animation:Play("uieff_N7_BlackFight_Btn_In")
end

function UIBlackFightMainBtn:PlayAnimOut()
  self.animation:Play("uieff_N7_BlackFight_Btn_Out")
end

function UIBlackFightMainBtn:offsetOnClick(go)
  self:StartTask(function(TT)
    self:Lock(lockKey)
    local lockKey = "UIBlackFightMainBtnrootOnClick"
    self.animation:Play("uieff_N7_BlackFight_Btn_Click")
    YIELD(TT, 200)
    self:UnLock(lockKey)
    self.rootRect.anchoredPosition = Vector2(0, self.rootRect.anchoredPosition.y)
    self:ShowDialog("UIN7LevelDetailsController", self.diff)
  end, self)
end
