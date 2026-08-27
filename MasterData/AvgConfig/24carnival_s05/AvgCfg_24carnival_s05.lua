local AvgCfg_24carnival_s05 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 5600107,
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg018",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      },
      {
        imgId = 200,
        imgType = 3,
        alpha = 0,
        imgPath = "knot_shadow_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
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
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = true
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
  [2] = {
    content = 20,
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
      {imgId = 101, faceId = 14}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1001
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 11}
    }
  },
  [6] = {
    content = 60,
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
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
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
      {imgId = 101, faceId = 1}
    }
  },
  [9] = {
    content = 90,
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
        alpha = 0
      }
    }
  },
  [10] = {autoContinue = true},
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1200,
    imgTween = {
      {
        imgId = 200,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 200,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    ppv = {
      cg = {saturation = -70}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1003,
    contentShake = true,
    imgTween = {
      {
        imgId = 200,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [13] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [14] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 140,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 101,
        delay = 1.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1001
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 8}
    }
  },
  [17] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
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
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1003,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg018",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg001",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        delete = true
      },
      {
        imgId = 200,
        imgType = 3,
        alpha = 0,
        imgPath = "knot_shadow_avg",
        delete = true
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 103,
        delay = 2,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
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
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 12,
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
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1003,
    contentShake = true,
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
      {imgId = 103, faceId = 16}
    }
  },
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 12,
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
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1003,
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
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1003
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1003,
    heroFace = {
      {imgId = 103, faceId = 1}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1003,
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 12,
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
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 12
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1003,
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
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1003,
    heroFace = {
      {imgId = 103, faceId = 16}
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 12,
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
  [32] = {
    content = 320,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [33] = {
    content = 330,
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
  [34] = {content = 340, contentType = 2},
  [35] = {content = 350, contentType = 2},
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
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
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1003,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 9}
    }
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 12,
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
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1003,
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
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1003,
    heroFace = {
      {imgId = 103, faceId = 10}
    }
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 12,
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
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1003,
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
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 12,
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
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 12
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 451,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
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
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Sector_5",
        sheet = "Mus_Sector_5",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 12
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
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
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 2
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 4,
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
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 2}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
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
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 12,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [63] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
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
  [64] = {
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1.6,
        scale = {
          1.5,
          1.5,
          1.5
        },
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dark",
        sheet = "Mus_Story_Dark",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 12}
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 4,
    speakerName = 12
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [72] = {
    bgColor = 3,
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.85
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [73] = {content = 730, contentType = 2},
  [74] = {
    content = 740,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 2,
        alpha = 0
      }
    }
  },
  [76] = {content = 760, contentType = 2},
  [77] = {
    content = 770,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        scale = {
          1,
          1,
          1
        },
        alpha = 0
      }
    }
  },
  [78] = {
    bgColor = 2,
    content = 780,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_tinnitus",
        sheet = "AVG_gf"
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 791,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 791,
    scrambleTypeWriter = true
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.85
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.15
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      },
      bgm = {
        stop = false,
        cue = "Mus_Story_Tiphares_Inner",
        sheet = "Mus_Story_Tiphares_Inner",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0.25,
        shake = true
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {content = 840, contentType = 2},
  [85] = {
    content = 850,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 2,
        alpha = 0.25,
        shake = true
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.4
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 999,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 0
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [89] = {
    bgColor = 3,
    content = 890,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Factory",
        sheet = "Mus_Factory",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [92] = {content = 920, contentType = 2},
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 12
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 12
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [96] = {
    content = 960,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 12
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 2
  },
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [105] = {
    content = 1050,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 2
  },
  [110] = {
    content = 1100,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1,
        scale = {
          1,
          1,
          1
        }
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 2,
    images = {
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt10/cpt10_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "cpt10/cpt10_e_bg002",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
        duration = 1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 3,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 3,
        duration = 0,
        alpha = 0
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [118] = {
    content = 1180,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 4,
    speakerName = 12
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [121] = {
    content = 1210,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 2
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [128] = {
    content = 1280,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 2,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_keyboardtype_sci",
        sheet = "AVG_gf"
      }
    }
  },
  [129] = {
    content = 1290,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [130] = {content = 1300, contentType = 2},
  [131] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [132] = {
    content = 1320,
    contentType = 2,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg003",
        fullScreen = true
      },
      {
        imgId = 7,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_cg003",
        fullScreen = true
      },
      {
        imgId = 8,
        imgType = 2,
        alpha = 0,
        order = 9,
        imgPath = "cpt10/cpt10_e_cg003_2",
        fullScreen = true
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
  [133] = {
    content = 1330,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 1.6,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 5,
        delay = 3.6,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    }
  },
  [134] = {
    bgColor = 2,
    content = 1340,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 1,
        alpha = 0
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [138] = {
    content = 1380,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [139] = {
    content = 1390,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
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
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [141] = {
    content = 1410,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 2
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [145] = {
    content = 1450,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [146] = {
    content = 1460,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [148] = {
    content = 1480,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 12}
    }
  },
  [150] = {
    content = 1500,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [152] = {
    content = 1520,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [153] = {
    content = 1530,
    contentType = 4,
    speakerName = 12
  },
  [154] = {
    content = 1540,
    contentType = 4,
    speakerName = 12
  },
  [155] = {
    content = 1550,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
    }
  },
  [156] = {content = 1560, contentType = 2},
  [157] = {content = 1570, contentType = 2},
  [158] = {content = 1580, contentType = 2},
  [159] = {content = 1590, contentType = 2},
  [160] = {
    content = 1600,
    contentType = 2,
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
  [161] = {
    content = 1610,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [162] = {
    content = 1620,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [163] = {
    content = 1630,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [164] = {
    content = 1640,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [165] = {content = 1650, contentType = 2},
  [166] = {
    content = 1660,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [167] = {content = 1670, contentType = 2},
  [168] = {
    content = 1680,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [169] = {
    content = 1690,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [170] = {
    content = 1700,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [171] = {content = 1710, contentType = 2},
  [172] = {content = 1720, contentType = 2},
  [173] = {
    content = 1730,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [174] = {
    content = 1740,
    contentType = 4,
    speakerName = 12
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [176] = {
    content = 1760,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
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
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [178] = {
    content = 1780,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [179] = {
    content = 1790,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [180] = {
    content = 1800,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [181] = {
    content = 1810,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [182] = {
    content = 1820,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [184] = {
    content = 1840,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [185] = {
    content = 1850,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [186] = {
    content = 1860,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [187] = {
    content = 1870,
    contentType = 3,
    speakerHeroId = 2
  },
  [188] = {
    content = 1880,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_OP",
        sheet = "Mus_OP",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [189] = {
    content = 1890,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 7,
        delay = 1,
        duration = 1,
        alpha = 1
      }
    }
  },
  [190] = {content = 1900, contentType = 2},
  [191] = {
    content = 1910,
    contentType = 4,
    speakerName = 12
  },
  [192] = {
    content = 1920,
    contentType = 4,
    speakerName = 11
  },
  [193] = {
    content = 1930,
    contentType = 4,
    speakerName = 11
  },
  [194] = {
    content = 1940,
    contentType = 2,
    imgTween = {
      {
        imgId = 8,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 7,
        delay = 1,
        duration = 0,
        alpha = 0
      }
    }
  },
  [195] = {
    content = 1950,
    contentType = 4,
    speakerName = 11
  },
  [196] = {
    content = 1960,
    contentType = 4,
    speakerName = 11
  },
  [197] = {content = 1970, contentType = 2},
  [198] = {content = 1980, contentType = 2},
  [199] = {
    content = 1990,
    contentType = 4,
    speakerName = 12
  },
  [200] = {
    bgColor = 3,
    autoContinue = true,
    imgTween = {
      {
        imgId = 8,
        delay = 0,
        duration = 2,
        alpha = 0
      }
    }
  },
  [201] = {
    content = 2010,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 6,
        delay = 2,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [202] = {
    bgColor = 2,
    content = 2020,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
    },
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [203] = {
    content = 2030,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 16}
    }
  },
  [204] = {
    content = 2040,
    contentType = 3,
    speakerHeroId = 2
  },
  [205] = {
    content = 2050,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [206] = {
    content = 2060,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [207] = {
    content = 2070,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
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
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [209] = {
    content = 2090,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 0,
        duration = 0.2,
        shake = true
      },
      {
        imgId = 6,
        delay = 0.5,
        duration = 0.2,
        shake = true
      }
    }
  },
  [210] = {
    content = 2100,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [211] = {
    content = 2110,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [212] = {
    content = 2120,
    contentType = 4,
    speakerName = 12
  },
  [213] = {
    content = 2130,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [214] = {
    content = 2140,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [215] = {
    content = 2150,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [216] = {
    content = 2160,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [217] = {
    content = 2170,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [218] = {
    content = 2180,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 2,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [219] = {content = 2190, contentType = 2},
  [220] = {
    content = 2200,
    contentType = 4,
    speakerName = 2201,
    images = {
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg001_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg002",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 7,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_cg003",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 8,
        imgType = 2,
        alpha = 0,
        order = 9,
        imgPath = "cpt10/cpt10_e_cg003_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 8,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_cg001_2",
        fullScreen = true
      },
      {
        imgId = 110,
        imgType = 3,
        alpha = 0,
        imgPath = "sangoma_avg"
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg003",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg009_2",
        fullScreen = true
      }
    }
  },
  [221] = {
    content = 2210,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Eosphorus",
        sheet = "Mus_EV3_Story_Eosphorus",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [222] = {
    content = 2220,
    contentType = 4,
    speakerName = 11
  },
  [223] = {
    content = 2230,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [224] = {
    content = 2240,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      }
    }
  },
  [225] = {
    content = 2250,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [226] = {
    content = 2260,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [227] = {
    content = 2270,
    contentType = 4,
    speakerName = 11
  },
  [228] = {
    content = 2280,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [229] = {
    content = 2290,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
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
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [231] = {
    content = 2310,
    contentType = 3,
    speakerHeroId = 1100
  },
  [232] = {
    content = 2320,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [233] = {
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 2331, jumpAct = 234},
      {content = 2332, jumpAct = 237}
    }
  },
  [234] = {
    content = 2340,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [235] = {content = 2350, contentType = 2},
  [236] = {
    content = 2360,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 110,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    nextId = 239
  },
  [237] = {
    content = 2370,
    contentType = 4,
    speakerName = 11
  },
  [238] = {
    content = 2380,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [239] = {
    content = 2390,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [240] = {
    content = 2400,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [241] = {
    content = 2410,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [242] = {
    content = 2420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [243] = {
    content = 2430,
    contentType = 4,
    speakerName = 11
  },
  [244] = {
    content = 2440,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [245] = {
    content = 2450,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [246] = {
    content = 2460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
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
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [248] = {
    content = 2480,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [249] = {content = 2490, contentType = 2},
  [250] = {
    content = 2500,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [251] = {
    content = 2510,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [252] = {
    content = 2520,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [253] = {
    content = 2530,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [254] = {
    content = 2540,
    contentType = 3,
    speakerHeroId = 1100
  },
  [255] = {
    content = 2550,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [256] = {
    content = 2560,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [257] = {
    content = 2570,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [258] = {
    content = 2580,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [259] = {
    content = 2590,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [260] = {
    content = 2600,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [261] = {
    content = 2610,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [262] = {
    content = 2620,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [263] = {
    content = 2630,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [264] = {
    content = 2640,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [265] = {
    content = 2650,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [266] = {
    content = 2660,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [267] = {
    content = 2670,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [268] = {
    content = 2680,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [269] = {
    content = 2690,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [270] = {
    content = 2700,
    contentType = 4,
    speakerName = 11
  },
  [271] = {
    content = 2710,
    contentType = 4,
    speakerName = 11
  },
  [272] = {
    content = 2720,
    contentType = 3,
    speakerHeroId = 1100,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 7}
    }
  },
  [273] = {
    content = 2730,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [274] = {
    content = 2740,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 11}
    }
  },
  [275] = {
    content = 2750,
    contentType = 3,
    speakerHeroId = 1100
  },
  [276] = {
    content = 2760,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [277] = {
    content = 2770,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [278] = {
    content = 2780,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0.3,
        duration = 0.6,
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
      {imgId = 110, faceId = 9}
    }
  },
  [279] = {
    content = 2790,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
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
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [281] = {
    content = 2810,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [282] = {
    content = 2820,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    }
  },
  [283] = {
    content = 2830,
    contentType = 2,
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [284] = {
    content = 2840,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 8,
        delay = 0,
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
  [285] = {
    content = 2850,
    contentType = 4,
    speakerName = 13
  },
  [286] = {
    content = 2860,
    contentType = 4,
    speakerName = 11
  },
  [287] = {
    content = 2870,
    contentType = 4,
    speakerName = 13
  },
  [288] = {
    content = 2880,
    contentType = 2,
    imgTween = {
      {
        imgId = 8,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [289] = {
    content = 2890,
    contentType = 4,
    speakerName = 11
  },
  [290] = {
    content = 2900,
    contentType = 4,
    speakerName = 11
  }
}
return AvgCfg_24carnival_s05
