local AvgCfg_24carnival_s03_1 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt10/cpt10_e_cg002",
        fullScreen = true
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
        imgId = 1,
        delay = 1,
        duration = 0.2,
        alpha = 1,
        shake = true
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Dangerous",
        sheet = "Mus_Story_Dangerous",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 12
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 13
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 12
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 13,
    contentShake = true
  },
  [7] = {
    bgColor = 3,
    autoContinue = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true
      },
      {
        imgId = 1,
        delay = 0.4,
        duration = 0.6,
        alpha = 0,
        scale = {
          1.3,
          1.3,
          1.3
        }
      }
    }
  }
}
return AvgCfg_24carnival_s03_1
