-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/model/MoneyEventType.lua

module("logic.extensions.money.model.MoneyEventType", package.seeall)

local MoneyEventType = {}

MoneyEventType.MONEY_VIEW_OPEN = UIDUtil.getEventUID()
MoneyEventType.MONEY_ITEM_HINT_CHANGE = UIDUtil.getEventUID()
MoneyEventType.ENERGY_RECOVER_TIME_SERVER_CHANGE = UIDUtil.getEventUID()

return MoneyEventType
