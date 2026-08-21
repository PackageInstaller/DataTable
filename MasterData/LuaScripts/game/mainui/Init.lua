mainui = {}

mainui.MainUI = require('game/mainui/view/MainUI')
mainui.RecoveryPanel = require('game/mainui/view/RecoveryPanel')

mainui.MainUIActivityView = require('game/mainui/view/MainUIActivityView')
mainui.MainUIActivityInfoItem = require('game/mainui/view/item/MainUIActivityInfoItem')
mainui.MainUIActivitySelectItem = require('game/mainui/view/item/MainUIActivitySelectItem')

mainui.MainUIPermitView = require('game/mainui/view/MainUIPermitView')
mainui.MainUIWallpaper = require('game/mainui/view/MainUIWallpaper')

mainui.MainUIConst = require('game/mainui/manager/MainUIConst')

mainui.MainUIManager = require('game/mainui/manager/MainUIManager').new()

mainui.MainUIController = require('game/mainui/controller/MainUIController').new(mainui.MainUIManager)

local module = { mainui.MainUIController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
