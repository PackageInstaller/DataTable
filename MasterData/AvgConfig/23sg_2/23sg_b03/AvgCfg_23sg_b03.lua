local AvgCfg_23sg_b03 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 4500114,
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      },
      {
        imgId = 603,
        imgType = 3,
        alpha = 0,
        imgPath = "ruka_avg"
      },
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        imgPath = "okabe_avg"
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 1
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tinnitus",
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
        duration = 0.6,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.5,
        duration = 1,
        alpha = 1
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    autoContinue = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg007_2",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "summer/summer_e_bg010",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
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
        isDark = true
      },
      {
        imgId = 10,
        delay = 0.6,
        duration = 0.6,
        alpha = 0.5
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 10,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.2,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img24_hesitative consideration",
        sheet = "Mus_SteinsGate_img24_hesitative consideration",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg007_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "summer/summer_e_bg010",
        fullScreen = true,
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true,
        isDark = true
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.85,
        shake = true,
        shakeIntensity = 4
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img31_Solitude",
        sheet = "Mus_SteinsGate_img31_Solitude",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {cue = "AVG_Rope", sheet = "AVG_gf"}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 11
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [20] = {content = 200, contentType = 2},
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [25] = {
    autoContinue = true,
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_cg003_2",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
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
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0.6,
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
        imgId = 202,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 2002,
    images = {
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_cg003_2",
        fullScreen = true,
        delete = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [31] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 202,
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
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img11_kako",
        sheet = "Mus_SteinsGate_img11_kako",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 11,
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
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 603,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 603,
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
    speakerHeroId = 603,
    contentShake = true,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 603, faceId = 2}
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 603,
    contentShake = true,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 603, faceId = 0}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 603,
    heroFace = {
      {imgId = 603, faceId = 1}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 603,
    heroFace = {
      {imgId = 603, faceId = 2}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 603,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 603,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 603, faceId = 2}
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 603,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 603,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
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
      {imgId = 999, faceId = 0}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 11}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [52] = {
    autoContinue = true,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg007_2",
        fullScreen = true
      },
      {
        imgId = 13,
        imgType = 3,
        alpha = 0,
        imgPath = "riko_b2_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 13,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 2,
    imgTween = {
      {
        imgId = 13,
        delay = 0.6,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    contentShake = true
  },
  [55] = {
    content = 550,
    contentType = 2,
    contentShake = true
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 2001,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 8}
    }
  },
  [58] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 201,
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
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_9",
        fullScreen = true
      }
    },
    imgTween = {
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
        cue = "Mus_SteinsGate_img26_Human community",
        sheet = "Mus_SteinsGate_img26_Human community",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 2,
    sgMobile = {showSgMobile = true}
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 11
  },
  [62] = {
    content = 620,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [65] = {
    content = 650,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 11
  },
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 11
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 11
  },
  [72] = {
    content = 720,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 9}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [78] = {
    content = 780,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
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
    speakerHeroId = 2003,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
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
  [84] = {
    content = 840,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    sgMobile = {showSgMobile = false},
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img04_Theme_full",
        sheet = "Mus_SteinsGate_img04_Theme_full",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [85] = {content = 850, contentType = 2},
  [86] = {
    content = 860,
    contentType = 4,
    speakerName = 11
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 11
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [92] = {content = 920, contentType = 2},
  [93] = {content = 930, contentType = 2},
  [94] = {content = 940, contentType = 2},
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 2001,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  }
}
return AvgCfg_23sg_b03
