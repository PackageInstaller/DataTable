local AvgCfg_24carnival_s00 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 5600101,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_bg005",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        order = 4,
        imgPath = "cpt10/cpt10_e_bg005f",
        imgPathBoy = "cpt10/cpt10_e_bg005m",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 110,
        imgType = 3,
        alpha = 0,
        imgPath = "sangoma_avg"
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.2,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1.6,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {content = 20, contentType = 1},
  [3] = {content = 30, contentType = 1},
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 5,
        delay = 2,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 4,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 4,
        duration = 0,
        alpha = 0
      }
    }
  },
  [7] = {content = 70, contentType = 1},
  [8] = {autoContinue = true},
  [9] = {content = 90, contentType = 1},
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 11
  },
  [12] = {
    content = 120,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {content = 140, contentType = 2},
  [15] = {content = 150, contentType = 2},
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1051,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Retainer",
        sheet = "Mus_Story_Retainer",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 151, faceId = 0}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 3}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 11
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 1}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [22] = {
    content = 220,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1051,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 5}
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 1}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 2}
    }
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 11
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1051,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 5}
    }
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
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
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
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
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1051
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
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
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 8}
    }
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
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
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 1}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 3}
    }
  },
  [46] = {
    content = 460,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [49] = {content = 490, contentType = 2},
  [50] = {
    content = 500,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Retainer2",
        sheet = "Mus_Story_Retainer2",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [53] = {
    content = 530,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1051,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1051,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [64] = {
    content = 640,
    contentType = 2,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1051,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 151, faceId = 5}
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
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
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [68] = {
    content = 680,
    contentType = 2,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 7}
    }
  },
  [70] = {
    content = 700,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1051,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [72] = {
    content = 720,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Retainer2",
        sheet = "Mus_Story_Retainer2",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1051,
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [75] = {
    content = 750,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 110,
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
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 1051,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "delacey_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1051,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1100,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
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
    speakerHeroId = 1100,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1100,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 151, faceId = 1}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1100,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 3}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1100,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 6}
    }
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 0}
    }
  },
  [92] = {
    content = 920,
    contentType = 2,
    images = {
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg",
        delete = true
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
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 11}
    }
  },
  [95] = {
    content = 950,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Eosphorus",
        sheet = "Mus_EV3_Story_Eosphorus",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1100
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [99] = {content = 990, contentType = 2},
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 8}
    }
  },
  [102] = {
    content = 1020,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [107] = {content = 1070, contentType = 2},
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [109] = {
    content = 1090,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [112] = {
    content = 1120,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [114] = {
    content = 1140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [115] = {
    content = 1150,
    contentType = 4,
    speakerName = 11
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Retainer2",
        sheet = "Mus_Story_Retainer2",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [119] = {
    content = 1190,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
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
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [122] = {
    content = 1220,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
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
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [124] = {
    content = 1240,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [129] = {
    content = 1290,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 1100
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 1100
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1100
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
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
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [135] = {
    content = 1350,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 4,
    speakerName = 11
  },
  [137] = {
    content = 1370,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 11
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
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
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [140] = {
    content = 1400,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [141] = {
    content = 1410,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [142] = {
    content = 1420,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 4,
    speakerName = 11
  },
  [145] = {content = 1450, contentType = 2},
  [146] = {
    content = 1460,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [147] = {
    content = 1470,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
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
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    }
  },
  [148] = {
    content = 1480,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        shake = true
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_AVG_Hit-knife",
        pos = {
          -250,
          0,
          0
        }
      }
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
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
        imgId = 110,
        delay = 0,
        duration = 0.2,
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
      }
    },
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [152] = {
    content = 1520,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [153] = {
    content = 1530,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [154] = {
    content = 1540,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [156] = {
    content = 1560,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [159] = {
    content = 1590,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [160] = {content = 1600, contentType = 2},
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [162] = {
    content = 1620,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [165] = {
    content = 1650,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [166] = {
    content = 1660,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
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
    speakerHeroId = 1100
  },
  [168] = {
    content = 1680,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [169] = {
    content = 1690,
    contentType = 3,
    speakerHeroId = 1001,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [170] = {
    content = 1700,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 3}
    }
  },
  [171] = {
    content = 1710,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 2}
    }
  },
  [172] = {
    content = 1720,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [173] = {
    content = 1730,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [174] = {
    content = 1740,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [176] = {
    content = 1760,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [177] = {
    content = 1770,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [178] = {
    content = 1780,
    contentType = 3,
    speakerHeroId = 1100
  },
  [179] = {
    content = 1790,
    contentType = 3,
    speakerHeroId = 1001,
    contentShake = true,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [180] = {
    content = 1800,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [181] = {
    content = 1810,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [182] = {
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1821, jumpAct = 183},
      {content = 1822, jumpAct = 184}
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    },
    nextId = 185
  },
  [184] = {
    content = 1840,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 11}
    }
  },
  [185] = {
    content = 1850,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [186] = {
    content = 1860,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 12}
    }
  },
  [187] = {
    content = 1870,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [188] = {
    content = 1880,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [189] = {
    content = 1890,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [190] = {
    content = 1900,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 8}
    }
  },
  [191] = {
    content = 1910,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [192] = {
    content = 1920,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
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
  [193] = {content = 1930, contentType = 2},
  [194] = {content = 1940, contentType = 2},
  [195] = {
    content = 1950,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 110,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 8}
    }
  },
  [196] = {
    content = 1960,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [197] = {
    content = 1970,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 6}
    }
  },
  [198] = {
    content = 1980,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [199] = {
    content = 1990,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [200] = {content = 2000, contentType = 2},
  [201] = {
    content = 2010,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Eosphorus",
        sheet = "Mus_EV3_Story_Eosphorus",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 110, faceId = 1}
    }
  },
  [202] = {
    content = 2020,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [203] = {
    content = 2030,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
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
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [204] = {
    content = 2040,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [205] = {
    content = 2050,
    contentType = 4,
    speakerName = 11
  },
  [206] = {
    content = 2060,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 3}
    }
  },
  [207] = {
    content = 2070,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [208] = {content = 2080, contentType = 2},
  [209] = {
    content = 2090,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -550,
          0
        },
        scale = {
          1.4,
          1.4,
          1.4
        }
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [210] = {
    content = 2100,
    contentType = 3,
    speakerHeroId = 1100,
    heroFace = {
      {imgId = 110, faceId = 11}
    }
  },
  [211] = {
    content = 2110,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [212] = {content = 2120, contentType = 2},
  [213] = {
    content = 2130,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 5}
    }
  },
  [214] = {
    content = 2140,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
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
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 2,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [215] = {
    content = 2150,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [216] = {
    content = 2160,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    }
  },
  [217] = {
    content = 2170,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 110,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 0}
    }
  },
  [218] = {
    content = 2180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [219] = {
    content = 2190,
    contentType = 4,
    speakerName = 11
  },
  [220] = {
    content = 2200,
    contentType = 3,
    speakerHeroId = 1100,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 110, faceId = 10}
    }
  },
  [221] = {
    content = 2210,
    contentType = 3,
    speakerHeroId = 1100
  },
  [222] = {
    content = 2220,
    contentType = 2,
    imgTween = {
      {
        imgId = 110,
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
  [223] = {
    content = 2230,
    contentType = 4,
    speakerName = 12
  },
  [224] = {
    content = 2240,
    contentType = 4,
    speakerName = 12
  }
}
return AvgCfg_24carnival_s00
