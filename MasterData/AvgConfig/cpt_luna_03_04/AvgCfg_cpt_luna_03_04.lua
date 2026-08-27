local AvgCfg_cpt_luna_03_04 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 1074,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_3",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg039",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg057",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt07/cpt07_e_bg002_2",
        fullScreen = true
      },
      {
        imgId = 6,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_cg039",
        fullScreen = true
      },
      {
        imgId = 146,
        imgType = 3,
        alpha = 0,
        imgPath = "earhart_avg"
      },
      {
        imgId = 171,
        imgType = 3,
        alpha = 0,
        imgPath = "yelena_avg"
      },
      {
        imgId = 174,
        imgType = 3,
        alpha = 0,
        imgPath = "luna_avg"
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 2,
        delay = 1.2,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 2,
        duration = 1,
        alpha = 1
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
        delay = 3,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 174,
        delay = 3.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
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
      {imgId = 174, faceId = 3}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 6}
    }
  },
  [4] = {
    bgColor = 3,
    content = 40,
    contentType = 2,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.75
      }
    }
  },
  [5] = {
    autoContinue = true,
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
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [7] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 174,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 6}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1074,
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1074,
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [11] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [13] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 15,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [15] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 174,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 3}
    }
  },
  [17] = {
    autoContinue = true,
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
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 16,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.5
      }
    }
  },
  [19] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 174,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 4}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1074,
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1074
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1074,
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 17,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 14,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 14
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 174,
        delay = 0.6,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 3}
    }
  },
  [28] = {
    content = 280,
    contentType = 2,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 2,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 17,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1074,
    contentShake = true,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 2}
    }
  },
  [32] = {
    content = 320,
    contentType = 2,
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
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 3,
        duration = 1,
        alpha = 1
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1046,
    contentShake = true,
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
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
      {imgId = 146, faceId = 5}
    }
  },
  [34] = {
    imgTween = {
      {
        imgId = 146,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    branch = {
      {content = 341, jumpAct = 35},
      {content = 342, jumpAct = 35}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1074,
    contentShake = true,
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
      {imgId = 174, faceId = 0}
    }
  },
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 6}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1071,
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
        imgId = 171,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 171, faceId = 1}
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 171,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [40] = {
    bgColor = 2,
    content = 400,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [41] = {
    content = 410,
    contentType = 2,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Dorm",
        sheet = "Mus_Dorm",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 6,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [43] = {
    content = 430,
    speakerName = 12,
    contentType = 4
  },
  [44] = {content = 440, contentType = 2},
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 12
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 12
  },
  [48] = {
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 6,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1074,
    imgTween = {
      {
        imgId = 174,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 174, faceId = 0}
    }
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1074
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1074,
    heroFace = {
      {imgId = 174, faceId = 1}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
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
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 12,
    contentShake = true
  }
}
return AvgCfg_cpt_luna_03_04
