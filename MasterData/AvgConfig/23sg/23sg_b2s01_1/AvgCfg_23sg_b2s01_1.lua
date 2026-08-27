local AvgCfg_23sg_b2s01_1 = {
  [1] = {
    contentStyle = 1,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg068",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg052",
        fullScreen = true
      },
      {
        imgId = 603,
        imgType = 3,
        alpha = 0,
        imgPath = "ruka_avg"
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tinnitus",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.8,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.6,
        duration = 1.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img14_Yanagibayashi",
        sheet = "Mus_SteinsGate_img14_Yanagibayashi",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11
  },
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 11
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        scale = {
          1.4,
          1.4,
          1.4
        }
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 603,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 603,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  }
}
return AvgCfg_23sg_b2s01_1
