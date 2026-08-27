local AvgCfg_cpt_bonneville_02_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
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
        imgPath = "cpt00/cpt00_e_bg028",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg009_2",
        fullScreen = true
      },
      {
        imgId = 184,
        imgType = 3,
        alpha = 0,
        imgPath = "bonneville_avg"
      },
      {
        imgId = 253,
        imgType = 3,
        alpha = 0,
        imgPath = "serper_avg"
      },
      {
        imgId = 254,
        imgType = 3,
        alpha = 0,
        imgPath = "gentle_avg"
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
        imgId = 1,
        delay = 0.6,
        duration = 0.1,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.9,
        duration = 0.1,
        shake = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Sector_Burbank",
        sheet = "Mus_EV3_Sector_Burbank",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.1,
        shake = true
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 13,
    contentShake = true
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 13,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.1,
        shake = true
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_engine_speedup",
        sheet = "AVG_gf"
      }
    }
  },
  [10] = {content = 100, contentType = 2},
  [11] = {content = 110, contentType = 2},
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 1}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 0}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 253,
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 253, faceId = 1}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
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
      {imgId = 184, faceId = 4}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 3}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 5}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1084
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1084,
    heroFace = {
      {imgId = 184, faceId = 7}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 3}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 0}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 1}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 2}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 2}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 7}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 3}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 253
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 2}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 7}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 0}
    }
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 5}
    }
  },
  [35] = {
    audio = {
      bgm = {stop = true}
    },
    autoContinue = true,
    imgTween = {
      {
        imgId = 184,
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
  [36] = {content = 360, contentType = 1},
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 253,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 1}
    }
  },
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 14
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 15,
    contentShake = true,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [42] = {content = 420, contentType = 2},
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 253,
    contentShake = true,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 254,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 254,
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
    speakerHeroId = 254
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 254
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 254,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 254,
    contentShake = true
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 0}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 254,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 1}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 254,
    contentShake = true,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 254,
    contentShake = true
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.2,
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
      sfx = {
        cue = "Atk_Snooper_Hit",
        sheet = "Mon_Snooper"
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 254,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 253,
    imgTween = {
      {
        imgId = 254,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 253,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 253, faceId = 4}
    }
  },
  [59] = {
    content = 590,
    contentType = 2,
    imgTween = {
      {
        imgId = 253,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [60] = {content = 600, contentType = 2},
  [61] = {
    autoContinue = true,
    imgTween = {
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
  [62] = {
    content = 620,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
    }
  },
  [63] = {content = 630, contentType = 2},
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1084,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 184, faceId = 5}
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 184,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 1,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  }
}
return AvgCfg_cpt_bonneville_02_01
