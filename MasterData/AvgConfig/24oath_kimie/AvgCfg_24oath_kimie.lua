local AvgCfg_24oath_kimie = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg068",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg068",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "oath/oath_kimie",
        pos = {
          -100,
          -200,
          0
        },
        scale = {
          1.6,
          1.6,
          1.6
        }
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      },
      {
        imgId = 159,
        imgType = 3,
        alpha = 0,
        imgPath = "nora_avg"
      },
      {
        imgId = 182,
        imgType = 3,
        alpha = 0,
        imgPath = "kimie_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 7}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1059,
    heroFace = {
      {imgId = 159, faceId = 6}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 3}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 159, faceId = 8}
    }
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 6},
      {imgId = 159, faceId = 6}
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [10] = {
    content = 100,
    contentType = 4,
    speakerName = 11
  },
  [11] = {
    content = 110,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 7}
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [18] = {
    audio = {
      bgm = {stop = true}
    },
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [19] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 190,
    contentType = 4,
    speakerName = 13,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
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
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 2,
    imgTween = {
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
      {imgId = 999, faceId = 3}
    }
  },
  [21] = {
    content = 210,
    contentType = 4,
    speakerName = 13,
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
  [22] = {
    content = 220,
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
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 2}
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 2,
    heroFace = {
      {imgId = 999, faceId = 1}
    }
  },
  [25] = {
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
        duration = 1,
        alpha = 0
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    ppv = {
      cg = {saturation = 0}
    }
  },
  [27] = {content = 270, contentType = 2},
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 182,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1059,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [32] = {content = 320, contentType = 2},
  [33] = {
    content = 330,
    contentType = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [34] = {content = 340, contentType = 2},
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 159, faceId = 7}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1059,
    contentShake = true,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 6}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1059,
    heroFace = {
      {imgId = 159, faceId = 5}
    }
  },
  [38] = {
    content = 380,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
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
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 4}
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
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
        imgId = 159,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 0,
        isDark = false
      }
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    imgTween = {
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
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
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
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 11
  },
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 11
  },
  [50] = {content = 500, contentType = 2},
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 7}
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [58] = {content = 580, contentType = 2},
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [61] = {
    content = 610,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 1,
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
        duration = 1,
        alpha = 1,
        scale = {
          1.2,
          1.2,
          1.2
        }
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 11
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 11
  },
  [64] = {content = 640, contentType = 2},
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 1082,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 4,
    speakerName = 11
  },
  [68] = {
    content = 680,
    contentType = 4,
    speakerName = 11
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 1082
  },
  [71] = {
    content = 710,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [72] = {
    content = 720,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [73] = {
    content = 730,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [74] = {
    content = 740,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -650,
          0
        },
        scale = {
          1.5,
          1.5,
          1.5
        }
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [76] = {
    content = 760,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
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
    images = {
      {
        imgId = 182,
        imgType = 3,
        alpha = 0,
        imgPath = "kimie_avg",
        delete = true
      },
      {
        imgId = 182,
        imgType = 3,
        alpha = 0,
        imgPath = "kimie_oath_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [77] = {
    content = 770,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 10,
        delay = 1,
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
  [78] = {content = 780, contentType = 2},
  [79] = {
    content = 790,
    contentType = 4,
    speakerName = 11
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 1082
  },
  [81] = {
    content = 810,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  },
  [82] = {content = 820, contentType = 2},
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
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
        imgId = 182,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [84] = {
    content = 840,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
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
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_body_fall",
        sheet = "AVG"
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 1082,
    contentShake = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        shake = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [88] = {
    content = 880,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
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
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [93] = {
    content = 930,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 1082,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        alpha = 0,
        isDark = false,
        pos = {
          0,
          -650,
          0
        },
        scale = {
          1.5,
          1.5,
          1.5
        }
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 4}
    }
  },
  [96] = {
    content = 960,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [98] = {
    content = 980,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [99] = {
    content = 990,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [102] = {
    content = 1020,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
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
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [105] = {
    content = 1050,
    contentType = 4,
    speakerName = 11
  },
  [106] = {
    content = 1060,
    contentType = 4,
    speakerName = 11
  },
  [107] = {
    content = 1070,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [108] = {
    content = 1080,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
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
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [110] = {
    content = 1100,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        shake = true
      }
    }
  },
  [111] = {
    content = 1110,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [112] = {content = 1120, contentType = 2},
  [113] = {content = 1130, contentType = 2},
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 182, faceId = 3}
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 1082
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 2}
    }
  },
  [117] = {
    content = 1170,
    contentType = 3,
    speakerHeroId = 1082
  },
  [118] = {
    content = 1180,
    contentType = 3,
    speakerHeroId = 1082,
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [119] = {
    content = 1190,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [120] = {content = 1200, contentType = 2},
  [121] = {
    content = 1210,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [122] = {
    content = 1220,
    contentType = 4,
    speakerName = 11
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
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
    }
  },
  [125] = {content = 1250, contentType = 2},
  [126] = {content = 1260, contentType = 2},
  [127] = {content = 1270, contentType = 2}
}
return AvgCfg_24oath_kimie
