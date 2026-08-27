local UINBattlePassItem = class("UINBattlePassItem", UIBaseNode)
local base = UIBaseNode
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINBaseItemWithLock = require("Game.CommonUI.Item.UINBaseItemWithLock")

function UINBattlePassItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__baseItemPool = UIItemPool.New(UINBaseItemWithLock, self.ui.baseItem)
  self.ui.baseItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Base, self, self.OnBtnPassBaseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Advance, self, self.OnBtnPassSeniorClicked)
  self._lastItemType = 0
end

function UINBattlePassItem:InitBattlePassItem(passLevelCfg, passInfo, clickEvent)
  self.passLevelCfg = passLevelCfg
  self.level = passLevelCfg.level
  self.passInfo = passInfo
  self.clickEvent = clickEvent
  if self._lastItemType ~= 0 then
    self.ui.obj_normal:SetActive(true)
    self.ui.spHolder:SetActive(false)
    self._lastItemType = 0
    self._spPassItem = nil
  end
  self:__InitPassItemUI(passLevelCfg)
end

function UINBattlePassItem:InitBattlePassSepcItem(spItem)
  if self._lastItemType ~= 1 then
    self.ui.obj_normal:SetActive(false)
    self.ui.spHolder:SetActive(true)
    self._spPassItem = spItem
    spItem.transform:SetParent(self.ui.spHolder.transform)
    spItem.transform.anchoredPosition = Vector2.zero
    self._lastItemType = 1
  end
end

function UINBattlePassItem:InitBattlePassEmptyItem()
  if self._lastItemType ~= 2 then
    self.ui.obj_normal:SetActive(false)
    self.ui.spHolder:SetActive(false)
    self._lastItemType = 2
  end
end

function UINBattlePassItem:__InitPassItemUI(passLevelCfg)
  self.__baseItemPool:HideAll()
  local basepacked, baselocked, baseEnable = self:__GetPassRewardStateBase(self.passInfo)
  local seniorpacked, seniorlocked, seniorEnable = self:__GetPassRewardStateSenior(self.passInfo)
  self.ui.obj_SeniorBlack:SetActive(not self.passInfo.unlockSenior)
  self.ui.obj_DownArrow:SetActive(self.passInfo.unlockSenior)
  self.ui.baseReward:SetActive(baseEnable)
  self.ui.advReward:SetActive(seniorEnable)
  self.ui.baseTouch.raycastTarget = baseEnable
  self.ui.advTouch.raycastTarget = seniorEnable
  self.ui.tex_Level.text = tostring(passLevelCfg.level)
  self.ui.img_Line:SetActive(self.level <= self.passInfo.level)
  self.ui.obj_Arrow:SetActive(self.level == self.passInfo.level)
  self.ui.obj_level.localScale = self.level == self.passInfo.level and Vector3.one or Vector3.New(0.78, 0.78, 0.78)
  if self.level < math.min(self.passInfo.level, self.passInfo.maxlevel) then
    self.ui.img_LevelBar.fillAmount = 1
  elseif self.level == self.passInfo.level or self.level == self.passInfo.maxlevel and self.passInfo:IsPassFullLevel() then
    self.ui.img_LevelBar.fillAmount = 0.5
  else
    self.ui.img_LevelBar.fillAmount = 0
  end
  if self.level == self.passInfo.maxlevel then
    self.ui.img_bar.fillAmount = 0.5
  else
    self.ui.img_bar.fillAmount = 1
  end
  for index, itemId in pairs(passLevelCfg.base_item_ids) do
    local itemCount = passLevelCfg.base_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(self.ui.btn_Base.transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, basepacked, baselocked)
    end
  end
  for index, itemId in pairs(passLevelCfg.senior_item_ids) do
    local itemCount = passLevelCfg.senior_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(self.ui.btn_Advance.transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, seniorpacked, seniorlocked)
    end
  end
  self.ui.baseTouch.transform:SetAsLastSibling()
  self.ui.advTouch.transform:SetAsLastSibling()
end

function UINBattlePassItem:UpdatePassItemUI(passInfo)
  self:__InitPassItemUI(self.passLevelCfg)
end

function UINBattlePassItem:__GetPassRewardStateBase(passInfo)
  local basepacked = false
  local takenReward = passInfo.taken[self.level]
  if takenReward ~= nil and takenReward.base then
    basepacked = true
  end
  local baselocked = false
  if self.level > passInfo.level then
    baselocked = true
  end
  local baseEnable = not basepacked and not baselocked
  return basepacked, baselocked, baseEnable
end

function UINBattlePassItem:__GetPassRewardStateSenior(passInfo)
  local unlockSenior = passInfo.unlockSenior
  local seniorpacked = false
  local takenReward = passInfo.taken[self.level]
  if takenReward ~= nil and takenReward.senior then
    seniorpacked = true
  end
  local seniorlocked = false
  if unlockSenior and self.level > passInfo.level then
    seniorlocked = true
  end
  local seniorEnable = unlockSenior and not seniorpacked and not seniorlocked
  return seniorpacked, seniorlocked, seniorEnable
end

function UINBattlePassItem:__CreatePassRewardItem(parent)
  local baseItem = self.__baseItemPool:GetOne()
  baseItem.transform:SetParent(parent)
  baseItem.transform.anchoredPosition3D = Vector3.zero
  return baseItem
end

function UINBattlePassItem:OnBtnPassBaseClicked()
  if self.clickEvent == nil then
    return
  end
  local basepacked, baselocked, baseEnable = self:__GetPassRewardStateBase(self.passInfo)
  if baseEnable then
    self.clickEvent(self.level, false)
  end
end

function UINBattlePassItem:OnBtnPassSeniorClicked()
  if self.clickEvent == nil then
    return
  end
  local seniorpacked, seniorlocked, seniorEnable = self:__GetPassRewardStateSenior(self.passInfo)
  if seniorEnable then
    self.clickEvent(self.level, true)
  end
end

function UINBattlePassItem:OnDelete()
  base.OnDelete(self)
end

return UINBattlePassItem
