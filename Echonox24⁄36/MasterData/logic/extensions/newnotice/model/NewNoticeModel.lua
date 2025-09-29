-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/model/NewNoticeModel.lua

module("logic.extensions.newnotice.model.NewNoticeModel", package.seeall)

local NewNoticeModel = class("NewNoticeModel", BaseModel)

function NewNoticeModel:ctor()
	NewNoticeModel.super.ctor(self)
	self:onReset()
end

function NewNoticeModel:onInit()
	self:onReset()
end

function NewNoticeModel:onReset()
	self._activityNoticeList = {}
	self._gameNoticeList = {}
	self._isRequestNoticeList = false
end

function NewNoticeModel:isRequestNoticeList()
	return self._isRequestNoticeList
end

function NewNoticeModel:setRequestNoticeList(v)
	self._isRequestNoticeList = v

	return self
end

function NewNoticeModel:clearNoticeList()
	self._activityNoticeList = {}
	self._gameNoticeList = {}
end

function NewNoticeModel:setIgnoreAlert(ignoreAlert)
	self._isIgnoreAlert = ignoreAlert
end

function NewNoticeModel:getIgnoreAlert()
	return self._isIgnoreAlert
end

function NewNoticeModel:addNotice(noticeMO)
	if tonumber(noticeMO.moduleCode) == NewNoticeEnum.Type.ActivityNotice then
		table.insert(self._activityNoticeList, noticeMO)
	elseif tonumber(noticeMO.moduleCode) == NewNoticeEnum.Type.GameNotice then
		table.insert(self._gameNoticeList, noticeMO)
	else
		printError(string.format("unknown notice type[%s]", noticeMO.moduleCode))
	end
end

function NewNoticeModel:getActivityNoticeList()
	return self._activityNoticeList
end

function NewNoticeModel:getGameNoticeList()
	return self._gameNoticeList
end

function NewNoticeModel:getActivityNoticeCount()
	return #self._activityNoticeList
end

function NewNoticeModel:getGameNoticeCount()
	return #self._gameNoticeList
end

function NewNoticeModel:hasNotice()
	return self:getActivityNoticeCount() ~= 0 or self:getGameNoticeCount() ~= 0
end

function NewNoticeModel:sort()
	table.sort(self._activityNoticeList, self._sortFunc)
	table.sort(self._gameNoticeList, self._sortFunc)
end

function NewNoticeModel._sortFunc(a, b)
	if a.order < b.order then
		return true
	end

	return false
end

function NewNoticeModel:getNoticeById(id)
	for i, notice in ipairs(self._activityNoticeList) do
		if notice.id == id then
			return notice
		end
	end

	for i, notice in ipairs(self._gameNoticeList) do
		if notice.id == id then
			return notice
		end
	end

	return false
end

NewNoticeModel.instance = NewNoticeModel.New()

return NewNoticeModel
