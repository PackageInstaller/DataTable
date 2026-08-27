local AvgCfg_23sg_b3_02 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 4500111,
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg062",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg063_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_cg003",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "sg/sg_e_cg003_2",
        fullScreen = true
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_avg"
      },
      {
        imgId = 197,
        imgType = 3,
        alpha = 0,
        imgPath = "cocytus_avg"
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_b_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img25_Self affirmation",
        sheet = "Mus_SteinsGate_img25_Self affirmation",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {content = 60, contentType = 2},
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 1,
        delay = 1.2,
        duration = 1,
        alpha = 0,
        scale = {
          1.4,
          1.4,
          1.4
        }
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Door_Open_Close",
        sheet = "AVG_gf"
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [12] = {content = 120, contentType = 2},
  [13] = {content = 130, contentType = 2},
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
        alpha = 1,
        isDark = true
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 101,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        isDark = true,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 999,
        delay = 0.8,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.8,
        duration = 0.6,
        shake = true
      }
    }
  },
  [20] = {content = 200, contentType = 2},
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        scale = {
          1,
          1,
          1
        }
      }
    },
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img24_hesitative consideration",
        sheet = "Mus_SteinsGate_img24_hesitative consideration",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [23] = {
    content = 230,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11
  },
  [27] = {
    content = 270,
    contentType = 4,
    speakerName = 11
  },
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 11
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 999,
        delay = 0.8,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        scale = {
          1.2,
          1.2,
          1.2
        }
      },
      {
        imgId = 1,
        delay = 0.8,
        duration = 0.6,
        shake = true
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 11
  },
  [33] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [34] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 340,
    contentType = 3,
    speakerHeroId = 2003,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 2003,
    contentShake = true,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  },
  [36] = {
    content = 360,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
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
        imgId = 202,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = true,
        pos = {
          0,
          -800,
          0
        },
        scale = {
          1.6,
          1.6,
          1.6
        }
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [37] = {content = 370, contentType = 2},
  [38] = {content = 380, contentType = 2},
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0.75,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [44] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [45] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 450,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img31_Solitude",
        sheet = "Mus_SteinsGate_img31_Solitude",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 11
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [53] = {
    content = 530,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 1,
        duration = 1,
        alpha = 0,
        isDark = false
      }
    },
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 1
      }
    }
  },
  [54] = {autoContinue = true},
  [55] = {
    content = 550,
    contentType = 2,
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 1
      }
    }
  },
  [56] = {content = 560, contentType = 2},
  [57] = {content = 570, contentType = 2},
  [58] = {content = 580, contentType = 2},
  [59] = {content = 590, contentType = 2},
  [60] = {content = 600, contentType = 2},
  [61] = {content = 610, contentType = 2},
  [62] = {content = 620, contentType = 2},
  [63] = {
    content = 630,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0,
        scale = {
          1,
          1,
          1
        }
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
        delay = 1.2,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 197,
        delay = 2,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 197,
        delay = 3.5,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [64] = {content = 640, contentType = 2},
  [65] = {content = 650, contentType = 2},
  [66] = {content = 660, contentType = 2},
  [67] = {content = 670, contentType = 2},
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 681
  },
  [69] = {
    content = 690,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1.2,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 4,
    speakerName = 11
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 12
  },
  [72] = {
    content = 720,
    contentType = 4,
    speakerName = 11
  },
  [73] = {
    content = 730,
    contentType = 4,
    speakerName = 11
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 12
  },
  [75] = {content = 750, contentType = 2},
  [76] = {
    content = 760,
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
  [77] = {content = 770, contentType = 2},
  [78] = {content = 780, contentType = 2},
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -800,
          0
        },
        scale = {
          1.6,
          1.6,
          1.6
        }
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.9,
        duration = 0.2,
        shake = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 2}
    }
  },
  [80] = {
    content = 800,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [81] = {content = 810, contentType = 2},
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11
  },
  [85] = {
    content = 850,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 4,
    speakerName = 11
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 11
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 11
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 2}
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [92] = {
    content = 920,
    contentType = 4,
    speakerName = 11
  },
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [94] = {content = 940, contentType = 2},
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 1}
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 2}
    }
  },
  [97] = {
    content = 970,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
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
    contentShake = true
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 11
  },
  [100] = {
    content = 1000,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
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
    speakerName = 12
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 12
  },
  [105] = {
    content = 1050,
    contentType = 4,
    speakerName = 12
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 12
  },
  [108] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [109] = {
    content = 1090,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 101,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    ppv = {
      cg = {saturation = -70}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img21_SERN",
        sheet = "Mus_SteinsGate_img21_SERN",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [111] = {
    content = 1110,
    contentType = 4,
    speakerName = 11
  },
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [113] = {
    content = 1130,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [116] = {
    content = 1160,
    contentType = 2,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 7}
    }
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [119] = {
    content = 1190,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [120] = {
    content = 1200,
    contentType = 4,
    speakerName = 11
  },
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [122] = {
    content = 1220,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [123] = {
    content = 1230,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [125] = {
    content = 1250,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 14}
    }
  },
  [127] = {
    content = 1270,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 11}
    }
  },
  [129] = {
    content = 1290,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [130] = {
    content = 1300,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [132] = {
    content = 1320,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 0}
    }
  },
  [133] = {
    content = 1330,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [135] = {
    content = 1350,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false,
        scale = {
          1.1,
          1.1,
          1.1
        }
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [136] = {
    content = 1360,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [138] = {
    content = 1380,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [140] = {
    content = 1400,
    contentType = 3,
    speakerHeroId = 1001,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img31_Solitude",
        sheet = "Mus_SteinsGate_img31_Solitude",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [141] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 101,
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
      },
      {
        imgId = 197,
        delay = 0.6,
        duration = 0.6,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 197,
        delay = 2,
        duration = 0.6,
        alpha = 0,
        isDark = true
      }
    }
  },
  [142] = {
    content = 1420,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 999, faceId = 8}
    }
  },
  [144] = {
    content = 1440,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 6}
    }
  },
  [145] = {
    content = 1450,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 15}
    }
  },
  [146] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 999,
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
  [147] = {
    content = 1470,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    ppv = {
      cg = {saturation = 0}
    }
  },
  [148] = {
    content = 1480,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [149] = {
    content = 1490,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [150] = {
    content = 1500,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [151] = {
    content = 1510,
    contentType = 4,
    speakerName = 11
  },
  [152] = {
    content = 1520,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [153] = {
    content = 1530,
    contentType = 4,
    speakerName = 11
  },
  [154] = {
    content = 1540,
    contentType = 4,
    speakerName = 11
  },
  [155] = {
    content = 1550,
    contentType = 4,
    speakerName = 11
  },
  [156] = {
    content = 1560,
    contentType = 4,
    speakerName = 11
  },
  [157] = {content = 1570, contentType = 2},
  [158] = {content = 1580, contentType = 2},
  [159] = {
    content = 1590,
    contentType = 4,
    speakerName = 12
  },
  [160] = {
    content = 1600,
    contentType = 4,
    speakerName = 12
  },
  [161] = {
    content = 1610,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    }
  },
  [162] = {content = 1620, contentType = 2},
  [163] = {
    content = 1630,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 3,
        delay = 1,
        duration = 0.6,
        isDark = false
      }
    }
  },
  [164] = {content = 1640, contentType = 2},
  [165] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [166] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 1660,
    contentType = 3,
    speakerHeroId = 1001,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 101,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 101, faceId = 13}
    }
  },
  [167] = {
    content = 1670,
    contentType = 3,
    speakerHeroId = 1001,
    heroFace = {
      {imgId = 101, faceId = 14}
    }
  },
  [168] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 101,
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
  [169] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1690,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [170] = {content = 1700, contentType = 2},
  [171] = {
    content = 1710,
    contentType = 2,
    contentShake = true
  },
  [172] = {
    content = 1720,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 1.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [173] = {
    content = 1730,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    }
  },
  [174] = {content = 1740, contentType = 2},
  [175] = {
    content = 1750,
    contentType = 4,
    speakerName = 12
  },
  [176] = {
    content = 1760,
    contentType = 4,
    speakerName = 12
  },
  [177] = {
    content = 1770,
    contentType = 4,
    speakerName = 12
  },
  [178] = {
    content = 1780,
    contentType = 4,
    speakerName = 11
  },
  [179] = {
    content = 1790,
    contentType = 4,
    speakerName = 12
  },
  [180] = {
    content = 1800,
    contentType = 4,
    speakerName = 11
  },
  [181] = {
    content = 1810,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        sheet = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [182] = {
    content = 1820,
    contentType = 4,
    speakerName = 12
  },
  [183] = {
    content = 1830,
    contentType = 4,
    speakerName = 12
  },
  [184] = {
    content = 1840,
    contentType = 4,
    speakerName = 12
  },
  [185] = {
    content = 1850,
    contentType = 4,
    speakerName = 12
  },
  [186] = {
    content = 1860,
    contentType = 4,
    speakerName = 12
  },
  [187] = {
    content = 1870,
    contentType = 4,
    speakerName = 11
  },
  [188] = {content = 1880, contentType = 2},
  [189] = {
    content = 1890,
    contentType = 4,
    speakerName = 12
  },
  [190] = {
    bgColor = 3,
    content = 1900,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 2,
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
  [191] = {content = 1910, contentType = 2},
  [192] = {content = 1920, contentType = 2},
  [193] = {content = 1930, contentType = 2},
  [194] = {
    content = 1940,
    contentType = 4,
    speakerName = 11
  },
  [195] = {content = 1950, contentType = 2},
  [196] = {
    content = 1960,
    contentType = 1,
    contentShake = true
  }
}
return AvgCfg_23sg_b3_02
