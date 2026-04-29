_class("SeasonMazeInputMobile", SeasonMazeInputBase)
SeasonMazeInputMobile = SeasonMazeInputMobile

function SeasonMazeInputMobile:Constructor(onClick)
  self._onClick = onClick
end

function SeasonMazeInputMobile:Dispose()
end

function SeasonMazeInputMobile:Update(deltaTime)
  SeasonMazeInputMobile.super.Update(self, deltaTime)
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
          local results = UnityEngine.Physics.RaycastAll(ray, 1000, 1 << SMazeSceneLayer.Arrow | 1 << SMazeSceneLayer.Room)
          if results and 0 < results.Length then
            self._curClickEventPoint = nil
            self._clickPositionInUnlockZone = false
            local sortedResults = {}
            for i = 0, results.Length - 1 do
              table.insert(sortedResults, results[i])
            end
            table.sort(sortedResults, function(a, b)
              return a.distance < b.distance
            end)
            self._onClick(sortedResults)
          end
        end
      end
    end
  end
end
