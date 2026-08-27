local AvgCfg_24carnival_fern = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 1041,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg018",
        fullScreen = true
      },
      {
        imgId = 141,
        imgType = 3,
        alpha = 0,
        imgPath = "fern_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 141,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 141,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1041
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1041
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 141,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1041,
    imgTween = {
      {
        imgId = 141,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1041
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1041,
    contentShake = true
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1041
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1041
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1041
  }
}
return AvgCfg_24carnival_fern
