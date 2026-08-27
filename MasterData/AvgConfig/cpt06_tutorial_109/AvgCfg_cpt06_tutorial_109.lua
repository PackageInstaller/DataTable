local AvgCfg_cpt06_tutorial_109 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 47,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 47,
        imgType = 3,
        alpha = 0,
        imgPath = "demiurge_avg"
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
        imgId = 47,
        alpha = 0,
        posId = 3
      },
      {
        imgId = 47,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        shake = true
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 2,
    imgTween = {
      {
        imgId = 47,
        duration = 0.6,
        posId = 3,
        alpha = 0
      }
    }
  },
  [3] = {content = 30, contentType = 2},
  [4] = {content = 40, contentType = 2},
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 52,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 52,
        alpha = 0,
        posId = 3
      },
      {
        imgId = 52,
        duration = 0.6,
        posId = 3,
        alpha = 1
      }
    }
  },
  [6] = {
    autoContinue = true,
    isEnd = true,
    {
      {
        imgId = 52,
        duration = 1,
        posId = 3,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt06_tutorial_109
