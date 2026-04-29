_class("SeasonMazeInputPc", SeasonMazeInputBase)
SeasonMazeInputPc = SeasonMazeInputPc

function SeasonMazeInputPc:Constructor(onClick)
  self._onClick = onClick
end

function SeasonMazeInputPc:Dispose()
end

function SeasonMazeInputPc:Update(deltaTime)
  SeasonMazeInputPc.super.Update(self, deltaTime)
  if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
    return
  end
  if self._input.GetMouseButtonDown(0) then
    self._clickDownTime = GetSvrTimeNow()
  end
  if self._input.GetMouseButtonUp(0) then
    if self._seasonCamera:IsDraging() then
      return
    end
    if GetSvrTimeNow() - self._clickDownTime <= self._clickTime * 1000 then
      local ray = self._camera:ScreenPointToRay(self._input.mousePosition)
      local results = UnityEngine.Physics.RaycastAll(ray, 1000, 1 << SMazeSceneLayer.Arrow | 1 << SMazeSceneLayer.Room)
      if results and 0 < results.Length then
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
