activity = {}

activity.ActivityPanel = require("game/activity/view/ActivityPanel")

activity.ActivityPromoView1 = "game/activity/view/ActivityPromoView1"
activity.ActivityPromoView2 = "game/activity/view/ActivityPromoView2"
activity.ActivityPromoView3 = "game/activity/view/ActivityPromoView3"
activity.ActivitySubscribeGift = "game/activity/view/ActivitySubscribeGift"
activity.ActivityVo = require("game/activity/manager/vo/ActivityVo")
activity.ActivityConst = require("game/activity/manager/ActivityConst")
activity.BillboardConfigVo = require("game/activity/manager/vo/BillboardConfigVo")
activity.ActivitySubscribeVo = require("game/activity/manager/vo/ActivitySubscribeVo")
activity.ActivitySubscribeWeChat = "game/activity/view/ActivitySubscribeWeChat"
activity.ActivityManager = require("game/activity/manager/ActivityManager").new()

activity.ActitvityExtraManager = require("game/activity/manager/ActitvityExtraManager").new()
local _c = require('game/activity/controller/ActivityController').new(
    {
        ActivityManager = activity.ActivityManager,
        ActitvityExtraManager = activity.ActitvityExtraManager
    })

    local module = {_c}
    return module

    --[[ 替换语言包自动生成，请勿修改！
]]
    --[[ 替换语言包自动生成，请勿修改！
]]

   