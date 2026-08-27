local AvgCfg_24summer_s06 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 3306206,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 21,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg003",
        fullScreen = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg007_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg006",
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
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      }
    },
    imgTween = {
      {
        imgId = 21,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
      },
      {
        imgId = 21,
        delay = 1,
        duration = 1,
        alpha = 0,
        shake = true
      },
      {
        imgId = 1,
        delay = 2,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Sector_Material",
        sheet = "Mus_Sector_Material",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true
      },
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
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 12}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1002,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 999,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 6}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1002,
    contentShake = true,
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [5] = {
    content = 50,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 21,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.75
      }
    },
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1002,
    contentShake = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 21,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 102,
        delay = 1.2,
        duration = 0.2,
        alpha = 1
      }
    }
  },
  [8] = {
    images = {
      {
        imgId = 21,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg003",
        fullScreen = true,
        delete = true
      }
    },
    content = 80,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 102,
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
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [9] = {
    content = 90,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    audio = {
      sfx = {
        cue = "Atk_Gabrie_01_Hit",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
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
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 10,
        delay = 1.2,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 1.2,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 10,
        delay = 2,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
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
    heroFace = {
      {imgId = 102, faceId = 7}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 12}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_door_storehouse",
        sheet = "AVG_gf"
      }
    }
  },
  [19] = {content = 190, contentType = 2},
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 102,
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
    }
  },
  [24] = {
    content = 240,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false
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
  [25] = {
    content = 250,
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
      {imgId = 102, faceId = 5}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 102,
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
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 30
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 30,
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
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
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
      {imgId = 102, faceId = 14}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 102,
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
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 14}
    }
  },
  [31] = {
    content = 310,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 2,
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
      sfx = {cue = "AVG_broken", sheet = "AVG"}
    }
  },
  [32] = {
    images = {
      {
        imgId = 26,
        imgType = 3,
        alpha = 0,
        imgPath = "beelneith_avg"
      }
    },
    content = 320,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
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
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [33] = {
    content = 330,
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
  [34] = {
    content = 340,
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
      {imgId = 26, faceId = 11}
    }
  },
  [35] = {
    content = 350,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [36] = {
    content = 360,
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
      {imgId = 26, faceId = 7}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 9}
    }
  },
  [38] = {
    content = 380,
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
  [39] = {
    content = 390,
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
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 30,
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
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 12}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 999, faceId = 0}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 999,
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
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 30,
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
      {imgId = 999, faceId = 6}
    }
  },
  [45] = {
    content = 450,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 2,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_22Halloween",
        sheet = "Mus_EV_22Halloween",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    imgTween = {
      {
        imgId = 999,
        delay = 0.6,
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
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        scale = {
          1,
          1,
          1
        }
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 999,
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
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [49] = {
    content = 490,
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
  [50] = {
    content = 500,
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
    }
  },
  [51] = {
    content = 510,
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
        delay = 0.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [52] = {
    content = 520,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [53] = {
    content = 530,
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
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.35
      }
    }
  },
  [54] = {
    content = 540,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_SC_Short",
        sheet = "Mus_Boss_Purifier_SC_Short",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 7}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 7}
    }
  },
  [58] = {
    content = 580,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 5}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 26,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 11}
    }
  },
  [60] = {
    images = {
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg002",
        fullScreen = true
      }
    },
    content = 600,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.6,
        scale = {
          1.2,
          1.2,
          1.2
        },
        alpha = 0,
        isDark = false
      },
      {
        imgId = 6,
        delay = 1.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 2,
        delay = 1.6,
        duration = 0,
        alpha = 0
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.2,
        shake = true
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 6,
        delay = 0.4,
        duration = 0.2,
        shake = true
      },
      {
        imgId = 10,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Gabrie_01_Hit",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 14,
    contentShake = true
  },
  [63] = {
    content = 630,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_energyreload",
        sheet = "AVG"
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 15,
    contentShake = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 6,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Beelneith_Combine3",
        sheet = "Mon_Beelneith"
      }
    }
  },
  [66] = {content = 660, contentType = 2},
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 14,
    contentShake = true
  },
  [68] = {
    content = 680,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        scale = {
          1.25,
          1.25,
          1.25
        },
        alpha = 0
      }
    }
  },
  [71] = {
    images = {
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg002",
        fullScreen = true,
        delete = true
      }
    },
    content = 710,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 7}
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
  [74] = {
    content = 740,
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
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 0
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
  [76] = {
    content = 760,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [77] = {
    content = 770,
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
        duration = 0.6,
        shake = true
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Gabrie_01_Hit",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
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
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [80] = {
    content = 800,
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
  [81] = {
    content = 810,
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
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
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
      {imgId = 102, faceId = 14}
    }
  },
  [83] = {
    content = 830,
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
  [84] = {
    content = 840,
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
      {imgId = 102, faceId = 6}
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 1002,
    contentShake = true,
    imgTween = {
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
      {imgId = 102, faceId = 6}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 999, faceId = 7}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
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
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1002
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 999, faceId = 6}
    }
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 999, faceId = 11}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1002,
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
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 6}
    }
  },
  [94] = {
    content = 940,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 102,
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
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 10,
        delay = 1.2,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {cue = "AVG_broken", sheet = "AVG"}
    }
  },
  [95] = {content = 950, contentType = 2},
  [96] = {
    content = 960,
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
      {imgId = 26, faceId = 11}
    }
  },
  [97] = {
    content = 970,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    audio = {
      sfx = {
        cue = "Atk_Gabrie_01_Hit",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
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
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 26,
    contentShake = true,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_DeusExMachina",
        sheet = "Mus_Story_DeusExMachina",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [103] = {
    content = 1030,
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
  [104] = {
    content = 1040,
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
      {imgId = 30, faceId = 5}
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 26,
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
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 8}
    }
  },
  [106] = {
    content = 1060,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1,
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
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 26,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 10}
    }
  },
  [110] = {
    images = {
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg002",
        fullScreen = true
      }
    },
    content = 1100,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
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
  [111] = {
    content = 1110,
    contentType = 4,
    speakerName = 15,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
    }
  },
  [112] = {
    content = 1120,
    contentType = 4,
    speakerName = 14
  },
  [113] = {
    content = 1130,
    contentType = 4,
    speakerName = 15
  },
  [114] = {
    content = 1140,
    contentType = 4,
    speakerName = 14
  },
  [115] = {
    content = 1150,
    contentType = 4,
    speakerName = 14
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 15
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 14
  },
  [118] = {
    content = 1180,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [119] = {
    images = {
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg002",
        fullScreen = true,
        delete = true
      }
    },
    content = 1190,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 9}
    }
  },
  [120] = {
    content = 1200,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 30
  },
  [122] = {
    content = 1220,
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
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 7}
    }
  },
  [125] = {
    content = 1250,
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
        isDark = false
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 26,
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
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 26,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 11}
    }
  },
  [127] = {
    content = 1270,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [128] = {
    content = 1280,
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
    }
  },
  [129] = {
    content = 1290,
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
      {imgId = 30, faceId = 8}
    }
  },
  [130] = {
    content = 1300,
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
      {imgId = 26, faceId = 9}
    }
  },
  [131] = {
    content = 1310,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 2}
    }
  },
  [132] = {
    content = 1320,
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
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      }
    },
    audio = {
      sfx = {
        cue = "AVG_energyreload",
        sheet = "AVG"
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 26,
    contentShake = true,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 8}
    }
  },
  [134] = {
    content = 1340,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 26,
    contentShake = true,
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
      {imgId = 26, faceId = 6}
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 26,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 26, faceId = 11}
    }
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 26,
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
      {imgId = 102, faceId = 6}
    }
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 26, faceId = 3}
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 0}
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [142] = {
    content = 1420,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0.4,
        duration = 0.2,
        alpha = 0
      }
    }
  },
  [143] = {
    content = 1430,
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
  [144] = {
    content = 1440,
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
  [145] = {
    content = 1450,
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
      {imgId = 102, faceId = 0}
    }
  },
  [146] = {
    content = 1460,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 26, faceId = 1}
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 1002,
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
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 14}
    }
  },
  [148] = {
    content = 1480,
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
  [149] = {
    content = 1490,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
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
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Entropy",
        sheet = "Mus_Story_Entropy",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [152] = {
    content = 1520,
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
  [153] = {
    content = 1530,
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
      {imgId = 102, faceId = 14}
    }
  },
  [154] = {
    content = 1540,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 26, faceId = 7}
    }
  },
  [155] = {
    content = 1550,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 5}
    }
  },
  [156] = {
    content = 1560,
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
      {imgId = 26, faceId = 1}
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 26,
    contentShake = true,
    heroFace = {
      {imgId = 26, faceId = 11}
    }
  },
  [158] = {
    content = 1580,
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
  [159] = {
    content = 1590,
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
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 26
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 26
  },
  [162] = {
    content = 1620,
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
      {imgId = 30, faceId = 8}
    }
  },
  [163] = {
    content = 1630,
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
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    heroFace = {
      {imgId = 26, faceId = 9}
    }
  },
  [165] = {
    content = 1650,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 30,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [166] = {
    content = 1660,
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
    }
  },
  [167] = {
    content = 1670,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 11}
    }
  },
  [168] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 26,
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
  [169] = {
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_cg003_2",
        fullScreen = true
      }
    },
    content = 1690,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    ppv = {
      cg = {saturation = -70}
    }
  },
  [170] = {
    content = 1700,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [171] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [172] = {
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_cg003_2",
        fullScreen = true,
        delete = true
      }
    },
    content = 1720,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 30,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    ppv = {
      cg = {saturation = 0}
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [173] = {
    content = 1730,
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
      {imgId = 26, faceId = 7}
    }
  },
  [174] = {
    content = 1740,
    contentType = 3,
    speakerHeroId = 26,
    nextId = 601
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 26,
    contentShake = true,
    imgTween = {
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
      {imgId = 26, faceId = 9}
    }
  },
  [176] = {
    content = 1760,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [177] = {
    content = 1770,
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
      },
      {
        imgId = 30,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 8}
    }
  },
  [178] = {
    content = 1780,
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
  [179] = {
    content = 1790,
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
      {imgId = 26, faceId = 9}
    }
  },
  [180] = {
    content = 1800,
    contentType = 3,
    speakerHeroId = 26
  },
  [181] = {
    content = 1810,
    contentType = 3,
    speakerHeroId = 26
  },
  [182] = {
    content = 1820,
    contentType = 3,
    speakerHeroId = 1002,
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
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 6}
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 26, faceId = 11}
    }
  },
  [184] = {
    content = 1840,
    contentType = 3,
    speakerHeroId = 2,
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
        isDark = true
      },
      {
        imgId = 30,
        delay = 0.4,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 30,
        delay = 0.8,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 14}
    }
  },
  [185] = {
    content = 1850,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 30,
        delay = 0.2,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 30,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [186] = {
    content = 1860,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [187] = {
    content = 1870,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 9}
    }
  },
  [188] = {
    content = 1880,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.15,
          1.15,
          1.15
        }
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.75
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Slime_Movement",
        sheet = "AVG"
      }
    }
  },
  [189] = {
    content = 1890,
    contentType = 3,
    speakerHeroId = 26
  },
  [190] = {
    content = 1900,
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
      {imgId = 30, faceId = 8}
    }
  },
  [191] = {
    content = 1910,
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
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [192] = {
    content = 1920,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
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
      {imgId = 26, faceId = 11}
    }
  },
  [193] = {
    content = 1930,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      },
      {
        imgId = 5,
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
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [194] = {
    content = 1940,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 26,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 9}
    }
  },
  [195] = {
    content = 1950,
    contentType = 3,
    speakerHeroId = 2,
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
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [196] = {
    content = 1960,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 999,
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
      {imgId = 102, faceId = 6}
    }
  },
  [197] = {
    content = 1970,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 102,
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
    }
  },
  [198] = {
    content = 1980,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 7}
    }
  },
  [199] = {
    content = 1990,
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
  [200] = {
    images = {
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg007",
        fullScreen = true
      }
    },
    content = 2000,
    contentType = 2,
    imgTween = {
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
        alpha = 0
      },
      {
        imgId = 4,
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [201] = {
    content = 2010,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 26,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 1}
    }
  },
  [202] = {
    images = {
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg007",
        fullScreen = true,
        delete = true
      }
    },
    content = 2020,
    contentType = 3,
    speakerHeroId = 26,
    heroFace = {
      {imgId = 26, faceId = 11}
    }
  },
  [203] = {
    content = 2030,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
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
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [204] = {
    content = 2040,
    contentType = 4,
    speakerName = 14,
    isEnd = true
  },
  [601] = {
    content = 1741,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 175
  }
}
return AvgCfg_24summer_s06
