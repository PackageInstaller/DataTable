local FirstBattleConfig = {
  firstBattle1 = {
    formHeroList = {
      1001,
      1003,
      1005
    },
    formCSList = {5001},
    csTreeId = 1,
    csGuideDelay = 60,
    guideList = {
      [1] = 1000,
      [2] = 1001
    }
  },
  firstBattle2 = {
    formHeroList = {
      1001,
      1003,
      1005
    },
    formHeroPos = {
      {0, 1},
      {0, 3},
      {1, 2}
    },
    clickHeroPos = {1, 2},
    benchHero = 1005,
    benchHeroOriginPos = 1,
    benchHeroPos = {1, 2},
    introHeroGuideTextId = 136,
    introHeroGuideHeroId = 1001,
    introHeroGuidePos = "4",
    dragGuideTextId = 126,
    guideTalkHeroId = 1001,
    guideTalkPos = "4",
    beforeDragAvg = "cpt00_tutorial_03",
    formCSList = {5001, 5009},
    csTreeId = 1,
    csGuideDelay = 85,
    dragSkillGuideAvg = "cpt00_tutorial_03x",
    dragSkillGuidePos = {4, 2},
    dragSkillGuideTextId = 142,
    dragSkillGuideHeroId = 1001,
    dragSkillGuideTalkPos = "2",
    guideList = {
      [1] = 1011,
      [2] = 1012,
      [3] = 1013,
      [4] = 1014
    }
  }
}
return FirstBattleConfig
