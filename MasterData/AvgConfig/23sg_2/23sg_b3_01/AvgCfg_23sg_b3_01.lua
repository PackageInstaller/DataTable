local AvgCfg_23sg_b3_01 = {
  [1] = {
    SkipScenario = 1,
    storyAvgId = 4500110,
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg005_2",
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
        imgPath = "sg/sg_e_bg001",
        fullScreen = true
      },
      {
        imgId = 601,
        imgType = 3,
        alpha = 0,
        imgPath = "itaru_avg"
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
        imgId = 129,
        imgType = 3,
        alpha = 0,
        order = 5,
        imgPath = "slime_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tinnitus",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = true,
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.5,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Fire_Bonfire_loop",
        sheet = "AVG_gf",
        audioId = 1
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      }
    }
  },
  [5] = {content = 50, contentType = 2},
  [6] = {content = 60, contentType = 2},
  [7] = {
    content = 70,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 1,
        delay = 1.8,
        duration = 1,
        scale = {
          1,
          1,
          1
        }
      }
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img23_Chaos mind",
        sheet = "Mus_SteinsGate_img23_Chaos mind",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 11
  },
  [9] = {content = 90, contentType = 2},
  [10] = {content = 100, contentType = 2},
  [11] = {content = 110, contentType = 2},
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [14] = {content = 140, contentType = 2},
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    audio = {
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        pos = {
          -120,
          0,
          0
        },
        scale = {
          1.25,
          1.25,
          1.25
        }
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
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
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Slime_Movement",
        sheet = "AVG"
      }
    }
  },
  [19] = {content = 190, contentType = 2},
  [20] = {
    content = 200,
    contentType = 2,
    imgTween = {
      {
        imgId = 197,
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
  [21] = {content = 210, contentType = 2},
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        pos = {
          0,
          0,
          0
        },
        scale = {
          1,
          1,
          1
        }
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11
  },
  [27] = {content = 270, contentType = 2},
  [28] = {content = 280, contentType = 2},
  [29] = {content = 290, contentType = 2},
  [30] = {
    content = 300,
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
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 11
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [33] = {content = 330, contentType = 2},
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
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
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img04_Theme_full",
        sheet = "Mus_SteinsGate_img04_Theme_full",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [35] = {content = 350, contentType = 2},
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
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
        imgId = 202,
        delay = 0.8,
        duration = 0.2,
        shake = true
      }
    }
  },
  [38] = {
    content = 380,
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
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true,
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
    }
  },
  [40] = {
    content = 400,
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
  [41] = {
    content = 410,
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
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11
  },
  [43] = {content = 430, contentType = 2},
  [44] = {content = 440, contentType = 2},
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [46] = {
    content = 460,
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
  [47] = {
    content = 470,
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
      {imgId = 202, faceId = 8}
    }
  },
  [48] = {
    content = 480,
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
  [49] = {content = 490, contentType = 2},
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [52] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 202,
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
    },
    audio = {
      bgm = {stop = true},
      stopAudioId = {1}
    }
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 531
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img19_Explanation",
        sheet = "Mus_SteinsGate_img19_Explanation",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [56] = {content = 560, contentType = 2},
  [57] = {
    content = 570,
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
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 13,
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
  [60] = {
    content = 600,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  },
  [61] = {
    content = 610,
    contentType = 3,
    speakerHeroId = 2003,
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
      {imgId = 203, faceId = 4}
    }
  },
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 2003,
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 11
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 2003,
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 2003,
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
      {imgId = 203, faceId = 3}
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 2003,
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
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
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 0}
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 2003,
    heroFace = {
      {imgId = 203, faceId = 2}
    }
  },
  [76] = {
    content = 760,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
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
    }
  },
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [80] = {content = 800, contentType = 2},
  [81] = {content = 810, contentType = 2},
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [84] = {
    content = 840,
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
  [86] = {content = 860, contentType = 2},
  [87] = {
    content = 870,
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
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [90] = {
    content = 900,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
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
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [94] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        alpha = 0,
        isDark = false,
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
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [95] = {
    content = 950,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img11_kako",
        sheet = "Mus_SteinsGate_img11_kako",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
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
      {imgId = 203, faceId = 3}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 0}
    }
  },
  [98] = {
    content = 980,
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
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 11
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [102] = {
    content = 1020,
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
  [103] = {
    content = 1030,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 9}
    }
  },
  [104] = {
    content = 1040,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [105] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 202,
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
      }
    }
  },
  [106] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 1060,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 129,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 129,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 129,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 11}
    }
  },
  [109] = {
    content = 1090,
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
  [110] = {
    content = 1100,
    contentType = 3,
    speakerHeroId = 601,
    imgTween = {
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 601,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 601,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 601, faceId = 2}
    }
  },
  [111] = {
    content = 1110,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
      {
        imgId = 601,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
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
      {imgId = 999, faceId = 1}
    }
  },
  [112] = {
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
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [113] = {
    content = 1130,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        alpha = 0,
        pos = {
          -120,
          0,
          0
        },
        scale = {
          1.25,
          1.25,
          1.25
        }
      },
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 2,
    imgTween = {
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
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = true
      },
      {
        imgId = 197,
        delay = 0.8,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [115] = {content = 1150, contentType = 2},
  [116] = {
    content = 1160,
    contentType = 2,
    imgTween = {
      {
        imgId = 197,
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
        alpha = 0
      }
    }
  },
  [117] = {autoContinue = true},
  [118] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 1180,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [119] = {content = 1190, contentType = 2},
  [120] = {content = 1200, contentType = 2},
  [121] = {
    content = 1210,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [122] = {
    content = 1220,
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
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [125] = {
    content = 1250,
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
  [126] = {
    content = 1260,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [127] = {
    content = 1270,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 1}
    }
  },
  [128] = {
    content = 1280,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [129] = {
    content = 1290,
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
  [130] = {content = 1300, contentType = 2},
  [131] = {
    content = 1310,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [132] = {
    content = 1320,
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
  [133] = {
    content = 1330,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 0}
    }
  },
  [134] = {
    content = 1340,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 1}
    }
  },
  [135] = {
    content = 1350,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [136] = {content = 1360, contentType = 2},
  [137] = {
    content = 1370,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 0}
    }
  },
  [138] = {
    content = 1380,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 6}
    }
  },
  [139] = {
    content = 1390,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 8}
    }
  },
  [140] = {
    content = 1400,
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
  [141] = {
    content = 1410,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = true
      }
    }
  },
  [142] = {
    content = 1420,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
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
      {imgId = 202, faceId = 3}
    }
  },
  [143] = {
    content = 1430,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
    heroFace = {
      {imgId = 202, faceId = 3}
    }
  },
  [144] = {
    content = 1440,
    contentType = 4,
    speakerName = 11,
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
  [145] = {
    content = 1450,
    contentType = 4,
    speakerName = 11
  },
  [146] = {
    content = 1460,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [147] = {
    content = 1470,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [148] = {
    content = 1480,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [149] = {
    content = 1490,
    contentType = 3,
    speakerHeroId = 2003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  },
  [150] = {
    content = 1500,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 1}
    }
  },
  [151] = {
    content = 1510,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [152] = {
    content = 1520,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [153] = {content = 1530, contentType = 2},
  [154] = {
    content = 1540,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [155] = {
    content = 1550,
    contentType = 3,
    speakerHeroId = 2002,
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  },
  [156] = {
    content = 1560,
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
  [157] = {
    content = 1570,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
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
      {imgId = 202, faceId = 9}
    }
  },
  [158] = {
    content = 1580,
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 4}
    }
  },
  [159] = {
    autoContinue = true,
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_RunStep",
        sheet = "AVG_gf"
      }
    },
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
        alpha = 0
      }
    }
  },
  [160] = {
    content = 1600,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0,
        pos = {
          0,
          0,
          0
        },
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
      },
      {
        imgId = 202,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Fire_Bonfire_loop",
        sheet = "AVG_gf",
        audioId = 2
      }
    },
    heroFace = {
      {imgId = 202, faceId = 4}
    }
  },
  [161] = {
    content = 1610,
    contentType = 3,
    speakerHeroId = 2002,
    contentShake = true,
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
      {imgId = 202, faceId = 4}
    }
  },
  [162] = {
    content = 1620,
    contentType = 3,
    speakerHeroId = 197,
    contentShake = true,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 197,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [163] = {
    content = 1630,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 197,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img09_Kinpaku2",
        sheet = "Mus_SteinsGate_img09_Kinpaku2",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_monster_scream",
        sheet = "AVG"
      }
    }
  },
  [164] = {
    content = 1640,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [165] = {
    content = 1650,
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
  [166] = {
    content = 1660,
    contentType = 4,
    speakerName = 11
  },
  [167] = {
    content = 1670,
    contentType = 2,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [168] = {content = 1680, contentType = 2},
  [169] = {
    content = 1690,
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
  [170] = {
    content = 1700,
    contentType = 3,
    speakerHeroId = 2002,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 202, faceId = 7}
    }
  }
}
return AvgCfg_23sg_b3_01
