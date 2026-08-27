local AvgCfg_24summer_cargo03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "summer/summer_e_bg008_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "summer/summer_e_bg001_1",
        fullScreen = true
      },
      {
        imgId = 117,
        imgType = 3,
        alpha = 0,
        imgPath = "angela_summer_avg"
      },
      {
        imgId = 159,
        imgType = 3,
        alpha = 0,
        imgPath = "nora_summer_avg"
      },
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_summer_avg"
      },
      {
        imgId = 144,
        imgType = 3,
        alpha = 0,
        imgPath = "twigs_summer_avg"
      },
      {
        imgId = 172,
        imgType = 3,
        alpha = 0,
        imgPath = "jiangyu_summer_avg"
      },
      {
        imgId = 166,
        imgType = 3,
        alpha = 0,
        imgPath = "clukay_summer_avg"
      },
      {
        imgId = 110,
        imgType = 3,
        alpha = 0,
        imgPath = "evelyn_summer_avg"
      },
      {
        imgId = 116,
        imgType = 3,
        alpha = 0,
        imgPath = "banxsy_summer_avg"
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
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 0.6}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV_23DormPVP",
        sheet = "Mus_EV_23DormPVP",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {cue = "Atk_Chi_01", sheet = "Chara_Chi"}
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1059,
    contentShake = true,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true
      },
      {
        imgId = 159,
        delay = 0.3,
        duration = 0.2,
        shake = true
      }
    },
    heroFace = {
      {imgId = 159, faceId = 2}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1017,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.6,
        posId = 5,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
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
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "Atk_Chi_01", sheet = "Chara_Chi"}
    }
  },
  [9] = {content = 90, contentType = 2},
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1066,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 166,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 166, faceId = 2}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1010,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 4}
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1072,
    contentShake = true,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1066,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 166, faceId = 1}
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 166,
        delay = 0.5,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.4,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      sfx = {cue = "Atk_Chi_01", sheet = "Chara_Chi"}
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    ppv = {
      dofTween = {startValue = 1, duration = 0.6}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1066,
    imgTween = {
      {
        imgId = 166,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
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
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1059,
    contentShake = true,
    heroFace = {
      {imgId = 159, faceId = 2}
    }
  },
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {content = 230, contentType = 2},
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1010,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1016,
    imgTween = {
      {
        imgId = 110,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1039,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 5}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 166,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 166,
        delay = 0.8,
        duration = 0.8,
        alpha = 1,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    },
    heroFace = {
      {imgId = 166, faceId = 3}
    }
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 166,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_door_storehouse",
        sheet = "AVG_gf"
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 311,
    contentShake = true
  },
  [32] = {content = 320, contentType = 2},
  [33] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true}
    }
  },
  [34] = {content = 340, contentType = 2},
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0.6,
        duration = 0.2,
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
      {imgId = 159, faceId = 2}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1059,
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 159, faceId = 2}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 3
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 3
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 159, faceId = 2}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1017,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [51] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
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
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
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
  [53] = {content = 530, contentType = 2},
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 144, faceId = 1}
    }
  },
  [57] = {
    content = 570,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 144, faceId = 0}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
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
    speakerHeroId = 1044,
    speakerHeroPosId = 1
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 117,
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
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
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
  [70] = {
    content = 700,
    contentType = 1,
    contentShake = true
  },
  [71] = {
    content = 710,
    contentType = 1,
    contentShake = true
  },
  [72] = {
    content = 720,
    contentType = 1,
    contentShake = true
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0.4,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 1
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [77] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 117,
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
  [78] = {
    content = 780,
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
  [79] = {content = 790, contentType = 2},
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [82] = {
    content = 820,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  },
  [83] = {content = 830, contentType = 2},
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [85] = {
    content = 850,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1044,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1044
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 1044,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 144, faceId = 1}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1044,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1044,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 1017,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [104] = {content = 1040, contentType = 2},
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1017,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 1071,
    contentShake = true
  },
  [108] = {
    content = 1080,
    contentType = 2,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 1072,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [112] = {
    content = 1120,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1072,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 3}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 1}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 144,
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
    speakerHeroId = 1044,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 144, faceId = 1}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 1}
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1017,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 0}
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1070,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 170,
        imgType = 3,
        alpha = 0,
        imgPath = "undline_summer_avg"
      },
      {
        imgId = 118,
        imgType = 3,
        alpha = 0,
        imgPath = "nanaka_summer_avg"
      },
      {
        imgId = 166,
        imgType = 3,
        alpha = 0,
        imgPath = "clukay_summer_avg",
        delete = true
      },
      {
        imgId = 110,
        imgType = 3,
        alpha = 0,
        imgPath = "evelyn_summer_avg",
        delete = true
      },
      {
        imgId = 116,
        imgType = 3,
        alpha = 0,
        imgPath = "banxsy_summer_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 170,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 170,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 170, faceId = 5}
    }
  },
  [122] = {
    content = 1220,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 170,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [123] = {
    content = 1230,
    contentType = 2,
    imgTween = {
      {
        imgId = 170,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 170,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 170,
        delay = 0.5,
        duration = 0.6,
        alpha = 0,
        shake = true,
        isDark = true
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1072,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 172, faceId = 3}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 0}
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 1044
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 1018,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 118,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 118,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Sector_Burbank",
        sheet = "Mus_EV3_Sector_Burbank",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [129] = {
    content = 1290,
    contentType = 2,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 1018,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 1018,
    contentShake = true
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [134] = {
    content = 1340,
    contentType = 2,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 1018,
    contentShake = true,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 1044,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 1018,
    contentShake = true,
    imgTween = {
      {
        imgId = 144,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 1018,
    contentShake = true,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [139] = {
    content = 1390,
    contentType = 2,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [140] = {
    content = 1400,
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
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 172, faceId = 1}
    }
  },
  [141] = {
    content = 1410,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 172,
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
    speakerHeroId = 1072,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 172,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 1070,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 172,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 170,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 170, faceId = 0}
    }
  }
}
return AvgCfg_24summer_cargo03
