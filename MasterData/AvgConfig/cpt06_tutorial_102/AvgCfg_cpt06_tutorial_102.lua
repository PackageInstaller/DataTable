local AvgCfg_cpt06_tutorial_102 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 17,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 17,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg"
      },
      {
        imgId = 52,
        imgType = 3,
        alpha = 0,
        imgPath = "love_avg"
      }
    },
    imgTween = {
      {
        imgId = 17,
        alpha = 0,
        posId = 3
      },
      {
        imgId = 17,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 52,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 17,
        duration = 0.2,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 52,
        alpha = 0,
        posId = 3
      },
      {
        imgId = 52,
        duration = 0.2,
        posId = 3,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 52, faceId = 2}
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 52,
        duration = 0.2,
        posId = 3,
        alpha = 0
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 11
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11
  }
}
return AvgCfg_cpt06_tutorial_102
