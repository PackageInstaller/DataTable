local AvgCfg_23oath_octogen = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg017",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg007_7",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "oath/oath_octogen",
        scale = {
          2,
          2,
          2
        },
        pos = {
          350,
          -800,
          0
        },
        order = 5
      },
      {
        imgId = 154,
        imgType = 3,
        alpha = 0,
        imgPath = "python_avg"
      },
      {
        imgId = 104,
        imgType = 3,
        alpha = 0,
        imgPath = "simo_avg",
        rot = {
          0,
          180,
          0
        }
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
      },
      {
        imgId = 126,
        imgType = 3,
        alpha = 0,
        imgPath = "octogen_avg"
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
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 1,
        delay = 2,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {cue = "Gunfight", sheet = "AVG"}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1026,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 126, faceId = 4}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1004,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 10}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1026,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1054,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 154,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1054
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1054,
    heroFace = {
      {imgId = 154, faceId = 2}
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 91,
    contentShake = true,
    imgTween = {
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 4},
      {imgId = 126, faceId = 1}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Simo_01",
        sheet = "Chara_Simo"
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1054,
    imgTween = {
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 154, faceId = 0}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 126,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 126,
        delay = 1.2,
        duration = 0.6,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 1}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 151,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1.5,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "Gunfight", sheet = "AVG"}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [20] = {
    bgColor = 3,
    content = 200,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true,
        shakeIntensity = 4
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [21] = {content = 210, contentType = 2},
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 126,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 4}
    }
  },
  [23] = {
    bgColor = 2,
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [24] = {
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
  [25] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 250,
    contentType = 4,
    speakerName = 11
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11
  },
  [27] = {autoContinue = true},
  [28] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 280,
    contentType = 3,
    speakerHeroId = 1026,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        alpha = 0,
        posId = 3,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Simo_01",
        sheet = "Chara_Simo"
      }
    }
  },
  [30] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [31] = {content = 310, contentType = 1},
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1054,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 154,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
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
      {imgId = 154, faceId = 3}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1026,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 154,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1054,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 154, faceId = 0}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1026,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1004,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 154,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 104, faceId = 10}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 104,
        delay = 0,
        duration = 0.2,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [38] = {
    audio = {
      bgm = {stop = true}
    },
    autoContinue = true,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
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
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1005,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 4}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1005,
    heroFace = {
      {imgId = 105, faceId = 2}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 1}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1005,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 4}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 50
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11
  },
  [52] = {content = 520, contentType = 2},
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1005,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 4}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1005,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 1}
    }
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [60] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
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
  [61] = {content = 610, contentType = 1},
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
      sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
    }
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11
  },
  [64] = {
    bgColor = 3,
    content = 640,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Battlefield",
        sheet = "AVG_gf"
      },
      bgm = {
        stop = false,
        cue = "Mus_EV_Whiteday",
        sheet = "Mus_EV_Whiteday",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    customCode = "AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource,'Selector_Mus_Home','SelectorLabel_OasisDay')"
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1.6,
        scale = {
          1.75,
          1.75,
          1.75
        },
        pos = {
          -200,
          450,
          0
        },
        alpha = 1
      },
      {
        imgId = 10,
        delay = 3,
        duration = 1,
        scale = {
          1,
          1,
          1
        },
        pos = {
          0,
          0,
          0
        },
        alpha = 1
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 11
  },
  [67] = {content = 670, contentType = 2},
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 12
  },
  [69] = {
    content = 690,
    contentType = 2,
    images = {
      {
        imgId = 126,
        imgType = 3,
        alpha = 0,
        imgPath = "octogen_avg",
        delete = true
      },
      {
        imgId = 126,
        imgType = 3,
        alpha = 0,
        imgPath = "octogen_oath_avg"
      }
    }
  },
  [70] = {content = 700, contentType = 2},
  [71] = {content = 710, contentType = 2},
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0.8,
        duration = 0.6,
        alpha = 1
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
        delay = 1.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [73] = {
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 731, jumpAct = 74},
      {content = 732, jumpAct = 76}
    }
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    },
    nextId = 78
  },
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 11
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 1026
  },
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
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
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [85] = {content = 850, contentType = 2},
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 126,
        delay = 0.4,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [90] = {content = 900, contentType = 2},
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
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
    speakerHeroId = 1026,
    contentShake = true,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [95] = {
    content = 950,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 301
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 3}
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 1026
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1026,
    heroFace = {
      {imgId = 126, faceId = 1}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1026
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1026
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1026,
    heroFace = {
      {imgId = 126, faceId = 0}
    }
  },
  [107] = {
    content = 1070,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11,
    nextId = 111
  },
  [109] = {
    content = 1090,
    contentType = 4,
    speakerName = 11
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11
  },
  [111] = {
    content = 1110,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 4,
    speakerName = 11
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [114] = {
    content = 1140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 1}
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [118] = {content = 1180, contentType = 2},
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false,
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 126, faceId = 1}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1026
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1026,
    heroFace = {
      {imgId = 126, faceId = 2}
    }
  },
  [122] = {
    content = 1220,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [123] = {
    content = 1230,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    isEnd = true
  },
  [301] = {
    content = 1001,
    contentType = 3,
    speakerHeroId = 1026,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [302] = {
    content = 1002,
    contentType = 2,
    imgTween = {
      {
        imgId = 126,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    nextId = 101
  }
}
return AvgCfg_23oath_octogen
