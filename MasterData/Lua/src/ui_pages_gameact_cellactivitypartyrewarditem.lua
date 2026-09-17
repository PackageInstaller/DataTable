local this = class("cellActivityPartyRewardItem", G_UIModuleBase)
local _GameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
local ShowTypeId = 102
local LevelColor = C_LuaUtility.ParseHtmlStringColor("#24344E")
local StarColor = C_LuaUtility.ParseHtmlStringColor("#806E5B")
local LevelAlpha = 0.7
local StarAlpha = 1.0

local function getProgressTextValue(value)
  value = tonumber(value) or 0
  if math.floor(value) == value then
    return tostring(math.floor(value))
  end
  return tostring(value)
end

local function getPartyRewardProgress(bind)
  local showProgress = bind and bind.partyRewardShowProgressText
  if bind == nil or showProgress ~= true and tonumber(showProgress) ~= 1 then
    return nil, nil
  end
  local currentValue = tonumber(bind.partyRewardProgressCurrent)
  local maxValue = tonumber(bind.partyRewardProgressMax)
  if currentValue == nil or maxValue == nil or maxValue <= 0 then
    return nil, nil
  end
  return currentValue, maxValue
end

local function disableComponentRaycast(component)
  if component and component.raycastTarget ~= nil then
    component.raycastTarget = false
  end
end

local function setComponentGameObjectActive(component, active)
  if component and component.gameObject then
    component.gameObject:SetActive(active)
  end
end

local function setTransformGameObjectActive(transform, active)
  if transform and transform.gameObject then
    transform.gameObject:SetActive(active)
  end
end

local function findChildByNameDeep(root, name)
  if not root or not name then
    return nil
  end
  if root.name == name then
    return root
  end
  local childCount = root.childCount or 0
  for i = 0, childCount - 1 do
    local child = root:GetChild(i)
    local result = findChildByNameDeep(child, name)
    if result then
      return result
    end
  end
  return nil
end

local function disableCellTextRaycast(bindComponents)
  if not bindComponents then
    return
  end
  disableComponentRaycast(bindComponents.txt_title)
  disableComponentRaycast(bindComponents.txt_reward_info_color)
  disableComponentRaycast(bindComponents.txt_icon_level)
  disableComponentRaycast(bindComponents.txt_icon_star)
end

local ColorStateMap = {
  img_TitleColor = {"#6289CC", "#8aa2c8"},
  txt_img_TitleColor = {"#6289CC", "#8aa2c8"},
  txt_reward_infoColor = {"#3b5b91", "#8aa2c8"},
  txt_MinTextColor = {"#AC5CA6", "#ccaac9"},
  txt_DecoColor = {"#AC5CA6", "#ccaac9"},
  txt_MaxTextColor = {"#AC5CA6", "#ccaac9"}
}
local ItemStateBgNodeMap = {
  [L_Const.ActivityRewardState.ARS_NONE] = {
    name = "go_OngoingBg",
    node = nil
  },
  [L_Const.ActivityRewardState.ARS_REWARDED] = {
    name = "go_CompleteBg",
    node = nil
  },
  [L_Const.ActivityRewardState.ARS_FINISH] = {
    name = "go_RewardBg",
    node = nil
  }
}

function this.bind()
  return {
    txt_title = "",
    reward_list = {
      moduleName = "modulePages/cellIconBag"
    },
    item_id = 0,
    img_bg_reward_up_level = false,
    img_bg_reward_up_star = false,
    img_bg_reward_up_level_fill = 1,
    img_bg_reward_up_mask_level_fill = 1,
    img_bg_reward_up_star_fill = 0,
    img_bg_reward_up_mask_star_fill = 0,
    btn_reward = false,
    txt_icon_level = "",
    txt_icon_star = "",
    info_alpha = 1.0,
    partyRewardShowProgressText = 0,
    partyRewardProgressCurrent = nil,
    partyRewardProgressMax = nil,
    mintxt = "",
    maxtxt = "",
    img_TitleColor = "",
    txt_reward_infoColor = "",
    txt_MinTextColor = "",
    txt_DecoColor = "",
    txt_MaxTextColor = "",
    txt_img_TitleColor = ""
  }
end

function this.methods()
  return {
    onClick_get = function(self)
      if self.bind.reward_state ~= L_Const.ActivityRewardState.ARS_FINISH then
        return
      end
      self:receivedAllRewards()
    end
  }
end

function this:open()
  for _, info in pairs(ItemStateBgNodeMap) do
    local stateNode = self.gameObject.transform:Find("Root/" .. info.name)
    info.node = stateNode.gameObject
  end
  local rewardId = self.bind.reward_id or self.bind.item_id
  local tpl = rewardId and _GameEventRewardTpl:getTplById(rewardId) or nil
  disableCellTextRaycast(self.bindComponents)
  local title = self.bind.txt_title or ""
  local progressCurrent, progressMax = getPartyRewardProgress(self.bind)
  local showType = self.bind.partyRewardShowType or tpl and _GameEventRewardTpl:getShowType(tpl) or 0
  local targetValue = tonumber(self.bind.partyRewardTargetValue)
  if targetValue == nil then
    targetValue = tpl and tonumber(_GameEventRewardTpl:getPara(tpl)) or 0
  end
  local groupId = self.bind.partyRewardTplGroupId
  if groupId == nil and tpl then
    groupId = _GameEventRewardTpl:getGroupId(tpl)
  end
  local rewardShowList = self.bind.partyRewardRewardShowList
  if rewardShowList == nil and tpl then
    rewardShowList = _GameEventRewardTpl:getRewardShow(tpl)
  end
  rewardShowList = rewardShowList or {}
  for _, cfg in pairs(rewardShowList) do
    cfg.isReceived = self.bind.reward_state == L_Const.ActivityRewardState.ARS_REWARDED
  end
  title = title ~= "" and title or tpl and _GameEventRewardTpl:getDescription(tpl) or ""
  if self.bind.mintxt ~= "" and self.bind.maxtxt ~= "" then
  elseif progressCurrent ~= nil and progressMax ~= nil then
    self.bind.mintxt = getProgressTextValue(progressCurrent)
    self.bind.maxtxt = getProgressTextValue(progressMax)
  else
    self.bind.mintxt = ""
    self.bind.maxtxt = ""
  end
  if showType == ShowTypeId then
    local starNum = groupId and self:getCurrentStarNum(groupId) or 0
    local MaxStarNum = targetValue or 0
    if starNum > MaxStarNum then
      starNum = MaxStarNum
    end
    self.bind.img_bg_reward_up_level = false
    self.bind.img_bg_reward_up_star = true
    local fillAmount = 0 < MaxStarNum and starNum / MaxStarNum or 0
    self.bind.img_bg_reward_up_star_fill = fillAmount
    self.bind.img_bg_reward_up_mask_star_fill = fillAmount
    self.bindComponents.txt_reward_info_color.color = StarColor
    self.bind.info_alpha = StarAlpha
  else
    self.bind.img_bg_reward_up_level_fill = 1
    self.bind.img_bg_reward_up_mask_level_fill = 1
    self.bind.img_bg_reward_up_level = true
    self.bind.img_bg_reward_up_star = false
    self.bindComponents.txt_reward_info_color.color = LevelColor
    self.bind.info_alpha = LevelAlpha
  end
  self:refreshTitle(title)
  self:refreshState(self.bind.reward_state)
  self:refreshRewardList(rewardShowList)
  self.bind.item_id = rewardId or 0
  self.bindComponents.tab_anim.enabled = false
  self.timer = Timer.once(0.7, function()
    self.bindComponents.tab_anim.enabled = true
    Timer.remove(self.timer)
    self.timer = nil
  end, self)
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:getCurrentStarNum(id)
  local allStarNum = 0
  local kibodeulTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local eventDataList = kibodeulTpl:getData()
  for _, v in pairs(eventDataList) do
    if v.groupId == id then
      local level_id = kibodeulTpl:getKiboDuelId(v)
      local starData = L_PetDuelStore:getKiBoDuelStar(level_id)
      if starData ~= nil then
        for _, k in pairs(starData) do
          if k then
            allStarNum = allStarNum + 1
          end
        end
      end
    end
  end
  return allStarNum
end

function this:setRefreshCallback(callback)
  self.refreshCallback = callback
end

function this:refreshTitle(title)
  self.bind.txt_title = title
end

function this:refreshRewardList(rewardList)
  if rewardList ~= nil then
    local ok = pcall(function()
      self.bind.reward_list:clear()
      self.bind.reward_list:insert_array(rewardList)
    end)
    if not ok then
      return
    end
  end
end

function this:ensurePartyStatusRefs()
  if self._partyStatusRefsReady then
    return
  end
  self._partyStatusRefsReady = true
  local root = self.gameObject and self.gameObject.transform or nil
  self._goOngoing = findChildByNameDeep(root, "go_Ongoing")
  self._goOngoingBg = findChildByNameDeep(root, "go_OngoingBg")
  self._goComplete = findChildByNameDeep(root, "go_Complete")
  self._goCompleteBg = findChildByNameDeep(root, "go_CompleteBg")
end

function this:refreshState(state)
  self.bind.btn_reward = state == L_Const.ActivityRewardState.ARS_FINISH
  self:ensurePartyStatusRefs()
  local showOngoing = state == L_Const.ActivityRewardState.ARS_NONE
  local showComplete = state == L_Const.ActivityRewardState.ARS_REWARDED
  setTransformGameObjectActive(self._goOngoing, showOngoing)
  setTransformGameObjectActive(self._goOngoingBg, showOngoing)
  setTransformGameObjectActive(self._goComplete, showComplete)
  setTransformGameObjectActive(self._goCompleteBg, showComplete)
  for _state, info in pairs(ItemStateBgNodeMap) do
    info.node:SetActive(_state == state)
  end
  local colorIndex = showComplete and 2 or 1
  for key, arr in pairs(ColorStateMap) do
    self.bind[key] = C_LuaUtility.ParseHtmlStringColor(arr[colorIndex])
  end
  if state == L_Const.ActivityRewardState.ARS_NONE then
    self.bind.txt_icon_level = L_WordsTpl:getValue("ui_novice_task_inprogress")
    self.bind.txt_icon_star = L_WordsTpl:getValue("ui_novice_task_inprogress")
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_level, true)
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_star, true)
  elseif state == L_Const.ActivityRewardState.ARS_REWARDED then
    self.bind.txt_icon_level = L_WordsTpl:getValue("ui_novice_task_complete")
    self.bind.txt_icon_star = L_WordsTpl:getValue("ui_novice_task_complete")
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_level, true)
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_star, true)
  else
    self.bind.txt_icon_level = ""
    self.bind.txt_icon_star = ""
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_level, false)
    setComponentGameObjectActive(self.bindComponents and self.bindComponents.txt_icon_star, false)
  end
end

function this:receivedAllRewards()
  if self.bind.partyRewardUsePageClaim == true then
    local claimRewardIds = self.bind.partyRewardClaimIds or {}
    if self.bind.reward_group_id ~= nil and self.bind.reward_group_id ~= 0 and 0 < #claimRewardIds then
      L_GameEventStore:req_CsProtoActivityReward(self.bind.reward_group_id, claimRewardIds, function(data)
        local rewards = require("ui.manager.reward.rewardData").new()
        rewards.rewardShowType = L_Const.rewardShowType.full
        local data = L_DataUtil.parseRewardConfig(data.rewards, true, true)
        rewards:constructList(data)
        L_RewardManager:ShowReward(rewards)
        L_EntrustStore:call(L_EntrustStore.event.entrustRewardRefresh)
      end)
    end
    return
  end
  local rewards = L_GameEventStore:getGameEventData(self.bind.reward_group_id):getRewardStateList()
  local tmp_list = {}
  for _, v in pairs(rewards) do
    if v.reward_show_type == self.bind.reward_show_type and v.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      table.insert(tmp_list, v.reward_id)
    end
  end
  if self.bind.reward_group_id ~= nil or self.bind.reward_group_id ~= 0 then
    L_GameEventStore:req_CsProtoActivityReward(self.bind.reward_group_id, tmp_list, function(data)
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local data = L_DataUtil.parseRewardConfig(data.rewards, true, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards)
      L_EntrustStore:call(L_EntrustStore.event.entrustRewardRefresh)
    end)
  end
end

return this
