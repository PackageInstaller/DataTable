local AvgCfg_cpt00_e_01_02 = {
  [1] = {
    autoContinue = true,
    bgColor = 2,
    SkipScenario = 11,
    storyAvgId = 101
  },
  [2] = {
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
    content = 20,
    contentType = 4,
    speakerName = 21,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_cg002",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg008",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg007_1",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
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
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 1,
        delay = 1.2,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 2
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
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 21
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 21,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 2
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 21
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 21,
    contentShake = true
  },
  [7] = {
    contentShake = true,
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 2
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 22
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 23
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 24,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        shakeIntensity = 2
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Explode",
        sheet = "AVG_gf"
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 23
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 24
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 24,
    contentShake = true
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 24,
    contentShake = true
  },
  [16] = {content = 160, contentType = 2},
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 24
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 121,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 23,
    contentShake = true
  },
  [20] = {
    contentShake = true,
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        shake = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Gatling_gun",
        sheet = "AVG_gf"
      }
    },
    effect = {
      stopList = {"effect1"}
    }
  },
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 24,
    audio = {
      sfx = {
        cue = "Atk_Zion_Hit",
        sheet = "Chara_Zion"
      }
    }
  },
  [22] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        scale = {
          1.3,
          1.3,
          1.3
        },
        pos = {
          100,
          100,
          0
        },
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Passion",
        sheet = "Mus_Story_Passion",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 4,
    speakerName = 26
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 27
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 28,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        scale = {
          1.3,
          1.3,
          1.3
        },
        pos = {
          -200,
          100,
          0
        },
        duration = 1,
        alpha = 1
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        scale = {
          1.3,
          1.3,
          1.3
        },
        pos = {
          200,
          -100,
          0
        },
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Croque_Ex_Start",
        sheet = "Chara_Croque"
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 23
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 24
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 27,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        scale = {
          1.3,
          1.3,
          1.3
        },
        pos = {
          300,
          -100,
          0
        },
        duration = 1,
        alpha = 1
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 23
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 27
  },
  [32] = {
    content = 320,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        scale = {
          1.3,
          1.3,
          1.3
        },
        pos = {
          350,
          -10,
          0
        },
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Persicaria_Ex_Start",
        sheet = "Chara_Persicaria"
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 27,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
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
        duration = 1,
        alpha = 1
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 22
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 24
  },
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 24
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 27
  },
  [38] = {
    content = 380,
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
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 1,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 1,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0,
        posId = 5,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 1,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 4}
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
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 0}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 105, faceId = 1}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 11}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
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
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
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
    contentType = 4,
    speakerName = 29,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  }
}
return AvgCfg_cpt00_e_01_02
