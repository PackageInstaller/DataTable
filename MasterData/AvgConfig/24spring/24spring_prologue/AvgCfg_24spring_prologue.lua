local AvgCfg_24spring_prologue = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 5100101,
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 8,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg016_3",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg069_3",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_newyear_avg"
      },
      {
        imgId = 127,
        imgType = 3,
        alpha = 0,
        imgPath = "zion_newyear_avg"
      },
      {
        imgId = 179,
        imgType = 3,
        alpha = 0,
        imgPath = "xinghuan_newyear_avg"
      },
      {
        imgId = 176,
        imgType = 3,
        alpha = 0,
        imgPath = "erika_newyear_avg"
      },
      {
        imgId = 182,
        imgType = 3,
        alpha = 0,
        imgPath = "kimie_newyear_avg"
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
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
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
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11
  },
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
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {cue = "AVG_Reload", sheet = "AVG_gf"}
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 11
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [10] = {content = 100, contentType = 2},
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 12
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 12
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 12
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 12,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_slip_away",
        sheet = "AVG"
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_slip_away",
        sheet = "AVG"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 12
  },
  [21] = {
    content = 210,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_23Springfes",
        sheet = "Mus_EV_23Springfes",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 179, faceId = 4}
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 7}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1079
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 4}
    }
  },
  [29] = {
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 291, jumpAct = 30},
      {content = 292, jumpAct = 32}
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.2,
        shake = true
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 6}
    },
    nextId = 34
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        shake = true
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 6}
    }
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 0}
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1079
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1079
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 2}
    }
  },
  [44] = {
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 441, jumpAct = 45},
      {content = 442, jumpAct = 47}
    }
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 11
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 1}
    },
    nextId = 49
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 1}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1079,
    heroFace = {
      {imgId = 179, faceId = 2}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1079,
    heroFace = {
      {imgId = 179, faceId = 7}
    }
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 1}
    }
  },
  [55] = {
    content = 550,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
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
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Door_Hit",
        sheet = "AVG_gf"
      }
    }
  },
  [56] = {content = 560, contentType = 2},
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 571,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
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
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 179, faceId = 5}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [59] = {
    content = 590,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 7}
    }
  },
  [62] = {
    content = 620,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [64] = {
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 179, faceId = 0}
    }
  },
  [67] = {
    content = 670,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 7}
    }
  },
  [70] = {
    content = 700,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.2
      }
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 8}
    },
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 0.2
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Sector_Material",
        sheet = "Mus_Sector_Material",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Broken_Glass",
        sheet = "AVG_gf"
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 13
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 13
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    },
    audio = {
      sfx = {
        cue = "AVG_jump_fall",
        sheet = "AVG"
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1084,
    contentShake = true,
    images = {
      {
        imgId = 184,
        imgType = 3,
        alpha = 0,
        imgPath = "bonneville_avg"
      }
    },
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1076,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 831,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 1076,
    images = {
      {
        imgId = 184,
        imgType = 3,
        alpha = 0,
        imgPath = "bonneville_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 176,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1076
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
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
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [90] = {content = 900, contentType = 2},
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [93] = {
    content = 930,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 11
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [102] = {
    content = 1020,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Fb_NextFloor",
        sheet = "UI"
      }
    }
  },
  [103] = {content = 1030, contentType = 2},
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    images = {
      {
        imgId = 179,
        imgType = 3,
        alpha = 0,
        imgPath = "xinghuan_newyear_avg",
        delete = true
      },
      {
        imgId = 179,
        imgType = 3,
        alpha = 0,
        imgPath = "xinghuan_mech_avg"
      }
    },
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          500,
          0
        }
      },
      {
        imgId = 179,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 179,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Fb_NextFloor",
        sheet = "UI"
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [109] = {
    content = 1090,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.2,
        shake = true
      }
    }
  },
  [110] = {
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1101, jumpAct = 111},
      {content = 1102, jumpAct = 111}
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_cannonbombing",
        sheet = "AVG"
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      },
      {
        imgId = 3,
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1076,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [115] = {
    content = 1150,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 11
  },
  [117] = {
    content = 1170,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [118] = {
    content = 1180,
    contentType = 4,
    speakerName = 11
  },
  [119] = {
    content = 1190,
    contentType = 4,
    speakerName = 11
  },
  [120] = {
    content = 1200,
    contentType = 2,
    images = {
      {
        imgId = 179,
        imgType = 3,
        alpha = 0,
        imgPath = "xinghuan_newyear_avg"
      },
      {
        imgId = 179,
        imgType = 3,
        alpha = 0,
        imgPath = "xinghuan_mech_avg",
        delete = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 4,
    speakerName = 11
  },
  [122] = {
    content = 1220,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_23Springfes",
        sheet = "Mus_EV_23Springfes",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [123] = {
    content = 1230,
    contentType = 4,
    speakerName = 11
  },
  [124] = {
    content = 1240,
    contentType = 4,
    speakerName = 11
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 72,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 1}
    }
  },
  [126] = {
    content = 1260,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [127] = {
    content = 1270,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 72,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 3}
    }
  },
  [131] = {
    content = 1310,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 2}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 1027,
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [135] = {
    content = 1350,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 4,
    speakerName = 11
  },
  [137] = {
    content = 1370,
    contentType = 4,
    speakerName = 11
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 3}
    }
  },
  [139] = {
    content = 1390,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 1027
  },
  [142] = {
    content = 1420,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 4,
    speakerName = 11
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [145] = {
    content = 1450,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [146] = {
    content = 1460,
    contentType = 4,
    speakerName = 11
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 2}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [149] = {
    content = 1490,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [151] = {
    content = 1510,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [152] = {
    content = 1520,
    contentType = 4,
    speakerName = 11
  },
  [153] = {
    content = 1530,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [154] = {
    content = 1540,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 4}
    }
  },
  [156] = {
    content = 1560,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [158] = {
    content = 1580,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [159] = {
    content = 1590,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 0}
    }
  },
  [160] = {
    content = 1600,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [161] = {
    content = 1610,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [162] = {
    content = 1620,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 3}
    }
  },
  [165] = {
    content = 1650,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [166] = {
    content = 1660,
    contentType = 4,
    speakerName = 11
  },
  [167] = {
    content = 1670,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 0}
    }
  },
  [168] = {
    content = 1680,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [169] = {
    content = 1690,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [170] = {
    content = 1700,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [171] = {
    content = 1710,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [172] = {
    content = 1720,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 2}
    }
  },
  [173] = {
    content = 1730,
    contentType = 3,
    speakerHeroId = 1027,
    heroFace = {
      {imgId = 127, faceId = 2}
    }
  },
  [174] = {
    content = 1740,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 1027,
    contentShake = true,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 5}
    }
  },
  [176] = {
    content = 1760,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [177] = {
    content = 1770,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg016_3",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg068",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg058",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
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
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [178] = {
    content = 1780,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 127, faceId = 3}
    }
  },
  [179] = {
    content = 1790,
    contentType = 3,
    speakerHeroId = 1027,
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg069_3",
        fullScreen = true,
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 0}
    }
  },
  [180] = {
    content = 1800,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [181] = {content = 1810, contentType = 2},
  [182] = {
    content = 1820,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [183] = {
    content = 1830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [184] = {content = 1840, contentType = 2},
  [185] = {
    content = 1850,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [186] = {
    content = 1860,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 6}
    }
  },
  [187] = {
    content = 1870,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [188] = {
    content = 1880,
    contentType = 4,
    speakerName = 11
  },
  [189] = {
    content = 1890,
    contentType = 3,
    speakerHeroId = 1082,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [190] = {
    content = 1900,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [191] = {
    content = 1910,
    contentType = 2,
    contentShake = true
  },
  [192] = {content = 1920, contentType = 2},
  [193] = {
    content = 1930,
    contentType = 4,
    speakerName = 11
  },
  [194] = {
    content = 1940,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [195] = {
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1951, jumpAct = 196},
      {content = 1952, jumpAct = 197}
    }
  },
  [196] = {
    content = 1960,
    contentType = 4,
    speakerName = 11,
    nextId = 198
  },
  [197] = {
    content = 1970,
    contentType = 4,
    speakerName = 11
  },
  [198] = {
    content = 1980,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [199] = {
    content = 1990,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [200] = {
    content = 2000,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [201] = {
    content = 2010,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [202] = {
    content = 2020,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [203] = {
    content = 2030,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [204] = {
    content = 2040,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [205] = {
    content = 2050,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [206] = {
    content = 2060,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [207] = {
    content = 2070,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [208] = {
    content = 2080,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [209] = {
    content = 2090,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [210] = {
    content = 2100,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [211] = {
    content = 2110,
    contentType = 4,
    speakerName = 11
  },
  [212] = {
    content = 2120,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [213] = {
    content = 2130,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Door_Hit",
        sheet = "AVG_gf"
      }
    }
  },
  [214] = {content = 2140, contentType = 2},
  [215] = {
    content = 2150,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Sector_Material",
        sheet = "Mus_Sector_Material",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [216] = {
    content = 2160,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [217] = {
    content = 2170,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [218] = {
    content = 2180,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 7}
    }
  },
  [219] = {
    content = 2190,
    contentType = 2,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [220] = {
    content = 2200,
    contentType = 4,
    speakerName = 11
  },
  [221] = {content = 2210, contentType = 2},
  [222] = {
    content = 2220,
    contentType = 4,
    speakerName = 11
  },
  [223] = {
    content = 2230,
    contentType = 4,
    speakerName = 11
  },
  [224] = {
    content = 2240,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0.5,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    }
  },
  [225] = {
    content = 2250,
    contentType = 3,
    speakerHeroId = 1076,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 4}
    }
  },
  [226] = {
    content = 2260,
    contentType = 3,
    speakerHeroId = 1082,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [227] = {
    content = 2270,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    }
  },
  [228] = {
    content = 2280,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [229] = {
    content = 2290,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [230] = {
    content = 2300,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [231] = {
    content = 2310,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [232] = {
    content = 2320,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 6}
    }
  },
  [233] = {
    content = 2330,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [234] = {
    content = 2340,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [235] = {
    content = 2350,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 6}
    }
  },
  [236] = {
    content = 2360,
    contentType = 4,
    speakerName = 2361,
    contentShake = true
  },
  [237] = {
    content = 2370,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false,
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [238] = {
    content = 2380,
    contentType = 4,
    speakerName = 11
  },
  [239] = {
    content = 2390,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
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
  [240] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [241] = {
    content = 2410,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 0
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    }
  },
  [242] = {
    content = 2420,
    contentType = 4,
    speakerName = 11
  },
  [243] = {
    content = 2430,
    contentType = 4,
    speakerName = 2431
  },
  [244] = {
    content = 2440,
    contentType = 4,
    speakerName = 11
  },
  [245] = {
    content = 2450,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      }
    }
  },
  [246] = {
    content = 2460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [247] = {
    content = 2470,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [248] = {
    content = 2480,
    contentType = 3,
    speakerHeroId = 1001
  },
  [249] = {
    content = 2490,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [250] = {
    content = 2500,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [251] = {
    content = 2510,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [252] = {
    content = 2520,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [253] = {
    content = 2530,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [254] = {
    content = 2540,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [255] = {
    content = 2550,
    contentType = 3,
    speakerHeroId = 1001
  },
  [256] = {
    content = 2560,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 3}
    }
  },
  [257] = {
    content = 2570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [258] = {
    content = 2580,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 1.6,
        alpha = 1,
        isDark = true,
        pos = {
          0,
          -600,
          0
        },
        scale = {
          1.4,
          1.4,
          1.4
        }
      }
    }
  },
  [259] = {
    content = 2590,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [260] = {
    content = 2600,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 3}
    }
  },
  [261] = {
    content = 2610,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [262] = {
    content = 2620,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [263] = {
    content = 2630,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 3}
    }
  },
  [264] = {
    content = 2640,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [265] = {content = 2650, contentType = 2},
  [266] = {
    content = 2660,
    contentType = 3,
    speakerHeroId = 1001
  },
  [267] = {
    content = 2670,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0.2,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0.5,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "Atk_Willow_01",
        sheet = "Chara_Willow"
      }
    }
  },
  [268] = {content = 2680, contentType = 2},
  [269] = {
    content = 2690,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [270] = {
    content = 2700,
    contentType = 3,
    speakerHeroId = 1047,
    contentShake = true,
    images = {
      {
        imgId = 147,
        imgType = 3,
        alpha = 0,
        imgPath = "willow_avg"
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "meryl_avg"
      }
    },
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 1}
    }
  },
  [271] = {
    content = 2710,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
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
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [272] = {
    content = 2720,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [273] = {
    content = 2730,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 3}
    }
  },
  [274] = {
    content = 2740,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [275] = {
    content = 2750,
    contentType = 3,
    speakerHeroId = 1079,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 179, faceId = 5}
    }
  },
  [276] = {
    content = 2760,
    contentType = 3,
    speakerHeroId = 1076,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [277] = {
    content = 2770,
    contentType = 3,
    speakerHeroId = 1076,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [278] = {
    content = 2780,
    contentType = 3,
    speakerHeroId = 1027,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 6}
    }
  },
  [279] = {
    content = 2790,
    contentType = 2,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [280] = {
    content = 2800,
    contentType = 4,
    speakerName = 11
  },
  [281] = {
    content = 2810,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 0}
    }
  },
  [282] = {
    content = 2820,
    contentType = 3,
    speakerHeroId = 1079,
    contentShake = true,
    heroFace = {
      {imgId = 179, faceId = 2}
    }
  },
  [283] = {
    content = 2830,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 3}
    }
  },
  [284] = {
    content = 2840,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [285] = {
    content = 2850,
    contentType = 3,
    speakerHeroId = 1079,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 179, faceId = 5}
    }
  },
  [286] = {
    content = 2860,
    contentType = 3,
    speakerHeroId = 1079,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [287] = {
    content = 2870,
    contentType = 3,
    speakerHeroId = 1076,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [288] = {
    content = 2880,
    contentType = 3,
    speakerHeroId = 1027,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [289] = {
    content = 2890,
    contentType = 3,
    speakerHeroId = 1047,
    contentShake = true,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 5}
    }
  },
  [290] = {
    content = 2900,
    contentType = 2,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [291] = {
    content = 2910,
    contentType = 3,
    speakerHeroId = 103,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Sector_Burbank",
        sheet = "Mus_EV3_Sector_Burbank",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 103, faceId = 1}
    }
  },
  [292] = {
    content = 2920,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [293] = {
    content = 2930,
    contentType = 3,
    speakerHeroId = 103,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [294] = {
    content = 2940,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [295] = {
    content = 2950,
    contentType = 3,
    speakerHeroId = 103,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 1}
    }
  },
  [296] = {
    content = 2960,
    contentType = 3,
    speakerHeroId = 103
  },
  [297] = {
    content = 2970,
    contentType = 3,
    speakerHeroId = 1079,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 179, faceId = 0}
    }
  },
  [298] = {
    content = 2980,
    contentType = 3,
    speakerHeroId = 103,
    imgTween = {
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [299] = {
    content = 2990,
    contentType = 3,
    speakerHeroId = 103,
    heroFace = {
      {imgId = 103, faceId = 1}
    }
  },
  [300] = {
    content = 3000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [301] = {
    content = 3010,
    contentType = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [302] = {
    content = 3020,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [303] = {
    content = 3030,
    contentType = 3,
    speakerHeroId = 103,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [304] = {
    content = 3040,
    contentType = 3,
    speakerHeroId = 1079,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 179, faceId = 2}
    }
  },
  [305] = {
    content = 3050,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [306] = {
    content = 3060,
    contentType = 3,
    speakerHeroId = 1076,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 179,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [307] = {
    content = 3070,
    contentType = 3,
    speakerHeroId = 1027,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 127, faceId = 5}
    }
  },
  [308] = {
    content = 3080,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 1}
    }
  },
  [309] = {
    content = 3090,
    contentType = 3,
    speakerHeroId = 1001
  },
  [310] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  }
}
return AvgCfg_24spring_prologue
