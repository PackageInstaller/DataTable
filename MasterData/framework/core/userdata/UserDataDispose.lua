-- chunkname: @framework/core/userdata/UserDataDispose.lua

module("framework.core.userdata.UserDataDispose", package.seeall)

local UserDataDispose = class("UserDataDispose")

function UserDataDispose:__onInit()
	local metaTable = getmetatable(self)

	function metaTable.__newindex(selfObj, key, value)
		rawset(selfObj, key, value)

		if type(value) == "userdata" then
			if not rawget(selfObj, "__userDataKeys") then
				rawset(selfObj, "__userDataKeys", {})
			end

			selfObj.__userDataKeys[key] = true
		end
	end

	self.__userDataTbs = {}
	self.__eventTbs = {}
	self.__clickObjs = {}
end

function UserDataDispose:__onDispose()
	if self.__userDataKeys then
		local userDataKeys = self.__userDataKeys

		for key, _ in pairs(userDataKeys) do
			rawset(self, key, nil)
		end

		self.__userDataKeys = nil
	end

	if self.__userDataTbs then
		for idx, tb in ipairs(self.__userDataTbs) do
			for key in pairs(tb) do
				rawset(tb, key, nil)
			end

			rawset(self.__userDataTbs, idx, nil)
		end

		self.__userDataTbs = nil
	end

	if self.__eventTbs then
		for _, evtInfo in ipairs(self.__eventTbs) do
			evtInfo[1]:unregisterCallback(evtInfo[2], evtInfo[3], evtInfo[4])
		end

		self.__eventTbs = nil
	end

	if self.__clickObjs then
		for clickObj, _ in pairs(self.__clickObjs) do
			if not clickObj:Equals(nil) then
				clickObj:RemoveClickListener()
			end
		end

		self.__clickObjs = nil
	end
end

function UserDataDispose:getUserDataTb_()
	local ret = {}

	if self.__userDataTbs then
		table.insert(self.__userDataTbs, ret)
	end

	return ret
end

function UserDataDispose:addEventCb(ctrlInstance, evtName, callback, cbObj, priority)
	if not ctrlInstance or not evtName or not callback then
		logError("UserDataDispose:addEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	ctrlInstance:registerCallback(evtName, callback, cbObj, priority)

	if self.__eventTbs then
		for _, evtInfo in ipairs(self.__eventTbs) do
			if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
				return
			end
		end
	end

	table.insert(self.__eventTbs, {
		ctrlInstance,
		evtName,
		callback,
		cbObj
	})
end

function UserDataDispose:removeEventCb(ctrlInstance, evtName, callback, cbObj)
	if not ctrlInstance or not evtName or not callback then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	if self.__eventTbs then
		for i, evtInfo in ipairs(self.__eventTbs) do
			if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
				table.remove(self.__eventTbs, i)

				break
			end
		end
	end

	ctrlInstance:unregisterCallback(evtName, callback, cbObj)
end

function UserDataDispose:addClickCb(clickObj, callback, cbObj, param)
	if not clickObj or clickObj:Equals(nil) or not callback or not cbObj then
		logError("UserDataDispose:addClickCb clickObj or callback or cbObj is null!")

		return
	end

	if self.__clickObjs and not self.__clickObjs[clickObj] then
		self.__clickObjs[clickObj] = true

		clickObj:AddClickListener(callback, cbObj, param)
	end
end

function UserDataDispose:removeClickCb(clickObj)
	if not clickObj or clickObj:Equals(nil) then
		logError("UserDataDispose:removeClickCb clickObj is null!")

		return
	end

	if self.__clickObjs and self.__clickObjs[clickObj] then
		self.__clickObjs[clickObj] = nil

		clickObj:RemoveClickListener()
	end
end

return UserDataDispose
