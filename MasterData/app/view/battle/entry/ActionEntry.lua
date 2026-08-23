local ActionEntry = class("ActionEntry", require("app.view.battle.entry.Entry"))
local Entry = require("app.view.battle.entry.Entry")
local MoveEntry = require("app.view.battle.entry.MoveEntry")

function ActionEntry:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9, arg_1_10, arg_1_11, arg_1_12)
	self._actor = arg_1_1
	self._actionName = arg_1_2
	self._eventCallBack = arg_1_3
	self._params = arg_1_4
	self._extParams = arg_1_5
	self._battleLayer = arg_1_6
	self._playInfo = arg_1_7
	self._movePos = arg_1_8
	self._parentEntry = arg_1_9
	self._backData = arg_1_10
	self._skillData = arg_1_11
	self._isPet = arg_1_12
	self._isDone = false
	self._isInit = false
	self._movetoFrames = 0
	self._movebackFrames = 0
	self._curFrame = 0

	ActionEntry.super.ctor(self)
end

function ActionEntry:initEntry()
	ActionEntry.super.initEntry(self)
	self.addEntryToQueue(self, self, self._step)
end

function ActionEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true
	self._isDone = false

	if self._movePos then
		self._actor:setPosition(self._movePos.x, self._movePos.y)
		self._actor:follow()
	end

	self:playEffectGroup((self._actor:playAction(self._actionName, handler(self, self._onEvent))))

	local var_3_0 = self._actor:getIdentity() == 2

	if self._eventCallBack ~= nil then
		self._eventCallBack("action_start", self._actor, self._params)
	end
end

function ActionEntry:playEffectGroup(arg_4_1)
	if string.find(self._actionName, "hit") then
		if string.find(self._actionName, "group") then
			local var_4_0 = require("app.view.battle.entry.EffectGroupEntry").new(self._actionName, self._actor, self._battleLayer, handler(self, self._onEvent), self._params)

			self:addEntryToNewQueue(var_4_0, var_4_0.updateEntry)

			local var_4_1 = require("app.view.battle.entry.Entry").new()
			local var_4_2 = require("app.view.battle.entry.HitEffectEntry").new(self._actionName, self._actor, self._battleLayer, self._params)

			self._actor:addChild((var_4_2:getNodeRoot()))
			var_4_1:addEntryToQueue(var_4_2, var_4_2.updateEntry)
			self._battleLayer:addNewEntry(var_4_1)
		else
			local var_4_3 = {
				resId = self._actionName
			}

			var_4_3.isLoop = false
			var_4_3.isReverse = true

			self._actor:getBones():addAnimImmediately(var_4_3, "hit_slot")
		end
	elseif (string.find(self._actionName, "skill") or string.find(self._actionName, "attack")) and string.find(self._actionName, "group") then
		local var_4_4 = Entry.new()
		local var_4_5 = require("app.view.battle.entry.AtkEffectGroupEntry").new(self._actionName, self._actor, self._battleLayer, handler(self, self._onEvent), self._parentEntry, self._backData, self._isPet)

		self._battleLayer:setAtkEffectGroupEntry(var_4_5, var_4_4)
		var_4_4:addEntryToNewQueue(var_4_5, var_4_5.updateEntry)
		self:addEntryToNewQueue(var_4_4, var_4_4.updateEntry)

		local var_4_6 = require("app.view.battle.entry.Entry").new()
		local var_4_7 = require("app.view.battle.entry.AtkEffectEntry").new(self._actionName, self._actor, self._battleLayer, self._skillData)

		self._actor:addChild((var_4_7:getNodeRoot()))
		var_4_6:addEntryToQueue(var_4_7, var_4_7.updateEntry)
		self._battleLayer:addNewEntry(var_4_6)

		self._isAtkEffectGroupEntry = true
	end
end

function ActionEntry:bindSound(arg_5_1)
	return
end

function ActionEntry:_onEvent(arg_6_1, arg_6_2)
	if not self._actor then
		return
	end

	if self._eventCallBack ~= nil then
		self._eventCallBack(arg_6_1, self._actor, self._params, arg_6_2)
	end

	if arg_6_1 == "finish" or arg_6_1 == "forever" then
		if not self._isAtkEffectGroupEntry and not self._actor:isGoingDead() then
			self._actor:playDefaultAction()
		end

		self._isDone = true
	elseif arg_6_1 == "action_force_finish" then
		self._isDone = true
	elseif arg_6_1 == "moveto_start" then
		local var_6_0

		if self._extParams == nil then
			do return end

			var_6_0 = {
				endPos = self._extParams.toPos
			}
		end

		var_6_0.frames = self._actor:getEventFrames("moveto_start", "moveto_end")

		local var_6_1 = MoveEntry.new(self._actor, var_6_0, 2)

		self:addEntryToNewQueue(var_6_1, var_6_1.updateEntry)
	elseif arg_6_1 == "moveback_start" then
		local var_6_2

		if self._extParams == nil then
			do return end

			var_6_2 = {
				endPos = self._extParams.backPos
			}
		end

		var_6_2.frames = self._actor:getEventFrames("moveback_start", "moveback_end")

		local var_6_3 = MoveEntry.new(self._actor, var_6_2, 2)

		self:addEntryToNewQueue(var_6_3, var_6_3.updateEntry)
	end
end

function ActionEntry:_step()
	self:_init()

	self._curFrame = self._curFrame + 1

	return self._isDone
end

function ActionEntry:destroyEntry()
	ActionEntry.super.destroyEntry(self)

	self._isDone = nil
	self._isInit = false
	self._actor = nil
	self._actionName = nil
	self._eventCallBack = nil
	self._params = nil
	self._extParams = nil
	self._playInfo = nil
end

return ActionEntry
