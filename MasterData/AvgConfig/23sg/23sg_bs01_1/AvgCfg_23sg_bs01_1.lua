local AvgCfg_23sg_bs01_1 = {
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
        imgPath = "sg/sg_e_bg001",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_cg002",
        fullScreen = true
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_Scene"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {content = 20, contentType = 2},
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
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0.5,
        duration = 1,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1.6,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 2.5,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    effect = {
      stopList = {"effect1"}
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    }
  },
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img17_Network battle",
        sheet = "Mus_SteinsGate_img17_Network battle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 13
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 12
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 13
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {content = 140, contentType = 2},
  [15] = {content = 150, contentType = 2},
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 12
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 13
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 12
  },
  [20] = {content = 200, contentType = 2},
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 12
  },
  [22] = {
    content = 220,
    contentType = 4,
    speakerName = 13
  },
  [23] = {
    bgColor = 3,
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 2,
        delay = 0.7,
        duration = 1,
        scale = {
          1.5,
          1.5,
          1.5
        },
        alpha = 0
      }
    }
  }
}
return AvgCfg_23sg_bs01_1
