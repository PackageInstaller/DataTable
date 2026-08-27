local SkinEnum = {}
SkinEnum.ColorShowTags = {
  Color.New(0, 0.95, 1),
  Color.New(0.965, 0.75, 0),
  Color.New(0.965, 0.75, 0),
  Color.New(1, 0.31, 0),
  Color.New(0.8666667, 0.6745098, 1)
}
SkinEnum.ColorHideTags = {
  Color.New(0.011, 0.47, 0.5),
  Color.New(0.537, 0.415, 0),
  Color.New(0.537, 0.415, 0),
  Color.New(0.576, 0.18, 0),
  Color.New(0.5393566, 0.4175664, 0.622)
}
SkinEnum.fromWhere = {
  normalUI = 0,
  otherPlayerHero = 1,
  heroInfoAndHandbook = 2,
  adjutant = 3,
  getSkin = 4,
  bp = 5,
  ultrSkill = 6,
  mpv = 7,
  shopOrGift = 8,
  mail = 9,
  reinforceCard = 10,
  heroVow = 11
}
SkinEnum.getOutLineResType = {
  skinId = 1,
  heroId = 2,
  resName = 3
}
return SkinEnum
