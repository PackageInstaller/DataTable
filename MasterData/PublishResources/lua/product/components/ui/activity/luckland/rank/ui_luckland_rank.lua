_class("UILuckLandRank", UIController)
UILuckLandRank = UILuckLandRank

function UILuckLandRank:LoadDataOnEnter(TT, res, uiParams)
  self._component = uiParams[1]
  self._componentInfo = self._component:GetComponentInfo()
  self._missionID = uiParams[2]
  self._component:HandleLuckLandGetRankList(TT, res, self._missionID)
  if not res:GetSucc() then
    self:GetModule(CampaignModule):ShowErrorToast(res.m_result, true)
    self:SwitchState(UIStateType.UIMain)
    return
  end
end

function UILuckLandRank:OnShow(uiParams)
  self._cfg = Cfg.cfg_luckland_client_mission[self._missionID]
  self._loginModule = self:GetModule(LoginModule)
  self._roleModule = self:GetModule(RoleModule)
  self._pstID = self._loginModule.PstID
  self._animationItems = {}
  self:_InitWidget()
  self:_OnValue()
end

function UILuckLandRank:OnHide()
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
end

function UILuckLandRank:_InitWidget()
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._rankGO = self:GetGameObject("Rank")
  self._noRankGO = self:GetGameObject("NoRank")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._bottomImgGO = self:GetGameObject("BottomImg")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandRank:_OnValue()
  self:_SetCommonTopButton()
  self._rankData = self._component.m_rank_top[self._missionID]
  self._level:SetText(StringTable.Get("str_luckland_rank_desc", StringTable.Get(self._cfg.Name)))
  self._bottomImgGO:SetActive(false)
  if self._rankData and self._rankData.infos and #self._rankData.infos > 0 then
    self._rankGO:SetActive(true)
    self._noRankGO:SetActive(false)
    self:_InitDynamicScrollView()
    if self._componentInfo.m_pass_mission_info[self._missionID] then
      self._myRankItem = UIWidgetHelper.SpawnObjects(self, "MyRank", "UILuckLandRankItem", 1)
      local index, info = self:_GetMyRank(self._rankData.infos)
      self._myRankItem[1]:SetData(index, info)
      self._bottomImgGO:SetActive(true)
    end
  else
    self._rankGO:SetActive(false)
    self._noRankGO:SetActive(true)
  end
end

function UILuckLandRank:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._rankData.infos, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
  self:Lock("UILuckLandRank")
  self._task = self:StartTask(function(TT)
    self:_DynamicListPlayAnimation(TT)
    YIELD(TT, 300)
    self:UnLock("UILuckLandRank")
  end, self)
end

function UILuckLandRank:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("UILuckLandRankItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UILuckLandRankItem", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  if itemWidgets[1] then
    local rankIndex = index + 1
    itemWidgets[1]:SetData(rankIndex, self._rankData.infos[rankIndex])
  end
  return item
end

function UILuckLandRank:_GetMyRank(infos)
  local rankIndex = 101
  local rankInfo
  for index, info in pairs(infos) do
    if info.pstid == self._pstID then
      rankIndex = index
      rankInfo = info
      break
    end
  end
  if not rankInfo then
    local playerInfo = self._roleModule:UI_GetPlayerInfo()
    rankInfo = {}
    rankInfo.pstid = self._pstID
    rankInfo.head = playerInfo.m_nHeadImageID
    local passInfo = self._componentInfo.m_pass_mission_info[self._missionID]
    if passInfo then
      rankInfo.damage = passInfo.record_score
    else
      rankInfo.damage = 0
    end
    rankInfo.nick = playerInfo.m_stRoleName
    rankInfo.head_bg = playerInfo.m_nHeadColorID
    rankInfo.frame_id = self._roleModule:GetHeadFrameID()
  end
  return rankIndex, rankInfo
end

function UILuckLandRank:_SetCommonTopButton()
  local function closeCallback()
    self:Lock("UILuckLandRank")
    
    self:StartTask(function(TT)
      self._animation:Play("uieff_UILuckLandRank_out")
      YIELD(TT, 333)
      self:CloseDialog()
      self:UnLock("UILuckLandRank")
    end, self)
  end
  
  local function helpCallBack()
    self:ShowDialog("UIIntroLoader", "UILuckLandRank")
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "BackBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, helpCallBack, nil, true)
end

function UILuckLandRank:_DynamicListPlayAnimation(TT)
  local showTabIds = self._scrollView:GetVisibleItemIDsInScrollView()
  local items = {}
  for index = 0, showTabIds.Count - 1 do
    local id = math.floor(showTabIds[index])
    local item = self._scrollView:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    if rowList then
      for i = 1, #rowList do
        item.gameObject:SetActive(false)
        local data = {}
        data.gameObject = item.gameObject
        data.widget = rowList[i]
        table.insert(items, data)
      end
    end
  end
  for i = 1, #items do
    YIELD(TT, (i - 1) * 50)
    items[i].gameObject:SetActive(true)
    items[i].widget:PlayAnimation()
  end
end
