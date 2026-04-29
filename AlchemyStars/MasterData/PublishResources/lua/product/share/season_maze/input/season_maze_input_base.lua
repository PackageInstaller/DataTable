_class("SeasonMazeInputBase", Object)
SeasonMazeInputBase = SeasonMazeInputBase

function SeasonMazeInputBase:Constructor(seasonID)
  self._seasonMazeManger = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager()
  self._player = self._seasonMazeManger:Player()
  self._camera = self._seasonMazeManger:SeasonMazeCameraManager():Camera()
  self._seasonCamera = self._seasonMazeManger:SeasonMazeCameraManager():SeasonCamera()
  self._zoneFlagLayer = self._seasonMazeManger:SeasonMazeSceneManager():GetLayer(SeasonSceneLayer.ZoneFlag)
  self._input = GameGlobal.EngineInput()
  self._clickTime = 0.2
  self._clickDownTime = 0
  self._clickEffect = SeasonMazeInputEffect:New(seasonID)
  self._functionTag = "Function"
end

function SeasonMazeInputBase:Update(deltaTime)
  self._clickEffect:Update(deltaTime)
end

function SeasonMazeInputBase:Dispose()
  self._clickEffect:Dispose()
end

function SeasonMazeInputBase:GetClickEffect()
  return self._clickEffect
end
