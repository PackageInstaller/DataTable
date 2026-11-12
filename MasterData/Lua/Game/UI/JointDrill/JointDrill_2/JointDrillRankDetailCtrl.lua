local JointDrillRankDetailCtrl = class("JointDrillRankDetailCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillRankDetailCtrl._mapNodeConfig = {
  goBlurBg = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  btnCloseBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  animWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Detail_Title"
  },
  txtDiffCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Difficulty"
  },
  txtDiff = {sComponentName = "TMP_Text"},
  txtBattleCountCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Battle_Count"
  },
  txtBattleCount = {sComponentName = "TMP_Text"},
  txtTimeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Battle_Time"
  },
  txtTime = {sComponentName = "TMP_Text"},
  teamLSV = {
    sComponentName = "LoopScrollView"
  }
}
JointDrillRankDetailCtrl._mapEventConfig = {}
JointDrillRankDetailCtrl._mapRedDotConfig = {}

function JointDrillRankDetailCtrl:RefreshRankData(mapRank)
  local nBattleCount = #mapRank.Teams
  NovaAPI.SetTMPText(self._mapNode.txtBattleCount, nBattleCount)
  local nTotalTime = 0
  self.tbTeams = mapRank.Teams
  for _, v in ipairs(mapRank.Teams) do
    nTotalTime = nTotalTime + v.Time
  end
  local nMin = math.floor(nTotalTime / 60000)
  local nRemain = nTotalTime % 60000
  local nSec = math.floor(nRemain / 1000)
  local nMs = nTotalTime % 1000
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d:%03d", nMin, nSec, nMs))
  self:RefreshTeamList()
end

function JointDrillRankDetailCtrl:RefreshTeamList()
  for _, v in pairs(self.tbTeamGridCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbTeamGridCtrl = {}
  self._mapNode.teamLSV:Init(#self.tbTeams, self, self.RefreshGrid)
end

function JointDrillRankDetailCtrl:RefreshGrid(goGrid, goGridIndex)
  local nIndex = goGridIndex + 1
  if self.tbTeamGridCtrl[goGrid] == nil then
    self.tbTeamGridCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.JointDrill.JointDrill_2.JointDrillTeamItemCtrl")
  end
  local mapTeam = self.tbTeams[nIndex]
  self.tbTeamGridCtrl[goGrid]:RefreshItem(mapTeam, nIndex)
end

function JointDrillRankDetailCtrl:Awake()
end

function JointDrillRankDetailCtrl:OnEnable()
  self.tbTeamGridCtrl = {}
  self._mapNode.animWindow.gameObject:SetActive(false)
  self._mapNode.goBlurBg:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.animWindow.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    local tbParam = self:GetPanelParam()
    if 0 < #tbParam then
      local mapRank = tbParam[1]
      self:RefreshRankData(mapRank)
    end
  end
  
  cs_coroutine.start(wait)
end

function JointDrillRankDetailCtrl:OnDisable()
  for _, v in pairs(self.tbTeamGridCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbTeamGridCtrl = {}
end

function JointDrillRankDetailCtrl:OnDestroy()
end

function JointDrillRankDetailCtrl:OnRelease()
end

function JointDrillRankDetailCtrl:OnBtnClick_Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  self._mapNode.goBlurBg:SetActive(false)
  
  local function callback()
    EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_2.nActId, "RankDetail"))
  end
  
  self:AddTimer(1, 0.3, callback, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

return JointDrillRankDetailCtrl
