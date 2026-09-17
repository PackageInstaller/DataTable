local this = class("pageAchievementGroup", G_UIPageBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()
local QUALITYTOIMG = {
  [L_Const.quality.n] = "Atlas/Achievement/tex_achievement_icon_chenjiuton",
  [L_Const.quality.r] = "Atlas/Achievement/tex_achievement_icon_chenjiuyin",
  [L_Const.quality.sr] = "Atlas/Achievement/tex_achievement_icon_chenjiujin"
}

function this.bind()
  return {
    fill_progress = 0,
    txt_progress = "",
    go_reward = true,
    go_complete = false,
    module_icon = L_Const.ModuleInfo.CellIcon,
    go_rewardCanCollect = false,
    scrollList_achievementGroup = {
      moduleName = "pages/achievement/cellAchievementItem"
    },
    scrollList_achieveTog = {
      moduleName = "pages/achievement/cellAchieveTogItem"
    },
    itemIndex_achieveTog = -3
  }
end

function this.methods()
  return {
    onClick_collectGroupReward = function(self)
      L_AchievementUtil.req_collectAchievementGroupReward(self._selectGroupId, function(itemList, src)
        if not table.isEmpty(itemList) then
          L_RewardManager:showPage(itemList, src)
        end
      end)
    end,
    scrollList_achieveTog = {
      onClick_select = function(self, cell)
        if not cell.bind.go_active then
          self.bind.itemIndex_achieveTog = cell.uiBinding:GetComponent(typeof(CS.Lens.Framework.UI.LoopListViewItem2)).ItemIndex
          self._selectGroupId = cell.bind.id
          self:initAchievementList()
          self:setTogListActive()
        end
      end
    },
    scrollList_achievementGroup = {
      onClick_collect = function(self, guid)
        L_AchievementUtil.req_collectAchievementReward(guid, function(itemList, src)
          if not table.isEmpty(itemList) then
            L_RewardManager:showPage(itemList, src)
          end
        end)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._onRefreshAchievementList = handler(self, self.onEvent_refreshAchievementList)
  C_AchievementEvent.instance:Listen(C_EAchievementEvent.RefreshAchievementList, self._onRefreshAchievementList)
  self._selectGroupId = options.groupId
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  if self._onRefreshAchievementList then
    C_AchievementEvent.instance:Cancel(C_EAchievementEvent.RefreshAchievementList, self._onRefreshAchievementList)
  end
end

function this:show()
  for i, v in pairs(self.modules.scrollList_achieveTog) do
    local cell = v
    cell:registerReddot()
  end
end

function this:initPage()
  self:initAchievementGroupList()
  self:initAchievementList()
end

function this:initAchievementGroupList()
  local achievementGroup_config = _achievementGroupTpl.data
  local list = {}
  for k, v in pairs(achievementGroup_config) do
    local isOn = false
    if v.id == self._selectGroupId then
      isOn = true
    end
    table.insert(list, {
      configData = v,
      textChoice = _achievementGroupTpl:getAchiName(v),
      text = _achievementGroupTpl:getAchiName(v),
      id = v.id
    })
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  local index = 1
  for i, v in ipairs(list) do
    if self._selectGroupId == v.id then
      index = i
      break
    end
  end
  self.bind.scrollList_achieveTog:clear()
  self.bind.scrollList_achieveTog:insert_array(list)
  self.bind.itemIndex_achieveTog = index - 1
  self:setTogListActive()
end

function this:setTogListActive()
  for i, v in pairs(self.modules.scrollList_achieveTog) do
    v:setActive(self._selectGroupId)
  end
end

function this:initAchievementList()
  self._achievementList = {}
  local achievement_server = L_AchievementUtil.getAchievementListByGroupId(self._selectGroupId)
  local tplList = _achievementTpl:getTplListByGroupId(self._selectGroupId)
  for i, tpl in pairs(tplList) do
    if math.isEmpty(_achievementTpl:getFirstAchi(tpl)) or _achievementTpl:getFirstAchi(tpl) == _achievementTpl:getId(tpl) then
      table.insert(self._achievementList, {
        configData = tpl,
        img_quality = QUALITYTOIMG[_achievementTpl:getAchiLevel(tpl)],
        txt_name = _achievementTpl:getAchiName(tpl),
        txt_condition = _achievementTpl:getAchiDesc(tpl),
        txt_progress = string.format("0/%s", _achievementTpl:getParam(tpl)),
        itemType = _achievementTpl:getReward(tpl)[1][1],
        itemId = _achievementTpl:getReward(tpl)[1][2],
        itemNum = _achievementTpl:getReward(tpl)[1][3]
      })
    end
  end
  for i, v in pairs(self._achievementList) do
    for i2, v2 in pairs(achievement_server) do
      local id = _achievementTpl:getId(v.configData)
      local tpl = _achievementTpl:getTplById(v2.achievementId)
      if id == v2.achievementId or id == _achievementTpl:getFirstAchi(tpl) then
        local count = math.clamp(v2.count[1], 0, _achievementTpl:getParam(tpl))
        self._achievementList[i] = {
          configData = tpl,
          serverData = v2,
          img_quality = QUALITYTOIMG[_achievementTpl:getAchiLevel(tpl)],
          txt_name = _achievementTpl:getAchiName(tpl),
          txt_condition = _achievementTpl:getAchiDesc(tpl),
          go_slider = not v2.isReward,
          value_slider = count / _achievementTpl:getParam(tpl),
          not_slider = 1 - count / _achievementTpl:getParam(tpl),
          go_reward = not v2.isReward,
          completed = v2.isReward,
          txt_completeTime = v2.isReward and L_TimeUtil.getDisplayTime(v2.finishTime, L_TimeUtil.TimeFormat.YMD) or "",
          txt_progress = string.format("%s/%s", count, _achievementTpl:getParam(tpl)),
          go_rewardCanCollect = not v2.isReward and L_AchievementUtil.getStore():GetIsAchievementCompleted(v2.achievementId),
          itemType = _achievementTpl:getReward(tpl)[1][1],
          itemId = _achievementTpl:getReward(tpl)[1][2],
          itemNum = _achievementTpl:getReward(tpl)[1][3]
        }
      end
    end
  end
  self:initAchievementGroupInfo()
  self:showAchievementList()
end

function this:initAchievementGroupInfo()
  local tpl = _achievementGroupTpl:getTplById(self._selectGroupId)
  local finishCount = L_AchievementUtil.getStore():GetFinishCountOfGroup(self._selectGroupId)
  local tplList = _achievementTpl:getTplListByGroupId(self._selectGroupId)
  local finish_rate = finishCount / #tplList
  self.bind.fill_progress = finish_rate
  self.bind.txt_progress = string.format("%s %.0f", _achievementGroupTpl:getAchiName(tpl), finish_rate * 100) .. "%"
  local hasReward = not table.isEmpty(_achievementGroupTpl:getReward(tpl))
  self.bind.go_reward = hasReward
  if hasReward then
    self.bind.go_reward = not L_AchievementUtil.getStore():GetIsAchievementRewardCollect(self._selectGroupId)
    self.bind.go_complete = L_AchievementUtil.getStore():GetIsAchievementRewardCollect(self._selectGroupId)
    if not L_AchievementUtil.getStore():GetIsAchievementRewardCollect(self._selectGroupId) then
      self.bind.go_rewardCanCollect = 1 <= finish_rate
      self.modules.module_icon:setGeneralContent(_achievementGroupTpl:getReward(tpl)[1][1], _achievementGroupTpl:getReward(tpl)[1][2], {
        itemNum = _achievementGroupTpl:getReward(tpl)[1][3]
      })
    end
  end
end

function this:showAchievementList()
  table.sort(self._achievementList, function(a, b)
    local isCompletedA = a.completed == true and 1 or 0
    local isCompletedB = b.completed == true and 1 or 0
    if isCompletedA == isCompletedB then
      return _achievementTpl:getId(a.configData) < _achievementTpl:getId(b.configData)
    else
      return isCompletedA < isCompletedB
    end
  end)
  self.bind.scrollList_achievementGroup:clear()
  self.bind.scrollList_achievementGroup:insert_array(self._achievementList)
end

function this:onEvent_refreshAchievementList()
  self:initAchievementList()
end

return this
