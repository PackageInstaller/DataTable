local AvgCfg_cpt_penumbra_03_02 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg002",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg005",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg046_3",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      },
      {
        imgId = 23,
        imgType = 3,
        alpha = 0,
        imgPath = "choco_avg"
      },
      {
        imgId = 183,
        imgType = 3,
        alpha = 0,
        imgPath = "penumbra_avg"
      },
      {
        imgId = 43,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotred_avg"
      },
      {
        imgId = 44,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotyellow_avg"
      },
      {
        imgId = 45,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotgreen_avg"
      },
      {
        imgId = 165,
        imgType = 3,
        alpha = 0,
        imgPath = "uranus_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
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
      {imgId = 183, faceId = 2}
    }
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 43,
    speakerHeroPosId = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 45,
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
    speakerHeroId = 45,
    speakerHeroPosId = 3,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 44,
    speakerHeroPosId = 3,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 44, faceId = 2}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 43,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 45,
    speakerHeroPosId = 3,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 45, faceId = 3}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 44,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 44, faceId = 6}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 1}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 45,
    speakerHeroPosId = 3,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 45, faceId = 1}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 43,
    speakerHeroPosId = 1,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 43, faceId = 4}
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    imgTween = {
      {
        imgId = 43,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 45,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [18] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [19] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 190,
    contentType = 3,
    speakerHeroId = 1065,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 165,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 165,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 183,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 165, faceId = 3}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 165,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 183, faceId = 8}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1065,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 165,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 165, faceId = 1}
    }
  },
  [22] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 165,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1065,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 165,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 165,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 165, faceId = 3}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1065,
    contentShake = true
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1065,
    heroFace = {
      {imgId = 165, faceId = 1}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1065,
    imgTween = {
      {
        imgId = 165,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [27] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 165,
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
  [28] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 280,
    contentType = 3,
    speakerHeroId = 1083,
    images = {
      {
        imgId = 92,
        imgType = 3,
        alpha = 0,
        imgPath = "spacebot_01_avg"
      },
      {
        imgId = 43,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotred_avg",
        delete = true
      },
      {
        imgId = 44,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotyellow_avg",
        delete = true
      },
      {
        imgId = 45,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotgreen_avg",
        delete = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_cg045",
        fullScreen = true
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_2",
        fullScreen = true
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
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [30] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [31] = {content = 310, contentType = 1},
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 23, faceId = 1}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 23,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 5}
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 23,
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
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 3}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 23,
    contentShake = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 7}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 23,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 8}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 183, faceId = 2}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 5}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 23, faceId = 0}
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 23,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 1}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 5}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 23,
    contentShake = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [47] = {content = 470, contentType = 2},
  [48] = {content = 480, contentType = 2},
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 23,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [50] = {
    content = 500,
    contentType = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 92,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        isDark = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 5}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 4}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 23,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 1,
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
      {imgId = 23, faceId = 1}
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1083,
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 2}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 5}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 183, faceId = 2}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 23, faceId = 6}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1083,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 9}
    }
  },
  [63] = {
    content = 630,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.6,
        alpha = 0.5,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0.8,
        duration = 0.6,
        posId = 4,
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
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 5}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 2}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 5}
    }
  },
  [67] = {
    content = 670,
    contentType = 2,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0.5,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 8}
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.7,
        duration = 0.6,
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
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0.5,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1083
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
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
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [74] = {content = 740, contentType = 2},
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1083,
    contentShake = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0.5,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 5}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1083
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 92, faceId = 2}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 4}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 0}
    }
  },
  [85] = {
    content = 850,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
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
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
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
      {imgId = 92, faceId = 0}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 4}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    heroFace = {
      {imgId = 92, faceId = 7}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [94] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 183,
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
  [95] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 950,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 14
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 15
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 14
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 13
  },
  [100] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 183,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 11
  },
  [103] = {
    content = 1030,
    contentType = 4,
    speakerName = 11
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 5}
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1083,
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1083
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      }
    }
  },
  [108] = {autoContinue = true},
  [109] = {
    content = 1090,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 183,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11
  },
  [111] = {
    content = 1110,
    contentType = 4,
    speakerName = 11
  },
  [112] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [113] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1130,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 183,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 0}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1083
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 0}
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 2}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 1083
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1083
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1083,
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
      {imgId = 183, faceId = 4}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 1}
    }
  },
  [122] = {
    content = 1220,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
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
    speakerHeroId = 92,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 92, faceId = 1}
    }
  },
  [124] = {
    content = 1240,
    contentType = 2,
    imgTween = {
      {
        imgId = 92,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
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
    }
  },
  [126] = {content = 1260, contentType = 2},
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 12
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 12
  },
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 12
  },
  [130] = {content = 1300, contentType = 2},
  [131] = {content = 1310, contentType = 2},
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 12
  },
  [133] = {content = 1330, contentType = 2},
  [134] = {
    content = 1340,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_penumbra_03_02
