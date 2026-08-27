local AvgCfg_cpt_zangyin_02_03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt02/cpt02_e_bg004_2",
        fullScreen = true
      },
      {
        imgId = 126,
        imgType = 3,
        alpha = 0,
        imgPath = "cyclopes_npc_02_avg"
      },
      {
        imgId = 160,
        imgType = 3,
        alpha = 0,
        imgPath = "crypter_avg"
      },
      {
        imgId = 125,
        imgType = 3,
        alpha = 0,
        imgPath = "nameless_avg"
      },
      {
        imgId = 19,
        imgType = 3,
        alpha = 0,
        imgPath = "olivia_avg"
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
    speakerHeroId = 125,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1060,
    contentShake = true,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 8}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1060
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1060,
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1060,
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 125,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 125,
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
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
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
      {imgId = 125, faceId = 3}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 2}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 1}
    }
  },
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [24] = {content = 240, contentType = 2},
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 5}
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 2}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
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
      {imgId = 125, faceId = 2}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 2}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 5}
    }
  },
  [60] = {
    content = 600,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 2
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 2}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 125,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 125
  },
  [75] = {
    content = 750,
    contentType = 2,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 8}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 5}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 125, faceId = 3}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [82] = {
    content = 820,
    contentType = 2,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 125,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
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
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 125, faceId = 0}
    }
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 160, faceId = 8}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 125,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1060,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0.6,
        posId = 5,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 2}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1060,
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1060
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 125,
    imgTween = {
      {
        imgId = 125,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 125,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 2,
    imgTween = {
      {
        imgId = 125,
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
  }
}
return AvgCfg_cpt_zangyin_02_03
