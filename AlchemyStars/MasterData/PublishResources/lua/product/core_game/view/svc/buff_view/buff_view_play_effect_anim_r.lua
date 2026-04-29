_class("BuffViewPlayEffectAnim", BuffViewBase)
BuffViewPlayEffectAnim = BuffViewPlayEffectAnim

function BuffViewPlayEffectAnim:PlayView(TT)
  local result = self._buffResult
  local gameObjectName = result:GetObjName()
  local animName = result:GetAnimName()
  local waitTime = result:GetWaitTime()
  local targetGameObject = UnityEngine.GameObject.Find(gameObjectName)
  if not targetGameObject then
    return
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, waitTime * 1000)
    targetGameObject = UnityEngine.GameObject.Find(gameObjectName)
    if targetGameObject and animName then
      local anim = targetGameObject.gameObject:GetComponent("Animation")
      anim:Play(animName)
    end
  end)
end
