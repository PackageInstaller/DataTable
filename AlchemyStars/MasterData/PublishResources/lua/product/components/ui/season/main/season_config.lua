require("season_enum")
require("ui_season_id_enum")
local SeasonKey = {Mode = 1, Trigger = 2}
_enum("SeasonKey", SeasonKey)
local SeasonEnvironmentConfig = {
  [UISeasonID.S1] = {
    [1] = {
      value = "SeasonSceneGiantLizard",
      param = nil
    },
    [2] = {
      value = "SeasonSceneSmallLizard",
      param = {1}
    },
    [3] = {
      value = "SeasonSceneSmallLizard",
      param = {2}
    }
  }
}
_enum("SeasonEnvironmentConfig", SeasonEnvironmentConfig)
