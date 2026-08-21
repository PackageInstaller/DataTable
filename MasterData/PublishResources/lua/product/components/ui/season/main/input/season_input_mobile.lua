_class("SeasonInputMobile", SeasonInputBase)
SeasonInputMobile = SeasonInputMobile

function SeasonInputMobile:Constructor(seasonID)
end

function SeasonInputMobile:Dispose()
end

function SeasonInputMobile:Update(deltaTime)
  SeasonInputMobile.super.Update(self, deltaTime)
  if self._input.touchCount > 0 then
    local t0 = self._input.GetTouch(0)
    if t0 then
      if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(t0.fingerId) then
        return
      end
      if not self._player then
        return
      end
      if t0.phase == TouchPhase.Began then
        self._clickDownTime = UnityEngine.Time.time
      end
      if t0.phase == TouchPhase.Ended or t0.phase == TouchPhase.Canceled then
        if self._seasonCamera:IsDraging() then
          return
        end
        if UnityEngine.Time.time - self._clickDownTime <= self._clickTime then
          local ray = self._camera:ScreenPointToRay(Vector3(t0.position.x, t0.position.y, 0))
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
  end
end
