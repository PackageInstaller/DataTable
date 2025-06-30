fightUI = {}


require("game/fightUI/FightPreviewDataConst")

fightUI.FightSkillItemState = require('game/fightUI/FightSkillItemStateDef')
--view
fightUI.FightBuffIcon = require("game/fightUI/view/item/FightBuffIcon")
fightUI.FightBuffEleIcon = require("game/fightUI/view/item/FightBuffEleIcon")
fightUI.FightSkillItem = require('game/fightUI/view/item/FightSkillItem')
fightUI.FightMaxSkillItem = require('game/fightUI/view/item/FightMaxSkillItem')
fightUI.FightSkillView = require('game/fightUI/view/FightSkillView')
fightUI.FightSmallFormatItem = require('game/fightUI/view/item/FightSmallFormatItem')
fightUI.FightSmallFormatView = require('game/fightUI/view/FightSmallFormatView')
fightUI.FightSoulView = require('game/fightUI/view/FightSoulView')
fightUI.FightWaveView = require('game/fightUI/view/FightWaveView')
fightUI.FightStartView = require('game/fightUI/view/FightStartView')
fightUI.FightSettingView = require('game/fightUI/view/FightSettingView')
fightUI.FightHitView = require('game/fightUI/view/FightHitView')
fightUI.FightBlockView = require('game/fightUI/view/FightBlockView')
fightUI.FightBuffInfoView = require('game/fightUI/view/FightBuffInfoView')
fightUI.FightBlockTeachingView = require('game/fightUI/view/FightBlockTeachingView')
fightUI.FightAutoFightView = require('game/fightUI/view/FightAutoFightView')
fightUI.FightBossHeadAreaView = require('game/fightUI/view/FightBossHeadAreaView')
fightUI.FightBossShowSkip = require('game/fightUI/view/FightBossShowSkip')

-- 屏蔽指挥官技能
fightUI.FightForcesSkillItem = require('game/fightUI/view/item/FightForcesSkillItem')
fightUI.FightForcesSkillView = require('game/fightUI/view/FightForcesSkillView')

fightUI.FightQueueItem = require('game/fightUI/view/item/FightQueueItem')
fightUI.FightQueueIcon = require('game/fightUI/view/item/FightQueueIcon')
fightUI.FightQueueView = require('game/fightUI/view/FightQueueView')

fightUI.FightUI = require('game/fightUI/view/FightUI')
fightUI.FightUIPauseView = require('game/fightUI/view/FightUIPauseView')
fightUI.FightSkillTips = require('game/fightUI/view/FightSkillTips')
fightUI.FightBlackMask = require('game/fightUI/view/FightBlackMask')
fightUI.FightSupportInfoTips = require('game/fightUI/view/FightSupportInfoTips')

fightUI.FightForcesSkillTips = require('game/fightUI/view/FightForcesSkillTips')

-- fightUI.FightWinEndView = require('game/fightUI/result/win/FightWinEndView')
-- fightUI.FightFailEndView = require('game/fightUI/result/fail/FightFailEndView')

fightUI.FightResultWinView = require('game/fightUI/result/win/FightResultWinView')
fightUI.FightWinSignView = require('game/fightUI/result/win/FightWinSignView')
fightUI.FightResultFailView = require('game/fightUI/result/fail/FightResultFailView')
fightUI.FightResultShortcut = require('game/fightUI/result/win/FightResultShortcut')

mainActivity.ActiveDupFightResultWinView = require("game/fightUI/result/win/ActiveDupFightResultWinView")


fightUI.ArenaFightWinEndView = require('game/fightUI/result/win/ArenaFightWinEndView')
fightUI.ArenaFightFailEndView = require('game/fightUI/result/fail/ArenaFightFailEndView')
fightUI.FightResultHeroItem = require('game/fightUI/result/item/FightResultHeroItem')

fightUI.FightElementReactionPanel = require('game/fightUI/view/FightElementReactionPanel')

--战斗数据结算面板
fightUI.FightDataPreView = require("game/fightUI/result/preview/FightDataPreView")
--战斗数据结算面板 单元格
fightUI.FightDataPreViewSingleItem = require("game/fightUI/result/preview/FightDataPreViewSingleItem")
--战斗数据结算面板头像
fightUI.FightDataPreviewHeroItem =  require("game/fightUI/result/preview/FightDataPreviewHeroItem")

-- 无限城结算
fightUI.InfiniteCityFightResultWinView = require('game/fightUI/result/win/InfiniteCityFightResultWinView')
-- 默示之境结算
fightUI.DupImpliedFightResultWinView = require('game/fightUI/result/win/DupImpliedFightResultWinView')
-- 迷宫副本结算
fightUI.MazeFightResultWinView = require('game/fightUI/result/win/MazeFightResultWinView')
-- 肉鸽副本结算
fightUI.RogueLikeResultWinView = require('game/fightUI/result/win/RogueLikeResultWinView')
-- 主探索结算
fightUI.MainExploreFightResultWinView = require('game/fightUI/result/win/MainExploreFightResultWinView')

require('game/fightUI/result/FightResultProxy')


fightUI.HUDItem = require("game/fightUI/view/hud/HUDItem")
fightUI.FlyHUDItem = require("game/fightUI/view/hud/FlyHUDItem")
fightUI.FlyHUDImg = require("game/fightUI/view/hud/FlyHUDImg")
fightUI.FlyBuffText = require("game/fightUI/view/hud/FlyBuffText")
fightUI.HeadAreaItem = require("game/fightUI/view/hud/HeadAreaItem")
fight.FightBuffHeroListItem = require("game/fightUI/view/item/FightBuffHeroListItem")


--utilHarmUtil
fightUI.HarmUtil = require("game/fightUI/utils/FightHarmUtil").new()
fightUI.FightFlyUtil = require("game/fightUI/utils/FightFlyUtil").new()
fightUI.FailedTipVo = require("game/fightUI/utils/FailedTipVo")
fightUI.FightFailedUIData = require("game/fightUI/utils/FightFailedUIData").new()

--controller
local _uic = require('game/fightUI/controller/FightUIController').new()
local module = {_uic}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
