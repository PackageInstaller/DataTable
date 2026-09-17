local this = class("cellActivityMainTaskReward", G_UIModuleBase)
local _GameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
local ShowTypeId = 102

function this.bind()
  return {
    txt_desc1 = "",
    txt_desc2 = "",
    img_reward = "",
    img_reward_b = "",
    txt_rewardNum = "",
    go_complete = false,
    go_canget = false,
    go_normal = false,
    color_icon = C_Color.white,
    color_iconB = C_Color(0.1058824, 0.4862745, 1, 0.7490196),
    color_txtNum = C_Color(0.3098039, 0.3294118, 0.345098, 1),
    color_txtName = C_Color(0.3686275, 0.3764706, 0.4470588, 1)
  }
end

function this.methods()
  return {
    onClick_reward = function(self)
      L_ItemTplManager:showInfoTip(self._itemType, self._itemId)
    end,
    onClick_Btn = function(self)
      if self.bind.reward_state ~= L_Const.ActivityRewardState.ARS_FINISH then
        return
      end
      self:receivedAllRewards()
    end
  }
end

function this:open()
end

function this:refresh()
  local itemId = self.bind.reward_id
  local tpl = _GameEventRewardTpl:getTplById(self.bind.reward_id)
  local title = _GameEventRewardTpl:getDescription(tpl)
  self.bind.txt_desc1 = title
  local rewardShowList = _GameEventRewardTpl:getRewardShow(tpl)
  if rewardShowList[1] then
    local item = L_ItemTplManager:getItemConfig(rewardShowList[1].itemType, rewardShowList[1].itemId)
    self.bind.img_reward = item.icon
    self.bind.img_reward_b = item.icon
    self.bind.txt_rewardNum = "x" .. tostring(rewardShowList[1].itemNum)
    self._itemType = rewardShowList[1].itemType
    self._itemId = rewardShowList[1].itemId
  end
  self:refreshState(self.bind.reward_state)
end

function this:refreshState(state)
  self.bind.go_complete = state == L_Const.ActivityRewardState.ARS_REWARDED
  self.bind.go_canget = state == L_Const.ActivityRewardState.ARS_FINISH
  self.bind.go_normal = state ~= L_Const.ActivityRewardState.ARS_FINISH
  local showState = state == L_Const.ActivityRewardState.ARS_REWARDED
  self.bind.color_icon = showState and C_Color(1, 1, 1, 0.6) or C_Color(1, 1, 1, 1)
  self.bind.color_iconB = showState and C_Color(0.1058824, 0.4862745, 1, 0.4509804) or C_Color(0.1058824, 0.4862745, 1, 0.7490196)
  self.bind.color_txtNum = showState and C_Color(0.3098039, 0.3294118, 0.345098, 0.5) or C_Color(0.3098039, 0.3294118, 0.345098, 1)
  self.bind.color_txtName = showState and C_Color(0.5411765, 0.5529412, 0.6470588, 1) or C_Color(0.3686275, 0.3764706, 0.4470588, 1)
end

function this:receivedAllRewards()
  local rewards = L_GameEventStore:getGameEventData(self.bind.reward_group_id):getRewardStateList()
  local tmp_list = {}
  for _, v in pairs(rewards) do
    if v.reward_show_type == self.bind.reward_show_type and v.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      table.insert(tmp_list, v.reward_id)
    end
  end
  if self.bind.reward_group_id ~= nil or self.bind.reward_group_id ~= 0 then
    L_GameEventStore:req_CsProtoActivityReward(self.bind.reward_group_id, tmp_list, function(data)
      L_RewardManager:showPage(data.rewards, data.src)
    end)
  end
end

return this
