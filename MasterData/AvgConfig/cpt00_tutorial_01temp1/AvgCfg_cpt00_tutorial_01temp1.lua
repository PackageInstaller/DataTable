local AvgCfg_cpt00_tutorial_01 = {
  [1] = {
    images = {
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
    imgTween = {
      {
        imgId = 103,
        alpha = 0,
        posId = 5
      },
      {
        imgId = 103,
        duration = 0.6,
        posId = 4
      },
      {
        imgId = 103,
        duration = 0.3,
        delay = 0.6,
        shake = true,
        shakeIntensity = 2
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    contentShake = true,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 101,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 101,
        duration = 0.6,
        posId = 2
      },
      {
        imgId = 103,
        duration = 0.2,
        alpha = 0
      }
    },
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  }
}
return AvgCfg_cpt00_tutorial_01
