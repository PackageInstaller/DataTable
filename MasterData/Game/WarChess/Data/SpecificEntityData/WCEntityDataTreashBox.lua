local base = require("Game.WarChess.Data.WarChessEntityData")
local WCEntityDataTreashBox = class("WCEntityDataTreashBox", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local OPEN_TREASURE_BOX_WAIT_TIME = 1

function WCEntityDataTreashBox:PlayEntityAnimation(animaId, trigger, callback)
  if animaId == -1 then
    self.__entity:PlayWCEntityDownTween(0.75, 0.25)
  else
    self.__entity:PlayWCEntityAnimation(animaId, trigger)
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl.state == eWarChessEnum.eWarChessState.play then
      wcCtrl.curState:SetIsWaitingEntityAnimation(true)
      self.__treashBoxTimerId = TimerManager:StartTimer(OPEN_TREASURE_BOX_WAIT_TIME, function()
        wcCtrl.curState:SetIsWaitingEntityAnimation(false)
        wcCtrl:RunAllSystemChange()
        self.__treashBoxTimerId = nil
      end, self, true)
    end
  end
  if callback ~= nil then
    callback()
  end
end

function WCEntityDataTreashBox:CleanTimerAndTween()
  if self.__treashBoxTimerId ~= nil then
    TimerManager:StopTimer(self.__treashBoxTimerId)
    self.__treashBoxTimerId = nil
  end
  base.CleanTimerAndTween(self)
end

return WCEntityDataTreashBox
