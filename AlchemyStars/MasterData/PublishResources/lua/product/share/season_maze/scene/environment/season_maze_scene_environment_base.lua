_class("SeasonMazeSceneEnvironmentBase", Object)
SeasonMazeSceneEnvironmentBase = SeasonMazeSceneEnvironmentBase

function SeasonMazeSceneEnvironmentBase:Constructor(sceneRoot)
  self._sceneRootTransform = sceneRoot.transform
end

function SeasonMazeSceneEnvironmentBase:Update(deltaTime)
end

function SeasonMazeSceneEnvironmentBase:Dispose()
end

function SeasonMazeSceneEnvironmentBase:UnLock()
end
