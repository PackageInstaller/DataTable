local AvgCfg_cpt_penumbra_01_03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg010",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg055",
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
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 11,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true
      },
      {
        imgId = 12,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true
      },
      {
        imgId = 183,
        imgType = 3,
        alpha = 0,
        imgPath = "penumbra_avg"
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
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
  [2] = {
    content = 20,
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
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 2,
    ppv = {
      cg = {saturation = -70}
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      }
    }
  },
  [5] = {
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    content = 50,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 11}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1083,
    heroFace = {
      {imgId = 183, faceId = 0}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    },
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
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 12
  },
  [10] = {
    content = 100,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 72,
    contentShake = true,
    images = {
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "simo_shadow2_avg"
      }
    },
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
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
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 72
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 72,
    contentShake = true,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "simo_shadow2_avg",
        delete = true
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    }
  },
  [20] = {
    content = 200,
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
      {imgId = 183, faceId = 11}
    },
    ppv = {
      cg = {saturation = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1083
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [24] = {
    content = 240,
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
  [25] = {
    content = 250,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
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
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [26] = {
    content = 260,
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
      {imgId = 183, faceId = 11}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1083
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
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
      },
      {
        imgId = 11,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      }
    }
  },
  [30] = {
    content = 300,
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
      {imgId = 183, faceId = 11}
    }
  },
  [31] = {
    content = 310,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 11,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [32] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 320,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
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
      {imgId = 101, faceId = 0}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1001
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [35] = {
    content = 350,
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
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 1,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 183,
        delay = 1.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 10}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1083
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1083,
    heroFace = {
      {imgId = 183, faceId = 2}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1083
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 183,
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
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 11
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {content = 460, contentType = 2},
  [47] = {
    content = 470,
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
        shake = true,
        isDark = false
      }
    },
    ppv = {
      cg = {saturation = 0}
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 183, faceId = 11}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1083
  },
  [49] = {
    content = 490,
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
        shake = true
      },
      {
        imgId = 11,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 12,
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
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
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
      {imgId = 183, faceId = 11}
    }
  },
  [51] = {
    content = 510,
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
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [52] = {
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    content = 520,
    contentType = 1,
    ppv = {
      cg = {saturation = -70}
    }
  },
  [53] = {
    content = 530,
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
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [54] = {
    content = 540,
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
      {imgId = 183, faceId = 0}
    }
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 11
  },
  [57] = {
    content = 570,
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
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 183,
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
      {imgId = 183, faceId = 0}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1083
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
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
      {imgId = 183, faceId = 10}
    }
  },
  [62] = {
    content = 620,
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
  [63] = {
    content = 630,
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
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [66] = {
    content = 660,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
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
  [67] = {content = 670, contentType = 2},
  [68] = {content = 680, contentType = 2},
  [69] = {content = 690, contentType = 2},
  [70] = {content = 700, contentType = 2},
  [71] = {content = 710, contentType = 2},
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.2,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.4,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.6,
        duration = 0.2,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 12,
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 2,
    ppv = {
      cg = {saturation = 0}
    }
  },
  [75] = {
    content = 750,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    images = {
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        delete = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [76] = {content = 760, contentType = 2},
  [77] = {content = 770, contentType = 2},
  [78] = {
    content = 780,
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
  [79] = {
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
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [80] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 800,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 11,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 12,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true,
        delete = true
      }
    },
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
    },
    heroFace = {
      {imgId = 183, faceId = 0}
    }
  },
  [81] = {
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
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [82] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 820,
    contentType = 4,
    speakerName = 12
  },
  [83] = {
    content = 830,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg055",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 165,
        imgType = 3,
        alpha = 0,
        imgPath = "uranus_avg"
      },
      {
        imgId = 23,
        imgType = 3,
        alpha = 0,
        imgPath = "choco_avg"
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [85] = {content = 850, contentType = 2},
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1027,
    contentShake = true,
    images = {
      {
        imgId = 127,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "zion_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 127,
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
        cue = "Mus_Story_Joy_Victory",
        sheet = "Mus_Story_Joy_Victory",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 127, faceId = 1}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1027
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 23,
    contentShake = true,
    images = {
      {
        imgId = 127,
        imgType = 3,
        alpha = 0,
        imgPath = "zion_avg",
        delete = true
      }
    },
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
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1065,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 165, faceId = 6}
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 165,
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
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 183,
        delay = 0.9,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 11}
    }
  },
  [91] = {
    content = 910,
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
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1065,
    imgTween = {
      {
        imgId = 165,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 165, faceId = 0}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1083,
    imgTween = {
      {
        imgId = 165,
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
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1083,
    heroFace = {
      {imgId = 183, faceId = 1}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1027,
    images = {
      {
        imgId = 127,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "zion_avg",
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 183,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 127,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 127, faceId = 1}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1027,
    heroFace = {
      {imgId = 127, faceId = 2}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1083,
    images = {
      {
        imgId = 127,
        imgType = 3,
        alpha = 0,
        imgPath = "zion_avg",
        delete = true
      }
    },
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
  [98] = {
    content = 980,
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
  [99] = {
    content = 990,
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
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 183, faceId = 1}
    }
  },
  [100] = {
    content = 1000,
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
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_penumbra_01_03
