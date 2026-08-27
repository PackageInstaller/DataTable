local AvgCfg_cpt_nora_00_01 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "21winter/21win_e_bg010",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_2",
        fullScreen = true
      },
      {
        imgId = 159,
        imgType = 3,
        alpha = 0,
        imgPath = "nora_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 3,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 3,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {content = 20, contentType = 1},
  [3] = {content = 30, contentType = 1},
  [4] = {content = 40, contentType = 1},
  [5] = {content = 50, contentType = 1},
  [6] = {content = 60, contentType = 1},
  [7] = {content = 70, contentType = 1},
  [8] = {content = 80, contentType = 1},
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
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
    contentType = 3,
    speakerHeroId = 72,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 159,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 159,
        delay = 0.6,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 3}
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 1}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 201, jumpAct = 21},
      {content = 202, jumpAct = 22}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1059,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 2}
    },
    nextId = 23
  },
  [22] = {
    content = 220,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 5}
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 159, faceId = 3}
    }
  },
  [24] = {
    content = 240,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 11
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 5}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [29] = {
    content = 290,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 11
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 1}
    }
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [36] = {
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 361, jumpAct = 37},
      {content = 362, jumpAct = 38},
      {content = 363, jumpAct = 39}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 8}
    },
    nextId = 40
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 5}
    },
    nextId = 40
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 8}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 159, faceId = 1}
    }
  },
  [42] = {
    content = 420,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 11
  },
  [44] = {
    content = 440,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 159, faceId = 0}
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [46] = {
    content = 460,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
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
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [49] = {
    content = 490,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 159, faceId = 1}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 1059,
    speakerHeroPosId = 2,
    audio = {
      bgm = {stop = true}
    }
  },
  [52] = {
    content = 520,
    contentType = 2,
    imgTween = {
      {
        imgId = 159,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
  [53] = {content = 530, contentType = 2}
}
return AvgCfg_cpt_nora_00_01
