local CopiesScene, Super = System.NewClass("CopiesScene", BaseSceneState)

function CopiesScene:ctor()
  Super.ctor(self)
end

function CopiesScene:OnInitSceneData()
  Super.OnInitSceneData(self)
end

function CopiesScene:OnEnterScene(data)
  Super.OnEnterScene(self, data)
  self:_StartReleaseResTimer()
end

function CopiesScene:OnExitScene()
  Super.OnExitScene(self)
  CopiesDataUtils.ResetAll()
end

return CopiesScene
