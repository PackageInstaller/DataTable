local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local SectorPlayModeCtrlBase = class("SectorPlayModeCtrlBase", base)

function SectorPlayModeCtrlBase:ctor(sctCtrl)
end

function SectorPlayModeCtrlBase:IsSectorPlayModeUnlock(entranceType)
  return self:IsSectorPlayModeExist(entranceType)
end

function SectorPlayModeCtrlBase:IsSectorPlayModeExist(entranceType)
  return true
end

function SectorPlayModeCtrlBase:OpenSectorPlayMode(entranceType)
  error("must be Overraid")
end

function SectorPlayModeCtrlBase:GetSectorPlayModeShowData(entranceType)
  error("must be Overraid")
end

function SectorPlayModeCtrlBase:GetPlayModeReddotNode()
  return nil
end

function SectorPlayModeCtrlBase:GetPlayModeReddotTypeAndNum()
  local isBlue = false
  return isBlue, 0
end

function SectorPlayModeCtrlBase:OnDelete()
end

return SectorPlayModeCtrlBase
