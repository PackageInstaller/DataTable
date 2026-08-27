local UINActCommonRewardBpItem = class("UINActCommonRewardBpItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local cs_MessageCommon = CS.MessageCommon

function UINActCommonRewardBpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.OnClickAVG)
  UIUtil.AddButtonListener(self.ui.btn_RewardBg, self, self.OnClickGet)
end

function UINActCommonRewardBpItem:InitBounsItem(commonRewardBpData, level, rewardFunc)
  self._data = commonRewardBpData
  self._level = level
  self._rewardFunc = rewardFunc
  self:__IntiFixed()
  self:RefreshBounsItem()
end

function UINActCommonRewardBpItem:__IntiFixed()
  self._avgId = nil
  local expCfg = self._data:GetCommonRewardBpCfg()[self._level]
  if expCfg == nil then
    error("level is miss " .. tostring(self._level))
    return
  end
  self._avgId = expCfg.show_story or 0
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
  self.ui.obj_Exp:SetActive(self._level < self._data:GetCommonRewardLvLimit())
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

function UINActCommonRewardBpItem:RefreshBounsItem()
  local curLevel = self._data:GetCommonRewardCurLv()
  local canPicked = self._data:IsCommonRewardLevelCanPick(self._level)
  local isPicked = self._data:IsCommonRewardLevelReceived(self._level)
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
    local curExp = self._data:GetCommonRewardCurExp()
    local maxExp = self._data:GetCommonRewardCurExpLimit()
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

function UINActCommonRewardBpItem:GetSeasonRewardExpLevel()
  return self._level
end

function UINActCommonRewardBpItem:OnClickAVG()
  if self._avgId == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if avgPlayCtrl == nil then
    return
  end
  if avgPlayCtrl:IsAvgUnlock(self._avgId) then
    local func = self._data:GetAvgJumpFunc()
    if func then
      func()
    end
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8718))
  end
end

function UINActCommonRewardBpItem:OnClickGet()
  if self._rewardFunc ~= nil then
    self._rewardFunc(self._level, self)
  end
end

return UINActCommonRewardBpItem
