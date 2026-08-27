local UIDungeonTwinTowerSelect = class("UIDungeonTwinTowerSelect", UIBaseWindow)
local base = UIBaseWindow
local UINDunTwinTowerSelectItem = require("Game.DungeonCenter.TowerUI.UINDunTwinTowerSelectItem")
local DungeonTypeTower = require("Game.DungeonCenter.Data.DungeonTypeTower")
local CS_ClientConsts = CS.ClientConsts

function UIDungeonTwinTowerSelect:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickTowerReturn, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnBtnCancelClick)
  self.__twinTowerPool = UIItemPool.New(UINDunTwinTowerSelectItem, self.ui.towerItem, false)
  self.__onSelectTwinTower = BindCallback(self, self.OnSelectTwinTower)
end

function UIDungeonTwinTowerSelect:InitDunTwinTowerSelect(dunTowerCtrl, selectTowerId, myRankDetail)
  self.__dunTowerCtrl = dunTowerCtrl
  self.__selectTowerId = selectTowerId or 0
  self:__InitTwinTowerList(myRankDetail)
  self.__onSelectTwinTower = BindCallback(self, self.OnSelectTwinTower)
end

function UIDungeonTwinTowerSelect:__InitTwinTowerList(myRankDetail)
  self.__twinTowerPool:HideAll()
  self.__twinItemDic = {}
  local time = 0
  local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
  self.__twinTowerNode = twinTowerNode
  local defaultIndex = math.max(1, PlayerDataCenter.dungeonTowerSData:GetTwinTowerFirstNoComplete())
  local towerCount = #ConfigData.dungeon_tower_type.twin_towers
  for index, towerId in pairs(ConfigData.dungeon_tower_type.twin_towers) do
    local towerTypeData = DungeonTypeTower.New(towerId, true)
    local twinTowerItem = self.__twinTowerPool:GetOne()
    local myRank
    if myRankDetail ~= nil then
      myRank = myRankDetail[towerId]
    end
    twinTowerItem:InitTwinTowerSelectItem(towerTypeData, self.__selectTowerId, myRank, self.__onSelectTwinTower)
    time = time + 1
    twinTowerItem:__PlayThemeTween(time)
    self.__twinItemDic[towerId] = twinTowerItem
    if self.__selectTowerId == towerId then
      defaultIndex = index
    end
    self:__RefreshTwinSelectReddot(towerId)
    local blueDot = PlayerDataCenter.dungeonTowerSData:IsNewDunTower(towerId)
    twinTowerItem:SetTwinTowerItemBluedot(blueDot)
  end
  self.ui.obj_Lock.transform:SetAsLastSibling()
  self.ui.cg_Lock:DOFade(0, 0.3):From():SetDelay((time + 1) * 0.15)
  if CS_ClientConsts.IsAudit then
    self.ui.obj_Lock.gameObject:SetActive(false)
  end
  if self._racingRewardListener == nil then
    function self._racingRewardListener(node)
      local towerId = node.nodeId
      
      self:__RefreshTwinSelectReddot(towerId)
    end
    
    RedDotController:AddListener(RedDotDynPath.DunTwinTowerReward, self._racingRewardListener)
  end
  self.ui.scrollRect.verticalNormalizedPosition = 1 - (defaultIndex - 1) / towerCount
end

function UIDungeonTwinTowerSelect:__RefreshTwinSelectReddot(towerId)
  local twinTowerItem = self.__twinItemDic[towerId]
  if twinTowerItem == nil then
    return
  end
  local towerNode = self.__twinTowerNode:GetChild(towerId)
  local hasRedot = false
  if towerNode ~= nil then
    hasRedot = towerNode:GetRedDotCount() > 0
  end
  twinTowerItem:SetTwinTowerItemReddot(hasRedot)
end

function UIDungeonTwinTowerSelect:OnSelectTwinTower(towerTypeData)
  local towerId = towerTypeData:GetDungeonTowerTypeId()
  UIUtil.OnClickBackByUiTab(self)
  if towerId == self.__selectTowerId then
    return
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if userDataCache:SetTwinTowerNewReaded(towerId, true) then
    PlayerDataCenter.dungeonTowerSData:ClearNewDunTower(towerId)
    local selectWindow = UIManager:GetWindow(UIWindowTypeID.DungeonTowerSelect)
    if selectWindow ~= nil then
      selectWindow:RefreshTowerSelectBlueDot()
    end
  end
  towerTypeData:GenTowerLevelListData()
  local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
    if window == nil then
      return
    end
    window:CloseLevelDetailWindow()
    window:InitDungeonTowerLevel(self.__dunTowerCtrl, towerTypeData, completeLevel)
  end)
end

function UIDungeonTwinTowerSelect:_OnBtnCancelClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonTwinTowerSelect:_OnClickTowerReturn()
  self:Delete()
end

function UIDungeonTwinTowerSelect:OnDelete()
  if self._racingRewardListener ~= nil then
    RedDotController:RemoveListener(RedDotDynPath.DunTwinTowerReward, self._racingRewardListener)
  end
  self.ui.cg_Lock:DOKill()
  self.__twinTowerPool:DeleteAll()
  base.OnDelete(self)
end

return UIDungeonTwinTowerSelect
