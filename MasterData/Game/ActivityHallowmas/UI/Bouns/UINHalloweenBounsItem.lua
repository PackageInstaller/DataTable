local UINHalloweenBounsItem = class("UINHalloweenBounsItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local cs_MessageCommon = CS.MessageCommon

function UINHalloweenBounsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINHalloweenBounsItem:InitBounsItem(hallowmasData, level, rewardFunc)
  self._data = hallowmasData
  self._level = level
  self._rewardFunc = rewardFunc
  self:__IntiFixed()
  self:RefreshBounsItem()
end

function UINHalloweenBounsItem:__IntiFixed()
  self._avgId = nil
  local expCfg = self._data:GetHallowmasExpCfg()[self._level]
  if expCfg == nil then
    error("level is miss " .. tostring(self._level))
    return
  end
  self._avgId = expCfg.unlock_story
  self.ui.obj_Unlock.gameObject:SetActive(self._avgId > 0)
  if self._avgId > 0 then
    local storyCfg = ConfigData.story_avg[self._avgId]
    self.ui.tex_Number.text = "#" .. tostring(storyCfg.number)
    if not IsNull(self.ui.tex_Title) then
      self.ui.tex_Title:SetIndex(2)
    end
    self.ui.tex_CharName.text = LanguageUtil.GetLocaleText(storyCfg.name)
  end
  self.ui.tex_Level.text = tostring(self._level)
  self.ui.obj_Exp:SetActive(self._level < self._data:GetHallowmasLvLimit())
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

function UINHalloweenBounsItem:RefreshBounsItem()
  local curLevel = self._data:GetHallowmasLv()
  self.ui.img_LevelBg:SetIndex(curLevel < self._level and 1 or 0)
  self.ui.canvasGroup.alpha = curLevel < self._level and 0.9 or 1
  self.ui.tex_Level.color = curLevel < self._level and self.ui.color_unTargetLv or Color.black
  if curLevel < self._level then
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
  elseif curLevel > self._level then
    self.ui.img_ExpProgress.fillAmount = 1
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
  else
    self.ui.tex_ExpProgress.gameObject:SetActive(true)
    local curExp = self._data:GetHallowmasCurExp()
    local maxExp = self._data:GetHallowmasCurExpLimit()
    self.ui.img_ExpProgress.fillAmount = curExp / maxExp
    self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(maxExp))
  end
  local isPicked = self._data:IsHallowmasLevelReceived(self._level)
  for k, v in pairs(self._rewardPool.listItem) do
    v:SetPickedUIActive(isPicked)
  end
end

function UINHalloweenBounsItem:GetHallowExpLevel()
  return self._level
end

function UINHalloweenBounsItem:OnClickGet()
  if self._rewardFunc ~= nil then
    self._rewardFunc(self._level, self)
  end
end

return UINHalloweenBounsItem
