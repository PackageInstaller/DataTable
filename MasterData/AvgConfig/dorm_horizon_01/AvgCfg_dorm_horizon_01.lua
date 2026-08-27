local AvgCfg_dorm_horizon_01 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 1073,
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "horizon_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      voice = {heroId = 1064, voiceId = 112}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1073
  }
}
return AvgCfg_dorm_horizon_01
