-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/model/BirthdaySportsWishModel.lua

module("logic.extensions.birthdaysportswish.model.BirthdaySportsWishModel", package.seeall)

local BirthdaySportsWishModel = class("BirthdaySportsWishModel", BaseModel)

function BirthdaySportsWishModel:onInit()
	self:onReset()
end

function BirthdaySportsWishModel:onReset()
	self._lastOpenTabId = nil
	self._curActId = 0
	self._gainedTimes = 0
end

function BirthdaySportsWishModel:onGetInfo(msg)
	self._curActId = checkint(msg.activityId)
	self._curCoolingTime = checkint(msg.coolingTime)
	self._gainedTimes = checkint(msg.GainedTimes)
end

function BirthdaySportsWishModel:onHidePet(msg)
	self._gainedTimes = self._gainedTimes + 1
	self._curCoolingTime = checkint(msg.coolingTime)
end

function BirthdaySportsWishModel:getCurActId()
	return self._curActId
end

function BirthdaySportsWishModel:getCurCoolingTime()
	return self._curCoolingTime
end

function BirthdaySportsWishModel:getGainedTimes()
	return self._gainedTimes
end

function BirthdaySportsWishModel:setLastOpenTabId(lastOpenTabId)
	self._lastOpenTabId = lastOpenTabId
end

function BirthdaySportsWishModel:getLastOpenTabId()
	return self._lastOpenTabId
end

BirthdaySportsWishModel.instance = BirthdaySportsWishModel.New()

return BirthdaySportsWishModel
