local UIMatChapterItem = class("UIMatChapterItem", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local ChapterState = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig").ChapterState

function UIMatChapterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.levelItem, self, self.__onClick)
  self.onClickAction = nil
  self.fstRewardItemData = {}
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
  self.dailyLimit = 0
  self.usedLimit = 0
  self.ui.obj_Complete:SetActive(false)
end

function UIMatChapterItem:CheckDailyLimit()
  return self.dailyLimit > self.usedLimit
end

function UIMatChapterItem:InitWithData(chapterCfg, state, index, fstRwdPool, mbRwdPool, moduleId, lockReason)
  self.lockReason = lockReason
  self.cfg = chapterCfg
  self.chapterId = self.cfg.id
  self.state = state
  self.moduleId = moduleId
  local epIndex = string.format("%02d", index)
  self.ui.tex_LevelName:SetIndex(0, epIndex)
  self.gameObject.name = self.ui.tex_LevelName.text.text
  self.fstRewardPool = fstRwdPool
  self.mbRewardPool = mbRwdPool
  local fstRewardIds = self.cfg.first_reward_ids
  local fstRewardNums = self.cfg.first_reward_nums
  if fstRewardIds ~= nil and 0 < #fstRewardIds then
    for k, v in ipairs(fstRewardIds) do
      self.fstRewardItemData[v] = fstRewardNums[k]
    end
  end
  self.mbDropIdList = self.cfg.normal_drop
  local costIds = self.cfg.cost_itemIds
  local costIdNums = self.cfg.cost_itemNums
  if costIds ~= nil and 0 < #costIds then
    for k, v in ipairs(costIds) do
      if v ~= FriendshipEnum.StaminaeId then
        self.costItemData[v] = costIdNums[k]
      else
        self.costStrengthNum = costIdNums[k]
      end
    end
  end
  self:UpdateLimit()
  if not self:CheckDailyLimit() then
    self.ui.obj_Complete:SetActive(true)
  end
  self:UpdateChapterData()
end

function UIMatChapterItem:UpdateChapterData()
  self.ui.img_State:SetIndex(self.state)
end

function UIMatChapterItem:UpdateLimit()
  self.dailyLimit = self.cfg.frequency_day
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and PlayerDataCenter.dungeonDailyBattleTimes[self.moduleId] ~= nil then
    local dungeonStageDict = PlayerDataCenter.dungeonDailyBattleTimes[self.moduleId].data
    if dungeonStageDict[self.chapterId] ~= nil then
      self.usedLimit = dungeonStageDict[self.chapterId]
    end
  end
end

function UIMatChapterItem:__onClick()
  if self.updateLimitDisplayEvent ~= nil then
  end
  if self.onClickAction ~= nil then
    local showDetail = self.onClickAction(true, self)
    if showDetail then
      self:ShowRewardsItem()
    end
  end
end

function UIMatChapterItem:ShowRewardsItem()
  if self.fstRewardPool ~= nil then
    self.fstRewardPool:HideAll()
    local rewardPicked = PlayerDataCenter:GetTotalBattleTimes(self.chapterId) > 0
    local rwdCount = 0
    for k, v in pairs(self.fstRewardItemData) do
      if k ~= nil and v ~= nil then
        local itemCfg = ConfigData.item[k]
        if itemCfg == nil then
          error("can not find item,id =" .. tostring(k))
        else
          local rwdItem = self.fstRewardPool:GetOne()
          rwdItem:InitBaseItem(itemCfg, nil)
          rwdItem.ui.obj_isPicked:SetActive(rewardPicked)
          rwdItem.ui.tex_Count.text = tostring(v)
          rwdCount = rwdCount + 1
        end
      end
    end
    if rwdCount <= 1 then
      self.ui.obj_EmptyItem:SetActive(true)
    else
      self.ui.obj_EmptyItem:SetActive(false)
    end
  end
  if self.mbRewardPool ~= nil then
    self.mbRewardPool:HideAll()
    for k, v in ipairs(self.mbDropIdList) do
      if v ~= nil then
        local itemCfg = ConfigData.item[v]
        if itemCfg == nil then
          error("can not find item,id =" .. tostring(v))
        else
          local rwdItem = self.mbRewardPool:GetOne()
          rwdItem:InitBaseItem(itemCfg, nil)
        end
      end
    end
  end
end

function UIMatChapterItem:OnHide()
  self.onClickAction = nil
  self.fstRewardItemData = {}
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
end

function UIMatChapterItem:OnDelete()
  base.OnDelete(self)
end

return UIMatChapterItem
