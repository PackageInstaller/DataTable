local AvgCfg_23winter_s20_1 = {
  [1] = {
    bgColor = 3,
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_12",
        fullScreen = true
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_s_hurt_avg"
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_wings_avg"
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 0.8,
        shake = true,
        isDark = false
      },
      {
        imgId = 103,
        delay = 1.5,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        shake = true,
        isDark = true
      },
      {
        imgId = 103,
        delay = 1.8,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        shake = true,
        isDark = false
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1003,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        shake = true,
        isDark = false
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_rifle_finalshot_h",
        sheet = "AVG_gf"
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1003,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1003,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 6}
    }
  },
  [9] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0.8,
        isDark = false,
        shake = true
      },
      {
        imgId = 103,
        delay = 0.3,
        duration = 0.4,
        scale = {
          1.25,
          1.25,
          1.25
        },
        alpha = 0.8,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0.8,
        duration = 0.2,
        alpha = 0.8,
        isDark = false,
        shake = true
      },
      {
        imgId = 103,
        delay = 1.1,
        duration = 1,
        scale = {
          1.45,
          1.45,
          1.45
        },
        alpha = 0.8,
        isDark = false
      },
      {
        imgId = 103,
        delay = 2.2,
        duration = 0.2,
        alpha = 0.8,
        isDark = false,
        shake = true
      },
      {
        imgId = 103,
        delay = 2.5,
        duration = 1,
        scale = {
          1.55,
          1.55,
          1.55
        },
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 2.5,
        duration = 1.5,
        alpha = 0
      }
    }
  }
}
return AvgCfg_23winter_s20_1
