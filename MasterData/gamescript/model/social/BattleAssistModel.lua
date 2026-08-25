local function applyPlayerInfoRelationChange(playerInfo, relation)
  if not (playerInfo and relation) or playerInfo.relation == relation then
    return
  end
  local wasFollowing = SocialDataUtils.CheckIsAttentionRelation(playerInfo.relation)
  local isFollowing = SocialDataUtils.CheckIsAttentionRelation(relation)
  if isFollowing and not wasFollowing then
    playerInfo.followerNum = (playerInfo.followerNum or 0) + 1
  elseif wasFollowing and not isFollowing then
    playerInfo.followerNum = math.max(0, (playerInfo.followerNum or 0) - 1)
  end
  playerInfo.relation = relation
end

local function modelState(teamModel)
  local state = {}
  state.teamModel = teamModel
  state.curSchoolId = 0
  state.assistList = {}
  state.starAssistList = {}
  state.searchAssistList = {}
  
  function state.stageId()
    return teamModel.stageId
  end
  
  state.sortType = CommonDefine.AssistAwakerSortType.Level
  state.sortOrder = CommonDefine.SortOrder.Descend
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetCurSchoolId()
    return data.curSchoolId
  end
  
  function view:GetAssistList()
    return data.showlist
  end
  
  function view:GetAssistUID()
    return data.assistUid
  end
  
  function view:GetSearchAssistList()
    return data.searchAssistList
  end
  
  function view:GetstarAssistList()
    return data.starAssistList
  end
  
  function view:CurSelectAssistAwakerId()
    if data.assistData then
      return data.assistData.awakerData.tid
    else
      return 0
    end
  end
  
  function view:IsAwakerFight_ExceptAssistSlot(awakerId)
    do return data.teamModel.IsAwakerFight_ExceptAssistSlot, data.teamModel end
    return data.teamModel.IsAwakerFight_ExceptAssistSlot, data.teamModel, awakerId
  end
  
  function view:SchoolBan(schoolId)
    local slot = CommonDefine.TeamAssign.MaxBattleNum
    local awakerList = data.teamModel:GetTeamAwakerTids()
    local schoolList = {}
    for i = 1, slot - 1 do
      local awakerId = awakerList[i]
      local awakerCfg = DT.AwakerConfig[awakerId]
      if awakerCfg then
        local awakerSchoolId = awakerCfg.School
        if not table.contains(schoolList, awakerSchoolId) then
          table.insert(schoolList, awakerSchoolId)
        end
      end
    end
    if table.contains(schoolList, schoolId) then
      return false
    end
    if #schoolList >= CommonDefine.TeamMixSchoolCount then
      return true
    end
    return false
  end
  
  function view:GetCurAssistData()
    return data.assistData
  end
  
  function view:GetAssistDataByAssistUid(assistUid)
    for _, assistData in ipairs(data.assistList) do
      if assistUid == assistData.assistUid then
        return assistData
      end
    end
    for _, assistData in ipairs(data.starAssistList) do
      if assistUid == assistData.assistUid then
        return assistData
      end
    end
    for _, assistData in ipairs(data.searchAssistList) do
      if assistUid == assistData.assistUid then
        return assistData
      end
    end
    return nil
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:SetSearchAssistList(list)
    data.searchAssistList = list
  end
  
  function action:SetCurSchoolId(schoolId)
    data.curSchoolId = schoolId
    data:UpdateShowList()
  end
  
  function action:UpdateShowList()
    local list = {}
    local teamTids = data.teamModel:GetTeamAwakerTids()
    local schoolId = data.curSchoolId
    local selectList = self:GetAwakerFilterMap()
    for _, assistData in ipairs(data.assistList) do
      local awakerData = assistData.awakerData
      local awakerCfg = DT.AwakerConfig[awakerData.tid]
      local awakerSchoolId = awakerCfg.School
      if (0 == schoolId or awakerSchoolId == schoolId) and selectList[awakerData.tid] then
        for i = 1, #teamTids - 1 do
          local awakerId = teamTids[i]
          if awakerData.tid == awakerId then
            break
          end
        end
        table.insert(list, assistData)
      end
    end
    local items = {}
    for _, assistData in pairs(list) do
      for _, item in pairs(assistData.items) do
        table.insert(items, item)
      end
    end
    ItemDataUtils.HandleMockDataLock = false
    ItemDataUtils.AddMockItemData(items)
    ItemDataUtils.OpenHandleMockDataLock(Urls.BattleAssistPanel)
    data.showlist = list
    print(" help flit.showlist : ", table.tostring(list))
  end
  
  function action:SetIsShowSortFilter(val)
    data.isShowSortFilter = val
  end
  
  function action:SetSortType(sortType)
    if not sortType then
      return
    end
    data.sortType = sortType
    data:UpdateShowList()
  end
  
  function action:SetSortOrder(order)
    data.sortOrder = order
    data:UpdateShowList()
  end
  
  function action:SetAssistAwaker2Team()
    local assistData = data:GetCurAssistData()
    data.teamModel:SetAssistData(assistData)
  end
  
  function action:ShowAssistAwakerDetail(assistUid)
    local assistData = data:GetAssistDataByAssistUid(assistUid)
    local awakerBasePanelData = {
      jumpPage = CommonDefine.AwakerPage.Detail,
      previewAwakersData = {
        awakers = {
          assistData.awakerData
        },
        items = assistData.items,
        hideAwakerChangeForm = true
      }
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  function action:UpdateSearchAssistPlayerInfo(assistData, name, relation)
    for _, singleData in ipairs(data.searchAssistList) do
      if assistData.assistUid == singleData.assistUid then
        if name then
          singleData.playerInfo.name = name
        end
        if relation then
          applyPlayerInfoRelationChange(singleData.playerInfo, relation)
        end
        break
      end
    end
  end
  
  function action:UpdateAssistPlayerInfo(assistData, name, relation)
    for _, singleData in ipairs(data.assistList) do
      if assistData.assistUid == singleData.assistUid then
        if name then
          singleData.playerInfo.name = name
        end
        if relation then
          applyPlayerInfoRelationChange(singleData.playerInfo, relation)
        end
        break
      end
    end
  end
  
  function action:UpdateAssistStarPlayerInfo(assistData, name, relation)
    for _, singleData in ipairs(data.starAssistList) do
      if assistData.assistUid == singleData.assistUid then
        if name then
          singleData.playerInfo.name = name
        end
        if relation then
          applyPlayerInfoRelationChange(singleData.playerInfo, relation)
        end
        break
      end
    end
  end
  
  function action:UpdateAssistStarAssist(assistData, isStarAssist)
    if not assistData then
      return
    end
    assistData.isStarAssist = isStarAssist
    local listKeys = {
      "assistList",
      "starAssistList",
      "searchAssistList"
    }
    for _, key in ipairs(listKeys) do
      for _, singleData in ipairs(data[key]) do
        if assistData.assistUid == singleData.assistUid then
          singleData.isStarAssist = isStarAssist
          break
        end
      end
    end
  end
  
  function action:AddAssistList(serverData, startIdx, endIdx)
    if not serverData then
      return
    end
    for index, singleData in ipairs(serverData) do
      local playerInfo = {
        uid = singleData.uid,
        name = singleData.name,
        lv = singleData.level,
        followerNum = singleData.followerNum,
        icon = singleData.icon,
        relation = singleData.relation
      }
      local assistData = {
        playerInfo = playerInfo,
        awakerData = singleData.assistAwakerData.awaker,
        assistUid = singleData.uid,
        items = singleData.assistAwakerData.items,
        isRecentUsed = singleData.isRecentUsed or false,
        isStarAssist = singleData.isStarAssist or false
      }
      data.assistList[index + startIdx - 1] = assistData
    end
    data:UpdateShowList()
  end
  
  function action:ClearAssistList()
    table.clear(data.assistList)
    self:SelectAssistUid(nil)
    data:UpdateShowList()
  end
  
  function action:UpdateStarAssist()
    local relationListMap = SocialDataUtils.GetRelationListByType(SocialDefine.RelationListType.StarAssist)
    if not relationListMap then
      return {}
    end
    data.starAssistList = {}
    for index, singleData in ipairs(relationListMap) do
      local playerInfo = {
        uid = singleData.uid,
        name = singleData.name,
        lv = singleData.level,
        followerNum = singleData.followerNum,
        icon = singleData.icon,
        relation = singleData.relation
      }
      local assistData = {
        playerInfo = playerInfo,
        awakerData = singleData.assistAwakerData.awaker,
        assistUid = singleData.uid,
        items = singleData.assistAwakerData.items,
        isRecentUsed = singleData.isRecentUsed or false,
        isStarAssist = true
      }
      ItemDataUtils.AddMockItemData(singleData.assistAwakerData.items)
      table.insert(data.starAssistList, assistData)
    end
    EventMgr.Instance.SocialStarAssistChanged:Dispatch(data.starAssistList)
  end
  
  function action:AddStarAssist(starAssistData)
    if not starAssistData then
      return
    end
    for _, assistData in ipairs(data.starAssistList) do
      if assistData.assistUid == starAssistData.assistUid then
        return
      end
    end
    starAssistData.isStarAssist = true
    local rst = {}
    table.insert(rst, starAssistData)
    table.merge(rst, data.starAssistList)
    data.starAssistList = rst
  end
  
  function action:RemoveStarAssist(starAssistData)
    if not starAssistData then
      return
    end
    local rst = {}
    for _, assistData in ipairs(data.starAssistList) do
      if assistData.assistUid ~= starAssistData.assistUid then
        table.insert(rst, assistData)
      end
    end
    data.starAssistList = rst
  end
  
  function action:CreateSearchStarAssistList(playerData, awakerData)
    if not playerData.facade or not awakerData then
      return nil
    end
    local rst = {}
    local facade = playerData.facade
    local playerInfo = {
      uid = facade.uid,
      name = facade.name,
      lv = facade.level,
      followerNum = playerData.followerNum or facade.followerNum or 0,
      icon = facade.icon,
      relation = facade.relation
    }
    local assistData = {
      playerInfo = playerInfo,
      awakerData = awakerData.awaker,
      assistUid = facade.uid,
      items = awakerData.items,
      isRecentUsed = facade.isRecentUsed or false,
      isStarAssist = facade.isStarAssist or false
    }
    table.insert(rst, assistData)
    ItemDataUtils.AddMockItemData(awakerData.items)
    return rst
  end
  
  function action:SelectAssistUid(uid)
    data.assistUid = uid
    data.assistData = nil
    for _, assistData in ipairs(data.assistList) do
      if data.assistUid == assistData.assistUid then
        data.assistData = assistData
        break
      end
    end
  end
  
  function action:GetAwakerFilterMap()
    local ret = {}
    local tmpList = AssistFilterModel.Instance.selectList or AssistFilterModel.Instance:ResetSelect()
    for awakerTid, _ in pairs(tmpList) do
      ret[awakerTid] = 1
    end
    return ret
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("BattleAssistModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("BattleAssistModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("BattleAssistModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("BattleAssistModel", modelState):views(modelView):actions(modelAction), onSetup
