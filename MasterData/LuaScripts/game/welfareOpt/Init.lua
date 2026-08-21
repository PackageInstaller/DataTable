--福利

welfareOpt = {}


welfareOpt.WelfareOptConst = require("game/welfareOpt/manager/WelfareOptConst")

--节日福利数据
welfareOpt.WelfareOptFestivalVo = require("game/welfareOpt/manager/vo/WelfareOptFestivalVo")
--战斗补给配置
welfareOpt.WelfareOptFightSupplyVo = require("game/welfareOpt/manager/vo/WelfareOptFightSupplyVo")
welfareOpt.WelfareOptFightSupplyProVo = require("game/welfareOpt/manager/vo/WelfareOptFightSupplyProVo")

--服务端下发的数据
welfareOpt.WelfareOptGoldWishingServerVo = require("game/welfareOpt/manager/vo/WelfareOptGoldWishingServerVo")

--金币祈愿配置
welfareOpt.WelfareOptGoldWishingVo = require("game/welfareOpt/manager/vo/WelfareOptGoldWishingVo")

--7天登录配置
welfareOpt.WelfareOptSevenLoadingVo = require("game/welfareOpt/manager/vo/WelfareOptSevenLoadingVo")

--新手训练营配置
welfareOpt.WelfareOptNoviceAwardVo = require("game/welfareOpt/manager/vo/WelfareOptNoviceAwardVo")
welfareOpt.WelfareOptNoviceVo = require("game/welfareOpt/manager/vo/WelfareOptNoviceVo")
welfareOpt.WelfareOptNoviceMissionVo = require("game/welfareOpt/manager/vo/WelfareOptNoviceMissionVo")

--福利页面
welfareOpt.WelfareOptPanel = "game/welfareOpt/view/WelfareOptPanel"

--战斗补给
welfareOpt.WelfareOptFightSupplyView = "game/welfareOpt/view/tab/WelfareOptFightSupplyView"
--战斗补给弹窗
welfareOpt.WelfareOptFightSupplyProView = "game/welfareOpt/view/pop/WelfareOptFightSupplyProView"

welfareOpt.WelfareOptFightSupplyItem = require("game/welfareOpt/view/item/WelfareOptFightSupplyItem")

welfareOpt.WelfareProPropsItem = require("game/welfareOpt/view/item/WelfareProPropsItem")
--新手目标
welfareOpt.WelfareOptNoviceGoalView = "game/welfareOpt/view/tab/WelfareOptNoviceGoalView"
welfareOpt.WelfareOptMissionItem = require("game/welfareOpt/view/item/WelfareOptMissionItem")

--七天训练目标
welfareOpt.WelfareOptSevenDayTargetView = "game/welfareOpt/view/tab/WelfareOptSevenDayTargetView"
welfareOpt.WelfareOptSevenDayItem = require("game/welfareOpt/view/item/WelfareOptSevenDayItem")

--TapTap联动
--welfareOpt.welfareOptTapTapItem = require("game/welfareOpt/view/item/welfareOptTapTapItem")
--金币许愿
welfareOpt.WelfareOptGoldWishingView = "game/welfareOpt/view/tab/WelfareOptGoldWishingView"

--七日签到
welfareOpt.WelfareOptSevenLoadingView = "game/welfareOpt/view/tab/WelfareOptSevenLoadingView"

--公测福利
welfareOpt.WelfareOptOpenBetaView = "game/welfareOpt/view/tab/WelfareOptOpenBetaView"
--公测福利
welfareOpt.WelfareOptOpenBetaItem = require("game/welfareOpt/view/item/WelfareOptOpenBetaItem")
--签到
welfareOpt.WelfareOptSignView = "game/welfareOpt/view/tab/WelfareOptSignView"

--节日签到
welfareOpt.WelfareOptFestivalView = "game/welfareOpt/view/tab/WelfareOptFestivalView"

welfareOpt.WelfareOptTapTapView = "game/welfareOpt/view/tab/WelfareOptTapTapView"

--体力补给解析
welfareOpt.WelfareOptStrengthSupplyVo = require("game/welfareOpt/manager/vo/WelfareOptStrengthSupplyVo")
welfareOpt.WelfareOptManager = require("game/welfareOpt/manager/WelfareOptManager").new()
--【福利】 公测活动 管理器
welfareOpt.WelfareOptOpenBetaManager = require("game/welfareOpt/manager/WelfareOptOpenBetaManager").new()

--TapTap联动
welfareOpt.WelfareOptTapTapTaskVo = require("game/welfareOpt/manager/vo/WelfareOptTapTapTaskVo")
welfareOpt.welfareOptTapTapItem = require("game/welfareOpt/view/item/welfareOptTapTapItem")
welfareOpt.WelfareOptTapTapView = "game/welfareOpt/view/tab/WelfareOptTapTapView"

local _sc = require("game/welfareOpt/controller/WelfareOptController").new(
{ welfareOpt.WelfareOptManager,
welfareOpt.WelfareOptOpenBetaManager
}
)
local _module = { _sc }

return _module

--[[ 替换语言包自动生成，请勿修改！
]]