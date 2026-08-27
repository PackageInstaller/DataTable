local AvgCfg_cpt_jiangyu_03_04 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg057",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg003_2",
        fullScreen = true
      },
      {
        imgId = 172,
        imgType = 3,
        alpha = 0,
        imgPath = "jiangyu_avg"
      },
      {
        imgId = 188,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_spring_avg"
      },
      {
        imgId = 185,
        imgType = 3,
        alpha = 0,
        imgPath = "burbank_npc1_avg"
      }
    },
    audio = {
      bgm = {stop = true}
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
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 100}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 188,
    heroFace = {
      {imgId = 188, faceId = 100}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 188,
    heroFace = {
      {imgId = 188, faceId = 100}
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [8] = {
    autoContinue = true,
    imgTween = {
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
  [9] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 90,
    contentType = 3,
    speakerHeroId = 188,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 188,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 99}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 185,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 185, faceId = 3}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 185,
    speakerHeroPosId = 3
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 188,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 188, faceId = 77}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 188,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 188, faceId = 22}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 185,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 185, faceId = 0}
    }
  },
  [15] = {
    content = 150,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 188,
    contentShake = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 44}
    }
  },
  [17] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
  [18] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 180,
    contentType = 2,
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
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 99}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 185,
    contentShake = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 185, faceId = 3}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 185
  },
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 185,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {content = 230, contentType = 2},
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 33}
    }
  },
  [25] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
  [26] = {
    content = 260,
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
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 6}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1072,
    heroFace = {
      {imgId = 172, faceId = 8}
    }
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 188,
    heroFace = {
      {imgId = 188, faceId = 22}
    }
  },
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        shake = true,
        isDark = false
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 5}
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.3,
        alpha = 0,
        isDark = false,
        scale = {
          0.8,
          0.8,
          0.8
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Magnhilda_02",
        sheet = "Chara_Magnhilda"
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.3,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.5,
        duration = 0.3,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Combat_Hits",
        sheet = "AVG_gf"
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [37] = {
    images = {
      {
        imgId = 172,
        imgType = 3,
        alpha = 0,
        imgPath = "jiangyu_avg",
        delete = true
      },
      {
        imgId = 172,
        imgType = 3,
        alpha = 0,
        imgPath = "jiangyu2_avg"
      }
    },
    content = 370,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0.5,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 0}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 188,
    audio = {
      sfx = {
        cue = "Atk_Magnhilda_02",
        sheet = "Chara_Magnhilda"
      }
    },
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 188,
        delay = 0.2,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 100}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1072,
    contentShake = true,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 2}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 188,
    audio = {
      sfx = {
        cue = "Atk_Magnhilda_02",
        sheet = "Chara_Magnhilda"
      }
    },
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.3,
        alpha = 0,
        isDark = false,
        scale = {
          0.8,
          0.8,
          0.8
        }
      },
      {
        imgId = 188,
        delay = 0.5,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 55}
    }
  },
  [41] = {
    content = 410,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.3,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.5,
        duration = 0.3,
        shake = true
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 188,
    audio = {
      sfx = {
        cue = "Atk_Magnhilda_02",
        sheet = "Chara_Magnhilda"
      }
    },
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 22}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Depressed",
        sheet = "Mus_Story_Depressed",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 188,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 188, faceId = 100}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 188,
    heroFace = {
      {imgId = 188, faceId = 55}
    }
  },
  [50] = {
    content = 500,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.6,
        scale = {
          1.3,
          1.3,
          1.3
        },
        alpha = 1,
        isDark = true
      },
      {
        imgId = 188,
        delay = 1,
        duration = 0.6,
        scale = {
          1.5,
          1.5,
          1.5
        },
        alpha = 1,
        isDark = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 188,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [52] = {
    content = 520,
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
return AvgCfg_cpt_jiangyu_03_04
