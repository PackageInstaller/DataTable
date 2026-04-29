_class("UICN16N45SeaNoteRankingList", UIController)
UICN16N45SeaNoteRankingList = UICN16N45SeaNoteRankingList

function UICN16N45SeaNoteRankingList:LoadDataOnEnter(TT, res)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N9_ASHEEP, ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  local sample = self._campaign:GetSample()
  self._activeEndTime = sample.end_time
  local localProcess = self._campaign:GetLocalProcess()
  self._ASheepCom = localProcess:GetComponent(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._ASheeoComInfo = localProcess:GetComponentInfo(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  local componentCfgId = self._ASheepCom:GetComponentCfgId()
  local sheepComCfg = Cfg.cfg_campaign_component({ComponentID = componentCfgId})[1]
  local subKey = sheepComCfg.RankSubKey[1]
  self._rank_info = self._campaignModule:CampaignLoadComponentRank(TT, res, componentCfgId, subKey)
  if not res:GetSucc() then
    Log.error("排行榜数据异常:", res:GetResult())
    return
  end
end

function UICN16N45SeaNoteRankingList:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = #self._rank_info.infos > 100 and 100 or #self._rank_info.infos
  self.selfRankIndex = self:GetSelfRank()
  self:InitWidget()
  if self._dynamicListRowSize == 0 then
    self.NullTipsObj:SetActive(true)
  else
    self.NullTipsObj:SetActive(false)
  end
  self:InitSelfRanking()
  self._data = uiParams[1]
end

function UICN16N45SeaNoteRankingList:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "closeBtn")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true, nil, false, nil)
  self._selfRankPool = self:GetUIComponent("UISelectObjectPath", "selfRank")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._dynamicList:InitListView(self._dynamicListRowSize + 1, function(scrollView, index)
    return self:_SpawnListItem(scrollView, index)
  end)
  self._sr = self:GetUIComponent("ScrollRect", "dynamicList")
  self.unScoreRankObj = self:GetGameObject("unScoreRank")
  self.unScoreRankObj:SetActive(false)
  self.NullTipsObj = self:GetGameObject("NullTips")
  self.NullTipsObj:SetActive(false)
end

function UICN16N45SeaNoteRankingList:InitSelfRanking()
  local maxScore = self._ASheeoComInfo.m_info.m_max_score
  if maxScore == 0 then
    self.unScoreRankObj:SetActive(true)
  else
    self.unScoreRankObj:SetActive(false)
    local roleModule = self:GetModule(RoleModule)
    local playerInfo = roleModule:UI_GetPlayerInfo()
    local headid = playerInfo.m_nHeadImageID
    local headbgid = playerInfo.m_nHeadColorID
    local nick = playerInfo.m_stRoleName
    local frameid = playerInfo.m_nHeadFrameID
    local pool = self._selfRankPool:SpawnObject("UICN16N45SeaNoteRankingListItem")
    pool:SetData(self.selfRankIndex, nick, maxScore, headbgid, headid, frameid, true, true)
  end
end

function UICN16N45SeaNoteRankingList:InitRankingData()
  local rankingList = self._rank_info.infos
  local defaultData = {}
  for _, v in pairs(Cfg.cfg_season_maze_world_boss_default_ranking({})) do
    table.insert(defaultData, v)
  end
  table.sort(defaultData, function(a, b)
    return a.ID < b.ID
  end)
  local rPtr = 1
  local dPtr = 1
  while dPtr ~= #defaultData do
    if rPtr > #rankingList then
      rankingList[rPtr] = defaultData[rPtr]
      dPtr = dPtr + 1
    elseif #rankingList ~= 0 then
      if defaultData[dPtr] < rankingList[rPtr] then
        table.insert(rankingList, rPtr, defaultData[dPtr])
        dPtr = dPtr + 1
      end
    else
      rankingList[1] = defaultData[1]
      dPtr = dPtr + 1
    end
    rPtr = rPtr + 1
  end
  self._rank_info.infos = rankingList
  self._dynamicListRowSize = #self._rank_info.infos
end

function UICN16N45SeaNoteRankingList:GetSelfRank()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  for rank, v in pairs(self._rank_info.infos) do
    if v.pstid == pstId then
      return rank
    end
  end
  if #self._rank_info.infos == 0 then
    if 0 < self._ASheeoComInfo.m_info.m_max_score then
      self._dynamicListRowSize = 1
    end
    return 101
  end
  return 101
end

function UICN16N45SeaNoteRankingList:SelfRankOnClick()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local selfRank = 0
  for rank, v in pairs(self._rank_info.infos) do
    if v.pstid == pstId then
      selfRank = rank
    end
  end
  if #self._rank_info.infos == 0 then
    selfRank = 1
  end
  if 100 < selfRank then
    return
  end
  if selfRank ~= 0 then
    local value = 1 - selfRank / 100
    selfRank = selfRank - 1
    if selfRank < 0 then
      selfRank = 0
    end
    self._dynamicList:MovePanelToItemIndex(selfRank, 0)
  end
end

function UICN16N45SeaNoteRankingList:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UICN16N45SeaNoteRankingListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  if index >= self._dynamicListRowSize then
    for i = 1, self._itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      listItem:SetNull()
    end
  else
    for i = 1, self._itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UICN16N45SeaNoteRankingList:_SetListItemData(listItem, index)
  local loginModule = self:GetModule(LoginModule)
  local maxScore = self._ASheeoComInfo.m_info.m_max_score
  if #self._rank_info.infos == 0 and self._dynamicListRowSize == 1 and 0 < maxScore then
    local roleModule = self:GetModule(RoleModule)
    local playerInfo = roleModule:UI_GetPlayerInfo()
    local headid = playerInfo.m_nHeadImageID
    local headbgid = playerInfo.m_nHeadColorID
    local nick = playerInfo.m_stRoleName
    local frameid = playerInfo.m_nHeadFrameID
    listItem:SetData(self.selfRankIndex, nick, maxScore, headbgid, headid, frameid, true, true)
    return
  end
  local info = self._rank_info.infos[index]
  if info == nil then
    return
  end
  local isMyself = false
  if info.pstid == loginModule.PstID then
    isMyself = true
  end
  if info ~= nil then
    if info.nick ~= nil then
      listItem:SetData(index, info.nick, info.damage, info.head_bg, info.head, info.frame_id, info.pstid ~= 0, isMyself, info.pstid)
    else
      listItem:SetData(index, info.Name, info.Damage, info.HeadIconBg, info.HeadIcon, nil, false, false, 0)
    end
  end
end
