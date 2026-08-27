local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessSubSystemCtrlBase = class("WarChessSubSystemCtrlBase", base)

function WarChessSubSystemCtrlBase:ctor(wcCtrl)
  local cat = self:__GetWCSubSystemCat()
  if cat == nil then
    error("not't def wc sub system cat, pleas check it")
  else
    wcCtrl.cat2SubCtrlDic[cat] = self
  end
end

function WarChessSubSystemCtrlBase:__GetWCSubSystemCat()
end

function WarChessSubSystemCtrlBase:OpenWCSubSystem(systemState, identify)
end

function WarChessSubSystemCtrlBase:CloseWCSubSystem(isSwitchClose)
end

return WarChessSubSystemCtrlBase
