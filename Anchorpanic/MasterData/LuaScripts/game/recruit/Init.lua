-- 招募
recruit = {}

--vo
-- recruit.RecruitConfigVo = require("game/recruit/manager/vo/RecruitConfigVo")

--manager
require("game/recruit/manager/RecruitConst")
recruit.RecruitManager = require("game/recruit/manager/RecruitManager").new()
recruit.ItemRecruitDataRo = require("rodata/ItemRecruitDataRo")
recruit.HeroRecruitRuleConfigVo = require("rodata/HeroRecruitRuleConfigVo")
recruit.RecruitLogVo = require("game/recruit/manager/vo/RecruitLogVo")
recruit.RecruitMenuVo = require("game/recruit/manager/vo/RecruitMenuVo")
recruit.RecruitInfoVo = require("game/recruit/manager/vo/RecruitInfoVo")
recruit.RecruitReslutVo = require("game/recruit/manager/vo/RecruitReslutVo")
recruit.DismissVo = require("game/recruit/manager/vo/DismissVo")
recruit.RecruitTween = require("game.recruit.manager.RecruitTween").new()
recruit.RecruitLive = require("game.recruit.manager.RecruitLive")

recruit.CustomFoldBar = require("game/recruit/view/CustomFoldBar")
--view
recruit.RecruitPanel = require("game/recruit/view/RecruitPanel")
recruit.RecruitTopTabView = require("game/recruit/view/tab/RecruitTopTabView")
recruit.RecruitNewPlayerTabView = require("game/recruit/view/tab/RecruitNewPlayerTabView")
recruit.RecruitBraceletsTabView = require("game/recruit/view/tab/RecruitBraceletsTabView")
recruit.RecruitActTopTabView = require("game/recruit/view/tab/RecruitActTopTabView")
recruit.RecruitActBraceletsTabView = require("game/recruit/view/tab/RecruitActBraceletsTabView")
recruit.RecruitActPlayerTabView = require("game/recruit/view/tab/RecruitActPlayerTabView")
recruit.RecruitAppTopTabView = require("game/recruit/view/tab/RecruitAppTopTabView")
recruit.RecruitAppBraceletsTabView = require("game/recruit/view/tab/RecruitAppBraceletsTabView")

recruit.RecruitMaskView = require("game/recruit/view/RecruitMaskView")

recruit.RecruitLogPanel = require("game/recruit/view/RecruitLogPanel")
recruit.RecruitLogItem = require("game/recruit/view/item/RecruitLogItem")

recruit.RecruitHeroHeadItem = require("game/recruit/view/item/RecruitHeroHeadItem")
recruit.RecruitRulePanel = require("game/recruit/view/RecruitRulePanel")
recruit.RecruitNewPlayResulitPanel = require("game/recruit/view/RecruitNewPlayResulitPanel")
recruit.RecruitRuleItem = require("game/recruit/view/item/RecruitRuleItem")
recruit.RecruitDialPanel = require("game/recruit/view/RecruitDialPanel")
recruit.RecruitSelectHeroPanel = require("game/recruit/view/RecruitSelectHeroPanel")

recruit.RecruitSucPanel = require("game/recruit/view/RecruitSucPanel")
recruit.RecruitSucItem = require("game/recruit/view/item/RecruitSucItem")
recruit.RecruitAppSelectHeroItem = require("game/recruit/view/item/RecruitAppSelectHeroItem")

recruit.RecruitShowAllItem = require("game/recruit/view/item/RecruitShowAllItem")
recruit.RecruitCardShowAllItem = require("game/recruit/view/item/RecruitCardShowAllItem")
recruit.RecruitShowAllView = require("game/recruit/view/RecruitShowAllView")
recruit.RecruitCardShowAllView = require("game/recruit/view/RecruitCardShowAllView")
recruit.RecruitShowOneView = require("game/recruit/view/RecruitShowOneView")
recruit.RecruitCardShowOneView = require("game/recruit/view/RecruitCardShowOneView")

recruit.RecruitSkipView = require("game/recruit/view/RecruitSkipView")

recruit.RecruitTmpPanel = require("game/recruit/view/RecruitTmpPanel")

recruit.HeroFirstShowView = require("game/recruit/view/HeroFirstShowView")

-- recruit.RecruitSceneController = require("game/recruit/controller/RecruitSceneController").new()
recruit.RecruitHeroSceneController = require("game/recruit/controller/RecruitHeroSceneController").new()
recruit.RecruitCardSceneController = require("game/recruit/controller/RecruitCardSceneController").new()

recruit.RecruitTrialManager = require('game/recruit/manager/RecruitTrialManager').new()



--战员遣散
-- recruit.HeroDismissPanel = require("game/recruit/view/HeroDismissPanel")
-- recruit.DismissHeroCardMini = require("game/recruit/view/item/DismissHeroCardMini")

recruit.RecruitController = require("game/recruit/controller/RecruitController").new(recruit.RecruitManager)
local module = {recruit.RecruitController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
