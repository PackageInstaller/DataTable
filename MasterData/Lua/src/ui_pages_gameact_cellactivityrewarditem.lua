local this = class("cellActivityRewardItem", G_UIModuleBase)
local _GameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
local ShowTypeId = 102
local StarShowContent = [[

(%s/%s)]]
local LevelColor = C_LuaUtility.ParseHtmlStringColor("#24344E")
local StarColor = C_LuaUtility.ParseHtmlStringColor("#806E5B")
local LevelAlpha = 0.7
local StarAlpha = 1.0

function this.bind()
  return {
    txt_title = "",
    reward_list = {
      moduleName = "modulePages/cellIconBag"
    },
    item_id = 0,
    img_bg_reward_up_level = false,
    img_bg_reward_up_mask_level = true,
    img_bg_reward_up_star = false,
    img_bg_reward_up_mask_star = true,
    img_bg_reward_up_level_fill = 1,
    img_bg_reward_up_mask_level_fill = 1,
    img_bg_reward_up_star_fill = 0,
    img_bg_reward_up_mask_star_fill = 0,
    btn_reward = false,
    txt_icon_level = "",
    txt_icon_star = "",
    info_alpha = 1.0
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
  local tpl = _GameEventRewardTpl:getTplById(self.bind.reward_id)
  local title = _GameEventRewardTpl:getDescription(tpl)
  if _GameEventRewardTpl:getShowType(tpl) == ShowTypeId then
    local starNum = self:getCurrentStarNum(_GameEventRewardTpl:getGroupId(tpl))
    local MaxStarNum = _GameEventRewardTpl:getPara(tpl)
    if starNum > MaxStarNum then
      starNum = MaxStarNum
    end
    title = title .. string.format(StarShowContent, starNum, MaxStarNum)
    self.bind.img_bg_reward_up_level = false
    self.bind.img_bg_reward_up_mask_level = false
    self.bind.img_bg_reward_up_star = true
    self.bind.img_bg_reward_up_mask_star = self.bind.reward_state == L_Const.ActivityRewardState.ARS_FINISH
    self.bind.img_bg_reward_up_star_fill = starNum / MaxStarNum
    self.bind.img_bg_reward_up_mask_star_fill = starNum / MaxStarNum
    self.bindComponents.txt_reward_info_color.color = StarColor
    self.bind.info_alpha = StarAlpha
  else
    self.bind.img_bg_reward_up_level = true
    self.bind.img_bg_reward_up_mask_level = self.bind.reward_state == L_Const.ActivityRewardState.ARS_FINISH
    self.bind.img_bg_reward_up_star = false
    self.bind.img_bg_reward_up_mask_star = false
    self.bindComponents.txt_reward_info_color.color = LevelColor
    self.bind.info_alpha = LevelAlpha
  end
  self:refreshTitle(title)
  self:refreshState(self.bind.reward_state)
  local rewardShowList = _GameEventRewardTpl:getRewardShow(tpl)
  self:refreshRewardList(rewardShowList)
  self.bind.item_id = self.bind.reward_id
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

function this:sortRewardList(rewardsData)
  local result = {}
  for _, v in pairs(rewardsData) do
    local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
    table.insert(result, {
      itemType = v.itemType,
      itemId = v.itemId,
      itemNum = v.itemNum,
      quality = item.quality or 0
    })
  end
  table.sort(result, function(a, b)
    if a.quality == b.quality then
      if a.itemType == b.itemType then
        return a.itemId < b.itemId
      else
        return a.itemType < b.itemType
      end
    else
      return a.quality > b.quality
    end
  end)
  return result
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
    self.bind.reward_list:clear()
    self.bind.reward_list:insert_array(rewardList)
  end
end

function this:refreshState(state)
  self.bind.btn_reward = state == L_Const.ActivityRewardState.ARS_FINISH
  if state == L_Const.ActivityRewardState.ARS_NONE then
    self.bind.txt_icon_level = L_WordsTpl:getValue("ui_novice_task_inprogress")
    self.bind.txt_icon_star = L_WordsTpl:getValue("ui_novice_task_inprogress")
  elseif state == L_Const.ActivityRewardState.ARS_REWARDED then
    self.bind.txt_icon_level = L_WordsTpl:getValue("ui_novice_task_complete")
    self.bind.txt_icon_star = L_WordsTpl:getValue("ui_novice_task_complete")
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
