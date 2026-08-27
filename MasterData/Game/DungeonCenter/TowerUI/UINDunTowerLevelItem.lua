local UINDunTowerLevelItem = class("UINDunTowerLevelItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local CS_ClientConsts = CS.ClientConsts

function UINDunTowerLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_towerItem, self, self.OnTowerItemClicked)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.__lastItemType = DungeonLevelEnum.TowerLevelItemType.NormalItem
  self:SetAsSelectTowerLevel(false)
end

function UINDunTowerLevelItem:BindTowerItemCommon(isTwinTower, resloader, clickEvent, objSelect, objNewLevel, downConstraint)
  self.__isTwinTower = isTwinTower
  self.__resloader = resloader
  self.__clickEvent = clickEvent
  self.__objSelect = objSelect
  self.__objNewLevel = objNewLevel
  self.__downConstraint = downConstraint
end

function UINDunTowerLevelItem:InitTowerLevelItem(towerLevelData, completeLevel)
  self.__towerLevelData = towerLevelData
  local towerFlag = towerLevelData:IsTowerFlagLevel()
  self.__towerFlag = towerFlag
  local itemType = DungeonLevelEnum.TowerLevelItemType.NormalItem
  if self.__lastItemType ~= itemType then
    self:ClearItemPositionConstraint()
    self.__lastItemType = itemType
    self.ui.btn_towerItem.gameObject:SetActive(true)
    self.ui.isTopOrDownNode.gameObject:SetActive(false)
    self.ui.towerComingSoon:SetActive(false)
  end
  self:RefreshTowerItemInfo(completeLevel)
end

function UINDunTowerLevelItem:InitTowerLevelItemKeep(itemType, topObj)
  if self.__lastItemType ~= itemType then
    self:ClearItemPositionConstraint()
    self.__lastItemType = itemType
    self.ui.btn_towerItem.gameObject:SetActive(false)
    self.ui.isTopOrDownNode.gameObject:SetActive(true)
    if itemType == DungeonLevelEnum.TowerLevelItemType.TopEmpty then
      topObj:SetParent(self.ui.isTopOrDownNode)
      topObj.anchoredPosition3D = Vector3.zero
      topObj.gameObject:SetActive(true)
      self.ui.towerComingSoon:SetActive(false)
    else
      topObj.gameObject:SetActive(false)
      local constraintSource = self.__downConstraint:GetSource(0)
      constraintSource.sourceTransform = self.ui.isTopOrDownNode
      self.__downConstraint:SetSource(0, constraintSource)
      self.__downConstraint.gameObject:SetActive(true)
      self.ui.towerComingSoon:SetActive(true)
      local showComingSoon = not self.__isTwinTower and not CS_ClientConsts.IsAudit
      self.ui.tex_ComingSoon:SetActive(showComingSoon)
    end
  end
end

function UINDunTowerLevelItem:SetAsSelectTowerLevel(selected)
  self.ui.selectHolder:SetActive(selected)
  if selected then
    self.__objSelect:SetParent(self.ui.selectHolder.transform)
    self.__objSelect.anchoredPosition = Vector2.zero
    if self.__isCompelete then
      self.ui.obj_Completed:SetActive(false)
    end
  elseif self.__isCompelete then
    self.ui.obj_Completed:SetActive(true)
  end
end

function UINDunTowerLevelItem:SetTowerNewLevelState(isnew)
  self.ui.newLevelHolder:SetActive(isnew)
  local index = 0
  if isnew then
    index = 1
    self.__objNewLevel:SetParent(self.ui.newLevelHolder.transform)
    self.__objNewLevel.anchoredPosition = Vector2.zero
  end
  if self.__towerFlag then
    index = index + 2
  end
  self.ui.img_Bottom:SetIndex(index)
end

function UINDunTowerLevelItem:GetItemTowerLevelData()
  return self.__towerLevelData
end

function UINDunTowerLevelItem:ClearItemTowerLevel()
  self:ClearItemPositionConstraint()
  self.__towerLevelData = nil
  self.__lastItemType = nil
end

function UINDunTowerLevelItem:ClearItemPositionConstraint()
  if self.__lastItemType == DungeonLevelEnum.TowerLevelItemType.DownEmpty then
    self.__downConstraint.gameObject:SetActive(false)
  end
end

function UINDunTowerLevelItem:RefreshTowerItemInfo(completeLevel)
  local levelNum = self.__towerLevelData:GetDunTowerLevelNum()
  local isCompelete = completeLevel >= levelNum
  local isNewLevel = levelNum == completeLevel + 1
  local isLock = levelNum > completeLevel + 1
  self.__isCompelete = isCompelete
  self:__InitFirstRewardList(isCompelete)
  self.ui.obj_Completed:SetActive(isCompelete)
  if isCompelete then
    local isHaveRacing = self.__towerLevelData:GetIsHaveRacing()
    self.ui.obj_time:SetActive(isHaveRacing)
    if isHaveRacing then
      local frame = PlayerDataCenter.dungeonTowerSData:GetTowerLevelRacingFrame(self.__towerLevelData:GetDungeonTowerType(), self.__towerLevelData:GetDunTowerLevelNum())
      self.ui.tex_CompleteTime:SetIndex(0, BattleUtil.FrameToTimeString(frame, true))
    end
  end
  self:SetTowerNewLevelState(isNewLevel)
  self.ui.obj_Locked:SetActive(isLock)
  self.ui.tex_FloorNum.text = string.format("%03d", levelNum)
  if isNewLevel then
    local userInfoData = PlayerDataCenter.inforData
    self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), self.__resloader)
    self.userHeadNode:Show()
  else
    self.userHeadNode:Hide()
  end
end

function UINDunTowerLevelItem:__InitFirstRewardList(isPacked)
  self.rewardPool:HideAll()
  local first_reward_ids, first_reward_nums = self.__towerLevelData:GetDungeonFirstReward()
  for i, itemId in pairs(first_reward_ids) do
    local itemCfg = ConfigData.item[itemId]
    local count = first_reward_nums[i]
    local item = self.rewardPool:GetOne(true)
    item:InitItemWithCount(itemCfg, count, nil, isPacked)
  end
end

function UINDunTowerLevelItem:OnTowerItemClicked()
  if self.__clickEvent ~= nil then
    self.__clickEvent(self, self.__towerLevelData)
  end
end

function UINDunTowerLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINDunTowerLevelItem
