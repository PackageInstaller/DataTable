local AvgCfg_cpt04_h_02_01 = {
  [1] = {
    SkipScenario = 12,
    ppv = {
      cg = {saturation = -35}
    },
    content = 10,
    contentType = 1,
    bgColor = 2,
    storyAvgId = 4202,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg007",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008_2",
        fullScreen = true
      },
      {
        imgId = 28,
        imgType = 3,
        alpha = 0,
        imgPath = "neumann_avg"
      },
      {
        imgId = 29,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_avg"
      },
      {
        imgId = 291,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_shadow_avg"
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {cue = "AVG_typing", sheet = "AVG"}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
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
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
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
        imgId = 291,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 291,
        delay = 0,
        duration = 1,
        posId = 3,
        alpha = 0.75,
        isDark = false
      },
      {
        imgId = 291,
        delay = 1,
        duration = 1,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 29,
        delay = 1,
        duration = 1,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
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
        alpha = 1,
        isDark = false
      },
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [8] = {
    content = 80,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [10] = {
    content = 100,
    contentType = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [22] = {
    autoContinue = true,
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
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_keyboardtype_sci",
        sheet = "AVG_gf"
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      },
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
        delay = 1,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [30] = {
    content = 300,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [31] = {
    content = 310,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 1}
    }
  },
  [33] = {
    content = 330,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [34] = {
    content = 340,
    contentType = 2,
    imgTween = {
      {
        imgId = 28,
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
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_BaseDoor_Open",
        sheet = "AVG_gf"
      }
    }
  },
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 361,
    images = {
      {
        imgId = 27,
        imgType = 3,
        alpha = 0,
        imgPath = "adele_avg"
      }
    },
    imgTween = {
      {
        imgId = 27,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 27,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 27, faceId = 1}
    }
  },
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 27,
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
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 28, faceId = 0}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 28,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 28, faceId = 2}
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 28,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
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
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 29, faceId = 0}
    }
  },
  [41] = {
    content = 410,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [43] = {
    content = 430,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
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
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [44] = {
    content = 440,
    contentType = 2,
    images = {
      {
        imgId = 29,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_avg",
        delete = true
      },
      {
        imgId = 291,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_shadow_avg",
        delete = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008_3",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.75,
        isDark = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 29,
        imgType = 3,
        alpha = 0,
        imgPath = "eniac_shadow_avg"
      }
    },
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 2,
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 11
  },
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    contentShake = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Depressed",
        sheet = "Mus_Story_Depressed",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [53] = {
    content = 530,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [55] = {
    content = 550,
    contentType = 4,
    speakerName = 11
  },
  [56] = {
    content = 560,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [57] = {
    content = 570,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 4,
    speakerName = 11
  },
  [59] = {
    content = 590,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [60] = {
    content = 600,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    contentShake = true
  },
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  },
  [62] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    contentShake = true,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0.75,
        isDark = true
      }
    }
  },
  [64] = {
    content = 640,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [65] = {
    content = 650,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [66] = {
    content = 660,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [69] = {
    content = 690,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
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
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [80] = {
    content = 800,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [81] = {
    content = 810,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [83] = {
    content = 830,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [85] = {
    content = 850,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [87] = {
    content = 870,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [88] = {
    content = 880,
    contentType = 4,
    speakerName = 11
  },
  [89] = {
    content = 890,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [91] = {
    content = 910,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [92] = {
    content = 920,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [94] = {
    content = 940,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [99] = {
    content = 990,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
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
      },
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.75,
        isDark = false
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [102] = {
    content = 1020,
    contentType = 3,
    speakerHeroId = 29,
    speakerHeroPosId = 2
  },
  [103] = {
    content = 1030,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [104] = {
    content = 1040,
    contentType = 4,
    speakerName = 11
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
    speakerHeroId = 29,
    speakerHeroPosId = 2,
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
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [108] = {
    content = 1080,
    contentType = 2,
    imgTween = {
      {
        imgId = 29,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [109] = {content = 1090, contentType = 2}
}
return AvgCfg_cpt04_h_02_01
