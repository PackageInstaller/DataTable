local AvgCfg_cpt_erika_00_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 12,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg025_1",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg013_3",
        scale = {
          1.25,
          1.25,
          1.25
        },
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_7",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg005_8",
        fullScreen = true
      },
      {
        imgId = 176,
        imgType = 3,
        alpha = 0,
        imgPath = "erika_avg"
      },
      {
        imgId = 134,
        imgType = 3,
        alpha = 0,
        imgPath = "abigail_avg"
      },
      {
        imgId = 200,
        imgType = 3,
        alpha = 0,
        imgPath = "dog_avg"
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg001_4",
        fullScreen = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 12
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_footsteps_cave",
        sheet = "AVG_gf"
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 13
  },
  [5] = {
    content = 50,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_rifle_finalshot_h",
        sheet = "AVG_gf"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 176,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 176,
        delay = 1.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Depressed",
        sheet = "Mus_Story_Depressed",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 176, faceId = 3}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 7}
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 12
  },
  [11] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    },
    ppv = {
      cg = {saturation = -30},
      dofTween = {startValue = 1, duration = 1}
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 2,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 1.8,
        duration = 1,
        alpha = 1,
        isDark = true
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 176,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 176,
        delay = 1.8,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 3}
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 6}
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
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 6}
    }
  },
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [23] = {
    content = 230,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
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
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1076
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
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
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 5}
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 11
  },
  [35] = {
    content = 350,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    nextId = 37
  },
  [36] = {
    content = 360,
    contentType = 2,
    autoContinue = true
  },
  [37] = {
    branch = {
      {content = 371, jumpAct = 38},
      {content = 372, jumpAct = 42}
    }
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
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
    contentType = 4,
    speakerName = 11
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 46
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
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
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
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
    contentType = 4,
    speakerName = 11
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1076
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1076,
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 1}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1076
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 5}
    }
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 11
  },
  [65] = {content = 650, contentType = 2},
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 6}
    }
  },
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 0}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1076
  },
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 11
  },
  [72] = {
    content = 720,
    contentType = 4,
    speakerName = 11
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1076,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 2}
    }
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [75] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 176,
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
  [76] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 760,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.2
      },
      {
        imgId = 3,
        delay = 1.2,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 2.5,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 3,
        delay = 3.7,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.75
      }
    },
    nextId = 601
  },
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 12
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0.4
      },
      {
        imgId = 3,
        delay = 0.5,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0.4
      },
      {
        imgId = 3,
        delay = 0.8,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 14,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0.4
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 17,
    contentShake = true,
    audio = {
      sfx = {
        cue = "Skill_Abigail_01",
        sheet = "Chara_Abigail"
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 15,
    contentShake = true
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 200,
    contentShake = true,
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
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 15,
    contentShake = true,
    imgTween = {
      {
        imgId = 200,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 200,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 15,
    contentShake = true
  },
  [90] = {
    content = 900,
    contentType = 4,
    speakerName = 16,
    contentShake = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 1034,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 134,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 134,
        delay = 0.8,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    },
    heroFace = {
      {imgId = 134, faceId = 5}
    }
  },
  [92] = {
    content = 920,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1034,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 134, faceId = 4}
    }
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 134,
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
    speakerHeroId = 1034,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 134, faceId = 7}
    }
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 134,
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
    speakerHeroId = 1034,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 134, faceId = 7}
    }
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1034,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 134, faceId = 4}
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 200,
    contentShake = true,
    imgTween = {
      {
        imgId = 134,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 200,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 200,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    isEnd = true
  },
  [601] = {
    content = 781,
    contentType = 4,
    speakerName = 12,
    nextId = 79
  }
}
return AvgCfg_cpt_erika_00_01
