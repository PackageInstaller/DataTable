-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/controller/BorrowPetController.lua

module("logic.extensions.borrowpet.controller.BorrowPetController", package.seeall)

local BorrowPetController = class("BorrowPetController", BaseController)

function BorrowPetController:ctor()
	return
end

function BorrowPetController:onInit()
	self:onReset()
end

function BorrowPetController:onReset()
	return
end

function BorrowPetController:handlePM_BorrowPetGetActivityInfosRes(msg)
	BorrowPetModel.instance:saveBorrowPetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BorrowPetGetActivityInfosRes)
end

function BorrowPetController:handlePM_BorrowPetBorrowRes(msg)
	BorrowPetModel.instance:saveBorrowPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BorrowPetGetActivityInfosRes)
end

function BorrowPetController:isBorrowActivityOpen()
	local activityIds = {}
	local activityId = BorrowPetModel.instance:getCurrActId()

	if activityId then
		table.insert(activityIds, activityId)
	end

	if RecallTaskModel.instance:isGetActivityOpen(false) == true then
		table.insert(activityIds, 9999)
	end

	return #activityIds > 0, activityIds
end

BorrowPetController.instance = BorrowPetController.New()

return BorrowPetController
