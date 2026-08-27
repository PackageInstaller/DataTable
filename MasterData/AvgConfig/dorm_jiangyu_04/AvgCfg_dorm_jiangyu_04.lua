local AvgCfg_dorm_jiangyu_04 = {
  [1] = {
    content = 10,
    contentType = 2,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "jiangyu_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      voice = {heroId = 1062, voiceId = 115}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1072
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1072
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1072
  }
}
return AvgCfg_dorm_jiangyu_04
