_class("UISummerActivityTwoEntryController", UIController)
UISummerActivityTwoEntryController = UISummerActivityTwoEntryController

function UISummerActivityTwoEntryController:LoadDataOnEnter(TT, res, uiParams)
  self._entryDatas = {}
  local matchModule = self:GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if not enterData then
    return
  end
  local affixList = enterData:GetAffixList()
  if not affixList then
    return
  end
  local missionInfo = enterData:GetMissionCreateInfo()
  local missionId = missionInfo.nCampaignMissionId
  local componentId = missionInfo.CampaignMissionParams
  if not componentId then
    return
  end
  local cfgs = Cfg.cfg_component_summer_ii_mission({
    CampaignMissionId = missionId,
    ComponentID = componentId[1]
  })
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  self._isSingles = {}
  local cfg = cfgs[1]
  local affixAndScore = cfg.AffixAndRatioScore
  for i = 1, #affixList do
    for k = 1, #affixAndScore do
      if affixAndScore[k][1] == affixList[i] then
        self._entryDatas[#self._entryDatas + 1] = UISummerActivityTwoEntryData:New(affixList[i], affixAndScore[k][2])
        self._isSingles[#self._isSingles + 1] = self:IsEntrySingle(affixAndScore, affixList[i])
        break
      end
    end
  end
  self._entryLevelData = nil
  local hardId = enterData:GetHardIndex()
  local baseScore = cfg.BaseScore
  for i = 1, #baseScore do
    if baseScore[i][1] == hardId then
      self._entryLevelData = UISummerActivityTwoEntryLevelData:New(baseScore[i])
    end
  end
  self._titleName = StringTable.Get(cfg.AffixTitle)
  self._titleIcon = cfg.AffixTitleIcon
  self:SortData()
end

function UISummerActivityTwoEntryController:IsEntrySingle(affixAndScore, entryId)
  local cfgs = Cfg.cfg_affix({ID = entryId})
  if cfgs == nil or #cfgs <= 0 then
    return false
  end
  local cfg = cfgs[1]
  local type = cfg.Type
  local count = 0
  for k, v in pairs(affixAndScore) do
    local tmpCfgs = Cfg.cfg_affix({
      ID = v[1]
    })
    if tmpCfgs and 0 < #tmpCfgs then
      local tmpCfg = tmpCfgs[1]
      local tmpType = tmpCfg.Type
      if tmpType == type then
        count = count + 1
      end
    end
  end
  return count <= 1
end

function UISummerActivityTwoEntryController:SortData()
  table.sort(self._entryDatas, function(a, b)
    return a:GetType() < b:GetType()
  end)
end

function UISummerActivityTwoEntryController:OnShow(uiParams)
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._titleIconImg = self:GetUIComponent("RawImageLoader", "TitleIcon")
  self._selectedEntryCountLabel = self:GetUIComponent("UILocalizationText", "SelectedEntryCount")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon2")
  self._baseScoreLabel = self:GetUIComponent("UILocalizationText", "BaseScore")
  self._selectedScoreLabel = self:GetUIComponent("UILocalizationText", "SelectedScore")
  self._ratioScoreLabel = self:GetUIComponent("UILocalizationText", "RatioScore")
  self._titleLabel.text = self._titleName
  self._titleIconImg:LoadImage(self._titleIcon)
  self._selectedEntryCountLabel.text = #self._entryDatas
  self._iconImg:LoadImage(UISummerActivityTwoConst.EntryIcon)
  local loader = self:GetUIComponent("UISelectObjectPath", "EntryGroup")
  loader:SpawnObjects("UISummerActivityTwoEntryItem", #self._entryDatas)
  self._list = loader:GetAllSpawnList()
  for i = 1, #self._list do
    self._list[i]:Refresh(self._entryDatas[i], false, nil, self._isSingles[i])
  end
  local loader = self:GetUIComponent("UISelectObjectPath", "LevelEntry")
  local entryLevelItem = loader:SpawnObject("UISummerActivityTwoEntryLevelItem")
  self._list = loader:GetAllSpawnList()
  entryLevelItem:Refresh(self._entryLevelData, false, nil)
  self:RefreshEntryScoreInfo()
end

function UISummerActivityTwoEntryController:RefreshEntryScoreInfo()
  local baseScore = self._entryLevelData:GetLevelScore()
  self._baseScoreLabel:SetText(StringTable.Get("str_summer_activity_two_base_score_title", baseScore))
  local ratio, totalScore = UISummerActivityTwoLevelDatas.CalcScore(self._entryLevelData, self._entryDatas)
  self._selectedScoreLabel.text = totalScore
  local a, b = math.modf(ratio / 10)
  local text = ""
  if b == 0 then
    text = StringTable.Get("str_summer_activity_two_ratio_score_title", 100 + a)
  else
    text = StringTable.Get("str_summer_activity_two_ratio_score_title", 100 + ratio / 10)
  end
  self._ratioScoreLabel:SetText(text)
end

function UISummerActivityTwoEntryController:MaskOnClick()
  self:CloseDialog()
end

function UISummerActivityTwoEntryController:BtnCloseOnClick()
  self:CloseDialog()
end
