local AvgCfg_cpt05_e_14_01 = {
  [1] = {
    bgColor = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg002",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
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
        imgPath = "wisdom_w_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 101,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 101,
        delay = 1,
        duration = 0.1,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
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
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [2] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {
        imgId = 35,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 35,
        duration = 0.1,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_weapon_reload",
        sheet = "AVG_gf"
      }
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [3] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {
        imgId = 103,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 103,
        duration = 0.1,
        alpha = 1
      },
      {imgId = 35, alpha = 0}
    },
    heroFace = {
      {imgId = 103, faceId = 6}
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2
  },
  [5] = {
    imgTween = {
      {imgId = 103, alpha = 0},
      {
        imgId = 35,
        duration = 0.2,
        alpha = 1
      }
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [6] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 35, alpha = 0}
    },
    content = 60,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [7] = {
    imgTween = {
      {imgId = 103, posId = 5},
      {
        imgId = 103,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    content = 70,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [8] = {
    heroFace = {
      {imgId = 103, faceId = 4}
    },
    content = 80,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [9] = {
    imgTween = {
      {imgId = 105, posId = 1},
      {
        imgId = 105,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 103, isDark = true},
      {
        imgId = 101,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    content = 90,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 1
  },
  [10] = {
    imgTween = {
      {imgId = 103, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 100,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [11] = {
    imgTween = {
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 103, isDark = true},
      {
        imgId = 105,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Croque_01",
        sheet = "Chara_Croque"
      }
    },
    content = 110,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [12] = {
    imgTween = {
      {imgId = 117, posId = 5},
      {
        imgId = 117,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true},
      {
        imgId = 103,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 120,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [14] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 117, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    },
    content = 140,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [15] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 150,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [16] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 160,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    branch = {
      {content = 161, jumpAct = 17},
      {content = 162, jumpAct = 19}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    nextId = 21
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [21] = {
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    content = 210,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [22] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 220,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [23] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 230,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [24] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 240,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [26] = {
    imgTween = {
      {imgId = 108, posId = 1},
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true},
      {
        imgId = 101,
        posId = 1,
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
      {imgId = 117, isDark = false},
      {imgId = 108, isDark = true}
    },
    content = 270,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [28] = {
    imgTween = {
      {imgId = 108, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 280,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1,
    branch = {
      {content = 301, jumpAct = 31},
      {content = 302, jumpAct = 32}
    }
  },
  [31] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true},
      {
        imgId = 108,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    content = 310,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    nextId = 34
  },
  [32] = {
    imgTween = {
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 101,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    content = 320,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [34] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 340,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [35] = {
    imgTween = {
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 101,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true}
    },
    content = 350,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [39] = {
    imgTween = {
      {
        imgId = 108,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 117,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    },
    content = 390,
    contentType = 4,
    speakerName = 14
  },
  [40] = {
    imgTween = {
      {imgId = 103, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 400,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [42] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 104, posId = 3}
    },
    audio = {
      sfx = {
        cue = "AVG_weapon_reload",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 104, faceId = 6}
    },
    content = 420,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [43] = {
    imgTween = {
      {imgId = 104, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 430,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [44] = {
    imgTween = {
      {imgId = 35, alpha = 0}
    },
    content = 440,
    contentType = 2
  },
  [45] = {
    imgTween = {
      {
        imgId = 1,
        duration = 0.5,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    },
    content = 450,
    contentType = 2
  },
  [46] = {
    imgTween = {
      {imgId = 104, posId = 3},
      {
        imgId = 1,
        duration = 0.5,
        shake = true
      }
    },
    heroFace = {
      {imgId = 104, faceId = 4}
    },
    content = 460,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2
  },
  [47] = {
    imgTween = {
      {imgId = 104, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 470,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [48] = {
    audio = {
      sfx = {
        cue = "AVG_rifle_finalshot_h",
        sheet = "AVG_gf"
      }
    },
    imgTween = {
      {imgId = 35, alpha = 0}
    },
    content = 480,
    contentType = 2
  },
  [49] = {content = 490, contentType = 2},
  [50] = {
    audio = {
      sfx = {
        cue = "AVG_Broken_Glass",
        sheet = "AVG_gf"
      }
    },
    imgTween = {
      {
        imgId = 1,
        duration = 0.5,
        shake = true
      }
    },
    content = 500,
    contentType = 2
  },
  [51] = {
    imgTween = {
      {imgId = 35, posId = 3}
    },
    content = 510,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [52] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 108, posId = 3}
    },
    audio = {
      sfx = {cue = "Atk_Gin_01", sheet = "Chara_Gin"}
    },
    content = 520,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2
  },
  [53] = {
    imgTween = {
      {imgId = 108, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 530,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [54] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 108, posId = 3}
    },
    content = 540,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2
  },
  [55] = {
    audio = {
      sfx = {cue = "Atk_Gin_02", sheet = "Chara_Gin"}
    },
    imgTween = {
      {imgId = 108, alpha = 0}
    },
    content = 550,
    contentType = 2
  },
  [56] = {
    imgTween = {
      {imgId = 35, posId = 3}
    },
    content = 560,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [57] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 108, posId = 3}
    },
    content = 570,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2
  },
  [59] = {
    imgTween = {
      {imgId = 108, alpha = 0},
      {imgId = 101, posId = 3}
    },
    audio = {
      sfx = {
        cue = "Skill_Persicaria_Ex_Start",
        sheet = "Chara_Persicaria"
      }
    },
    content = 590,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [60] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 35, posId = 3},
      {
        imgId = 35,
        duration = 0.2,
        shake = true
      }
    },
    content = 600,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [61] = {
    images = {
      {imgId = 108, delete = true},
      {imgId = 117, delete = true},
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg003",
        fullScreen = true
      }
    },
    imgTween = {
      {imgId = 35, alpha = 0},
      {
        imgId = 1,
        duration = 1.5,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    },
    autoContinue = true
  },
  [62] = {
    audio = {
      bgm = {
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    imgTween = {
      {
        imgId = 2,
        duration = 1.5,
        alpha = 1
      },
      {
        imgId = 101,
        delay = 1.5,
        duration = 0,
        alpha = 1
      }
    },
    ppv = {
      cg = {saturation = -100}
    },
    content = 620,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [63] = {
    audio = {
      sfx = {
        cue = "Atk_Persicaria_01_Hit",
        sheet = "Chara_Persicaria"
      }
    },
    imgTween = {
      {imgId = 35, alpha = 1},
      {
        imgId = 35,
        duration = 0.2,
        shake = true
      },
      {imgId = 101, alpha = 0}
    },
    content = 630,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [64] = {
    imgTween = {
      {imgId = 101, alpha = 1},
      {imgId = 35, alpha = 0}
    },
    content = 640,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [65] = {
    imgTween = {
      {imgId = 101, alpha = 0}
    },
    content = 650,
    contentType = 4,
    speakerName = 12
  },
  [66] = {
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg004",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        duration = 1.5,
        alpha = 0
      },
      {
        imgId = 3,
        duration = 1.5,
        delay = 1.5,
        alpha = 1
      }
    },
    autoContinue = true
  },
  [67] = {
    images = {
      {imgId = 2, delete = true}
    },
    imgTween = {
      {imgId = 105, posId = 3}
    },
    heroFace = {
      {imgId = 105, faceId = 6}
    },
    audio = {
      sfx = {
        cue = "Skill_Corque_Ex_End",
        sheet = "Chara_Croque"
      }
    },
    content = 670,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [68] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {
        imgId = 35,
        duration = 0.2,
        shake = true
      },
      {imgId = 105, alpha = 0}
    },
    heroFace = {
      {imgId = 105, faceId = 0}
    },
    content = 680,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [69] = {
    imgTween = {
      {imgId = 105, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 690,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [70] = {
    imgTween = {
      {imgId = 105, alpha = 0}
    },
    content = 700,
    contentType = 4,
    speakerName = 12
  },
  [71] = {
    images = {
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt01/cpt01_e_bg005",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 3,
        duration = 1.5,
        alpha = 0
      },
      {
        imgId = 4,
        duration = 1.5,
        delay = 1.5,
        alpha = 1
      }
    },
    autoContinue = true
  },
  [72] = {
    images = {
      {imgId = 3, delete = true}
    },
    imgTween = {
      {imgId = 35, posId = 3}
    },
    content = 720,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [73] = {
    imgTween = {
      {
        imgId = 104,
        posId = 3,
        alpha = 0.4
      },
      {imgId = 35, alpha = 0}
    },
    heroFace = {
      {imgId = 104, faceId = 1}
    },
    content = 730,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2
  },
  [74] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 104, alpha = 0}
    },
    content = 740,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [75] = {
    audio = {
      sfx = {
        cue = "Atk_Simo_01",
        sheet = "Chara_Simo"
      }
    },
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 104, alpha = 1}
    },
    heroFace = {
      {imgId = 104, faceId = 0}
    },
    content = 750,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2
  },
  [76] = {
    imgTween = {
      {imgId = 104, alpha = 0}
    },
    content = 760,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [77] = {
    images = {
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 4,
        duration = 1.5,
        alpha = 0
      },
      {
        imgId = 5,
        duration = 1.5,
        delay = 1.5,
        alpha = 1
      }
    },
    autoContinue = true
  },
  [78] = {
    images = {
      {imgId = 4, delete = true}
    },
    imgTween = {
      {imgId = 103, posId = 3}
    },
    heroFace = {
      {imgId = 103, faceId = 6}
    },
    content = 780,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [79] = {
    imgTween = {
      {
        imgId = 5,
        duration = 0.5,
        alpha = 0
      },
      {
        imgId = 5,
        duration = 0.5,
        delay = 0.5,
        alpha = 1
      },
      {imgId = 103, alpha = 0},
      {
        imgId = 104,
        duration = 0,
        delay = 1,
        posId = 3
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    },
    audio = {
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    },
    content = 790,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [80] = {
    imgTween = {
      {
        imgId = 5,
        duration = 0.5,
        alpha = 0
      },
      {
        imgId = 5,
        duration = 0.5,
        delay = 0.5,
        alpha = 1
      },
      {imgId = 104, alpha = 0},
      {
        imgId = 101,
        duration = 0,
        delay = 1,
        posId = 3
      }
    },
    content = 800,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    audio = {
      sfx = {
        cue = "Atk_Simo_01",
        sheet = "Chara_Simo"
      }
    }
  },
  [81] = {
    imgTween = {
      {
        imgId = 5,
        duration = 0.5,
        alpha = 0
      },
      {
        imgId = 5,
        duration = 0.5,
        delay = 0.5,
        alpha = 1
      },
      {imgId = 101, alpha = 0},
      {
        imgId = 105,
        duration = 0,
        delay = 1,
        posId = 3
      }
    },
    heroFace = {
      {imgId = 105, faceId = 5}
    },
    audio = {
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      }
    },
    content = 810,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [82] = {
    heroFace = {
      {imgId = 105, faceId = 0}
    },
    imgTween = {
      {
        imgId = 5,
        duration = 1,
        alpha = 0
      },
      {imgId = 105, alpha = 0}
    },
    audio = {
      bgm = {stop = true}
    },
    autoContinue = true
  },
  [83] = {content = 830, contentType = 2},
  [84] = {
    images = {
      {imgId = 5, delete = true},
      {imgId = 104, delete = true},
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
      }
    },
    imgTween = {
      {
        imgId = 1,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 2.1,
        duration = 0,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 2.2,
        duration = 1,
        shake = true
      }
    },
    ppv = {
      cg = {saturation = 0}
    },
    content = 840,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [85] = {
    imgTween = {
      {imgId = 108, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 850,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 2,
    audio = {
      bgm = {
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeOut = 3
      }
    }
  },
  [86] = {
    imgTween = {
      {imgId = 108, alpha = 0},
      {imgId = 101, alpha = 1}
    },
    content = 860,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [87] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 35, alpha = 1}
    },
    content = 870,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [88] = {
    imgTween = {
      {
        imgId = 35,
        duration = 0.2,
        shake = true
      }
    },
    content = 880,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [89] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, alpha = 1}
    },
    content = 890,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [90] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 103, alpha = 1}
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    },
    content = 900,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2
  },
  [91] = {
    images = {
      {
        imgId = 351,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      }
    },
    imgTween = {
      {imgId = 103, alpha = 0},
      {imgId = 101, alpha = 1}
    },
    content = 910,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [92] = {
    imgTween = {
      {imgId = 35, alpha = 1},
      {
        imgId = 35,
        duration = 1,
        alpha = 0.7
      },
      {
        imgId = 35,
        duration = 0.5,
        delay = 1,
        alpha = 1
      },
      {
        imgId = 351,
        duration = 1,
        alpha = 0.7
      },
      {
        imgId = 351,
        duration = 0.5,
        delay = 1,
        alpha = 0
      },
      {imgId = 101, alpha = 0}
    },
    content = 920,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [93] = {
    imgTween = {
      {
        imgId = 35,
        duration = 1,
        alpha = 0.7
      },
      {
        imgId = 35,
        duration = 0.5,
        delay = 1,
        alpha = 1
      },
      {
        imgId = 351,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 351,
        duration = 0.5,
        delay = 1,
        alpha = 0
      },
      {
        imgId = 35,
        duration = 1,
        alpha = 0.5,
        delay = 2
      },
      {
        imgId = 35,
        duration = 0.5,
        delay = 3,
        alpha = 1
      },
      {
        imgId = 351,
        duration = 1,
        alpha = 0.7,
        delay = 2
      },
      {
        imgId = 351,
        duration = 0.5,
        delay = 1,
        alpha = 0,
        delay = 3
      },
      {
        imgId = 35,
        duration = 0.1,
        isDark = true,
        delay = 3.5
      }
    },
    audio = {
      bgm = {stop = true}
    },
    content = 930,
    contentType = 2
  },
  [94] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, alpha = 1}
    },
    audio = {
      sfx = {
        cue = "Atk_Persicaria_01_Hit",
        sheet = "Chara_Persicaria"
      }
    },
    content = 940,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [95] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 103, alpha = 1}
    },
    heroFace = {
      {imgId = 103, faceId = 5}
    },
    content = 950,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2
  },
  [96] = {
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg002_2",
        scale = {
          7,
          7,
          7
        },
        fullScreen = true,
        order = 9
      }
    },
    imgTween = {
      {
        imgId = 35,
        duration = 1,
        alpha = 0.7
      },
      {
        imgId = 351,
        duration = 1,
        alpha = 0.5
      },
      {imgId = 103, alpha = 0}
    },
    content = 960,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [97] = {
    imgTween = {
      {
        imgId = 35,
        scale = {
          7,
          7,
          7
        },
        pos = {
          -200,
          -3200,
          0
        },
        duration = 5,
        alpha = 0
      },
      {
        imgId = 351,
        duration = 5,
        pos = {
          -200,
          -3750,
          0
        },
        scale = {
          7.5,
          7.5,
          7.5
        },
        alpha = 0.4
      },
      {
        imgId = 1,
        duration = 5,
        scale = {
          7,
          7,
          7
        },
        alpha = 0
      },
      {
        imgId = 351,
        duration = 3,
        delay = 5,
        pos = {
          -800,
          -13800,
          0
        },
        scale = {
          28,
          28,
          28
        },
        alpha = 0
      },
      {
        imgId = 2,
        delay = 8,
        scale = {
          1,
          1,
          1
        },
        duration = 6,
        alpha = 1
      },
      {
        imgId = 351,
        delay = 8.1,
        duration = 0.5,
        alpha = 1
      },
      {
        imgId = 351,
        duration = 5,
        delay = 8.6,
        pos = {
          8,
          -323,
          0
        },
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 351,
        duration = 0.5,
        delay = 14,
        pos = {
          8,
          -324,
          0
        }
      }
    },
    autoContinue = true,
    audio = {
      bgm = {
        cue = "Mus_Story_Passion",
        sheet = "Mus_Story_Passion",
        fadeOut = 3
      }
    }
  },
  [98] = {
    images = {
      {imgId = 35, delete = true},
      {imgId = 1, delete = true},
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 33,
        imgType = 3,
        alpha = 0,
        imgPath = "odette_avg"
      },
      {
        imgId = 34,
        imgType = 3,
        alpha = 0,
        imgPath = "odile_b_avg"
      }
    },
    imgTween = {
      {imgId = 351, alpha = 0},
      {imgId = 2, alpha = 0}
    },
    content = 980,
    contentType = 4,
    speakerName = 981,
    contentShake = true
  },
  [99] = {
    imgTween = {
      {
        imgId = 2,
        duration = 0.5,
        alpha = 1
      }
    },
    content = 990,
    contentType = 4,
    speakerName = 13
  },
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 13
  },
  [101] = {
    imgTween = {
      {imgId = 103, alpha = 6}
    },
    content = 1010,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [102] = {
    imgTween = {
      {imgId = 103, alpha = 0},
      {imgId = 102, posId = 3}
    },
    heroFace = {
      {imgId = 102, faceId = 2}
    },
    content = 1020,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2
  },
  [103] = {
    imgTween = {
      {imgId = 102, alpha = 0},
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 101, faceId = 1}
    },
    content = 1030,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [104] = {
    imgTween = {
      {imgId = 102, posId = 5},
      {
        imgId = 102,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 1040,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [106] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 102, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    },
    content = 1060,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [108] = {
    heroFace = {
      {imgId = 101, faceId = 5}
    },
    content = 1080,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [109] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 101, isDark = true}
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    },
    content = 1090,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [110] = {
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 1100,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [111] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 102, isDark = true}
    },
    content = 1110,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [112] = {
    imgTween = {
      {imgId = 102, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 1120,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [113] = {
    heroFace = {
      {imgId = 102, faceId = 2}
    },
    content = 1130,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    branch = {
      {content = 1131, jumpAct = 114},
      {content = 1132, jumpAct = 115}
    }
  },
  [114] = {
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 1140,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    nextId = 117
  },
  [115] = {
    heroFace = {
      {imgId = 102, faceId = 1}
    },
    content = 1150,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [117] = {
    imgTween = {
      {
        imgId = 102,
        duration = 0.2,
        shake = true
      },
      {
        imgId = 102,
        delay = 0.5,
        duration = 0.2,
        posId = 5
      },
      {
        imgId = 101,
        delay = 0.5,
        duration = 0.2,
        posId = 1
      }
    },
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    content = 1170,
    contentType = 2
  },
  [118] = {
    imgTween = {
      {imgId = 105, posId = 1},
      {
        imgId = 105,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 105,
        delay = 0.5,
        duration = 0.2,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_ClothingUp",
        sheet = "AVG_gf"
      }
    },
    content = 1180,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 1
  },
  [119] = {
    heroFace = {
      {imgId = 102, faceId = 0}
    },
    imgTween = {
      {imgId = 102, posId = 5},
      {
        imgId = 102,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 105, isDark = true}
    },
    content = 1190,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3
  },
  [121] = {
    imgTween = {
      {
        imgId = 102,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 105,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {imgId = 351, posId = 3}
    },
    content = 1210,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [123] = {
    imgTween = {
      {imgId = 351, alpha = 0},
      {imgId = 103, posId = 5},
      {
        imgId = 103,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 103, faceId = 5}
    },
    content = 1230,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [124] = {
    imgTween = {
      {imgId = 105, posId = 1},
      {
        imgId = 105,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 103, isDark = true}
    },
    heroFace = {
      {imgId = 105, faceId = 1}
    },
    content = 1240,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 1
  },
  [125] = {
    imgTween = {
      {imgId = 103, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 1250,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [126] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 103, isDark = true}
    },
    content = 1260,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 1
  },
  [127] = {
    imgTween = {
      {imgId = 103, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 1270,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [128] = {
    imgTween = {
      {
        imgId = 103,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 105,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {imgId = 351, alpha = 1}
    },
    content = 1280,
    contentType = 3,
    speakerHeroId = 35
  },
  [129] = {
    imgTween = {
      {imgId = 351, alpha = 0}
    },
    audio = {
      sfx = {
        cue = "Skill_Refactorer_01_Loop",
        sheet = "Mon_Refactorer",
        audioId = 14
      }
    },
    content = 1290,
    contentType = 2
  },
  [130] = {
    imgTween = {
      {imgId = 117, posId = 5},
      {
        imgId = 117,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    audio = {
      stopAudioId = {14}
    },
    content = 1300,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [131] = {
    imgTween = {
      {imgId = 108, posId = 1},
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true}
    },
    content = 1310,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [132] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 108, isDark = true}
    },
    content = 1320,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3
  },
  [133] = {
    imgTween = {
      {imgId = 108, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 1330,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [135] = {
    imgTween = {
      {
        imgId = 108,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 117,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {imgId = 33, posId = 3}
    },
    content = 1350,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 2
  },
  [136] = {
    imgTween = {
      {imgId = 33, alpha = 0},
      {imgId = 34, posId = 3}
    },
    heroFace = {
      {imgId = 34, faceId = 3}
    },
    content = 1360,
    contentType = 3,
    speakerHeroId = 34,
    speakerHeroPosId = 2
  },
  [137] = {
    imgTween = {
      {imgId = 34, alpha = 0},
      {
        imgId = 108,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    content = 1370,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 1
  },
  [138] = {
    imgTween = {
      {imgId = 101, posId = 5},
      {
        imgId = 101,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 108, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    content = 1380,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3
  },
  [140] = {
    imgTween = {
      {imgId = 351, posId = 3},
      {
        imgId = 101,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 108,
        posId = 1,
        isDark = false,
        duration = 0.2
      }
    },
    content = 1400,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    branch = {
      {content = 1401, jumpAct = 141},
      {content = 1402, jumpAct = 141}
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  }
}
return AvgCfg_cpt05_e_14_01
