local AvgCfg_cpt_lewis_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt07/cpt07_e_bg002",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg063",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
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
        imgId = 197,
        imgType = 3,
        alpha = 0,
        imgPath = "cocytus_avg"
      },
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "burbank_npc3_avg"
      },
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "robotdog_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
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
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0.1,
        duration = 0.1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0.2,
        duration = 0.1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0.3,
        duration = 0.1,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    images = {
      {
        imgId = 187,
        imgType = 3,
        alpha = 0,
        imgPath = "lewis_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      },
      {
        imgId = 114,
        imgType = 3,
        alpha = 0,
        imgPath = "robotdog_avg"
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true,
        delete = true
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        scale = {
          1.15,
          1.15,
          1.15
        }
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [9] = {content = 90, contentType = 2},
  [10] = {content = 100, contentType = 2},
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 197,
    imgTween = {
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
    },
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 197,
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
        shake = true,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 6}
    }
  },
  [13] = {
    content = 130,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [15] = {content = 150, contentType = 2},
  [16] = {content = 160, contentType = 2},
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 5}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 4}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 104
  },
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [22] = {autoContinue = true},
  [23] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 230,
    contentType = 2
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 15
  },
  [26] = {content = 260, contentType = 2},
  [27] = {content = 270, contentType = 2},
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 15
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 15
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 15
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 15
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 15
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 2,
    audio = {
      sfx = {cue = "AVG_quake", sheet = "AVG"}
    }
  },
  [36] = {content = 360, contentType = 2},
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2,
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 2,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [38] = {content = 380, contentType = 2},
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 6}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 5}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1087
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
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
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 187,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 5}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1087
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1087
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 1}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [51] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 187,
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
    }
  },
  [52] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 520,
    contentType = 3,
    speakerHeroId = 197,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 197,
        delay = 0.6,
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
      },
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 5}
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 14,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Passion",
        sheet = "Mus_Story_Passion",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 197,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        shake = true
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
    }
  },
  [58] = {
    content = 580,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 187,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 5}
    }
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 0}
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
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
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 2}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [70] = {content = 700, contentType = 2},
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 0}
    }
  },
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
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
    },
    nextId = 76
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1087,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
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
  [79] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [80] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 800,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 187,
        delay = 0.6,
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
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1087
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1087
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1087
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 1087
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1087
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1087
  },
  [88] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 187,
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
  [89] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 890,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 187,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Exiles",
        sheet = "Mus_Story_Exiles",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
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
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 1087,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [92] = {
    content = 920,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [93] = {content = 930, contentType = 2},
  [94] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 104,
        delay = 0.6,
        duration = 0.2,
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
      {imgId = 104, faceId = 0}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 104
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 4}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 0}
    }
  },
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 260,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
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
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 1}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    heroFace = {
      {imgId = 104, faceId = 0}
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 1}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 104
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 104,
    heroFace = {
      {imgId = 104, faceId = 0}
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1087,
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
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [111] = {
    content = 1110,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1087,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 104,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
      {imgId = 104, faceId = 2}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1087,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1087,
    speakerHeroPosId = 3
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 104,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 4}
    }
  },
  [117] = {
    content = 1170,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 260,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [120] = {
    content = 1200,
    contentType = 2,
    imgTween = {
      {
        imgId = 114,
        delay = 1,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = true
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 260,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 114,
        delay = 0.3,
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
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 0}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 187,
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
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [126] = {content = 1260, contentType = 2},
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 11
  },
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
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
    speakerHeroId = 260,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 2,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
      {imgId = 104, faceId = 0}
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 104,
    heroFace = {
      {imgId = 104, faceId = 1}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 104
  },
  [135] = {
    content = 1350,
    contentType = 2,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 1087
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 104,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0,
        posId = 2,
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
      {imgId = 104, faceId = 2}
    }
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1087,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 104,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 1}
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 104,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [142] = {
    content = 1420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 260,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [145] = {
    content = 1450,
    contentType = 2,
    imgTween = {
      {
        imgId = 114,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [146] = {content = 1460, contentType = 2},
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 104,
    imgTween = {
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
      {imgId = 104, faceId = 0}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 0}
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 2}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 104,
    contentShake = true,
    heroFace = {
      {imgId = 104, faceId = 0}
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [152] = {
    content = 1520,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [153] = {
    content = 1530,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 3}
    }
  },
  [154] = {
    content = 1540,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
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
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [156] = {
    content = 1560,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [157] = {
    content = 1570,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [158] = {
    content = 1580,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
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
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [160] = {
    content = 1600,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
    },
    heroFace = {
      {imgId = 187, faceId = 2}
    }
  },
  [162] = {
    content = 1620,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
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
    speakerHeroId = 1087,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [165] = {
    content = 1650,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [166] = {
    content = 1660,
    contentType = 3,
    speakerHeroId = 1087,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [167] = {
    content = 1670,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [168] = {
    content = 1680,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [169] = {
    content = 1690,
    contentType = 3,
    speakerHeroId = 1087,
    contentShake = true,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 3}
    }
  },
  [170] = {
    content = 1700,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [171] = {content = 1710, contentType = 2},
  [172] = {
    content = 1720,
    contentType = 4,
    speakerName = 11
  },
  [173] = {
    content = 1730,
    contentType = 4,
    speakerName = 16
  },
  [174] = {
    content = 1740,
    contentType = 4,
    speakerName = 11
  },
  [175] = {content = 1750, contentType = 2},
  [176] = {content = 1760, contentType = 2},
  [177] = {
    content = 1770,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [178] = {
    content = 1780,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
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
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [180] = {
    content = 1800,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [181] = {
    content = 1810,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [182] = {
    content = 1820,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 1087
  },
  [184] = {
    content = 1840,
    contentType = 3,
    speakerHeroId = 1087,
    heroFace = {
      {imgId = 187, faceId = 1}
    }
  },
  [185] = {
    content = 1850,
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [186] = {
    content = 1860,
    contentType = 3,
    speakerHeroId = 1087,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 187, faceId = 4}
    }
  },
  [187] = {
    content = 1870,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 187,
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
    contentType = 2,
    imgTween = {
      {
        imgId = 187,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_lewis_01
