local AvgCfg_24summer_s05 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 3306205,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg001",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon_avg"
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_wings_avg"
      }
    },
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
        shake = true,
        shakeIntensity = 3
      },
      {
        imgId = 5,
        delay = 1,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 1.6,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_XS",
        sheet = "Mus_Boss_Purifier_XS",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
        scale = {
          1.15,
          1.15,
          1.15
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
      sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
    }
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [5] = {
    content = 50,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 6}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
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
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true,
        shakeIntensity = 3
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
    audio = {
      sfx = {cue = "AVG_broken", sheet = "AVG"}
    }
  },
  [12] = {content = 120, contentType = 2},
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 10}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 6}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true,
        shakeIntensity = 10
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Eos_EX_Cast",
        sheet = "Chara_Eos"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true,
        shakeIntensity = 5
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_smook",
        layer = 2,
        pos = {
          0,
          -150,
          0
        }
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Fakegod_01",
        sheet = "Mon_Fakegod"
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 2,
    effect = {
      stopList = {"effect1"}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 37,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 10}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 38
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 6}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 4}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 37
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 3}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
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
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 7}
    }
  },
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Eos_EX_Cast",
        sheet = "Chara_Eos"
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 37,
    contentShake = true,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [41] = {
    content = 410,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        shake = true,
        isDark = false
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
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 6}
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
      }
    }
  },
  [45] = {content = 450, contentType = 2},
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [49] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 38,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [50] = {
    ppv = {
      cg = {saturation = -40}
    },
    content = 500,
    contentType = 3,
    speakerHeroId = 37,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt11/cpt11_e_bg001",
        fullScreen = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon_avg",
        delete = true
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_wings_avg",
        delete = true
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg"
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg",
        order = 5
      },
      {
        imgId = 96,
        imgType = 3,
        alpha = 0,
        imgPath = "eos2_avg",
        order = 5
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Sector_5",
        sheet = "Mus_Sector_5",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [58] = {
    content = 580,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 2
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 37, faceId = 1}
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 96,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 2}
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 96,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 5}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 1}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 38,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 96,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 2}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 37,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [77] = {
    content = 770,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 8}
    }
  },
  [79] = {
    content = 790,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [82] = {
    content = 820,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 1}
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 96,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 96, faceId = 0}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 96,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 8}
    }
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [92] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 38,
    contentShake = true,
    images = {
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg",
        delete = true
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_w2_avg",
        order = 5
      },
      {
        imgId = 96,
        imgType = 3,
        alpha = 0,
        imgPath = "eos2_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
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
        cue = "Mus_Story_Depressed",
        sheet = "Mus_Story_Depressed",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 37,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 37,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 1}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 3}
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [99] = {content = 990, contentType = 2},
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 0}
    }
  },
  [102] = {
    content = 1020,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_footsteps_cave",
        sheet = "AVG_gf"
      }
    }
  },
  [103] = {
    content = 1030,
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
  [104] = {content = 1040, contentType = 2},
  [105] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 37,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    images = {
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg"
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_w2_avg",
        delete = true
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 38,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dark",
        sheet = "Mus_Story_Dark",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 17}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 7}
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [110] = {
    content = 1100,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 1}
    }
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 37
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [115] = {
    content = 1150,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 17}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 37
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 0}
    }
  },
  [119] = {
    content = 1190,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
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
  [120] = {
    content = 1200,
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
  [121] = {content = 1210, contentType = 2},
  [122] = {autoContinue = true},
  [123] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1230,
    contentType = 3,
    speakerHeroId = 38,
    images = {
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_weapon_avg"
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_wings_avg"
      },
      {
        imgId = 38,
        imgType = 3,
        alpha = 0,
        imgPath = "hesperus_avg",
        delete = true
      },
      {
        imgId = 37,
        imgType = 3,
        alpha = 0,
        imgPath = "eosphorus_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV3_Story_Hesperus",
        sheet = "Mus_EV3_Story_Hesperus",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 38, faceId = 2}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 38
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 4}
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 5}
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 11}
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 37,
    heroFace = {
      {imgId = 37, faceId = 9}
    }
  },
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 38, faceId = 6}
    }
  },
  [130] = {
    content = 1300,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_Raven",
        sheet = "Mus_Boss_Purifier_Raven",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "Skill_Odile_04_Loop",
        sheet = "Mon_Odile",
        audioId = 1
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 2,
    effect = {
      effect2 = {
        prefabName = "avg/FXP_smook",
        layer = 2,
        pos = {
          0,
          0,
          0
        }
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 38,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 38,
    heroFace = {
      {imgId = 38, faceId = 7}
    }
  },
  [134] = {
    content = 1340,
    contentType = 2,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [135] = {
    content = 1350,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true,
        shakeIntensity = 5
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.75
      }
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 37,
    imgTween = {
      {
        imgId = 38,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 37, faceId = 4}
    }
  },
  [137] = {
    content = 1370,
    contentType = 2,
    imgTween = {
      {
        imgId = 37,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    effect = {
      effect3 = {
        prefabName = "avg/FXP_Scene"
      }
    }
  },
  [138] = {
    content = 1380,
    contentType = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        shake = true,
        shakeIntensity = 10
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [139] = {content = 1390, contentType = 2}
}
return AvgCfg_24summer_s05
