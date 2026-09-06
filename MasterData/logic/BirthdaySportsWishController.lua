-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/controller/BirthdaySportsWishController.lua

module("logic.extensions.birthdaysportswish.controller.BirthdaySportsWishController", package.seeall)

local BirthdaySportsWishController = class("BirthdaySportsWishController", BaseController)

function BirthdaySportsWishController:onReset()
	return
end

function BirthdaySportsWishController:getInfo(activityId)
	BirthdaySportsWishesAgent.instance:sendPM_BirthdaySportsWishesGetInfoReq(activityId)
end

function BirthdaySportsWishController:handleGetInfo(msg)
	BirthdaySportsWishModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BirthdaySportsWishInfoUpdate)
end

function BirthdaySportsWishController:hidePet(activityId)
	BirthdaySportsWishesAgent.instance:sendPM_BirthdaySportsWishesHirePetReq(activityId)
end

function BirthdaySportsWishController:handleHidePet(msg)
	BirthdaySportsWishModel.instance:onHidePet(msg)

	local hirePet = true

	GlobalDispatcher:dispatch(GlobalNotify.BirthdaySportsWishInfoUpdate, hirePet)
end

BirthdaySportsWishController.instance = BirthdaySportsWishController.New()

return BirthdaySportsWishController
