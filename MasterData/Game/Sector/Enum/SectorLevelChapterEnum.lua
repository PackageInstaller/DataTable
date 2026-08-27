local SectorLevelChapterEnum = {}
SectorLevelChapterEnum.levelSelectButtonType = {
  repeatButton = 1,
  mainButton = 2,
  normalDiffButton = 3,
  hardDiffButton = 4
}
SectorLevelChapterEnum.chapterDataType = {
  default = 1,
  actWinter23 = 2,
  actCarnival23 = 3,
  actWinter23Resident = 4,
  actCarnival23Resident = 5,
  actSummer23Resident = 6,
  actSummer24 = 7,
  actAnniversary24 = 8,
  actAnniversary24Resident = 9
}
SectorLevelChapterEnum.actSectorToChapterDataType = {
  [330021] = SectorLevelChapterEnum.chapterDataType.actCarnival23Resident,
  [330041] = SectorLevelChapterEnum.chapterDataType.actSummer23Resident
}
return SectorLevelChapterEnum
