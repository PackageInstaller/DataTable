local AvgCfg_cpt_clotho_04_05 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg039",
        fullScreen = true
      },
      {
        imgId = 167,
        imgType = 3,
        alpha = 0,
        imgPath = "clotho_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      sfx = {cue = "AVG_Rope", sheet = "AVG_gf"}
    }
  },
  [3] = {content = 30, contentType = 1},
  [4] = {content = 40, contentType = 1},
  [5] = {content = 50, contentType = 1},
  [6] = {content = 60, contentType = 2},
  [7] = {content = 70, contentType = 2},
  [8] = {content = 80, contentType = 2},
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1067,
    imgTween = {
      {
        imgId = 167,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 167,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 167, faceId = 7}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1067
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1067
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 1067,
    heroFace = {
      {imgId = 167, faceId = 8}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1067
  },
  [14] = {
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 167,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      }
    }
  },
  [15] = {
    content = 150,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 1067,
    imgTween = {
      {
        imgId = 167,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 167, faceId = 0}
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 167,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 167,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [19] = {
    content = 190,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true
  },
  [20] = {
    content = 200,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
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
        pos = {
          0,
          0,
          0
        },
        scale = {
          2,
          2,
          2
        },
        duration = 5,
        alpha = 0
      }
    },
    audio = {
      sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
    }
  }
}
return AvgCfg_cpt_clotho_04_05
