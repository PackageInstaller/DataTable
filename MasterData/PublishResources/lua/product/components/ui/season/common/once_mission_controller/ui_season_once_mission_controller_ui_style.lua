_class("UISeasonOnceMissionControllerUIStyle", Object)
UISeasonOnceMissionControllerUIStyle = UISeasonOnceMissionControllerUIStyle

function UISeasonOnceMissionControllerUIStyle:Constructor()
  self._cfgs = {
    [1] = {
      controllerBg = "ycxxxg_bg_01",
      pointBg = "ycxxxg_di01",
      pointStarLight = "ycxxxg_di01_02",
      pointStarGray = "ycxxxg_di01_03",
      pointFinishBg = "ycxxg_di01_05",
      pointFinishEffBg = "ycxxg_di01_06",
      idle_animation = "brown_idle",
      in_animation = "brown_in",
      controller_out_animation = "out3"
    },
    [2] = {
      controllerBg = "ycxxxg_bg_02",
      pointBg = "ycxxxg_di02",
      pointStarLight = "ycxxxg_di02_02",
      pointStarGray = "ycxxxg_di02_03",
      pointFinishBg = "ycxxg_di01_05",
      pointFinishEffBg = "ycxxg_di01_06",
      idle_animation = "brown_idle",
      in_animation = "brown_in",
      controller_out_animation = "out3"
    },
    [3] = {
      controllerBg = "ycxxxg_bg_03",
      pointBg = "ycxxxg_di03",
      pointStarLight = "ycxxxg_di03_02",
      pointStarGray = "ycxxxg_di03_03",
      pointFinishBg = "ycxxg_di03_05",
      pointFinishEffBg = "ycxxg_di03_06",
      idle_animation = "red_idle",
      in_animation = "red_in",
      controller_out_animation = "out1"
    }
  }
end

function UISeasonOnceMissionControllerUIStyle:GetSyle(index)
  return self._cfgs[index]
end
