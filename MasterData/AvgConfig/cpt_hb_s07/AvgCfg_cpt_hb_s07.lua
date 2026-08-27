local AvgCfg_cpt_hb_s07 = {
  [1] = {
    SkipScenario = 15,
    bgColor = 2,
    content = 10,
    contentType = 1,
    storyAvgId = 1100107,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg003_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg003_3",
        fullScreen = true,
        order = 5
      },
      {
        imgId = 151,
        imgType = 3,
        alpha = 0,
        imgPath = "delacey_avg"
      },
      {
        imgId = 153,
        imgType = 3,
        alpha = 0,
        imgPath = "sueyoi_avg"
      },
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "elaugh_mask_avg"
      },
      {
        imgId = 177,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        scale = {
          1.2,
          1.2,
          1.2
        },
        order = 3
      },
      {
        imgId = 178,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg",
        scale = {
          1.2,
          1.2,
          1.2
        },
        order = 2
      },
      {
        imgId = 117,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg"
      },
      {
        imgId = 1171,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg"
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
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 2
      },
      {
        imgId = 1,
        delay = 1.6,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 4
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dangerous",
        sheet = "Mus_Story_Dangerous",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Gunfire",
        sheet = "AVG"
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 61,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 61,
    scrambleTypeWriter = true
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    },
    nextId = 301
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
        posId = 3
      }
    },
    nextId = 18
  },
  [18] = {
    content = 180,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    nextId = 25
  },
  [25] = {
    content = 250,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
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
        alpha = 1,
        shake = true,
        shakeIntensity = 4
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    },
    nextId = 27
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0,
        alpha = 0,
        posId = 2
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        alpha = 0,
        posId = 4
      },
      {
        imgId = 177,
        delay = 0,
        duration = 1.5,
        alpha = 1,
        isDark = true,
        posId = 2
      },
      {
        imgId = 178,
        delay = 0,
        duration = 1.5,
        alpha = 1,
        isDark = true,
        posId = 4
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      },
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 8,
        fadeOut = 3
      }
    },
    nextId = 29
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 291,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        posId = 2
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        posId = 4
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 291,
    heroFace = {
      {imgId = 177, faceId = 1}
    }
  },
  [31] = {
    content = 310,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        alpha = 0
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        alpha = 0
      }
    }
  },
  [32] = {content = 320, contentType = 2},
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
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
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 5,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 153, faceId = 2}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 4}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 3}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    nextId = 501
  },
  [41] = {
    content = 410,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 2,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 71,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 2,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 2,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 178, faceId = 4}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 71,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 177, faceId = 2}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [50] = {
    content = 500,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_BaseDoor_Open",
        sheet = "AVG_gf"
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 3}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 3}
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 177, faceId = 2}
    }
  },
  [56] = {
    content = 560,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 3}
    }
  },
  [59] = {
    content = 590,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 5,
        alpha = 0,
        isDark = true
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 177, faceId = 0}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 177, faceId = 2}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 3}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 177, faceId = 2}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 4}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 2}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 174, faceId = 3}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 6}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 4}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [77] = {
    content = 770,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        shake = true,
        shakeIntensity = 3
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 1}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Purifier",
        sheet = "Mus_Story_Purifier",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 0}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 178, faceId = 6}
    },
    contentShake = true
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 3}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 177, faceId = 0}
    },
    nextId = 90
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 1}
    }
  },
  [93] = {
    content = 930,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
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
        alpha = 1,
        shake = true,
        shakeIntensity = 3
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "Atk_Raider_02",
        sheet = "Mon_Raider"
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 3
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Broken_Glass",
        sheet = "AVG_gf"
      }
    }
  },
  [95] = {content = 950, contentType = 2},
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 5}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 178, faceId = 1}
    }
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 177, faceId = 5}
    }
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 178, faceId = 5}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 2,
    imgTween = {
      {
        imgId = 177,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        alpha = 0,
        posId = 4
      }
    },
    heroFace = {
      {imgId = 174, faceId = 4}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 6}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 74,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0
      },
      {imgId = 2, alpha = 0}
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [109] = {
    content = 1090,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [110] = {
    content = 1100,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 3
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dangerous",
        sheet = "Mus_Story_Dangerous",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "Skill_Sol_Passive",
        sheet = "Chara_Sol"
      }
    }
  },
  [111] = {content = 1110, contentType = 2},
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 5,
        alpha = 0
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 153, faceId = 4}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 10}
    }
  },
  [115] = {
    content = 1150,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [116] = {
    content = 1160,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0,
        posId = 1,
        alpha = 0
      },
      {
        imgId = 1171,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0,
        posId = 5,
        alpha = 0
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true
  },
  [118] = {
    content = 1180,
    contentType = 2,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 1171,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0
      }
    }
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 2,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1171,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0
      },
      {
        imgId = 117,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 151, faceId = 9}
    }
  },
  [124] = {
    content = 1240,
    contentType = 2,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
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
  [125] = {
    content = 1250,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        alpha = 0
      }
    },
    isEnd = true
  },
  [301] = {
    content = 81,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [302] = {
    content = 82,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 9
  },
  [501] = {
    content = 401,
    contentType = 3,
    speakerHeroId = 1051,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 151, faceId = 7}
    }
  },
  [502] = {
    content = 402,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 151,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    nextId = 41
  }
}
return AvgCfg_cpt_hb_s07
