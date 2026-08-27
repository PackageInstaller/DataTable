local AvgCfg_23sg_cafe = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg069",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg005_3",
        fullScreen = true
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_maid_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg"
      },
      {
        imgId = 602,
        imgType = 3,
        alpha = 0,
        imgPath = "faris_avg"
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
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 11
  },
  [5] = {
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
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 2001,
    images = {
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "okabe_avg",
        comm = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 201,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    ppv = {
      cg = {saturation = -70}
    },
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 2001
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 2}
    },
    nextId = 901
  },
  [9] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 90,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        delete = true
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
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
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img06_ocharake1",
        sheet = "Mus_SteinsGate_img06_ocharake1",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 5}
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    images = {
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        imgPath = "okabe_avg"
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.8,
        scale = {
          1.2,
          1.2,
          1.2
        },
        alpha = 1
      },
      {
        imgId = 2,
        delay = 0.8,
        duration = 0.2,
        shake = true,
        alpha = 1
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.8,
        scale = {
          1.2,
          1.2,
          1.2
        },
        alpha = 1,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 4}
    }
  },
  [16] = {
    content = 160,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 602,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        scale = {
          1,
          1,
          1
        },
        alpha = 1
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.6,
        scale = {
          1,
          1,
          1
        },
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 0}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 602,
    heroFace = {
      {imgId = 602, faceId = 5}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 602,
    heroFace = {
      {imgId = 602, faceId = 1}
    },
    contentShake = true
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 602,
    contentShake = true,
    heroFace = {
      {imgId = 602, faceId = 2}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 602,
    contentShake = true
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 602,
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
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 0}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 602
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    contentShake = true,
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
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.4,
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
  [29] = {
    content = 290,
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
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 602,
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
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 602
  },
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [33] = {content = 330, contentType = 2},
  [34] = {
    branch = {
      {content = 341, jumpAct = 36},
      {content = 342, jumpAct = 145},
      {content = 343, jumpAct = 254}
    }
  },
  [35] = {autoContinue = true},
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
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
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 602,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 602, faceId = 0}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 602,
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 602,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 602,
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
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img18_Cycle",
        sheet = "Mus_SteinsGate_img18_Cycle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 20003,
    contentShake = true,
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
  [44] = {
    content = 440,
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
  [45] = {
    content = 450,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [46] = {content = 460, contentType = 2},
  [47] = {content = 470, contentType = 2},
  [48] = {
    content = 480,
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
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [51] = {
    content = 510,
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
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 20003,
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
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 20003
  },
  [54] = {
    content = 540,
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
  [55] = {
    content = 550,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 2,
        delay = 0.8,
        duration = 0.6,
        shake = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "Atk_Snooper_Hit",
        sheet = "Mon_Snooper"
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
    },
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 20003,
    contentShake = true,
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
      {imgId = 203, faceId = 1}
    }
  },
  [60] = {
    content = 600,
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
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 2,
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
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img18_Cycle",
        sheet = "Mus_SteinsGate_img18_Cycle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 20003,
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
  [64] = {
    content = 640,
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
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 3}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [67] = {
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 671, jumpAct = 68},
      {content = 672, jumpAct = 68}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 2}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 20003
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
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 1}
    }
  },
  [72] = {
    content = 720,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [73] = {
    content = 730,
    contentType = 2,
    contentShake = true,
    imgTween = {
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
        cue = "Atk_Snooper_Hit",
        sheet = "Mon_Snooper"
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 2,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Snooper_Hit",
        sheet = "Mon_Snooper"
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 2,
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
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 761
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
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
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [80] = {
    content = 800,
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
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 2}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 20003,
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
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
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
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [87] = {
    content = 870,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img18_Cycle",
        sheet = "Mus_SteinsGate_img18_Cycle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [88] = {
    content = 880,
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
  [89] = {content = 890, contentType = 2},
  [90] = {content = 900, contentType = 2},
  [91] = {
    content = 910,
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
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 3}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [94] = {
    content = 940,
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
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 20003,
    contentShake = true,
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
  [96] = {
    content = 960,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
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
      {imgId = 203, faceId = 1}
    }
  },
  [99] = {
    content = 990,
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
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [101] = {
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1011, jumpAct = 102},
      {content = 1012, jumpAct = 108}
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [103] = {
    content = 1030,
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
  [104] = {content = 1040, contentType = 2},
  [105] = {content = 1050, contentType = 2},
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11
  },
  [107] = {
    content = 1070,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    nextId = 111
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11
  },
  [109] = {
    content = 1090,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 761
  },
  [111] = {content = 1110, contentType = 2},
  [112] = {content = 1120, contentType = 2},
  [113] = {
    content = 1130,
    contentType = 4,
    speakerName = 11
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 203,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [115] = {
    content = 1150,
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
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 2}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 20003,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img13_Quiet air",
        sheet = "Mus_SteinsGate_img13_Quiet air",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [119] = {
    content = 1190,
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
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 20003,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [121] = {
    content = 1210,
    contentType = 2,
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
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 2}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 20003
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 20003
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 20003
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 20003
  },
  [127] = {
    content = 1270,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [128] = {
    content = 1280,
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
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 20003,
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
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [131] = {
    content = 1310,
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
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 20003,
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
      {imgId = 203, faceId = 3}
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 3}
    }
  },
  [135] = {
    content = 1350,
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
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 20003,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 20003,
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [138] = {
    content = 1380,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [139] = {
    content = 1390,
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
  [140] = {
    content = 1400,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
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
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
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
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 7}
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 3}
    },
    contentShake = true
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [144] = {
    content = 1440,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
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
    isEnd = true
  },
  [145] = {autoContinue = true},
  [146] = {
    content = 1460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
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
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 602,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 20002,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 602,
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
      {imgId = 202, faceId = 7}
    }
  },
  [151] = {
    content = 1510,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
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
  [152] = {
    content = 1520,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
    }
  },
  [153] = {
    content = 1530,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [154] = {
    content = 1540,
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
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 20002,
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
    }
  },
  [156] = {
    content = 1560,
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
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 20002,
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
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [159] = {
    content = 1590,
    contentType = 4,
    speakerName = 11
  },
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 20002,
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
  [161] = {
    content = 1610,
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
  [162] = {
    content = 1620,
    contentType = 4,
    speakerName = 11
  },
  [163] = {
    content = 1630,
    contentType = 3,
    speakerHeroId = 20002,
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
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 20002,
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
  [165] = {
    content = 1650,
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
  [166] = {
    content = 1660,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 2}
    }
  },
  [167] = {
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
  [168] = {
    content = 1680,
    contentType = 3,
    speakerHeroId = 20002,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 202,
        delay = 1.4,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img06_ocharake1",
        sheet = "Mus_SteinsGate_img06_ocharake1",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [169] = {
    content = 1690,
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
  [170] = {
    content = 1700,
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
  [171] = {
    content = 1710,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 8}
    }
  },
  [172] = {
    content = 1720,
    contentType = 4,
    speakerName = 11
  },
  [173] = {
    content = 1730,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [174] = {
    content = 1740,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 202,
        delay = 0.8,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = true
      }
    }
  },
  [175] = {
    content = 1750,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [176] = {
    content = 1760,
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
  [177] = {
    content = 1770,
    contentType = 3,
    speakerHeroId = 20002,
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
  [178] = {
    content = 1780,
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
  [179] = {
    content = 1790,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [180] = {
    content = 1800,
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
  [181] = {
    content = 1810,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 8}
    }
  },
  [182] = {
    content = 1820,
    contentType = 2,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true
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
  [183] = {content = 1830, contentType = 2},
  [184] = {
    content = 1840,
    contentType = 3,
    speakerHeroId = 20002,
    contentShake = true,
    imgTween = {
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
  [185] = {
    content = 1850,
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
  [186] = {
    content = 1860,
    contentType = 2,
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
  [187] = {
    content = 1870,
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
  [188] = {
    content = 1880,
    contentType = 3,
    speakerHeroId = 20002,
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
  [189] = {
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 1891, jumpAct = 190},
      {content = 1892, jumpAct = 192}
    }
  },
  [190] = {
    content = 1900,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [191] = {
    content = 1910,
    contentType = 3,
    speakerHeroId = 20002,
    nextId = 193
  },
  [192] = {
    content = 1920,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [193] = {
    content = 1930,
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
  [194] = {
    content = 1940,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1.2,
          1.2,
          1.2
        }
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
      {imgId = 202, faceId = 4}
    }
  },
  [195] = {
    content = 1950,
    contentType = 3,
    speakerHeroId = 20002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [196] = {
    content = 1960,
    contentType = 3,
    speakerHeroId = 20002,
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
    }
  },
  [197] = {
    content = 1970,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img18_Cycle",
        sheet = "Mus_SteinsGate_img18_Cycle",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [198] = {content = 1980, contentType = 2},
  [199] = {content = 1990, contentType = 2},
  [200] = {
    content = 2000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
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
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [201] = {
    content = 2010,
    contentType = 3,
    speakerHeroId = 20002,
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
  [202] = {
    content = 2020,
    contentType = 3,
    speakerHeroId = 20002
  },
  [203] = {
    content = 2030,
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
  [204] = {
    content = 2040,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [205] = {
    content = 2050,
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
  [206] = {
    content = 2060,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [207] = {
    content = 2070,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 7}
    }
  },
  [208] = {
    content = 2080,
    contentType = 3,
    speakerHeroId = 20002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [209] = {
    content = 2090,
    contentType = 3,
    speakerHeroId = 20002,
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [210] = {
    content = 2100,
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
  [211] = {
    content = 2110,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 1}
    }
  },
  [212] = {
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [213] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 2130,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [214] = {
    content = 2140,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
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
      {imgId = 202, faceId = 7}
    }
  },
  [215] = {
    content = 2150,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
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
  [216] = {
    content = 2160,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
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
      {imgId = 202, faceId = 6}
    }
  },
  [217] = {
    content = 2170,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3
  },
  [218] = {
    content = 2180,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
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
    }
  },
  [219] = {
    content = 2190,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [220] = {
    autoContinue = true,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [221] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 2210,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 2,
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
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [222] = {
    content = 2220,
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
  [223] = {
    content = 2230,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [224] = {
    content = 2240,
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
  [225] = {
    content = 2250,
    contentType = 3,
    speakerHeroId = 20002,
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
  [226] = {
    content = 2260,
    contentType = 3,
    speakerHeroId = 20002
  },
  [227] = {
    content = 2270,
    contentType = 3,
    speakerHeroId = 20002,
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
  [228] = {
    content = 2280,
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
  [229] = {content = 2290, contentType = 2},
  [230] = {
    content = 2300,
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
  [231] = {
    content = 2310,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [232] = {
    content = 2320,
    contentType = 3,
    speakerHeroId = 20002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [233] = {
    content = 2330,
    contentType = 4,
    speakerName = 11
  },
  [234] = {
    content = 2340,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 2}
    }
  },
  [235] = {
    content = 2350,
    contentType = 3,
    speakerHeroId = 20002
  },
  [236] = {
    content = 2360,
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
  [237] = {
    content = 2370,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 6}
    }
  },
  [238] = {
    content = 2380,
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
  [239] = {
    content = 2390,
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img05_FGL",
        sheet = "Mus_SteinsGate_img05_FGL",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [240] = {
    content = 2400,
    contentType = 4,
    speakerName = 11
  },
  [241] = {
    content = 2410,
    contentType = 3,
    speakerHeroId = 20002,
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
  [242] = {
    content = 2420,
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
  [243] = {
    content = 2430,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 8}
    }
  },
  [244] = {
    content = 2440,
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
  [245] = {
    content = 2450,
    contentType = 4,
    speakerName = 11
  },
  [246] = {content = 2460, contentType = 2},
  [247] = {
    content = 2470,
    contentType = 3,
    speakerHeroId = 20002,
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
      {imgId = 202, faceId = 7}
    }
  },
  [248] = {
    content = 2480,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [249] = {
    content = 2490,
    contentType = 2,
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
  [250] = {
    content = 2500,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
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
        cue = "Mus_SteinsGate_img22_Walking on sleeping",
        sheet = "Mus_SteinsGate_img22_Walking on sleeping",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 201, faceId = 7}
    }
  },
  [251] = {
    content = 2510,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
    heroFace = {
      {imgId = 201, faceId = 3}
    }
  },
  [252] = {
    content = 2520,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [253] = {
    content = 2530,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
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
    isEnd = true
  },
  [254] = {autoContinue = true},
  [255] = {
    content = 2550,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 232,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg"
      },
      {
        imgId = 231,
        imgType = 3,
        alpha = 0,
        imgPath = "ksenia_avg"
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
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
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
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [256] = {
    content = 2560,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
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
      {imgId = 203, faceId = 3}
    }
  },
  [257] = {
    content = 2570,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
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
  [258] = {
    content = 2580,
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
  [259] = {
    content = 2590,
    contentType = 3,
    speakerHeroId = 20002,
    contentShake = true,
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
        duration = 0.6,
        posId = 3,
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
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [260] = {
    content = 2600,
    contentType = 3,
    speakerHeroId = 602,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 602, faceId = 1}
    }
  },
  [261] = {
    content = 2610,
    contentType = 3,
    speakerHeroId = 602,
    heroFace = {
      {imgId = 602, faceId = 0}
    }
  },
  [262] = {
    content = 2620,
    contentType = 3,
    speakerHeroId = 232,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 232,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 232,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [263] = {
    content = 2630,
    contentType = 3,
    speakerHeroId = 602,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 232,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 602, faceId = 2}
    }
  },
  [264] = {
    content = 2640,
    contentType = 3,
    speakerHeroId = 232,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 232,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [265] = {
    content = 2650,
    contentType = 2,
    imgTween = {
      {
        imgId = 602,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 232,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [266] = {
    content = 2660,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
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
      {imgId = 101, faceId = 8}
    }
  },
  [267] = {
    content = 2670,
    contentType = 3,
    speakerHeroId = 231,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [268] = {
    content = 2680,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 231,
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
      {imgId = 101, faceId = 2}
    }
  },
  [269] = {
    content = 2690,
    contentType = 3,
    speakerHeroId = 231,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [270] = {
    content = 2700,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 231,
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
      {imgId = 101, faceId = 15}
    }
  },
  [271] = {
    content = 2710,
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
  [272] = {
    content = 2720,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
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
  [273] = {
    content = 2730,
    contentType = 3,
    speakerHeroId = 20003,
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
  [274] = {
    content = 2740,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [275] = {
    content = 2750,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 201,
        delay = 0.6,
        duration = 0.6,
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
    }
  },
  [276] = {
    content = 2760,
    contentType = 3,
    speakerHeroId = 20003,
    imgTween = {
      {
        imgId = 201,
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
      {imgId = 203, faceId = 1}
    }
  },
  [277] = {
    content = 2770,
    contentType = 3,
    speakerHeroId = 2001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 201,
        delay = 0,
        duration = 0,
        posId = 4,
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
  [278] = {
    content = 2780,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 201,
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
    }
  },
  [279] = {
    content = 2790,
    contentType = 3,
    speakerHeroId = 2001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 201,
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
      {imgId = 201, faceId = 7}
    }
  },
  [280] = {
    content = 2800,
    contentType = 3,
    speakerHeroId = 2001,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [281] = {
    content = 2810,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 201,
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
    }
  },
  [282] = {
    content = 2820,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        posId = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [283] = {
    content = 2830,
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
      {imgId = 201, faceId = 3}
    }
  },
  [284] = {
    content = 2840,
    contentType = 3,
    speakerHeroId = 2001
  },
  [285] = {
    content = 2850,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [286] = {
    content = 2860,
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
      {imgId = 201, faceId = 1}
    }
  },
  [287] = {
    content = 2870,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [288] = {
    content = 2880,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      },
      {
        imgId = 201,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 3}
    }
  },
  [289] = {
    content = 2890,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [290] = {
    content = 2900,
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
      {imgId = 201, faceId = 4}
    }
  },
  [291] = {
    content = 2910,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 2}
    },
    contentShake = true
  },
  [292] = {
    content = 2920,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 1}
    },
    contentShake = true
  },
  [293] = {
    content = 2930,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [294] = {content = 2940, contentType = 2},
  [295] = {
    content = 2950,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true,
        scale = {
          1,
          1,
          1
        }
      }
    }
  },
  [296] = {
    content = 2960,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
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
      {imgId = 201, faceId = 3}
    }
  },
  [297] = {
    content = 2970,
    contentType = 3,
    speakerHeroId = 2001
  },
  [298] = {
    content = 2980,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 1}
    },
    contentShake = true
  },
  [299] = {
    content = 2990,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [300] = {content = 3000, contentType = 2},
  [301] = {
    content = 3010,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [302] = {
    content = 3020,
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
    }
  },
  [303] = {
    content = 3030,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 3}
    },
    contentShake = true
  },
  [304] = {
    content = 3040,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 3}
    }
  },
  [305] = {
    content = 3050,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
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
  [306] = {
    content = 3060,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img22_Walking on sleeping",
        sheet = "Mus_SteinsGate_img22_Walking on sleeping",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [307] = {
    content = 3070,
    contentType = 2,
    contentShake = true
  },
  [308] = {
    content = 3080,
    contentType = 2,
    images = {
      {
        imgId = 232,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg",
        delete = true
      },
      {
        imgId = 231,
        imgType = 3,
        alpha = 0,
        imgPath = "ksenia_avg"
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_maid_avg",
        delete = true
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        isDark = false
      },
      {
        imgId = 2,
        delay = 1.2,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 2,
        delay = 1.8,
        duration = 0.6,
        isDark = false
      }
    }
  },
  [309] = {
    content = 3090,
    contentType = 3,
    speakerHeroId = 232,
    contentShake = true,
    images = {
      {
        imgId = 2322,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg",
        ripple = true
      }
    },
    imgTween = {
      {
        imgId = 2322,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2322,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      }
    }
  },
  [310] = {
    content = 3100,
    contentType = 3,
    speakerHeroId = 232
  },
  [311] = {
    content = 3110,
    contentType = 3,
    speakerHeroId = 232,
    images = {
      {
        imgId = 232,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg"
      }
    },
    imgTween = {
      {
        imgId = 232,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 232,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2322,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = false
      }
    }
  },
  [312] = {
    content = 3120,
    contentType = 3,
    speakerHeroId = 231,
    speakerHeroPosId = 3,
    contentShake = true,
    images = {
      {
        imgId = 2322,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 232,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 231, faceId = 3}
    }
  },
  [313] = {
    content = 3130,
    contentType = 3,
    speakerHeroId = 232,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 232,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [314] = {
    content = 3140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 232,
        delay = 0,
        duration = 0.6,
        posId = 1,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 231,
        delay = 0,
        duration = 0.8,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [315] = {
    content = 3150,
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
  [316] = {
    content = 3160,
    contentType = 3,
    speakerHeroId = 2001
  },
  [317] = {
    content = 3170,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [318] = {
    content = 3180,
    contentType = 3,
    speakerHeroId = 2001,
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
      {imgId = 201, faceId = 7}
    }
  },
  [319] = {
    content = 3190,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [320] = {
    content = 3200,
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
      {imgId = 201, faceId = 1}
    }
  },
  [321] = {
    images = {
      {
        imgId = 232,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_maid_avg",
        delete = true
      }
    },
    content = 3210,
    contentType = 3,
    speakerHeroId = 1001,
    contentShake = true,
    imgTween = {
      {
        imgId = 201,
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [322] = {
    content = 3220,
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
  [323] = {
    content = 3230,
    contentType = 3,
    speakerHeroId = 1001,
    images = {
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        delete = true
      },
      {
        imgId = 1001,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        ripple = true
      }
    },
    imgTween = {
      {
        imgId = 1001,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1001,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      }
    }
  },
  [324] = {
    content = 3240,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 1001, faceId = 0}
    }
  },
  [325] = {
    content = 3250,
    contentType = 2,
    images = {
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      }
    },
    imgTween = {
      {
        imgId = 1001,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [326] = {
    content = 3260,
    contentType = 2,
    contentShake = true,
    images = {
      {
        imgId = 1001,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
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
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    }
  },
  [327] = {
    content = 3270,
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
      },
      {
        imgId = 201,
        delay = 0.4,
        duration = 1,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img08_Kinpaku1",
        sheet = "Mus_SteinsGate_img08_Kinpaku1",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 201, faceId = 6}
    }
  },
  [328] = {
    content = 3280,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 201,
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
      {imgId = 101, faceId = 7}
    }
  },
  [329] = {
    content = 3290,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    }
  },
  [330] = {
    content = 3300,
    contentType = 3,
    speakerHeroId = 2001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 201,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 6}
    }
  },
  [331] = {
    content = 3310,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 8}
    },
    contentShake = true
  },
  [332] = {
    content = 3320,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [333] = {
    content = 3330,
    contentType = 4,
    speakerName = 11
  },
  [334] = {
    images = {
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg"
      }
    },
    content = 3340,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
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
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
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
      {imgId = 202, faceId = 8}
    }
  },
  [335] = {
    content = 3350,
    contentType = 3,
    speakerHeroId = 20002,
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
  [336] = {
    content = 3360,
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
  [337] = {
    content = 3370,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [338] = {
    content = 3380,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 2003,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_maid_avg",
        ripple = true
      },
      {
        imgId = 2002,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg",
        ripple = true
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2002,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2002,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2003,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 2002, faceId = 6}
    }
  },
  [339] = {
    content = 3390,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 2003, faceId = 2}
    }
  },
  [340] = {
    content = 3400,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 2002, faceId = 3}
    }
  },
  [341] = {
    content = 3410,
    contentType = 3,
    speakerHeroId = 20003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 2003, faceId = 1}
    }
  },
  [342] = {
    content = 3420,
    contentType = 3,
    speakerHeroId = 20002,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2002,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 2002, faceId = 6}
    }
  },
  [343] = {
    content = 3430,
    contentType = 3,
    speakerHeroId = 20002,
    contentShake = true,
    imgTween = {
      {
        imgId = 2003,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2002,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 2002, faceId = 3}
    }
  },
  [344] = {
    content = 3440,
    contentType = 2,
    imgTween = {
      {
        imgId = 2002,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img08_Kinpaku1",
        sheet = "Mus_SteinsGate_img08_Kinpaku1",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [345] = {
    content = 3450,
    contentType = 2,
    images = {
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_maid_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg"
      },
      {
        imgId = 2003,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_maid_avg",
        delete = true
      },
      {
        imgId = 2002,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_maid_avg",
        delete = true
      }
    },
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
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [346] = {
    images = {
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg",
        delete = true
      }
    },
    content = 3460,
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
  [347] = {
    content = 3470,
    contentType = 3,
    speakerHeroId = 20002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
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
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.75,
        isDark = true
      }
    }
  },
  [348] = {
    content = 3480,
    contentType = 3,
    speakerHeroId = 2001,
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
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 201, faceId = 6}
    }
  },
  [349] = {
    content = 3490,
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
      },
      {
        imgId = 201,
        delay = 0.5,
        duration = 1,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [350] = {
    content = 3500,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [351] = {content = 3510, contentType = 2},
  [352] = {
    content = 3520,
    contentType = 3,
    speakerHeroId = 2001,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 201,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
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
    },
    heroFace = {
      {imgId = 201, faceId = 9}
    }
  },
  [353] = {
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 3531, jumpAct = 354},
      {content = 3532, jumpAct = 355}
    }
  },
  [354] = {
    content = 3540,
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
      {imgId = 201, faceId = 5}
    },
    nextId = 356
  },
  [355] = {
    content = 3550,
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
    }
  },
  [356] = {
    content = 3560,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [357] = {
    content = 3570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [358] = {
    content = 3580,
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
      {imgId = 201, faceId = 7}
    }
  },
  [359] = {
    content = 3590,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 1}
    },
    contentShake = true
  },
  [360] = {
    content = 3600,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 0}
    }
  },
  [361] = {
    content = 3610,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 3}
    }
  },
  [362] = {
    content = 3620,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [363] = {
    content = 3630,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
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
    }
  },
  [364] = {
    content = 3640,
    contentType = 3,
    speakerHeroId = 2001,
    contentShake = true,
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
      {imgId = 201, faceId = 3}
    }
  },
  [365] = {
    content = 3650,
    contentType = 3,
    speakerHeroId = 2001,
    heroFace = {
      {imgId = 201, faceId = 4}
    }
  },
  [366] = {
    content = 3660,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [367] = {
    content = 3670,
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
      {imgId = 201, faceId = 8}
    }
  },
  [368] = {
    content = 3680,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0,
        scale = {
          1.3,
          1.3,
          1.3
        }
      }
    }
  },
  [369] = {
    content = 3690,
    contentType = 4,
    speakerName = 3691
  },
  [370] = {
    content = 3700,
    contentType = 4,
    speakerName = 3691,
    contentShake = true
  },
  [371] = {
    content = 3710,
    contentType = 4,
    speakerName = 3711,
    contentShake = true,
    isEnd = true
  },
  [901] = {
    autoContinue = true,
    nextId = 9,
    images = {
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        imgPath = "okabe_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  }
}
return AvgCfg_23sg_cafe
