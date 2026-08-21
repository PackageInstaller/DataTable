_class("LuckLandGame", Object)
LuckLandGame = LuckLandGame

function LuckLandGame:Constructor()
  self._module = LuckLandModule:New()
  self._eventListener = LuckLandEventListener:New(self)
end

function LuckLandGame:Dispose()
  self._module:Dispose()
  self._module = nil
  self._eventListener:Dispose()
  self._eventListener = nil
  LuckLandInnerGameHelper:GetInstance():Dispose()
end

function LuckLandGame:EnterLuckLandGame(missionID)
  self._module:Init(missionID)
end

function LuckLandGame:EventDispatcher()
  return GameGlobal.EventDispatcher()
end

function LuckLandGame:GetLuckLandModule()
  return self._module
end
