local AvgCfg_cpt_hb_s11 = {
  [1] = {
    SkipScenario = 11,
    bgColor = 2,
    autoContinue = true,
    nextId = 201,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 6,
        fadeOut = 3
      }
    },
    storyAvgId = 1100111
  },
  [27] = {
    bgColor = 2,
    content = 270,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 514,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg",
        order = 3,
        delete = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg006",
        fullScreen = true
      },
      {
        imgId = 20,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg006_2",
        fullScreen = true,
        order = 5
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        order = 4
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish2_avg"
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge3_avg"
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg003_3",
        fullScreen = true
      },
      {
        imgId = 79,
        imgType = 3,
        alpha = 0,
        imgPath = "fakegod_avg"
      }
    },
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 3}
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 0}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 78, faceId = 4}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 5}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 78, faceId = 2}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 78, faceId = 4}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 0}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [41] = {
    bgColor = 3,
    content = 410,
    contentType = 4,
    speakerName = 411,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 2,
        posId = 3,
        alpha = 0,
        isDark = false,
        dissolve = true
      },
      {
        imgId = 80,
        delay = 0,
        duration = 2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 2,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 80,
        delay = 2,
        duration = 2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [42] = {
    bgColor = 2,
    autoContinue = true,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 1.5,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [43] = {
    content = 430,
    contentType = 1,
    images = {
      {
        imgId = 153,
        imgType = 3,
        alpha = 0,
        imgPath = "sueyoi_avg"
      },
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg"
      },
      {
        imgId = 74,
        imgType = 3,
        alpha = 0,
        imgPath = "elaugh_avg"
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        delete = true
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish2_avg",
        delete = true
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge3_avg",
        delete = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_DeusExMachina",
        sheet = "Mus_Story_DeusExMachina",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 461,
    contentShake = true
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 2,
        duration = 1.5,
        scale = {
          1.5,
          1.5,
          1.5
        },
        pos = {
          0,
          200,
          0
        },
        alpha = 1
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 0}
    }
  },
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 1,
        duration = 1,
        alpha = 1
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0.2,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 74, faceId = 5}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 0}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 153, faceId = 3}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 3}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0.2,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 74,
        delay = 0.4,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Depressed",
        sheet = "Mus_Story_Depressed",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 79, faceId = 3}
    }
  },
  [74] = {content = 740, contentType = 2},
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 2,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 2,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 3}
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 74, faceId = 1}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 74,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        shake = true,
        shakeIntensity = 4
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dangerous",
        sheet = "Mus_Story_Dangerous",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [89] = {content = 890, contentType = 2},
  [90] = {
    content = 900,
    contentType = 4,
    speakerName = 181,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 4,
    speakerName = 921,
    contentShake = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg006",
        fullScreen = true,
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 2,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 2,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 0}
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 2}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 1}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [107] = {
    content = 1070,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 3}
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [115] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [116] = {content = 1160, contentType = 1},
  [117] = {
    content = 1170,
    contentType = 2,
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 2,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 2}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 181,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [128] = {content = 1280, contentType = 2},
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [140] = {
    content = 1400,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [145] = {
    content = 1450,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    },
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    }
  },
  [146] = {content = 1460, contentType = 2},
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 0}
    },
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      }
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 1
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 153, faceId = 2}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    },
    contentShake = true
  },
  [152] = {
    content = 1520,
    contentType = 2,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        shake = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [153] = {
    content = 1530,
    contentType = 2,
    images = {
      {
        imgId = 79,
        imgType = 3,
        alpha = 0,
        imgPath = "fakegod_avg"
      }
    },
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 79, faceId = 3}
    }
  },
  [154] = {
    content = 1540,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [156] = {
    content = 1560,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      },
      {
        imgId = 74,
        imgType = 3,
        alpha = 0,
        imgPath = "elaugh_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2
  },
  [159] = {
    content = 1590,
    contentType = 2,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      }
    }
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2
  },
  [162] = {
    content = 1620,
    contentType = 2,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    }
  },
  [163] = {content = 1630, contentType = 2},
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      }
    }
  },
  [165] = {
    content = 1650,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2
  },
  [166] = {
    content = 1660,
    contentType = 2,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 79,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [167] = {
    content = 1670,
    contentType = 3,
    speakerHeroId = 14,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 79,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 114,
        delay = 2,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        comm = true
      }
    }
  },
  [168] = {
    content = 1680,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    contentShake = true,
    images = {
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "asagent_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [169] = {
    content = 1690,
    contentType = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [170] = {
    content = 1700,
    contentType = 2,
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [171] = {
    content = 1710,
    contentType = 2,
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [172] = {
    content = 1720,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [173] = {
    content = 1730,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 0}
    }
  },
  [174] = {
    content = 1740,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1
  },
  [176] = {
    content = 1760,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [177] = {
    content = 1770,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [178] = {
    content = 1780,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [179] = {
    content = 1790,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [180] = {
    content = 1800,
    contentType = 2,
    imgTween = {
      {
        imgId = 20,
        delay = 0,
        duration = 1.5,
        scale = {
          1.5,
          1.5,
          1.5
        },
        pos = {
          0,
          150,
          0
        },
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Delacey_01",
        sheet = "Chara_Delascey"
      }
    }
  },
  [181] = {autoContinue = true},
  [182] = {
    content = 1820,
    contentType = 2,
    images = {
      {
        imgId = 20,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg006_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 30,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg007",
        fullScreen = true,
        order = 6
      },
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 30,
        delay = 1,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dark",
        sheet = "Mus_Story_Dark",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 153, faceId = 44}
    }
  },
  [184] = {
    content = 1840,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [185] = {
    content = 1850,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 11}
    }
  },
  [186] = {
    content = 1860,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [187] = {
    content = 1870,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [188] = {content = 1880, contentType = 2},
  [189] = {
    content = 1890,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [190] = {
    content = 1900,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [191] = {
    content = 1910,
    contentType = 4,
    speakerName = 1911,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    isEnd = true
  },
  [201] = {
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        order = 4
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish2_avg",
        order = 3
      },
      {
        imgId = 514,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg",
        order = 3
      }
    },
    content = 2010,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        shake = true,
        shakeIntensity = 3
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [202] = {content = 2020, contentType = 2},
  [203] = {
    bgColor = 3,
    content = 2030,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 0.6
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 6}
    }
  },
  [204] = {
    content = 2040,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [205] = {
    content = 2050,
    contentType = 2,
    contentShake = true
  },
  [206] = {
    content = 2060,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 0
      }
    }
  },
  [207] = {
    content = 2070,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 1,
        duration = 1,
        alpha = 0.6
      }
    },
    heroFace = {
      {imgId = 77, faceId = 5}
    }
  },
  [208] = {
    content = 2080,
    contentType = 4,
    speakerName = 2081,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 3}
    }
  },
  [209] = {content = 2090, contentType = 2},
  [210] = {
    content = 2100,
    contentType = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 78,
        delay = 1.2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        duration = 1,
        alpha = 1
      }
    }
  },
  [211] = {
    content = 2110,
    contentType = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [212] = {
    content = 2120,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    }
  },
  [213] = {
    content = 2130,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 77, faceId = 5}
    },
    contentShake = true
  },
  [214] = {
    content = 2140,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [215] = {
    content = 2150,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 4}
    }
  },
  [216] = {
    content = 2160,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 6}
    }
  },
  [217] = {
    content = 2170,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 5}
    }
  },
  [218] = {
    content = 2180,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    }
  },
  [219] = {
    content = 2190,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2
  },
  [220] = {
    content = 2200,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    }
  },
  [221] = {
    content = 2210,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 4}
    }
  },
  [222] = {
    content = 2220,
    contentType = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [223] = {
    content = 2230,
    contentType = 4,
    speakerName = 2231,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [224] = {
    content = 2240,
    contentType = 4,
    speakerName = 2231,
    scrambleTypeWriter = true
  },
  [225] = {
    content = 2250,
    contentType = 4,
    speakerName = 2231,
    scrambleTypeWriter = true
  },
  [226] = {content = 2260, contentType = 2},
  [227] = {
    images = {
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg",
        comm = true
      }
    },
    content = 2270,
    contentType = 2,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [228] = {
    content = 2280,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [229] = {
    content = 2290,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 2
  },
  [230] = {
    content = 2300,
    contentType = 2,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [231] = {
    content = 2310,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [232] = {
    content = 2320,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 5}
    }
  },
  [233] = {
    content = 2330,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 77, faceId = 2}
    }
  },
  [234] = {
    content = 2340,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [235] = {
    content = 2350,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 6}
    }
  },
  [236] = {
    content = 2360,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 78, faceId = 3}
    },
    contentShake = true
  },
  [237] = {
    content = 2370,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [238] = {
    content = 2380,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [239] = {
    content = 2390,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [240] = {
    content = 2400,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 4}
    }
  },
  [241] = {
    content = 2410,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 5}
    }
  },
  [242] = {
    content = 2420,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 4}
    },
    nextId = 244
  },
  [244] = {
    content = 2440,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [245] = {
    content = 2450,
    contentType = 2,
    images = {
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [246] = {
    content = 2460,
    contentType = 4,
    speakerName = 2461,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 514,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 514,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [247] = {
    content = 2470,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 514,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [248] = {
    content = 2480,
    contentType = 4,
    speakerName = 2461,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 514,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [249] = {
    content = 2490,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 514,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [250] = {
    content = 2500,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 2
  },
  [251] = {
    content = 2510,
    contentType = 2,
    images = {
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg",
        delete = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [252] = {
    content = 2520,
    contentType = 2,
    nextId = 27
  }
}
return AvgCfg_cpt_hb_s11
