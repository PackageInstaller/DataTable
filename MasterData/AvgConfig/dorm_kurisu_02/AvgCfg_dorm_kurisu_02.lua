local AvgCfg_dorm_kurisu_02 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 2002,
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
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
      voice = {heroId = 1078, voiceId = 113}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 2002
  }
}
return AvgCfg_dorm_kurisu_02
