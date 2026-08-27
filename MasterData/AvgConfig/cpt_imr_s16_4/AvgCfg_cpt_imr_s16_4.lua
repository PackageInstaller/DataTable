local AvgCfg_cpt_imr_s16_4 = {
  [1] = {
    ppv = {
      cg = {saturation = 0}
    },
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg001",
        fullScreen = true
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005",
        order = 5,
        fullScreen = true
      },
      {
        imgId = 97,
        imgType = 3,
        alpha = 0,
        imgPath = "ranko_avg"
      },
      {
        imgId = 13,
        imgType = 3,
        alpha = 0,
        imgPath = "riko_avg"
      }
    }
  },
  [2] = {
    ppv = {
      cg = {saturation = -70}
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.2,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 13,
        delay = 0.8,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 97,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 97,
        delay = 0.8,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 13, faceId = 3}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 97,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 97,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 97, faceId = 8}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 97,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 13, faceId = 0}
    },
    contentShake = true
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 1
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 97,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 97,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 97, faceId = 6}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 97,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 97, faceId = 7}
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 97,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.2,
        posId = 2,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 13, faceId = 3}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 13,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 97,
        delay = 0,
        duration = 0.2,
        posId = 4,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 13, faceId = 7}
    }
  },
  [11] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 13,
        delay = 0,
        duration = 0.6,
        posId = 3,
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
return AvgCfg_cpt_imr_s16_4
