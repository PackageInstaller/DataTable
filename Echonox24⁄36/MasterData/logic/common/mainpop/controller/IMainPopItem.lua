-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mainpop/controller/IMainPopItem.lua

module("logic.common.mainpop.controller.IMainPopItem", package.seeall)

local IMainPopItem = class("IMainPopItem")

function IMainPopItem:getMainPopType()
	if enableErrorLog then
		printError("unimplment method")
	end
end

function IMainPopItem:onTriggerMainPop()
	if enableErrorLog then
		printError("unimplment method")
	end
end

function IMainPopItem:finishMainPop()
	MainPopController.instance:showNext()
end

function IMainPopItem:increaseToNextMainPop()
	MainPopController.instance:increaseToNext()
end

function IMainPopItem:hasPopUpData()
	return false
end

return IMainPopItem
