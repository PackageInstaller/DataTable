G_GuideClasses = {}
G_GuideClasses.guideType = {noobGuide = 1}
G_GuideClasses.maskMode = {rect = 1, circle = 2}
G_GuideClasses.itemMode = {
  single = 1,
  list = 2,
  custom = 3
}
G_GuideClasses.listItemType = {
  soulEssence = 1,
  pet = 2,
  product = 3,
  mountPet = 4,
  hero = 5
}
G_GuideClasses.listType = {
  none = 0,
  lScrollRect = 1,
  lList = 2
}
G_GuideClasses.BattleGuideType = {
  BattleStart = 0,
  TargetEnter = 1,
  ChargeComplete = 2,
  TargetPropertyCondition = 3,
  EnterSkillAvailable = 4,
  GuideInBattleByTime = 5
}
G_GuideClasses.GuideEvent = {
  GuideControlMouse = "GuideControlMouse",
  GuideEnd = "GuideEnd",
  TutotialGuideStart = "TutotialGuideStart",
  TutotialGuideEnd = "TutotialGuideEnd",
  InputChecked = "InputChecked",
  GuideClickInputChecked = "GuideClickInputChecked",
  RefreshWorldArea = "RefreshWorldArea",
  RefreshWorldMarkFilter = "RefreshWorldMarkFilter",
  ShowSkipGuide = "ShowSkipGuide",
  GuideClickPass = "GuideClickPass",
  CombinedTipPass = "CombinedTipPass",
  GuideRefresh = "GuideRefresh"
}
require("modules.guide.behaviorTree.action.setGuideStepFinish")
require("modules.guide.behaviorTree.action.setGuieSkipTime")
require("modules.guide.behaviorTree.action.checkOpenWindow")
require("modules.guide.behaviorTree.action.checkReachLevel")
require("modules.guide.behaviorTree.action.checkOwnItemNum")
require("modules.guide.behaviorTree.action.openWindow")
require("modules.guide.behaviorTree.action.checkGuideTreeComplete")
require("modules.guide.behaviorTree.action.closeWindow")
require("modules.guide.behaviorTree.action.checkCloseWindow")
require("modules.guide.behaviorTree.action.checkJourneyTaskComplete")
require("modules.guide.behaviorTree.action.componentVisibleControl")
require("modules.guide.behaviorTree.action.showGuideTips")
require("modules.guide.behaviorTree.action.playAnimation")
require("modules.guide.behaviorTree.action.playEffect")
require("modules.guide.behaviorTree.action.showComponentTips")
require("modules.guide.behaviorTree.action.checkScreenTouch")
require("modules.guide.behaviorTree.action.checkAnyInputs")
require("modules.guide.behaviorTree.action.showInfoWindow")
require("modules.guide.behaviorTree.action.findTargetListItem")
require("modules.guide.behaviorTree.action.findTargetCellItem")
require("modules.guide.behaviorTree.action.inputControlAction")
require("modules.guide.behaviorTree.action.findTargetItem")
require("modules.guide.behaviorTree.action.guideWait")
require("modules.guide.behaviorTree.action.forceClickAction")
require("modules.guide.behaviorTree.action.setWorldPauseAction")
require("modules.guide.behaviorTree.action.showGuideTipsCombined")
require("modules.guide.behaviorTree.action.guideClick")
require("modules.guide.behaviorTree.action.setScreenTouch")
require("modules.guide.behaviorTree.action.changeMainControl")
require("modules.guide.behaviorTree.action.freezeSkillAction")
require("modules.guide.behaviorTree.action.checkAcceesoryEquiped")
require("modules.guide.behaviorTree.action.checkScene")
require("modules.guide.behaviorTree.action.kiboSummonEnable")
require("modules.guide.behaviorTree.action.checkSkillStartRelease")
require("modules.guide.behaviorTree.action.castNextSkillAction")
require("modules.guide.behaviorTree.action.finishGuideTree")
require("modules.guide.behaviorTree.action.worldFilterAction")
require("modules.guide.behaviorTree.action.checkShowOrHide")
require("modules.guide.behaviorTree.action.setHighLevelSkill")
require("modules.guide.behaviorTree.action.checkMainControlEntity")
require("modules.guide.behaviorTree.action.describeAction")
require("modules.guide.behaviorTree.action.forceCastSkillAction")
require("modules.guide.behaviorTree.action.checkPlayerGender")
require("modules.guide.behaviorTree.action.popupWindowControlAction")
require("modules.guide.behaviorTree.action.waitPopupWindowClean")
require("modules.guide.behaviorTree.action.waitPlayerOutOfTheWar")
require("modules.guide.behaviorTree.action.functionDisableAction")
require("modules.guide.behaviorTree.action.forceEnableGamepadUIInput")
require("modules.guide.behaviorTree.action.petDuelCardDrag")
require("modules.guide.behaviorTree.action.heroAnimChangedTrigger")
require("modules.guide.behaviorTree.action.useNextFlyableMount")
require("modules.guide.behaviorTree.action.leaveMount")
require("modules.guide.behaviorTree.action.checkOnMount")
require("modules.guide.behaviorTree.action.mainCityUIRevertAction")
require("modules.guide.behaviorTree.composite.guideStepSequencer")
require("modules.guide.behaviorTree.composite.guideTreeSequencer")
require("modules.guide.behaviorTree.composite.guidePlatformSequencer")
require("modules.guide.behaviorTree.composite.parallelFailureSelector")
