local AvgCfg_24oath_hubblesp = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 12,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg067",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg013_3",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef003",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "oath/oath_hubblesp"
      },
      {
        imgId = 181,
        imgType = 3,
        alpha = 0,
        imgPath = "hubble_sp_avg"
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
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
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 1,
        duration = 0.6,
        alpha = 1,
        isDark = true
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
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 12
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 12
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true,
        pos = {
          0,
          -480,
          0
        },
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.1,
        alpha = 0,
        shake = true,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.1,
        alpha = 0,
        shake = true
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 3,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 71,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 0.1,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.1,
        duration = 0.1,
        alpha = 1
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1002,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg007_7",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef003",
        fullScreen = true,
        delete = true
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg",
        delete = true
      }
    },
    imgTween = {
      {
        imgId = 102,
        delay = 0,
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
    },
    heroFace = {
      {imgId = 102, faceId = 11}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 13}
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 2}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1081
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 0}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 11}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1002,
    heroFace = {
      {imgId = 102, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 9}
    }
  },
  [22] = {
    content = 220,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 12}
    }
  },
  [24] = {
    content = 240,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
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
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 7}
    }
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1002,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 0}
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1002
  },
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [31] = {content = 310, contentType = 2},
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 4}
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 4}
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 9}
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [40] = {content = 400, contentType = 2},
  [41] = {
    content = 410,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = true,
        pos = {
          -250,
          -600,
          0
        },
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 3}
    }
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [49] = {content = 490, contentType = 2},
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [51] = {
    content = 510,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 3}
    }
  },
  [54] = {
    content = 540,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 11
  },
  [57] = {content = 570, contentType = 2},
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
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
    }
  },
  [62] = {
    content = 620,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg067",
        fullScreen = true
      },
      {
        imgId = 181,
        imgType = 3,
        alpha = 0,
        imgPath = "hubble_sp_avg",
        delete = true
      },
      {
        imgId = 181,
        imgType = 3,
        alpha = 0,
        imgPath = "hubble_sp_oath_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [63] = {content = 630, contentType = 2},
  [64] = {
    content = 640,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_Door_Open_Close",
        sheet = "AVG_gf"
      }
    }
  },
  [65] = {
    content = 650,
    contentType = 2,
    images = {
      {
        imgId = 11,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 1.6,
        duration = 1,
        alpha = 0
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
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
  [67] = {content = 670, contentType = 2},
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11
  },
  [69] = {content = 690, contentType = 2},
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 181,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 2}
    }
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
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
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [73] = {
    content = 730,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 3}
    }
  },
  [77] = {
    content = 770,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [78] = {
    content = 780,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1081
  },
  [81] = {
    content = 810,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [83] = {
    content = 830,
    contentType = 2,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [84] = {content = 840, contentType = 2},
  [85] = {content = 850, contentType = 2},
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 181,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 2}
    }
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [88] = {content = 880, contentType = 2},
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 4}
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 0}
    }
  },
  [91] = {
    content = 910,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
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
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 4}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 4,
    speakerName = 11
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -400,
          0
        },
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [99] = {content = 990, contentType = 2},
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 11
  },
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 11
  },
  [102] = {
    content = 1020,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [103] = {
    content = 1030,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -550,
          0
        },
        scale = {
          1.5,
          1.5,
          1.5
        }
      },
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [105] = {
    content = 1050,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [106] = {
    content = 1060,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1081
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
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
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 3}
    }
  },
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [111] = {
    content = 1110,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 2}
    }
  },
  [115] = {
    content = 1150,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
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
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 2}
    }
  },
  [117] = {
    content = 1170,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [119] = {
    content = 1190,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [120] = {content = 1200, contentType = 2},
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = false,
        scale = {
          1.5,
          1.5,
          1.5
        }
      }
    },
    heroFace = {
      {imgId = 181, faceId = 4}
    }
  },
  [122] = {
    content = 1220,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [123] = {content = 1230, contentType = 2},
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [125] = {
    content = 1250,
    contentType = 3,
    speakerHeroId = 1081,
    heroFace = {
      {imgId = 181, faceId = 5}
    }
  },
  [126] = {
    content = 1260,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 181, faceId = 1}
    }
  },
  [128] = {
    content = 1280,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 1081,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [130] = {
    content = 1300,
    contentType = 2,
    imgTween = {
      {
        imgId = 181,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [131] = {
    content = 1310,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [132] = {
    content = 1320,
    contentType = 4,
    speakerName = 12
  },
  [133] = {
    content = 1330,
    contentType = 4,
    speakerName = 12
  },
  [134] = {
    content = 1340,
    contentType = 4,
    speakerName = 12
  }
}
return AvgCfg_24oath_hubblesp
