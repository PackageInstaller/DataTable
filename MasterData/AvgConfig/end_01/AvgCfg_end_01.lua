local AvgCfg_end_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 29,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg007",
        fullScreen = true
      },
      {
        imgId = 29,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac2_avg"
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
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
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 1,
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
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 29
  },
  [3] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      },
      bgm = {stop = true}
    }
  },
  [4] = {
    content = 40,
    contentType = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    }
  },
  [5] = {autoContinue = true},
  [6] = {
    content = 60,
    contentType = 1,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true
      },
      {
        imgId = 96,
        imgType = 3,
        alpha = 0,
        imgPath = "eos2_avg"
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg"
      },
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        pos = {
          -500,
          -400,
          0
        }
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge_avg"
      },
      {
        imgId = 16,
        imgType = 3,
        alpha = 0,
        imgPath = "faith2_avg"
      },
      {
        imgId = 52,
        imgType = 3,
        alpha = 0,
        imgPath = "love_avg"
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 96,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 96,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = false
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
      {imgId = 96, faceId = 2}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 96,
    heroFace = {
      {imgId = 96, faceId = 1}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 96,
    heroFace = {
      {imgId = 96, faceId = 3}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 96,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 0}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 96,
    heroFace = {
      {imgId = 96, faceId = 1}
    }
  },
  [13] = {
    content = 130,
    contentType = 2,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [15] = {
    content = 150,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 30
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 30
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 30
  },
  [21] = {
    content = 210,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.3,
        shake = true
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [24] = {content = 240, contentType = 2},
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 30
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 30
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_General",
        sheet = "Mus_Boss_Purifier_General",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 80,
    speakerHeroPosId = 3,
    imgTween = {
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
        alpha = 1,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 21,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 5}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 341,
    contentShake = true,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 16,
        delay = 0,
        duration = 0,
        posId = 2,
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
      },
      {
        imgId = 52,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 351,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        shake = true
      },
      {
        imgId = 2,
        delay = 1.6,
        duration = 1,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [36] = {content = 360, contentType = 2},
  [37] = {
    content = 370,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 96,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.6,
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
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 96, faceId = 0}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 96
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 96,
    heroFace = {
      {imgId = 96, faceId = 2}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 96
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 96,
    heroFace = {
      {imgId = 96, faceId = 1}
    }
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 96,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 3}
    }
  },
  [45] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [47] = {autoContinue = true},
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 29,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 96,
        imgType = 3,
        alpha = 0,
        imgPath = "eos2_avg",
        delete = true
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg",
        delete = true
      },
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge_avg",
        delete = true
      },
      {
        imgId = 16,
        imgType = 3,
        alpha = 0,
        imgPath = "faith2_avg",
        delete = true
      },
      {
        imgId = 52,
        imgType = 3,
        alpha = 0,
        imgPath = "love_avg",
        delete = true
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
        imgId = 29,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 3}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 29
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 29
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 2}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [59] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 1,
    scrambleTypeWriter = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg005",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_bq_avg"
      },
      {
        imgId = 197,
        imgType = 3,
        alpha = 0,
        imgPath = "ptolomaea_slave_gold_avg"
      },
      {
        imgId = 2631,
        imgType = 3,
        alpha = 0,
        imgPath = "slime_avg"
      },
      {
        imgId = 2632,
        imgType = 3,
        alpha = 0,
        imgPath = "slime2_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [61] = {content = 610, contentType = 1},
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 29,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 29,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
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
    },
    heroFace = {
      {imgId = 29, faceId = 2}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 3}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [65] = {
    content = 650,
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
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 9}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 2}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 29,
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [70] = {
    content = 700,
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
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 29, faceId = 2}
    }
  },
  [76] = {
    content = 760,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 771,
    contentShake = true
  },
  [78] = {content = 780, contentType = 2},
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 29, faceId = 7}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
      {imgId = 101, faceId = 0}
    }
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 2631,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 2632,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 2,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 2631,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2631,
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
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 101, faceId = 1}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 29, faceId = 4}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
      {imgId = 101, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
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
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 6}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 2631,
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
        imgId = 2631,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 2632,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 2631,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 2632,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 2631,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 2631,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2632,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [99] = {content = 990, contentType = 2},
  [100] = {
    content = 1000,
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
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 29,
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
      {imgId = 101, faceId = 2}
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1001
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 6}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 29,
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
      {imgId = 101, faceId = 2}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1001
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 29,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 29,
    contentShake = true,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 29,
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
  [112] = {
    content = 1120,
    contentType = 4,
    speakerName = 771,
    contentShake = true,
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
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1971,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 197,
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
      {imgId = 101, faceId = 1}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 2}
    }
  },
  [117] = {
    autoContinue = true,
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
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [119] = {autoContinue = true},
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 29,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg005",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_bq_avg",
        delete = true
      },
      {
        imgId = 197,
        imgType = 3,
        alpha = 0,
        imgPath = "ptolomaea_slave_gold_avg",
        delete = true
      },
      {
        imgId = 2631,
        imgType = 3,
        alpha = 0,
        imgPath = "slime_avg",
        delete = true
      },
      {
        imgId = 2632,
        imgType = 3,
        alpha = 0,
        imgPath = "slime2_avg",
        delete = true
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
        imgId = 29,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 9}
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 4}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 29,
    contentShake = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 3}
    }
  },
  [126] = {
    content = 1260,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 29
  },
  [129] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 1,
    scrambleTypeWriter = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg022",
        fullScreen = true
      },
      {
        imgId = 105,
        imgType = 3,
        alpha = 0,
        imgPath = "croque_avg"
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "simo_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [131] = {autoContinue = true},
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 1321,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_AMB_Restaurant",
        sheet = "AVG_gf",
        audioId = 1
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 4,
    speakerName = 1331,
    contentShake = true
  },
  [134] = {
    content = 1340,
    contentType = 4,
    speakerName = 1341,
    contentShake = true
  },
  [135] = {
    content = 1350,
    contentType = 4,
    speakerName = 1351
  },
  [136] = {
    content = 1360,
    contentType = 4,
    speakerName = 1361
  },
  [137] = {content = 1370, contentType = 2},
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 1381
  },
  [139] = {
    content = 1390,
    contentType = 4,
    speakerName = 1391,
    contentShake = true
  },
  [140] = {
    content = 1400,
    contentType = 4,
    speakerName = 1401,
    contentShake = true
  },
  [141] = {
    content = 1410,
    contentType = 4,
    speakerName = 1411
  },
  [142] = {
    content = 1420,
    contentType = 4,
    speakerName = 1421,
    contentShake = true
  },
  [143] = {
    content = 1430,
    contentType = 4,
    speakerName = 1431,
    contentShake = true
  },
  [144] = {
    content = 1440,
    contentType = 4,
    speakerName = 1441,
    contentShake = true
  },
  [145] = {
    content = 1450,
    contentType = 4,
    speakerName = 1451
  },
  [146] = {content = 1460, contentType = 2},
  [147] = {
    content = 1470,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 1,
        duration = 0,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
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
        fadeIn = 6,
        fadeOut = 6
      },
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      },
      stopAudioId = {1}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 4}
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 2}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 3}
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 10}
    }
  },
  [152] = {
    content = 1520,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 102, faceId = 11}
    }
  },
  [153] = {
    content = 1530,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [154] = {
    content = 1540,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    },
    heroFace = {
      {imgId = 102, faceId = 12}
    }
  },
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 1}
    }
  },
  [156] = {
    content = 1560,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 12}
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [158] = {
    content = 1580,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [159] = {
    content = 1590,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 9}
    }
  },
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 4}
    }
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 9}
    }
  },
  [162] = {
    content = 1620,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 1,
    contentShake = true
  },
  [164] = {autoContinue = true},
  [165] = {
    content = 1650,
    contentType = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    }
  },
  [166] = {autoContinue = true},
  [167] = {
    content = 1670,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 29,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 2}
    }
  },
  [168] = {
    content = 1680,
    contentType = 3,
    speakerHeroId = 29,
    heroFace = {
      {imgId = 29, faceId = 8}
    }
  },
  [169] = {
    content = 1690,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 9}
    }
  },
  [170] = {
    content = 1700,
    contentType = 3,
    speakerHeroId = 29
  },
  [171] = {
    content = 1710,
    contentType = 3,
    speakerHeroId = 29,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 9}
    }
  },
  [172] = {
    content = 1720,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [173] = {
    content = 1730,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [174] = {content = 1740, contentType = 2},
  [175] = {
    content = 1750,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [176] = {autoContinue = true},
  [177] = {
    content = 1770,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [178] = {
    content = 1780,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [179] = {
    content = 1790,
    contentType = 1,
    scrambleTypeWriter = true,
    audio = {
      sfx = {cue = "AVG_typing", sheet = "AVG"}
    }
  },
  [180] = {
    content = 1800,
    contentType = 1,
    scrambleTypeWriter = true,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_OP",
        sheet = "Mus_OP",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [181] = {
    content = 1810,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [182] = {
    content = 1820,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 184
  },
  [183] = {
    content = 1830,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [184] = {
    content = 1840,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [185] = {
    content = 1850,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [186] = {
    content = 1860,
    contentType = 1,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.75
      }
    }
  },
  [187] = {
    content = 1870,
    contentType = 1,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 0.5
      }
    }
  },
  [188] = {
    content = 1880,
    contentType = 1,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [189] = {autoContinue = true},
  [190] = {
    autoContinue = true,
    images = {
      {
        imgId = 100,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/end",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 100,
        delay = 0,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 100,
        delay = 5,
        duration = 2,
        alpha = 0
      }
    }
  }
}
return AvgCfg_end_01
