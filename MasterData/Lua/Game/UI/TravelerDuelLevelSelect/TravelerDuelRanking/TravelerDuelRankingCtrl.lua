local TravelerDuelRankingCtrl = class("TravelerDuelRankingCtrl", BaseCtrl)
TravelerDuelRankingCtrl._mapNodeConfig = {
  TMPEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_PlayerInfo_Empty"
  },
  rtPlayerInfo = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRankingPlayerInfoCtrl"
  },
  svRankingInfo = {
    sComponentName = "LoopScrollView"
  },
  imgEmpty = {},
  svRankingReward = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtRankingInfo = {},
  rtRankingReward = {},
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_right"
  },
  tcTab = {
    sCtrlName = "Game.UI.TemplateEx.TemplateTogTabCtrl"
  },
  t_window = {sComponentName = "Animator"},
  t_fullscreen_blur_black = {sComponentName = "Animator"},
  txtLeft = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Ranking_Info"
  },
  txtRight = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Ranking_Reward"
  },
  txtRefreshTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Refresh_Tips"
  }
}
TravelerDuelRankingCtrl._mapEventConfig = {}
TravelerDuelRankingCtrl._mapRedDotConfig = {}

function TravelerDuelRankingCtrl:Awake()
  self._mapRankingGrid = {}
  self._mapRewardGrid = {}
end

function TravelerDuelRankingCtrl:FadeIn()
end

function TravelerDuelRankingCtrl:FadeOut()
end

function TravelerDuelRankingCtrl:OnEnable()
  self._mapNode.tcTab:SetText("排行奖励", "排行信息")
  if self.bOpenPanel then
    self:OpenPanel()
  end
end

function TravelerDuelRankingCtrl:OnDisable()
  for go, mapCtrl in pairs(self._mapRankingGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  for go, mapCtrl in pairs(self._mapRewardGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapRankingGrid = {}
  self._mapRewardGrid = {}
end

function TravelerDuelRankingCtrl:OnDestroy()
end

function TravelerDuelRankingCtrl:OnRelease()
end

function TravelerDuelRankingCtrl:OpenPanel()
  self.gameObject:SetActive(true)
  self._mapNode.t_window:Play("t_window_04_t_in")
  local mapSelfRankingData, mapRankingData = PlayerData.TravelerDuel:GetTDRankingData()
  self.mapRankingData = mapRankingData
  self.mapSelfRankingData = mapSelfRankingData
  self._mapNode.rtPlayerInfo:Refresh(mapSelfRankingData)
  if #self.mapRankingData > 0 then
    self._mapNode.svRankingInfo.gameObject:SetActive(true)
    self._mapNode.svRankingInfo:Init(#self.mapRankingData, self, self.OnGridRankingRefresh)
    self._mapNode.imgEmpty:SetActive(false)
  else
    self._mapNode.svRankingInfo.gameObject:SetActive(false)
    self._mapNode.imgEmpty:SetActive(true)
  end
  self._mapNode.svRankingReward:Init(4, self, self.OnGridRankingRewardRefresh)
  if not self.bOpenPanel then
    self._mapNode.tcTab:SetState(false)
    self._mapNode.rtRankingInfo:SetActive(true)
    self._mapNode.rtRankingReward:SetActive(false)
    self.bOpenPanel = true
  end
end

function TravelerDuelRankingCtrl:OnBtnClick_Close()
  self._mapNode.t_window:Play("t_window_04_t_out")
  self._mapNode.t_fullscreen_blur_black:SetTrigger("tOut")
  
  local function close()
    self.gameObject:SetActive(false)
    self.bOpenPanel = false
  end
  
  self:AddTimer(1, 0.2, close, true, true, true)
end

function TravelerDuelRankingCtrl:OnGridRankingRefresh(grid)
  if self._mapRankingGrid[grid] == nil then
    local mapCtrl = self:BindCtrlByNode(grid, "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRankingGrid")
    self._mapRankingGrid[grid] = mapCtrl
  end
  local nIdx = tonumber(grid.name)
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  self._mapRankingGrid[grid]:Refresh(self.mapRankingData[nIdx])
end

function TravelerDuelRankingCtrl:OnGridRankingRewardRefresh(grid)
  if self._mapRewardGrid[grid] == nil then
    local mapCtrl = self:BindCtrlByNode(grid, "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRewardGridCtrl")
    self._mapRewardGrid[grid] = mapCtrl
  end
  local nIdx = tonumber(grid.name)
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local nSelfIdx = 0
  if self.mapSelfRankingData ~= nil then
    nSelfIdx = self.mapSelfRankingData.nRewardIdx
  end
  self._mapRewardGrid[grid]:Refresh(nIdx, nSelfIdx)
end

function TravelerDuelRankingCtrl:OnBtnClick_right()
  self._mapNode.tcTab:SetState(true)
  self._mapNode.rtRankingInfo:SetActive(false)
  self._mapNode.rtRankingReward:SetActive(true)
end

function TravelerDuelRankingCtrl:OnBtnClick_left()
  self._mapNode.tcTab:SetState(false)
  self._mapNode.rtRankingInfo:SetActive(true)
  self._mapNode.rtRankingReward:SetActive(false)
end

return TravelerDuelRankingCtrl
