local StarTowerBuildBriefCtrl = class("StarTowerBuildBriefCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
StarTowerBuildBriefCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
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
  btn_DeleteBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectDelete"
  },
  btn_SetPreference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectPreference"
  },
  txt_srot_timeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SortTime"
  },
  txt_srot_ScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SortScore"
  },
  txt_BuildCount = {sComponentName = "TMP_Text"},
  result1 = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnResult1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Result1"
  },
  rtResultTitle = {},
  txtBtnDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Delete"
  },
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
  ListContent = {},
  DeleteContent = {},
  DD_selectDelect = {
    sNodeName = "tc_dropdown_01",
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  btn_FastSelectDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastSelectDeleteBuild"
  },
  btn_CloseDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseDelete"
  },
  btn_Delete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenDeleteHint"
  },
  txt_FastSelectDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_BtnBatchSelect"
  },
  txt_CloseDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_BtnClose"
  },
  txt_Delete = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_BtnDelete"
  },
  txt_SelectCountTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  txt_SelectCount = {sComponentName = "TMP_Text"},
  txt_DeleteIncomeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_DeleteIncomeTitle"
  },
  PreferenceContent = {},
  btn_ConfirmPreference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ConfitmPreference"
  },
  btn_ClosePreference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePreference"
  },
  txt_PreferenceCountTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_FilterPreference"
  },
  txt_PreferenceCountTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  txt_PreferenceCount = {sComponentName = "TMP_Text"},
  txt_ClosePreference = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_BtnClose"
  },
  txt_SetPreference = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_BtnConfirm"
  },
  ani_DeleteContent = {
    sNodeName = "DeleteContent",
    sComponentName = "Animator"
  }
}
StarTowerBuildBriefCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "OnEvent_RefreshByFilter"
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

function StarTowerBuildBriefCtrl:GetEditableBuildCount()
  local nCount = 0
  for _, mapBuild in ipairs(self._tbAllBuild) do
    if PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) then
      nCount = nCount + 1
    end
  end
  return nCount
end

function StarTowerBuildBriefCtrl:RefreshList()
  local isDirty = PlayerData.Filter:IsDirtyByOption(self._panel.tbOption)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  if #self._tbAllBuild == 0 then
    self._mapNode.ExistContent:SetActive(false)
    self._mapNode.EmptyContent:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_Empty, ConfigTable.GetUIText("RoguelikeBuild_Manage_EmptyList"))
    return
  else
    self._mapNode.ExistContent:SetActive(true)
  end
  self.tbCurShow = self:FilterAndSortBuildData()
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
  NovaAPI.SetTMPText(self._mapNode.txt_BuildCount, string.format("%d/%d", self:GetEditableBuildCount(), ConfigTable.GetConfigNumber("StarTowerBuildNumberMax")))
end

function StarTowerBuildBriefCtrl:FilterAndSortBuildData()
  local ret = {}
  
  local function filterBuild(mapBuild)
    if self.nPanelState == PanelState.Delete and self.mapDelete[mapBuild.nBuildId] ~= nil then
      table.insert(ret, mapBuild)
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
  PlayerData.Build:PrioritizeLimitedTrialBuilds(ret, function(mapBuild)
    if self.nPanelState == PanelState.Delete then
      return self.mapDelete[mapBuild.nBuildId] ~= nil and 1 or 0
    elseif self.nPanelState == PanelState.Preference then
      local bCheckIn = self.mapPreferenceCheckIn[mapBuild.nBuildId] ~= nil
      local bCheckOut = self.mapPreferenceCheckOut[mapBuild.nBuildId] ~= nil
      return (not (not mapBuild.bPreference or bCheckOut) or not mapBuild.bPreference and bCheckIn) and 1 or 0
    end
    return 0
  end)
  return ret
end

function StarTowerBuildBriefCtrl:RefreshBuildGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbCurShow[nIndex]
  local bSelectDelete = self.mapDelete[mapData.nBuildId] ~= nil
  local bCheckOut = self.mapPreferenceCheckOut[mapData.nBuildId] ~= nil
  local bCheckIn = self.mapPreferenceCheckIn[mapData.nBuildId] ~= nil
  if self.mapListItemCtrl[goGrid] == nil then
    self.mapListItemCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.StarTower.Build.StarTowerBuildBriefItem")
    self.mapListItemCtrl[goGrid]:Init(self)
  end
  self.mapListItemCtrl[goGrid]:RefreshGrid(mapData, self.nPanelState, bSelectDelete, bCheckOut, bCheckIn)
end

function StarTowerBuildBriefCtrl:OnBuildGridLock(nIdx, itemCtrl)
  local mapBuild = self.tbCurShow[nIdx]
  if not PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) then
    return
  end
  
  local function callback()
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

function StarTowerBuildBriefCtrl:OnBuildGridPreference(nIdx, itemCtrl)
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

function StarTowerBuildBriefCtrl:OnBtnClickGrid(nIdx, itemCtrl)
  local mapBuild = self.tbCurShow[nIdx]
  if self.nPanelState ~= PanelState.Normal and not PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) then
    return
  end
  if self.nPanelState == PanelState.Delete then
    if mapBuild.bLock then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BUILD_01"))
      return
    end
    local bSelectDelete = self.mapDelete[mapBuild.nBuildId] ~= nil
    if bSelectDelete then
      self.mapDelete[mapBuild.nBuildId] = nil
      self.nSelectedDeleteCount = self.nSelectedDeleteCount - 1
      itemCtrl:SetSelectDeleteState(false)
    else
      self.mapDelete[mapBuild.nBuildId] = 0
      self.nSelectedDeleteCount = self.nSelectedDeleteCount + 1
      itemCtrl:SetSelectDeleteState(true)
    end
    self:SetDeleteResult()
  elseif self.nPanelState == PanelState.Preference then
    local bCheckIn = self.mapPreferenceCheckIn[mapBuild.nBuildId] ~= nil
    local bCheckOut = self.mapPreferenceCheckOut[mapBuild.nBuildId] ~= nil
    if bCheckIn then
      self.mapPreferenceCheckIn[mapBuild.nBuildId] = nil
      itemCtrl:SetSelectPreferenceState(false)
      self.nPreferenceCount = self.nPreferenceCount - 1
    elseif bCheckOut then
      self.mapPreferenceCheckOut[mapBuild.nBuildId] = nil
      itemCtrl:SetSelectPreferenceState(true)
      self.nPreferenceCount = self.nPreferenceCount + 1
    elseif mapBuild.bPreference then
      self.mapPreferenceCheckOut[mapBuild.nBuildId] = 0
      itemCtrl:SetSelectPreferenceState(false)
      self.nPreferenceCount = self.nPreferenceCount - 1
    else
      self.mapPreferenceCheckIn[mapBuild.nBuildId] = 0
      itemCtrl:SetSelectPreferenceState(true)
      self.nPreferenceCount = self.nPreferenceCount + 1
    end
    NovaAPI.SetTMPText(self._mapNode.txt_PreferenceCount, string.format("%d/%d", self.nPreferenceCount, self:GetEditableBuildCount()))
  else
    local function callback(mapData)
      EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildDetail, mapData)
      
      self._panel._nFadeInType = 2
    end
    
    PlayerData.Build:GetBuildDetailData(callback, mapBuild.nBuildId)
  end
end

function StarTowerBuildBriefCtrl:CalDeleteResult()
  local ret = 0
  local bHasRare = false
  for nBuildId, _ in pairs(self.mapDelete) do
    local mapBuild = self._mapAllBuild[nBuildId]
    if mapBuild.mapRank.Rarity == GameEnum.itemRarity.SSR then
      bHasRare = true
    end
    ret = ret + math.floor(math.min(math.max(mapBuild.nScore / tonumber(self.tbCoinRate[1]), tonumber(self.tbCoinRate[2])), tonumber(self.tbCoinRate[3])))
  end
  return ret, bHasRare
end

function StarTowerBuildBriefCtrl:SetDeleteResult()
  local nCoin = self:CalDeleteResult()
  local mapCfg = ConfigTable.GetData_Item(self.nDeleteReturnId)
  if nCoin == 0 then
    self._mapNode.rtResultTitle.gameObject:SetActive(false)
  else
    self._mapNode.rtResultTitle.gameObject:SetActive(true)
    self._mapNode.result1:SetItem(self.nDeleteReturnId, nil, nCoin, nil, nil, nil, nil, true)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_SelectCount, string.format("%d/%d", self.nSelectedDeleteCount, self:GetEditableBuildCount()))
end

function StarTowerBuildBriefCtrl:CalPreferenceCount()
  local ret = 0
  for _, mapBuild in ipairs(self._tbAllBuild) do
    if PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) and mapBuild.bPreference then
      ret = ret + 1
    end
  end
  return ret
end

function StarTowerBuildBriefCtrl:OpenConfirmHint()
  local nCoin, bHasRare = self:CalDeleteResult()
  
  local function CheckCallback()
    local sTip = ""
    if bHasRare then
      sTip = ConfigTable.GetUIText("BUILD_06")
    else
      sTip = ConfigTable.GetUIText("BUILD_02")
    end
    local msg = {
      nType = AllEnum.MessageBox.Item,
      sContent = sTip,
      tbItem = {
        [1] = {
          nTid = self.nDeleteReturnId,
          nCount = nCoin,
          bFullShow = true
        }
      },
      callbackConfirm = function()
        local hasDispatchingBuild = false
        
        local function callback()
          local function GetDataCallback(tbBuildData, mapAllBuild)
            self._mapAllBuild = mapAllBuild
            
            self._tbAllBuild = tbBuildData
            self:RefreshList()
            if hasDispatchingBuild then
              EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Build_Same_Cant_Delete"))
            end
          end
          
          self:OnBtnClick_CloseDelete()
          PlayerData.Build:GetSelectableBuildBriefData(GetDataCallback, nil, true)
        end
        
        local tbDelete = {}
        for key, _ in pairs(self.mapDelete) do
          if not PlayerData.Dispatch.IsBuildDispatching(key) then
            table.insert(tbDelete, key)
          else
            hasDispatchingBuild = true
          end
        end
        if 0 < #tbDelete and not hasDispatchingBuild then
          PlayerData.Build:DeleteBuild(tbDelete, callback)
        else
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Build_Cant_Delete"))
        end
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  PlayerData.Build:CheckCoinMax(nCoin, CheckCallback)
end

function StarTowerBuildBriefCtrl:InitSort()
  NovaAPI.SetTMPColor(self._mapNode.txt_srot_timeTitle, BtnTextColor[self.nSortype == SortType.Time])
  NovaAPI.SetTMPColor(self._mapNode.txt_srot_ScoreTitle, BtnTextColor[self.nSortype == SortType.Score])
  self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Score and self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_score.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Score and self.nSortOrder == SortOrder.Descending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Time and self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortype == SortType.Time and self.nSortOrder == SortOrder.Descending
end

function StarTowerBuildBriefCtrl:FadeIn(bPlayFadeIn)
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    self._mapNode.animExistContent:SetTrigger("tIn")
    if #self._tbAllBuild > 0 then
      EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
    end
  end
end

function StarTowerBuildBriefCtrl:Awake()
  self.nDeleteReturnId = ConfigTable.GetConfigNumber("StarTowerBuildDeleteReturnItemId")
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
  local tbLanguageId = {
    "RoguelikeBuild_Manage_DD_N",
    "RoguelikeBuild_Manage_DD_R",
    "RoguelikeBuild_Manage_DD_SR",
    "RoguelikeBuild_Manage_DD_SSR"
  }
  self._mapNode.DD_selectDelect:SetList(tbLanguageId, 3)
end

function StarTowerBuildBriefCtrl:OnEnable()
  if next(self._panel.mapCacheFilter) ~= nil then
    for fKey, data in pairs(self._panel.mapCacheFilter) do
      for sKey, value in pairs(data) do
        PlayerData.Filter:SetCacheFilterByKey(fKey, sKey, value)
      end
    end
    PlayerData.Filter:SyncFilterByCache()
  end
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    self._mapAllBuild = mapAllBuild
    self._tbAllBuild = tbBuildData
    self:RefreshList()
  end
  
  PlayerData.Build:GetSelectableBuildBriefData(GetDataCallback, nil, true)
end

function StarTowerBuildBriefCtrl:OnDisable()
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

function StarTowerBuildBriefCtrl:OnDestroy()
end

function StarTowerBuildBriefCtrl:OnRelease()
end

function StarTowerBuildBriefCtrl:FadeOut(callback)
  local function Callback()
    if type(callback) == "function" then
      callback()
    end
  end
  
  EventManager.Hit(EventId.TemporaryBlockInput, 0.03, Callback)
end

function StarTowerBuildBriefCtrl:OnBtnClick_Preview()
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildAttrPreview)
end

function StarTowerBuildBriefCtrl:OnBtnClick_SelectDelete()
  if self.nPanelState == PanelState.Delete then
    return
  end
  self.nPanelState = PanelState.Delete
  self.mapDelete = {}
  self.nSelectedDeleteCount = 0
  self:SetDeleteResult()
  self._mapNode.DeleteContent:SetActive(true)
  self._mapNode.animExistContent:Play("RoguelikeBuildPanel_delete_in")
  self._mapNode.BuildList:ForceRefresh()
  self._mapNode.ani_DeleteContent:Play("goDismantle_in")
end

function StarTowerBuildBriefCtrl:OnBtnClick_CloseDelete()
  self._mapNode.ani_DeleteContent:Play("goDismantle_out")
  self._mapNode.animExistContent:Play("RoguelikeBuildPanel_delete_out")
  
  function Callback()
    if self._mapNode == nil then
      return
    end
    self.nPanelState = PanelState.Normal
    self.mapDelete = {}
    self.nSelectedDeleteCount = 0
    self._mapNode.DeleteContent:SetActive(false)
    self:RefreshList()
  end
  
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2, Callback)
end

function StarTowerBuildBriefCtrl:OnBtnClick_SelectPreference()
  self.nPanelState = PanelState.Preference
  self.mapPreferenceCheckIn = {}
  self.mapPreferenceCheckOut = {}
  self.nPreferenceCount = self:CalPreferenceCount()
  NovaAPI.SetTMPText(self._mapNode.txt_PreferenceCount, string.format("%d/%d", self.nPreferenceCount, self:GetEditableBuildCount()))
  self:RefreshList()
  self._mapNode.PreferenceContent:SetActive(true)
end

function StarTowerBuildBriefCtrl:OnBtnClick_ClosePreference()
  local function Callback()
    if self._mapNode == nil then
      return
    end
    self.nPanelState = PanelState.Normal
    self.mapPreferenceCheckIn = {}
    self.mapPreferenceCheckOut = {}
    self.nPreferenceCount = 0
    self._mapNode.PreferenceContent:SetActive(false)
    self:RefreshList()
  end
  
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2, Callback)
end

function StarTowerBuildBriefCtrl:OnBtnClick_SortTime(btn)
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

function StarTowerBuildBriefCtrl:OnBtnClick_SortScore(btn)
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

function StarTowerBuildBriefCtrl:OnBtnClick_FastSelectDeleteBuild(btn)
  local filterGrade = self._mapNode.DD_selectDelect:GetValue()
  if #self.tbCurShow == 0 then
    return
  end
  for _, mapBuild in ipairs(self.tbCurShow) do
    if PlayerData.Build:IsBuildEditable(mapBuild.nBuildId) and mapBuild.mapRank.Rarity >= 4 - filterGrade and not mapBuild.bLock and self.mapDelete[mapBuild.nBuildId] == nil then
      self.mapDelete[mapBuild.nBuildId] = 0
      self.nSelectedDeleteCount = self.nSelectedDeleteCount + 1
    end
  end
  self._mapNode.BuildList:ForceRefresh()
  self:SetDeleteResult()
end

function StarTowerBuildBriefCtrl:OnBtnClick_ConfitmPreference(btn)
  local tbCheckIn = {}
  for key, _ in pairs(self.mapPreferenceCheckIn) do
    table.insert(tbCheckIn, key)
  end
  local tbCheckOut = {}
  for key, _ in pairs(self.mapPreferenceCheckOut) do
    table.insert(tbCheckOut, key)
  end
  if #tbCheckIn == 0 and #self.mapPreferenceCheckOut == 0 then
    self:OnBtnClick_ClosePreference()
  end
  
  local function callback()
    self:OnBtnClick_ClosePreference()
  end
  
  PlayerData.Build:SetBuildPreference(tbCheckIn, tbCheckOut, callback)
end

function StarTowerBuildBriefCtrl:OnBtnClick_OpenDeleteHint(btn)
  if self.nSelectedDeleteCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BUILD_03"))
    return
  end
  self:OpenConfirmHint()
end

function StarTowerBuildBriefCtrl:OnBtnClick_OpenFilter(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, self._panel.tbOption)
end

function StarTowerBuildBriefCtrl:OnBtnClick_Result1(btn)
  local mapData = {
    nTid = self.nDeleteReturnId,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function StarTowerBuildBriefCtrl:OnEvent_RefreshByFilter()
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

return StarTowerBuildBriefCtrl
