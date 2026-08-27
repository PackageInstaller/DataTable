local AvgCfg_23sg_as004ri_7 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg003_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg001",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 4,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt05/cpt05_e_bg005",
        fullScreen = true
      },
      {
        imgId = 129,
        imgType = 3,
        alpha = 0,
        imgPath = "slime_avg"
      },
      {
        imgId = 16,
        imgType = 3,
        alpha = 0,
        imgPath = "faith2_avg"
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "summer/summer_e_bg010",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_9",
        fullScreen = true
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
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1.2,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dangerous",
        sheet = "Mus_Story_Dangerous",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 16,
    contentShake = true,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 16, faceId = 5}
    }
  },
  [6] = {
    content = 60,
    contentType = 2,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    contentShake = true
  },
  [8] = {content = 80, contentType = 2},
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 16,
    contentShake = true,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 16, faceId = 2}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [11] = {
    bgColor = 3,
    content = 110,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        shake = true,
        alpha = 0,
        shakeIntensity = 6
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {cue = "AVG_broken", sheet = "AVG"}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        shake = true,
        alpha = 1,
        shakeIntensity = 6
      }
    }
  },
  [13] = {
    bgColor = 2,
    content = 130,
    contentType = 3,
    speakerHeroId = 129,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 16,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 16,
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
        cue = "Mus_Story_DeusExMachina",
        sheet = "Mus_Story_DeusExMachina",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 16, faceId = 2}
    }
  },
  [15] = {
    content = 150,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
      },
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [16] = {content = 160, contentType = 2},
  [17] = {content = 170, contentType = 2},
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [20] = {
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_fs_avg",
        imgPathBoy = "prof_ms_avg"
      }
    },
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 999,
        delay = 2.2,
        duration = 0.6,
        alpha = 0,
        isDark = true
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 16,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 16, faceId = 4}
    }
  },
  [22] = {
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_fs_avg",
        imgPathBoy = "prof_ms_avg",
        delete = true
      }
    },
    autoContinue = true,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [23] = {
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg003_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 9,
        imgPath = "sg/sg_e_bg003",
        fullScreen = true
      }
    },
    content = 230,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.4,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11
  },
  [25] = {
    content = 250,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        sheet = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [26] = {content = 260, contentType = 2},
  [27] = {content = 270, contentType = 2},
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.5
      }
    }
  },
  [29] = {content = 290, contentType = 2},
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [31] = {content = 310, contentType = 2},
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0.7,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        isDark = false
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 0.5
      }
    }
  },
  [35] = {content = 350, contentType = 2},
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 11
  },
  [37] = {
    content = 370,
    contentType = 2,
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
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.75
      }
    }
  },
  [39] = {content = 390, contentType = 2},
  [40] = {
    content = 400,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11
  },
  [42] = {content = 420, contentType = 2},
  [43] = {
    content = 430,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.75,
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
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {content = 460, contentType = 2},
  [47] = {
    content = 470,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_footsteps_cave",
        sheet = "AVG_gf"
      }
    }
  },
  [48] = {content = 480, contentType = 2},
  [49] = {content = 490, contentType = 2},
  [50] = {content = 500, contentType = 2},
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = true
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 521,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img21_SERN",
        sheet = "Mus_SteinsGate_img21_SERN",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [53] = {content = 530, contentType = 2},
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 14
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 14
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 13
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 13
  },
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 14
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 13
  },
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 14
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 13
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 14
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 13
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 14
  },
  [65] = {
    content = 650,
    contentType = 4,
    speakerName = 13
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 14
  },
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 13
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 14
  },
  [69] = {
    content = 690,
    contentType = 4,
    speakerName = 13
  },
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 13
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 14
  },
  [72] = {content = 720, contentType = 2},
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 13
  },
  [74] = {
    content = 740,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_Crowd_Run",
        sheet = "AVG_gf"
      }
    }
  },
  [75] = {content = 750, contentType = 2},
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1001,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1.8,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 2.8,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        pos = {
          0,
          -750,
          0
        },
        scale = {
          1.5,
          1.5,
          1.5
        },
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 3.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img19_Explanation",
        sheet = "Mus_SteinsGate_img19_Explanation",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [77] = {
    content = 770,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.8,
        alpha = 1,
        isDark = true,
        pos = {
          0,
          -850,
          0
        },
        scale = {
          1.65,
          1.65,
          1.65
        }
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
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [80] = {
    content = 800,
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
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11
  },
  [82] = {
    content = 820,
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
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
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
      {imgId = 101, faceId = 13}
    }
  },
  [85] = {
    content = 850,
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
  [86] = {
    content = 860,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 129,
    contentShake = true,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [88] = {
    content = 880,
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
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 11
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img04_Theme_full",
        sheet = "Mus_SteinsGate_img04_Theme_full",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 3,
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 1.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        scale = {
          1,
          1,
          1
        },
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 11}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 8}
    }
  },
  [94] = {
    content = 940,
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
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 4,
    speakerName = 13
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 11
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 13
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 13
  }
}
return AvgCfg_23sg_as004ri_7
