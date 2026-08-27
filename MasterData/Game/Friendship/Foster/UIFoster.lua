local UIFoster = class("UIFoster", UIBaseWindow)
local base = UIBaseWindow
local UINFosterLineItem = require("Game.Friendship.Foster.UINFosterLineItem")
local UINFosterUnlockNode = require("Game.Friendship.Foster.UINFosterUnlockNode")
local UINFosterUpgradeNode = require("Game.Friendship.Foster.UINFosterUpgradeNode")
local UINFosterButtomNode = require("Game.Friendship.Foster.UINFosterButtomNode")

function UIFoster:OnInit()
  self.heroId = nil
  self.fosterIds = {}
  self.fosterCfgs = {}
  self.heroLevel = nil
  self.friendShipLevel = nil
  self.fosterlinePool = nil
  self.itemList = {}
  self.originalPos = nil
  self.selectedOneId = nil
  UIUtil.CreateTopBtnGroup(self.ui.topBtnGroup, self, self.Delete)
  self.__RefreshFosterLines = BindCallback(self, self.RefreshFosterLines)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFosterLines)
  self.__RefreshGnum = BindCallback(self, self.RefreshGnum)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshGnum)
  self.upgradeNode = UINFosterUpgradeNode.New()
  self.upgradeNode:Init(self.ui.obj_upgradeNode)
  self.unlockNode = UINFosterUnlockNode.New()
  self.unlockNode:Init(self.ui.obj_unlockNode)
  self.buttomNode = UINFosterButtomNode.New()
  self.buttomNode:Init(self.ui.obj_buttomNode)
end

function UIFoster:InitHeroFosterLine(heroId)
  self.heroId = heroId
  self.fosterIds = ConfigData.friendship_hero[heroId].foster_id
  for _, fosterId in ipairs(self.fosterIds) do
    table.insert(self.fosterCfgs, ConfigData.friendship_foster[fosterId])
  end
  self.heroLevel = PlayerDataCenter.heroDic[heroId].level
  self.friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
  self.fosterlinePool = UIItemPool.New(UINFosterLineItem, self.ui.obj_favorLineItem)
  self.originalPos = self.ui.pos_skill.anchoredPosition
  self.ui.obj_favorLineItem:SetActive(false)
  self.upgradeNode:InitUpgradekNode(heroId, self.heroLevel, self.friendShipLevel)
  self.unlockNode:InitUnlockNode(heroId, self.heroLevel, self.friendShipLevel)
  self:RefreshFosterLines()
  self:RefreshGnum()
  self:RefreshFriendSlider()
end

function UIFoster:RefreshGnum()
  local num = PlayerDataCenter:GetItemCount(ConstGlobalItem.NormalGold)
  self.ui.tex_Money:SetIndex(0, tostring(num))
end

function UIFoster:RefreshFriendSlider()
  local maxValue = #self.fosterCfgs
  local value = -0.5
  local unlockLevels = {}
  for index, fosterCfg in ipairs(self.fosterCfgs) do
    table.insert(unlockLevels, fosterCfg[1].friendship_level)
  end
  local lastUnlockLevel = 0
  for index, level in ipairs(unlockLevels) do
    if level <= self.friendShipLevel then
      value = value + 1
    else
      if lastUnlockLevel == 0 then
        value = 0
      end
      value = value + 0.5 * (self.friendShipLevel - lastUnlockLevel) / (level - lastUnlockLevel)
      break
    end
    lastUnlockLevel = level
    if index == #unlockLevels then
      value = value + 0.5 * (self.friendShipLevel - lastUnlockLevel) / (#ConfigData.friendship_level - lastUnlockLevel)
    end
  end
  self.ui.friendship_slider.maxValue = maxValue
  self.ui.friendship_slider.value = value
end

function UIFoster:RefreshFosterLines()
  self.fosterlinePool:HideAll()
  self.itemList = {}
  local needMove = #self.fosterCfgs % 2 == 0
  for i = #self.fosterCfgs, 1, -1 do
    local fosterCfg = self.fosterCfgs[i]
    local item = self.fosterlinePool:GetOne(true)
    item:InitFosterItem(self.heroId, fosterCfg, self.heroLevel, self.friendShipLevel, function(bool)
      if bool then
        self.selectedOneId = #self.fosterCfgs - i + 1
        if item:isUnlocked() then
          self:RefreshAndShowInfo(fosterCfg, item)
        else
          self:RefreshAndShowLockedInfo(fosterCfg)
        end
      end
    end)
    item:Move(needMove, self.originalPos)
    needMove = not needMove
    table.insert(self.itemList, item)
  end
  if self.selectedOneId == nil and #self.itemList > 0 then
    self.itemList[#self.itemList]:setSelect(true)
    self.selectedOneId = #self.itemList
  elseif self.selectedOneId ~= nil then
    self.itemList[self.selectedOneId]:setSelect(false)
    self.itemList[self.selectedOneId]:setSelect(true)
  end
end

function UIFoster:RefreshAndShowLockedInfo(fosterCfg)
  self.ui.obj_mAXNode:SetActive(false)
  self.ui.obj_upgradeNode:SetActive(false)
  self.ui.obj_unlockNode:SetActive(true)
  self.unlockNode:RefreshAndShowLockedInfo(fosterCfg)
  self.buttomNode:RefreshAndShowLockedInfo(fosterCfg)
end

function UIFoster:RefreshAndShowInfo(fosterCfg, item)
  self.ui.obj_unlockNode:SetActive(false)
  local level = item.lienLevel
  if level == #fosterCfg then
    self.ui.obj_mAXNode:SetActive(true)
    self.ui.obj_upgradeNode:SetActive(false)
    self.buttomNode:RefreshAndShowMaxLevelInfo(fosterCfg, level)
  else
    self.ui.obj_mAXNode:SetActive(false)
    self.ui.obj_upgradeNode:SetActive(true)
    self.upgradeNode:RefreshAndShowInfo(fosterCfg, level)
    self.buttomNode:RefreshAndShowInfo(fosterCfg, level)
  end
end

function UIFoster:OnDelete()
  self.fosterlinePool:DeleteAll()
  self.unlockNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFosterLines)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshGnum)
  base.OnDelete(self)
end

return UIFoster
