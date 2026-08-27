local AvgCfg_22white_rise = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg022",
        fullScreen = true
      },
      {
        imgId = 149,
        imgType = 3,
        alpha = 0,
        imgPath = "rise_avg"
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "pola/p_rise",
        scale = {
          1.6,
          1.6,
          1.6
        }
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
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
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 0}
    }
  },
  [8] = {
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 81, jumpAct = 9},
      {content = 82, jumpAct = 10}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    },
    nextId = 11
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        fadeOut = 3
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 0}
    }
  },
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [21] = {
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 211, jumpAct = 22},
      {content = 212, jumpAct = 23}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    },
    nextId = 24
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [24] = {
    content = 240,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 12
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 12
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 11
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 12
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [37] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 149,
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
      bgm = {stop = true}
    }
  },
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
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
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
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
  [49] = {
    content = 490,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11
  },
  [51] = {content = 510, contentType = 2},
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [53] = {content = 530, contentType = 2},
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11,
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
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [65] = {
    content = 650,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [66] = {content = 660, contentType = 2},
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [68] = {
    content = 680,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [73] = {
    branch = {
      {content = 731, jumpAct = 74},
      {content = 732, jumpAct = 76}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 1}
    },
    nextId = 77
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 791,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1,
        shake = true
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 792
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11
  },
  [82] = {content = 820, contentType = 2},
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 11
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 0}
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 871,
    contentShake = true,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 791
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 792,
    contentShake = true
  },
  [90] = {content = 900, contentType = 2},
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 1,
        duration = 0.2,
        posId = 3,
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
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [100] = {
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1001, jumpAct = 101},
      {content = 1002, jumpAct = 102}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    },
    nextId = 104
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [104] = {
    content = 1040,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
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
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [114] = {
    content = 1140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [117] = {
    content = 1170,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 4,
    speakerName = 11
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 4,
    speakerName = 11
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [123] = {
    content = 1230,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [125] = {
    content = 1250,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
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
      },
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1.5,
        pos = {
          -180,
          320,
          0
        },
        alpha = 1
      },
      {
        imgId = 10,
        delay = 2.5,
        duration = 1.5,
        scale = {
          1,
          1,
          1
        },
        pos = {
          -30,
          -470,
          0
        },
        alpha = 1
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 4,
    speakerName = 12
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 12
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 11
  },
  [129] = {
    content = 1290,
    contentType = 4,
    speakerName = 12
  },
  [130] = {
    content = 1300,
    contentType = 4,
    speakerName = 11
  },
  [131] = {
    content = 1310,
    contentType = 4,
    speakerName = 11
  },
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 12
  },
  [133] = {
    content = 1330,
    contentType = 4,
    speakerName = 12
  },
  [134] = {content = 1340, contentType = 2},
  [135] = {
    branch = {
      {content = 1351, jumpAct = 136}
    }
  },
  [136] = {
    content = 1360,
    contentType = 4,
    speakerName = 12
  },
  [137] = {
    content = 1370,
    contentType = 4,
    speakerName = 11
  },
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 12
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 1.2,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 4}
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [141] = {
    content = 1410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [145] = {
    content = 1450,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 149, faceId = 3}
    }
  },
  [146] = {
    content = 1460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 149, faceId = 1}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1049,
    speakerHeroPosId = 2
  },
  [149] = {
    content = 1490,
    contentType = 2,
    imgTween = {
      {
        imgId = 149,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
  [150] = {
    content = 1500,
    contentType = 4,
    speakerName = 12
  }
}
return AvgCfg_22white_rise
