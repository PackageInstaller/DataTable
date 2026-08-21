hero = {}
require("game/hero/manager/HeroConst")

--vo
hero.HeroConfigVo = require("game/hero/manager/vo/HeroConfigVo")
hero.HeroLvlUpConfigVo = require("game/hero/manager/vo/HeroLvlUpConfigVo")
hero.HeroColorUpConfigVo = require("game/hero/manager/vo/HeroColorUpConfigVo")
hero.HeroStarConfigVo = require("game/hero/manager/vo/HeroStarConfigVo")
hero.HeroFightSkillVo = require("game/hero/manager/vo/HeroFightSkillVo")
hero.HeroMilitaryRankConfigVo = require("game/hero/manager/vo/HeroMilitaryRankConfigVo")
hero.HeroVo = require("game/hero/manager/vo/HeroVo")
hero.OtherHeroVo = require("game/hero/manager/vo/OtherHeroVo")
--增幅相关
hero.HeroIncreasesVo = require("game/hero/manager/vo/HeroIncreasesVo")
hero.IncreasesVo = require("game/hero/manager/vo/IncreasesVo")
--职业与属性相关
hero.HeroEleAndOccVo = require("game/hero/manager/vo/HeroEleAndOccVo")
--manager
hero.HeroStarManager = require("game/hero/manager/HeroStarManager").new()
hero.HeroLvlUpManager = require("game/hero/manager/HeroLvlUpManager").new()
hero.HeroColorUpManager = require("game/hero/manager/HeroColorUpManager").new()
hero.HeroBraceletsManager = require("game/hero/manager/HeroBraceletsManager").new()
hero.HeroMilitaryRankManager = require("game/hero/manager/HeroMilitaryRankManager").new()
hero.HeroInteractManager = require("game/hero/manager/HeroInteractManager").new()
hero.HeroActionManager = require("game/hero/manager/HeroActionManager").new()
hero.HeroLvlTargetManager = require("game/hero/manager/HeroLvlTargetManager")
hero.HeroManager = require("game/hero/manager/HeroManager").new()

--view
hero.HeroPanel = require("game/hero/view/HeroPanel")
hero.HeroListSortPanel = require("game/hero/view/HeroListSortPanel")
hero.HeroInfoPanel = require("game/hero/view/HeroInfoPanel")
hero.HeroListScrollItem_1 = require("game/hero/view/item/HeroListScrollItem_1")
hero.HeroListScrollItem_2 = require("game/hero/view/item/HeroListScrollItem_2")
hero.HeroListScrollItem_3 = require("game/hero/view/item/HeroListScrollItem_3")
hero.HeroListScrollItem_4 = require("game/hero/view/item/HeroListScrollItem_4")
hero.HeroCard = require("game/hero/view/item/HeroCard")
hero.HeroCard2 = require("game/hero/view/item/HeroCard2")
hero.MonsterCard = require("game/hero/view/item/MonsterCard")
hero.HeroSortView = require("game/hero/view/HeroSortView")
hero.HeroSortMaxView = require("game/hero/view/HeroSortMaxView")
hero.HeroSortMinView = require("game/hero/view/HeroSortMinView")
hero.HeroMaterialPanel = require("game/hero/view/HeroMaterialPanel")
hero.HeroMaterialItem = require("game/hero/view/item/HeroMaterialItem")
hero.HeroSingleSelectPanel = require("game/hero/view/HeroSingleSelectPanel")

hero.HeroDetailPanel = require("game/hero/view/HeroDetailPanel")
hero.HeroStoryPanel = require("game/hero/view/HeroStoryPanel")
hero.HeroDevelopPanel = require("game/hero/view/HeroDevelopPanel")
hero.HeroUpGradePanel = require("game/hero/view/HeroUpGradePanel")
hero.HeroDetailDesTips = require("game/hero/view/HeroDetailDesTips")
hero.HeroAttrListPanel = require("game/hero/view/HeroAttrListPanel")
hero.HeroStarSkillView = require("game/hero/view/HeroStarSkillView")
hero.HeroDetailsSubPanel = require("game/hero/view/HeroDetailsSubPanel")
hero.HeroParticularsPanel = require("game/hero/view/HeroParticularsPanel")
hero.HeroIntroductionPanel = require("game/hero/view/HeroIntroductionPanel")
hero.HeroFragmentComposePanel = require("game/hero/view/HeroFragmentComposePanel")
--通用
hero.HeroSucPanelAttItem = require("game/hero/view/item/HeroSucPanelAttItem")
hero.HeroGetNewSkillPanel = require("game/hero/view/success/HeroGetNewSkillPanel")
hero.HeroJobPanel = require("game/hero/view/HeroJobPanel")

-- -- 概要信息
-- hero.HeroInfoBriefSubTabView = require("game/hero/view/subTab/HeroInfoBriefSubTabView")
-- -- 技能信息
hero.HeroDetailsInfoPanel = require("game/hero/view/HeroDetailsInfoPanel")
hero.HeroSkillIntroduceTabView = require("game/hero/view/tab/HeroSkillIntroduceTabView")
hero.HeroSkillIntroduceItem = require("game/hero/view/item/HeroSkillIntroduceItem")

-- 升级
hero.HeroLvlUpTabView = require("game/hero/view/tab/HeroLvlUpTabView")
hero.HeroLvlUpResetView = require("game/hero/view/tab/HeroLvlUpResetView")
hero.HeroLvlUpAttrItem_1 = require("game/hero/view/item/HeroLvlUpAttrItem_1")
hero.HeroRankUpAttrItem = require("game/hero/view/item/HeroRankUpAttrItem")

--共鸣
hero.HeroResonanceTabView = require("game/hero/view/tab/HeroResonanceTabView")
hero.HeroResonanceConfigVo = require("game/hero/manager/vo/HeroResonanceConfigVo")
hero.HeroResonanceSkillItem = require('game/hero/view/item/HeroResonanceSkillItem')

-- 技能
hero.HeroSkillTabView = require("game/hero/view/tab/HeroSkillTabView")
hero.HeroSkillItem2 = require 'game/hero/view/item/HeroSkillItem2'
hero.HeroSkillDetailSubTabView = require("game/hero/view/subTab/HeroSkillDetailSubTabView")
hero.HeroPassiveSkillItem = require("game/hero/view/item/HeroPassiveSkillItem")
hero.HeroSkillEditPanel = require("game/hero/view/HeroSkillEditPanel")

-- 升品
hero.HeroColorUpTabView = require("game/hero/view/tab/HeroColorUpTabView")
hero.HeroColorUpPreviewPanel = require("game/hero/view/HeroColorUpPreviewPanel")
hero.HeroColorUpSkillItem = require("game/hero/view/item/HeroColorUpSkillItem")
hero.HeroColorUpListItem = require("game/hero/view/item/HeroColorUpListItem")
hero.HeroColorUpMaterialPanel = require("game/hero/view/HeroColorUpMaterialPanel")
hero.HeroColorUpAddItem = require("game/hero/view/item/HeroColorUpAddItem")
hero.HeroColorUpScrollItem = require("game/hero/view/item/HeroColorUpScrollItem")
hero.HeroColorUpMaterialTipPanel = require("game/hero/view/HeroColorUpMaterialTipPanel")

hero.HeroLevelUpSucPanel = require("game/hero/view/success/HeroLevelUpSucPanel")

-- 军衔
hero.HeroMilitaryRankUpTabView = require("game/hero/view/tab/HeroMilitaryRankUpTabView")
hero.HeroMilitaryRankPreviewPanel = require("game/hero/view/HeroMilitaryRankPreviewPanel")
hero.HeroMilitaryRankMaterialPanel = require("game/hero/view/HeroMilitaryRankMaterialPanel")
hero.HeroMilitaryRankListItem = require("game/hero/view/item/HeroMilitaryRankListItem")
hero.HeroMilitaryRankSucItem = require("game/hero/view/item/HeroMilitaryRankSucItem")
hero.HeroMilitaryRankScrollItem = require("game/hero/view/item/HeroMilitaryRankScrollItem")
hero.HeroMilitaryRankAddItem = require("game/hero/view/item/HeroMilitaryRankAddItem")
hero.HeroMilitaryRankMaterialTipPanel = require("game/hero/view/HeroMilitaryRankMaterialTipPanel")

-- 升星
hero.HeroStarUpPreviewPanel = require("game/hero/view/HeroStarUpPreviewPanel")
hero.HeroStarUpTabView = require("game/hero/view/tab/HeroStarUpTabView")
hero.HeroStarUpSkillItem = require("game/hero/view/item/HeroStarUpSkillItem")
hero.HeroStarUpListItem = require("game/hero/view/item/HeroStarUpListItem")
hero.HeroStarUpMaterialPanel = require("game/hero/view/HeroStarUpMaterialPanel")
hero.HeroStarUpScrollItem = require("game/hero/view/item/HeroStarUpScrollItem")
hero.HeroStarUpMaterialTipPanel = require("game/hero/view/HeroStarUpMaterialTipPanel")
hero.HeroStarUpTipPanel = require("game/hero/view/HeroStarUpTipPanel")
hero.HeroStarUpItem = require("game/hero/view/item/HeroStarUpItem")
hero.HeroStarUpShowOneView = require("game/hero/view/HeroStarUpShowOneView")
-- 装备
hero.HeroEquipManager = require("game/hero/manager/HeroEquipManager").new()
hero.HeroEquipController = require("game/hero/controller/HeroEquipController").new(hero.HeroEquipManager)
hero.HeroEquipPanel = require("game/hero/view/HeroEquipPanel")
hero.HeroEquipBagScrollerItem = require("game/hero/view/item/HeroEquipBagScrollerItem")
hero.HeroEquipSuitPanel = require("game/hero/view/HeroEquipSuitPanel")
hero.HeroEquipSuitScrollerItem = require("game/hero/view/item/HeroEquipSuitScrollerItem")
hero.HeroEquipItem = require("game/hero/view/item/HeroEquipItem")
hero.HeroEquipAttrItem = require("game/hero/view/item/HeroEquipAttrItem")
hero.HeroEquipAttrListPanel = require("game/hero/view/HeroEquipAttrListPanel")
hero.HeroEquipChangeHeroPanel = require("game/hero/view/HeroEquipChangeHeroPanel")
hero.HeroEquipMaterialPanel = require("game/hero/view/HeroEquipMaterialPanel")
hero.HeroEquipMaterialItem = require("game/hero/view/item/HeroEquipMaterialItem")

--hero.HeroBraceletsMaterialPanel = require("game/hero/view/HeroBraceletsMaterialPanel")

--hero.HeroEquipMaterialMinPanel = require("game/hero/view/HeroEquipMaterialMinPanel")

-- hero.HeroEquipAttrTabView = require("game/hero/view/tab/HeroEquipAttrTabView")
-- hero.HeroEquipReplaceTabView = require("game/hero/view/tab/HeroEquipReplaceTabView")

-- 手环
hero.HeroBraceletsTabView = require("game/hero/view/tab/HeroBraceletsTabView")

hero.HeroBraceletsPanel = require("game/hero/view/HeroBraceletsPanel")
--hero.HeroBraceletsBagPanel = require("game/hero/view/HeroBraceletsBagPanel")
hero.HeroBraceletsBagScrollerItem = require("game/hero/view/item/HeroBraceletsBagScrollerItem")
--手环信息弹窗
hero.HeroBraceletsTipsPanel = require("game/hero/view/HeroBraceletsTipsPanel")

-- 增幅
hero.HeroGrowTabView = require("game/hero/view/tab/HeroGrowTabView")
-- 增幅技能成功
hero.HeroGrowSkillUpSucPanel = require("game/hero/view/success/HeroGrowSkillUpSucPanel")

-- 英雄等级目标
hero.HeroLvlTargetPanel = require("game/hero/view/HeroLvlTargetPanel")
hero.HeroLvlTargetItem = require("game/hero/view/item/HeroLvlTargetItem")
hero.HeroLvlTargetConfigVo = require("game/hero/manager/vo/HeroLvlTargetConfigVo")

-- 英雄获得展示
hero.HeroShowManager = require("game/hero/manager/HeroShowManager").new()
hero.HeroShowController = require("game/hero/controller/HeroShowController").new(hero.HeroShowManager)

-- 英雄Q版管理
hero.HeroCuteConfigVo = require("game/hero/manager/vo/HeroCuteConfigVo")
hero.HeroCuteManager = require("game/hero/manager/HeroCuteManager").new()

-- 发行专用面板
hero.HeroIssueShowPanel = require("game/hero/view/HeroIssueShowPanel")

--controller
local mgrList = {}
table.insert(mgrList, hero.HeroManager)
table.insert(mgrList, hero.HeroLvlUpManager)
table.insert(mgrList, hero.HeroStarManager)
table.insert(mgrList, hero.HeroMilitaryRankManager)
table.insert(mgrList, hero.HeroInteractManager)
table.insert(mgrList, hero.HeroLvlTargetManager)
table.insert(mgrList, hero.HeroCuteManager)
table.insert(mgrList, hero.HeroActionManager)

hero.HeroController = require("game/hero/controller/HeroController").new(mgrList)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 英雄技能升级管理
hero.HeroSkillUpScrollItem = require("game/hero/view/item/HeroSkillUpScrollItem")
hero.HeroSkillUpMaterialPanel = require("game/hero/view/HeroSkillUpMaterialPanel")
hero.HeroSkillUpMaterialTipPanel = require("game/hero/view/HeroSkillUpMaterialTipPanel")
hero.HeroSkillUpSucPanel = require("game/hero/view/success/HeroSkillUpSucPanel")
hero.HeroSkillUpConfigVo = require("game/hero/manager/vo/HeroSkillUpConfigVo")
hero.HeroSkillUpManager = require("game/hero/manager/HeroSkillUpManager").new()
hero.HeroSkillUpController = require("game/hero/controller/HeroSkillUpController").new(hero.HeroSkillUpManager)

-- 英雄助战管理
hero.HeroAssistTabView = require("game/hero/view/tab/HeroAssistTabView")
hero.HeroAssistManager = require("game/hero/manager/HeroAssistManager").new()
hero.HeroAssistController = require("game/hero/controller/HeroAssistController").new(hero.HeroAssistManager)
hero.HeroAssistVo = require("game/hero/manager/vo/HeroAssistVo")
hero.HeroAssistConfigVo = require("game/hero/manager/vo/HeroAssistConfigVo")

-- 英雄使用码管理
hero.HeroUseCodeManager = require("game/hero/manager/HeroUseCodeManager").new()
hero.HeroUseCodeController = require("game/hero/controller/HeroUseCodeController").new(hero.HeroUseCodeManager)

-- 英雄红点标识
hero.HeroFlagManager = require("game/hero/heroFlag/manager/HeroFlagManager").new()
hero.HeroFlagController = require("game/hero/heroFlag/controller/HeroFlagController").new(hero.HeroFlagManager)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

local module = {hero.HeroController, hero.HeroEquipController, hero.HeroUseCodeController, hero.HeroFlagController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
