dup = {}
-- main
require('game/dup/DupConst')
require('game/dup/baseDupPotency/manager/DupPotencyConst')
dup.DupMainManager = require('game/dup/DupMainManager').new()
dup.DupInfoVo = require('game/dup/DupInfoVo')
dup.DupUpVo = require('game/dup/DupUpVo')
local _dupMainController = require('game/dup/DupMainController').new()

-- -----------------------------------daily-----------------------------
dup.DupDailyUtil = require('game/dup/baseDaily/DupDailyUtil')
dup.DupDailyBasePanel = require('game/dup/baseDaily/DupDailyBasePanel')
dup.DupDailyBaseItem = require('game/dup/baseDaily/item/DupDailyBaseItem')
dup.DupDailyBaseManager = require('game/dup/baseDaily/DupDailyBaseManager')
dup.DupDailyBaseController = require('game/dup/baseDaily/DupDailyBaseController')
dup.DupDailyDataVo = require('game/dup/baseDaily/vo/DupDailyDataVo')
dup.DupDailyConfigVo = require('game/dup/baseDaily/vo/DupDailyConfigVo')
dup.DupDailyInfoView = require('game/dup/baseDaily/DupDailyInfoView')
dup.DupDailyEnterItem = require('game/dup/baseDaily/item/DupDailyEnterItem')
dup.DupDailyMoreInfo = require('game/dup/baseDaily/DupDailyMoreInfo')
dup.DupDailyConst = require('game/dup/baseDaily/DupDailyConst')
--basePotency 潜能
dup.DupPotencyView = require('game/dup/baseDupPotency/view/DupPotencyView')
dup.DupPotencyItem = require('game/dup/baseDupPotency/view/item/DupPotencyItem')
dup.DupPotencyManager = require('game/dup/baseDupPotency/manager/DupPotencyManager').new()
-- dailymain
dup.DupDailyMainPanel = require('game/dup/baseDaily/DupDailyMainPanel')
dup.DupDailyMainManager = require('game/dup/baseDaily/DupDailyMainManager').new()
local _dupDailyMainController = require('game/dup/baseDaily/DupDailyMainController').new()


-- dupMoney
dup.DupMoneyPanel = require('game/dup/dup_money/view/DupMoneyPanel')
dup.DupMoneyItem = require('game/dup/dup_money/view/item/DupMoneyItem')
dup.DupMoneyManager = require('game/dup/dup_money/manager/DupMoneyManager').new()
local _dupMoneyController = require('game/dup/dup_money/controller/DupMoneyController').new()

-- dupExp
dup.DupExpPanel = require('game/dup/dup_exp/view/DupExpPanel')
dup.DupExpItem = require('game/dup/dup_exp/view/item/DupExpItem')
dup.DupExpManager = require('game/dup/dup_exp/manager/DupExpManager').new()
local _dupExpController = require('game/dup/dup_exp/controller/DupExpController').new()

--dupEquipTupo
dup.DupEquipTupoPanel = require('game/dup/dup_equip_tupo/view/DupEquipTupoPanel')
dup.DupEquipTupoItem = require('game/dup/dup_equip_tupo/view/item/DupEquipTupoItem')
dup.DupEquipTupoManager = require('game/dup/dup_equip_tupo/manager/DupEquipTupoManager').new()
local _dupEquipTupoController = require('game/dup/dup_equip_tupo/controller/DupEquipTupoController').new()

-- dupBracelets
dup.DupBraceletsPanel = require('game/dup/dup_bracelets/view/DupBraceletsPanel')
dup.DupBraceletsItem = require('game/dup/dup_bracelets/view/item/DupBraceletsItem')
dup.DupBraceletsManager = require('game/dup/dup_bracelets/manager/DupBraceletsManager').new()
local _dupBraceletsController = require('game/dup/dup_bracelets/controller/DupBraceletsController').new()

-- dupHeroStarUp
dup.DupHeroStarUpPanel = require('game/dup/dup_hero_star_up/view/DupHeroStarUpPanel')
dup.DupHeroStarUpItem = require('game/dup/dup_hero_star_up/view/item/DupHeroStarUpItem')
dup.DupHeroStarUpManager = require('game/dup/dup_hero_star_up/manager/DupHeroStarUpManager').new()
local _dupHeroStarUpController = require('game/dup/dup_hero_star_up/controller/DupHeroStarUpController').new()

-- dupHeroGrowUp
dup.DupHeroGrowUpPanel = require('game/dup/dup_hero_grow_up/view/DupHeroGrowUpPanel')
dup.DupHeroGrowUpItem = require('game/dup/dup_hero_grow_up/view/item/DupHeroGrowUpItem')
dup.DupHeroGrowUpManager = require('game/dup/dup_hero_grow_up/manager/DupHeroGrowUpManager').new()
local _dupHeroGrowUpController = require('game/dup/dup_hero_grow_up/controller/DupHeroGrowUpController').new()

-- dupHeroSkillUp
dup.DupHeroSkillUpPanel = require('game/dup/dup_hero_skill/view/DupHeroSkillUpPanel')
dup.DupHeroSkillUpItem = require('game/dup/dup_hero_skill/view/item/DupHeroSkillUpItem')
dup.DupHeroSkillUpManager = require('game/dup/dup_hero_skill/manager/DupHeroSkillUpManager').new()
local _dupHeroSkillUpController = require('game/dup/dup_hero_skill/controller/DupHeroSkillUpController').new()

-------------------------------------------------challenge------------------------------
dup.DupChallengePanel = require('game/dup/baseChallenge/DupChallengePanel')
dup.DupChallengeEnterItem = require('game/dup/baseChallenge/item/DupChallengeEnterItem')
dup.DupChallengeManager = require('game/dup/baseChallenge/DupChallengeManager').new()
local _dupChallengeController = require('game/dup/baseChallenge/DupChallengeController').new()

-- climb_tower
dup.DupClimbTowerPanel = require('game/dup/dup_climb_tower/view/DupClimbTowerPanel')
dup.DupClimbTowerDeepPanel = require('game/dup/dup_climb_tower/view/DupClimbTowerDeepPanel')
dup.DupClimbTowerDupPanel = require('game/dup/dup_climb_tower/view/DupClimbTowerDupPanel')
dup.DupClimbTowerDeepDupPanel = require('game/dup/dup_climb_tower/view/DupClimbTowerDeepDupPanel')
dup.DupClimbTowerAreaItem = require('game/dup/dup_climb_tower/view/item/DupClimbTowerAreaItem')
dup.DupClimbTowerDeepAreaItem = require('game/dup/dup_climb_tower/view/item/DupClimbTowerDeepAreaItem')
dup.DupClimbTowerDupItem = require('game/dup/dup_climb_tower/view/item/DupClimbTowerDupItem')
dup.DupClimbTowerDeepDupItem = require('game/dup/dup_climb_tower/view/item/DupClimbTowerDeepDupItem')
dup.DupClimbTowerAreaVo = require('game/dup/dup_climb_tower/manager/vo/DupClimbTowerAreaVo')
dup.DupClimbTowerDupVo = require('game/dup/dup_climb_tower/manager/vo/DupClimbTowerDupVo')
dup.DupClimbElementVo = require('game/dup/dup_climb_tower/manager/vo/DupClimbElementVo')
dup.DupClimbElementMsgVo = require('game/dup/dup_climb_tower/manager/vo/DupClimbElementMsgVo')
dup.DupClimbElementDupVo = require('game/dup/dup_climb_tower/manager/vo/DupClimbElementDupVo')
dup.DupClimbTowerManager = require('game/dup/dup_climb_tower/manager/DupClimbTowerManager').new()
local _dupClimbTowerController = require('game/dup/dup_climb_tower/controller/DupClimbTowerController').new(dup.DupClimbTowerManager)

-- code_hope
dup.DupCodeHopeMainPanel = require("game/dup/dup_codeHope/view/DupCodeHopeMainPanel")
dup.DupCodeHopeChapterPanel = require("game/dup/dup_codeHope/view/DupCodeHopeChapterPanel")
dup.DupCodeHopeInfoView = require("game/dup/dup_codeHope/view/DupCodeHopeInfoView")
dup.DupCodeHopeShowBuffView = require("game/dup/dup_codeHope/view/DupCodeHopeShowBuffView")
dup.DupCodeHopeResetView = require("game/dup/dup_codeHope/view/DupCodeHopeResetView")
dup.DupCodeHopeRankHallPanel = require("game/dup/dup_codeHope/view/DupCodeHopeRankHallPanel")
dup.DupCodeHopeRankPanel = require("game/dup/dup_codeHope/view/DupCodeHopeRankPanel")
dup.DupCodeHopeAwardPanel = require("game/dup/dup_codeHope/view/DupCodeHopeAwardPanel")

dup.DupCodeHopeTabItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeTabItem")
dup.DupCodeHopeDupItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeDupItem")
dup.DupCodeHopeDupBossItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeDupBossItem")
dup.DupCodeHopeRankItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeRankItem")
dup.DupCodeHopeAwardItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeAwardItem")
dup.DupCodeHopeLevelItem = require("game/dup/dup_codeHope/view/item/DupCodeHopeLevelItem")

dup.DupCodeHopeBuffVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeBuffVo")
dup.DupCodeHopeDataVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeDataVo")
dup.DupCodeHopeDupVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeDupVo")
dup.DupCodeHopeHeroVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeHeroVo")
dup.DupCodeHopeInfoVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeInfoVo")
dup.DupCodeHopeRankVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeRankVo")
dup.DupCodeHopeRewardVo = require("game/dup/dup_codeHope/manager/vo/DupCodeHopeRewardVo")

dup.DupCodeHopeManager = require("game/dup/dup_codeHope/manager/DupCodeHopeManager").new()
local _dupCodeHopeController = require('game/dup/dup_codeHope/controller/DupCodeHopeController').new(dup.DupCodeHopeManager)

-- implied
dup.DupImpliedEnterPanel = require("game/dup/dup_implied/view/DupImpliedEnterPanel")
dup.DupImpliedDupPanel = require("game/dup/dup_implied/view/DupImpliedDupPanel")
dup.DupImpliedRankHallPanel = require("game/dup/dup_implied/view/DupImpliedRankHallPanel")
dup.DupImpliedRankPanel = require("game/dup/dup_implied/view/DupImpliedRankPanel")
dup.DupImpliedAwardPanel = require("game/dup/dup_implied/view/DupImpliedAwardPanel")
dup.DupImpliedLevelSelectPanel = require("game/dup/dup_implied/view/DupImpliedLevelSelectPanel")
dup.DupImpliedDupInfoView = require("game/dup/dup_implied/view/DupImpliedDupInfoView")
dup.DupImpliedMatrixSelectView = require("game/dup/dup_implied/view/DupImpliedMatrixSelectView")
dup.DupImpliedMatrixShowView = require("game/dup/dup_implied/view/DupImpliedMatrixShowView")
dup.DupImpliedAbnormalShowView = require("game/dup/dup_implied/view/DupImpliedAbnormalShowView")
dup.DupImpliedMatrixBookView = require("game/dup/dup_implied/view/DupImpliedMatrixBookView")

dup.DupImpliedRankItem = require("game/dup/dup_implied/view/item/DupImpliedRankItem")
dup.DupImpliedAwardItem = require("game/dup/dup_implied/view/item/DupImpliedAwardItem")
dup.DupImpliedDupItem = require("game/dup/dup_implied/view/item/DupImpliedDupItem")
dup.DupImpliedLevelSelectItem = require("game/dup/dup_implied/view/item/DupImpliedLevelSelectItem")
dup.DupImpliedMatrixSelectItem = require("game/dup/dup_implied/view/item/DupImpliedMatrixSelectItem")
dup.DupImpliedMatrixItem = require("game/dup/dup_implied/view/item/DupImpliedMatrixItem")

dup.DupImpliedStageVo = require("game/dup/dup_implied/manager/vo/DupImpliedStageVo")
dup.DupImpliedDupVo = require("game/dup/dup_implied/manager/vo/DupImpliedDupVo")
dup.DupImpliedRewardVo = require("game/dup/dup_implied/manager/vo/DupImpliedRewardVo")
dup.DupImpliedMatrixVo = require("game/dup/dup_implied/manager/vo/DupImpliedMatrixVo")
dup.DupImpliedInfoVo = require("game/dup/dup_implied/manager/vo/DupImpliedInfoVo")
dup.DupImpliedRankVo = require("game/dup/dup_implied/manager/vo/DupImpliedRankVo")
dup.DupImpliedDifficultyVo = require("game/dup/dup_implied/manager/vo/DupImpliedDifficultyVo")

dup.DupImpliedManager = require("game/dup/dup_implied/manager/DupImpliedManager").new()
dup.DupImpliedController = require('game/dup/dup_implied/controller/DupImpliedController').new(dup.DupImpliedManager)

-- apostlesWar
dup.DupApostlesMainPanel = require("game/dup/dup_apostles_war/view/DupApostlesMainPanel")
dup.DupApostlesBossInfoView = require("game/dup/dup_apostles_war/view/DupApostlesBossInfoView")
dup.DupApostlesWarStarAwardPanel = require("game/dup/dup_apostles_war/view/DupApostlesWarStarAwardPanel")
dup.DupApostlesWarPanel = require("game/dup/dup_apostles_war/view/DupApostlesWarPanel")
dup.DupApostlesWarGoalPanel = require("game/dup/dup_apostles_war/view/DupApostlesWarGoalPanel")

dup.DupApostlesWarGoalItem = require("game/dup/dup_apostles_war/view/item/DupApostlesWarGoalItem")
dup.DupApostlesRewardItem = require("game/dup/dup_apostles_war/view/item/DupApostlesRewardItem")

dup.DupApostlesWarGoalVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesWarGoalVo")
dup.DupApostlesWarVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesWarVo")
dup.DupApostlesStarVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesStarVo")
dup.DupApostlesTaskVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesTaskVo")
dup.DupApostlesDataVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesDataVo")
dup.DupApostlesCloisterVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesCloisterVo")

dup.DupApostlesBossDiffiVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesBossDiffiVo")
dup.DupApostlesBossVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesBossVo")
dup.DupApostlesPanelInfoVo = require("game/dup/dup_apostles_war/manager/vo/DupApostlesPanelInfoVo")

dup.DupApostlesWarManager = require("game/dup/dup_apostles_war/manager/DupApostlesWarManager").new()
dup.DupApostlesWarController = require('game/dup/dup_apostles_war/controller/DupApostlesWarController').new(dup.DupApostlesWarManager)

-------------------------------------------------equip------------------------------
dup.DupChipItem = require('game/dup/baseDupEquip/DupChipItem')
dup.DupChipConst = require('game/dup/dup_equip/manager/DupChipConst')
dup.DupChipAwardRoleView = require("game/dup/dup_equip/view/DupChipAwardRoleView")
dup.DupChipInfoView = require('game/dup/baseDupEquip/DupChipInfoView')
dup.DupChipSelectView = require('game/dup/baseDupEquip/DupChipSelectView')

dup.DupEquipConfigVo = require("game/dup/baseDupEquip/vo/DupEquipConfigVo")
dup.DupEquipMainManager = require("game/dup/baseDupEquip/DupEquipMainManager").new()
dup.DupEquipMainController = require("game/dup/baseDupEquip/DupEquipMainController").new(dup.DupEquipMainManager)


dup.DupEquipBaseManager = require('game/dup/baseDupEquip/DupEquipBaseManager')
dup.DupEquipBaseController = require('game/dup/baseDupEquip/DupEquipBaseController')
dup.DupEquipBasePanel = require('game/dup/baseDupEquip/DupEquipBasePanel')

dup.DupEquipInfoView = require('game/dup/baseDupEquip/DupEquipInfoView')

--dupEquip  
dup.DupEquipItem = require('game/dup/dup_equip/view/item/DupEquipItem')

-- low
dup.DupEquipLowPanel = require('game/dup/dup_equip/view/DupEquipLowPanel')
dup.DupEquipLowManager = require('game/dup/dup_equip/manager/DupEquipLowManager').new()
local _dupEquipLowController = require('game/dup/dup_equip/controller/DupEquipLowController').new()

-- mid
dup.DupEquipMidPanel = require('game/dup/dup_equip/view/DupEquipMidPanel')
dup.DupEquipMidManager = require('game/dup/dup_equip/manager/DupEquipMidManager').new()
local _dupEquipMidController = require('game/dup/dup_equip/controller/DupEquipMidController').new()
-- high
dup.DupEquipHighPanel = require('game/dup/dup_equip/view/DupEquipHighPanel')
dup.DupEquipHighManager = require('game/dup/dup_equip/manager/DupEquipHighManager').new()
local _dupEquipHighController = require('game/dup/dup_equip/controller/DupEquipHighController').new()



local module = { _dupMainController, _dupDailyMainController, _dupMoneyController,
_dupExpController, _dupChallengeController, _dupClimbTowerController,
_dupEquipLowController, _dupEquipMidController, _dupEquipHighController, _dupEquipTupoController, _dupBraceletsController,
_dupHeroStarUpController, _dupCodeHopeController, dup.DupImpliedController, dup.DupApostlesWarController, dup.DupEquipMainController
}

return module

--[[ 替换语言包自动生成，请勿修改！
]]