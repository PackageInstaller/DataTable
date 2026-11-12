local JointDrillQuestCtrl = class("JointDrillQuestCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillQuestCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  btnBgClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Reward_Window_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  txtLeft = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Score_Reward",
    nCount = 2
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  txtRight = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Ranking_Reward",
    nCount = 2
  },
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  goScore = {},
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Week_Score_All"
  },
  txtWeekScore = {sComponentName = "TMP_Text"},
  questLSV = {
    sComponentName = "LoopScrollView"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Quest_Receive_All"
  },
  goRankReward = {},
  rankingRewardLSV = {
    sComponentName = "LoopScrollView"
  },
  txtRankTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Refresh_Tip"
  }
}
JointDrillQuestCtrl._mapEventConfig = {}
JointDrillQuestCtrl._mapRedDotConfig = {}
local tab_score = 1
local tab_ranking = 2

function JointDrillQuestCtrl:Refresh()
  self._mapNode.imgOn[1].gameObject:SetActive(self.nSelectTab == tab_score)
  self._mapNode.imgOn[2].gameObject:SetActive(self.nSelectTab == tab_ranking)
  self._mapNode.imgOff[1].gameObject:SetActive(self.nSelectTab == tab_ranking)
  self._mapNode.imgOff[2].gameObject:SetActive(self.nSelectTab == tab_score)
  self._mapNode.goScore.gameObject:SetActive(self.nSelectTab == tab_score)
  self._mapNode.goRankReward.gameObject:SetActive(self.nSelectTab == tab_ranking)
  if self.nSelectTab == tab_score then
    self:RefreshQuest()
  else
    self:RefreshRanking()
  end
end

function JointDrillQuestCtrl:RefreshQuest()
  for goGrid, objCtrl in pairs(self.mapQuestGrid) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapQuestGrid[goGrid] = nil
  end
  local actDataIns = PlayerData.Activity:GetActivityDataById(self.nActId)
  if actDataIns == nil then
    return
  end
  self.actDataIns = actDataIns
  self.tbQuests = actDataIns:GetRewardQuestList()
  self._mapNode.questLSV:Init(#self.tbQuests, self, self.RefreshQuestGrid)
  local nTotalScore = PlayerData.JointDrill_1:GetTotalRankScore()
  NovaAPI.SetTMPText(self._mapNode.txtWeekScore, FormatWithCommas(nTotalScore))
end

function JointDrillQuestCtrl:RefreshQuestGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.mapQuestGrid[goGrid] == nil then
    self.mapQuestGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.JointDrill.JointDrill_1.JointDrillQuestItemCtrl")
  end
  local mapQuest = self.tbQuests[nIndex]
  self.mapQuestGrid[goGrid]:SetItem(mapQuest)
end

function JointDrillQuestCtrl:RefreshRanking()
  for goGrid, objCtrl in pairs(self.mapRankingGrid) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapRankingGrid[goGrid] = nil
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
  self._mapNode.rankingRewardLSV:Init(nRankCount, self, self.RefreshRankingGrid)
end

function JointDrillQuestCtrl:RefreshRankingGrid(goGrid, goGridIndex)
  local nIndex = goGridIndex + 1
  if self.tbRankRewardGridCtrl[goGrid] == nil then
    self.tbRankRewardGridCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.JointDrill.JointDrill_1.JointDrillRankRewardItemCtrl")
  end
  self.tbRankRewardGridCtrl[goGrid]:RefreshItem(nIndex, self.nRankSection)
end

function JointDrillQuestCtrl:PlayCloseAni(callback)
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, callback)
end

function JointDrillQuestCtrl:OnPanelClose(_, callback)
  EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(self.nActId, "Quest"))
  if callback then
    callback()
  end
end

function JointDrillQuestCtrl:Awake()
  self.nActId = 0
  self.mapQuestGrid = {}
  self.mapRankingGrid = {}
  self.tbQuests = {}
end

function JointDrillQuestCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self.nActId = tbParam[1]
  end
  self.nSelectTab = tab_score
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  self:Refresh()
end

function JointDrillQuestCtrl:OnDisable()
  for goGrid, objCtrl in pairs(self.mapQuestGrid) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapQuestGrid[goGrid] = nil
  end
  self.mapQuestGrid = {}
  for goGrid, objCtrl in pairs(self.mapRankingGrid) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapRankingGrid[goGrid] = nil
  end
  self.mapRankingGrid = {}
end

function JointDrillQuestCtrl:OnDestroy()
end

function JointDrillQuestCtrl:OnBtnClick_Close()
  self:PlayCloseAni()
end

function JointDrillQuestCtrl:OnBtnClick_Receive()
  local bReceive = false
  for _, v in ipairs(self.tbQuests) do
    if v.Status == 1 then
      bReceive = true
      break
    end
  end
  if not bReceive then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Receive_Quest_Reward_Tip"))
    return
  end
  
  local function callback()
    self:Refresh()
  end
  
  self.actDataIns:SendReceiveQuestReward(callback)
end

function JointDrillQuestCtrl:OnBtnClick_Left()
  self.nSelectTab = tab_score
  self:Refresh()
end

function JointDrillQuestCtrl:OnBtnClick_Right()
  self.nSelectTab = tab_ranking
  self:Refresh()
end

return JointDrillQuestCtrl
