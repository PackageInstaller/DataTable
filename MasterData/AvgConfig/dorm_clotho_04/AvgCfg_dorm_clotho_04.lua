local AvgCfg_dorm_clotho_04 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 1067,
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "clotho_avg"
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
      voice = {heroId = 1059, voiceId = 115}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1067
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1067
  }
}
return AvgCfg_dorm_clotho_04
