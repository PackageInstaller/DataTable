bag = {}
-- const
require('game/bag/manager/BagConst')

bag.BagPanel = require('game/bag/view/BagPanel')
bag.BagBaseTabView = require('game/bag/view/tab/BagBaseTabView')
bag.BagNormalTabView = require('game/bag/view/tab/BagNormalTabView')
bag.BagEquipTabView = require('game/bag/view/tab/BagEquipTabView')
bag.BagBraceletsTabView = require('game/bag/view/tab/BagBraceletsTabView')
bag.BagNuclearTabView = require('game/bag/view/tab/BagNuclearTabView')
bag.BagConsumeTabView = require('game/bag/view/tab/BagConsumeTabView')
bag.BagOrderTabView = require('game/bag/view/tab/BagOrderTabView')
bag.BagFragmentTabView = require('game/bag/view/tab/BagFragmentTabView')
bag.BagRawMatTabView = require('game/bag/view/tab/BagRawMatTabView')
bag.BagEggTabView = require('game/bag/view/tab/BagEggTabView')

bag.BagScrollerItem = require('game/bag/view/item/BagScrollerItem')
bag.BagEquipPreviewScrollerItem = require('game/bag/view/item/BagEquipPreviewScrollerItem')
bag.BagEquipScrollerItem = require('game/bag/view/item/BagEquipScrollerItem')
bag.BreakEquipScrollerItem = require('game/bag/view/item/BreakEquipScrollerItem')
bag.BreakHeroEggScrollerItem = require('game/bag/view/item/BreakHeroEggScrollerItem')
bag.BagConsumeScrollerItem = require('game/bag/view/item/BagConsumeScrollerItem')


bag.BagEquipSuitScrollerItem = require('game/bag/view/item/BagEquipSuitScrollerItem')
bag.BagOrderScrollerItem = require('game/bag/view/item/BagOrderScrollerItem')

bag.BagNewSortView = require('game/bag/view/BagNewSortView')
bag.BagBreakConfigVo = require 'game/bag/manager/vo/BagBreakConfigVo'

bag.BagBreakEquipView = 'game/bag/view/BagBreakEquipView'
bag.BagBreakOrderView = 'game/bag/view/BagBreakOrderView'
bag.BagBreakBraceletsView = 'game/bag/view/BagBreakBraceletsView'
bag.BagBreakHeroEggView = 'game/bag/view/BagBreakHeroEggView'

bag.EquipFilterRulePanel = 'game/bag/view/EquipFilterRulePanel'
bag.EquipFilterRuleSubPanel = 'game/bag/view/EquipFilterRuleSubPanel'


bag.HeroEggRuleItem = require('game/bag/view/item/HeroEggRuleItem')
bag.UseHeroEggRulePanel = 'game/bag/view/UseHeroEggRulePanel'
--manager
bag.BagManager = require("game/bag/manager/BagManager").new()

local _c = require('game/bag/controller/BagController').new(bag.BagManager)
local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
