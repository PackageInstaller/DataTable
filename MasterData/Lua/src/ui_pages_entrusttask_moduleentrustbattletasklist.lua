local this = class("moduleEntrustBattleTaskList", G_UIModuleBase)
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local RewardBoxEnum = {
  HasReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_01.png",
  NoReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_02.png"
}
local RewardStarEnum = {
  HasReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_01.png",
  NoReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_02.png"
}

function this.bind()
  return {
    txt_reward = "",
    active_numBg = true,
    active_rewardBg = false,
    scroll_view = {
      moduleName = "pages/entrustTask/cellEntrustBattleTask"
    },
    img_rewardBox = "",
    img_rewardStar = "",
    active_bg = false,
    moduleTalentReward = {
      moduleName = "pages/common/modules/moduleRewardTipBtn"
    },
    active_rewardBtn = true
  }
end

function this.methods()
  return {
    btn_reward_click = function(self)
      self:onBtnOpenBox()
    end
  }
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:open()
  self:refreshBoxInfo()
  L_EntrustStore:listenCallFunc(L_EntrustStore.event.entrustRewardRefresh, self.onEvent_entrustRewardRefresh, self)
end

function this:close()
  L_EntrustStore:unListenCallFunc(L_EntrustStore.event.entrustRewardRefresh, self.onEvent_entrustRewardRefresh, self)
end

function this:setListData(data)
  self.listData = data
end

function this:refreshList()
  local tmp_list = {}
  for i, item in pairs(self.listData) do
    table.insert(tmp_list, item)
  end
  table.sort(tmp_list, function(a, b)
    return tonumber(a.level_num) < tonumber(b.level_num)
  end)
  self.bind.scroll_view:clear()
  self.bind.scroll_view:insert_array(tmp_list)
  self.hasSetScrollView = true
end

function this:refreshUnlockMaskItem()
  if not self.parent or not self.parent.isShow then
    return
  end
  if not self.modules or not self.modules.scroll_view then
    return
  end
  if not self.hasSetScrollView then
    return
  end
  local firstIndexHasBindUI
  for index = 1, #self.modules.scroll_view do
    local cellModule = self.modules.scroll_view[index]
    if cellModule.uiBinding ~= nil and not cellModule.isClose then
      if cellModule:IsLocked() then
        if firstIndexHasBindUI == nil then
          firstIndexHasBindUI = index
        else
          cellModule:updateUnlockMask(false)
        end
      else
        cellModule:updateUnlockMask(false)
      end
    elseif firstIndexHasBindUI ~= nil then
      local count = index - firstIndexHasBindUI
      self.modules.scroll_view[firstIndexHasBindUI]:updateUnlockMask(true, count)
      firstIndexHasBindUI = nil
      break
    end
  end
  if firstIndexHasBindUI ~= nil then
    local count = #self.modules.scroll_view - firstIndexHasBindUI + 1
    self.modules.scroll_view[firstIndexHasBindUI]:updateUnlockMask(true, count, true)
  end
end

function this:refreshAllBtnFalse()
  for i = 1, #self.bind.scroll_view do
    self.bind.scroll_view:getItemCls(i):refreshSelect(false)
  end
end

function this:selectItem(level, toTarget)
  local index = 0
  for i = 1, #self.bind.scroll_view do
    if self.bind.scroll_view:getItemCls(i):getLevelId() == level then
      self.bind.scroll_view:getItemCls(i):refreshSelect(true)
      if toTarget and self.bindComponents and self.bindComponents.taskList_scroll then
        self.bindComponents.taskList_scroll:FocusItemIndex(index)
      end
    else
      self.bind.scroll_view:getItemCls(i):refreshSelect(false)
    end
    index = index + 1
  end
end

function this:refreshBoxInfo()
  local tpl = _dungeonEntrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.PetDuel)
  if tpl and _dungeonEntrustTypeTpl:getStarRewardIsShow(tpl) == 0 then
    self.bind.active_rewardBtn = false
    return
  end
  self.bind.active_rewardBtn = true
  local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.PetDuel, 0)
  local firstRewardStarNum, rewardId = L_EntrustStore:getFirstCanReceiveStarNum(L_Const.EntrustTypeEnum.PetDuel, 0)
  local canReceiveReward = curStarNum >= firstRewardStarNum and 0 < rewardId
  self.modules.moduleTalentReward:refreshState(canReceiveReward)
  if not canReceiveReward then
    printf("委托界面：：：" .. string.format("%s/%s", curStarNum, firstRewardStarNum))
    self.modules.moduleTalentReward:refreshNumberState(1, string.format("%s/%s", curStarNum, firstRewardStarNum))
  end
  self.modules.moduleTalentReward:setStarImage(canReceiveReward and RewardStarEnum.HasReward or RewardStarEnum.NoReward)
  self.modules.moduleTalentReward:setBoxImage(canReceiveReward and RewardBoxEnum.HasReward or RewardBoxEnum.NoReward)
  self.bindComponents.rewardBtn.legacyAnimationTriggers.normalTrigger = canReceiveReward and "anim_entrust_normal_full" or "anim_entrust_normal"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.highlightedTrigger = canReceiveReward and "anim_entrust_hover_full" or "anim_entrust_hover"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.selectedTrigger = canReceiveReward and "anim_entrust_Selected_full" or "anim_entrust_Selected"
end

function this:onBtnOpenBox()
  self.bind.active_bg = true
  Timer.once(0.4, function()
    self.bind.active_bg = false
    local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.PetDuel, 0)
    local rewardIdList = L_EntrustStore:getCanReceiveRewardIdList(L_Const.EntrustTypeEnum.PetDuel, curStarNum, 0)
    if rewardIdList then
      L_EntrustStore:req_getEntrustReward(rewardIdList)
      return
    end
    local list, index = self:initRewardsTip({
      difficultyId = 0,
      entrustType = L_Const.EntrustTypeEnum.PetDuel
    })
    L_UI:open("pageCommonRewardsTip", {
      title = L_WordsTpl:getValue("ui_common_rewardlist_title_entrust"),
      module_list = list,
      selectIndex = index
    })
  end, self, self.gameObject)
end

function this:initRewardsTip(options)
  self.difficultyId = options.difficultyId or 0
  self.entrustType = options.entrustType
  local _, canReceiveRewardId = L_EntrustStore:getFirstCanReceiveStarNum(self.entrustType, self.difficultyId)
  local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(self.entrustType, self.difficultyId) or {}
  local info = {}
  local selectIndex = 1
  for index, v in ipairs(modeInfo) do
    local received = L_EntrustStore:checkEntrustRewardReceived(v.id)
    local cfg = _dungeonEntrustRewardTpl:getTplById(v.id)
    local reward = _dungeonEntrustRewardTpl:getReward(cfg)
    local starNum = string.format("x%s", _dungeonEntrustRewardTpl:getStarNum(cfg))
    local rewardItems = {}
    for i = 1, #reward do
      local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
      table.insert(rewardItems, {
        itemType = item.itemType,
        itemId = item.itemId,
        num = reward[i].itemNum,
        received = received
      })
    end
    local isActive = canReceiveRewardId == v.id
    table.insert(info, {
      isStar = true,
      number = starNum,
      rewardList = rewardItems,
      isSelect = isActive
    })
    if isActive then
      selectIndex = index
    end
  end
  return info, selectIndex
end

function this:onEvent_entrustRewardRefresh()
  self:refreshBoxInfo()
end

return this
