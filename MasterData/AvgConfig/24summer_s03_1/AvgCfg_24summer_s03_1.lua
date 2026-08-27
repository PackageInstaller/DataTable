local AvgCfg_24summer_s03_1 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg004",
        fullScreen = true
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel2_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 26,
        imgType = 3,
        alpha = 0,
        imgPath = "beelneith_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
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
        cue = "Mus_Story_DeusExMachina",
        sheet = "Mus_Story_DeusExMachina",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [3] = {
    content = 30,
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
        shake = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "Gunfight", sheet = "AVG"}
    }
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      }
    }
  },
  [5] = {content = 50, contentType = 2},
  [6] = {
    content = 60,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [7] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 70,
    contentType = 3,
    speakerHeroId = 35,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg006_4",
        fullScreen = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg",
        delete = true
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
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
        cue = "Mus_Sector_5",
        sheet = "Mus_Sector_5",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 35
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
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
      {imgId = 35, faceId = 0}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 35,
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 4}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 1}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 4}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
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
      {imgId = 35, faceId = 3}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [27] = {
    content = 270,
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
  [28] = {
    content = 280,
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
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 35,
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
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 1}
    }
  },
  [31] = {
    autoContinue = true,
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
      cg = {saturation = 0}
    },
    content = 320,
    contentType = 2,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg006_4",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        shake = true,
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
      },
      sfx = {
        cue = "AVG_rifle_finalshot_h",
        sheet = "AVG_gf"
      }
    }
  },
  [33] = {
    content = 330,
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
        imgId = 30,
        delay = 0.6,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [35] = {
    autoContinue = true,
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
  [36] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 360,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg006_4",
        fullScreen = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg",
        delete = true
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
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
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 35,
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
      {imgId = 35, faceId = 3}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 0}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 30,
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 5}
    }
  },
  [48] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 35,
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
  [49] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 490,
    contentType = 3,
    speakerHeroId = 30,
    images = {
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        delete = true
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
        delay = 0.6,
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
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [50] = {
    content = 500,
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
        shake = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
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
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [53] = {
    content = 530,
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
      sfx = {
        cue = "AVG_rifle_finalshot_h",
        sheet = "AVG_gf"
      }
    }
  },
  [54] = {
    bgColor = 3,
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true,
        shakeIntensity = 4
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 35,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
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
    }
  },
  [58] = {
    bgColor = 2,
    autoContinue = true,
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
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [59] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 590,
    contentType = 3,
    speakerHeroId = 30,
    images = {
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg",
        delete = true
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
      {imgId = 30, faceId = 1}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 11}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 35,
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 4}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 0}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 30
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 2}
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 1}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 2}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 30,
    contentShake = true,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 30,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV22Summer_Story_Fall",
        sheet = "Mus_EV22Summer_Story_Fall",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 35,
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
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 35,
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 4}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [82] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 1,
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
  [83] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 830,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    images = {
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 35,
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
      {imgId = 30, faceId = 9}
    }
  },
  [85] = {
    autoContinue = true,
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
  [86] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 860,
    contentType = 3,
    speakerHeroId = 35,
    images = {
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg",
        delete = true
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [87] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 35,
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
  [88] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 880,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 1,
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
    heroFace = {
      {imgId = 30, faceId = 10}
    }
  },
  [89] = {
    autoContinue = true,
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
  [90] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 900,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [91] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [92] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 920,
    contentType = 3,
    speakerHeroId = 30,
    imgTween = {
      {
        imgId = 1,
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
    }
  },
  [93] = {
    autoContinue = true,
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
  [94] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 940,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 35,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 5}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 35,
    contentShake = true,
    imgTween = {
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
      {imgId = 35, faceId = 3}
    }
  },
  [96] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 35,
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
  [97] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 970,
    contentType = 2,
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_cg001",
        fullScreen = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg"
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        delete = true
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "Atk_Gabrie_01",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [99] = {content = 990, contentType = 2},
  [100] = {content = 1000, contentType = 2},
  [101] = {
    content = 1010,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 12
  },
  [103] = {
    content = 1030,
    contentType = 4,
    speakerName = 11
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 12
  },
  [105] = {
    content = 1050,
    contentType = 4,
    speakerName = 11
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 12
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 11
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11
  },
  [109] = {
    content = 1090,
    contentType = 4,
    speakerName = 12,
    bgColor = 3
  },
  [110] = {
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
  [111] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 1110,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg006_4",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_b_avg",
        delete = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg",
        order = 3
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg",
        order = 4
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
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
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 103, faceId = 3}
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 103,
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
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [114] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [115] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1150,
    contentType = 4,
    speakerName = 12,
    images = {
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 11
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 12
  },
  [118] = {
    content = 1180,
    contentType = 4,
    speakerName = 11
  },
  [119] = {
    content = 1190,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 2,
        alpha = 0
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_Scene"
      }
    }
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 12
  },
  [121] = {content = 1210, contentType = 2},
  [122] = {
    content = 1220,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.6,
        alpha = 0.5,
        isDark = false
      },
      {
        imgId = 35,
        delay = 2,
        duration = 1,
        alpha = 0,
        isDark = false,
        dissolve = true
      }
    },
    heroFace = {
      {imgId = 35, faceId = 5}
    }
  },
  [123] = {
    content = 1230,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    effect = {
      stopList = {"effect1"}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [124] = {
    content = 1240,
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
      {imgId = 30, faceId = 8}
    }
  },
  [125] = {
    bgColor = 2,
    content = 1250,
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
        duration = 1,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Tiphares_Inner",
        sheet = "Mus_Story_Tiphares_Inner",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 2,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 26,
        delay = 0,
        duration = 1,
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
      {imgId = 26, faceId = 7}
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 26,
    imgTween = {
      {
        imgId = 26,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 26, faceId = 0}
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 26,
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
    }
  }
}
return AvgCfg_24summer_s03_1
