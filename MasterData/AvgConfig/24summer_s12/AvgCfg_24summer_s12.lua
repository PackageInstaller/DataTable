local AvgCfg_24summer_s12 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 3306210,
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 65,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg001",
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
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon2_avg"
      },
      {
        imgId = 65,
        imgType = 3,
        alpha = 0,
        imgPath = "reverence_avg"
      },
      {
        imgId = 262,
        imgType = 3,
        alpha = 0,
        imgPath = "hope_avg"
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
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge_avg"
      },
      {
        imgId = 197,
        imgType = 3,
        alpha = 0,
        imgPath = "cocytus_avg"
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
        imgId = 65,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
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
        cue = "Mus_Boss_Purifier_General",
        sheet = "Mus_Boss_Purifier_General",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 65, faceId = 6}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 1,
        delay = 0.3,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.3,
        duration = 0.3,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.6,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 262,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 262,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 262,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 262,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 65, faceId = 6}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 262,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 262,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 262,
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
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 65,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 65, faceId = 6}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 65,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 197,
    contentShake = true,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
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
    speakerHeroId = 16,
    contentShake = true,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
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
    },
    heroFace = {
      {imgId = 16, faceId = 4}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 65,
    contentShake = true,
    imgTween = {
      {
        imgId = 16,
        delay = 0,
        duration = 0.2,
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
      }
    },
    heroFace = {
      {imgId = 65, faceId = 6}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.15,
          1.15,
          1.15
        }
      }
    },
    audio = {
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 2,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 3,
    contentShake = true,
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
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 65, faceId = 5}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 80,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 80, faceId = 1}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.6,
        posId = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 65,
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
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 80,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 80, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 52,
    imgTween = {
      {
        imgId = 80,
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
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 52,
    heroFace = {
      {imgId = 52, faceId = 1}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 80,
    imgTween = {
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 80,
    contentShake = true,
    heroFace = {
      {imgId = 80, faceId = 3}
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 251,
    contentShake = true,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_execute",
        sheet = "AVG"
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [29] = {
    content = 290,
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
        shake = true,
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
      {imgId = 38, faceId = 4}
    }
  },
  [30] = {
    content = 300,
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
        duration = 0.6,
        shake = true
      }
    }
  },
  [31] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
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
    audio = {
      bgm = {stop = true}
    }
  },
  [32] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 320,
    contentType = 3,
    speakerHeroId = 30,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg001",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true
      },
      {
        imgId = 65,
        imgType = 3,
        alpha = 0,
        imgPath = "reverence_avg",
        delete = true
      },
      {
        imgId = 262,
        imgType = 3,
        alpha = 0,
        imgPath = "hope_avg",
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
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg"
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
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 12,
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
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 12
  },
  [35] = {
    content = 350,
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
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 12,
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
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 12
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 12,
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
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 12
  },
  [42] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 30,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [43] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 430,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg001",
        fullScreen = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg002",
        fullScreen = true,
        delete = true
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
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.5,
        isDark = false
      },
      {
        imgId = 38,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        shake = true,
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
      {imgId = 38, faceId = 1}
    }
  },
  [44] = {
    content = 440,
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
        duration = 0.6,
        shake = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.35
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Fir_Bonfire",
        sheet = "AVG_gf"
      }
    }
  },
  [45] = {
    content = 450,
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
      {imgId = 38, faceId = 5}
    }
  },
  [46] = {
    content = 460,
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
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [48] = {content = 480, contentType = 2},
  [49] = {
    content = 490,
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
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1002,
    images = {
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "anna_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 102, faceId = 11}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 0}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg",
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
      {imgId = 38, faceId = 0}
    }
  },
  [53] = {
    content = 530,
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
  [54] = {
    content = 540,
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
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1002,
    images = {
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "anna_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
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
      {imgId = 102, faceId = 13}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    images = {
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg",
        delete = true
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        comm = true
      }
    },
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
      {imgId = 999, faceId = 11}
    }
  },
  [58] = {
    content = 580,
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
  [59] = {
    content = 590,
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
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
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
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 38
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
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
      {imgId = 999, faceId = 8}
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [66] = {
    content = 660,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_22Halloween",
        sheet = "Mus_EV_22Halloween",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 38
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 38
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
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
      {imgId = 999, faceId = 12}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
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
    }
  },
  [72] = {
    content = 720,
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
  [73] = {content = 730, contentType = 2},
  [74] = {
    content = 740,
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
      {imgId = 38, faceId = 5}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
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
      {imgId = 999, faceId = 0}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 2
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
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
      {imgId = 38, faceId = 2}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
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
      {imgId = 999, faceId = 15}
    }
  },
  [81] = {
    content = 810,
    contentType = 2,
    images = {
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [82] = {
    content = 820,
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
      {imgId = 38, faceId = 8}
    }
  },
  [83] = {
    content = 830,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 21,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        posId = 3,
        comm = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 21,
    heroFace = {
      {imgId = 21, faceId = 4}
    }
  },
  [86] = {
    content = 860,
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
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 38
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 21,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        posId = 3,
        comm = true
      }
    },
    heroFace = {
      {imgId = 21, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 21
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 21,
    heroFace = {
      {imgId = 21, faceId = 4}
    }
  },
  [91] = {
    content = 910,
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
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [92] = {
    content = 920,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
  [93] = {
    content = 930,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 21,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        posId = 3,
        comm = true
      }
    }
  },
  [95] = {
    content = 950,
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
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      }
    },
    heroFace = {
      {imgId = 38, faceId = 6}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 21,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        posId = 3,
        comm = true
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 2,
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      }
    }
  },
  [98] = {
    content = 980,
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
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 21,
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
        imgId = 21,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        posId = 3,
        comm = true
      }
    },
    heroFace = {
      {imgId = 21, faceId = 4}
    }
  },
  [101] = {
    content = 1010,
    contentType = 2,
    images = {
      {
        imgId = 21,
        imgType = 3,
        alpha = 0,
        imgPath = "mara_weapon_avg",
        delete = true
      }
    }
  },
  [102] = {content = 1020, contentType = 2},
  [103] = {
    content = 1030,
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
      },
      {
        imgId = 38,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [104] = {
    content = 1040,
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
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.75
      }
    }
  },
  [105] = {
    content = 1050,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_XS",
        sheet = "Mus_Boss_Purifier_XS",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 38
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 38
  },
  [108] = {
    content = 1080,
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
        duration = 1,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Fire_Bonfire_loop",
        sheet = "AVG_gf",
        audioId = 1
      }
    },
    effect = {
      effect4 = {
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
  [109] = {content = 1090, contentType = 2},
  [110] = {
    content = 1100,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true
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
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [111] = {content = 1110, contentType = 2},
  [112] = {
    content = 1120,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    effect = {
      stopList = {"effect4"}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 52,
    imgTween = {
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 52, faceId = 2}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 80,
    contentShake = true,
    imgTween = {
      {
        imgId = 52,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 80, faceId = 2}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 80,
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
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 80,
        delay = 0.3,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 38
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 80,
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
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 80,
        delay = 0.3,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 80,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 80, faceId = 3}
    }
  },
  [120] = {
    content = 1200,
    contentType = 2,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
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
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        scale = {
          1.25,
          1.25,
          1.25
        },
        pos = {
          -20,
          -420,
          0
        },
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
      {imgId = 38, faceId = 7}
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true
  },
  [125] = {
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1251, jumpAct = 126},
      {content = 1252, jumpAct = 126}
    }
  },
  [126] = {
    branch = {
      {content = 1261, jumpAct = 127},
      {content = 1262, jumpAct = 127}
    }
  },
  [127] = {
    branch = {
      {content = 1271, jumpAct = 128},
      {content = 1272, jumpAct = 128}
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 12,
    images = {
      {
        imgId = 52,
        imgType = 3,
        alpha = 0,
        imgPath = "love_avg",
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
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg004",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    effect = {
      stopList = {"effect1"}
    }
  },
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 12
  },
  [130] = {
    content = 1300,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    }
  },
  [131] = {content = 1310, contentType = 2}
}
return AvgCfg_24summer_s12
