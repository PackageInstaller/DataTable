-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/data/AoqiGodMgr.lua

module("logic.extensions.aoqigod.data.AoqiGodMgr", package.seeall)

local AoqiGodMgr = class("AoqiGodMgr")

function AoqiGodMgr:ctor(activityId)
	self._activityId = activityId
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._itemList = {}
	self._itemTempList = {}
	self._itemStateDic = {}
end

function AoqiGodMgr:onEnter()
	self._curTimeMillis = ServerTime.nowMs()

	table.clear(self._itemList)
	table.insert(self._itemList, self._aoqiGodMo:getCaller())
	table.insert(self._itemList, self._aoqiGodMo:getHelper())

	for _, v in ipairs(self._itemList) do
		self._itemStateDic[v] = self:_getItemState(v)
	end

	settimer(1, self._onTicking, self)
	self:_onTicking()
end

function AoqiGodMgr:onExit()
	self:_clear()
end

function AoqiGodMgr:onDestroy()
	self:_clear()
end

function AoqiGodMgr:_clear()
	removetimer(self._onTicking, self)
	table.clear(self._itemList)
	table.clear(self._itemTempList)
end

function AoqiGodMgr:_onTicking()
	self._curTimeMillis = ServerTime.nowMs()

	local isNeedNotifyChange = false

	table.insertto(self._itemTempList, self._itemList)

	for _, v in ipairs(self._itemTempList) do
		local state = self:_getItemState(v)

		if state ~= self._itemStateDic[v] then
			self._itemStateDic[v] = state
			isNeedNotifyChange = true
		end
	end

	table.clear(self._itemTempList)

	if isNeedNotifyChange then
		GlobalDispatcher:dispatch(GlobalNotify.AoqiGodItemHelpChange)
	end
end

function AoqiGodMgr:_getItemState(item)
	if self._curTimeMillis < item:getStartTimeMillis() then
		return GameUtil.beforeTimePeriod
	elseif self._curTimeMillis <= item:getEndTimeMillis() then
		return GameUtil.inTimePeriod
	else
		return GameUtil.afterTimePeriod
	end
end

return AoqiGodMgr
