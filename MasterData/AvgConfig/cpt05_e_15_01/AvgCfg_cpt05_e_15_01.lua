local AvgCfg_cpt05_e_15_01 = {
  [1] = {
    bgColor = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg002_2",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      },
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "simo_avg",
        rot = {
          0,
          180,
          0
        }
      },
      {
        imgId = 105,
        imgType = 3,
        alpha = 0,
        imgPath = "croque_avg",
        rot = {
          0,
          180,
          0
        }
      },
      {
        imgId = 108,
        imgType = 3,
        alpha = 0,
        imgPath = "gin_avg"
      },
      {
        imgId = 117,
        imgType = 3,
        alpha = 0,
        imgPath = "angela_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 33,
        imgType = 3,
        alpha = 0,
        imgPath = "odette_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 35,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 35,
        delay = 1,
        alpha = 1,
        duration = 0.2
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [2] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [3] = {
    imgTween = {
      {imgId = 103, posId = 1},
      {
        imgId = 103,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 105, isDark = true}
    },
    heroFace = {
      {imgId = 103, faceId = 5}
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [4] = {
    imgTween = {
      {
        imgId = 103,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 105,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 35, posId = 3}
    },
    content = 40,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [5] = {
    imgTween = {
      {imgId = 117, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [6] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 117, alpha = 0}
    },
    content = 60,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [7] = {
    imgTween = {
      {imgId = 117, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 70,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [11] = {
    imgTween = {
      {imgId = 33, posId = 3},
      {imgId = 117, alpha = 0}
    },
    content = 110,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 2
  },
  [12] = {
    imgTween = {
      {imgId = 117, posId = 3},
      {imgId = 33, alpha = 0}
    },
    content = 120,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [13] = {
    audio = {
      bgm = {stop = true}
    },
    content = 130,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [14] = {
    imgTween = {
      {imgId = 117, alpha = 0},
      {
        imgId = 1,
        duration = 1,
        alpha = 0
      }
    },
    content = 140,
    contentType = 4,
    speakerName = 141
  },
  [15] = {content = 150, contentType = 2},
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 161
  },
  [17] = {content = 170, contentType = 2},
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 181
  },
  [19] = {content = 190, contentType = 2},
  [20] = {
    imgTween = {
      {
        imgId = 35,
        delay = 1,
        duration = 0,
        alpha = 1
      },
      {
        imgId = 1,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    content = 200,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [24] = {
    images = {
      {imgId = 117, delete = true},
      {
        imgId = 34,
        imgType = 3,
        alpha = 0,
        imgPath = "odile_b_avg"
      }
    },
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 34, posId = 3}
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 34, faceId = 3}
    },
    content = 240,
    contentType = 3,
    speakerHeroId = 34,
    speakerHeroPosId = 2
  },
  [25] = {
    imgTween = {
      {imgId = 34, alpha = 0},
      {imgId = 33, posId = 3}
    },
    content = 250,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 2
  },
  [26] = {
    images = {
      {imgId = 34, delete = true},
      {
        imgId = 117,
        imgType = 3,
        alpha = 0,
        imgPath = "angela_avg"
      }
    },
    imgTween = {
      {imgId = 33, alpha = 0},
      {imgId = 108, posId = 1},
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    content = 260,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [27] = {
    imgTween = {
      {imgId = 33, posId = 5},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 108, isDark = true}
    },
    content = 270,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [28] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 33, isDark = true},
      {
        imgId = 108,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    audio = {
      sfx = {
        cue = "Skill_Persicaria_Ex_Start",
        sheet = "Chara_Persicaria"
      }
    },
    content = 280,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [30] = {
    imgTween = {
      {
        imgId = 101,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 35, posId = 3}
    },
    content = 300,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [32] = {
    imgTween = {
      {imgId = 117, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 320,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2
  },
  [33] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 117, alpha = 0}
    },
    content = 330,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [34] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 102, posId = 1},
      {
        imgId = 102,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 102, faceId = 6}
    },
    content = 340,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [35] = {
    imgTween = {
      {imgId = 33, posId = 5},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 102, isDark = true}
    },
    content = 350,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [36] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 33, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 2}
    },
    content = 360,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [38] = {
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    imgTween = {
      {imgId = 35, posId = 3},
      {
        imgId = 102,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 380,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    branch = {
      {content = 401, jumpAct = 41},
      {content = 402, jumpAct = 47}
    }
  },
  [41] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {
        imgId = 102,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    content = 410,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [42] = {
    imgTween = {
      {imgId = 117, posId = 5},
      {
        imgId = 117,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 102, isDark = true}
    },
    content = 420,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [43] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 430,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [45] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 102, isDark = true}
    },
    content = 450,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [46] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 117, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 460,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1,
    nextId = 51
  },
  [47] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {
        imgId = 102,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 470,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [50] = {
    imgTween = {
      {imgId = 117, posId = 5},
      {
        imgId = 117,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 102, isDark = true}
    },
    content = 500,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [51] = {
    heroFace = {
      {imgId = 102, faceId = 6}
    },
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 510,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [56] = {
    imgTween = {
      {imgId = 33, posId = 5},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 117,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 102, isDark = true}
    },
    content = 560,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [59] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 33, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 590,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [60] = {
    imgTween = {
      {imgId = 33, isDark = false},
      {imgId = 102, isDark = true}
    },
    content = 600,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [61] = {
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    imgTween = {
      {
        imgId = 102,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 35, posId = 3}
    },
    content = 610,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [62] = {
    imgTween = {
      {imgId = 103, posId = 1},
      {
        imgId = 103,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 35, alpha = 0}
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    },
    content = 620,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [63] = {
    imgTween = {
      {imgId = 104, posId = 5},
      {
        imgId = 104,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 103, isDark = true}
    },
    content = 630,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 3
  },
  [64] = {
    imgTween = {
      {imgId = 105, posId = 1},
      {
        imgId = 105,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 104, isDark = true},
      {
        imgId = 103,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      }
    },
    content = 640,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 1
  },
  [65] = {
    imgTween = {
      {
        imgId = 105,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 104,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 35,
        posId = 3,
        duration = 0.2,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    },
    content = 650,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [66] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 105, posId = 3}
    },
    content = 660,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [67] = {
    imgTween = {
      {imgId = 105, alpha = 0},
      {
        imgId = 1,
        duration = 0.5,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Corque_Ex_End",
        sheet = "Chara_Croque"
      }
    },
    content = 670,
    contentType = 2
  },
  [68] = {
    imgTween = {
      {imgId = 105, posId = 3}
    },
    content = 680,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [69] = {
    heroFace = {
      {imgId = 105, faceId = 6}
    },
    content = 690,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [70] = {
    heroFace = {
      {imgId = 105, faceId = 0},
      {imgId = 104, faceId = 4}
    },
    imgTween = {
      {imgId = 105, alpha = 0},
      {imgId = 104, posId = 3}
    },
    content = 700,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2
  },
  [71] = {
    imgTween = {
      {imgId = 104, alpha = 0}
    },
    content = 710,
    contentType = 2
  },
  [72] = {
    imgTween = {
      {imgId = 103, posId = 1},
      {
        imgId = 103,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    content = 720,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [73] = {
    imgTween = {
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 103, isDark = true}
    },
    content = 730,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [74] = {
    imgTween = {
      {imgId = 104, posId = 1},
      {
        imgId = 104,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 105, isDark = true},
      {
        imgId = 103,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    content = 740,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 1
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 1
  },
  [76] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 104, isDark = true}
    },
    content = 760,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3,
    branch = {
      {content = 771, jumpAct = 78},
      {content = 772, jumpAct = 79}
    }
  },
  [78] = {
    imgTween = {
      {imgId = 104, isDark = false},
      {imgId = 105, isDark = true}
    },
    heroFace = {
      {imgId = 104, faceId = 1}
    },
    content = 780,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 1,
    nextId = 80
  },
  [79] = {
    heroFace = {
      {imgId = 105, faceId = 1},
      {imgId = 104, faceId = 0}
    },
    content = 790,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [80] = {
    heroFace = {
      {imgId = 105, faceId = 0}
    },
    imgTween = {
      {imgId = 104, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 800,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 1
  },
  [81] = {
    imgTween = {
      {
        imgId = 104,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 105,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, posId = 3}
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    },
    content = 810,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [82] = {
    imgTween = {
      {
        imgId = 101,
        posId = 2,
        isDark = true,
        duration = 0.5
      },
      {imgId = 33, posId = 5},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    audio = {
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    },
    content = 820,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [84] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 33, isDark = true}
    },
    content = 840,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [85] = {
    imgTween = {
      {imgId = 33, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 850,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [86] = {
    imgTween = {
      {imgId = 108, posId = 5},
      {
        imgId = 108,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 860,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [87] = {
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 108, isDark = true}
    },
    content = 870,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    branch = {
      {content = 871, jumpAct = 89},
      {content = 872, jumpAct = 88}
    }
  },
  [88] = {
    imgTween = {
      {imgId = 33, posId = 5},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 108,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    content = 880,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [89] = {
    imgTween = {
      {imgId = 33, isDark = true},
      {imgId = 101, isDark = true},
      {imgId = 108, isDark = true}
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    },
    content = 890,
    contentType = 4,
    speakerName = 11
  },
  [90] = {
    imgTween = {
      {
        imgId = 108,
        posId = 3,
        isDark = false
      },
      {imgId = 33, alpha = 0},
      {imgId = 101, alpha = 0}
    },
    content = 900,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2
  },
  [91] = {
    imgTween = {
      {imgId = 108, alpha = 0},
      {imgId = 117, posId = 5},
      {
        imgId = 117,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    content = 910,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [93] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    content = 930,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [95] = {
    imgTween = {
      {imgId = 102, posId = 5},
      {
        imgId = 102,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 117,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    content = 950,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [96] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 102, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    content = 960,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  }
}
return AvgCfg_cpt05_e_15_01
