_class("UIWorldBossRanking", UICustomWidget)
UIWorldBossRanking = UIWorldBossRanking

function UIWorldBossRanking:Constructor()
  self._dicTeam = {}
  self._dicWidget = {}
  self._page = {
    cur = 0,
    max = 0,
    count = 0,
    perPage = 50,
    totalCount = 0
  }
end

function UIWorldBossRanking:OnShow(uiParams)
  self._uiRanking = self:GetUIComponent("RectTransform", "uiRanking")
  self._uiCalculating = self:GetUIComponent("RectTransform", "uiCalculating")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._uiCurPlayer = self:GetUIComponent("RectTransform", "uiCurPlayer")
  self._uiCurPlayerLoader = self:GetUIComponent("UISelectObjectPath", "uiCurPlayer")
  self._txtOfflistTips = self:GetUIComponent("UILocalizationText", "txtOfflistTips")
  self._txtPage = self:GetUIComponent("UILocalizationText", "txtPage")
  self._txtCalculating = self:GetUIComponent("UILocalizationText", "txtCalculating")
  self._listViewInited = false
end

function UIWorldBossRanking:OnHide()
  for k, v in pairs(self._dicWidget) do
    v:UnLoad()
    v:Dispose()
  end
end

function UIWorldBossRanking:Flush(ranking, rankingSelf, isCurRanking)
  self._ranking = ranking
  self._rankingSelf = rankingSelf
  self._isCurRanking = isCurRanking
  if false then
    self._ranking = {}
    for i = 1, 270 do
      table.insert(self._ranking, ranking[1])
    end
  end
  if 0 == #self._ranking then
    self._uiRanking.gameObject:SetActive(false)
    self._uiCalculating.gameObject:SetActive(true)
  else
    self._uiRanking.gameObject:SetActive(true)
    self._uiCalculating.gameObject:SetActive(false)
    self._page.totalCount = #self._ranking
    self._page.max = math.ceil(self._page.totalCount / self._page.perPage)
    self._page.cur = 1
    self:DynamicSv()
    self:RankingSelf()
  end
  if self._isCurRanking then
    self._txtCalculating:SetText(StringTable.Get("str_world_boss_n31_ranking_calculating"))
  else
    self._txtCalculating:SetText(StringTable.Get("str_world_boss_n31_ranking_pre_calculating"))
  end
end

function UIWorldBossRanking:DynamicSv()
  self._page.count = self._page.totalCount - self._page.perPage * (self._page.cur - 1)
  self._page.count = math.min(self._page.count, self._page.perPage)
  self._txtPage:SetText(string.format("%d/%d", self._page.cur, self._page.max))
  if self._listViewInited then
    self._scrollView:SetListItemCount(self._page.count)
    self._scrollView:ResetListView()
    self._scrollView:RefreshAllShownItem()
    self._scrollView:MovePanelToItemIndex(0, 0)
  else
    self._listViewInited = true
    self._scrollView:InitListView(self._page.count, function(scrollView, index)
      return self:InitSpritListInfo(scrollView, index)
    end, nil)
  end
end

function UIWorldBossRanking:InitSpritListInfo(scrollView, index)
  local item = scrollView:NewListViewItem("UIWorldBossRankingWidget")
  local widget = self._dicWidget[item:GetInstanceID()]
  if widget == nil then
    local uiWidgetName = "UIWorldBossRankingWidget"
    widget = _createInstance(uiWidgetName)
    widget:SetName(uiWidgetName)
    self._dicWidget[item:GetInstanceID()] = widget
    local view = item:GetComponent("UIView")
    widget:Load(view, self:RootUIOwner())
  end
  local luaIndex = self._page.perPage * (self._page.cur - 1)
  luaIndex = luaIndex + index + 1
  widget:Flush(self._ranking[luaIndex], luaIndex, self._isCurRanking, self)
  return item
end

function UIWorldBossRanking:RankingSelf()
  if self._rankingSelf == nil then
    self._uiCurPlayer.gameObject:SetActive(false)
    self._txtOfflistTips.gameObject:SetActive(true)
  else
    self._uiCurPlayer.gameObject:SetActive(true)
    self._txtOfflistTips.gameObject:SetActive(false)
    local widgetSelf = self._uiCurPlayerLoader:SpawnObject("UIWorldBossRankingWidget")
    widgetSelf:Flush(self._rankingSelf, self._rankingSelf.luaIndex, self._isCurRanking)
  end
end

function UIWorldBossRanking:BtnLeftOnClick(go)
  local old = self._page.cur
  self._page.cur = math.max(self._page.cur - 1, 1)
  if self._page.cur ~= old then
    self:DynamicSv()
  end
end

function UIWorldBossRanking:BtnRightOnClick(go)
  local old = self._page.cur
  self._page.cur = math.min(self._page.cur + 1, self._page.max)
  if self._page.cur ~= old then
    self:DynamicSv()
  end
end

function UIWorldBossRanking:BtnViewOnClick(go, data)
  local teamInfo = self._dicTeam[data.pstid]
  if teamInfo == nil then
    local lockName = "UIWorldBossRanking:BtnViewOnClick"
    self:StartTask(function(TT)
      self:Lock(lockName)
      local res
      local worldBossModule = self:GetModule(WorldBossModule)
      res, teamInfo = worldBossModule:GetRankOneDetail(TT, data.pstid)
      self:UnLock(lockName)
      if res:GetSucc() then
        self._dicTeam[data.pstid] = teamInfo
        self:ShowDialog("UIWorldBossViewTeam", data, teamInfo)
      end
    end)
  else
    self:ShowDialog("UIWorldBossViewTeam", data, teamInfo)
  end
end

function UIWorldBossRanking:InAnimation()
  local sortList = {}
  for k, v in pairs(self._dicWidget) do
    if v:GetGameObject().activeSelf then
      table.insert(sortList, v)
    end
  end
  table.sort(sortList, function(a, b)
    return a:RankingIndex() < b:RankingIndex()
  end)
  local lockName = "UIWorldBossRanking:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(sortList) do
      v:GetGameObject():SetActive(false)
    end
    for k, v in pairs(sortList) do
      v:GetGameObject():SetActive(true)
      v:PlayAnimation("UIWorldBossRanking_in")
      YIELD(TT, 30)
    end
    self:UnLock(lockName)
  end)
end

_class("UIWorldBossRankingWidget", UICustomWidget)
UIWorldBossRankingWidget = UIWorldBossRankingWidget

function UIWorldBossRankingWidget:OnShow()
  self._txtPosition = self:GetUIComponent("UILocalizationText", "txtPosition")
  self._uiPosition = self:GetUIComponent("RectTransform", "uiPosition")
  self._playerHeadLoader = self:GetUIComponent("RawImageLoader", "playerHead")
  self._playerHeadBgLoader = self:GetUIComponent("UICircleMaskLoader", "playerHeadBg")
  self._playerHeadFrameLoader = self:GetUIComponent("RawImageLoader", "playerHeadFrame")
  self._playerHeadBadge = self:GetUIComponent("UISelectObjectPath", "playerHeadBadge")
  self._playerName = self:GetUIComponent("UILocalizationText", "playerName")
  self._playerId = self:GetUIComponent("UILocalizationText", "playerId")
  self._txtDamageBg = self:GetUIComponent("UILocalizationText", "txtDamageBg")
  self._txtDamage = self:GetUIComponent("UILocalizationText", "txtDamage")
  self._btnView = self:GetUIComponent("Button", "btnView")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._btnPlayer = self:GetGameObject("btnPlayer")
  local GetChildComponent = UISerialAutoFightInfo.GetChildComponent
  local uiPosition = {
    uiRoot = self._uiPosition,
    GetChildComponent(self, self._uiPosition, "RectTransform", "1"),
    GetChildComponent(self, self._uiPosition, "RectTransform", "2"),
    GetChildComponent(self, self._uiPosition, "RectTransform", "3")
  }
  self._uiPosition = uiPosition
end

function UIWorldBossRankingWidget:OnHide()
end

function UIWorldBossRankingWidget:RankingIndex()
  return self._index
end

function UIWorldBossRankingWidget:PlayAnimation(animName)
  self._animation:Play(animName)
end

function UIWorldBossRankingWidget:Flush(data, index, isCurRanking, widgetRanking)
  self._data = data
  self._index = index
  self._isCurRanking = isCurRanking
  self._widgetRanking = widgetRanking
  local cfg_header = Cfg.cfg_role_head_image[self._data.head]
  if cfg_header then
    self._playerHeadLoader.gameObject:SetActive(true)
    self._playerHeadLoader:LoadImage(cfg_header.Icon)
  else
    self._playerHeadLoader.gameObject:SetActive(false)
  end
  local headBg = self._data.head_bg
  local cfgHeadBg = Cfg.cfg_player_head_bg[headBg]
  if not cfgHeadBg then
    headBg = HelperProxy:GetInstance():GetHeadBgDefaultID()
    cfgHeadBg = Cfg.cfg_player_head_bg[headBg]
  end
  self._playerHeadBgLoader:LoadImage(cfgHeadBg.Icon)
  local headFrame = self._data.frame_id
  if not headFrame or headFrame == 0 then
    headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  end
  local cfgHeadFrame = Cfg.cfg_role_head_frame[headFrame]
  self._playerHeadFrameLoader:LoadImage(cfgHeadFrame.Icon)
  local headDanBadge = self._playerHeadBadge:SpawnObject("UIWorldBossDanBadge")
  local badgeType = UIWroldBossBadgeStype.WBBS_SIMPLE
  local badgeRect = self._playerHeadBadge:Engine().transform
  local missionId = self:RootUIOwner()._missionId
  local danIndex = UIWorldBossHelper.GetUiLegendDanCfg(missionId).ID
  headDanBadge:SetData(badgeType, danIndex, self._index, badgeRect.sizeDelta.x, badgeRect.sizeDelta.y)
  headDanBadge:EnableRankLevel(false)
  local loginModule = self:GetModule(LoginModule)
  local showId = loginModule:GetShowIdByPstId(self._data.pstid)
  local roleModule = self:GetModule(RoleModule)
  local selfPstid = roleModule:GetPstId()
  self._txtPosition:SetText(self._index)
  self._playerName:SetText(self._data.nick)
  self._playerId:SetText(string.format("ID:%d", showId))
  self._txtDamageBg:SetText(string.format("%.7d", self._data.damage))
  self._txtDamage:SetText(self._data.damage)
  self._btnView.gameObject:SetActive(self._isCurRanking and selfPstid ~= self._data.pstid)
  self._btnPlayer:SetActive(selfPstid ~= self._data.pstid)
  local showBtnView = false
  local showPlayerId = false
  local showUiPosition = false
  local showTxtPosition = false
  local show1Position = false
  local show2Position = false
  local show3Position = false
  local clrPlayerName = Color.white
  if self._index == 1 then
    showUiPosition = true
    show1Position = true
    clrPlayerName = Color(0.6705882352941176, 0.6235294117647059, 0.5058823529411764, 1)
  elseif self._index == 2 then
    showUiPosition = true
    show2Position = true
    clrPlayerName = Color(0.7137254901960784, 0.7372549019607844, 0.8784313725490196, 1)
  elseif self._index == 3 then
    showUiPosition = true
    show3Position = true
    clrPlayerName = Color(0.796078431372549, 0.7098039215686275, 0.6705882352941176, 1)
  elseif self._index >= 4 then
    showTxtPosition = true
    clrPlayerName = Color(0.8745098039215686, 0.8745098039215686, 0.8745098039215686, 1)
  end
  self._playerName.color = clrPlayerName
  self._btnView.gameObject:SetActive(showBtnView)
  self._playerId.gameObject:SetActive(showPlayerId)
  self._txtPosition.gameObject:SetActive(showTxtPosition)
  self._uiPosition.uiRoot.gameObject:SetActive(showUiPosition)
  self._uiPosition[1].gameObject:SetActive(show1Position)
  self._uiPosition[2].gameObject:SetActive(show2Position)
  self._uiPosition[3].gameObject:SetActive(show3Position)
end

function UIWorldBossRankingWidget:BtnViewOnClick(go)
  if self._widgetRanking ~= nil then
    self._widgetRanking:BtnViewOnClick(go, self._data)
  end
end

function UIWorldBossRankingWidget:BtnPlayerOnClick(go)
  if string.len(self._data.nick) == 0 then
    return
  end
  local chatFriendManager = ChatFriendManager:New()
  chatFriendManager:Request(false, true, true, function(mgr)
    self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.WorldBoss, self._data.pstid, mgr)
  end)
end
