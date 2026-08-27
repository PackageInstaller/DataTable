local AvgCfg_cpt04_e_12_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    contentShake = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg007",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg001",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
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
        imgPath = "croque_avg"
      },
      {
        imgId = 112,
        imgType = 3,
        alpha = 0,
        imgPath = "max_avg"
      },
      {
        imgId = 30,
        imgType = 3,
        alpha = 0,
        imgPath = "gabriel_avg"
      },
      {
        imgId = 27,
        imgType = 3,
        alpha = 0,
        imgPath = "adele_avg"
      },
      {
        imgId = 29,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false,
        shake = true,
        shakeIntensity = 1
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_BattleTension",
        sheet = "Mus_Story_BattleTension",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 5}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 6}
    }
  },
  [5] = {
    content = 50,
    contentType = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      },
      {
        cue = "Skill_Sol_Hit",
        sheet = "Chara_Sol"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_Purifier",
        sheet = "Mus_Story_Purifier",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 103, faceId = 3}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 101, faceId = 2}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
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
    speakerHeroId = 1003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    branch = {
      {content = 171, jumpAct = 18},
      {content = 172, jumpAct = 18}
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 3}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 30, faceId = 4}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 30,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 30,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 30, faceId = 0}
    }
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 30,
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
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [31] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false
      }
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0.6,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 5,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0.6,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 321, jumpAct = 33},
      {content = 322, jumpAct = 35}
    },
    heroFace = {
      {imgId = 103, faceId = 5}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 101, faceId = 2}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    nextId = 37,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    audio = {
      bgm = {
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 103, faceId = 3}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0},
      {imgId = 101, faceId = 0}
    }
  },
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 112, faceId = 2}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    contentShake = true,
    speakerHeroId = 27,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 112, faceId = 0}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true,
        rot = {
          0,
          180,
          0
        }
      },
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 105,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 105, faceId = 1}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1003,
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
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1012,
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
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 27, faceId = 1}
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 27, faceId = 0}
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 27, faceId = 1}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    branch = {
      {content = 621, jumpAct = 63},
      {content = 622, jumpAct = 77}
    },
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 2,
    audio = {
      bgm = {
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 2,
        fadeOut = 3
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 102, faceId = 1}
    }
  },
  [74] = {
    content = 740,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    nextId = 89,
    heroFace = {
      {imgId = 101, faceId = 2}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1,
    audio = {
      bgm = {
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 2,
        fadeOut = 3
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 1
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 1
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 102, faceId = 2}
    }
  },
  [89] = {
    content = 890,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 101, faceId = 2}
    }
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 1002,
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
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 991, jumpAct = 100},
      {content = 992, jumpAct = 102}
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    nextId = 105,
    heroFace = {
      {imgId = 102, faceId = 1}
    }
  },
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 11
  },
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 102, faceId = 1}
    }
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 102,
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
      {imgId = 101, faceId = 2}
    }
  },
  [106] = {
    content = 1060,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 2,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [109] = {
    content = 1090,
    contentType = 3,
    contentShake = true,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 102,
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
        alpha = 0,
        isDark = true
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 1}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 102, faceId = 2}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    }
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 103,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 27, faceId = 0}
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 2
  },
  [119] = {
    content = 1190,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 112, faceId = 0}
    }
  },
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 112, faceId = 2}
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 27,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 27, faceId = 1}
    }
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1012,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 112, faceId = 0}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 112,
        delay = 0,
        duration = 0.2,
        posId = 2,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 5}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 0}
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [129] = {
    content = 1290,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 1.5,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 2,
        duration = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 29,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [130] = {
    content = 1300,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [131] = {
    content = 1310,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [132] = {
    content = 1320,
    contentType = 1,
    scrambleTypeWriter = true
  }
}
return AvgCfg_cpt04_e_12_01
