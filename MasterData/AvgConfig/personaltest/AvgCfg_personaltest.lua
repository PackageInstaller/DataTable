local AvgCfg_personaltest = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg007",
        fullScreen = true
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 28,
        imgType = 3,
        alpha = 0,
        imgPath = "puzzlecat_avg"
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
        duration = 1,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 28,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 28,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        cue = "Mus_Story_Sad",
        sheet = "Mus_Story_Sad",
        fadeIn = 2,
        fadeOut = 3
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 5}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 0.75,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 6}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
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
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 3}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 102, faceId = 10}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 102, faceId = 12}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 28,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 28,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0.75,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 8}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 10,
        alpha = 1,
        isDark = false,
        shake = true
      },
      {
        imgId = 28,
        delay = 0,
        duration = 10,
        posId = 3,
        alpha = 0.75,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 28, faceId = 7}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [10] = {content = 100, contentType = 2},
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 5}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 0,
        isDark = false,
        dissolve = true
      }
    }
  },
  [15] = {content = 150, contentType = 2},
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
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
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  }
}
return AvgCfg_personaltest
