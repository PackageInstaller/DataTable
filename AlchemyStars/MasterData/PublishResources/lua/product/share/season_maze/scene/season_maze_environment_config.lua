local SeasonMazeEnvironmentConfig = {
  [UISeasonID.S1] = {
    [1] = {
      value = "SeasonMazeSceneGiantLizard",
      param = nil
    },
    [2] = {
      value = "SeasonMazeSceneSmallLizard",
      param = {1}
    },
    [3] = {
      value = "SeasonMazeSceneSmallLizard",
      param = {2}
    }
  }
}
_enum("SeasonMazeEnvironmentConfig", SeasonMazeEnvironmentConfig)
