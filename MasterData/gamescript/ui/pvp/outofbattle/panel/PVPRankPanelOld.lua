local seasonCfgs = {}
for _, cfg in pairs(DT.PVPSeason) do
  table.insert(seasonCfgs, cfg)
end
table.sort(seasonCfgs, function(a, b)
  return a.BaseSortID < b.BaseSortID
end)
local PVPRankPanel, Super = System.NewClass("PVPRankPanel", UIBasePanel)
PVPRankPanel.uiResCls = UI_Pvp_Popup_list_TipsResource

function PVPRankPanel:ctor(pvpSeasonModel)
  Super.ctor(self)
  self.pvpSeasonModel = pvpSeasonModel
  SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.RankBoard, {
    rankType = RankDefine.RankType.PVP
  })
end

function PVPRankPanel:OnBind(binder)
  self.pvpRankModel = binder:createModel(PVPRankModel)
  self.pvpRankModel:SetSeasonTid(self.pvpSeasonModel.seasonTid)
  self:_BindCloseBtn(binder)
  self:_BindSeasonCountdown(binder)
  self:_BindSelfInfo(binder)
  self:_BindPageBtn(binder)
  self:_BindRankList(binder)
  self:_BindSeasonList(binder)
end

function PVPRankPanel:_BindCloseBtn(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function PVPRankPanel:_BindSeasonCountdown(binder)
  binder:BindToRaw(function(_, seasonEndTime)
    if 0 == seasonEndTime then
      self.ui.Image_Hourglass:SetActive(false)
      return
    end
    self.ui.Image_Hourglass:SetActive(true)
    binder:SetText(self.ui.Text_Hourglass, "")
    if self.timerID then
      TimerManager.Instance:StopTimer(self.timerID)
      self.timerID = nil
    end
    local countdown = seasonEndTime - TimeUtils.GetServerTime()
    self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
      countdown = math.max(countdown - 0.033, 0)
      local d, h = TimeUtils.PVPSeasonEnd(countdown)
      binder:SetText(self.ui.Text_Hourglass, LT.Textf("PVPSeasonCountdown", d, h))
    end)
  end, function()
    return self.pvpSeasonModel.seasonEndTime
  end)
end

function PVPRankPanel:_BindSelfInfo(binder)
  local headRes = PlayerDataUtils.GetAvatarIcon()
  binder:SetImage(self.ui.Image_Avatar, headRes)
  binder:SetText(self.ui.Text_Name, DataCenter.playerData.DRole.name)
  binder:SetText(self.ui.Text_Uid, DataCenter.playerData.DRole.uid)
  binder:BindToVisible(self.ui.Text_Ranking, function()
    return self.pvpRankModel.selfRankIdx >= 0
  end)
  binder:BindToText(self.ui.Text_Ranking, function()
    return 0 == self.pvpRankModel.selfRankIdx and LT.Text("Unranked") or self.pvpRankModel.selfRankIdx
  end)
  binder:BindToVisible(self.ui.Image_Icon, function()
    return self.pvpSeasonModel.rankTid > 0
  end)
  binder:BindToRaw(function(_, rankTid)
    if rankTid > 0 then
      local cfg = DT.PVPRank[rankTid]
      binder:SetImage(self.ui.Image_Icon, cfg.Icon)
      binder:SetImage(self.ui.Image_Grade, CommonDefine.PVPRankStageIcon[cfg.Stage])
      binder:SetText(self.ui.Text_Level, LT.Text(cfg.Name))
      if cfg.ID == CommonDefine.HighestPVPRank.ID then
        self.ui.Image_Hoist:SetActive(true)
        binder:SetText(self.ui.Text_Star, self.pvpSeasonModel.stars)
      else
        self.ui.Image_Hoist:SetActive(false)
      end
    end
  end, function()
    return self.pvpSeasonModel.rankTid
  end)
  
  local function _OnClickHead()
    SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, DataCenter.playerData.DRole.uid)
  end
  
  binder:BindButtonClick(self.ui.Button_Head, _OnClickHead)
end

function PVPRankPanel:_BindPageBtn(binder)
  binder:BindToText(self.ui.Text_Page, function()
    return self.pvpRankModel.currPageIdx
  end)
  binder:BindButtonClick(self.ui.Btn_Click_UP, function()
    local pageIdx = self.pvpRankModel.currPageIdx - 1
    self.pvpRankModel:SetPageIdx(pageIdx)
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Down, function()
    local pageIdx = self.pvpRankModel.currPageIdx + 1
    self.pvpRankModel:SetPageIdx(pageIdx)
  end)
  binder:BindToVisible(self.ui.Icon_Normal_UP, function()
    return self.pvpRankModel.currPageIdx > 1
  end)
  binder:BindToVisible(self.ui.Icon_Normal_Down, function()
    return self.pvpRankModel.currPageIdx < self.pvpRankModel.maxPages
  end)
end

function PVPRankPanel:_BindRankList(binder)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.pvpRankModel.currPageEntries
  end, function(itemBinder, obj, index)
    local data = self.pvpRankModel.currPageEntries[index]
    itemBinder:BindComponent(PVPRankItem(obj, data))
  end)
end

function PVPRankPanel:_BindSeasonList(binder)
  binder:BindToVisible(self.ui.Label_Season, function()
    return self.pvpRankModel.seasonTid > 0
  end)
  binder:BindToText(self.ui.Label_Season, function()
    if self.pvpRankModel.seasonTid > 0 then
      local cfg = DT.PVPSeason[self.pvpRankModel.seasonTid]
      do return LT.Text end
      return LT.Text, cfg.Name
    end
    return ""
  end)
  self.ui.ScrollView_Seasons:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Season, function()
    self.ui.ScrollView_Seasons:SetActive(not self.ui.ScrollView_Seasons.activeSelf)
    if not self.ui.ScrollView_Seasons.activeSelf then
      return
    end
    local seasonCfgsToShow = {}
    local currSeasonCfg = DT.PVPSeason[self.pvpSeasonModel.seasonTid]
    for _, cfg in ipairs(seasonCfgs) do
      if cfg.StartTime <= currSeasonCfg.StartTime then
        table.insert(seasonCfgsToShow, cfg)
      end
    end
    if self.seasonListBinder then
      self.seasonListBinder:teardown()
    end
    self.seasonListBinder = binder:BindToCircularListView(self.ui.ScrollView_Seasons, function()
      return seasonCfgsToShow
    end, function(itemBinder, obj, index)
      local cfg = seasonCfgsToShow[index]
      itemBinder:BindComponent(PVPSeasonItem(obj, cfg, function()
        self.pvpRankModel:SetSeasonTid(cfg.ID)
        self.ui.ScrollView_Seasons:SetActive(false)
      end))
    end)
  end)
end

function PVPRankPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

return PVPRankPanel
