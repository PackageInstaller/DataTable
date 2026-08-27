local UIDungeonTowerSelect = class("UIDungeonTowerSelect", UIBaseWindow)
local base = UIBaseWindow
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local UINDunTowerSelectItem = require("Game.DungeonCenter.TowerUI.UINDunTowerSelectItem")
local DungeonTypeTower = require("Game.DungeonCenter.Data.DungeonTypeTower")

function UIDungeonTowerSelect:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnBtnTowerRankClick)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.OnBtnTowerGotoClick)
  self.ui.towerItem:SetActive(false)
  self.__onDunTowerTypeSelect = BindCallback(self, self.OnDunTowerTypeSelect)
end

function UIDungeonTowerSelect:InitDungeonTowerSelect(dunTowerCtrl, towerCat)
  self.__dunTowerCtrl = dunTowerCtrl
  self.__towerItems = {}
  local normalItem = self:__GenTowerSelectItem(DungeonLevelEnum.DunTowerCategory.Normal)
  local twinItem
  local twinTowerList = ConfigData.dungeon_tower_type.twin_towers
  if 0 < #twinTowerList then
    twinItem = self:__GenTowerSelectItem(DungeonLevelEnum.DunTowerCategory.TwinTower)
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect_main.transform)
  self.ui.rect_main.enabled = false
  if self._twinTowerListener == nil then
    function self._twinTowerListener(node)
      local active = node:GetRedDotCount() > 0
      
      local twinItem = self.__towerItems[DungeonLevelEnum.DunTowerCategory.TwinTower]
      if twinItem == nil then
        return
      end
      twinItem:SetTowerReddot(active)
      if self.__selectItem == twinItem then
        self.ui.redDot_Enter:SetActive(active)
      end
    end
    
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
    RedDotController:AddListener(twinTowerNode.nodePath, self._twinTowerListener)
    self._twinTowerListener(twinTowerNode)
  end
  self:RefreshTowerSelectBlueDot()
  local catId = towerCat or DungeonLevelEnum.DunTowerCategory.Normal
  self:OnDunTowerTypeSelect(catId, self.__towerItems[catId], true)
  normalItem:__PlayInitTween(self.__selectItem)
  if twinItem ~= nil then
    twinItem:__PlayInitTween(self.__selectItem)
  end
end

function UIDungeonTowerSelect:RefreshTowerSelectBlueDot()
  local twinItem = self.__towerItems[DungeonLevelEnum.DunTowerCategory.TwinTower]
  if twinItem ~= nil then
    twinItem:SetTowerBluedot(PlayerDataCenter.dungeonTowerSData:HasNewDunTwinTower())
  end
  local normalItem = self.__towerItems[DungeonLevelEnum.DunTowerCategory.Normal]
  if normalItem ~= nil then
    normalItem:SetTowerBluedot(PlayerDataCenter.dungeonTowerSData:IsNewNormalDunTower())
  end
end

function UIDungeonTowerSelect:__GenTowerSelectItem(catId)
  local go = self.ui.towerItem:Instantiate()
  go:SetActive(true)
  local towerItem = UINDunTowerSelectItem.New()
  towerItem:Init(go)
  local name = self.ui.tex_TowerName:GetIndex(catId)
  towerItem:InitTowerSelectItem(catId, self.__onDunTowerTypeSelect, name)
  self.__towerItems[catId] = towerItem
  return towerItem
end

function UIDungeonTowerSelect:OnDunTowerTypeSelect(catId, towerItem, isinit)
  if towerItem == nil then
    return
  end
  if self.__selectItem == towerItem then
    return
  end
  if self.__selectItem ~= nil then
    self.__selectItem:SetTowerSelected(false, isinit)
  end
  self.__selectCatId = catId
  self.__selectItem = towerItem
  towerItem:SetTowerSelected(true, isinit)
  local isNoraml = catId == DungeonLevelEnum.DunTowerCategory.Normal
  self.ui.btn_Rank.gameObject:SetActive(isNoraml)
  self.ui.tex_Progress.gameObject:SetActive(isNoraml)
  if isNoraml then
    local completeLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerCompleteLevel()
    local totalLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerTotalLevel()
    self.ui.tex_Progress:SetIndex(0, tostring(completeLevel), tostring(totalLevel))
    self.ui.redDot_Enter:SetActive(false)
  else
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
    self.ui.redDot_Enter:SetActive(0 < twinTowerNode:GetRedDotCount())
  end
  if isinit then
    self:__SetUiIndex(catId)
  else
    self:PlaySwitchTweenAnim(catId)
  end
  self.ui.img_Background1:DOComplete()
  self.ui.img_Background1:DOFade(isNoraml and 1 or 0, 0.2)
end

function UIDungeonTowerSelect:GotoDunTowerByCat(catId)
  if catId == DungeonLevelEnum.DunTowerCategory.Normal then
    local towerId = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerId()
    local towerTypeData = DungeonTypeTower.New(towerId)
    local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
      if window == nil then
        return
      end
      window:InitDungeonTowerLevel(self.__dunTowerCtrl, towerTypeData, completeLevel)
    end)
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local towerCfg = ConfigData.dungeon_tower_type[towerId]
    if userDataCache:SetNormalTowerLevel(towerCfg.total_level) then
      self.__towerItems[DungeonLevelEnum.DunTowerCategory.Normal]:SetTowerBluedot(false)
      PlayerDataCenter.dungeonTowerSData:ClearNewDunTower(towerId)
    end
  elseif catId == DungeonLevelEnum.DunTowerCategory.TwinTower then
    local twinTowerList = ConfigData.dungeon_tower_type.twin_towers
    if #twinTowerList == 1 then
      local towerId = twinTowerList[1]
      local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
      UIManager:DeleteWindow(UIWindowTypeID.DungeonTowerLevel)
      UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
        if window == nil then
          return
        end
        local towerTypeData = DungeonTypeTower.New(towerId)
        window:InitDungeonTowerLevel(self.__dunTowerCtrl, towerTypeData, completeLevel)
      end)
    else
      self.__dunTowerCtrl:RequestRacingRankSelfInfo(function(myRankDetail)
        UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTwinTowerSelect, function(window)
          if window == nil then
            return
          end
          window:InitDunTwinTowerSelect(self.__dunTowerCtrl, 0, myRankDetail)
        end, UIWindowTypeID.DungeonTwinTowerSelectNoAni)
      end)
    end
  end
end

function UIDungeonTowerSelect:OnBtnTowerRankClick()
  local towerId = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerId()
  local rankId = ConfigData.dungeon_tower_type[towerId].rank_id
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId)
  end)
end

function UIDungeonTowerSelect:OnBtnTowerGotoClick()
  self:GotoDunTowerByCat(self.__selectCatId)
end

function UIDungeonTowerSelect:_OnClickBack(toHome)
  self.__dunTowerCtrl:ExitDungeonTower(toHome)
end

function UIDungeonTowerSelect:OnDelete()
  if self._twinTowerListener ~= nil then
    local _, twinTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower, RedDotStaticTypeId.DungeonTwinTower)
    RedDotController:RemoveListener(twinTowerNode.nodePath, self._twinTowerListener)
  end
  for _, item in pairs(self.__towerItems) do
    item:Delete()
  end
  self.__towerItems = nil
  self.ui.img_Background1:DOKill()
  base.OnDelete(self)
end

function UIDungeonTowerSelect:PlaySwitchTweenAnim(catId)
  local __TowerNamePos = self.ui.tex_TowerName.transform.localPosition
  local Tweenitem = self.ui.TweenAnimation
  Tweenitem:DORestartAllById("Start")
  Tweenitem:DORestartAllById("Fade")
  Tweenitem.onComplete:AddListener(BindCallback(self, function()
    self:SetBack(__TowerNamePos)
    self:__SetUiIndex(catId)
    Tweenitem:DORestartAllById("FadeOut")
    Tweenitem:DORestartAllById("End")
  end))
end

function UIDungeonTowerSelect:__SetUiIndex(catId)
  self.ui.tex_Pattern:SetIndex(catId)
  self.ui.tex_TowerName:SetIndex(catId)
  self.ui.tex_TowerMode:SetIndex(catId)
end

function UIDungeonTowerSelect:SetBack(__TowerNamePos)
  self.ui.tex_TowerName.transform.localPosition = Vector3.New(__TowerNamePos.x - 37, __TowerNamePos.y, 0)
  self.ui.tex_TowerMode.transform.localPosition = Vector3.New(0, 50, 0)
  self.ui.tex_Pattern.transform.localPosition = Vector3.New(25.38, -25, 0)
end

return UIDungeonTowerSelect
