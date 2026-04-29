_class("BuffViewDestroyEffect", BuffViewBase)
BuffViewDestroyEffect = BuffViewDestroyEffect

function BuffViewDestroyEffect:PlayView(TT, notify)
  local result = self._buffResult
  local gameObjectName = result:GetObjName()
  local waitTime = result:GetWaitTime()
  local targetGameObject = UnityEngine.GameObject.Find(gameObjectName)
  if not targetGameObject then
    return
  end
  if waitTime and 0 < waitTime then
    local fadeComponent = targetGameObject:AddComponent(typeof(FadeComponent))
    fadeComponent.Alpha = 1
    local mathService = self._world:GetService("Math")
    local tmpDuration = waitTime
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      while fadeComponent.Alpha > 0 do
        tmpDuration = tmpDuration - UnityEngine.Time.deltaTime
        local tran = tmpDuration / waitTime
        tran = mathService:ClampValue(tran, 0, 1)
        fadeComponent.Alpha = tran
        YIELD(TT)
      end
      if targetGameObject then
        UnityEngine.Object.Destroy(targetGameObject)
      end
    end)
  else
    UnityEngine.Object.Destroy(targetGameObject)
  end
end

function BuffViewDestroyEffect:IsNotifyMatch(notify)
  return true
end
