local base = require("Game.Sector.Ctrl.SubPlayMode.base.SectorPlayModeCtrlBase")
local SectorSixHeroTowerCtrl = class("SectorSixHeroTowerCtrl", base)
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local SectorPlayModeData = require("Game.Sector.Data.SectorPlayModeData")
local eSectorState = require("Game.Sector.Enum.eSectorState")

function SectorSixHeroTowerCtrl:ctor(sectorCtrl)
end

function SectorSixHeroTowerCtrl:IsSectorPlayModeUnlock(entranceType)
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower), FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower)
end

function SectorSixHeroTowerCtrl:OpenSectorPlayMode(entranceType, lastTowerId, closeFunc, openfunc)
  local dunSixHeroCtrl = ControllerManager:GetController(ControllerTypeId.DunSixHeroTower, true)
  if lastTowerId == nil then
    dunSixHeroCtrl:ShowHexaTower(closeFunc, openfunc)
  else
    dunSixHeroCtrl:ShowHexaTower(closeFunc, openfunc, lastTowerId)
  end
end

function SectorSixHeroTowerCtrl:GetSectorPlayModeShowData(entranceType)
  local dunSixHeroCtrl = ControllerManager:GetController(ControllerTypeId.DunSixHeroTower, true)
  local normalTowwerIdList = dunSixHeroCtrl:GetCurrentNormalTower()
  local periodicTowwerIdList = dunSixHeroCtrl:GetCurrentTimeLimitTower()
  local ntn, ncn = dunSixHeroCtrl:GetProgressByTowerList(normalTowwerIdList)
  local modeData = SectorPlayModeData.New()
  modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.process, {
    tostring(ncn),
    tostring(ntn)
  })
  if 0 < #periodicTowwerIdList then
    local ptn, pcn = dunSixHeroCtrl:GetProgressByTowerList(periodicTowwerIdList)
    local endTime = dunSixHeroCtrl:GetCurrentPeriodicEndtime(periodicTowwerIdList)
    local endTimeStr = TimeUtil:TimestampToDateString(endTime, false, true, ConfigData:GetTipContent(6052))
    modeData:SetSSPMStateInfo(eSectorEntrance.secondStateInfoType.periodicProcess, {
      tostring(pcn),
      tostring(ptn)
    })
    modeData:SetSPEndTime(endTimeStr)
  end
  return modeData
end

function SectorSixHeroTowerCtrl:GetPlayModeReddotNode()
  local _, dunTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower)
  return dunTowerNode
end

function SectorSixHeroTowerCtrl:GetPlayModeReddotTypeAndNum()
  local dunSixHeroCtrl = ControllerManager:GetController(ControllerTypeId.DunSixHeroTower, true)
  local periodicTowwerIdList = dunSixHeroCtrl:GetCurrentTimeLimitTower()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local redNum = self:GetPlayModeReddotNode():GetRedDotCount()
  if redNum <= 0 then
    local isHaveUnrade = false
    for index, towerId in ipairs(periodicTowwerIdList) do
      local isRade = userDataCache:GetTwinTowerNewReaded(towerId)
      if not isRade then
        isHaveUnrade = true
        break
      end
    end
    if isHaveUnrade then
      return true, 1
    end
  end
  return false, redNum
end

function SectorSixHeroTowerCtrl.IsEntrancetypeSixHeroTower(entranceType)
  return entranceType == eSectorEntrance.eEntranceType.sixHeroTower
end

function SectorSixHeroTowerCtrl:OnDelete()
end

return SectorSixHeroTowerCtrl
