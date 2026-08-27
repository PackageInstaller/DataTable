local AvgCfg_cpt_yelena_03_02 = {
  [1] = {
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg004_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg057_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg001_4",
        fullScreen = true
      },
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg"
      },
      {
        imgId = 185,
        imgType = 3,
        alpha = 0,
        imgPath = "burbank_npc1_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.3
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.3,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.5,
        duration = 0.6,
        alpha = 0.6
      },
      {
        imgId = 1,
        delay = 2.2,
        duration = 0.3,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 193,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 193, faceId = 2}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 193,
    contentShake = true,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 193, faceId = 3}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 193, faceId = 2}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    contentShake = true
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [19] = {content = 190, contentType = 2},
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1071,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 171,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 171, faceId = 5}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        comm = true
      },
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg",
        delete = true
      }
    },
    contentShake = true,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        delete = true
      }
    },
    contentShake = true,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0.6,
        duration = 0.3,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 13,
    images = {
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg",
        comm = true
      },
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 171, faceId = 4},
      {imgId = 174, faceId = 6}
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 311,
    contentShake = true,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg",
        delete = true
      },
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 193, faceId = 1}
    }
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 13,
    images = {
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg"
      },
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg"
      }
    },
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 1.2,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 171,
        delay = 1.2,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 171, faceId = 0},
      {imgId = 174, faceId = 5}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1071,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 193, faceId = 2}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 171, faceId = 5}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    images = {
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 6}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1071,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 171, faceId = 5}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1071,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 171, faceId = 9}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1071,
    speakerHeroPosId = 3
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1074,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 193,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 193,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [53] = {
    autoContinue = true,
    isEnd = true,
    images = {
      {
        imgId = 193,
        imgType = 3,
        alpha = 0,
        imgPath = "boy_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_cpt_yelena_03_02
