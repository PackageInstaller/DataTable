local StoryDefine = {}
StoryDefine.MainCopyPanelChapter = {
  Morimens = cd.StageChapterName.StageChapterMorimens,
  StarsCameRight = cd.StageChapterName.StageChapterStarsCameRight
}
StoryDefine.MainCopyPanelChapterList = {
  cd.StageChapterName.StageChapterMorimens,
  cd.StageChapterName.StageChapterStarsCameRight
}
StoryDefine.ChapterRes = {
  [StoryDefine.MainCopyPanelChapter.Morimens] = {
    TopIcon = "UIResources/UIBigImages/UI_GuideNote/UI_GuideNote_Story_01.png",
    ToggleIcon = "UIResources/AtlasSource/UI_GuideNote/UI_GuideNote_Image_StageChapter01.png",
    FullName = LT.Text("StageChapterMorimens_Full")
  },
  [StoryDefine.MainCopyPanelChapter.StarsCameRight] = {
    TopIcon = "UIResources/UIBigImages/UI_GuideNote/UI_GuideNote_Story_02.png",
    ToggleIcon = "UIResources/AtlasSource/UI_GuideNote/UI_GuideNote_Image_StageChapter02.png",
    FullName = LT.Text("StageChapterStarsCameRight_Full")
  }
}
StoryDefine.StoryTypeRes = {
  [cd.StageGroupType.Prologue] = {
    Icon = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Linshi_Icon_1.png",
    Title = LT.Text("MainCopyTitle")
  },
  [cd.StageGroupType.MainCopy] = {
    Icon = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Linshi_Icon_1.png",
    Title = LT.Text("MainCopyTitle")
  },
  [cd.StageGroupType.LargeSubplotNormal] = {
    Icon = "UIResources/AtlasSource/UI_Chapter_Image/UI_Spur_image_Career_09.png",
    Title = LT.Text("LargeSubplotTitle")
  },
  [cd.StageGroupType.SmallSubplotNormal] = {
    Icon = "UIResources/AtlasSource/UI_Chapter_Image/UI_Spur_image_Career_11.png",
    Title = LT.Text("SmallSubplotTitle")
  },
  [cd.StageGroupType.SpecialSubplotNormal] = {
    Icon = "UIResources/AtlasSource/UI_Chapter_Image/UI_Spur_image_Career_16.png",
    Title = LT.Text("SpecialSubplotTitle"),
    Bg = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Special.png"
  },
  [cd.StageGroupType.LinkageActivityNormal] = {
    Icon = "UIResources/AtlasSource/UI_Chapter_Image/UI_Spur_image_Career_18.png",
    Title = LT.Text("LinkageActivityTitle"),
    Bg = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Linkage.png"
  }
}
StoryDefine.StoryState = {
  Default = 0,
  Locked = 1,
  CanUnlock = 2,
  FreeNow = 3,
  Unlocked = 4,
  Finished = 5
}
return StoryDefine
