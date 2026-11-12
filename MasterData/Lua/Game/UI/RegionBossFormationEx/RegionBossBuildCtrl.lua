local RegionBossBuildCtrl = class("RegionBossBuildCtrl", BaseCtrl)
RegionBossBuildCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  aniPanel = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  BuildList = {
    sComponentName = "LoopScrollView"
  },
  btn_sort_time = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SortTime"
  },
  btn_sort_score = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SortScore"
  },
  btn_Filter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenFilter"
  },
  imgFilterChoose = {},
  txt_srot_timeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SortTime"
  },
  txt_srot_ScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SortScore"
  },
  txt_BuildCount = {sComponentName = "TMP_Text"},
  btnPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preview"
  },
  txtBtnPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Btn_AttributePreview"
  },
  txt_Empty = {sComponentName = "TMP_Text"},
  EmptyContent = {},
  ExistContent = {},
  animExistContent = {
    sNodeName = "ExistContent",
    sComponentName = "Animator"
  },
  ListContent = {}
}
RegionBossBuildCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.FilterConfirm] = "OnEvent_RefreshByFilter",
  [EventId.IsNewDay] = "RefreshBuildData"
}
local SortType = {Time = 1, Score = 2}
local SortOrder = {Descending = true, Ascending = false}
local PanelState = {
  Normal = 1,
  Delete = 2,
  Preference = 3
}
local BtnTextColor = {
  [true] = Color(0.3288888888888889, 0.43555555555555553, 0.5422222222222223, 1),
  [false] = Color(0.7288888888888889, 0.8, 0.8711111111111111, 1)
}
local FilterGradeIdx = {
  btn_FilterGradeS = 3,
  btn_FilterGradeA = 2,
  btn_FilterGradeB = 1,
  btn_FilterGradeC = 0
}

function RegionBossBuildCtrl:RefreshList()
  if #self._tbAllBuild == 0 then
    self._mapNode.ExistContent:SetActive(false)
    self._mapNode.EmptyContent:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_Empty, ConfigTable.GetUIText("RoguelikeBuild_Manage_EmptyList"))
    return
  else
    self._mapNode.ExistContent:SetActive(true)
  end
  local isDirty = PlayerData.Filter:IsDirtyByOption(self._panel.tbOption)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self.tbCurShow = self:FilterAndSortBuildData()
  if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    for i, v in pairs(self.tbCurShow) do
      local tmpChar = {}
      for i = 1, 3 do
        table.insert(tmpChar, v.tbChar[i].nTid)
      end
      v.isCanUse = PlayerData.InfinityTower:JudgeInfinityTowerBuildCanUse(tmpChar, self.selLvId)
    end
    table.sort(self.tbCurShow, function(a, b)
      if self.nSortype == SortType.Time then
        if self.nSortOrder == SortOrder.Descending then
          if a.isCanUse ~= b.isCanUse then
            return a.isCanUse and not b.isCanUse
          end
          return a.nBuildId > b.nBuildId
        else
          if a.isCanUse ~= b.isCanUse then
            return a.isCanUse and not b.isCanUse
          end
          return a.nBuildId < b.nBuildId
        end
      elseif self.nSortOrder == SortOrder.Descending then
        if a.isCanUse ~= b.isCanUse then
          return a.isCanUse and not b.isCanUse
        end
        if a.nScore ~= b.nScore then
          return a.nScore > b.nScore
        else
          return a.nBuildId > b.nBuildId
        end
      else
        if a.isCanUse ~= b.isCanUse then
          return a.isCanUse and not b.isCanUse
        end
        if a.nScore ~= b.nScore then
          return a.nScore < b.nScore
        else
          return a.nBuildId > b.nBuildId
        end
      end
    end)
  elseif self.nType == AllEnum.RegionBossFormationType.Vampire then
    for _, v in pairs(self.tbCurShow) do
      local function judgeBuildCanUse(v)
        for i = 1, 3 do
          if table.indexof(self.tbSelChar, v.tbChar[i].nTid) > 0 then
            v.isCanUse = false
            
            return
          end
        end
        v.isCanUse = true
      end
      
      judgeBuildCanUse(v)
    end
  elseif self.nType == AllEnum.RegionBossFormationType.JointDrill or self.nType == AllEnum.RegionBossFormationType.JointDrill_2 then
    for _, data in ipairs(self.tbUsedBuildList) do
      for k, v in pairs(self.tbCurShow) do
        if data.BuildId == v.nBuildId then
          v.bBuildUsed = true
        else
          local bCharUsed = false
          for i = 1, 3 do
            if table.indexof(self.tbSelChar, v.tbChar[i].nTid) > 0 then
              bCharUsed = true
              break
            end
          end
          if bCharUsed then
            v.bCharUsed = true
          end
        end
      end
    end
  end
  PlayerData.Build:PrioritizeLimitedTrialBuilds(self.tbCurShow, function(mapBuild)
    if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
      return mapBuild.isCanUse and 1 or 0
    elseif self.nPanelState == PanelState.Delete then
      return self.mapDelete[mapBuild.nBuildId] ~= nil and 1 or 0
    elseif self.nPanelState == PanelState.Preference then
      local bCheckIn = self.mapPreferenceCheckIn[mapBuild.nBuildId] ~= nil
      local bCheckOut = self.mapPreferenceCheckOut[mapBuild.nBuildId] ~= nil
      return (not (not mapBuild.bPreference or bCheckOut) or not mapBuild.bPreference and bCheckIn) and 1 or 0
    end
    return 0
  end)
  if #self.tbCurShow == 0 then
    self._mapNode.EmptyContent:SetActive(true)
    self._mapNode.ListContent:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txt_Empty, ConfigTable.GetUIText("RoguelikeBuild_Manage_EmptyFilter"))
    return
  else
    self._mapNode.EmptyContent:SetActive(false)
    self._mapNode.ListContent:SetActive(true)
  end
  self._mapNode.BuildList:Init(#self.tbCurShow, self, self.RefreshBuildGrid)
  local nBuildCount = 0
  for _, mapBuild in ipairs(self._tbAllBuild) do
    if PlayerData.Build:GetBuildSourceByData(mapBuild) == AllEnum.BuildSource.Normal then
      nBuildCount = nBuildCount + 1
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txt_BuildCount, string.format("%d/%d", nBuildCount, ConfigTable.GetConfigNumber("StarTowerBuildNumberMax")))
end

function RegionBossBuildCtrl:FilterAndSortBuildData()
  local ret = {}
  
  local function filterBuild(mapBuild)
    if self.nPanelState == PanelState.Delete and self.mapDelete[mapBuild.nBuildId] ~= nil then
      table.insert(ret, clone(mapBuild))
      return
    end
    if self.nPanelState == PanelState.Preference then
      local bCheckIn = self.mapPreferenceCheckIn[mapBuild.nBuildId] ~= nil
      local bCheckOut = self.mapPreferenceCheckOut[mapBuild.nBuildId] ~= nil
      if not (not mapBuild.bPreference or bCheckOut) or not mapBuild.bPreference and bCheckIn then
        table.insert(ret, mapBuild)
        return
      end
    end
    if #self.FilterGrade > 0 and 0 >= table.indexof(self.FilterGrade, mapBuild.nGrade) then
      return
    end
    if self.FiterPreference ~= self.FilterUnpreference and (not (not self.FiterPreference or mapBuild.bPreference) or self.FilterUnpreference and mapBuild.bPreference) then
      return
    end
    if self.FilterPass ~= self.FilterUnpass and (not (not self.FilterPass or mapBuild.bPass) or self.FilterUnpass and mapBuild.bPass) then
      return
    end
    local nCharId = mapBuild.tbChar[1].nTid
    local isFilter = PlayerData.Filter:CheckFilterByCharAndOption(nCharId, self._panel.tbOption)
    if isFilter then
      table.insert(ret, mapBuild)
    end
  end
  
  for _, mapBuild in ipairs(self._tbAllBuild) do
    filterBuild(mapBuild)
  end
  if self.nSortype == SortType.Time then
    local function sortByTime(a, b)
      if self.nPanelState == PanelState.Delete then
        local bSelecta = self.mapDelete[a.nBuildId] ~= nil
        
        local bSelectb = self.mapDelete[b.nBuildId] ~= nil
        if bSelecta ~= bSelectb then
          return bSelecta
        end
      end
      if self.nPanelState == PanelState.Preference then
        local bCheckInA = self.mapPreferenceCheckIn[a.nBuildId] ~= nil
        local bCheckOutA = self.mapPreferenceCheckOut[a.nBuildId] ~= nil
        local bSelectA = a.bPreference and not bCheckOutA or not a.bPreference and bCheckInA
        local bCheckInB = self.mapPreferenceCheckIn[b.nBuildId] ~= nil
        local bCheckOutB = self.mapPreferenceCheckOut[b.nBuildId] ~= nil
        local bSelectB = b.bPreference and not bCheckOutB or not b.bPreference and bCheckInB
        if bSelectA ~= bSelectB then
          return bSelectA
        end
      end
      if self.nSortOrder == SortOrder.Descending then
        return a.nBuildId > b.nBuildId
      else
        return a.nBuildId < b.nBuildId
      end
    end
    
    table.sort(ret, sortByTime)
  else
    local function sortByScore(a, b)
      if self.nPanelState == PanelState.Delete then
        local bSelecta = self.mapDelete[a.nBuildId] ~= nil
        
        local bSelectb = self.mapDelete[b.nBuildId] ~= nil
        if bSelecta ~= bSelectb then
          return bSelecta
        end
      end
      if self.nPanelState == PanelState.Preference then
        local bCheckInA = self.mapPreferenceCheckIn[a.nBuildId] ~= nil
        local bCheckOutA = self.mapPreferenceCheckOut[a.nBuildId] ~= nil
        local bSelectA = a.bPreference and not bCheckOutA or not a.bPreference and bCheckInA
        local bCheckInB = self.mapPreferenceCheckIn[b.nBuildId] ~= nil
        local bCheckOutB = self.mapPreferenceCheckOut[b.nBuildId] ~= nil
        local bSelectB = b.bPreference and not bCheckOutB or not b.bPreference and bCheckInB
        if bSelectA ~= bSelectB then
          return bSelectA
        end
      end
      if self.nSortOrder == SortOrder.Descending then
        if a.nScore ~= b.nScore then
          return a.nScore > b.nScore
        else
          return a.nBuildId > b.nBuildId
        end
      elseif a.nScore ~= b.nScore then
        return a.nScore < b.nScore
      else
        return a.nBuildId > b.nBuildId
      end
    end
    
    table.sort(ret, sortByScore)
  end
  return ret
end

function RegionBossBuildCtrl:RefreshBuildGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbCurShow[nIndex]
  local bSelectDelete = self.mapDelete[mapData.nBuildId] ~= nil
  local bCheckOut = self.mapPreferenceCheckOut[mapData.nBuildId] ~= nil
  local bCheckIn = self.mapPreferenceCheckIn[mapData.nBuildId] ~= nil
  if self.mapListItemCtrl[goGrid] == nil then
    self.mapListItemCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.StarTower.Build.StarTowerBuildBriefItem")
    self.mapListItemCtrl[goGrid]:Init(self)
  end
  self.mapListItemCtrl[goGrid]:RefreshGrid(mapData, self.nPanelState, bSelectDelete, bCheckOut, bCheckIn, self.nType)
end

function RegionBossBuildCtrl:OnBuildGridLock(nIdx, itemCtrl)
  local mapBuild = self.tbCurShow[nIdx]
  if not PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) then
    return
  end
  
  local function callback()
    mapBuild.bLock = not mapBuild.bLock
    itemCtrl:SetLockState(mapBuild.bLock)
    if self.nPanelState == PanelState.Delete and mapBuild.bLock and self.mapDelete[mapBuild.nBuildId] ~= nil then
      self.mapDelete[mapBuild.nBuildId] = nil
      self.nSelectedDeleteCount = self.nSelectedDeleteCount - 1
      itemCtrl:SetSelectDeleteState(false)
      self:SetDeleteResult()
    end
  end
  
  PlayerData.Build:ChangeBuildLock(mapBuild.nBuildId, not mapBuild.bLock, callback)
end

function RegionBossBuildCtrl:OnBuildGridPreference(nIdx, itemCtrl)
  if self.nPanelState ~= PanelState.Normal then
    self:OnBtnClickGrid(nIdx, itemCtrl)
    return
  end
  local mapBuild = self.tbCurShow[nIdx]
  if not PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) then
    return
  end
  local tbPreferenceCheckIn = {}
  local tbPreferenceCheckOut = {}
  
  local function callback()
    itemCtrl:SetPreferenceState(mapBuild.bPreference)
  end
  
  if mapBuild.bPreference then
    table.insert(tbPreferenceCheckOut, mapBuild.nBuildId)
  else
    table.insert(tbPreferenceCheckIn, mapBuild.nBuildId)
  end
  PlayerData.Build:SetBuildPreference(tbPreferenceCheckIn, tbPreferenceCheckOut, callback)
end

function RegionBossBuildCtrl:OnBtnClickGrid(nIdx, itemCtrl)
  local mapBuild = self.tbCurShow[nIdx]
  if mapBuild == nil then
    return
  end
  if mapBuild.nBuildSource == AllEnum.BuildSource.LimitedTrial and not PlayerData.Build:IsLimitedTrialBuildAllowedType(self.nType) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LimitedTrialBuild_UnableTip"))
    return
  end
  if mapBuild.nBuildSource == AllEnum.BuildSource.LimitedTrial and not PlayerData.Build:IsLimitedTrialBuildValid(mapBuild.nBuildId, self.nType) then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Reengagement_BuildInvalid")
    })
    self:RefreshBuildData()
    return
  end
  if self.nType == AllEnum.RegionBossFormationType.RegionBoss then
    PlayerData.RogueBoss:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.TravelerDuel then
    if self.Other ~= nil then
      local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
      activityLevelsData:SetCachedBuildId(self.tbCurShow[nIdx].nBuildId)
    end
  elseif self.nType == AllEnum.RegionBossFormationType.DailyInstance then
    PlayerData.DailyInstance:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    PlayerData.InfinityTower:SetSelBuildId(self.tbCurShow[nIdx].nBuildId, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.EquipmentInstance then
    PlayerData.EquipmentInstance:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
    EventManager.Hit("SelectEquipmentBuild")
  elseif self.nType == AllEnum.RegionBossFormationType.Story then
    PlayerData.Avg:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.Vampire then
    PlayerData.VampireSurvivor:CacheSelectedBuildId(self.selLvId, self.nIdx, self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss or self.nType == AllEnum.RegionBossFormationType.ScoreBoss_GM then
    PlayerData.ScoreBoss:SetSelBuildId(self.tbCurShow[nIdx].nBuildId, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.TraceHunt then
    PlayerData.TraceHunt:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.SkillInstance then
    PlayerData.SkillInstance:SetSelBuildId(self.tbCurShow[nIdx].nBuildId, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.WeeklyCopies then
    PlayerData.RogueBoss:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.JointDrill then
    PlayerData.JointDrill_1:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.JointDrill_2 then
    PlayerData.JointDrill_2:SetSelBuildId(self.tbCurShow[nIdx].nBuildId)
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityLevels then
    local nActId = PlayerData.Activity:GetActivityLevelActId()
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(nActId)
    activityLevelsData:SetCachedSelBuildId(self.tbCurShow[nIdx].nBuildId, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityStory then
    local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
    storyData:SetSelBuildId(self.tbCurShow[nIdx].nBuildId, self.nActId)
  end
  local tbChar = self.tbCurShow[nIdx].tbChar
  local nRandomIdx = math.random(1, #tbChar)
  PlayerData.Voice:PlayCharVoice("buildPick", tbChar[nRandomIdx].nTid)
  EventManager.Hit(EventId.ClosePanel, PanelId.RogueBossBuildBrief)
end

function RegionBossBuildCtrl:OnBuildGridDetail(nIdx, itemCtrl)
  local mapBuild = self.tbCurShow[nIdx]
  
  local function callback(mapData)
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildDetail, mapData)
  end
  
  PlayerData.Build:GetBuildDetailData(callback, mapBuild.nBuildId)
end

function RegionBossBuildCtrl:InitSort()
  NovaAPI.SetTMPColor(self._mapNode.txt_srot_timeTitle, BtnTextColor[self.nSortype == SortType.Time])
  NovaAPI.SetTMPColor(self._mapNode.txt_srot_ScoreTitle, BtnTextColor[self.nSortype == SortType.Score])
  self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Score and self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Score and self.nSortOrder == SortOrder.Descending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Time and self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Time and self.nSortOrder == SortOrder.Descending
end

function RegionBossBuildCtrl:FadeIn(bPlayFadeIn)
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    self._mapNode.animExistContent:SetTrigger("tIn")
    if #self._tbAllBuild > 0 then
      EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
    end
  end
end

function RegionBossBuildCtrl:Awake()
  self._tbAllBuild = {}
  self.tbCurShow = {}
  self.mapPreferenceCheckIn = {}
  self.mapPreferenceCheckOut = {}
  self.mapDelete = {}
  self.nSelectedDeleteCount = 0
  self.FilterGrade = {}
  self.FiterPreference = false
  self.FilterUnpreference = false
  self.FilterPass = false
  self.FilterUnpass = false
  self.nSortype = SortType.Score
  self.nSortOrder = SortOrder.Descending
  self.nPanelState = PanelState.Normal
  self:InitSort()
  self.mapListItemCtrl = {}
  self.tbCoinRate = ConfigTable.GetConfigArray("StarTowerBuildTransformParas")
end

function RegionBossBuildCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nType = tbParam[1]
  self.selLvId = 0
  self.nIdx = 1
  self.tbSelChar = {}
  if tbParam[2] ~= nil then
    self.selLvId = tbParam[2]
  end
  if self.nType == AllEnum.RegionBossFormationType.Vampire then
    self.nIdx = tbParam[3]
  elseif self.nType == AllEnum.RegionBossFormationType.JointDrill then
    self.tbUsedBuildList = PlayerData.JointDrill_1:GetJointDrillBuildList()
  elseif self.nType == AllEnum.RegionBossFormationType.JointDrill_2 then
    self.tbUsedBuildList = PlayerData.JointDrill_2:GetJointDrillBuildList()
  end
  if tbParam[4] ~= nil then
    self.Other = tbParam[4]
  end
  self.nActId = tbParam[5]
  self.bReview = tbParam[6] == true
  if next(self._panel.mapCacheFilter) ~= nil then
    for fKey, data in pairs(self._panel.mapCacheFilter) do
      for sKey, value in pairs(data) do
        PlayerData.Filter:SetCacheFilterByKey(fKey, sKey, value)
      end
    end
    PlayerData.Filter:SyncFilterByCache()
  end
  self:RefreshBuildData()
end

function RegionBossBuildCtrl:RefreshBuildData()
  self.tbSelChar = {}
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    self._mapAllBuild = mapAllBuild
    self._tbAllBuild = clone(tbBuildData)
    if self.nType == AllEnum.RegionBossFormationType.Vampire then
      local tbBuildId = PlayerData.VampireSurvivor:GetCachedBuildId(self.selLvId)
      if tbBuildId ~= nil then
        local nOtherBuildId = tbBuildId[2 / self.nIdx]
        local mapBuildData = mapAllBuild[nOtherBuildId]
        if mapBuildData ~= nil then
          for _, mapChar in ipairs(mapBuildData.tbChar) do
            table.insert(self.tbSelChar, mapChar.nTid)
          end
        end
      end
    elseif self.nType == AllEnum.RegionBossFormationType.JointDrill or self.nType == AllEnum.RegionBossFormationType.JointDrill_2 then
      for _, v in ipairs(self.tbUsedBuildList) do
        for _, char in ipairs(v.Chars) do
          if table.indexof(self.tbSelChar, char.CharId) == 0 then
            table.insert(self.tbSelChar, char.CharId)
          end
        end
      end
    end
    self:RefreshList()
    EventManager.Hit("Guide_RegionBossRefresh")
  end
  
  PlayerData.Build:GetSelectableBuildBriefData(GetDataCallback, self.nType, true)
end

function RegionBossBuildCtrl:OnDisable()
  self.mapPreferenceCheckIn = {}
  self.mapPreferenceCheckOut = {}
  self.mapDelete = {}
  self.nSelectedDeleteCount = 0
  for nInstanceId, objCtrl in pairs(self.mapListItemCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapListItemCtrl[nInstanceId] = nil
  end
  self.mapListItemCtrl = {}
  self._panel.mapCacheFilter = {}
  for _, fKey in ipairs(self._panel.tbOption) do
    if self._panel.mapCacheFilter[fKey] == nil then
      self._panel.mapCacheFilter[fKey] = {}
    end
    local data = PlayerData.Filter:GetCacheFilter(fKey)
    if data ~= nil then
      for sKey, value in pairs(data) do
        self._panel.mapCacheFilter[fKey][sKey] = value
      end
    end
  end
  PlayerData.Filter:Reset(self._panel.tbOption)
end

function RegionBossBuildCtrl:OnDestroy()
end

function RegionBossBuildCtrl:OnRelease()
end

function RegionBossBuildCtrl:FadeOut(callback)
  local function Callback()
    if type(callback) == "function" then
      callback()
    end
  end
  
  EventManager.Hit(EventId.TemporaryBlockInput, 0.03, Callback)
end

function RegionBossBuildCtrl:OnBtnClick_SortTime(btn)
  if self.nSortype == SortType.Time then
    self.nSortOrder = not self.nSortOrder
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Ascending
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Descending
  else
    self.nSortype = SortType.Time
    self.nSortOrder = SortOrder.Descending
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = false
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = true
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = false
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = false
    NovaAPI.SetTMPColor(self._mapNode.txt_srot_timeTitle, BtnTextColor[self.nSortype == SortType.Time])
    NovaAPI.SetTMPColor(self._mapNode.txt_srot_ScoreTitle, BtnTextColor[self.nSortype == SortType.Score])
  end
  self:RefreshList()
end

function RegionBossBuildCtrl:OnBtnClick_SortScore(btn)
  if self.nSortype == SortType.Score then
    self.nSortOrder = not self.nSortOrder
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Ascending
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Descending
  else
    self.nSortype = SortType.Score
    self.nSortOrder = SortOrder.Descending
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = false
    self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = true
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = false
    self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = false
    NovaAPI.SetTMPColor(self._mapNode.txt_srot_timeTitle, BtnTextColor[self.nSortype == SortType.Time])
    NovaAPI.SetTMPColor(self._mapNode.txt_srot_ScoreTitle, BtnTextColor[self.nSortype == SortType.Score])
  end
  self:RefreshList()
end

function RegionBossBuildCtrl:OnBtnClick_OpenFilter(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, self._panel.tbOption)
end

function RegionBossBuildCtrl:OnBtnClick_Preview()
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildAttrPreview)
end

function RegionBossBuildCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    PlayerData.InfinityTower:SetPageState(1)
  end
  PanelManager.Home()
end

function RegionBossBuildCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.RogueBossBuildBrief)
end

function RegionBossBuildCtrl:OnEvent_RefreshByFilter()
  local bChange = false
  local tbTemp = clone(self._panel.mapCacheFilter)
  self._panel.mapCacheFilter = {}
  for _, fKey in ipairs(self._panel.tbOption) do
    if self._panel.mapCacheFilter[fKey] == nil then
      self._panel.mapCacheFilter[fKey] = {}
    end
    local data = PlayerData.Filter:GetCacheFilter(fKey)
    if data ~= nil then
      if tbTemp[fKey] == nil then
        bChange = true
      end
      for sKey, value in pairs(data) do
        if not bChange and (tbTemp[fKey][sKey] == nil or tbTemp[fKey][sKey] ~= value) then
          bChange = true
        end
        self._panel.mapCacheFilter[fKey][sKey] = value
      end
    end
  end
  if bChange then
    self:RefreshList()
  end
end

return RegionBossBuildCtrl
