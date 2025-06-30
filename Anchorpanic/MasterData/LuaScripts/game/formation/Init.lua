formation = {}

------------------------------------------------------------ Normal ------------------------------------------------------------
-- manager
require("game/formation/FormationConst")
formation.FormationManager = require("game/formation/normal/manager/FormationManager").new()
formation.FormationVo = require("game/formation/normal/manager/vo/FormationVo")
formation.FormationTeamVo = require("game/formation/normal/manager/vo/FormationTeamVo")
formation.FormationHeroVo = require("game/formation/normal/manager/vo/FormationHeroVo")
formation.FormationAssistVo = require("game/formation/normal/manager/vo/FormationAssistVo")
formation.FormationAssistConfigVo = require("game/formation/normal/manager/vo/FormationAssistConfigVo")
formation.FormationConfigVo = require("rodata/HeroFormationDataRo")
formation.MonFormationConfigVo = require("rodata/MonFormationDataRo")
formation.FormationRecommendVo = require("game/formation/normal/manager/vo/FormationRecommendVo")
formation.FormationPosEffVo = require("game/formation/normal/manager/vo/FormationPosEffVo")

-- view
-- formation.FormationScene = require("game/formation/normal/view/FormationScene")
formation.FormationPanel = require("game/formation/normal/view/FormationPanel")
formation.FormationTeamItem = require("game/formation/normal/view/item/FormationTeamItem")
formation.FormationItem = require("game/formation/normal/view/item/FormationItem")
formation.FormationSelectPanel = require("game/formation/normal/view/FormationSelectPanel")
formation.FormationSelectItem = require("game/formation/normal/view/item/FormationSelectItem")
formation.FormationHeroSelectPanel = require("game/formation/normal/view/FormationHeroSelectPanel")
formation.FormationHeroSelectItem = require("game/formation/normal/view/item/FormationHeroSelectItem")
formation.FormationCaptainSelectPanel = require("game/formation/normal/view/FormationCaptainSelectPanel")
formation.FormationCaptainSelectItem = require("game/formation/normal/view/item/FormationCaptainSelectItem")
formation.FormationModifyTeamNamePanel = require("game/formation/normal/view/FormationModifyTeamNamePanel")
formation.FormationAssistPanel = require("game/formation/normal/view/FormationAssistPanel")
formation.FormationAssistPreviewPanel = require("game/formation/normal/view/FormationAssistPreviewPanel")
formation.FormationAssistSelectPanel = require("game/formation/normal/view/FormationAssistSelectPanel")
formation.FormationAssistCardItem = require("game/formation/normal/view/item/FormationAssistCardItem")

formation.FormationPosEffPanel = require("game/formation/normal/view/FormationPosEffPanel")
formation.FormationPosEffItem = require("game/formation/normal/view/item/FormationPosEffItem")

formation.FormationTargetPanel = require("game/formation/normal/view/FormationTargetPanel")
-- controller
formation.FormationController = require("game/formation/normal/controller/FormationController").new()
formation.FormationSceneController = require("game/formation/normal/controller/FormationSceneController").new()

------------------------------------------------------------ PlayerEdit ------------------------------------------------------------
formation.FormationPlayerEditManager = require("game/formation/playerEdit/manager/FormationPlayerEditManager").new()
formation.FormationPlayerEditPanel = require("game/formation/playerEdit/view/FormationPlayerEditPanel")
formation.FormationPlayerEditController = require("game/formation/playerEdit/controller/FormationPlayerEditController").new(formation.FormationPlayerEditManager)

------------------------------------------------------------ ArenaDefense ------------------------------------------------------------
formation.FormationArenaDefenseManager = require("game/formation/arenaDefense/manager/FormationArenaDefenseManager").new()
formation.FormationArenaDefensePanel = require("game/formation/arenaDefense/view/FormationArenaDefensePanel")
formation.FormationArenaDefenseController = require("game/formation/arenaDefense/controller/FormationArenaDefenseController").new(formation.FormationArenaDefenseManager)
formation.FormationArenaDefenseSelectPanel = require("game/formation/arenaDefense/view/FormationArenaDefenseSelectPanel")
formation.FormationArenaDefenseSelectItem = require("game/formation/arenaDefense/view/item/FormationArenaDefenseSelectItem")

------------------------------------------------------------ ArenaAttack ------------------------------------------------------------
formation.FormationArenaAttackManager = require("game/formation/arenaAttack/manager/FormationArenaAttackManager").new()
formation.FormationArenaAttackPanel = require("game/formation/arenaAttack/view/FormationArenaAttackPanel")
formation.FormationArenaAttackController = require("game/formation/arenaAttack/controller/FormationArenaAttackController").new(formation.FormationArenaAttackManager)
formation.FormationArenaAttackSelectPanel = require("game/formation/arenaAttack/view/FormationArenaAttackSelectPanel")
formation.FormationArenaAttackSelectItem = require("game/formation/arenaAttack/view/item/FormationArenaAttackSelectItem")

------------------------------------------------------------ MainSupport ------------------------------------------------------------
formation.FormationMainSupportManager = require("game/formation/mainSupport/manager/FormationMainSupportManager").new()
formation.FormationMainSupportHeroSelectPanel = require("game/formation/mainSupport/view/FormationMainSupportHeroSelectPanel")
formation.FormationMainSupportController = require("game/formation/mainSupport/controller/FormationMainSupportController").new(formation.FormationMainSupportManager)

------------------------------------------------------------ MainFixed ------------------------------------------------------------
formation.FormationMainFixedManager = require("game/formation/mainFixed/manager/FormationMainFixedManager").new()
formation.FormationMainFixedPanel = require("game/formation/mainFixed/view/FormationMainFixedPanel")
formation.FormationMainFixedController = require("game/formation/mainFixed/controller/FormationMainFixedController").new(formation.FormationMainFixedManager)

------------------------------------------------------------ Distribute ------------------------------------------------------------
formation.FormationDistributeManager = require("game/formation/distribute/manager/FormationDistributeManager").new()
formation.FormationDistributePanel = require("game/formation/distribute/view/FormationDistributePanel")
formation.FormationDistributeHeroSelectPanel = require("game/formation/distribute/view/FormationDistributeHeroSelectPanel")
formation.FormationDistributeController = require("game/formation/distribute/controller/FormationDistributeController").new(formation.FormationDistributeManager)

------------------------------------------------------------ codeHope ------------------------------------------------------------
formation.FormationCodeHopeManager = require("game/formation/codeHope/manager/FormationCodeHopeManager").new()
formation.FormationCodeHopePanel = require("game/formation/codeHope/view/FormationCodeHopePanel")
formation.FormationCodeHopeHeroSelectPanel = require("game/formation/codeHope/view/FormationCodeHopeHeroSelectPanel")
formation.FormationCodeHopeHeroSelectItem = require("game/formation/codeHope/view/item/FormationCodeHopeHeroSelectItem")
formation.FormationCodeHopeController = require("game/formation/codeHope/controller/FormationCodeHopeController").new(formation.FormationCodeHopeManager)

------------------------------------------------------------ Maze ------------------------------------------------------------
formation.FormationMazeManager = require("game/formation/maze/manager/FormationMazeManager").new()
formation.FormationMazePanel = require("game/formation/maze/view/FormationMazePanel")
formation.FormationMazeHeroSelectPanel = require("game/formation/maze/view/FormationMazeHeroSelectPanel")
formation.FormationMazeHeroSelectItem = require("game/formation/maze/view/item/FormationMazeHeroSelectItem")
formation.FormationMazeController = require("game/formation/maze/controller/FormationMazeController").new(formation.FormationMazeManager)

------------------------------------------------------------ Apostles ------------------------------------------------------------
formation.FormationApostlesManager = require("game/formation/apostles/manager/FormationApostlesManager").new()
formation.FormationApostlesPanel = require("game/formation/apostles/view/FormationApostlesPanel")
formation.FormationApostlesHeroSelectPanel = require("game/formation/apostles/view/FormationApostlesHeroSelectPanel")
formation.FormationApostlesHeroSelectItem = require("game/formation/apostles/view/item/FormationApostlesHeroSelectItem")
formation.FormationApostlesController = require("game/formation/apostles/controller/FormationApostlesController").new(formation.FormationApostlesManager)

------------------------------------------------------------ Teaching ------------------------------------------------------------
formation.FormationTeachingManager = require("game/formation/teaching/manager/FormationTeachingManager").new()
formation.FormationTeachingPanel = require("game/formation/teaching/view/FormationTeachingPanel")
formation.FormationTeachingHeroSelectPanel = require("game/formation/teaching/view/FormationTeachingHeroSelectPanel")
formation.FormationTeachingHeroSelectItem = require("game/formation/teaching/view/item/FormationTeachingHeroSelectItem")
formation.FormationTeachingController = require("game/formation/teaching/controller/FormationTeachingController").new(formation.FormationTeachingManager)

------------------------------------------------------------ Power ------------------------------------------------------------
formation.FormationPowerManager = require("game/formation/power/manager/FormationPowerManager").new()
formation.FormationPowerPanel = require("game/formation/power/view/FormationPowerPanel")
formation.FormationPowerController = require("game/formation/power/controller/FormationPowerController").new(formation.FormationPowerManager)

formation.FormationPowerTipsPanel = require("game/formation/power/view/FormationPowerTipsPanel")

------------------------------------------------------------ RougeLike ------------------------------------------------------------
-- formation.FormationRogueLikeManager = require("game/formation/rogueLike/manager/FormationRogueLikeManager")
-- formation.FormationRogueLikePanel = require("game/formation/rogueLike/view/FormationRogueLikePanel")
-- formation.FormationRogueLikeHeroSelectPanel = require("game/formation/rogueLike/view/FormationRogueLikeHeroSelectPanel")
-- formation.FormationRogueLikeHeroSelectItem = require("game/formation/rogueLike/view/item/FormationRogueLikeHeroSelectItem")
-- formation.FormationRogueLikeController = require("game/formation/rogueLike/controller/FormationRogueLikeController").new(formation.FormationRogueLikeManager)

------------------------------------------------------------ MainExplore ------------------------------------------------------------
formation.FormationMainExploreManager = require("game/formation/mainExplore/manager/FormationMainExploreManager").new()
formation.FormationMainExplorePanel = require("game/formation/mainExplore/view/FormationMainExplorePanel")
formation.FormationMainExploreHeroSelectPanel = require("game/formation/mainExplore/view/FormationMainExploreHeroSelectPanel")
formation.FormationMainExploreHeroSelectItem = require("game/formation/mainExplore/view/item/FormationMainExploreHeroSelectItem")
formation.FormationMainExploreController = require("game/formation/mainExplore/controller/FormationMainExploreController").new(formation.FormationMainExploreManager)

------------------------------------------------------------ DupImplied ------------------------------------------------------------
formation.DupImpliedExploreController = require("game/formation/dupImplied/controller/DupImpliedExploreController").new()

formation.FormationElementHomologyPanel = require("game/formation/normal/view/FormationElementHomologyPanel")
formation.FormationElementScrollerItem = require("game/formation/normal/view/item/FormationElementScrollerItem")

formation.ForamtionElementConfigVo = require("game/formation/normal/manager/vo/ForamtionElementConfigVo")

------------------------------------------------------------ Preview ------------------------------------------------------------
formation.FormationPreviewManager = require("game/formation/enemyPreview/manager/FormationPreviewManager").new()
formation.FromtionPreviewController = require("game/formation/enemyPreview/controller/FromtionPreviewController").new(formation.FormationPreviewManager)
formation.FormationPreviewPanel = require("game/formation/enemyPreview/view/FormationPreviewPanel")

------------------------------------------------------------ Element -----------------------------------------------------------
formation.FormationElementPanel = require("game/formation/elementTower/view/FormationElementPanel")
formation.FormationElementTowerManager = require("game/formation/elementTower/manager/FormationElementTowerManager").new()
formation.FormationElementTowerController = require("game/formation/elementTower/controller/FormationElementTowerController").new(formation.formanager)

------------------------------------------------------------ Cycle -----------------------------------------------------------
formation.FormationCycleManager = require("game/formation/cycle/manager/FormationCycleManager")
formation.FormationCyclePanel = require("game/formation/cycle/view/FormationCyclePanel")
formation.FormationCycleHeroSelectPanel = require("game/formation/cycle/view/FormationCycleHeroSelectPanel")
formation.FormationCycleController = require("game/formation/cycle/controller/FormationCycleController").new(formation.FormationCycleManager)

----------------------------------------------------------- ClimbTower ------------------------------------------------------
formation.FormationClimbTowerPanel = require("game/formation/climbTower/view/FormationClimbTowerPanel")
formation.FormationClimbTowerManager = require("game/formation/climbTower/manager/FormationClimbTowerManager")
formation.FormationClimbTowerController = require("game/formation/climbTower/controller/FormationClimbTowerController").new(formation.FormationClimbTowerManager)

----------------------------------------------------------- ActivityDup ------------------------------------------------------
formation.FormationActivityDupPanel = require("game/formation/activityDup/view/FormationActivityDupPanel")
formation.FormationActivityDupManager = require("game/formation/activityDup/manager/FormationActivityDupManager")
formation.FormationActivityDupController = require("game/formation/activityDup/controller/FormationActivityDupController").new(formation.FormationActivityDupManager)

------------------------------------------------------------ ArenaPeakAttack ------------------------------------------------------------
formation.FormationArenaPeakAttackManager = require("game/formation/arenaPeakAttack/manager/FormationArenaPeakAttackManager").new()
formation.FormationArenaPeakAttackPanel = require("game/formation/arenaPeakAttack/view/FormationArenaPeakAttackPanel")
formation.FormationArenaPeakAttackController = require("game/formation/arenaPeakAttack/controller/FormationArenaPeakAttackController").new(formation.FormationArenaPeakAttackManager)
formation.FormationArenaPeakAttackSelectPanel = require("game/formation/arenaPeakAttack/view/FormationArenaPeakAttackSelectPanel")
formation.FormationArenaPeakAttackSelectItem = require("game/formation/arenaPeakAttack/view/item/FormationArenaPeakAttackSelectItem")

------------------------------------------------------------ ArenaPeakDefense ------------------------------------------------------------
formation.FormationArenaPeakDefenseManager = require("game/formation/arenaPeakDefense/manager/FormationArenaPeakDefenseManager").new()
formation.FormationArenaPeakDefensePanel = require("game/formation/arenaPeakDefense/view/FormationArenaPeakDefensePanel")
formation.FormationArenaPeakDefenseController = require("game/formation/arenaPeakDefense/controller/FormationArenaPeakDefenseController").new(formation.FormationArenaPeakDefenseManager)
formation.FormationArenaPeakDefenseSelectPanel = require("game/formation/arenaPeakDefense/view/FormationArenaPeakDefenseSelectPanel")
formation.FormationArenaPeakDefenseSelectItem = require("game/formation/arenaPeakDefense/view/item/FormationArenaPeakDefenseSelectItem")

------------------------------------------------------------ GuildBossWar ------------------------------------------------------------
formation.FormationGuildBossWarManager = require("game/formation/guildBossWar/manager/FormationGuildBossWarManager").new()
formation.FormationGuildBossWarPanel = require("game/formation/guildBossWar/view/FormationGuildBossWarPanel")
formation.FormationGuildBossWarController = require("game/formation/guildBossWar/controller/FormationGuildBossWarController").new(formation.FormationGuildBossWarManager)
formation.FormationGuildBossWarSelectPanel = require("game/formation/guildBossWar/view/FormationGuildBossWarHeroSelectPanel")
formation.FormationGuildBossWarSelectItem = require("game/formation/guildBossWar/view/item/FormationGuildBossWarHeroSelectItem")

------------------------------------------------------------ SandPlay ------------------------------------------------------------
formation.FormationSandPlayManager = require("game/formation/sandPlay/manager/FormationSandPlayManager").new()
formation.FormationSandPlayPanel = require("game/formation/sandPlay/view/FormationSandPlayPanel")
formation.FormationSandPlayController = require("game/formation/sandPlay/controller/FormationSandPlayController").new(formation.FormationSandPlayManager)
formation.FormationSandPlayHeroSelectPanel = require("game/formation/sandPlay/view/FormationSandPlayHeroSelectPanel")
formation.FormationSandPlayHeroSelectItem = require("game/formation/sandPlay/view/item/FormationSandPlayHeroSelectItem")

------------------------------------------------------------ GuildBossImitate ------------------------------------------------------------
formation.FormationGuildBossImitateManager = require("game/formation/guildBossImitate/manager/FormationGuildBossImitateManager").new()
formation.FormationGuildBossImitateController = require("game/formation/guildBossImitate/controller/FormationGuildBossImitateController").new(formation.FormationGuildBossImitateManager)


----------------------------------------------------------- doundless ------------------------------------------------------
formation.FormationDoundlessPanel = require("game/formation/doundless/view/FormationDoundlessPanel")
formation.FormationDoundlessManager = require("game/formation/doundless/manager/FormationDoundlessManager")
formation.FormationDoundlessController = require("game/formation/doundless/controller/FormationDoundlessController").new(formation.FormationDoundlessManager)

----------------------------------------------------------- disaster------------------------------------------------------

formation.FormaionDisasterLogPanel = require("game/formation/disaster/view/FormaionDisasterLogPanel")

formation.FormationDisasterPanel = require("game/formation/disaster/view/FormationDisasterPanel")
formation.FormationDisasterManager = require("game/formation/disaster/manager/FormationDisasterManager")
formation.FormationDisasterController = require("game/formation/disaster/controller/FormationDisasterController").new(formation.FormationDisasterManager)

formation.FormationDisasterSelectPanel = require("game/formation/disaster/view/FormationDisasterSelectPanel")
formation.FormationDisasterSelectItem = require("game/formation/disaster/view/item/FormationDisasterSelectItem")


----------------------------------------------------------- seabed------------------------------------------------------
formation.FormationSeabedPanel = require("game/formation/seabed/view/FormationSeabedPanel")
formation.FormationSeabedHeroSelectPanel = require("game/formation/seabed/view/FormationSeabedHeroSelectPanel")
formation.FormationSeabedHeroSelectItem = require("game/formation/seabed/view/item/FormationSeabedHeroSelectItem")

formation.FormationSeabedManager = require("game/formation/seabed/manager/FormationSeabedManager")
formation.FormationSeabedController = require("game/formation/seabed/controller/FormationSeabedController").new(formation.FormationSeabedManager)

----------------------------------------------------------- guildWar atk ------------------------------------------------------

formation.FormationGuildWarAtkPanel = require("game/formation/guildWarAtk/view/FormationGuildWarAtkPanel")

formation.FormationGuildWarAtkSelectPanel = require("game/formation/guildWarAtk/view/FormationGuildWarAtkSelectPanel")
formation.FormationGuildWarAtkSelectItem = require("game/formation/guildWarAtk/view/item/FormationGuildWarAtkSelectItem")
formation.FormationGuildWarAtkManager = require("game/formation/guildWarAtk/manager/FormationGuildWarAtkManager").new()
formation.FormationGuildWarAtkController = require("game/formation/guildWarAtk/controller/FormationGuildWarAtkController").new(formation.FormationGuildWarAtkManager)

----------------------------------------------------------- guildWar def ------------------------------------------------------

formation.FormationGuildWarDefPanel = require("game/formation/guildWarDef/view/FormationGuildWarDefPanel")
formation.FormationGuildWarDefSelectPanel = require("game/formation/guildWarDef/view/FormationGuildWarDefSelectPanel")
formation.FormationGuildWarDefSelectItem = require("game/formation/guildWarDef/view/item/FormationGuildWarDefSelectItem")
formation.FormationGuildWarDefManager = require("game/formation/guildWarDef/manager/FormationGuildWarDefManager").new()
formation.FormationGuildWarDefController = require("game/formation/guildWarDef/controller/FormationGuildWarDefController").new(formation.FormationGuildWarDefManager)


local module = {}
table.insert(module, formation.FormationController)
table.insert(module, formation.FormationSceneController)
table.insert(module, formation.FormationPlayerEditController)
table.insert(module, formation.FormationArenaDefenseController)
table.insert(module, formation.FormationMainSupportController)
table.insert(module, formation.FormationMainFixedController)
table.insert(module, formation.FormationDistributeController)
table.insert(module, formation.FormationCodeHopeController)
table.insert(module, formation.FormationMazeController)
table.insert(module, formation.FormationApostlesController)
table.insert(module, formation.FormationTeachingController)
table.insert(module, formation.FormationPowerController)
--table.insert(module, formation.FormationRogueLikeController)
table.insert(module, formation.FormationMainExploreController)
table.insert(module, formation.DupImpliedExploreController)
table.insert(module, formation.FromtionPreviewController)
table.insert(module, formation.FormationElementTowerController)
table.insert(module, formation.FormationCycleController)
table.insert(module, formation.FormationClimbTowerController)
table.insert(module, formation.FormationArenaPeakDefenseController)
table.insert(module, formation.FormationArenaPeakAttackController)
table.insert(module, formation.FormationGuildBossWarController)
table.insert(module, formation.FormationDisasterController)
table.insert(module, formation.FormationSeabedController)
table.insert(module, formation.FormationGuildWarDefController)
table.insert(module, formation.FormationGuildWarAtkController)
return module

--[[ 替换语言包自动生成，请勿修改！
]]
