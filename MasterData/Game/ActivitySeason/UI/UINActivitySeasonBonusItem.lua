local UINActivitySeasonBonusItem = class("UINActivitySeasonBonusItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local eActInteract = require("Game.ActivityLobby.Activity.Season.eActInteract")
local cs_MessageCommon = CS.MessageCommon

function UINActivitySeasonBonusItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.OnClickAVG)
  UIUtil.AddButtonListener(self.ui.btn_RewardBg, self, self.OnClickGet)
end

function UINActivitySeasonBonusItem:InitBounsItem(activitySeasonData, level, rewardFunc)
  self._data = activitySeasonData
  self._level = level
  self._rewardFunc = rewardFunc
  self:__IntiFixed()
  self:RefreshBounsItem()
end

function UINActivitySeasonBonusItem:__IntiFixed()
  self._avgId = nil
  local expCfg = self._data:GetSeasonRewardCfg()[self._level]
  if expCfg == nil then
    error("level is miss " .. tostring(self._level))
    return
  end
  self._avgId = expCfg.unlock_story
  self.ui.btn_Unlock.gameObject:SetActive(self._avgId > 0)
  if self._avgId > 0 then
    local storyCfg = ConfigData.story_avg[self._avgId]
    self.ui.tex_Number.text = string.format("%02d", storyCfg.number)
    if not IsNull(self.ui.tex_Title) then
      self.ui.tex_Title:SetIndex(2)
    end
    self.ui.tex_CharName:SetIndex(0, LanguageUtil.GetLocaleText(storyCfg.name))
  end
  self.ui.tex_Level.text = tostring(self._level)
  self.ui.obj_Exp:SetActive(self._level < self._data:GetSeasonRewardLvLimit())
  self._rewardPool:HideAll()
  if #expCfg.level_reward_ids == 0 then
    self.ui.img_RewardBg:SetActive(false)
  else
    self.ui.img_RewardBg:SetActive(true)
    for i, itemId in ipairs(expCfg.level_reward_ids) do
      local itemCount = expCfg.level_reward_nums[i]
      local itemCfg = ConfigData.item[itemId]
      local item = self._rewardPool:GetOne()
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
end

function UINActivitySeasonBonusItem:RefreshBounsItem()
  local curLevel = self._data:GetSeasonRewardCurLv()
  local canPicked = self._data:IsSeasonRewardLevelCanPick(self._level)
  local isPicked = self._data:IsSeasonRewardLevelReceived(self._level)
  self.ui.img_AvgBottom.color = self.ui.color_AvgBg[curLevel < self._level and 2 or 1]
  self.ui.btn_RewardBg.interactable = canPicked
  self.ui.img_LevelBg.color = self.ui.color_LevelBg[curLevel < self._level and 2 or 1]
  self.ui.canvasGroup.alpha = curLevel < self._level and 0.9 or 1
  self.ui.tex_Level.color = curLevel < self._level and self.ui.color_unTargetLv or Color.white
  if curLevel < self._level then
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
  elseif curLevel > self._level then
    self.ui.img_ExpProgress.fillAmount = 1
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
  else
    self.ui.tex_ExpProgress.gameObject:SetActive(true)
    local curExp = self._data:GetSeasonRewardCurExp()
    local maxExp = self._data:GetSeasonRewardCurExpLimit()
    self.ui.img_ExpProgress.fillAmount = curExp / maxExp
    self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(maxExp))
  end
  for k, v in pairs(self._rewardPool.listItem) do
    v:SetPickedUIActive(isPicked)
  end
  if isPicked then
    self.ui.img_Bottom:SetIndex(0)
  elseif canPicked then
    self.ui.img_Bottom:SetIndex(1)
  else
    self.ui.img_Bottom:SetIndex(2)
  end
end

function UINActivitySeasonBonusItem:GetSeasonRewardExpLevel()
  return self._level
end

function UINActivitySeasonBonusItem:OnClickAVG()
  if self._avgId == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if avgPlayCtrl == nil then
    return
  end
  if avgPlayCtrl:IsAvgUnlock(self._avgId) then
    local unlockInfo = self._data:GetSeasonUnlockInfo()
    if unlockInfo ~= nil then
      unlockInfo:ClearActUnlockInfo()
    end
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonCtrl ~= nil then
      seasonCtrl:OpenSeasonObj(eActInteract.eLbIntrctEntityId.MainStory)
    end
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8718))
  end
end

function UINActivitySeasonBonusItem:OnClickGet()
  if self._rewardFunc ~= nil then
    self._rewardFunc(self._level, self)
  end
end

return UINActivitySeasonBonusItem
