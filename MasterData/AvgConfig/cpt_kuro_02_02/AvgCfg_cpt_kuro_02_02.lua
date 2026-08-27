local AvgCfg_cpt_kuro_02_02 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_miemie",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {
    content = 20,
    contentType = 1,
    scrambleTypeWriter = true,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    nextId = 6
  },
  [6] = {
    content = 60,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 9
  },
  [9] = {
    content = 90,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 13
  },
  [13] = {
    content = 130,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 16
  },
  [16] = {
    content = 160,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 20
  },
  [20] = {
    content = 200,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 24
  },
  [24] = {
    content = 240,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 28
  },
  [28] = {
    content = 280,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 32
  },
  [32] = {
    content = 320,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 36
  },
  [36] = {
    content = 360,
    contentType = 1,
    scrambleTypeWriter = true
  },
  [37] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_kuro_02_02
