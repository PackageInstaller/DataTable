local AvgCfg_cpt_helix_03_03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg004",
        fullScreen = true
      },
      {
        imgId = 44,
        imgType = 3,
        alpha = 0,
        imgPath = "helios_robotred_avg"
      },
      {
        imgId = 116,
        imgType = 3,
        alpha = 0,
        imgPath = "banxsy_avg"
      },
      {
        imgId = 161,
        imgType = 3,
        alpha = 0,
        imgPath = "helix_avg"
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
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0.6,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 116,
        delay = 0.6,
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
      {imgId = 161, faceId = 6}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 8}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 116, faceId = 7}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
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
      {imgId = 116, faceId = 0}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 8}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 5}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 2}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 5}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 5}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 0}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 116, faceId = 2}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 3}
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [35] = {
    content = 350,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 2,
    imgTween = {
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 2}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Exiles",
        sheet = "Mus_Story_Exiles",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 4}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 2}
    }
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1061,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 5}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1016,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 116, faceId = 3}
    }
  },
  [49] = {
    content = 490,
    contentType = 2,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1061,
    contentShake = true,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 1}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1016,
    imgTween = {
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 2}
    }
  },
  [52] = {
    content = 520,
    contentType = 3,
    speakerHeroId = 1016
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 43,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 44, faceId = 6}
    }
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 1016,
    imgTween = {
      {
        imgId = 44,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 116, faceId = 1}
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1016
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1061,
    contentShake = true,
    imgTween = {
      {
        imgId = 116,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 161, faceId = 5}
    }
  },
  [57] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 161,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_cpt_helix_03_03
