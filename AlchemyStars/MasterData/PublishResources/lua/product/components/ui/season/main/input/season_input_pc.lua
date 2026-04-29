_class("SeasonInputPc", SeasonInputBase)
SeasonInputPc = SeasonInputPc

function SeasonInputPc:Constructor(seasonID)
end

function SeasonInputPc:Dispose()
end

function SeasonInputPc:Update(deltaTime)
  SeasonInputPc.super.Update(self, deltaTime)
  if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
    return
  end
  if not self._player then
    return
  end
  if self._input.GetMouseButtonDown(0) then
    self._clickDownTime = UnityEngine.Time.time
  end
  if self._input.GetMouseButtonUp(0) then
    if self._seasonCamera:IsDraging() then
      return
    end
    if UnityEngine.Time.time - self._clickDownTime <= self._clickTime then
      local ray = self._camera:ScreenPointToRay(self._input.mousePosition)
      local results = UnityEngine.Physics.RaycastAll(ray, 1000, 1 << SeasonLayerMask.Default | 1 << SeasonLayerMask.Stage | 1 << SeasonLayerMask.Scene | 1 << SeasonLayerMask.UI)
      local destination
      if results and 0 < results.Length then
        self._curClickEventPoint = nil
        self._clickPositionInUnlockZone = false
        self._clickZoneId = nil
        for i = 0, results.Length - 1 do
          local gameObject = results[i].transform.gameObject
          if gameObject.layer == SeasonLayerMask.Default then
            if self._player:IsPlayer(gameObject) then
              self._player:TryPlayExpress(SeasonPlayerExpressType.Click)
              return
            end
          elseif gameObject.layer == SeasonLayerMask.UI then
            if gameObject.name == self._functionTag then
              self._curClickEventPoint = self:GetEventPointByFunction(gameObject)
            end
          elseif gameObject.layer == SeasonLayerMask.Scene then
            destination = results[i].point
            local contain, zoneID = self._zoneFlagLayer:GetZoneID(gameObject)
            if contain then
              local unlock = self._seasonManger:SeasonMapManager():IsUnLock(zoneID)
              self._clickPositionInUnlockZone = self._clickPositionInUnlockZone or unlock
              self._clickZoneId = zoneID
            end
          elseif gameObject.layer == SeasonLayerMask.Stage then
            self._curClickEventPoint = self._seasonManger:SeasonMapManager():GetEventPoint(tonumber(gameObject.name))
          end
        end
      end
      local play_move_click_sound = true
      if self._curClickEventPoint then
        local seasonAudio = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonAudioManager():GetSeasonAudio()
        if seasonAudio then
          seasonAudio:PlayEventAudio(self._curClickEventPoint:EventPointType())
          play_move_click_sound = false
        end
        local clickPosition = Vector3(self._curClickEventPoint:Position().x, self._player:Position().y, self._curClickEventPoint:Position().z)
        local direction = self._player:Position() - clickPosition
        direction = direction.normalized * self._curClickEventPoint:ObstacleRadius() * 2
        local targetPosition = clickPosition + direction
        local result, navMeshHit = UnityEngine.AI.NavMesh.Raycast(targetPosition, clickPosition, nil, UnityEngine.AI.NavMesh.AllAreas)
        if result then
          destination = navMeshHit.position
        end
        if EDITOR then
          UnityEngine.Debug.DrawLine(clickPosition, targetPosition, Color.red, 2)
        end
      end
      if destination then
        self._clickEffect:Click()
        self._player:SetDestination(destination, play_move_click_sound, nil)
      end
    end
  end
end
