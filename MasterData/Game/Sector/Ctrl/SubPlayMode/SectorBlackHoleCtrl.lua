local base = require("Game.Sector.Ctrl.SubPlayMode.base.SectorPlayModeCtrlBase")
local SectorBlackHoleCtrl = class("SectorBlackHoleCtrl", base)
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local SectorPlayModeData = require("Game.Sector.Data.SectorPlayModeData")
local eSectorState = require("Game.Sector.Enum.eSectorState")

function SectorBlackHoleCtrl:ctor(sectorCtrl)
end

function SectorBlackHoleCtrl:IsSectorPlayModeUnlock(entranceType)
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower), FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower)
end

function SectorBlackHoleCtrl:OpenSectorPlayMode(entranceType, lastTowerId, closeFunc, openfunc)
  local dungeonTowerCtrl = ControllerManager:GetController(ControllerTypeId.DungeonTower, true)
  if lastTowerId == nil then
    if closeFunc == nil then
      function closeFunc()
        self.sctCtrl:SetSctState(eSectorState.InNotMainEntrance)
      end
    else
      local realCloseFunc = closeFunc
      
      function closeFunc()
        self.sctCtrl:SetSctState(eSectorState.InNotMainEntrance)
        realCloseFunc()
      end
    end
    if openfunc == nil then
      function openfunc()
        self.sctCtrl:SetSctState(eSectorState.CorverSector)
      end
    end
    dungeonTowerCtrl:ShowDungeonTowerMain(closeFunc, openfunc)
  else
    dungeonTowerCtrl:DirectEnterTowerLevel(lastTowerId, closeFunc, openfunc)
  end
end

function SectorBlackHoleCtrl:GetSectorPlayModeShowData(entranceType)
  local curLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerCompleteLevel()
  local totalLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerTotalLevel()
  local modeData = SectorPlayModeData.New()
  modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.process, {
    tostring(curLevel),
    tostring(totalLevel)
  })
  return modeData
end

function SectorBlackHoleCtrl:GetPlayModeReddotNode()
  local _, dunTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower)
  return dunTowerNode
end

function SectorBlackHoleCtrl:GetPlayModeReddotTypeAndNum()
  local redNum = self:GetPlayModeReddotNode():GetRedDotCount()
  if redNum <= 0 and (PlayerDataCenter.dungeonTowerSData:HasNewDunTwinTower() or PlayerDataCenter.dungeonTowerSData:IsNewNormalDunTower()) then
    return true, 1
  end
  return false, redNum
end

function SectorBlackHoleCtrl.IsEntrancetypeBlackHole(entranceType)
  return entranceType == eSectorEntrance.eEntranceType.blackHole
end

function SectorBlackHoleCtrl:OnDelete()
end

return SectorBlackHoleCtrl
