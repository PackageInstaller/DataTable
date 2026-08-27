local AvgCfg_cpt06_tutorial_101 = {
  [1] = {
    content = 10,
    contentType = 4,
    speakerName = 11,
    images = {
      {
        imgId = 47,
        imgType = 3,
        alpha = 0,
        imgPath = "demiurge_avg"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 47,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 47,
        alpha = 0,
        posId = 3
      },
      {
        imgId = 47,
        duration = 0.6,
        posId = 3,
        alpha = 1
      }
    },
    heroFace = {
      {imgId = 47, faceId = 3}
    }
  },
  [5] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 47,
        duration = 0.6,
        posId = 3,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt06_tutorial_101
