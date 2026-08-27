local AvgCfg_24carnival_tony = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 1029,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg070",
        fullScreen = true
      },
      {
        imgId = 129,
        imgType = 3,
        alpha = 0,
        imgPath = "tony_avg"
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
        imgId = 129,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1029
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1029
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1029
  }
}
return AvgCfg_24carnival_tony
