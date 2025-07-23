fight = {}

require('game/fight/FightConst')
fight.FightDef = require('game/fight/FightDef')
--scene item
fight.LiveBase = require('game/fight/view/LiveBase')
fight.LiveView = require('game/fight/view/LiveView')
fight.LiveWeapon = require('game/fight/view/LiveWeapon')
fight.Livething = require('game/fight/view/Livething')
fight.SceneGrid = require('game/fight/view/SceneGrid').new()

--vo
fight.LivethingVo = require('game/fight/manager/vo/LivethingVo')
fight.SkillVo = require('game/fight/manager/vo/SkillVo')
fight.AttDicVo = require('game/fight/manager/vo/AttDicVo')
-- fight.CalculatorAttVo = require('game/fight/calculator/manager/vo/CalculatorAttVo')
fight.UseSkillVo = require('game/fight/manager/vo/UseSkillVo')
fight.CdDicVo = require('game/fight/manager/vo/CdDicVo')
-- fight.PassiveSkillExecutorVo = require("game/fight/passiveSkill/manager/vo/PassiveSkillExecutorVo")

fight.SkillTmpVo = require('game/fight/manager/vo/SkillTmpVo')
fight.BattlePriorityVo = require('game/fight/manager/vo/BattlePriorityVo')
fight.SkillEditorDataRo = require('game/fight/manager/vo/SkillEditorDataRo')
-- ro
fight.SceneDataRo = require('game/fight/manager/vo/SceneDataRo')
fight.SkillDataRo = require('game/fight/manager/vo/SkillDataRo')
fight.FightShowDataRo = require('game/fight/manager/vo/FightShowDataRo')
fight.RoleShowoffsetRo = require('game/fight/manager/vo/RoleShowoffsetRo')
fight.RoleShowmodeRo = require('game/fight/manager/vo/RoleShowmodeRo')
fight.AlwaysEffectDataRo = require('game/fight/manager/vo/AlwaysEffectDataRo')
fight.SoundDataRo = require('game/fight/manager/vo/SoundDataRo')
fight.DupFightDataRo = require('game/fight/manager/vo/DupFightDataRo')

fight.EffectDataRo = require('game/fight/manager/vo/EffectDataRo')
fight.AttrShowDataRo = require('game/fight/manager/vo/AttrShowDataRo')

fight.BossShowCofingVo = require('game/fight/manager/vo/BossShowCofingVo')
fight.passiveSkillCofingVo = require('game/fight/passiveSkill/vo/PassiveSkillCofingVo')


fight.Tile = require('game/fight/manager/vo/Tile')

--util
fight.SkillConst = require("game/fight/manager/vo/SkillConst")
-- fight.CalculatorConst = require("game/fight/calculator/manager/CalculatorConst")
-- fight.PassiveSkillConst = require("game/fight/passiveSkill/manager/PassiveSkillConst")
fight.MoveType = require('game/fight/ai/move/MoveType')

fight.SceneUtil = require('game/fight/utils/SceneUtil')
fight.AIUtil = require('game/fight/ai/AIUtil')
fight.FightAI = require("game/fight/ai/FightAI")
-- fight.CalculatorUtil = require("game/fight/calculator/CalculatorUtil")
-- fight.PassiveSkillUtil = require("game/fight/passiveSkill/PassiveSkillUtil")
fight.AttConst = require("game/fight/manager/vo/AttConst")
fight.SeedRandom = require("game/fight/utils/SeedRandom")


fight.LiveLooper = require('game/fight/utils/LiveLooper').new()


-- 现阶段不需要用寻路算法
-- fight.FindPath = require("game/fight/utils/path/FindPath")

--event
fight.AIEvent = require("game/fight/ai/AIEvent")

--buff
require('game/fight/buff/BuffInit')
--ABBlock
require('game/fight/abblock/ABBlockInit')

require('game/fight/skill/performLogic/SkillPerfInit')

--manager
fight.FightCamera = require('game/fight/manager/FightCamera').new()
fight.FightSetting = require("game/fight/manager/FightSetting").new()
fight.FightLoader = require("game/fight/manager/FightLoader").new()
fight.SceneManager = require('game/fight/manager/SceneManager').new()
fight.SceneItemManager = require('game/fight/manager/SceneItemManager').new()
fight.FightManager = require('game/fight/manager/FightManager').new()
fight.RoleShowManager = require('game/fight/manager/RoleShowManager').new()
fight.AIManager = require('game/fight/manager/AIManager').new()
fight.PlayerManager = require('game/fight/manager/PlayerManager').new()
fight.SkillManager = require('game/fight/manager/SkillManager').new()
-- fight.CalculatorManager = require("game/fight/calculator/manager/CalculatorManager").new()
fight.TweenManager = require("game/fight/manager/TweenManager").new()
fight.CDManager = require("game/fight/manager/CDManager").new()
fight.TargetManager = require("game/fight/manager/TargetManager").new()
fight.AttrManager = require("game/fight/manager/AttrManager").new()
-- fight.PassiveSkillManager = require("game/fight/passiveSkill/manager/PassiveSkillManager").new()
fight.FightAction = require("game/fight/manager/FightAction").new()
fight.FightActionPlayer = require("game/fight/manager/FightActionPlayer").new()
fight.FightEffectHandle = require("game/fight/manager/FightEffectHandle").new()
fight.LivePerformManager = require("game/fight/manager/LivePerformManager").new()
fight.PassiveSkillManager = require("game/fight/passiveSkill/PassiveSkillManager").new()
fight.BuffTriggerEftManger = require("game/fight/buff/BuffTriggerEftManger").new()


--controller
local _c = require('game/fight/controller/FightController').new(fight.FightManager)
local _aic = require('game/fight/controller/AIController').new()
local _playerc = require('game/fight/controller/PlayerController').new()
local _sc = require('game/fight/controller/SceneController').new()
-- local _ccc = require("game/fight/calculator/controller/CalculatorController").new()
-- local _psc = require("game/fight/passiveSkill/controller/PassiveSkillController").new()
local module = { _c, _aic, _playerc, _sc, _ccc }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
