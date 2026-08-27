local AvgCfg_cpt_kuro_04_02 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg012_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt00/cpt00_e_bg012",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg002",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg002_2",
        fullScreen = true
      },
      {
        imgId = 7,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg005",
        pos = {
          0,
          -1200,
          0
        },
        scale = {
          2.2,
          2.2,
          2.2
        },
        order = 5
      },
      {
        imgId = 8,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg005_2",
        pos = {
          0,
          -1200,
          0
        },
        scale = {
          2.2,
          2.2,
          2.2
        },
        order = 6
      },
      {
        imgId = 155,
        imgType = 3,
        alpha = 0,
        imgPath = "kuro_avg"
      },
      {
        imgId = 118,
        imgType = 3,
        alpha = 0,
        imgPath = "nanaka_avg",
        ripple = true
      },
      {
        imgId = 65,
        imgType = 3,
        alpha = 0,
        imgPath = "reverence_avg"
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
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 2,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 2,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 3,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 2,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 4,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 7,
        delay = 4,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 8,
        delay = 5,
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 8,
        delay = 6,
        duration = 2,
        alpha = 1,
        pos = {
          0,
          1200,
          0
        },
        isDark = false
      },
      {
        imgId = 8,
        delay = 6,
        duration = 3,
        alpha = 1,
        scale = {
          1.85,
          1.85,
          1.85
        },
        isDark = false
      },
      {
        imgId = 7,
        delay = 9,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 9,
        duration = 0,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_SC_Short",
        sheet = "Mus_Boss_Purifier_SC_Short",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg012_2",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg002",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 7,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg005",
        pos = {
          0,
          -1200,
          0
        },
        scale = {
          2.2,
          2.2,
          2.2
        },
        delete = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg001",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 8,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.6,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 6,
        delay = 1.6,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 2.6,
        duration = 0,
        alpha = 0
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 2,
    contentShake = true,
    images = {
      {
        imgId = 8,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg005_2",
        pos = {
          0,
          0,
          0
        },
        scale = {
          2.2,
          2.2,
          2.2
        },
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 1.2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 65, faceId = 3}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 2
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1055,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 155,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 155,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1055,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 155, faceId = 2}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 65,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 155,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1055,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 65,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 155,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 155,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 155, faceId = 0}
    }
  },
  [9] = {
    content = 90,
    contentType = 2,
    images = {
      {
        imgId = 34,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg002_3",
        fullScreen = true,
        order = 5
      },
      {
        imgId = 12,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt00/cpt00_e_bg012_3",
        fullScreen = true,
        order = 8
      }
    },
    imgTween = {
      {
        imgId = 155,
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
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 34,
        delay = 1.2,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 34,
        delay = 1.8,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 1.8,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1.8,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 2.4,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 34,
        delay = 2.4,
        duration = 0,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 3,
        duration = 0,
        alpha = 0
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    images = {
      {
        imgId = 34,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg002_3",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 3,
        imgPath = "cpt06/cpt06_e_bg002_2",
        fullScreen = true,
        delete = true
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1018,
    speakerHeroPosId = 2,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [13] = {content = 130, contentType = 2},
  [14] = {content = 140, contentType = 2},
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1018,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 118,
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
    speakerHeroId = 1018,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 118, faceId = 1}
    }
  },
  [18] = {
    bgColor = 3,
    content = 180,
    contentType = 3,
    speakerHeroId = 1018,
    speakerHeroPosId = 2,
    contentShake = true,
    heroFace = {
      {imgId = 118, faceId = 11}
    }
  },
  [19] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 12,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 118,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_cpt_kuro_04_02
