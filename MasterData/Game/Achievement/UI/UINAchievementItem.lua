local UINAchievementItem = class("UINAchievementItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")

function UINAchievementItem:OnInit()
  self.isPicked = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.OnClick)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem.gameObject:SetActive(false)
end

function UINAchievementItem:InitAchieveItem(resloader, getRewardEvent, JumpToTargetEvent)
  self.resloader = resloader
  self.getRewardEvent = getRewardEvent
  self.JumpToTargetEvent = JumpToTargetEvent
end

function UINAchievementItem:RefreshAchieveItem(achieveData)
  self.achieveData = achieveData
  self:m_RefreshStaticUI(achieveData.stcData)
  self:RefreshUI()
end

function UINAchievementItem:m_RefreshStaticUI(stcData)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(stcData.name)
  local stepCfg = ConfigData.taskStep[stcData.id][1]
  self.ui.tex_TaskIntro.text = LanguageUtil.GetLocaleText(stcData.task_intro)
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AchievementIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    if self.ui == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, stcData.icon)
  end)
end

function UINAchievementItem:RefreshUI()
  self.ui.btn_ItemClick.enabled = true
  if self.achieveData.state == TaskEnum.eTaskState.InProgress then
    local schedule, aim = self.achieveData.taskData:GetTaskProcess()
    self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
    self:m_FillProcess(schedule / aim)
    self.ui.tex_State:SetIndex(0)
    self.ui.obj_isOver:SetActive(false)
  elseif self.achieveData.state == TaskEnum.eTaskState.Completed then
    local schedule, aim = self.achieveData.taskData:GetTaskProcess()
    self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
    self:m_FillProcess(1)
    self.ui.tex_State:SetIndex(1)
    self.ui.obj_isOver:SetActive(false)
  elseif self.achieveData.state == TaskEnum.eTaskState.Picked then
    local aim = ConfigData.taskStep[self.achieveData.stcData.id][1].finish_value
    self.ui.tex_Progress:SetIndex(0, tostring(aim), tostring(aim))
    local time = TimeUtil:TimestampToDate(self.achieveData.completedTimestamp, nil, true)
    local month
    if time.month < 10 then
      month = "0" .. tostring(time.month)
    else
      month = tostring(time.month)
    end
    local day
    if 10 > time.day then
      day = "0" .. tostring(time.day)
    else
      day = tostring(time.day)
    end
    self.ui.textCompleteTime.text = time.year .. "." .. month .. "." .. day
    self:m_FillProcess(1)
    self.ui.tex_State:SetIndex(2)
    self.ui.obj_isOver:SetActive(true)
    self.ui.btn_ItemClick.enabled = false
  else
    error("not configed task state:" .. tostring(self.achieveData.stat))
  end
  self:RefreshRewards()
end

function UINAchievementItem:m_FillProcess(value)
  local sizeDelta = self.ui.bar.sizeDelta
  if 1 <= value then
    self.ui.img_Fill.sizeDelta = sizeDelta
  else
    self.ui.img_Fill.sizeDelta = Vector2.New(value * sizeDelta.x, sizeDelta.y)
  end
end

function UINAchievementItem:RefreshRewards()
  self.rewardItemPool:HideAll()
  local stcData = self.achieveData.stcData
  local isPicked = self.achieveData.state == TaskEnum.eTaskState.Picked
  for k, rewardId in ipairs(stcData.rewardIds) do
    local rewardNum = stcData.rewardNums[k]
    local itemCfg = ConfigData.item[rewardId]
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem:InitItemWithCount(itemCfg, rewardNum, nil, isPicked)
  end
end

function UINAchievementItem:OnClick()
  if self.achieveData.state == TaskEnum.eTaskState.InProgress then
    self:JumpToTarget()
  elseif self.achieveData.state == TaskEnum.eTaskState.Completed then
    local containAth = false
    for k, rewardId in ipairs(self.achieveData.stcData.rewardIds) do
      local itemCfg = ConfigData.item[rewardId]
      if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
        containAth = true
        break
      end
    end
    if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return
    end
    if self.getRewardEvent ~= nil then
      self.getRewardEvent(self.achieveData)
    end
  end
end

function UINAchievementItem:JumpToTarget()
  if self.JumpToTargetEvent ~= nil then
    self.JumpToTargetEvent(self.achieveData.stcData)
  end
end

function UINAchievementItem:OnDelete()
  for _, item in pairs(self.rewardItemPool.listItem) do
    item:CloseGreatRewardLoopFx()
  end
  base.OnDelete(self)
end

return UINAchievementItem
