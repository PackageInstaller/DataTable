local AvgCfg_Test = {
  [1] = {
    contentStyle = 1,
    images = {
      {
        imgId = 1,
        imgPath = "cpt00/cpt00_e_bg005",
        imgType = 2,
        fullScreen = true
      }
    },
    content = 10,
    contentType = 1,
    contentShake = true,
    scrambleTypeWriter = true,
    effect = {
      effect1 = {
        prefabName = "avg/avgtest",
        layer = 2
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    sgLineChange = {worldChangeId = 1},
    images = {
      {
        imgId = 2,
        imgPath = "sol_avg",
        imgPathBoy = "sol_hurt_avg",
        imgType = 3,
        pos = {
          -1000,
          0,
          0
        },
        alpha = 0.2,
        comm = true
      }
    },
    imgTween = {
      {
        imgId = 2,
        duration = 1.5,
        posId = 1,
        alpha = 1
      },
      {
        imgId = 2,
        delay = 1.5,
        duration = 0.5,
        shake = true
      }
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1009,
    speakerHeroPosId = 1,
    audio = {
      bgm = {
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "AVG_Alarm",
        sheet = "AVG_gf",
        audioId = 0
      },
      voice = {heroId = 1002, voiceId = 1}
    },
    branch = {
      disableSelected = true,
      {content = 21, jumpAct = 3},
      {content = 22, jumpChapter = "Test"},
      {content = 23, jumpAct = 11}
    },
    effect = {
      stopList = {"effect1"}
    },
    ppv = {
      dofTween = {startValue = 1, duration = 1}
    }
  },
  [3] = {
    sgMobile = {
      sendMsg = {
        receiver = 205,
        title = 204,
        contentMsg = 203
      }
    }
  },
  [4] = {
    sgMobile = {sendMsgConfirm = true}
  },
  [5] = {
    sgMobile = {showSgMobile = false}
  },
  [6] = {
    images = {
      {imgId = 2, delete = true}
    },
    content = 60,
    contentType = 2,
    contentShake = true
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 71,
    ppv = {
      cg = {saturation = 0}
    }
  },
  [8] = {
    content = 80,
    contentType = 5,
    tipsTypeWriter = true,
    vedioLoopPath = "avg/cpt00_pv",
    vedioLoopFrame = {0, 20}
  },
  [9] = {
    content = 90,
    contentType = 2,
    scrambleTypeWriter = true,
    vedioLoopFrame = {21, 40}
  },
  [10] = {
    content = 100,
    contentType = 2,
    vedioLoopStop = true,
    isEnd = true
  },
  [11] = {
    content = 91,
    contentType = 2,
    customCode = "print('11')"
  },
  [12] = {
    content = 91,
    contentType = 2,
    branch = {
      disableSelected = true,
      finalAct = 13,
      {content = 101, jumpAct = 14},
      {content = 102, jumpAct = 14}
    },
    customCode = "print('12')"
  },
  [13] = {
    content = 92,
    contentType = 2,
    nextId = 2,
    customCode = "print('13')"
  },
  [14] = {
    content = 93,
    contentType = 2,
    nextId = 12,
    customCode = "print('14')"
  },
  [-1] = {
    SkipScenario = 1,
    storyAvgId = 1,
    bgColor = 1,
    images = {
      {
        imgId = 1,
        imgPath = "",
        imgPathBoy = "",
        imgType = 1,
        order = 0,
        fullScreen = true,
        posId = 1,
        pos = {
          0,
          0,
          0
        },
        rot = {
          0,
          0,
          0
        },
        scale = {
          1,
          1,
          1
        },
        alpha = 1,
        isDark = false,
        comm = true,
        ripple = true,
        delete = false
      }
    },
    imgTween = {
      {
        imgId = 1,
        duration = 1,
        delay = 0,
        posId = 1,
        pos = {
          0,
          0,
          0
        },
        rot = {
          0,
          0,
          0
        },
        alpha = 0.5,
        scale = {
          1,
          1,
          1
        },
        isDark = true,
        shake = true,
        shakeIntensity = 1,
        dissolve = true
      }
    },
    heroFace = {
      {imgId = 1, faceId = 1},
      {imgId = 2, faceId = 3}
    },
    contentStyle = 1,
    content = 40,
    contentType = 1,
    contentShake = true,
    speakerHeroId = nil,
    speakerHeroPosId = 1,
    speakerName = nil,
    tipsShowDuration = 0,
    tipsTypeWriter = true,
    scrambleTypeWriter = true,
    autoContinue = true,
    ppv = {
      cg = {saturation = 0},
      dofTween = {startValue = 1, duration = 1},
      rRgbSTween = {
        isShow = true,
        duration = 1,
        blurRadius = 1
      }
    },
    vedioPath = "avg/cpt00_pv",
    vedioAudio = {cue = "GF_YT_PV", sheet = "GF_YT_PV"},
    vedioLoopPath = "avg/cpt00_pv",
    vedioLoopFrame = {0, 100},
    vedioLoopStop = true,
    effect = {
      effect1 = {
        prefabName = "Avg/AvgTest",
        pos = {
          0,
          0,
          0
        },
        layer = 1
      },
      stopList = {"effect1"}
    },
    audio = {
      bgm = {
        stop = true,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 2,
        fadeOut = 3
      },
      sfx = {
        cue = "Menu_Victory",
        sheet = "UI",
        audioId = 0
      },
      stopAudioId = {
        0,
        1,
        2
      },
      voice = {heroId = 1001, voiceId = 1}
    },
    branch = {
      disableSelected = true,
      finalAct = 1,
      {
        content = 21,
        jumpAct = 3,
        jumpChapter = "story1"
      },
      {content = 22, jump = 4}
    },
    nextId = 2,
    isEnd = true,
    skip2EndActId = 10,
    customCode = "print('customCode')",
    sgLineChange = {worldChangeId = 1},
    sgMobile = {
      showSgMobile = true,
      hideImmediate = true,
      showReceiveNewMsg = true,
      receiveMsg = {
        sender = 201,
        date = 202,
        title = 204,
        contentMsg = 206
      },
      sendMsg = {
        receiver = 205,
        title = 204,
        contentMsg = 203
      },
      sendMsgConfirm = true
    }
  }
}
return AvgCfg_Test
