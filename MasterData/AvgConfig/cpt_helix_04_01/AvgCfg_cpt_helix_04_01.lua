local AvgCfg_cpt_helix_04_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg008_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg010",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg004",
        fullScreen = true
      },
      {
        imgId = 44,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotred_avg"
      },
      {
        imgId = 116,
        imgType = 3,
        alpha = 0,
        imgPath = "banxsy_avg"
      },
      {
        imgId = 161,
        imgType = 3,
        alpha = 0,
        imgPath = "helix_avg"
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg026",
        fullScreen = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 43,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 44,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
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
        fadeOut = 3
      },
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    },
    heroFace = {
      {imgId = 44, faceId = 5}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [7] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
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
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 116,
        delay = 0.6,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "AVG_BaseDoor_Open",
        sheet = "AVG_gf"
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 2}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 43,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 44, faceId = 4}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 2}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 43,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [25] = {
    content = 250,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 4}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [33] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 116,
        delay = 0.6,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 161, faceId = 1}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 4}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 4}
    }
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 4}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 4}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [52] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    },
    nextId = 54
  },
  [54] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 540,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 116,
        delay = 0.6,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [56] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [57] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 570,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 116,
        delay = 0.6,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
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
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0},
      {imgId = 161, faceId = 4}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [64] = {
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    },
    nextId = 69
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 116,
        delay = 0.6,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 161, faceId = 1}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_helix_04_01
