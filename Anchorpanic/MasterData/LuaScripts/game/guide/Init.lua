guide = {}

guide.GuideDataRo = require('rodata/GuideDataRo')
guide.GuideFlowDataRo = require('rodata/GuideFlowDataRo')

guide.GuideUITransVo = require("game/guide/vo/GuideUITransVo")

guide.GuideCondition = require("game/guide/manager/GuideCondition").new()
guide.GuideManager = require("game/guide/manager/GuideManager").new()
guide.GuideUITransHandler = require("game/guide/manager/GuideUITransHandler").new()


guide.GuideBasePanel = require("game/guide/view/GuideBasePanel")
guide.GuidePanel = require("game/guide/view/GuidePanel")
guide.GuidePanelTools = require("game/guide/view/GuidePanelTools")



local _sc = require("game/guide/controller/GuideController").new(guide.GuideManager)

local _module = { _sc }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
