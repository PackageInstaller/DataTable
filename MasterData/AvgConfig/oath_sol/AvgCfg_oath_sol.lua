local AvgCfg_oath_sol = {
  [1] = {
    bgColor = 3,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg067",
        fullScreen = true
      },
      {
        imgId = 100,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_Scene"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 3,
        duration = 2,
        scale = {
          1.4,
          1.4,
          1.4
        },
        pos = {
          0,
          200,
          0
        }
      },
      {
        imgId = 100,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 100,
        delay = 6,
        duration = 1,
        posId = 3,
        isDark = true,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Dorm",
        sheet = "Mus_Dorm",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1003,
    imgTween = {
      {
        imgId = 100,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      voice = {heroId = 1003, voiceId = 117}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1003
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1003
  },
  [6] = {
    content = 60,
    contentType = 2,
    imgTween = {
      {
        imgId = 100,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [7] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 0
      },
      {
        imgId = 100,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 0
      }
    }
  }
}
return AvgCfg_oath_sol
