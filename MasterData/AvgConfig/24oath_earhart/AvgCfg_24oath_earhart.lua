local AvgCfg_24oath_earhart = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt02/cpt02_e_bg004_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg001_4",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg007_1",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "oath/oath_earhart",
        pos = {
          -100,
          -200,
          0
        },
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 146,
        imgType = 3,
        alpha = 0,
        imgPath = "earhart_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
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
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 2}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1046
  },
  [9] = {
    content = 90,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 2}
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [17] = {content = 170, contentType = 2},
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
      },
      {
        imgId = 1,
        delay = 1,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Celebration",
        sheet = "Mus_EV3_Story_Celebration",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [21] = {autoContinue = true},
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 146,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 3}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [24] = {
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 241, jumpAct = 25},
      {content = 242, jumpAct = 26}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    },
    nextId = 27
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 11
  },
  [30] = {
    content = 300,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_slip_away",
        sheet = "AVG"
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 4}
    }
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 6}
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 4}
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 11
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1046
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 6}
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 4}
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 5}
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 146,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 6}
    }
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 4}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 4}
    }
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Justice",
        sheet = "Mus_EV3_Story_Justice",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      },
      {
        imgId = 2,
        delay = 1.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 2}
    }
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 13,
    contentShake = true
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 12
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 13
  },
  [65] = {
    content = 650,
    contentType = 4,
    speakerName = 11
  },
  [66] = {content = 660, contentType = 2},
  [67] = {
    content = 670,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [68] = {autoContinue = true},
  [69] = {content = 690, contentType = 1},
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    images = {
      {
        imgId = 146,
        imgType = 3,
        alpha = 0,
        imgPath = "earhart_avg",
        delete = true
      },
      {
        imgId = 146,
        imgType = 3,
        alpha = 0,
        imgPath = "earhart_oath_avg"
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [71] = {content = 710, contentType = 2},
  [72] = {content = 720, contentType = 2},
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 11
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11
  },
  [75] = {
    content = 750,
    contentType = 4,
    speakerName = 12
  },
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 12
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1,
        scale = {
          1.35,
          1.35,
          1.35
        },
        pos = {
          -100,
          -350,
          0
        },
        alpha = 1
      },
      {
        imgId = 10,
        delay = 2,
        duration = 2,
        scale = {
          1.35,
          1.35,
          1.35
        },
        pos = {
          -100,
          350,
          0
        },
        alpha = 1
      },
      {
        imgId = 10,
        delay = 4,
        duration = 1,
        scale = {
          1.2,
          1.2,
          1.2
        },
        pos = {
          -100,
          -200,
          0
        },
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_Whiteday",
        sheet = "Mus_EV_Whiteday",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    customCode = "AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource,'Selector_Mus_Home','SelectorLabel_OasisDay')"
  },
  [79] = {content = 790, contentType = 2},
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [81] = {
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 811, jumpAct = 82},
      {content = 812, jumpAct = 82}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 3}
    }
  },
  [89] = {
    content = 890,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 2}
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    },
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1046
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [95] = {
    content = 950,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1046
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1046
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [103] = {
    content = 1030,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [104] = {content = 1040, contentType = 2},
  [105] = {
    branch = {
      {content = 1051, jumpAct = 106}
    }
  },
  [106] = {
    content = 1060,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 3}
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
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
  [114] = {
    content = 1140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 146,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_slip_away",
        sheet = "AVG"
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1046,
    heroFace = {
      {imgId = 146, faceId = 0}
    }
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1046
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1046,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 146, faceId = 1}
    }
  },
  [122] = {
    content = 1220,
    contentType = 2,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [123] = {content = 1230, contentType = 2}
}
return AvgCfg_24oath_earhart
