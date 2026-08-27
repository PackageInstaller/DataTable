local AvgCfg_cpt_gastronomie_03_03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg040_2",
        fullScreen = true
      },
      {
        imgId = 164,
        imgType = 3,
        alpha = 0,
        imgPath = "gastronomie_avg"
      },
      {
        imgId = 147,
        imgType = 3,
        alpha = 0,
        imgPath = "willow_avg"
      },
      {
        imgId = 130,
        imgType = 3,
        alpha = 0,
        imgPath = "uncle_avg"
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
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_AMB_Restaurant",
        sheet = "AVG_gf",
        audioId = 0
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1047,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
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
    contentType = 3,
    speakerHeroId = 1047,
    heroFace = {
      {imgId = 147, faceId = 5}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1047,
    heroFace = {
      {imgId = 147, faceId = 0}
    },
    contentShake = true
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 1}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 9}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 164, faceId = 10}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 164, faceId = 9}
    },
    contentShake = true
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 0}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 10}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 5}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 130,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 130,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 130,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    imgTween = {
      {
        imgId = 130,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [18] = {content = 180, contentType = 2},
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1047,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 6}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1047,
    heroFace = {
      {imgId = 147, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1047
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 6}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 9}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 10}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 0}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [29] = {content = 290, contentType = 2},
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {stop = true},
      stopAudioId = {0}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 130,
    imgTween = {
      {
        imgId = 130,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 130, faceId = 1}
    }
  },
  [32] = {
    content = 320,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 130,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [33] = {content = 330, contentType = 2},
  [34] = {
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
  [35] = {content = 350, contentType = 1},
  [36] = {
    content = 360,
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
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [37] = {content = 370, contentType = 2},
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 6}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [40] = {
    content = 400,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1064
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1064
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1047,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 0}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1064
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 8}
    }
  },
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 147, faceId = 6}
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 147, faceId = 5}
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 147, faceId = 7}
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [58] = {content = 580, contentType = 2},
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 5}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0.2,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 9}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 147, faceId = 1}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 6}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 164, faceId = 5}
    },
    contentShake = true
  },
  [64] = {
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [65] = {content = 650, contentType = 2},
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 6}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 10}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 4}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 5}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 8}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 5}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 3}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 164, faceId = 3}
    },
    contentShake = true
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 8}
    }
  },
  [83] = {
    content = 830,
    contentType = 2,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.6,
        posId = 1,
        alpha = 0,
        isDark = true
      }
    }
  },
  [84] = {content = 840, contentType = 2},
  [85] = {
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
  [86] = {
    content = 860,
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
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [87] = {content = 870, contentType = 2},
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 12
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 13
  },
  [90] = {
    content = 900,
    contentType = 4,
    speakerName = 12
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 14
  },
  [92] = {
    content = 920,
    contentType = 4,
    speakerName = 12
  },
  [93] = {content = 930, contentType = 2},
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 1}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 147, faceId = 8}
    }
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 13
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 14
  },
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 12
  },
  [101] = {content = 1010, contentType = 2},
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 13
  },
  [103] = {
    content = 1030,
    contentType = 4,
    speakerName = 14
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 14
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1064
  },
  [111] = {
    content = 1110,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 9}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1064
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 13
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 7}
    }
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 164,
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
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [122] = {
    content = 1220,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [123] = {
    content = 1230,
    contentType = 4,
    speakerName = 13
  },
  [124] = {
    content = 1240,
    contentType = 4,
    speakerName = 14
  },
  [125] = {
    content = 1250,
    contentType = 4,
    speakerName = 13
  },
  [126] = {
    content = 1260,
    contentType = 4,
    speakerName = 12
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 13,
    contentShake = true
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 14
  },
  [129] = {content = 1290, contentType = 2},
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [132] = {
    content = 1320,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 1064
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 1}
    }
  },
  [136] = {
    content = 1360,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [137] = {
    content = 1370,
    contentType = 4,
    speakerName = 13
  },
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 13
  },
  [139] = {
    content = 1390,
    contentType = 4,
    speakerName = 13
  },
  [140] = {
    content = 1400,
    contentType = 4,
    speakerName = 12
  },
  [141] = {
    content = 1410,
    contentType = 4,
    speakerName = 13
  },
  [142] = {content = 1420, contentType = 2},
  [143] = {
    content = 1430,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [145] = {
    content = 1450,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [146] = {
    content = 1460,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 1064
  },
  [149] = {
    content = 1490,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    contentShake = true
  },
  [150] = {
    content = 1500,
    contentType = 4,
    speakerName = 12
  },
  [151] = {content = 1510, contentType = 2},
  [152] = {
    content = 1520,
    contentType = 4,
    speakerName = 14
  },
  [153] = {
    content = 1530,
    contentType = 4,
    speakerName = 12
  },
  [154] = {content = 1540, contentType = 2},
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [156] = {
    content = 1560,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 0}
    }
  },
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 1064
  },
  [159] = {
    content = 1590,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [160] = {
    content = 1600,
    contentType = 4,
    speakerName = 14
  },
  [161] = {
    content = 1610,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [162] = {content = 1620, contentType = 2},
  [163] = {
    content = 1630,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 1064,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [165] = {
    content = 1650,
    contentType = 3,
    speakerHeroId = 1064,
    contentShake = true
  },
  [166] = {
    content = 1660,
    contentType = 3,
    speakerHeroId = 1064,
    heroFace = {
      {imgId = 164, faceId = 1}
    }
  },
  [167] = {
    content = 1670,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [168] = {
    content = 1680,
    contentType = 4,
    speakerName = 14
  },
  [169] = {content = 1690, contentType = 2},
  [170] = {
    content = 1700,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [171] = {
    content = 1710,
    contentType = 4,
    speakerName = 12
  },
  [172] = {content = 1720, contentType = 2},
  [173] = {
    content = 1730,
    contentType = 4,
    speakerName = 12
  },
  [174] = {
    content = 1740,
    contentType = 4,
    speakerName = 13
  },
  [175] = {
    content = 1750,
    contentType = 4,
    speakerName = 14
  },
  [176] = {
    content = 1760,
    contentType = 4,
    speakerName = 13
  },
  [177] = {
    content = 1770,
    contentType = 2,
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
  [178] = {content = 1780, contentType = 2},
  [179] = {
    content = 1790,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 147,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 147, faceId = 6}
    }
  },
  [180] = {
    content = 1800,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [181] = {
    content = 1810,
    contentType = 2,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [182] = {
    content = 1820,
    contentType = 3,
    speakerHeroId = 1047,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [183] = {
    content = 1830,
    contentType = 3,
    speakerHeroId = 1064,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 164, faceId = 2}
    }
  },
  [184] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 164,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 147,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_cpt_gastronomie_03_03
