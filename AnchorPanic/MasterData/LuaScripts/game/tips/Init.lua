tips = {}
require("game/tips/bracelet/BraceletTipConst")

tips.TipsManager = require("game/tips/TipsManager").new()
tips.BaseTips = require('game/tips/base/BaseTips')
tips.PropsTips = require('game/tips/props/PropsTips')
tips.HeroEggTips = require('game/tips/props/HeroEggTips')

tips.UAVBuyTips = require('game/tips/props/UAVUseTips')
tips.EquipTips = require('game/tips/equip/EquipTips')
tips.EquipTipsMin = require("game/tips/equip/EquipTipsMin")
tips.EquipTipsOtherMin = require("game/tips/equip/EquipTipsOtherMin")
tips.EquipInfoContrastTips = require('game/tips/equip/EquipInfoContrastTips')
tips.EquipInfoTips2 = require('game/tips/equip/EquipInfoTips2')

tips.BraceletTips = require('game/tips/bracelet/BraceletTips')
tips.BraceletSelfTips = require('game/tips/bracelet/BraceletSelfTips')
tips.RecommandTip = require('game/tips/formation/RecommandTip')

tips.HeroEquipContrastTips = require('game/tips/equip/HeroEquipContrastTips')
tips.NoMaskEquipTips = require('game/tips/equip/NoMaskEquipTips')
tips.SkillTips = require('game/tips/skill/SkillTips')
-- tips.OrderTips = require('game/tips/order/OrderTips')
tips.PassiveSkillTips = require('game/tips/skill/PassiveSkillTips')
tips.NuclearSkillTips = require('game/tips/skill/NuclearSkillTips')
tips.MonsterSkillTips = require('game/tips/skill/MonsterSkillTips')
tips.SingleSkillTips = require('game/tips/skill/SingleSkillTips')
tips.NormalSkillTips = require('game/tips/skill/NormalSkillTips')

tips.AttrListTips = require('game/tips/skill/AttrListTips')
tips.AttrListTipsItem = require('game/tips/skill/item/AttrListTipsItem')
tips.SkillTipsNew = require('game/tips/skill/SkillTipsNew')
tips.NormalSkillTipsNew = require('game/tips/skill/NormalSkillTipsNew')
tips.AssistSkillTips = require('game/tips/skill/AssistSkillTips')


tips.MonsterTips = require('game/tips/monster/MonsterTips')

tips.HeroAssistTip = require('game/tips/hero/HeroAssistTip')
tips.HeroEleAndOccTips = require('game/tips/hero/HeroEleAndOccTips')
tips.SkillEffectTips = require('game/tips/skill/SkillEffectTips')
tips.SpecialEffectTip = require('game/tips/skill/SpecialEffectTip')

tips.ClimbTowerTips = require('game/tips/other/ClimbTowerTips')

tips.BossSkillTips = require("game/tips/skill/BossSkillTips")
require('game/tips/base/TipsFactory')
local module = {}
return module

--[[ 替换语言包自动生成，请勿修改！
]]