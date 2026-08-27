local AvgCfg_23sg_o_1_1 = {
  [1] = {
    contentStyle = 1,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 6,
        imgPath = "summer/summer_e_bg010",
        fullScreen = true
      },
      {
        imgId = 203,
        imgType = 3,
        alpha = 0,
        imgPath = "mayuri_avg"
      }
    },
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 10,
        delay = 1,
        duration = 1,
        alpha = 0.1
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 2003,
    imgTween = {
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
      {imgId = 203, faceId = 4}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 2003,
    contentShake = true,
    heroFace = {
      {imgId = 203, faceId = 6}
    }
  }
}
return AvgCfg_23sg_o_1_1
