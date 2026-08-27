local AvgCfg_cpt_kimie_03_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg009_1",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt03/cpt03_e_bg005",
        fullScreen = true
      },
      {
        imgId = 23,
        imgType = 3,
        alpha = 0,
        imgPath = "choco_avg"
      },
      {
        imgId = 124,
        imgType = 3,
        alpha = 0,
        imgPath = "helix_avg"
      },
      {
        imgId = 182,
        imgType = 3,
        alpha = 0,
        imgPath = "kimie_avg"
      },
      {
        imgId = 160,
        imgType = 3,
        alpha = 0,
        imgPath = "crypter_avg"
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
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [5] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 1024,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 124,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 124,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 23,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 124, faceId = 1}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 23,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 124,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 23, faceId = 1}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1024,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 124,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 124, faceId = 3}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 124,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 23,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
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
      {imgId = 182, faceId = 8}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1024,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 124,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 124,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 124, faceId = 8}
    }
  },
  [10] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 124,
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
  [11] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 110,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 182,
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
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
      }
    },
    heroFace = {
      {imgId = 182, faceId = 7}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1082
  },
  [13] = {
    content = 130,
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
      {imgId = 182, faceId = 8}
    }
  },
  [14] = {
    content = 140,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [15] = {
    content = 150,
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
    },
    heroFace = {
      {imgId = 182, faceId = 6}
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
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
      },
      sfx = {
        cue = "AVG_slip_away",
        sheet = "AVG"
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 72,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [18] = {
    content = 180,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 0,
        isDark = true
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 72,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 12,
    contentShake = true,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1082,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = true
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
      {imgId = 182, faceId = 5}
    }
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1060,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 8}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1060
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 160,
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
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 5}
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 4}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 160, faceId = 8}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 4}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
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
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 5}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 5}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 182, faceId = 1}
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 182, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 6}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1082,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 182,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 1060,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 182,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 160,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 160, faceId = 0}
    }
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 160,
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
  }
}
return AvgCfg_cpt_kimie_03_01
