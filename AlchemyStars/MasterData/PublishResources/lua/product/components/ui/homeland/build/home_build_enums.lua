local HomeBuildLayer = {
  Water = 4,
  Surface = 13,
  Building = 14,
  Drag = 15,
  Arrow = 16,
  BuildObstacle = 17,
  MedalWall = 18
}
_enum("HomeBuildLayer", HomeBuildLayer)
local HomeBuildEditType = {
  None = 0,
  Move = 1,
  Rotate = 2,
  Add = 4,
  Delete = 8,
  ChangeSkin = 16
}
_enum("HomeBuildEditType", HomeBuildEditType)
local BuildAdsorbType = {
  None = 0,
  Side = 1,
  Start2Start = 2,
  Start2End = 4,
  End2End = 8,
  End2Start = 16,
  END = 999
}
_enum("BuildAdsorbType", BuildAdsorbType)
local BuildGridSize = {
  One = 1,
  Two = 2,
  Three = 3
}
_enum("BuildGridSize", BuildGridSize)
local BuildArrowDirection = {
  Forward = 1,
  ForwardRight = 2,
  Right = 3,
  BackRight = 4,
  Back = 5,
  BackLeft = 6,
  Left = 7,
  ForwardLeft = 8
}
_enum("BuildArrowDirection", BuildArrowDirection)
local BuildEditorMode = {
  Normal = 1,
  ChangeSkin = 2,
  MakeMovieFree = 3,
  MakeMovieOther = 4,
  MakeMovieClosing = 5,
  None = 0
}
_enum("BuildEditorMode", BuildEditorMode)
local BuildEditIllegalType = {SonNotOnFather = 1, None = 0}
_enum("BuildEditIllegalType", BuildEditIllegalType)
local BuildObstacleType = {Treasures = 1, ParentBuildingObstacles = 2}
_enum("BuildObstacleType", BuildObstacleType)
