local AvgCfg_cpt00_tutorial_04 = {
  [1] = {
    images = {
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg",
        order = 2
      },
      {
        imgId = 105,
        imgType = 3,
        alpha = 0,
        rot = {
          0,
          180,
          0
        },
        imgPath = "croque_avg"
      }
    },
    imgTween = {
      {
        imgId = 101,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 101,
        duration = 0.6,
        alpha = 1,
        posId = 2
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 101, faceId = 4}
    }
  },
  [2] = {
    imgTween = {
      {
        imgId = 105,
        alpha = 0,
        posId = 5
      },
      {
        imgId = 105,
        alpha = 1,
        posId = 4,
        duration = 0.6
      },
      {
        imgId = 101,
        duration = 0.2,
        isDark = true
      }
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1005,
    speakerHeroPosId = 3
  },
  [3] = {
    imgTween = {
      {
        imgId = 105,
        alpha = 0,
        duration = 0.6
      },
      {
        imgId = 101,
        duration = 0.2,
        isDark = false
      }
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [4] = {
    imgTween = {
      {imgId = 101, isDark = false}
    },
    customCode = "AvgUtil.ChangeUltSkillOrder(true)",
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    nextId = 10
  },
  [6] = {
    customCode = "AvgUtil.ChangeUltSkillOrder(false)",
    autoContinue = true
  },
  [10] = {
    content = 51,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    nextId = 6
  }
}
return AvgCfg_cpt00_tutorial_04
