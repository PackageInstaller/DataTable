local AvgCfg_cpt_hb_tutorial_111 = {
  [1] = {
    content = 10,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 77,
        imgType = 3,
        alpha = 0,
        imgPath = "sin_avg",
        order = 5
      },
      {
        imgId = 78,
        imgType = 3,
        alpha = 0,
        imgPath = "punish_avg"
      }
    },
    imgTween = {
      {
        imgId = 77,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
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
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 78,
        delay = 0,
        duration = 0.6,
        posId = 4,
        alpha = 1,
        isDark = false
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    heroFace = {
      {imgId = 77, faceId = 2}
    }
  }
}
return AvgCfg_cpt_hb_tutorial_111
