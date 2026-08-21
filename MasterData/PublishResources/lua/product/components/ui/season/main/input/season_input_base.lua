_class("SeasonInputBase", Object)
SeasonInputBase = SeasonInputBase

function SeasonInputBase:Constructor(seasonID)
  self._seasonManger = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._player = self._seasonManger:SeasonPlayerManager():GetPlayer()
  self._camera = self._seasonManger:SeasonCameraManager():Camera()
  self._seasonCamera = self._seasonManger:SeasonCameraManager():SeasonCamera()
  self._zoneFlagLayer = self._seasonManger:SeasonSceneManager():GetLayer(SeasonSceneLayer.ZoneFlag)
  self._input = GameGlobal.EngineInput()
  self._clickTime = 0.2
  self._clickDownTime = 0
  self._curClickEventPoint = nil
  self._clickPositionInUnlockZone = false
  self._clickZoneId = nil
  self._clickEffect = SeasonInputEffect:New(seasonID)
  self._functionTag = "Function"
end

function SeasonInputBase:Update(deltaTime)
  self._clickEffect:Update(deltaTime)
end

function SeasonInputBase:Dispose()
  self._player = nil
  self._clickEffect:Dispose()
end

function SeasonInputBase:GetCurClickEventPoint()
  return self._curClickEventPoint
end

function SeasonInputBase:SetCurClickEventPoint(eventPoint)
  self._curClickEventPoint = eventPoint
end

function SeasonInputBase:GetClickUnLockZone()
  return self._clickPositionInUnlockZone
end

function SeasonInputBase:GetClickZoneID()
  return self._clickZoneId
end

function SeasonInputBase:SetClickZoneID(zoneId)
  self._clickZoneId = zoneId
end

function SeasonInputBase:SetClickUnLockZone(clickUnlock)
  self._clickPositionInUnlockZone = clickUnlock
end

function SeasonInputBase:GetClickEffect()
  return self._clickEffect
end

function SeasonInputBase:GetEventPointByFunction(gameObject)
  local ui = self._seasonManger:SeasonUIManager():UI()
  if ui then
    return ui:GetEventPointByFunction(gameObject)
  end
end
