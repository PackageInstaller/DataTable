local UIDunHexaTower = class("UIDunHexaTower", UIBaseWindow)
local base = UIBaseWindow
local UINDunHexaTowerInfoNode = require("Game.DungeonCenter.SixHeroTower.UINDunHexaTowerInfoNode")
local UINDunHexaTowerModNode = require("Game.DungeonCenter.SixHeroTower.UINDunHexaTowerModNode")

function UIDunHexaTower:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickBack)
  self.infoNode = UINDunHexaTowerInfoNode.New()
  self.infoNode:Init(self.ui.infoGroupNode)
  self.modNode = UINDunHexaTowerModNode.New()
  self.modNode:Init(self.ui.ModeNode)
  self.__OnClickPeriod = BindCallback(self, self.__OnClickTowerBtn, true)
  self.__OnClickNormal = BindCallback(self, self.__OnClickTowerBtn, false)
  self.modNode:InitTowerModNode(self.__OnClickPeriod, self.__OnClickNormal)
end

function UIDunHexaTower:InitHexaTower(dunSixHeroCtrl, closeFunc, lastTowerId)
  self.dunSixHeroCtrl = dunSixHeroCtrl
  self.closeFunc = closeFunc
  self:DunHexaTowerAllRefresh()
  self:BackFromBattle(lastTowerId)
end

function UIDunHexaTower:DunHexaTowerAllRefresh()
  self.normalTowwerIdList = self.dunSixHeroCtrl:GetCurrentNormalTower()
  self.periodicTowwerIdList = self.dunSixHeroCtrl:GetCurrentTimeLimitTower()
  self._isHavePeriodic = #self.periodicTowwerIdList > 0
  if self._isHavePeriodic then
    self._endTime = self.dunSixHeroCtrl:GetCurrentPeriodicEndtime(self.periodicTowwerIdList)
  end
  self:RefreshInfo()
  self:RefreshMode()
  self:__InitRedDot()
end

function UIDunHexaTower:RefreshInfo()
  self.infoNode:RefreshEndtime(self._isHavePeriodic, self._endTime)
end

function UIDunHexaTower:RefreshMode()
  local tnn, cnn = self.dunSixHeroCtrl:GetProgressByTowerList(self.normalTowwerIdList)
  local tnp, cnp
  if self._isHavePeriodic then
    tnp, cnp = self.dunSixHeroCtrl:GetProgressByTowerList(self.periodicTowwerIdList)
  end
  self.modNode:RefreshProgress(tnn, cnn, self._isHavePeriodic, tnp, cnp)
end

function UIDunHexaTower:__InitRedDot()
  if self.reddotListener == nil then
    function self.reddotListener(node)
      local active = node:GetRedDotCount() > 0
      
      self.modNode.ui.RedDot_Period:SetActive(active)
    end
    
    local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
    RedDotController:AddListener(node.nodePath, self.reddotListener)
    self.reddotListener(node)
  end
  local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
  if node ~= nil and node:GetRedDotCount() > 0 then
    self.modNode.ui.BlueDot_Period:SetActive(false)
    return
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isHaveUnrade = false
  for index, towerId in ipairs(self.periodicTowwerIdList) do
    local isRade = userDataCache:GetTwinTowerNewReaded(towerId)
    if not isRade then
      isHaveUnrade = true
      break
    end
  end
  self.modNode.ui.BlueDot_Period:SetActive(isHaveUnrade)
end

function UIDunHexaTower:__OnClickTowerBtn(isPeriodic)
  local window = UIManager:ShowWindow(UIWindowTypeID.DungeonHexaTowerSelect)
  if window == nil then
    return
  end
  window:RefreshSelectNode(self.dunSixHeroCtrl, self._isHavePeriodic, self.normalTowwerIdList, self.periodicTowwerIdList, nil)
  window:HexaTowerSelectTag(isPeriodic)
end

function UIDunHexaTower:BackFromBattle(lastTowerId)
  if lastTowerId == nil then
    return
  end
  local HexaTowerData = require("Game.DungeonCenter.SixHeroTower.HexaTowerData")
  local towerId = lastTowerId
  local towerTypeData = HexaTowerData.New(towerId)
  local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
    if window == nil then
      return
    end
    window:CloseLevelDetailWindow()
    window:InitDungeonTowerLevel4HexaTower(self.dunSixHeroCtrl, towerTypeData, completeLevel)
  end)
end

function UIDunHexaTower:_OnClickBack(toHome)
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
  self:Delete()
end

function UIDunHexaTower:OnDelete()
  if self.reddotListener ~= nil then
    local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
    RedDotController:RemoveListener(node.nodePath, self.reddotListener)
    self.reddotListener = nil
  end
  base.OnDelete(self)
end

return UIDunHexaTower
