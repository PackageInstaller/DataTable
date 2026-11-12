local JointDrillRankingCtrl = class("JointDrillRankingCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillRankingCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goLoading = {},
  txtLoading = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Loading"
  },
  goMainContent = {},
  txtRankEndTime = {sComponentName = "TMP_Text"},
  txtRewardTime = {sComponentName = "TMP_Text"},
  txtRefreshTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Refresh_Tip"
  },
  svRankingInfo = {
    sComponentName = "LoopScrollView"
  },
  txtRankingListRankTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Title_Ranking"
  },
  txtRankingListPlayerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Title_Name"
  },
  txtRankingListScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Title_Score"
  },
  txtRankingListDetailTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Title_Detail"
  },
  txtRankingListBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Title_Build"
  },
  rtSelfRank = {
    sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillRankItemCtrl"
  },
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  txtBtnReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Reward_Btn"
  },
  goRewardView = {},
  goBlurBg = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  btnRewardClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseReward"
  },
  animWindow = {
    sNodeName = "t_window_04",
    sComponentName = "Animator"
  },
  txt_Reward_Title = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Ranking_Reward"
  },
  svRankingReward = {
    sComponentName = "LoopScrollView"
  },
  txtRankTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Refresh_Tip"
  },
  btnCloseReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseReward"
  }
}
JointDrillRankingCtrl._mapEventConfig = {
  ShowTeamDetail = "OnEvent_ShowTeamDetail",
  OpenRankBuildDetail = "OnEvent_OpenRankBuildDetail"
}
JointDrillRankingCtrl._mapRedDotConfig = {}

function JointDrillRankingCtrl:SetEndTime()
  local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if actData ~= nil then
    local nEndTime = actData:GetActEndTime()
    local nThresholdTime = ConfigTable.GetConfigValue("SeasonEndThreshold")
    nEndTime = nEndTime - nThresholdTime
    local sTime = os.date("%m/%d %H:%M", nEndTime)
    NovaAPI.SetTMPText(self._mapNode.txtRankEndTime, orderedFormat(ConfigTable.GetUIText("JointDrill_Rank_Refresh_Time"), sTime))
  end
end

function JointDrillRankingCtrl:InitRankReward()
  for _, v in pairs(self.tbRankRewardGridCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbRankRewardGridCtrl = {}
  local nRankCount = PlayerData.JointDrill_1:GetRankRewardCount()
  local nTotalRankCount = PlayerData.JointDrill_1:GetTotalRankCount()
  local mapSelfRank = PlayerData.JointDrill_1:GetSelfRankData()
  local nSelfRank = 0
  if mapSelfRank ~= nil and 0 < mapSelfRank.Rank then
    nSelfRank = mapSelfRank.Rank
  end
  self.nRankSection = 0
  if nTotalRankCount ~= 0 then
    nTotalRankCount = math.max(nTotalRankCount, 100)
    self.nRankSection = nSelfRank / nTotalRankCount
  end
  self._mapNode.svRankingReward:Init(nRankCount, self, self.RefreshRankRewardGrid)
end

function JointDrillRankingCtrl:RefreshRankRewardGrid(goGrid, goGridIndex)
  local nIndex = goGridIndex + 1
  if self.tbRankRewardGridCtrl[goGrid] == nil then
    self.tbRankRewardGridCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.JointDrill.JointDrill_1.JointDrillRankRewardItemCtrl")
  end
  self.tbRankRewardGridCtrl[goGrid]:RefreshItem(nIndex, self.nRankSection)
end

function JointDrillRankingCtrl:RefreshRankList()
  self.mapRankList = PlayerData.JointDrill_1:GetRankList()
  for _, v in ipairs(self.tbRankGridCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbRankGridCtrl = {}
  if self.mapRankList == nil or #self.mapRankList == 0 then
    self._mapNode.goLoading.gameObject:SetActive(true)
    self._mapNode.goMainContent.gameObject:SetActive(false)
  else
    self._mapNode.goLoading.gameObject:SetActive(false)
    self._mapNode.goMainContent.gameObject:SetActive(true)
    if self._panel.mapRankDetail == nil then
      self._mapNode.svRankingInfo:SetAnim(0.1)
    end
    self._mapNode.svRankingInfo:Init(#self.mapRankList, self, self.RefreshRankGrid)
    if self._panel.mapRankDetail ~= nil then
      self._mapNode.svRankingInfo:SetScrollPos(self._panel.nGridPos)
      self:AddTimer(1, 0.4, function()
        EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "RankDetail"), self._panel.mapRankDetail)
        self._panel.mapRankDetail = nil
        self._panel.nGridPos = 0
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
    end
  end
end

function JointDrillRankingCtrl:RefreshSelfRank()
  local mapSelfRank = PlayerData.JointDrill_1:GetSelfRankData()
  self._mapNode.rtSelfRank:RefreshSelfRank(mapSelfRank)
end

function JointDrillRankingCtrl:RefreshRankGrid(goGrid, goGridIndex)
  local nIndex = goGridIndex + 1
  if self.tbRankGridCtrl[goGrid] == nil then
    local itemCtrl = self:BindCtrlByNode(goGrid, "Game.UI.JointDrill.JointDrill_1.JointDrillRankItemCtrl")
    self.tbRankGridCtrl[goGrid] = itemCtrl
  end
  local mapRank = self.mapRankList[nIndex]
  self.tbRankGridCtrl[goGrid]:RefreshRankItem(mapRank)
end

function JointDrillRankingCtrl:Awake()
end

function JointDrillRankingCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self.nActId = tbParam[1]
  end
  self.tbRankGridCtrl = {}
  self.tbRankRewardGridCtrl = {}
  self._mapNode.goRewardView.gameObject:SetActive(false)
  self._mapNode.goMainContent.gameObject:SetActive(true)
  self:RefreshRankList()
  self:RefreshSelfRank()
  self:SetEndTime()
  self:InitRankReward()
end

function JointDrillRankingCtrl:OnDisable()
  for _, v in pairs(self.tbRankGridCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbRankGridCtrl = {}
  for _, v in pairs(self.tbRankRewardGridCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbRankRewardGridCtrl = {}
end

function JointDrillRankingCtrl:OnDestroy()
end

function JointDrillRankingCtrl:OnRelease()
end

function JointDrillRankingCtrl:OnBtnClick_Reward()
  self._mapNode.animWindow.gameObject:SetActive(false)
  self._mapNode.goBlurBg.gameObject:SetActive(true)
  self._mapNode.goRewardView.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.animWindow.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
end

function JointDrillRankingCtrl:OnBtnClick_CloseReward()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  
  local function close()
    self._mapNode.animWindow.gameObject:SetActive(false)
    self._mapNode.goRewardView.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.2, close, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function JointDrillRankingCtrl:OnEvent_ShowTeamDetail(rankData)
  self.mapRankDetail = rankData
end

function JointDrillRankingCtrl:OnEvent_OpenRankBuildDetail()
  self._panel.mapRankDetail = self.mapRankDetail
  self._panel.nGridPos = self._mapNode.svRankingInfo:GetScrollPos()
end

return JointDrillRankingCtrl
