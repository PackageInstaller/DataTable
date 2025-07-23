danke = {}

--vo
danke.DanKeMapConfigVo = require("game/danke/manager/vo/DanKeMapConfigVo")
danke.DanKeHeroConfigVo = require("game/danke/manager/vo/DanKeHeroConfigVo")
danke.DanKeMonsterConfigVo = require("game/danke/manager/vo/DanKeMonsterConfigVo")
danke.DanKeStageConfigVo = require("game/danke/manager/vo/DanKeStageConfigVo")
danke.DanKePlayerSkillConfigVo = require("game/danke/manager/vo/DanKePlayerSkillConfigVo")
danke.DanKePlayerSkillVo = require("game/danke/manager/vo/DanKePlayerSkillVo")
danke.DanKeDropConfigVo = require("game/danke/manager/vo/DanKeDropConfigVo")
danke.DanKeTaskConfigVo = require("game/danke/manager/vo/DanKeTaskConfigVo")
danke.DanKeMonsterSkillConfigVo = require("game/danke/manager/vo/DanKeMonsterSkillConfigVo")
danke.DanKeStarConfigVo = require("game/danke/manager/vo/DanKeStarConfigVo")
danke.DanKeRewardConfigVo = require("game/danke/manager/vo/DanKeRewardConfigVo")

----UI
danke.DankeStagePanel = "game/danke/view/DankeStagePanel"
danke.DanKeSceneUI = "game/danke/view/DanKeSceneUI"
danke.DanKePausePanel = "game/danke/view/DanKePausePanel"
danke.DanKeSkillSelectPanel = "game/danke/view/DanKeSkillSelectPanel"
danke.DanKeRewardView = "game/danke/view/DanKeRewardView"
danke.DanKeSettlementPanel = "game/danke/view/DanKeSettlementPanel"

danke.DanKeJoystickView = require("game/danke/view/DanKeJoystickView")

danke.DanKeSceneUISkillItem = require("game/danke/view/item/DanKeSceneUISkillItem")
danke.DanKeStageItem = require("game/danke/view/item/DanKeStageItem")
danke.DanKeRewardItem = require("game/danke/view/item/DanKeRewardItem")

--场景模型
danke.DanKeBaseSpriteModel = require("game/danke/manager/model/DanKeBaseSpriteModel")

--场景实体
danke.DanKeBaseThing = require("game/danke/manager/thing/DanKeBaseThing")
danke.DanKePlayerThing = require("game/danke/manager/thing/DanKePlayerThing")
danke.DanKeMonsterThing = require("game/danke/manager/thing/DanKeMonsterThing")
danke.DanKeMonsterEliteThing = require("game/danke/manager/thing/DanKeMonsterEliteThing")

danke.DanKeDropThing = require("game/danke/manager/thing/DanKeDropThing")

--子弹
danke.DankeBullet = require("game/danke/manager/playBullet/DankeBullet")
danke.DankeBulletFlyKnife = require("game/danke/manager/playBullet/DankeBulletFlyKnife")
danke.DankeBulletShield = require("game/danke/manager/playBullet/DankeBulletShield")
danke.DankeBulletMagnetic = require("game/danke/manager/playBullet/DankeBulletMagnetic")
danke.DankeBulletWhip = require("game/danke/manager/playBullet/DankeBulletWhip")
danke.DankeBulletBumerang = require("game/danke/manager/playBullet/DankeBulletBumerang")
danke.DankeBulletFireBom = require("game/danke/manager/playBullet/DankeBulletFireBom")
danke.DankeBulletFire = require("game/danke/manager/playBullet/DankeBulletFire")
danke.DankeBulletPotShoot = require("game/danke/manager/playBullet/DankeBulletPotShoot")
danke.DankeBulletParabolic = require("game/danke/manager/playBullet/DankeBulletParabolic")
danke.DankeBulletFallMine = require("game/danke/manager/playBullet/DankeBulletFallMine")

danke.DankeMonsterBaseBullet = require("game/danke/manager/monsterBullet/DankeMonsterBaseBullet")
danke.DankeMonsterStraightBullet = require("game/danke/manager/monsterBullet/DankeMonsterStraightBullet")
danke.DankeMonsterDashBullet = require("game/danke/manager/monsterBullet/DankeMonsterDashBullet")

--玩家技能
danke.DankePlayerBaseSkill = require("game/danke/manager/playerSkill/DankePlayerBaseSkill")
--主动
danke.DankePlayerInitiativeSkill = require("game/danke/manager/playerSkill/DankePlayerInitiativeSkill")
danke.DankePlayerShieldSkill = require("game/danke/manager/playerSkill/DankePlayerShieldSkill")
danke.DankePlayerFlyKnifeSkill = require("game/danke/manager/playerSkill/DankePlayerFlyKnifeSkill")
danke.DankePlayerMagneticSkill = require("game/danke/manager/playerSkill/DankePlayerMagneticSkill")
danke.DankePlayerWhipSkill = require("game/danke/manager/playerSkill/DankePlayerWhipSkill")
danke.DankePlayerBumerangSkill = require("game/danke/manager/playerSkill/DankePlayerBumerangSkill")
danke.DankePlayerFireBombSkill = require("game/danke/manager/playerSkill/DankePlayerFireBombSkill")
danke.DankePlayerPotShootSkill = require("game/danke/manager/playerSkill/DankePlayerPotShootSkill")
danke.DankePlayerParabolicSkill = require("game/danke/manager/playerSkill/DankePlayerParabolicSkill")
danke.DankePlayerFallMineSkill = require("game/danke/manager/playerSkill/DankePlayerFallMineSkill")

--被动
danke.DankePlayerPassiveSkill = require("game/danke/manager/playerSkill/DankePlayerPassiveSkill")

--怪物技能
danke.DankeMonsterBaseSkill = require("game/danke/manager/monsterSkill/DankeMonsterBaseSkill")
danke.DankeMonsterShootSkill_2 = require("game/danke/manager/monsterSkill/DankeMonsterShootSkill_2")
danke.DankeMonsterShootSkill_3 = require("game/danke/manager/monsterSkill/DankeMonsterShootSkill_3")
danke.DankeMonsterShootSkill_4 = require("game/danke/manager/monsterSkill/DankeMonsterShootSkill_4")
danke.DankeMonsterShootSkill_Dash1 = require("game/danke/manager/monsterSkill/DankeMonsterShootSkill_Dash1")
danke.DankeMonsterShootSkill_Dash2 = require("game/danke/manager/monsterSkill/DankeMonsterShootSkill_Dash2")

--管理器
danke.DanKeColliderManager = require("game/danke/manager/DanKeColliderManager")
danke.DanKeCamera = require("game/danke/manager/DanKeCamera")
danke.DanKeConst = require("game/danke/manager/DanKeConst")
danke.DanKeffect = require("game/danke/manager/DanKeffect")
danke.DanKeManager = require("game/danke/manager/DanKeManager").new()
danke.DanKeController = require("game/danke/controller/DanKeController").new(danke.DanKeManager)
danke.DanKeSceneController = require("game/danke/controller/DanKeSceneController").new()

local module = {danke.DanKeController, danke.DanKeSceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
