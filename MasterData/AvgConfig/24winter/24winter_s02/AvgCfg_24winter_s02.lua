local AvgCfg_24winter_s02 = {
  [1] = {
    SkipScenario = 18,
    storyAvgId = 4000303,
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg070_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg034",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg072",
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
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 242,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 242,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 6}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {cue = "Gunfight", sheet = "AVG"}
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    imgTween = {
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
      },
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
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 129, faceId = 7}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
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
      {imgId = 139, faceId = 11}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 139,
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
  [9] = {
    content = 90,
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
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1029,
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
      },
      {
        imgId = 129,
        delay = 0.6,
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
  [11] = {
    content = 110,
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
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {
    content = 140,
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
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
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
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 7}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 242, faceId = 0}
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
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
      {imgId = 139, faceId = 1}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 242,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 4}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 242, faceId = 4}
    },
    contentShake = true
  },
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {content = 230, contentType = 2},
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 242,
    contentShake = true,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 2}
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [27] = {
    content = 270,
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
  [28] = {
    content = 280,
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
      },
      {
        imgId = 129,
        delay = 0.5,
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
  [29] = {
    content = 290,
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
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 2,
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
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
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
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 139,
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
      {imgId = 129, faceId = 7}
    }
  },
  [33] = {
    content = 330,
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
  [34] = {
    content = 340,
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
      {imgId = 129, faceId = 1}
    }
  },
  [35] = {
    content = 350,
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
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
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
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 242, faceId = 0}
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [38] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
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
  [40] = {content = 400, contentType = 2},
  [41] = {content = 410, contentType = 2},
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Door_Open_Close",
        sheet = "AVG_gf"
      },
      stopAudioId = {0}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
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
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 242,
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
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        shakeIntensity = 4,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 4}
    }
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
    contentShake = true,
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
      {imgId = 129, faceId = 4}
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
      }
    }
  },
  [49] = {content = 490, contentType = 2},
  [50] = {
    content = 500,
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
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
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
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
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
    }
  },
  [53] = {content = 530, contentType = 2},
  [54] = {content = 540, contentType = 2},
  [55] = {content = 550, contentType = 2},
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 11,
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
  [57] = {
    content = 570,
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
  [58] = {
    content = 580,
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
  [59] = {content = 590, contentType = 2},
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1029,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 129, faceId = 0}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1029,
    heroFace = {
      {imgId = 129, faceId = 1}
    }
  },
  [62] = {
    content = 620,
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
  [63] = {
    content = 630,
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
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1039
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1039
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 2}
    }
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [70] = {
    content = 700,
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
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 0}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
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
      {imgId = 139, faceId = 1}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 4}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
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
      {imgId = 139, faceId = 11}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1039
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 5}
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
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
  [79] = {
    content = 790,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1029,
    imgTween = {
      {
        imgId = 139,
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
      {imgId = 129, faceId = 4}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1029
  },
  [83] = {
    content = 830,
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
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11
  },
  [85] = {content = 850, contentType = 2},
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 2,
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
      {imgId = 129, faceId = 6}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1029,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
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
        duration = 0,
        posId = 4,
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
  [89] = {
    content = 890,
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
        shake = true,
        isDark = false
      },
      {
        imgId = 129,
        delay = 0.5,
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
  [90] = {
    content = 900,
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
      },
      {
        imgId = 129,
        delay = 0.8,
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
  [91] = {
    content = 910,
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
  }
}
return AvgCfg_24winter_s02
