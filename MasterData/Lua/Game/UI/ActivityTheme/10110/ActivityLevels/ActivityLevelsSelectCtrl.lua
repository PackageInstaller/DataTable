local ActivityLevelsSelectCtrl = class("ActivityLevelsSelectCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local mapToggle = {
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4,
  [5] = GameEnum.diffculty.Diffculty_5,
  [6] = GameEnum.diffculty.Diffculty_6,
  [7] = GameEnum.diffculty.Diffculty_7,
  [8] = GameEnum.diffculty.Diffculty_8,
  [9] = GameEnum.diffculty.Diffculty_9,
  [10] = GameEnum.diffculty.Diffculty_10
}
local colorSelect = Color(1.0, 0.9882352941176471, 0.9568627450980393, 1)
local colorUnSelect = Color(0.4, 0.13333333333333333, 0.15294117647058825, 1)
local colorSelectLock = Color(0.11764705882352941, 0.12549019607843137, 0.17254901960784313, 1)
local colorUnSelectLock = Color(0.4823529411764706, 0.5333333333333333, 0.6509803921568628, 1)
local timeUnLockColor = "fff7ca"
local colorLockSelectImage = Color(1, 1, 1, 1)
local colorLockUnSelectImage = Color(0.20784313725490197, 0.4, 0.9019607843137255, 1)
local colorConditionsUnLock = Color(1, 1, 1, 0.5)
local colorConditionsLock = Color(1, 1, 1, 1)
local lvIndexTitle = "{0}-{1}"
local twelveLvGroupPadding = {
  81,
  88,
  -107,
  0
}
local twelveLvGroupPaddingOpen = {
  81,
  818,
  -107,
  0
}
local fourLvGroupPadding = {
  320,
  88,
  -107,
  0
}
local fourLvGroupPaddingOpen = {
  81,
  818,
  -107,
  0
}
ActivityLevelsSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  togTypeExplore = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeExplore"
  },
  togTypeExploreCtrl = {
    sNodeName = "togTypeExplore",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  lockExplore = {
    sComponentName = "UIButton",
    callback = "OnClick_BtnLockExplore"
  },
  redExplore = {},
  togTypeAdventure = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeAdventure"
  },
  togTypeAdventureCtrl = {
    sNodeName = "togTypeAdventure",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  lockAdventure = {
    sComponentName = "UIButton",
    callback = "OnClick_BtnLockAdventure"
  },
  redAdventure = {},
  togTypeHard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTypeHard"
  },
  togTypeHardCtrl = {
    sNodeName = "togTypeHard",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  lockHard = {
    sComponentName = "UIButton",
    callback = "OnClick_BtnLockHard"
  },
  redHard = {},
  rtToggles = {
    sNodeName = "srToggle",
    sComponentName = "UIScrollRect"
  },
  rtTogglesTmp = {
    sNodeName = "rt_ToggleTmp",
    sComponentName = "Transform"
  },
  togRoot = {
    nCount = 12,
    sCtrlName = "Game.UI.ActivityTheme.10110.ActivityLevels.ActivityLevelsLvCtrl"
  },
  rt_Toggle = {},
  rt_ToggleTrans = {sNodeName = "rt_Toggle", sComponentName = "Transform"},
  btnCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseBossInfo"
  },
  rtBoss = {},
  rtBossAni = {sNodeName = "rtBoss", sComponentName = "Animator"},
  txtRecommendLevel = {
    sNodeName = "txtSuggestLevel",
    sComponentName = "TMP_Text"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  txtBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgBuild = {sComponentName = "Image"},
  TMPName = {sComponentName = "TMP_Text"},
  TMPLevel = {sComponentName = "TMP_Text"},
  detailDescSc = {sComponentName = "Transform"},
  detailDesc = {sComponentName = "TMP_Text"},
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  tex_EnemyInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_EnemyInfo"
  },
  txtTitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "RogueBoss_Pause_Target"
  },
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  Task = {sComponentName = "Transform", nCount = 3},
  rewardRoot = {sComponentName = "Transform"},
  btn_itemTemp = {},
  btnListRoot = {},
  btnRaid = {
    sComponentName = "UIButton",
    callback = "OnClickBtnRaid"
  },
  txtBtnRaid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnClickBtnGo"
  },
  txtBtnGoRaidUnlock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  goCoin = {},
  txtTicketsCount = {sComponentName = "TMP_Text"},
  btnRaidUnlock = {
    sComponentName = "UIButton",
    callback = "OnClickBtnGo"
  },
  goCoinRaidUnlock = {},
  txtTicketsCountRaidUnlock = {sComponentName = "TMP_Text"},
  grpRaidUnlock = {},
  TMPRaidUnlockHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_CondStar"
  },
  ListConditions = {},
  ListConditionsObj = {
    sNodeName = "Conditions_",
    nCount = 2
  }
}
ActivityLevelsSelectCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
ActivityLevelsSelectCtrl._mapRedDotConfig = {}

function ActivityLevelsSelectCtrl:Awake()
  self.detailDescContent = self._mapNode.detailDescSc:Find("Viewport/Content").transform
  self.curRequireEnergy = 0
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.nLevelType = GameEnum.ActivityLevelType.Explore
  self.tabRewardList = {}
  self.AniRoot = self.gameObject:GetComponent("Animator")
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
  if bInActGroup then
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Explore, {nActGroupId}, self._mapNode.redExplore)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Adventure, {nActGroupId}, self._mapNode.redAdventure)
    RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Hard, {nActGroupId}, self._mapNode.redHard)
  end
end

function ActivityLevelsSelectCtrl:OnEnable()
  self.isOpenLvMsg = false
  self:ShowBossInfo(false, true)
  self.timeTab = {}
  EventManager.Hit(EventId.SetTransition)
  self.SelectTogPreLvLock = nil
  self.AniRoot:Play("ActivityLevelsSelect_in")
  self:Init()
  
  function self.onScrollValueChanged(value)
    self._mapNode.rtTogglesTmp.localPosition = self._mapNode.rt_ToggleTrans.localPosition
  end
  
  self._mapNode.rtToggles.onValueChanged:AddListener(self.onScrollValueChanged)
end

function ActivityLevelsSelectCtrl:OnDisable()
  self.timeTab = {}
  for i = 1, #self.tabRewardList do
    local go = self.tabRewardList[i].gameObject
    local btnSelect = self.tabRewardList[i].gameObject:GetComponent("UIButton")
    btnSelect.onClick:RemoveAllListeners()
    self:UnbindCtrlByNode(self.tabRewardList[i])
    destroy(go)
  end
  self.tabRewardList = {}
  self.SelectTogPreLvLock = nil
  self.SelectObj = nil
  if self.onScrollValueChanged ~= nil then
    self._mapNode.rtToggles.onValueChanged:RemoveListener(self.onScrollValueChanged)
    self.onScrollValueChanged = nil
  end
end

function ActivityLevelsSelectCtrl:OnDestroy(...)
end

function ActivityLevelsSelectCtrl:Init()
  self.activityLevelsData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self:RefreshTogTypeCount()
  self:Refresh()
end

function ActivityLevelsSelectCtrl:Refresh()
  self.nLevelType = self.activityLevelsData:GetDefaultSelectionType()
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
end

function ActivityLevelsSelectCtrl:RefreshTogTypeCount()
  self._mapNode.togTypeExploreCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Explore"))
  self._mapNode.togTypeAdventureCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Adventure"))
  self._mapNode.togTypeHardCtrl:SetText(ConfigTable.GetUIText("ActivityLevels_Hard"))
  self._mapNode.togTypeExploreCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetDefaultActivity(self.nLevelType == GameEnum.ActivityLevelType.HARD)
  local objExploreCert = self._mapNode.togTypeExplore.gameObject.transform:Find("AnimRoot/AnimSwitch/iconCert").gameObject
  local objAdventureCert = self._mapNode.togTypeAdventure.gameObject.transform:Find("AnimRoot/AnimSwitch/iconCert").gameObject
  local objHardCert = self._mapNode.togTypeHard.gameObject.transform:Find("AnimRoot/AnimSwitch/iconCert").gameObject
  self.firstExploreLevel = self.activityLevelsData.levelTabExploreDifficulty[1]
  local isOpenExplore = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Explore, self.firstExploreLevel)
  self._mapNode.lockExplore.gameObject:SetActive(not isOpenExplore)
  self.firstAdventureLevel = self.activityLevelsData.levelTabAdventureDifficulty[1]
  local isOpenAdventure = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Adventure, self.firstAdventureLevel)
  self._mapNode.lockAdventure.gameObject:SetActive(not isOpenAdventure)
  local txt_SelectAdventure = self._mapNode.togTypeAdventure.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_Select").gameObject
  local txt_unSelectAdventure = self._mapNode.togTypeAdventure.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_unSelect").gameObject
  txt_SelectAdventure.transform.localScale = isOpenAdventure == true and Vector3.one or Vector3.zero
  txt_unSelectAdventure.transform.localScale = isOpenAdventure == true and Vector3.one or Vector3.zero
  self.firstHardLevel = self.activityLevelsData.levelTabHardDifficulty[1]
  local isOpenHard = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.HARD, self.firstHardLevel)
  self._mapNode.lockHard.gameObject:SetActive(not isOpenHard)
  local txt_SelectHard = self._mapNode.togTypeHard.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_Select").gameObject
  local txt_unSelectHard = self._mapNode.togTypeHard.gameObject.transform:Find("AnimRoot/AnimSwitch/txt_unSelect").gameObject
  txt_SelectHard.transform.localScale = isOpenHard == true and Vector3.one or Vector3.zero
  txt_unSelectHard.transform.localScale = isOpenHard == true and Vector3.one or Vector3.zero
  objExploreCert:SetActive(true)
  for i, v in pairs(self.activityLevelsData.levelTabExplore) do
    if v.Star < 3 then
      objExploreCert:SetActive(false)
      break
    end
  end
  objAdventureCert:SetActive(true)
  for i, v in pairs(self.activityLevelsData.levelTabAdventure) do
    if v.Star < 3 then
      objAdventureCert:SetActive(false)
      break
    end
  end
  objHardCert:SetActive(true)
  for i, v in pairs(self.activityLevelsData.levelTabHard) do
    if v.Star < 3 then
      objHardCert:SetActive(false)
      break
    end
  end
end

function ActivityLevelsSelectCtrl:OnClick_BtnLockExplore()
  self:FirstLevelLockTips(GameEnum.ActivityLevelType.Explore, self.firstExploreLevel)
end

function ActivityLevelsSelectCtrl:OnClick_BtnLockAdventure()
  self:FirstLevelLockTips(GameEnum.ActivityLevelType.Adventure, self.firstAdventureLevel)
end

function ActivityLevelsSelectCtrl:OnClick_BtnLockHard()
  self:FirstLevelLockTips(GameEnum.ActivityLevelType.HARD, self.firstHardLevel)
end

function ActivityLevelsSelectCtrl:FirstLevelLockTips(nType, nLevel)
  local day = self.activityLevelsData:GetUnLockDay(nType, nLevel)
  local strTips = ""
  if day == 0 then
    local hour, min, sec = self.activityLevelsData:GetUnLockHour(nType, nLevel)
    if 0 < hour then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour"), hour)
    elseif 0 < min then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min"), min)
    elseif 0 < sec then
      strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec"), sec)
    end
  else
    strTips = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_DayOpen"), day)
  end
  EventManager.Hit(EventId.OpenMessageBox, strTips)
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeExplore()
  if self.nLevelType == GameEnum.ActivityLevelType.Explore then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_in1")
  self.nLevelType = GameEnum.ActivityLevelType.Explore
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeAdventure()
  if self.nLevelType == GameEnum.ActivityLevelType.Adventure then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_in1")
  self.nLevelType = GameEnum.ActivityLevelType.Adventure
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
end

function ActivityLevelsSelectCtrl:OnBtnClick_TogTypeHard()
  if self.nLevelType == GameEnum.ActivityLevelType.HARD then
    return
  end
  self:CloseAllTimer()
  self.AniRoot:Play("ActivityLevelsSelect_in1")
  self.nLevelType = GameEnum.ActivityLevelType.HARD
  self:RefreshTogType(self.nLevelType)
  local nDifficulty = self.activityLevelsData:GetDefaultSelectionDifficulty(self.nLevelType)
  self:RefreshTogList(self.nLevelType, nDifficulty)
end

function ActivityLevelsSelectCtrl:CloseAllTimer()
  for i, v in pairs(self.timeTab) do
    v:Pause(true)
  end
  self.timeTab = {}
end

function ActivityLevelsSelectCtrl:RefreshTogType(nType)
  self._mapNode.togTypeExploreCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetTrigger(nType == GameEnum.ActivityLevelType.HARD)
  self._mapNode.togTypeExploreCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.Explore)
  self._mapNode.togTypeAdventureCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.Adventure)
  self._mapNode.togTypeHardCtrl:SetDefaultActivity(nType == GameEnum.ActivityLevelType.HARD)
end

function ActivityLevelsSelectCtrl:RefreshTogList(nType, nDifficulty)
  self.SelectObj = nil
  local tabLevelInfo, tabLevelInfoDifficulty
  self.currentTypeLvCount = 0
  local isOpenAdventure = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.Adventure, self.firstAdventureLevel)
  local isOpenHard = self.activityLevelsData:GetLevelDayOpen(GameEnum.ActivityLevelType.HARD, self.firstHardLevel)
  local tmpImageAdventure = self._mapNode.lockAdventure.gameObject.transform:Find("Image"):GetComponent("Image")
  local tmpImageHard = self._mapNode.lockHard.gameObject.transform:Find("Image"):GetComponent("Image")
  if nType == GameEnum.ActivityLevelType.Explore then
    tabLevelInfo = self.activityLevelsData.levelTabExplore
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabExploreDifficulty
    NovaAPI.SetImageColor(tmpImageAdventure, colorLockUnSelectImage)
    NovaAPI.SetImageColor(tmpImageHard, colorLockUnSelectImage)
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    tabLevelInfo = self.activityLevelsData.levelTabAdventure
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabAdventureDifficulty
    if isOpenAdventure then
      NovaAPI.SetImageColor(tmpImageAdventure, colorLockUnSelectImage)
    else
      NovaAPI.SetImageColor(tmpImageAdventure, colorLockSelectImage)
    end
    NovaAPI.SetImageColor(tmpImageHard, colorLockUnSelectImage)
  else
    tabLevelInfo = self.activityLevelsData.levelTabHard
    tabLevelInfoDifficulty = self.activityLevelsData.levelTabHardDifficulty
    NovaAPI.SetImageColor(tmpImageAdventure, colorLockUnSelectImage)
    if isOpenHard then
      NovaAPI.SetImageColor(tmpImageHard, colorLockUnSelectImage)
    else
      NovaAPI.SetImageColor(tmpImageHard, colorLockSelectImage)
    end
  end
  self.currentTypeLvCount = #tabLevelInfoDifficulty
  self._mapNode.rtToggles.gameObject:SetActive(true)
  local isFour = self.currentTypeLvCount == 4
  if self.isOpenLvMsg == false then
    local tmpPadding = isFour and fourLvGroupPadding or twelveLvGroupPadding
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, tmpPadding[1], tmpPadding[2], tmpPadding[3], tmpPadding[4])
  else
    local tmpPadding = isFour and fourLvGroupPaddingOpen or twelveLvGroupPaddingOpen
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, tmpPadding[1], tmpPadding[2], tmpPadding[3], tmpPadding[4])
  end
  for i = 1, 12 do
    self._mapNode.togRoot[i].gameObject:SetActive(i <= self.currentTypeLvCount)
  end
  for i = 1, self.currentTypeLvCount do
    local tmpId = tabLevelInfoDifficulty[i]
    local tmpData = tabLevelInfo[tmpId]
    local isOpen = self.activityLevelsData:GetLevelDayOpen(nType, tmpData.baseData.Id)
    local isLevelUnLock = self.activityLevelsData:GetLevelUnLock(nType, tmpData.baseData.Id)
    self._mapNode.togRoot[i]:InitData(self, nType, self.activityLevelsData, tmpData, isOpen, isLevelUnLock, self._nSortingOrder)
    if nDifficulty == i then
      if self.isOpenLvMsg then
        self.SelectObj = self._mapNode.togRoot[i]
        self._mapNode.togRoot[i]:SetDefault(true)
        self:RefreshInstanceInfo(nType, nDifficulty, true)
      else
        self._mapNode.togRoot[i]:SetDefault(false)
        
        local function wait()
          LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rt_ToggleTrans.gameObject:GetComponent("RectTransform"))
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          if i < 3 then
            self._mapNode.rt_ToggleTrans.localPosition = Vector3(0, self._mapNode.rt_ToggleTrans.localPosition.y, 0)
          elseif 10 < i then
            self._mapNode.rt_ToggleTrans.localPosition = Vector3(-3060, self._mapNode.rt_ToggleTrans.localPosition.y, 0)
          else
            self._mapNode.rt_ToggleTrans.localPosition = Vector3(-400 * (i - 2), self._mapNode.rt_ToggleTrans.localPosition.y, 0)
          end
        end
        
        cs_coroutine.start(wait)
      end
    else
      self._mapNode.togRoot[i]:SetDefault(false)
    end
  end
end

function ActivityLevelsSelectCtrl:SetSelectObj(tmpSelectObj)
  if self.SelectObj ~= nil then
    self.SelectObj:SetDefault(false)
  end
  self.SelectObj = tmpSelectObj
end

function ActivityLevelsSelectCtrl:OnBtnClick_CloseBossInfo()
  self._mapNode.rtBossAni:Play("rtBoss_out")
  self:AddTimer(1, 0.2, function()
    self:ShowBossInfo(false, false)
  end, true, true, true)
end

function ActivityLevelsSelectCtrl:ShowBossInfo(isShow, isOnEnable)
  self.isOpenLvMsg = isShow
  self._mapNode.rtBoss:SetActive(isShow)
  self._mapNode.btnCloseBg.gameObject:SetActive(isShow)
  if not isShow and self.SelectObj ~= nil then
    self.SelectObj:SetDefault(false)
    self.SelectObj = nil
  end
  if not isShow and not isOnEnable then
    local isFour = self.currentTypeLvCount == 4
    local tmpPadding = isFour and fourLvGroupPadding or twelveLvGroupPadding
    if isFour then
      EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
      local moveTime = 0.2
      local layoutGroup = self._mapNode.rt_Toggle:GetComponent("HorizontalLayoutGroup")
      local startLeft = layoutGroup ~= nil and layoutGroup.padding.left or tmpPadding[1]
      NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, startLeft, fourLvGroupPaddingOpen[2], fourLvGroupPaddingOpen[3], fourLvGroupPaddingOpen[4])
      CS.DG.Tweening.DOVirtual.Float(startLeft, tmpPadding[1], moveTime, function(v)
        NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, math.floor(v), tmpPadding[2], tmpPadding[3], tmpPadding[4])
      end)
    else
      NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, tmpPadding[1], tmpPadding[2], tmpPadding[3], tmpPadding[4])
    end
  end
end

function ActivityLevelsSelectCtrl:RefreshInstanceInfo(nType, nHard, isInit)
  if self.currentTypeLvCount == 12 then
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, twelveLvGroupPaddingOpen[1], twelveLvGroupPaddingOpen[2], twelveLvGroupPaddingOpen[3], twelveLvGroupPaddingOpen[4])
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      local moveTime = isInit and 0.4 or 0.2
      if nHard < 3 then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(0, moveTime)
      elseif 10 <= nHard then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-3060, moveTime)
      else
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-400 * (nHard - 2), moveTime)
      end
    end
    
    cs_coroutine.start(wait)
  elseif self.currentTypeLvCount == 8 then
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, twelveLvGroupPaddingOpen[1], twelveLvGroupPaddingOpen[2], twelveLvGroupPaddingOpen[3], twelveLvGroupPaddingOpen[4])
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      local moveTime = isInit and 0.4 or 0.2
      if nHard < 3 then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(0, moveTime)
      elseif 6 < nHard then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-1620, moveTime)
      else
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-400 * (nHard - 2), moveTime)
      end
    end
    
    cs_coroutine.start(wait)
  else
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      local moveTime = isInit and 0.4 or 0.2
      EventManager.Hit(EventId.TemporaryBlockInput, moveTime)
      local layoutGroup = self._mapNode.rt_Toggle:GetComponent("HorizontalLayoutGroup")
      local startLeft = layoutGroup ~= nil and layoutGroup.padding.left or fourLvGroupPadding[1]
      NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, startLeft, fourLvGroupPaddingOpen[2], fourLvGroupPaddingOpen[3], fourLvGroupPaddingOpen[4])
      CS.DG.Tweening.DOVirtual.Float(startLeft, fourLvGroupPaddingOpen[1], moveTime, function(v)
        NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, math.floor(v), fourLvGroupPaddingOpen[2], fourLvGroupPaddingOpen[3], fourLvGroupPaddingOpen[4])
      end)
      if nHard < 2 then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(0, moveTime)
      elseif 3 <= nHard then
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-180, moveTime)
      else
        self._mapNode.rt_ToggleTrans:DOLocalMoveX(-75 * (nHard - 1), moveTime)
      end
    end
    
    cs_coroutine.start(wait)
  end
  self.curSelectHard = nHard
  local levelId = 0
  self.selectLevelData = nil
  if nType == GameEnum.ActivityLevelType.Explore then
    levelId = self.activityLevelsData.levelTabExploreDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabExplore[levelId]
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    levelId = self.activityLevelsData.levelTabAdventureDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabAdventure[levelId]
  else
    levelId = self.activityLevelsData.levelTabHardDifficulty[nHard]
    self.selectLevelData = self.activityLevelsData.levelTabHard[levelId]
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, self.selectLevelData.baseData.SuggestedPower)
  local sRank = "Icon/BuildRank/BuildRank_" .. self.selectLevelData.baseData.RecommendBuildRank
  self:SetPngSprite(self._mapNode.imgBuild, sRank)
  NovaAPI.SetTMPText(self._mapNode.TMPName, self.selectLevelData.baseData.Name)
  local strTitle = ""
  if nType == GameEnum.ActivityLevelType.Explore then
    strTitle = orderedFormat(lvIndexTitle, 1, self.selectLevelData.baseData.Difficulty)
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    strTitle = orderedFormat(lvIndexTitle, 2, self.selectLevelData.baseData.Difficulty)
  elseif nType == GameEnum.ActivityLevelType.HARD then
    strTitle = orderedFormat(lvIndexTitle, 3, self.selectLevelData.baseData.Difficulty)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPLevel, strTitle)
  NovaAPI.SetTMPText(self._mapNode.detailDesc, self.selectLevelData.baseData.Desc)
  self.detailDescContent:DOLocalMoveY(0, 0)
  self.curStar = self.selectLevelData.Star
  local tbCond = {
    self.selectLevelData.baseData.OneStarDesc,
    self.selectLevelData.baseData.TwoStarDesc,
    self.selectLevelData.baseData.ThreeStarDesc
  }
  for i = 1, 3 do
    local rtTask = self._mapNode.Task[i]
    local goDone = rtTask:Find("imgDone").gameObject
    local imgUnDone = rtTask:Find("imgUnDone").gameObject
    local Text = rtTask:Find("Text"):GetComponent("TMP_Text")
    goDone:SetActive(i <= self.curStar)
    imgUnDone:SetActive(i > self.curStar)
    local cond = tbCond[i]
    if cond == nil then
      rtTask.gameObject:SetActive(false)
      return
    else
      rtTask.gameObject:SetActive(true)
      NovaAPI.SetTMPText(Text, cond)
    end
  end
  self.PreviewMonsterGroupId = self.selectLevelData.baseData.PreviewMonsterGroupId
  local isOpen = self.activityLevelsData:GetLevelDayOpen(nType, self.selectLevelData.baseData.Id)
  local isLevelUnLock = self.activityLevelsData:GetLevelUnLock(nType, self.selectLevelData.baseData.Id)
  local isNeedEnergyConsume = true
  if not self.selectLevelData.baseData.EnergyConsumeOnRetry and 0 < self.selectLevelData.Star then
    isNeedEnergyConsume = false
  end
  if isOpen and isLevelUnLock then
    self._mapNode.btnListRoot:SetActive(true)
    self._mapNode.ListConditions:SetActive(false)
    if self.selectLevelData.baseData.ThreeStarSweep then
      if self.selectLevelData.Star == 3 then
        self._mapNode.btnRaid.gameObject:SetActive(true)
        self._mapNode.btnGo.gameObject:SetActive(true)
        self._mapNode.btnRaidUnlock.gameObject:SetActive(false)
      else
        self._mapNode.btnRaid.gameObject:SetActive(false)
        self._mapNode.btnGo.gameObject:SetActive(false)
        self._mapNode.btnRaidUnlock.gameObject:SetActive(true)
        self._mapNode.grpRaidUnlock:SetActive(true)
      end
    else
      self._mapNode.btnRaid.gameObject:SetActive(false)
      self._mapNode.btnGo.gameObject:SetActive(false)
      self._mapNode.btnRaidUnlock.gameObject:SetActive(true)
      self._mapNode.grpRaidUnlock:SetActive(false)
    end
    local nHas = PlayerData.Base:GetCurEnergy()
    local nRequire = self.selectLevelData.baseData.EnergyConsume
    if not isNeedEnergyConsume then
      nRequire = 0
    end
    self.curRequireEnergy = nRequire
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, nRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
    self._mapNode.goCoin:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCountRaidUnlock, nRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCountRaidUnlock, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
    self._mapNode.goCoinRaidUnlock:SetActive(true)
  elseif isOpen and not isLevelUnLock then
    self._mapNode.btnListRoot:SetActive(false)
    self._mapNode.ListConditions:SetActive(true)
    local preLevelId = self.selectLevelData.baseData.PreLevelId
    if preLevelId ~= 0 then
      local lvPreNeedStar = self.selectLevelData.baseData.PreLevelStar
      local lvPreStar = self.activityLevelsData:GetPreLevelStar(nType, self.selectLevelData.baseData.Id)
      local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      local tmpData = ConfigTable.GetData("ActivityLevelsLevel", preLevelId)
      imgConditions_Lock_1:SetActive(lvPreNeedStar > lvPreStar)
      imgConditions_UnLock_1:SetActive(lvPreNeedStar <= lvPreStar)
      NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_PreLevel"), tmpData.Name))
      NovaAPI.SetTMPColor(txt, lvPreNeedStar <= lvPreStar and colorConditionsUnLock or colorConditionsLock)
    else
      local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      imgConditions_Lock_1:SetActive(true)
      imgConditions_UnLock_1:SetActive(false)
      NovaAPI.SetTMPText(txt, ConfigTable.GetUIText("Unlocked_By_PreLevel"))
      NovaAPI.SetTMPColor(txt, colorConditionsUnLock)
    end
    local preActivityStory = self.selectLevelData.baseData.PreActivityStory
    if preActivityStory ~= nil and preActivityStory[1] ~= nil then
      local isRead = PlayerData.ActivityAvg:IsStoryReaded(preActivityStory[2])
      local imgConditions_Lock_2 = self._mapNode.ListConditionsObj[2].transform:Find("imgConditions_Lock").gameObject
      local imgConditions_UnLock_2 = self._mapNode.ListConditionsObj[2].transform:Find("imgConditions_UnLock").gameObject
      local txt = self._mapNode.ListConditionsObj[2].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
      imgConditions_Lock_2:SetActive(not isRead)
      imgConditions_UnLock_2:SetActive(isRead)
      local cfgdata = ConfigTable.GetData("ActivityStory", preActivityStory[2])
      if cfgdata ~= nil then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Avg"), cfgdata.Title))
        self._mapNode.ListConditionsObj[2]:SetActive(true)
        NovaAPI.SetTMPColor(txt, isRead and colorConditionsUnLock or colorConditionsLock)
      else
        self._mapNode.ListConditionsObj[2]:SetActive(false)
      end
    else
      self._mapNode.ListConditionsObj[2]:SetActive(false)
    end
  elseif not isOpen then
    self._mapNode.btnListRoot:SetActive(false)
    self._mapNode.ListConditions:SetActive(true)
    self._mapNode.ListConditionsObj[2]:SetActive(false)
    local imgConditions_Lock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_1 = self._mapNode.ListConditionsObj[1].transform:Find("imgConditions_UnLock").gameObject
    imgConditions_Lock_1:SetActive(true)
    imgConditions_UnLock_1:SetActive(false)
    NovaAPI.SetTMPColor(txt, colorConditionsUnLock)
    local txt = self._mapNode.ListConditionsObj[1].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    local day = self.activityLevelsData:GetUnLockDay(nType, self.selectLevelData.baseData.Id)
    if day == 0 then
      local hour, min, sec = self.activityLevelsData:GetUnLockHour(nType, self.selectLevelData.baseData.Id)
      if 0 < hour then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour"), hour))
      elseif 0 < min then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min"), min))
      elseif 0 < sec then
        NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min"), min))
      end
    else
      local _day, _hour = self.activityLevelsData:GetUnLockDayHour(nType, self.selectLevelData.baseData.Id)
      NovaAPI.SetTMPText(txt, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_DayHourOpen"), _day, _hour))
    end
  end
  for i = 1, #self.tabRewardList do
    self.tabRewardList[i].gameObject:SetActive(false)
  end
  local tbReward = decodeJson(self.selectLevelData.baseData.CompleteRewardPreview)
  self._mapNode.btn_itemTemp.gameObject:SetActive(false)
  for i = 1, #tbReward do
    if i > #self.tabRewardList then
      local obj = instantiate(self._mapNode.btn_itemTemp, self._mapNode.rewardRoot)
      self.tabRewardList[i] = self:BindCtrlByNode(obj, "Game.UI.TemplateEx.TemplateItemCtrl")
    end
    local itemCtrl = self.tabRewardList[i]
    itemCtrl.gameObject:SetActive(true)
    if tbReward[i] ~= nil then
      local bReceived = 0 < self.selectLevelData.Star and tbReward[i][3] == 1
      local bFirstPass = tbReward[i][3] == 1
      itemCtrl:SetItem(tbReward[i][1], nil, UTILS.ParseRewardItemCount(tbReward[i]), nil, bReceived, bFirstPass, false, true)
      local btnItem = itemCtrl.gameObject:GetComponent("UIButton")
      btnItem.onClick:RemoveAllListeners()
      
      local function clickCb()
        self:OnBtnClick_RewardItem(tbReward[i][1], btnItem.gameObject)
      end
      
      btnItem.onClick:AddListener(clickCb)
    end
  end
  if self._mapNode.rtBoss.activeSelf == false then
    self:ShowBossInfo(true, false)
    self:AddTimer(1, 0.2, function()
      self._mapNode.rtBossAni:Play("rtBoss_in")
    end, true, true, true)
  else
    self._mapNode.rtBossAni:Play("rtBoss_Empty")
    self:AddTimer(1, 0.1, function()
      self._mapNode.rtBossAni:Play("rtBoss_in")
    end, true, true, true)
  end
end

function ActivityLevelsSelectCtrl:OnBtnClick_RewardItem(nTid, btn)
  local rtBtn = btn.transform
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function ActivityLevelsSelectCtrl:OnClickBtnGo()
  local nEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  if nEnergy < self.curRequireEnergy then
    local function callback()
      EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
    return
  end
  if self.SelectObj ~= nil then
    self.SelectObj:ShowArrowAni(true)
  end
  self:AddTimer(1, 0.2, function()
    self.activityLevelsData:ChangeRedDot(self.selectLevelData.baseData.Type, self.selectLevelData.baseData.Id)
    PlayerData.Activity:SetActivityLevelActId(self.nActId)
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityLevels, self.selectLevelData.baseData.Id, {
      self.nActId
    })
  end, true, true, true)
end

function ActivityLevelsSelectCtrl:OnClickBtnRaid()
  if self.curStar ~= 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  if self.SelectObj ~= nil then
    self.SelectObj:ShowArrowAni(true)
  end
  self:AddTimer(1, 0.2, function()
    local nNeedEnergy = self.curRequireEnergy
    EventManager.Hit(EventId.OpenPanel, PanelId.Raid, self.selectLevelData.baseData.Id, nNeedEnergy, 0, self.nActId)
  end, true, true, true)
end

function ActivityLevelsSelectCtrl:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.Raid and self.SelectObj ~= nil then
    self.SelectObj:ShowArrowAni(false)
  end
end

function ActivityLevelsSelectCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenActivityLevelsMonsterInfo", self.PreviewMonsterGroupId)
end

function ActivityLevelsSelectCtrl:OnEvent_UpdateEnergy()
  local nHas = PlayerData.Base:GetCurEnergy()
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nHas.nEnergy < self.curRequireEnergy and Red_Unable or Blue_Normal)
  NovaAPI.SetTMPColor(self._mapNode.txtTicketsCountRaidUnlock, nHas.nEnergy < self.curRequireEnergy and Red_Unable or Blue_Normal)
end

return ActivityLevelsSelectCtrl
