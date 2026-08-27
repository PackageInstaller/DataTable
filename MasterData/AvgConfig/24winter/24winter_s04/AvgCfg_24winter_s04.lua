local AvgCfg_24winter_s04 = {
  [1] = {
    SkipScenario = 18,
    storyAvgId = 4000305,
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg072",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg070_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg071",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg017",
        fullScreen = true
      },
      {
        imgId = 129,
        imgType = 3,
        alpha = 0,
        imgPath = "tony_avg"
      },
      {
        imgId = 242,
        imgType = 3,
        alpha = 0,
        imgPath = "chris_avg"
      },
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_sp_avg"
      },
      {
        imgId = 243,
        imgType = 3,
        alpha = 0,
        imgPath = "soldier_weber_hurt_avg"
      },
      {
        imgId = 240,
        imgType = 3,
        alpha = 0,
        imgPath = "soldier_helmet_avg"
      },
      {
        imgId = 241,
        imgType = 3,
        alpha = 0,
        imgPath = "soldier_helmet_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
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
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Halloween_Wind_loop",
        sheet = "AVG_gf",
        audioId = 0
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [8] = {content = 80, contentType = 2},
  [9] = {
    content = 90,
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
      bgm = {
        stop = false,
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Door_Hit",
        sheet = "AVG_gf"
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 8}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1039,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 4}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 7}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 5}
    }
  },
  [19] = {
    content = 190,
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
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 242,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 242,
        delay = 1.6,
        duration = 0.6,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 2.2,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 3.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 4.2,
        duration = 0.6,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 242, faceId = 6}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 5}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [23] = {
    content = 230,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 11}
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 5}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 1}
    }
  },
  [30] = {
    content = 300,
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
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 7}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 0}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 1}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3
  },
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 1}
    }
  },
  [38] = {
    content = 380,
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
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 7}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1029
  },
  [41] = {
    content = 410,
    contentType = 2,
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
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 3}
    }
  },
  [43] = {
    content = 430,
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
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
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
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 0}
    }
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
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
      bgm = {stop = true},
      stopAudioId = {0}
    }
  },
  [49] = {
    content = 490,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
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
  [50] = {content = 500, contentType = 2},
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 1}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [53] = {content = 530, contentType = 2},
  [54] = {content = 540, contentType = 2},
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 3,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 571
  },
  [58] = {content = 580, contentType = 2},
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 240,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 241,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 240,
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
    speakerHeroId = 240,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 241,
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
    speakerHeroId = 241,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 240,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1029,
    contentShake = true,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 129, faceId = 4}
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
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
    speakerHeroId = 240,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 240,
    speakerHeroPosId = 1
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 241,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 241,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 6}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1029,
    heroFace = {
      {imgId = 129, faceId = 4}
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 5}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1029
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1029,
    heroFace = {
      {imgId = 129, faceId = 6}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1029
  },
  [76] = {
    content = 760,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
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
      }
    }
  },
  [77] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [78] = {content = 780, contentType = 1},
  [79] = {
    content = 790,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
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
  [80] = {content = 800, contentType = 2},
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 240,
    contentShake = true,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 2}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 240,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 240,
    contentShake = true,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
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
    speakerHeroId = 1029,
    contentShake = true,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
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
    },
    heroFace = {
      {imgId = 129, faceId = 4}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [88] = {content = 880, contentType = 2},
  [89] = {content = 890, contentType = 2},
  [90] = {content = 900, contentType = 2},
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 7}
    }
  },
  [92] = {
    content = 920,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 2,
    contentShake = true
  },
  [94] = {content = 940, contentType = 2},
  [95] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [96] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 960,
    contentType = 3,
    speakerHeroId = 243,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 243,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 243,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 243, faceId = 1}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 243,
    heroFace = {
      {imgId = 243, faceId = 0}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 243
  },
  [99] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 243,
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
  [100] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1000,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 129,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 3}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1029,
    heroFace = {
      {imgId = 129, faceId = 1}
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 240,
    contentShake = true,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 2}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 240,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 2,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 0}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1029
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1029
  },
  [109] = {
    content = 1090,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [110] = {content = 1100, contentType = 2},
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 240,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 240,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 2}
    }
  },
  [113] = {
    content = 1130,
    contentType = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
    }
  }
}
return AvgCfg_24winter_s04
