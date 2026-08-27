local AvgCfg_cpt_haze_06_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg020",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_cg007",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_cg007_2",
        fullScreen = true,
        order = 3
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_cg007_3",
        fullScreen = true,
        order = 4
      },
      {
        imgId = 158,
        imgType = 3,
        alpha = 0,
        imgPath = "haze_avg"
      },
      {
        imgId = 105,
        imgType = 3,
        alpha = 0,
        imgPath = "croque_avg",
        rot = {
          0,
          180,
          0
        }
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
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Dorm",
        sheet = "Mus_Dorm",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 41,
    contentShake = true
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 105,
        delay = 1,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 6}
    }
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 91,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 41,
    contentShake = true
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {stop = true}
    }
  },
  [12] = {content = 120, contentType = 2},
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 12,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 158, faceId = 6}
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1058,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 158, faceId = 8}
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1058,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1058,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 158, faceId = 6}
    }
  },
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 2,
    heroFace = {
      {imgId = 158, faceId = 8}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1058,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [24] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 158,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
      bgm = {stop = true},
      sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
    }
  },
  [25] = {content = 250, contentType = 2},
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 12
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 11
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [29] = {
    content = 290,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_Broken_Glass",
        sheet = "AVG_gf"
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 12
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 11
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 12
  },
  [33] = {content = 330, contentType = 2},
  [34] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 2,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11
  },
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 12
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 12
  },
  [38] = {content = 380, contentType = 2},
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 11
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 12
  },
  [41] = {content = 410, contentType = 2},
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 12
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 12
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11
  },
  [47] = {content = 470, contentType = 2},
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 12
  },
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 11
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 12
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 12
  },
  [52] = {
    branch = {
      {content = 521, jumpAct = 53},
      {content = 522, jumpAct = 54},
      {content = 523, jumpAct = 55}
    }
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    nextId = 56
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    nextId = 56
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 12
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 12
  },
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 12
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 11
  },
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 12
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 12
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 12
  },
  [65] = {
    branch = {
      {content = 651, jumpAct = 66},
      {content = 652, jumpAct = 67}
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 12,
    nextId = 68
  },
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 12,
    nextId = 68
  },
  [68] = {content = 680, contentType = 2},
  [69] = {content = 690, contentType = 2},
  [70] = {
    content = 700,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [71] = {content = 710, contentType = 2}
}
return AvgCfg_cpt_haze_06_01
