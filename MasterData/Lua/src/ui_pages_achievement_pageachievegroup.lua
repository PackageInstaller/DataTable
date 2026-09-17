local this = class("pageAchieveGroup", G_UIPageBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()
local _achievementAwardTpl = L_GameTpl:getAchievementAwardTpl()
local HasRewardImg = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_01.png"
local noRewardImg = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_02.png"
local trophyImgList = {
  "UI/Atlas/Page/Achievement/tex_achievement_dec_bronze",
  "UI/Atlas/Page/Achievement/tex_achievement_dec_silver",
  "UI/Atlas/Page/Achievement/tex_achievement_dec_gold",
  "UI/Atlas/Page/Achievement/tex_achievement_dec_platinum"
}

function this.bind()
  return {
    GroupList = {
      moduleName = "pages/achievement/CellAchieveGroup"
    },
    obj_awardPreView = false,
    obj_listAward = false,
    moduleAchievementAwardPreView = {
      moduleName = "pages/achievement/moduleAchievementAwardPreView"
    },
    list_award = {
      moduleName = "pages/achievement/cellAchievementAwardPreViewItem"
    },
    list_trophy = {
      moduleName = "pages/achievement/cellTrophyItem"
    },
    moduleTalentReward = {
      moduleName = "pages/common/modules/moduleRewardTipBtn"
    },
    txt_curValue = "",
    txt_allValue = "",
    obj_lightActive_One = false,
    obj_lightActive_Two = false
  }
end

function this.methods()
  return {
    onclick_recent = function(self)
      L_UI:open("pageRecentAchieve")
    end,
    onclick_award = function(self)
      self:getPointReward()
    end,
    onclick_list_award = function(self)
      self:getPointReward()
    end,
    GroupList = {
      onClick = function(self, index)
        if self.bCanClick then
          self.bCanClick = false
          if self.pageAchieveMainContentAsset == nil then
            self.pageAchieveMainContentAsset = C_UIMgr.uiLoader:Spawn("Assets/ResourcesAssets/UI/Pages/Achievement/pageAchieveMainContent.prefab")
          end
          self.bindComponents.aniRoot:Play("anim_achievementgroup_pageAchievementGroup_click_" .. index)
          self:newOrResetTimer("animTimer1", function()
            L_UI:open("pageAchieveMainContent", {firstIndex = index})
          end, 0.23)
        end
      end
    }
  }
end

function this:preOpen(options)
  C_AudioManager.Play("Play_SFX_CREAT_Common_FX_Shining")
  self.pageAchieveMainContentAsset = nil
  self.bind.obj_awardPreView = false
  local idList = {}
  for key, value in ipairs(_achievementGroupTpl:getfirstLvDir()) do
    table.insert(idList, {
      index = key,
      id = value.id
    })
  end
  self.bind.GroupList:clear()
  self.bind.GroupList:insert_array(idList)
end

function this:open(options)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self._onGetAchievementPointReward = handler(self, self.showPointReward)
  C_AchievementEvent.instance:Listen(C_EAchievementEvent.GetAchievementPointReward, self._onGetAchievementPointReward)
end

function this:close(options)
  if self.pageAchieveMainContentAsset then
    C_PrefabManager:RecycleByLoader(self.pageAchieveMainContentAsset)
  end
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
  if self._onGetAchievementPointReward then
    C_AchievementEvent.instance:Cancel(C_EAchievementEvent.GetAchievementPointReward, self._onGetAchievementPointReward)
  end
end

function this:show()
  self.bCanClick = true
  self.bindComponents.aniRoot:Play("anim_achievementgroup_pageAchievementGroup_in")
  self:refreshForAward()
  self.modules.moduleTalentReward:setNumBgState(true)
  self.modules.moduleTalentReward:setrewardBgState(false)
  self.bind.obj_listAward = true
  local trophyList = {}
  for i = 1, 4 do
    table.insert(trophyList, {
      img_icon = trophyImgList[i],
      num = L_AchievementUtil.getStore():GetTrophyByQuality(i)
    })
  end
  self.bind.list_trophy:clear()
  self.bind.list_trophy:insert_array(trophyList)
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageAchieveMainContent" then
    self.bCanClick = true
    self.bindComponents.aniRoot:Play("anim_achievementgroup_pageAchievementGroup_in2")
  end
end

function this:showPointReward()
  self:refreshForAward()
end

function this:showNextLevelRewardPreView(curGetPoint)
  local id = _achievementAwardTpl:getIdByPoint(curGetPoint)
  local tpl = _achievementAwardTpl:getTplById(id)
  local rewards = _achievementAwardTpl:getReward(tpl)
  local rewardTab = {}
  for _, v in ipairs(rewards) do
    local reward = L_DataUtil.parseRewardConfigItem(v)
    table.insert(rewardTab, {
      itemId = reward.itemId,
      itemType = reward.itemType,
      itemNum = reward.itemNum
    })
  end
  self.bind.list_award:clear()
  self.bind.list_award:insert_array(rewardTab)
end

function this:refreshForAward()
  local pointAllNum = L_AchievementUtil.getStore():GetCurAllPointValue()
  local lastGetPoint = L_AchievementUtil.getStore():GetLastAchievementAwardPoint()
  print("=========================================lastGetPoint", lastGetPoint)
  local curGetPoint = 0
  if lastGetPoint == nil or lastGetPoint == 0 then
    local tpl = _achievementAwardTpl:getFirstTpl()
    curGetPoint = _achievementAwardTpl:getAchiPoint(tpl)
  else
    local awardId = _achievementAwardTpl:getIdByPoint(lastGetPoint)
    local tpl = _achievementAwardTpl:getNextTplById(awardId)
    curGetPoint = _achievementAwardTpl:getAchiPoint(tpl)
  end
  if curGetPoint == 0 or not curGetPoint then
  end
  self.bind.txt_curValue = string.format("%s", pointAllNum)
  self.bind.txt_allValue = string.format("/%s", curGetPoint)
  local canReward = pointAllNum >= curGetPoint and pointAllNum ~= lastGetPoint
  self:showNextLevelRewardPreView(curGetPoint)
  self.bind.obj_lightActive_One = canReward
  self.bind.obj_lightActive_Two = canReward
  if canReward then
    self.modules.moduleTalentReward:setBoxImage(HasRewardImg)
  else
    self.modules.moduleTalentReward:setBoxImage(noRewardImg)
  end
  self.modules.moduleTalentReward:refreshNumberState(1, string.format("%s/%s", pointAllNum, curGetPoint))
  self.curGetPoint = curGetPoint
  self.pointAllNum = pointAllNum
end

function this:getPointReward()
  local lastGetPoint = L_AchievementUtil.getStore():GetLastAchievementAwardPoint()
  if self.pointAllNum >= self.curGetPoint and self.pointAllNum ~= lastGetPoint then
    local awardId = _achievementAwardTpl:getIdByPoint(self.curGetPoint)
    L_AchievementUtil.req_getAchievementPointRewaed(awardId)
  else
    self.bind.obj_awardPreView = not self.bind.obj_awardPreView
    local list = self:getRewardList(self.curGetPoint)
    L_UI:open("pageCommonRewardsTip", {
      title = L_WordsTpl:getValue("ui_common_rewardlist_title_achievement"),
      module_list = list
    })
  end
end

function this:getRewardList(point)
  local nextAwardId = _achievementAwardTpl:getIdByPoint(point)
  local list = {}
  for i, v in ipairs(_achievementAwardTpl.data) do
    local isReceived = nextAwardId > v.id
    local txt_num = tostring(point)
    local tpl = _achievementAwardTpl:getTplById(v.id)
    local rewards = L_DataUtil.parseRewardConfig(tpl.reward)
    local rewardItems = {}
    for i = 1, #rewards do
      local type = rewards[i].itemType
      local id = rewards[i].itemId
      local item = L_ItemTplManager:getItemConfig(type, id)
      table.insert(rewardItems, {
        itemType = item.itemType,
        itemId = item.itemId,
        num = rewards[i].itemNum,
        received = isReceived
      })
    end
    local select = nextAwardId == v.id
    table.insert(list, {
      isStar = true,
      number = tostring(v.achiPoint),
      rewardList = rewardItems,
      isSelect = select
    })
  end
  return list
end

return this
