_class("UISummerActivityTwoSelectEntryController", UIController)
UISummerActivityTwoSelectEntryController = UISummerActivityTwoSelectEntryController

function UISummerActivityTwoSelectEntryController:LoadDataOnEnter(TT, res, uiParams)
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
  self._missionComponentInfo = self._localProcess:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  self._missionComponent = self._localProcess:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  self._levelData = uiParams[1]
  local affixDatas = self._levelData:GetAffixAndScore()
  self._affixGroupDatas = affixDatas:GetEntryGroups()
  self._grouCount = affixDatas:GetGroupCount()
  self._entryCount = affixDatas:GetEntryCount()
  local selectedAffixs = self._missionComponentInfo.m_select_affix
  local selectedAffix = {}
  local missionId = self._levelData:GetMissionId()
  if selectedAffixs and selectedAffixs[missionId] then
    selectedAffix = selectedAffixs[missionId]
  end
  for i = 1, #self._affixGroupDatas do
    local entryDatas = self._affixGroupDatas[i]
    for j = 1, #entryDatas do
      local entryData = entryDatas[j]
      entryData:SetSelectedStatus(false)
      for k = 1, #selectedAffix do
        if selectedAffix[k] == entryData:GetId() then
          entryData:SetSelectedStatus(true)
          break
        end
      end
    end
  end
  local selectedHards = self._missionComponentInfo.m_select_hard
  local selectedHard
  if selectedHards and selectedHards[missionId] then
    selectedHard = selectedHards[missionId]
  end
  local entryLevelDatas = self._levelData:GetEntryLevelDatas()
  if selectedHard and entryLevelDatas:GetEntryLevelDataByLevel(selectedHard) then
    local entryLevelData = entryLevelDatas:GetEntryLevelDataByLevel(selectedHard)
    entryLevelData:SetSelectedStatus(true)
  else
    local entryLevelDataList = entryLevelDatas:GetEntryLevelDatas()
    if entryLevelDataList and 0 < #entryLevelDataList then
      entryLevelDataList[1]:SetSelectedStatus(true)
    end
  end
end

function UISummerActivityTwoSelectEntryController:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, function()
    self:ShowDialog("UIHelpController", "UISummerActivityTwoSelectEntryController")
  end, nil, true)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._icon1Img = self:GetUIComponent("RawImageLoader", "Icon1")
  self._icon2Img = self:GetUIComponent("RawImageLoader", "Icon2")
  self._maxScoreLabel = self:GetUIComponent("UILocalizationText", "MaxScore")
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._titleIconImg = self:GetUIComponent("RawImageLoader", "TitleIcon")
  self._selectedEntryCountLabel = self:GetUIComponent("UILocalizationText", "SelectedEntryCount")
  self._baseScoreLabel = self:GetUIComponent("UILocalizationText", "BaseScore")
  self._totalScoreLabel = self:GetUIComponent("UILocalizationText", "TotalScore")
  self._ratioScoreLabel = self:GetUIComponent("UILocalizationText", "RatioScore")
  self._titleLabel.text = self._levelData:GetAffixTitle()
  self._titleIconImg:LoadImage(self._levelData:GetAffixTitleIcon())
  self._maxScoreLabel.text = self._levelData:GetMaxScore()
  self._icon1Img:LoadImage(UISummerActivityTwoConst.EntryIcon)
  self._icon2Img:LoadImage(UISummerActivityTwoConst.EntryIcon)
  local loader = self:GetUIComponent("UISelectObjectPath", "EntryGroup")
  loader:SpawnObjects("UISummerActivityTwoEntryGroupItem", self._grouCount)
  self._list = loader:GetAllSpawnList()
  for i = 1, #self._list do
    self._list[i]:Refresh(self._affixGroupDatas[i], function()
      self:SelectEntryChanged()
    end)
  end
  local loader = self:GetUIComponent("UISelectObjectPath", "LevelEntry")
  local levelGroup = loader:SpawnObject("UISummerActivityTwoEntryLevelGroup")
  levelGroup:Refresh(self._levelData:GetEntryLevelDatas(), function()
    self:SelectEntryLevelChanged()
  end)
  self:RefreshEntryScoreInfo()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISummerActivityTwoSelectEntryController)
end

function UISummerActivityTwoSelectEntryController:RefreshEntryScoreInfo()
  local selectEntryLevelData
  local entryLevelData = self._levelData:GetEntryLevelDatas()
  local entryLevelDatas = entryLevelData:GetEntryLevelDatas()
  for i = 1, #entryLevelDatas do
    local entryLevelData = entryLevelDatas[i]
    if entryLevelData:IsSelected() then
      selectEntryLevelData = entryLevelData
      break
    end
  end
  local baseScore = selectEntryLevelData:GetLevelScore()
  self._baseScoreLabel:SetText(StringTable.Get("str_summer_activity_two_base_score_title", baseScore))
  local count = 0
  local entryDatas = {}
  for i = 1, #self._list do
    local entryItem = self._list[i]:GetSelectedEntryItem()
    if entryItem then
      local entryData = entryItem:GetEntryData()
      entryDatas[#entryDatas + 1] = entryData
      count = count + 1
    end
  end
  self._selectedEntryCountLabel.text = count .. "/" .. self._grouCount
  local ratio, totalScore = UISummerActivityTwoLevelDatas.CalcScore(selectEntryLevelData, entryDatas)
  self._totalScoreLabel.text = totalScore
  local a, b = math.modf(ratio / 10)
  local text = ""
  if b == 0 then
    text = StringTable.Get("str_summer_activity_two_ratio_score_title", 100 + a)
  else
    text = StringTable.Get("str_summer_activity_two_ratio_score_title", 100 + ratio / 10)
  end
  self._ratioScoreLabel:SetText(text)
end

function UISummerActivityTwoSelectEntryController:SelectEntryLevelChanged()
  self:RefreshEntryScoreInfo()
end

function UISummerActivityTwoSelectEntryController:SelectEntryChanged()
  self:RefreshEntryScoreInfo()
end

function UISummerActivityTwoSelectEntryController:StartBattleBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.StartBattleBtnCoro, self)
end

function UISummerActivityTwoSelectEntryController:StartBattleBtnCoro(TT)
  local res = AsyncRequestRes:New()
  local selectaffixIdArray = {}
  for i = 1, #self._list do
    local entryItem = self._list[i]:GetSelectedEntryItem()
    if entryItem then
      local id = entryItem:GetEntryData():GetId()
      selectaffixIdArray[#selectaffixIdArray + 1] = id
    end
  end
  local selectEntryLevelData
  local entryLevelData = self._levelData:GetEntryLevelDatas()
  local entryLevelDatas = entryLevelData:GetEntryLevelDatas()
  for i = 1, #entryLevelDatas do
    local entryLevelData = entryLevelDatas[i]
    if entryLevelData:IsSelected() then
      selectEntryLevelData = entryLevelData
      break
    end
  end
  self._missionComponent:HandleSelectAffix(TT, res, self._levelData:GetMissionId(), selectaffixIdArray, selectEntryLevelData:GetLevel())
  if res:GetSucc() then
    local missiontModule = GameGlobal.GetModule(MissionModule)
    local ctx = missiontModule:TeamCtx()
    local level = selectEntryLevelData:GetSuggestLevel()
    local awake = selectEntryLevelData:GetSuggestAwake()
    local param = {
      self._levelData:GetMissionId(),
      self._missionComponent:GetCampaignMissionComponentId(),
      self._missionComponent:GetCampaignMissionParamKeyMap(),
      {
        true,
        level,
        awake
      }
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result)
  end
end

function UISummerActivityTwoSelectEntryController:ClearBtnOnClick()
  for i = 1, #self._list do
    self._list[i]:ClearSelected()
  end
  self:SelectEntryChanged()
end

function UISummerActivityTwoSelectEntryController:CloseCoro(TT)
  self:Lock("UISummerActivityTwoSelectEntryController_CloseCoro")
  self._anim:Play("uieff_Summer2_Level_Select_Out")
  YIELD(TT, 700)
  self:CloseDialog()
  self:UnLock("UISummerActivityTwoSelectEntryController_CloseCoro")
end
