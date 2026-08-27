local AvgCfg_22white_jessie = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg016_4",
        fullScreen = true
      },
      {
        imgId = 135,
        imgType = 3,
        alpha = 0,
        imgPath = "jessie_avg"
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "pola/p_jessie",
        scale = {
          1.6,
          1.6,
          1.6
        }
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg020_3",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg007_2",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg002",
        fullScreen = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 1,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [3] = {
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 31, jumpAct = 4},
      {content = 32, jumpAct = 5}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 1}
    },
    nextId = 6
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
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
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 91,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 91
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 91
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [15] = {
    content = 150,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 11
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 11
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
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
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
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
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 351,
    contentShake = true
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 351,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [40] = {
    content = 400,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [59] = {
    content = 590,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [62] = {
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 621, jumpAct = 63},
      {content = 622, jumpAct = 64}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    nextId = 65
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
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
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [66] = {
    content = 660,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Dorm",
        sheet = "Mus_Dorm",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [69] = {
    content = 690,
    contentType = 4,
    speakerName = 691,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [70] = {content = 700, contentType = 2},
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 691,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 761,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [77] = {content = 770, contentType = 2},
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [79] = {
    content = 790,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 691
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 691,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 691
  },
  [86] = {content = 860, contentType = 2},
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 691,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 4,
    speakerName = 691
  },
  [91] = {content = 910, contentType = 2},
  [92] = {
    content = 920,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 1,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 2}
    },
    contentShake = true
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [101] = {
    content = 1010,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [102] = {content = 1020, contentType = 2},
  [103] = {
    content = 1030,
    contentType = 4,
    speakerName = 1031,
    contentShake = true
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 691
  },
  [105] = {
    content = 1050,
    contentType = 4,
    speakerName = 1051
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 1052
  },
  [107] = {content = 1070, contentType = 2},
  [108] = {content = 1080, contentType = 2},
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [113] = {
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1131, jumpAct = 114},
      {content = 1132, jumpAct = 115}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    },
    nextId = 116
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 2}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [118] = {
    content = 1180,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 0}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 135, faceId = 3}
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 135,
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
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1.5,
        scale = {
          1,
          1,
          1
        },
        alpha = 1
      },
      {
        imgId = 10,
        delay = 2.5,
        duration = 1.5,
        pos = {
          -50,
          -450,
          0
        },
        alpha = 1
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 4,
    speakerName = 12
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 12
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 12
  },
  [129] = {
    branch = {
      {content = 1291, jumpAct = 130},
      {content = 1292, jumpAct = 131}
    }
  },
  [130] = {
    content = 1300,
    contentType = 4,
    speakerName = 12,
    nextId = 132
  },
  [131] = {
    content = 1310,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 11
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 135,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 135,
        delay = 1.2,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 135, faceId = 1}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 1035,
    speakerHeroPosId = 2
  },
  [136] = {
    imgTween = {
      {
        imgId = 135,
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
      }
    },
    branch = {
      {content = 1361, jumpAct = 137}
    }
  },
  [137] = {autoContinue = true, isEnd = true}
}
return AvgCfg_22white_jessie
