_class("SeasonSceneEnvironmentBase", Object)
SeasonSceneEnvironmentBase = SeasonSceneEnvironmentBase

function SeasonSceneEnvironmentBase:Constructor(sceneRoot)
  self._sceneRootTransform = sceneRoot.transform
  self._isUnlock = false
end

function SeasonSceneEnvironmentBase:Update(deltaTime)
end

function SeasonSceneEnvironmentBase:Dispose()
end

function SeasonSceneEnvironmentBase:UnLock()
end
