local AvgCfg_23concert_vee_03 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 1045,
    contentShake = true,
    images = {
      {
        imgId = 145,
        imgType = 3,
        alpha = 0,
        imgPath = "vee_idol_avg"
      }
    },
    imgTween = {
      {
        imgId = 145,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 145,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 145, faceId = 1}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1045
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1045,
    contentShake = true,
    imgTween = {
      {
        imgId = 145,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 145, faceId = 2}
    }
  },
  [4] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 145,
        delay = 0,
        duration = 0.6,
        posId = 2,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_23concert_vee_03
