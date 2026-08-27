local AvgCfg_cpt_hb_tutorial_11 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg001_2",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true,
        order = 5
      },
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg"
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg"
      },
      {
        imgId = 80,
        imgType = 3,
        alpha = 0,
        imgPath = "judge_avg"
      },
      {
        imgId = 800,
        imgType = 3,
        alpha = 0,
        imgPath = "judge2_avg"
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
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 77,
        delay = 1,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 1,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 2}
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    nextId = 101
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 3}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 3}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 77, faceId = 3}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    nextId = 102
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 78, faceId = 2}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 0}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [11] = {content = 110, contentType = 2},
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 121
  },
  [13] = {
    content = 130,
    contentType = 4,
    speakerName = 122
  },
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 121
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 0},
      {imgId = 78, faceId = 0}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 2,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    }
  },
  [18] = {content = 180, contentType = 2},
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 123,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0.6,
        duration = 1,
        posId = 4,
        alpha = 0,
        isDark = false,
        dissolve = true
      },
      {
        imgId = 77,
        delay = 0.6,
        duration = 1,
        posId = 2,
        alpha = 0,
        isDark = false,
        dissolve = true
      },
      {
        imgId = 10,
        delay = 0.6,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 80,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 10,
        delay = 1.6,
        duration = 2,
        alpha = 0
      },
      {
        imgId = 80,
        delay = 1.6,
        duration = 3,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 80, faceId = 999}
    }
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 124,
    imgTween = {
      {
        imgId = 80,
        delay = 0,
        duration = 0.5,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 800,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 800,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [21] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1.5,
        alpha = 0
      },
      {
        imgId = 800,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    isEnd = true
  },
  [101] = {
    content = 11,
    contentType = 3,
    speakerHeroId = 77,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 78,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 77, faceId = 2}
    },
    nextId = 2
  },
  [102] = {
    content = 71,
    contentType = 3,
    speakerHeroId = 78,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 78, faceId = 6}
    },
    nextId = 8
  }
}
return AvgCfg_cpt_hb_tutorial_11
