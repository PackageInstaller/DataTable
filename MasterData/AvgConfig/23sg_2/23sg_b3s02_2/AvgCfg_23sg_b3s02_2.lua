local AvgCfg_23sg_b3s02_2 = {
  [1] = {
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 1,
        alpha = 0,
        imgPath = "sg/sg_e_bg003_2",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 1,
        alpha = 0,
        imgPath = "sg/sg_e_bg004_4",
        fullScreen = true
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_avg"
      },
      {
        imgId = 176,
        imgType = 3,
        alpha = 0,
        imgPath = "erika_avg"
      },
      {
        imgId = 3,
        imgType = 1,
        alpha = 0,
        imgPath = "sg/sg_e_bg007_2",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img12_Crossroads",
        sheet = "Mus_SteinsGate_img12_Crossroads",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Crowd_Run",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1076,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 176,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 176, faceId = 7}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 2003,
    contentShake = true,
    imgTween = {
      {
        imgId = 176,
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
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 5}
    }
  },
  [8] = {
    content = 80,
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
  [9] = {
    content = 90,
    contentType = 2,
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
      },
      {
        imgId = 3,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [10] = {content = 100, contentType = 2},
  [11] = {
    content = 110,
    contentType = 2,
    sgMobile = {
      sendMsg = {receiver = 121, contentMsg = 122}
    },
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE175_type",
        sheet = "SG",
        audioId = 4
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 40,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    sgMobile = {sendMsgConfirm = true},
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        order = 8,
        fullScreen = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img04_Theme_full",
        sheet = "Mus_SteinsGate_img04_Theme_full",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "SteinsGate_SGSE067_Dmail",
        sheet = "SG",
        audioId = 2
      },
      stopAudioId = {4}
    }
  },
  [13] = {autoContinue = true},
  [14] = {
    autoContinue = true,
    sgMobile = {showSgMobile = false}
  },
  [15] = {
    bgColor = 3,
    content = 140,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        fullScreen = true,
        delete = true
      }
    },
    audio = {
      stopAudioId = {2},
      bgm = {stop = true}
    }
  }
}
return AvgCfg_23sg_b3s02_2
