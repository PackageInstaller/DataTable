local this = class("moduleMapExplorePanel", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _exploreTpl = L_GameTpl:getExploreTpl()
local _exploreLevelTpl = L_GameTpl:getExploreLevelTpl()
local exploreCategory = {
  [1] = {
    moduleName = "moduleExploreGroup_play",
    name = "ui_moduleMapExplorePanel_01"
  },
  [2] = {
    moduleName = "moduleExploreGroup_play",
    name = "ui_moduleMapExplorePanel_02"
  },
  [3] = {
    moduleName = "moduleExploreGroup_boss",
    name = "ui_moduleMapExplorePanel_03"
  },
  [4] = {
    moduleName = "moduleExploreGroup_sight",
    name = "ui_moduleMapExplorePanel_04"
  }
}
local tips = {
  [1] = "explore_reward_on",
  [2] = "explore_reward_complete"
}
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V"
}

function this.bind()
  return {
    active_finishImg = false,
    active_decImg = false,
    txt_exploreName = "",
    list_finishText = {
      moduleName = "pages/explore/cell/cellExploreTxt"
    },
    rewardProcess = 0,
    toggleHaveReward = true,
    list_exploreGroup = {
      moduleName = "pages/explore/cell/cellExploreGroupContent"
    },
    txt_tips = "",
    txt_fly_reward = "",
    go_fly_reward = false
  }
end

function this.methods()
  return {
    onClick_receiveReward = function(self)
      if table.isEmpty(self.explorationMapInfo) then
        return
      end
      local allTpl = _exploreLevelTpl:getExploreRewardTplByMapId(self.sceneId)
      local rewardIds = {}
      for i, v in pairs(allTpl) do
        if self.explorationMapInfo.lv >= _exploreLevelTpl:getLv(v) then
          rewardIds[_exploreLevelTpl:getId(v)] = _exploreLevelTpl:getId(v)
        end
      end
      local haveReward = L_WorldExploreStore:getExploreHaveRewards(rewardIds, self.sceneId)
      if haveReward then
        L_WorldExploreStore:req_worldExploreReward(self.sceneId)
      else
        local list, index = self:getRewardList(self.explorationMapInfo)
        L_UI:open("pageCommonRewardsTip", {
          title = L_WordsTpl:getValue("ui_common_rewardlist_title_explore"),
          module_list = list,
          selectIndex = index
        })
      end
    end,
    onClick_rewardDetail = function(self)
      local list, index = self:getRewardList(self.explorationMapInfo)
      L_UI:open("pageCommonRewardsTip", {
        title = L_WordsTpl:getValue("ui_common_rewardlist_title_explore"),
        module_list = list,
        selectIndex = index
      })
    end
  }
end

function this:open()
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.OnEvent_ExplorationSync, self)
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.MapExploreReward, self.OnEvent_ExplorationSync, self)
end

function this:close()
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.OnEvent_ExplorationSync)
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.MapExploreReward, self.OnEvent_ExplorationSync)
end

function this:refresh()
end

function this:setMapExploreData(sceneId)
  local explorationMapInfo = L_WorldExploreStore:getExploreInfo(sceneId)
  self.explorationMapInfo = explorationMapInfo
  self.sceneId = sceneId
  if table.isEmpty(explorationMapInfo) then
    return
  end
  local data = _exploreTpl:getExploreTplByMapId(explorationMapInfo.map_id)
  if table.isEmpty(data) then
    return
  end
  self.mapData = {}
  local isAllFinish = not math.isEmpty(explorationMapInfo.time)
  self.bind.active_finishImg = isAllFinish
  self.bind.active_decImg = not isAllFinish
  local statusTxt = isAllFinish and L_WordsTpl:getValue("ui_moduleMapExplorePanel_05") or L_WordsTpl:getValue("notice_pageBigMap_03", {
    [0] = levelText[explorationMapInfo.lv]
  })
  local allTpl = _exploreLevelTpl:getExploreRewardTplByMapId(sceneId)
  local rewardIds = {}
  local canRewardIds = {}
  for i, v in pairs(allTpl) do
    rewardIds[_exploreLevelTpl:getId(v)] = _exploreLevelTpl:getId(v)
    if self.explorationMapInfo.lv >= _exploreLevelTpl:getLv(v) then
      canRewardIds[_exploreLevelTpl:getId(v)] = _exploreLevelTpl:getId(v)
    end
  end
  if not L_WorldExploreStore:getExploreHaveRewards(rewardIds, sceneId) and explorationMapInfo.lv >= #allTpl then
    self.bind.toggleHaveReward = false
  else
    self.bind.toggleHaveReward = true
  end
  self.bindComponents.rewardAnim.enabled = L_WorldExploreStore:getExploreHaveRewards(canRewardIds, self.sceneId)
  local curLevel = explorationMapInfo.lv
  if curLevel >= #allTpl then
    self.bind.rewardProcess = 1
    self.bind.txt_tips = L_WordsTpl:getValue(tips[2])
  else
    local tpl = _exploreLevelTpl:getExploreRewardTplByMapId(sceneId, curLevel + 1)
    self.bind.rewardProcess = (explorationMapInfo.exp or 0) / _exploreLevelTpl:getExp(tpl)
    self.bind.txt_tips = L_WordsTpl:getValue(tips[1], {
      [0] = _exploreLevelTpl:getExp(tpl) - (explorationMapInfo.exp or 0)
    })
  end
  local tpl = _worldCityTpl:getTplById(explorationMapInfo.map_id)
  if tpl then
    self.bind.txt_exploreName = string.format("%s%s", _worldCityTpl:getCity(tpl), statusTxt)
  else
    self.bind.txt_exploreName = ""
  end
  for i, v in pairs(data) do
    if self.mapData[_exploreTpl:getCategory(v)] == nil then
      self.mapData[_exploreTpl:getCategory(v)] = {}
    end
    table.insert(self.mapData[_exploreTpl:getCategory(v)], v)
  end
  local tmp = {}
  for i, v in pairs(self.mapData) do
    table.insert(tmp, {
      category = i,
      groupData = v,
      name = L_WordsTpl:getValue(exploreCategory[i].name),
      module = exploreCategory[i].moduleName
    })
  end
  self.bind.list_exploreGroup:clear()
  self.bind.list_exploreGroup:insert_array(tmp)
  local timeStamp = explorationMapInfo.time or 0
  self.bind.list_finishText:clear()
  if not math.isEmpty(timeStamp) then
    local timeStr = L_TimeUtil.getDisplayTimeCustom(math.ceil(timeStamp), "!%Y.%m.%d")
    local txt_data = {}
    for i = 1, #timeStr do
      table.insert(txt_data, {
        txt = timeStr:sub(i, i),
        index = i
      })
    end
    self.bind.list_finishText:insert_array(txt_data)
  end
  local fly_unlcok_level = self:getLockFlyData(allTpl)
  if fly_unlcok_level <= explorationMapInfo.lv then
    self.bind.go_fly_reward = false
  else
    self.bind.go_fly_reward = true
    local explorationMapInfo = L_WorldExploreStore:getExploreInfo(self.sceneId)
    local tpl = L_GameTpl:getWorldCityTpl():getTplById(explorationMapInfo.map_id)
    local name = L_GameTpl:getWorldCityTpl():getCity(tpl)
    self.bind.txt_fly_reward = L_WordsTpl:getValue("notice_ui_fly_forbidden", {
      [0] = fly_unlcok_level,
      [1] = name
    })
  end
end

function this:OnEvent_ExplorationSync()
  local explorationMapInfo = L_WorldExploreStore:getExploreInfo(self.sceneId)
  if table.isEmpty(explorationMapInfo) then
    return
  end
  local allTpl = _exploreLevelTpl:getExploreRewardTplByMapId(self.sceneId)
  local rewardIds = {}
  for i, v in pairs(allTpl) do
    rewardIds[_exploreLevelTpl:getId(v)] = _exploreLevelTpl:getId(v)
  end
  if not L_WorldExploreStore:getExploreHaveRewards(rewardIds, self.sceneId) and explorationMapInfo.lv >= #allTpl then
    self.bind.toggleHaveReward = false
  else
    self.bind.toggleHaveReward = true
  end
end

function this:getLockFlyData(data)
  local level = 1
  for i, v in pairs(data) do
    if _exploreLevelTpl:getLffly(v) == 1 then
      level = _exploreLevelTpl:getLv(v)
      break
    end
  end
  return level
end

function this:getRewardList(data)
  local tmp = {}
  local explorationMapInfo = data
  local rewardData = _exploreLevelTpl:getExploreRewardTplByMapId(explorationMapInfo.map_id)
  table.sort(rewardData, function(a, b)
    return _exploreLevelTpl:getLv(a) < _exploreLevelTpl:getLv(b)
  end)
  local voidIndex = 0
  local index = 0
  for i, v in ipairs(rewardData) do
    if not table.isEmpty(_exploreLevelTpl:getReward(v)) then
      voidIndex = voidIndex + 1
      local rewardItems = {}
      local sceneId = explorationMapInfo.map_id
      local id = _exploreLevelTpl:getId(v)
      local isReceived = L_WorldExploreStore:getExploreGotId(id, sceneId)
      local item_list = L_DataUtil.parseRewardConfig(_exploreLevelTpl:getReward(v))
      for i, item in ipairs(item_list) do
        table.insert(rewardItems, {
          itemType = item.itemType,
          itemId = item.itemId,
          num = item.itemNum,
          received = isReceived
        })
      end
      local select = false
      if explorationMapInfo.lv + 1 == _exploreLevelTpl:getLv(v) then
        select = true
        index = voidIndex
      end
      local fly_reward = string.empty
      if _exploreLevelTpl:getLffly(v) == explorationMapInfo.lv then
        fly_reward = L_WordsTpl:getValue("residual_code_modulemapexplorepanel_01")
      end
      table.insert(tmp, {
        isStar = false,
        number = "",
        reward_icon = _exploreLevelTpl:getExploreLevel(v),
        rewardList = rewardItems,
        isSelect = select,
        reward_tips = fly_reward,
        txt_content = L_WordsTpl:getValue("ui_common_rewardlist_desc_explore")
      })
    end
  end
  return tmp, index
end

return this
