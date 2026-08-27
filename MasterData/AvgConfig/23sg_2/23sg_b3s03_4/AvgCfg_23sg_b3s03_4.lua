local AvgCfg_23sg_b3s03_4 = {
  [1] = {
    bgColor = 3,
    contentStyle = 1,
    content = 10,
    contentType = 3,
    speakerHeroId = 2003,
    images = {
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_avg"
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg004_4",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "summer/summer_e_bg010",
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
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
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
        delay = 0.6,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        sheet = "Mus_SteinsGate_img10_ThemePiano_Monologue",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  },
  [2] = {
    bgColor = 2,
    content = 20,
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 203,
        delay = 0.5,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  },
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 203,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [4] = {content = 40, contentType = 2},
  [5] = {content = 50, contentType = 2},
  [6] = {content = 60, contentType = 2},
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 11
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11
  },
  [10] = {content = 100, contentType = 2},
  [11] = {
    content = 110,
    contentType = 2,
    sgLineChange = {worldChangeId = 10}
  },
  [12] = {content = 120, contentType = 2},
  [13] = {content = 130, contentType = 2},
  [14] = {content = 140, contentType = 2}
}
return AvgCfg_23sg_b3s03_4
