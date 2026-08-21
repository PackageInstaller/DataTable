_class("UISeasonMazeWorldBossRankingList", UIController)
UISeasonMazeWorldBossRankingList = UISeasonMazeWorldBossRankingList

function UISeasonMazeWorldBossRankingList:LoadDataOnEnter(TT, res)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._comCfgID = self._component:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  local subKey = self._cfg_global.WorldBossMissionID
  self._rank_info = self._component:HandleCampaignLoadComponentRank(TT, res, subKey)
  if not res:GetSucc() then
    Log.error("赛季秘境荒典排行榜数据异常:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
    return
  end
end

function UISeasonMazeWorldBossRankingList:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = #self._rank_info.infos > 100 and 100 or #self._rank_info.infos
  self.worldBossInfo = self._componentInfo.m_world_boss_info
  self.selfRankIndex = self:GetSelfRank()
  self:InitWidget()
  self:InitRankingData()
  self:InitSelfRanking()
end

function UISeasonMazeWorldBossRankingList:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "closeBtn")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UISeasonMazeWorldBossTipsPopUp", "str_season_maze_world_boss_rank_help_title", "str_season_maze_world_boss_rank_help_detail")
  end, nil, true, nil, false, nil)
  self._selfRankPool = self:GetUIComponent("UISelectObjectPath", "selfRank")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._dynamicList:InitListView(self._dynamicListRowSize + 1, function(scrollView, index)
    return self:_SpawnListItem(scrollView, index)
  end)
end

function UISeasonMazeWorldBossRankingList:InitSelfRanking()
  local damage = self._componentInfo.m_world_boss_info.total_damage
  if damage == 0 then
  else
    local roleModule = self:GetModule(RoleModule)
    local playerInfo = roleModule:UI_GetPlayerInfo()
    local headid = playerInfo.m_nHeadImageID
    local headbgid = playerInfo.m_nHeadColorID
    local nick = playerInfo.m_stRoleName
    local frameid = playerInfo.m_nHeadFrameID
    local pool = self._selfRankPool:SpawnObject("UISeasonMazeWorldBossRankingListItem")
    pool:SetData(self.selfRankIndex, nick, damage, headbgid, headid, frameid, true)
  end
end

function UISeasonMazeWorldBossRankingList:InitRankingData()
end

function UISeasonMazeWorldBossRankingList:GetSelfRank()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  for rank, v in pairs(self._rank_info.infos) do
    if v.pstid == pstId then
      return rank
    end
  end
  return 101
end

function UISeasonMazeWorldBossRankingList:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeWorldBossRankingListItem", self._itemCountPerRow)
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

function UISeasonMazeWorldBossRankingList:_SetListItemData(listItem, index)
  local info = self._rank_info.infos[index]
  if info ~= nil then
    listItem:SetData(index, info.nick, info.damage, info.head_bg, info.head, info.frame_id, info.pstid ~= 0)
  end
end
