local AvgCfg_cpt05_e_13_01 = {
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
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg006"
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
        imgId = 33,
        imgType = 3,
        alpha = 0,
        imgPath = "odette_avg"
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
      {imgId = 108, posId = 5},
      {
        imgId = 108,
        delay = 1,
        duration = 0.2,
        posId = 4
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [2] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 108, isDark = true}
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [3] = {
    imgTween = {
      {imgId = 108, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [4] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 108, isDark = true}
    },
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [5] = {
    imgTween = {
      {imgId = 108, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [6] = {
    imgTween = {
      {imgId = 108, alpha = 0},
      {imgId = 101, alpha = 0}
    },
    content = 60,
    contentType = 2
  },
  [7] = {
    imgTween = {
      {
        imgId = 101,
        alpha = 1,
        isDark = false
      }
    },
    content = 70,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [8] = {
    imgTween = {
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    heroFace = {
      {imgId = 105, faceId = 6}
    },
    content = 80,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [11] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    heroFace = {
      {imgId = 105, faceId = 0},
      {imgId = 101, faceId = 4}
    },
    content = 110,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [13] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 130,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [15] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 150,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [17] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 170,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [20] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    },
    content = 200,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [21] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 210,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [23] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 230,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [25] = {
    imgTween = {
      {imgId = 103, posId = 5},
      {
        imgId = 103,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true},
      {
        imgId = 105,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 250,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [26] = {
    audio = {
      sfx = {
        cue = "Atk_Croque_01",
        sheet = "Chara_Croque"
      }
    },
    content = 260,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    contentShake = true
  },
  [27] = {
    imgTween = {
      {imgId = 117, posId = 1},
      {
        imgId = 117,
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
    audio = {
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    },
    content = 270,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [28] = {
    heroFace = {
      {imgId = 103, faceId = 5}
    },
    imgTween = {
      {imgId = 103, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 280,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [29] = {
    heroFace = {
      {imgId = 103, faceId = 3}
    },
    content = 290,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [30] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 103, isDark = true}
    },
    content = 300,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [31] = {
    audio = {
      bgm = {stop = true}
    },
    imgTween = {
      {imgId = 117, alpha = 0},
      {imgId = 103, alpha = 0},
      {
        imgId = 2,
        scale = {
          2,
          2,
          2
        },
        duration = 1,
        pos = {
          0,
          100,
          0
        },
        alpha = 1
      }
    },
    content = 310,
    contentType = 4,
    speakerName = 14
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 15
  },
  [33] = {
    imgTween = {
      {
        imgId = 33,
        posId = 4,
        isDark = false
      }
    },
    content = 330,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3,
    branch = {
      {content = 331, jumpAct = 34},
      {content = 332, jumpAct = 42}
    }
  },
  [34] = {
    images = {
      {imgId = 2, delete = true}
    },
    imgTween = {
      {
        imgId = 117,
        alpha = 1,
        isDark = false
      },
      {imgId = 33, isDark = true}
    },
    content = 340,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [35] = {
    imgTween = {
      {imgId = 103, posId = 5},
      {
        imgId = 103,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 117, isDark = true},
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 350,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [37] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 103, isDark = true}
    },
    content = 370,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [38] = {
    audio = {
      bgm = {
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    content = 380,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [39] = {
    imgTween = {
      {imgId = 117, isDark = true},
      {
        imgId = 33,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 103,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 390,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [40] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 33, isDark = true}
    },
    content = 400,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1,
    nextId = 47
  },
  [42] = {
    images = {
      {imgId = 2, delete = true}
    },
    imgTween = {
      {
        imgId = 117,
        alpha = 1,
        isDark = false
      },
      {imgId = 33, isDark = true}
    },
    content = 420,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [43] = {
    imgTween = {
      {imgId = 33, isDark = false},
      {imgId = 117, isDark = true}
    },
    audio = {
      bgm = {
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    content = 430,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [44] = {
    imgTween = {
      {imgId = 117, isDark = false},
      {imgId = 33, isDark = true}
    },
    content = 440,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 1
  },
  [47] = {
    imgTween = {
      {imgId = 33, isDark = false},
      {imgId = 117, isDark = true}
    },
    content = 470,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [49] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 117,
        posId = 1,
        isDark = false,
        duration = 0.2
      },
      {imgId = 33, isDark = true}
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    },
    content = 490,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [50] = {
    imgTween = {
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true},
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 500,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [52] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 105, alpha = 0},
      {imgId = 101, alpha = 0}
    },
    content = 520,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [53] = {
    imgTween = {
      {imgId = 105, posId = 3},
      {imgId = 35, alpha = 0}
    },
    heroFace = {
      {imgId = 105, faceId = 6}
    },
    content = 530,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [54] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 105, alpha = 0}
    },
    content = 540,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [55] = {
    imgTween = {
      {
        imgId = 101,
        posId = 3,
        isDark = false
      },
      {imgId = 35, alpha = 0}
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    content = 550,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [57] = {
    imgTween = {
      {imgId = 35, posId = 3},
      {imgId = 101, alpha = 0}
    },
    content = 570,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [61] = {
    imgTween = {
      {imgId = 101, posId = 3},
      {imgId = 35, alpha = 0}
    },
    content = 610,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [62] = {
    audio = {
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    },
    imgTween = {
      {
        imgId = 101,
        duration = 0.5,
        pos = {
          200,
          -310,
          0
        },
        alpha = 0
      }
    },
    content = 620,
    contentType = 2
  },
  [63] = {
    imgTween = {
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    heroFace = {
      {imgId = 105, faceId = 5}
    },
    content = 630,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [65] = {
    imgTween = {
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 105, isDark = true}
    },
    content = 650,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [67] = {
    heroFace = {
      {imgId = 105, faceId = 0}
    },
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 670,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [68] = {
    imgTween = {
      {imgId = 105, alpha = 0},
      {imgId = 101, alpha = 0}
    },
    audio = {
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    },
    content = 680,
    contentType = 2
  },
  [69] = {
    imgTween = {
      {
        imgId = 101,
        posId = 3,
        isDark = false
      }
    },
    content = 690,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [70] = {
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005",
        fullScreen = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Persicaria_Ex_Start",
        sheet = "Chara_Persicaria"
      }
    },
    content = 700,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [71] = {
    imgTween = {
      {
        imgId = 1,
        alpha = 0,
        duration = 1.5
      },
      {
        imgId = 2,
        delay = 1.5,
        alpha = 0.3,
        duration = 1
      },
      {imgId = 101, alpha = 0}
    },
    autoContinue = true
  },
  [72] = {
    ppv = {
      cg = {saturation = -100}
    },
    content = 720,
    contentType = 4,
    speakerName = 12
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 11
  },
  [74] = {
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    },
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
    speakerName = 11
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 12
  },
  [78] = {
    imgTween = {
      {
        imgId = 2,
        alpha = 0,
        duration = 0.5
      },
      {
        imgId = 1,
        delay = 0.5,
        alpha = 1,
        duration = 0.5
      }
    },
    ppv = {
      cg = {saturation = 0}
    },
    autoContinue = true
  },
  [79] = {
    heroFace = {
      {imgId = 105, faceId = 5}
    },
    imgTween = {
      {imgId = 105, posId = 3}
    },
    content = 790,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2
  },
  [80] = {
    imgTween = {
      {imgId = 105, alpha = 0},
      {imgId = 35, alpha = 1},
      {
        imgId = 35,
        duration = 0.2,
        shake = true
      }
    },
    content = 800,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [81] = {
    imgTween = {
      {
        imgId = 35,
        duration = 0.5,
        posId = 2,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Croque_01",
        sheet = "Chara_Croque"
      }
    },
    content = 810,
    contentType = 2
  },
  [82] = {
    imgTween = {
      {imgId = 35, posId = 3}
    },
    content = 820,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [83] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, posId = 1},
      {
        imgId = 101,
        posId = 2,
        isDark = false,
        duration = 0.2
      }
    },
    content = 830,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [85] = {
    imgTween = {
      {imgId = 105, posId = 5},
      {
        imgId = 105,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    content = 850,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [86] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 860,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [87] = {
    imgTween = {
      {imgId = 105, isDark = false},
      {imgId = 101, isDark = true}
    },
    content = 870,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [88] = {
    imgTween = {
      {imgId = 101, isDark = false},
      {imgId = 105, isDark = true}
    },
    content = 880,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
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
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [91] = {
    imgTween = {
      {imgId = 103, posId = 5},
      {imgId = 105, posId = 5},
      {
        imgId = 103,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {imgId = 101, isDark = true}
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    },
    content = 910,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [93] = {
    imgTween = {
      {imgId = 108, posId = 5},
      {
        imgId = 108,
        posId = 4,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 103,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 930,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [95] = {
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
      }
    },
    content = 950,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 3
  },
  [96] = {
    imgTween = {
      {
        imgId = 33,
        posId = 5,
        isDark = false,
        duration = 0.2
      },
      {
        imgId = 108,
        posId = 4,
        isDark = false,
        duration = 0.2
      }
    },
    content = 960,
    contentType = 3,
    speakerHeroId = 1008,
    speakerHeroPosId = 3
  },
  [97] = {
    imgTween = {
      {imgId = 103, posId = 4},
      {
        imgId = 108,
        posId = 5,
        isDark = false,
        duration = 0.2
      }
    },
    content = 970,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [98] = {
    imgTween = {
      {imgId = 103, alpha = 0},
      {imgId = 101, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 980,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [99] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {
        imgId = 101,
        posId = 3,
        isDark = false
      }
    },
    content = 990,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [100] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 1000,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [101] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, posId = 3}
    },
    content = 1010,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [102] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 1020,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [103] = {
    audio = {
      bgm = {stop = true}
    },
    imgTween = {
      {
        imgId = 1,
        duration = 0.5,
        alpha = 0
      },
      {imgId = 35, alpha = 0},
      {
        imgId = 2,
        duration = 0.5,
        delay = 0.5,
        alpha = 0.3
      }
    },
    ppv = {
      cg = {saturation = -100}
    },
    autoContinue = true
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 11
  },
  [105] = {
    content = 1050,
    contentType = 4,
    speakerName = 12
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 11
  },
  [108] = {content = 1080, contentType = 2},
  [109] = {
    imgTween = {
      {
        imgId = 2,
        duration = 0.5,
        alpha = 0
      },
      {
        imgId = 1,
        duration = 0.5,
        delay = 0.5,
        alpha = 1
      }
    },
    ppv = {
      cg = {saturation = 0}
    },
    autoContinue = true
  },
  [110] = {
    imgTween = {
      {
        imgId = 35,
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
    content = 1100,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [111] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, posId = 3}
    },
    content = 1110,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [112] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 35, posId = 3}
    },
    content = 1120,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [114] = {
    imgTween = {
      {imgId = 35, alpha = 0},
      {imgId = 101, posId = 3}
    },
    content = 1140,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [115] = {
    imgTween = {
      {imgId = 101, alpha = 0},
      {imgId = 33, posId = 3}
    },
    content = 1150,
    contentType = 3,
    speakerHeroId = 33,
    speakerHeroPosId = 2
  }
}
return AvgCfg_cpt05_e_13_01
