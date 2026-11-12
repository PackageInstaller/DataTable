local ScoreBossRankingCtrl = class("ScoreBossRankingCtrl", BaseCtrl)
ScoreBossRankingCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgBlurBG = {},
  txtLoading = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScorebossRanking_Loading"
  },
  txtRankingListRankTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Rank"
  },
  txtRankingListPlayerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBossRankingPlayerName"
  },
  txtRankingListScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Score"
  },
  txtRankingListDetailTitle = {sComponentName = "TMP_Text", sLanguageId = "MoreInfo"},
  txtRefreshTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Refresh_Tips"
  },
  rtPlayerInfo = {
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossRanking.ScoreBossRankingGridCtrl"
  },
  svRankingInfo = {
    sComponentName = "LoopScrollView"
  },
  goLoading = {},
  goMainContent = {},
  goSafeArea = {
    sNodeName = "----SafeAreaRoot----"
  },
  goTeamDetail = {
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossRanking.ScoreBossRankingTeamDetailCtrl"
  },
  txtEndTime = {sComponentName = "TMP_Text"}
}
ScoreBossRankingCtrl._mapEventConfig = {
  ShowTeamDetail = "OnEvent_ShowTeamDetail",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  OpenRankBuildDetail = "OnEvent_OpenRankBuildDetail"
}

function ScoreBossRankingCtrl:Awake()
  self._mapRankingGrid = {}
end

function ScoreBossRankingCtrl:OnDisable()
  EventManager.Hit(EventId.BlockInput, false)
  for go, mapCtrl in pairs(self._mapRankingGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapRankingGrid = {}
  if self.timerRefreshRanking ~= nil then
    self.timerRefreshRanking:Cancel()
    self.timerRefreshRanking = nil
  end
end

function ScoreBossRankingCtrl:OnEnable()
  self._mapNode.goSafeArea:SetActive(false)
  self._mapNode.imgBlurBG:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goSafeArea.gameObject:SetActive(true)
    self._mapNode.goLoading.gameObject:SetActive(true)
    self._mapNode.goMainContent.gameObject:SetActive(false)
    PlayerData.ScoreBoss:SendScoreBossApplyReq(function()
      local rankPlayerCount = PlayerData.ScoreBoss:GetRankPlayerCount()
      if 0 < rankPlayerCount then
        self:OpenPanel()
      else
        NovaAPI.SetTMPText(self._mapNode.txtLoading, ConfigTable.GetUIText("STRanking_Empty"))
      end
    end)
    if self.timerRefreshRanking ~= nil then
      self.timerRefreshRanking:Cancel()
      self.timerRefreshRanking = nil
    end
    self.timerRefreshRanking = self:AddTimer(0, 600, function()
      PlayerData.ScoreBoss:SendScoreBossApplyReq(function()
        local rankPlayerCount = PlayerData.ScoreBoss:GetRankPlayerCount()
        if 0 < rankPlayerCount then
          self:OpenPanel()
        else
          NovaAPI.SetTMPText(self._mapNode.txtLoading, ConfigTable.GetUIText("STRanking_Empty"))
        end
      end)
    end, true, true, true)
  end
  
  cs_coroutine.start(wait)
end

function ScoreBossRankingCtrl:OpenPanel()
  self._mapNode.goLoading:SetActive(false)
  self._mapNode.goMainContent:SetActive(true)
  self._mapNode.rtPlayerInfo:Refresh(0, true)
  local rankTable = PlayerData.ScoreBoss:GetRankTableCount()
  if 0 < rankTable then
    self._mapNode.svRankingInfo.gameObject:SetActive(true)
    self._mapNode.svRankingInfo:Init(rankTable, self, self.OnGridRankingRefresh)
    if self._panel.mapRankDetail ~= nil then
      self._mapNode.svRankingInfo:SetScrollPos(self._panel.nGridPos)
    else
      self:PlayGridItemAnim()
    end
  else
    self._mapNode.svRankingInfo.gameObject:SetActive(false)
  end
  self._mapNode.goTeamDetail.gameObject:SetActive(false)
  if self._panel.mapRankDetail ~= nil then
    self:AddTimer(1, 0.4, function()
      EventManager.Hit("ShowTeamDetail", self._panel.mapRankDetail)
      self._panel.mapRankDetail = nil
      self._panel.nGridPos = 0
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  end
  local endTime = PlayerData.ScoreBoss.EndTime + ConfigTable.GetConfigNumber("SeasonEndThreshold")
  local sTime = os.date("%m/%d %H:%M", endTime)
  local sEndTimeTitle = ConfigTable.GetUIText("ScoreBossRankingEndTime")
  NovaAPI.SetTMPText(self._mapNode.txtEndTime, sEndTimeTitle .. " " .. sTime)
end

function ScoreBossRankingCtrl:OnGridRankingRefresh(grid)
  if self._mapRankingGrid[grid] == nil then
    local mapCtrl = self:BindCtrlByNode(grid, "Game.UI.ScoreBoss.ScoreBossRanking.ScoreBossRankingGridCtrl")
    self._mapRankingGrid[grid] = mapCtrl
  end
  local nIdx = tonumber(grid.name)
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  self._mapRankingGrid[grid]:Refresh(nIdx)
end

function ScoreBossRankingCtrl:PlayGridItemAnim()
  local sv = self._mapNode.svRankingInfo
  local sAnim = "go"
  local nAnimTime = 0.1
  local nItemAnimLen = 0
  local listInUse = sv:GetInUseGridIndex()
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(self.tbGridInUse, listInUse[i])
  end
  if self.gridItemAnimTimer ~= nil then
    self.gridItemAnimTimer:Cancel()
    self.gridItemAnimTimer = nil
  end
  for k, v in ipairs(self.tbGridInUse) do
    local goGrid = sv.transform:Find("Viewport/Content/" .. v)
    if goGrid ~= nil then
      local animRoot = goGrid:GetComponent("Animator")
      if animRoot ~= nil then
        animRoot.gameObject:SetActive(false)
      end
      if k == 1 and animRoot ~= nil then
        animRoot.gameObject:SetActive(true)
        nItemAnimLen = NovaAPI.GetAnimClipLength(animRoot, {sAnim})
        animRoot:Play(sAnim, 0, 0)
      end
    end
  end
  local nCurIndex = 1
  EventManager.Hit(EventId.BlockInput, true)
  self.gridItemAnimTimer = self:AddTimer(0, nAnimTime, function()
    nCurIndex = nCurIndex + 1
    if nCurIndex > #self.tbGridInUse and self.gridItemAnimTimer ~= nil then
      self.gridItemAnimTimer:Cancel()
      self.gridItemAnimTimer = nil
      EventManager.Hit(EventId.BlockInput, false)
      return
    end
    local goGrid = sv.transform:Find("Viewport/Content/" .. self.tbGridInUse[nCurIndex])
    if goGrid ~= nil then
      local animRoot = goGrid:GetComponent("Animator")
      if animRoot ~= nil then
        animRoot.gameObject:SetActive(true)
        animRoot:Play(sAnim, 0, 0)
      end
    end
  end, true, true, true)
end

function ScoreBossRankingCtrl:OnEvent_ShowTeamDetail(mapRanking)
  self.mapRankDetail = mapRanking
  self._mapNode.goTeamDetail.gameObject:SetActive(true)
  self._mapNode.goTeamDetail:Refresh(mapRanking)
end

function ScoreBossRankingCtrl:OnEvent_Back(nPanelId)
  EventManager.Hit(EventId.CloesCurPanel)
end

function ScoreBossRankingCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function ScoreBossRankingCtrl:OnEvent_OpenRankBuildDetail()
  self._panel.mapRankDetail = self.mapRankDetail
  self._panel.nGridPos = self._mapNode.svRankingInfo:GetScrollPos()
end

return ScoreBossRankingCtrl
