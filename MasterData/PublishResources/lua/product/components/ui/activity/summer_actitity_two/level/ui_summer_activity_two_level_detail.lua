_class("UISummerActivityTwoLevelDetail", UIController)
UISummerActivityTwoLevelDetail = UISummerActivityTwoLevelDetail

function UISummerActivityTwoLevelDetail:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_2, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_3, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_4, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_5, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_6)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._missionComponent = self._localProcess:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
end

function UISummerActivityTwoLevelDetail:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._bossIconImg = self:GetUIComponent("RawImageLoader", "BossIcon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._scoreShadoweLabel = self:GetUIComponent("UILocalizationText", "ScoreShadow")
  self._IconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._scoreGo = self:GetGameObject("Score")
  self._scoreShadowGo = self:GetGameObject("ScoreShadow")
  self._iconGo = self:GetGameObject("Icon")
  self._scoreTitleGo = self:GetGameObject("ScoreTitle")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._typeToScoreColor = {
    [UISummerActivity2LevelType.Boss] = Color(0.5333333333333333, 0, 0, 1),
    [UISummerActivity2LevelType.Affix] = Color(0.5333333333333333, 0, 0, 1)
  }
  self._ids = {}
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(self._levelData:GetFightId())
  if monsterIDs == nil or #monsterIDs == 0 then
    Log.fatal("[Enemy] 怪物id列表为空")
  else
    local count = table.count(monsterIDs)
    for i = 1, count do
      table.insert(self._ids, monsterIDs[i])
    end
  end
  local type = self._levelData:GetLevelType()
  self._bossIconImg:LoadImage(self._levelData:GetMonsterIcon())
  self._nameLabel.text = self._levelData:GetName()
  self._desLabel.text = self._levelData:GetDes()
  self._scoreLabel.text = self._levelData:GetMaxScore()
  self._scoreShadoweLabel.text = self._levelData:GetMaxScore()
  self._IconImg:LoadImage(UISummerActivityTwoConst.EntryIcon)
  self._scoreShadoweLabel.color = self._typeToScoreColor[type]
end

function UISummerActivityTwoLevelDetail:OnHide()
end

function UISummerActivityTwoLevelDetail:MaskOnClick()
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UISummerActivityTwoLevelDetail:StartBattleBtnOnClick()
  self:ShowDialog("UISummerActivityTwoSelectEntryController", self._levelData)
end

function UISummerActivityTwoLevelDetail:DesBtnOnClick()
  self:ShowDialog("UIRestrainTips")
end

function UISummerActivityTwoLevelDetail:BossIconOnClick()
  if #self._ids <= 0 then
    Log.debug("monster list is empty")
    return
  end
  self:ShowDialog("UIEnemyTip", self._ids, 1)
end

function UISummerActivityTwoLevelDetail:CloseCoro(TT)
  self:Lock("UISummerActivityTwoLevelDetail_CloseCoro")
  self._anim:Play("uieff_Summer2_Level_Detail_Out")
  YIELD(TT, 270)
  self:CloseDialog()
  self:UnLock("UISummerActivityTwoLevelDetail_CloseCoro")
end
