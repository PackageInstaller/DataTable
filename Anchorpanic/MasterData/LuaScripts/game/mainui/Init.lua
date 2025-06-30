mainui = {}

mainui.MainUI = require('game/mainui/view/MainUI')
mainui.MainUIActivityView = require('game/mainui/view/MainUIActivityView')
mainui.MainUIActivityInfoItem = require('game/mainui/view/item/MainUIActivityInfoItem')
mainui.MainUIActivitySelectItem = require('game/mainui/view/item/MainUIActivitySelectItem')

mainui.MainUIPermitView = require('game/mainui/view/MainUIPermitView')

mainui.MainUIConst = require('game/mainui/manager/MainUIConst')

mainui.MainUIManager = require('game/mainui/manager/MainUIManager').new()

local _c = require('game/mainui/controller/MainUIController').new(mainui.MainUIManager)

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
