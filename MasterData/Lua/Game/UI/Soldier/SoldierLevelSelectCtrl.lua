local SoldierLevelSelectCtrl = class("SoldierLevelSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
SoldierLevelSelectCtrl._mapNodeConfig = {
  topbar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  ScrollView = {
    sComponentName = "LoopScrollView"
  },
  snapScrollView = {
    sNodeName = "ScrollView",
    sComponentName = "LoopScrollSnap",
    callback = "OnGridSelect_Center"
  },
  rtGridTest = {
    sComponentName = "RectTransform"
  },
  txtTestDesc = {nCount = 2, sComponentName = "TMP_Text"},
  txt_Experience = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_Experience"
  },
  txt_ExperienceNum = {sComponentName = "TMP_Text"},
  txt_Tech = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_Tech"
  },
  txt_TechNum = {sComponentName = "TMP_Text"},
  btnSearch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Search"
  },
  btnRewardWindow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardWindow"
  },
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_RewardTitle"
  },
  txt_TechTree = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_TechTree"
  },
  btn_BackToHighest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BackToHighest"
  },
  txt_Back = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_BackToHighest"
  },
  btn_Start = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txt_Start = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_Start"
  },
  txtRankDifficulty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_RankDifficulty"
  },
  txtPhaseTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_PhaseTitle"
  },
  txtPhaseLevel = {sComponentName = "TMP_Text"},
  txtEnemyDifficulty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_EnemyDifficulty"
  },
  txtEnemyDifficultyNum = {sComponentName = "TMP_Text"},
  rtRankRewardPopup = {},
  goRewardWindow = {},
  goBlurRankReward = {},
  animRewardWindow = {
    sNodeName = "goRewardWindow",
    sComponentName = "Animator"
  },
  btnRewardCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseRewardPopup"
  },
  btnRankRewardClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseRewardPopup"
  },
  txtRankReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_RankReward"
  },
  txtCurRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_CurRank"
  },
  txtRankName = {sComponentName = "TMP_Text"},
  txtRankLevel = {sComponentName = "TMP_Text"},
  txtExpReward = {sComponentName = "TMP_Text"},
  txtExpRewardDetail = {sComponentName = "TMP_Text"},
  txtTechReward = {sComponentName = "TMP_Text"},
  txtTechRewardDetail = {sComponentName = "TMP_Text"}
}
SoldierLevelSelectCtrl._mapEventConfig = {}
SoldierLevelSelectCtrl._mapRedDotConfig = {}

function SoldierLevelSelectCtrl:Awake()
end

function SoldierLevelSelectCtrl:OnEnable()
  self._mapNode.rtRankRewardPopup.gameObject:SetActive(false)
  self:RefreshGradeChallenge()
end

function SoldierLevelSelectCtrl:OnDisable()
  for k, v in pairs(self.tbGridCtrl or {}) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  self.tbGridCtrl = nil
end

function SoldierLevelSelectCtrl:RefreshGradeChallenge()
  if self.tbGradeChallenge == nil or self.tbGridHeight == nil then
    self.tbGradeChallenge = {}
    ForEachTableLine(DataTable.SoldierGradeChallenge, function(mapLineData)
      table.insert(self.tbGradeChallenge, mapLineData)
    end)
    table.sort(self.tbGradeChallenge, function(a, b)
      return a.Id > b.Id
    end)
    self.tbGridHeight = {}
    for _, v in ipairs(self.tbGradeChallenge) do
      local sText = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_InitialHp"), v.InitialHp)
      NovaAPI.SetTMPText(self._mapNode.txtTestDesc[1], sText)
      local sOppoAttrAddShow = math.floor(tonumber(v.OppoAttrAddShow) * 100) .. "%"
      sText = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_OppoAttrAddShow"), sOppoAttrAddShow)
      NovaAPI.SetTMPText(self._mapNode.txtTestDesc[2], sText)
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtGridTest)
      local nHeight = self._mapNode.rtGridTest.sizeDelta.y
      table.insert(self.tbGridHeight, nHeight)
    end
  end
  self.nHighestChallengeId = PlayerData.SoldierData:GetHighestChallengeId()
  self.nSelectedChallenge = self.nHighestChallengeId
  self.curChallengeData = ConfigTable.GetData("SoldierGradeChallenge", self.nHighestChallengeId)
  self.nCenterGridIndex = nil
  self.tbUnlock = {}
  self._mapNode.ScrollView:InitEx(self.tbGridHeight, self, self.OnGridRefresh, self.OnGridBtnClick, false)
  self:ScrollToHighest(0)
  self._mapNode.ScrollView:ForceRefresh()
end

function SoldierLevelSelectCtrl:OnGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local mapData = self.tbGradeChallenge[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if self.tbGridCtrl == nil then
    self.tbGridCtrl = {}
  end
  if self.tbGridCtrl[nInstanceId] == nil then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.SoldierLevelSelectItemCtrl")
  end
  local bUnlock = self.nHighestChallengeId >= mapData.Id
  self.tbUnlock[mapData.Id] = bUnlock
  self.tbGridCtrl[nInstanceId]:SetData(mapData, bUnlock)
  if self.nHighestChallengeId == mapData.Id then
    self.nAutoSelectIndex = nGridIndex
  end
  self.tbGridCtrl[nInstanceId]:SetSelect(nGridIndex == self.nCenterGridIndex)
  if nGridIndex == self.nCenterGridIndex then
    self.nSelectedChallenge = self.tbGridCtrl[nInstanceId]:GetChallengeId()
  end
end

function SoldierLevelSelectCtrl:OnGridSelect_Center(_, goGrid)
  local nGridIndex = tonumber(goGrid.name)
  if nGridIndex == nil or self.nCenterGridIndex == nGridIndex then
    return
  end
  self.nCenterGridIndex = nGridIndex
  for _, objGridCtrl in pairs(self.tbGridCtrl or {}) do
    local goGridObj = objGridCtrl.gameObject
    if goGridObj ~= nil then
      objGridCtrl:SetSelect(tonumber(goGridObj.name) == nGridIndex)
    end
  end
  local nNewChallengeId = self.tbGridCtrl[goGrid:GetInstanceID()]:GetChallengeId()
  self.nSelectedChallenge = nNewChallengeId and nNewChallengeId or self.nSelectedChallenge
  self._mapNode.btn_BackToHighest.gameObject:SetActive(self.nSelectedChallenge ~= self.nHighestChallengeId)
  local mapGrade = ConfigTable.GetData("SoldierGradeChallenge", self.nSelectedChallenge)
  if mapGrade ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txt_ExperienceNum, "+" .. mapGrade.Score)
    NovaAPI.SetTMPText(self._mapNode.txt_TechNum, "+" .. mapGrade.TechPoint)
  end
  WwiseAudioMgr:PostEvent("mode_900001_chess_rankLevel_drag")
end

function SoldierLevelSelectCtrl:RefreshRewardWindow()
  local mapCurGrade = ConfigTable.GetData("SoldierGradeChallenge", self.nSelectedChallenge)
  if mapCurGrade == nil then
    return
  end
  local sExpNum = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_ExpRewardNum"), mapCurGrade.Score)
  NovaAPI.SetTMPText(self._mapNode.txtExpReward, sExpNum)
  local sExpDetail = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_ExpRewardDesc"), mapCurGrade.Score)
  NovaAPI.SetTMPText(self._mapNode.txtExpRewardDetail, sExpDetail)
  local sTechNum = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_TechRewardNum"), mapCurGrade.TechPoint)
  NovaAPI.SetTMPText(self._mapNode.txtTechReward, sTechNum)
  local sTechDetail = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_TechRewardDesc"), mapCurGrade.TechPoint)
  NovaAPI.SetTMPText(self._mapNode.txtTechRewardDetail, sTechDetail)
  NovaAPI.SetTMPText(self._mapNode.txtRankLevel, mapCurGrade.Name)
  local mapKeyGrade = ConfigTable.GetData("SoldierKeyGrade", mapCurGrade.KeyGradeId)
  if mapKeyGrade ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtRankName, mapKeyGrade.Name)
  end
end

function SoldierLevelSelectCtrl:ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierLevelSelectPanel)
end

function SoldierLevelSelectCtrl:OnBtnClick_Challenge(nIndex)
  self:EnterSoldier(nIndex)
end

function SoldierLevelSelectCtrl:OnBtnClick_Continue(nIndex)
  self:EnterSoldier(nIndex)
end

function SoldierLevelSelectCtrl:OnBtnClick_Search()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierTechPreviewPanel)
end

function SoldierLevelSelectCtrl:OnBtnClick_RewardWindow()
  self._mapNode.rtRankRewardPopup.gameObject:SetActive(true)
  self._mapNode.goRewardWindow.gameObject:SetActive(false)
  self._mapNode.goBlurRankReward.gameObject:SetActive(false)
  self:RefreshRewardWindow()
  
  local function wait()
    self._mapNode.goBlurRankReward.gameObject:SetActive(true)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRewardWindow.gameObject:SetActive(true)
    self._mapNode.animRewardWindow:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
end

function SoldierLevelSelectCtrl:OnBtnClick_CloseRewardPopup()
  self._mapNode.animRewardWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.rtRankRewardPopup.gameObject:SetActive(false)
  end, true, true, true)
end

function SoldierLevelSelectCtrl:OnBtnClick_BackToHighest()
  self:ScrollToHighest(0.25)
end

function SoldierLevelSelectCtrl:ScrollToHighest(nTime)
  if self.tbGradeChallenge == nil or self.tbGridHeight == nil then
    return
  end
  self.nHighestChallengeId = PlayerData.SoldierData:GetHighestChallengeId()
  local nTargetIndex = 0
  for k, v in pairs(self.tbGradeChallenge) do
    if v.Id == self.nHighestChallengeId then
      nTargetIndex = k
      break
    end
  end
  if nTargetIndex == 0 then
    return
  end
  if 0 < nTime then
    WwiseAudioMgr:PostEvent("mode_900001_chess_rankLevel")
    self:AddTimer(1, nTime, function()
      WwiseAudioMgr:PostEvent("mode_900001_chess_rankLevel_stop")
    end, true, true, true)
  end
  self._mapNode.ScrollView:SetScrollGridPosEx(self.tbGridHeight, nTargetIndex, nTime, 0)
end

function SoldierLevelSelectCtrl:OnBtnClick_Start()
  local function callback()
    self:ClosePanel()
  end
  
  if not self.tbUnlock[self.nSelectedChallenge] then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_LevelSelect_Locked"))
    return
  end
  PlayerData.SoldierData:EnterSoldier(self.nSelectedChallenge, callback)
end

return SoldierLevelSelectCtrl
