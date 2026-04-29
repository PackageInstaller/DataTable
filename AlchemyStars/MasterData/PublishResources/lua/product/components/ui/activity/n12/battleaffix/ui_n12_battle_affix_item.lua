_class("UIN12BattleAffixItem", UICustomWidget)
UIN12BattleAffixItem = UIN12BattleAffixItem

function UIN12BattleAffixItem:Constructor()
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12BattleAffixItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12BattleAffixItem:_GetComponent()
  self._affix = self:GetGameObject("Affix")
  self._other = self:GetGameObject("Other")
  self._gainType = self:GetUIComponent("Image", "GainType")
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._scoreBg = self:GetGameObject("ScoreBg")
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._diffText = self:GetUIComponent("UILocalizationText", "DiffText")
  self._recommend = self:GetUIComponent("UILocalizationText", "Recommend ")
end

function UIN12BattleAffixItem:SetData(levelType, noAffix, campaignMissionId, affixId)
  self._affix:SetActive(not noAffix)
  self._other:SetActive(noAffix)
  self._scoreBg:SetActive(levelType == N12LevelType.Challenge)
  if noAffix then
    local tempDailyMissionCfgs
    if levelType == N12LevelType.Daily then
      tempDailyMissionCfgs = Cfg.cfg_component_daily_mission({CampaignMissionId = campaignMissionId})
    elseif levelType == N12LevelType.Challenge then
      tempDailyMissionCfgs = Cfg.cfg_component_challenge_mission({CampaignMissionId = campaignMissionId})
    end
    self._curDailyMissionCfg = tempDailyMissionCfgs[1]
    self._diffText:SetText(StringTable.Get(HardLevelTypeText[self._curDailyMissionCfg.HardID]))
    self._recommend:SetText(StringTable.Get("str_n12_recommend_info", self._curDailyMissionCfg.RecommendAwaken, self._curDailyMissionCfg.RecommendLV))
    if levelType == N12LevelType.Challenge then
      self._score.color = Color(1.0, 0.7764705882352941, 0.1803921568627451)
      self._score:SetText(self._curDailyMissionCfg.BaseScore)
    end
    return
  end
  self._missionAffixCfg = Cfg.cfg_component_mission_affix[affixId]
  if not self._missionAffixCfg then
    Log.error("cfg_component_mission_affix does not exist." .. affixId)
    return
  end
  local affixCfg = Cfg.cfg_affix[self._missionAffixCfg.AffixID]
  if not affixCfg then
    Log.error("cfg_affix does not exist." .. self._missionAffixCfg.AffixID)
    return
  end
  N12ToolFunctions.SetAffixText(self._text, affixCfg)
  if levelType == N12LevelType.Challenge then
    self._score:SetText(self._missionAffixCfg.AffixScore)
    local color = Color(1.0, 0.7764705882352941, 0.1803921568627451)
    if self._missionAffixCfg.GainType == GainType.Friend then
      color = Color.red
    end
    self._score.color = color
  end
  self._gainType.sprite = self._atlas:GetSprite(GainTypeSprite[self._missionAffixCfg.GainType])
end
