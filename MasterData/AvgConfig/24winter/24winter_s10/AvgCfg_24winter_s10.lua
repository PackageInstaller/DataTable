local AvgCfg_24winter_s10 = {
  [1] = {
    SkipScenario = 18,
    storyAvgId = 4000311,
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg034",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg072",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_cg047",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg039",
        fullScreen = true
      },
      {
        imgId = 242,
        imgType = 3,
        alpha = 0,
        imgPath = "chris_avg"
      },
      {
        imgId = 129,
        imgType = 3,
        alpha = 0,
        imgPath = "tony_avg"
      },
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_sp_avg"
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
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {content = 30, contentType = 2},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 0}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 4,
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
      {imgId = 139, faceId = 3}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 242,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 4}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 0}
    }
  },
  [9] = {
    content = 90,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 242,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
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
      {imgId = 242, faceId = 2}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 242,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 4}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 5}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
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
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 1}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 242,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1039,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [19] = {
    content = 190,
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
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
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
      },
      {
        imgId = 139,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 11}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 242, faceId = 7}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 242
  },
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 242,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 2,
    images = {
      {
        imgId = 242,
        imgType = 3,
        alpha = 0,
        imgPath = "chris_avg",
        delete = true
      },
      {
        imgId = 246,
        imgType = 3,
        alpha = 0,
        imgPath = "chris_avg"
      }
    },
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 246, faceId = 991}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 71}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 246,
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
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 246, faceId = 991}
    }
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 246,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [31] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 246,
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
    }
  },
  [32] = {
    content = 320,
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
  [33] = {content = 330, contentType = 2},
  [34] = {
    content = 340,
    contentType = 2,
    contentShake = true
  },
  [35] = {content = 350, contentType = 2},
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
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
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 992}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 246, faceId = 72}
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 11}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1039
  },
  [43] = {
    content = 430,
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
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
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
  [44] = {
    autoContinue = true,
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
  [45] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 450,
    contentType = 3,
    speakerHeroId = 10391,
    images = {
      {
        imgId = 10391,
        imgType = 3,
        alpha = 0,
        posId = 3,
        imgPath = "oasis_01b_avg",
        comm = true
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
        imgId = 10391,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 10391
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 10391
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 10391
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 10391
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 11
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 11
  },
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 10391
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 10391
  },
  [56] = {
    autoContinue = true,
    images = {
      {
        imgId = 10391,
        imgType = 3,
        alpha = 0,
        imgPath = "oasis_01b_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [57] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 570,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 139,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 42}
    }
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1039,
    contentShake = true,
    imgTween = {
      {
        imgId = 246,
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
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 139, faceId = 7}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 992}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 246, faceId = 42}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 246, faceId = 992}
    }
  },
  [63] = {
    content = 630,
    contentType = 2,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 7}
    }
  },
  [66] = {
    content = 660,
    contentType = 2,
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
  [67] = {content = 670, contentType = 2},
  [68] = {
    content = 680,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 72}
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 139,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 139, faceId = 11}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 242,
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
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 42}
    }
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 242,
    heroFace = {
      {imgId = 246, faceId = 72}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 242
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 242
  },
  [74] = {
    content = 740,
    contentType = 2,
    imgTween = {
      {
        imgId = 246,
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
      },
      {
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [75] = {content = 750, contentType = 2},
  [76] = {
    content = 760,
    contentType = 4,
    speakerName = 13
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 13
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
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
        imgId = 246,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 22}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 242
  },
  [81] = {
    content = 810,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
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
  [83] = {autoContinue = true},
  [84] = {
    images = {
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_sp_avg",
        delete = true
      },
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_avg"
      }
    },
    ppv = {
      cg = {saturation = -70}
    },
    content = 840,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 139,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 12,
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
        imgId = 4,
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
        imgId = 139,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 4,
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
        imgId = 139,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 4,
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
        imgId = 139,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 4,
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
        imgId = 139,
        delay = 1.2,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [89] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [90] = {
    ppv = {
      cg = {saturation = 0}
    },
    images = {
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_avg",
        delete = true
      },
      {
        imgId = 139,
        imgType = 3,
        alpha = 0,
        imgPath = "centaureissi_sp_avg"
      }
    },
    content = 900,
    contentType = 2
  },
  [91] = {
    content = 910,
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
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 242,
    imgTween = {
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 42}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 246,
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
      {imgId = 139, faceId = 3}
    }
  },
  [94] = {
    content = 940,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [95] = {
    content = 950,
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
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1039,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 139, faceId = 2}
    }
  },
  [97] = {
    content = 970,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 139,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Passion",
        sheet = "Mus_Story_Passion",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 11
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 2,
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
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 11
  },
  [103] = {
    content = 1030,
    contentType = 4,
    speakerName = 11
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [105] = {
    content = 1050,
    contentType = 3,
    speakerHeroId = 242,
    contentShake = true,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 246,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 246, faceId = 22}
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1039,
    imgTween = {
      {
        imgId = 246,
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
      {imgId = 139, faceId = 3}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1039,
    heroFace = {
      {imgId = 139, faceId = 3}
    }
  },
  [108] = {
    content = 1080,
    contentType = 2,
    imgTween = {
      {
        imgId = 139,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [109] = {
    content = 1090,
    contentType = 4,
    speakerName = 11,
    imgTween = {
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
    speakerName = 11
  }
}
return AvgCfg_24winter_s10
