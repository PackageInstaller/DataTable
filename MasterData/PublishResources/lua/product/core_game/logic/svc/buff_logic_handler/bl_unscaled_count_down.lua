_class("BuffLogicStartUnscaledCountDown", BuffLogicBase)
BuffLogicStartUnscaledCountDown = BuffLogicStartUnscaledCountDown

function BuffLogicStartUnscaledCountDown:Constructor(buffInstance, logicParam)
  self._flagID = logicParam.flagID or 1
  self._cdMs = logicParam.cdMs
  self._isGlobal = logicParam.isGlobal or 1
  self._showGlobalUI = logicParam.showGlobalUI or 1
end

function BuffLogicStartUnscaledCountDown:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local flagID = self._flagID
  if self._isGlobal and self._isGlobal == 1 then
    flagID = BattleConst.ClientGlobalUnscaledCountDownFlagID
  end
  if self._isGlobal and self._isGlobal == 1 then
    local boardEntity = self._world:GetBoardEntity()
    local cmpt = boardEntity:UnscaledCountDownLogic()
    Log.debug("BuffLogicStartUnscaledCountDown get cmpt")
    if cmpt then
      cmpt:StartCoundDown(flagID, self._cdMs)
      Log.debug("BuffLogicStartUnscaledCountDown cmpt flagID:", cmpt:GetFlagID(), " isActive:", cmpt:GetIsActive())
    end
  end
  return BuffResultStartUnscaledCountDown:New(flagID, self._cdMs, self._showGlobalUI)
end

_class("BuffLogicStopUnscaledCountDown", BuffLogicBase)
BuffLogicStopUnscaledCountDown = BuffLogicStopUnscaledCountDown

function BuffLogicStopUnscaledCountDown:Constructor(buffInstance, logicParam)
  self._flagID = logicParam.flagID or 1
  self._isGlobal = logicParam.isGlobal or 1
  self._hideGlobalUI = logicParam.hideGlobalUI or 1
end

function BuffLogicStopUnscaledCountDown:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local flagID = self._flagID
  if self._isGlobal and self._isGlobal == 1 then
    flagID = BattleConst.ClientGlobalUnscaledCountDownFlagID
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownLogic)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownLogic()
    Log.debug("BuffLogicStopUnscaledCountDown cmpt flagID:", cmpt:GetFlagID(), " isActive:", cmpt:GetIsActive())
    if flagID == cmpt:GetFlagID() then
      cmpt:Reset()
      break
    end
  end
  return BuffResultStopUnscaledCountDown:New(flagID, self._hideGlobalUI)
end
