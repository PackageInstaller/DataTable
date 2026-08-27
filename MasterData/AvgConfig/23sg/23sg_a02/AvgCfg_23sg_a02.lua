local AvgCfg_23sg_a02 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 4500102,
    contentStyle = 1,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg004",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        order = 4
      },
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        imgPath = "okabe_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg016_1",
        fullScreen = true
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
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_tinnitus",
        sheet = "AVG_gf"
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.1
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {
    content = 60,
    contentType = 1,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        sheet = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [7] = {content = 70, contentType = 2},
  [8] = {content = 80, contentType = 2},
  [9] = {content = 90, contentType = 1},
  [10] = {content = 100, contentType = 1},
  [11] = {content = 110, contentType = 2},
  [12] = {content = 120, contentType = 1},
  [13] = {content = 130, contentType = 2},
  [14] = {content = 140, contentType = 2},
  [15] = {content = 150, contentType = 2},
  [16] = {
    content = 160,
    contentType = 1,
    nextId = 18
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.8,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 3,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 0.1
      }
    }
  },
  [20] = {content = 200, contentType = 2},
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img07_Giwaku1",
        sheet = "Mus_SteinsGate_img07_Giwaku1",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 4,
    speakerName = 11
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 241,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
  [28] = {content = 280, contentType = 2},
  [29] = {content = 290, contentType = 2},
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1,
    speakerHeroPosId = 1,
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
  [31] = {
    content = 310,
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
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 22222,
    contentShake = true,
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
      {imgId = 999, faceId = 12}
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    sgMobile = {showSgMobile = true}
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 11
  },
  [38] = {content = 380, contentType = 2},
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 22222,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 12}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 227,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.8,
        posId = 1,
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
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
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
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {content = 460, contentType = 2},
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11
  },
  [49] = {
    content = 490,
    contentType = 2,
    sgMobile = {showSgMobile = false}
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img15_Hack -alpha vision-",
        sheet = "Mus_SteinsGate_img15_Hack -alpha vision-",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 1,
        pos = {
          -100,
          0,
          0
        },
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 2,
    contentShake = true
  },
  [56] = {content = 560, contentType = 2},
  [57] = {
    content = 570,
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
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Door_Open_Close",
        sheet = "AVG_gf"
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
    imgTween = {
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
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 202,
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
        cue = "Mus_SteinsGate_img26_Human community",
        sheet = "Mus_SteinsGate_img26_Human community",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [59] = {
    content = 590,
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
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    contentShake = true,
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [63] = {
    content = 630,
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
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
      {imgId = 202, faceId = 7}
    }
  },
  [65] = {
    content = 650,
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
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    contentShake = true,
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
      {imgId = 202, faceId = 4}
    }
  },
  [67] = {
    content = 670,
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
    }
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 2002,
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
        imgId = 202,
        delay = 0.5,
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
  [70] = {
    content = 700,
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
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 11
  },
  [72] = {
    content = 720,
    contentType = 4,
    speakerName = 11
  },
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [76] = {content = 760, contentType = 2},
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 202,
        delay = 1.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [78] = {
    content = 780,
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
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 11
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [81] = {content = 810, contentType = 2},
  [82] = {
    content = 820,
    contentType = 4,
    speakerName = 11
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 11
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 2002,
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
  [87] = {
    content = 870,
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
      {imgId = 202, faceId = 4}
    }
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 11,
    nextId = 90
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    },
    heroFace = {
      {imgId = 202, faceId = 2}
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    }
  },
  [92] = {autoContinue = true},
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        pos = {
          0,
          0,
          0
        },
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
        imgId = 202,
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
        imgId = 202,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img15_Hack -alpha vision-",
        sheet = "Mus_SteinsGate_img15_Hack -alpha vision-",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [94] = {
    content = 940,
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
    }
  },
  [95] = {
    content = 950,
    contentType = 4,
    speakerName = 11
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 222222,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 222222,
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [98] = {
    content = 980,
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
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
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
      {imgId = 202, faceId = 5}
    }
  },
  [100] = {
    content = 1000,
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
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [104] = {
    content = 1040,
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
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
  [106] = {
    content = 1060,
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
    }
  },
  [107] = {
    content = 1070,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [108] = {content = 1080, contentType = 2},
  [109] = {content = 1090, contentType = 2},
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 2002,
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
      {imgId = 202, faceId = 3}
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 1}
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 1}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 2}
    }
  },
  [114] = {
    content = 1140,
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
  [115] = {
    content = 1150,
    contentType = 4,
    speakerName = 11
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
      {imgId = 202, faceId = 0}
    }
  },
  [117] = {
    content = 1170,
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
    }
  },
  [118] = {
    content = 1180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [119] = {content = 1190, contentType = 2},
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
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
      {imgId = 201, faceId = 1}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img17_Network battle",
        sheet = "Mus_SteinsGate_img17_Network battle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 3}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 1}
    },
    contentShake = true
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 2002,
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
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 202,
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
      {imgId = 999, faceId = 12}
    }
  },
  [126] = {
    content = 1260,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [127] = {
    content = 1270,
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
      {imgId = 101, faceId = 4}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img22_Walking on sleeping",
        sheet = "Mus_SteinsGate_img22_Walking on sleeping",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
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
  [131] = {
    content = 1310,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 11
  },
  [133] = {
    content = 1330,
    contentType = 4,
    speakerName = 11
  },
  [134] = {
    content = 1340,
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
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img15_Hack -alpha vision-",
        sheet = "Mus_SteinsGate_img15_Hack -alpha vision-",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    contentShake = true,
    heroFace = {
      {imgId = 202, faceId = 0}
    }
  },
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [139] = {
    content = 1390,
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
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [140] = {
    content = 1400,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img22_Walking on sleeping",
        sheet = "Mus_SteinsGate_img22_Walking on sleeping",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [141] = {
    content = 1410,
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
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
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
      {imgId = 202, faceId = 0}
    }
  },
  [143] = {
    content = 1430,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
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
  [145] = {
    content = 1450,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
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
      {imgId = 999, faceId = 9}
    }
  },
  [146] = {
    content = 1460,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
      {imgId = 101, faceId = 0}
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 999, faceId = 3}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 999,
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
      {imgId = 999, faceId = 1}
    }
  },
  [150] = {
    content = 1500,
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
  [151] = {
    content = 1510,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [152] = {
    content = 1520,
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
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img05_FGL",
        sheet = "Mus_SteinsGate_img05_FGL",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 9}
    }
  },
  [153] = {
    content = 1530,
    contentType = 4,
    speakerName = 11
  },
  [154] = {
    content = 1540,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [155] = {
    content = 1550,
    contentType = 4,
    speakerName = 11
  },
  [156] = {
    content = 1560,
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
      {imgId = 999, faceId = 9}
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 4,
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
      {imgId = 202, faceId = 1}
    }
  },
  [159] = {
    content = 1590,
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
    }
  },
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 2}
    }
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [162] = {
    content = 1620,
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
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  }
}
return AvgCfg_23sg_a02
