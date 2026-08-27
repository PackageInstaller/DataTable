local AvgCfg_24summer_s00 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 3306200,
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg"
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon_avg"
      },
      {
        imgId = 26,
        imgType = 3,
        alpha = 0,
        imgPath = "beelneith_avg"
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    },
    nextId = 4
  },
  [4] = {autoContinue = true},
  [5] = {content = 50, contentType = 1},
  [6] = {autoContinue = true},
  [7] = {content = 70, contentType = 1},
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Purifier",
        sheet = "Mus_Story_Purifier",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [9] = {content = 90, contentType = 2},
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 37
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 21,
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_avg"
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg"
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg"
      }
    },
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0.3,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
        delay = 0.3,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 6}
    }
  },
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [21] = {
    content = 210,
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
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 3}
    }
  },
  [23] = {
    content = 230,
    contentType = 2,
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_avg",
        delete = true
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        delete = true
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 4}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 0}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 4}
    }
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [28] = {content = 280, contentType = 2},
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1.6,
        alpha = 1,
        scale = {
          1,
          1,
          1
        }
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [31] = {
    content = 310,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 3}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 7}
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 15,
    contentShake = true,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
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
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 38,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Hesperus",
        sheet = "Mus_EV3_Story_Hesperus",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 7}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 3,
    contentShake = true,
    images = {
      {
        imgId = 65,
        imgType = 3,
        alpha = 0,
        imgPath = "reverence_avg"
      },
      {
        imgId = 16,
        imgType = 3,
        alpha = 0,
        imgPath = "faith_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        order = 4
      },
      {
        imgId = 52,
        imgType = 3,
        alpha = 0,
        imgPath = "love_avg"
      }
    },
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 65, faceId = 4}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 52,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 52,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 52, faceId = 2}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 52
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 16,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 52,
    speakerHeroPosId = 2,
    imgTween = {
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
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 52, faceId = 1}
    }
  },
  [49] = {
    content = 490,
    contentType = 2,
    imgTween = {
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg"
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg"
      },
      {
        imgId = 65,
        imgType = 3,
        alpha = 0,
        imgPath = "reverence_avg",
        delete = true
      },
      {
        imgId = 16,
        imgType = 3,
        alpha = 0,
        imgPath = "faith_avg",
        delete = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
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
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 78, faceId = 2}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 0}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 6}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 3}
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        delete = true
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1,
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
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
  [58] = {autoContinue = true},
  [59] = {
    content = 590,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002_2",
        fullScreen = true
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg",
        delete = true
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
  [60] = {
    content = 600,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
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
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [62] = {
    content = 620,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [63] = {content = 630, contentType = 2},
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 12
  },
  [65] = {
    content = 650,
    contentType = 4,
    speakerName = 13
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 12
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
      {imgId = 30, faceId = 3}
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
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
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 7}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 26
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 0}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 4}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 6}
    }
  },
  [79] = {
    content = 790,
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
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 38
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 6}
    }
  },
  [86] = {
    content = 860,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 0}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 26
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 10}
    }
  },
  [90] = {
    content = 900,
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
      bgm = {stop = true}
    }
  },
  [91] = {
    content = 910,
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
      {imgId = 30, faceId = 4}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 30
  },
  [93] = {
    content = 930,
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
  [94] = {
    content = 940,
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
      {imgId = 30, faceId = 3}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 30
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 3}
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [101] = {
    content = 1010,
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
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 3}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 6}
    }
  },
  [107] = {
    content = 1070,
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
  [108] = {
    content = 1080,
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
      {imgId = 30, faceId = 3}
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 30
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [112] = {
    content = 1120,
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
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 38
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 38
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 8}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [123] = {
    content = 1230,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [126] = {
    content = 1260,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [127] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 30
  },
  [130] = {
    content = 1300,
    contentType = 2,
    images = {
      {
        imgId = 502,
        imgType = 3,
        alpha = 0,
        imgPath = "ira_avg",
        order = 5
      }
    },
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0,
        pos = {
          -10,
          -300,
          0
        },
        alpha = 0,
        isDark = true
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        alpha = 0.5
      },
      {
        imgId = 502,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 2,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg001",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg005",
        fullScreen = true,
        order = 5
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_wings_avg"
      }
    },
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [132] = {
    autoContinue = true,
    images = {
      {
        imgId = 502,
        imgType = 3,
        alpha = 0,
        imgPath = "ira_avg",
        delete = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon_avg",
        delete = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon2_avg"
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Hesperus",
        sheet = "Mus_EV3_Story_Hesperus",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Fire_Bonfire_loop",
        sheet = "AVG_gf",
        audioId = 1
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 2,
        delay = 1.6,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_smook",
        layer = 2,
        pos = {
          0,
          -150,
          0
        }
      }
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.15,
          1.15,
          1.15
        }
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0.3,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 4}
    }
  },
  [137] = {
    content = 1370,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [138] = {content = 1380, contentType = 2},
  [139] = {
    bgColor = 3,
    content = 1390,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.6
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Slime_Movement",
        sheet = "AVG"
      }
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [142] = {
    content = 1420,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.75
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "AVG_broken", sheet = "AVG"}
    },
    effect = {
      stopList = {"effect1"}
    }
  },
  [144] = {content = 1440, contentType = 2},
  [145] = {
    content = 1450,
    contentType = 4,
    speakerName = 11
  }
}
return AvgCfg_24summer_s00
