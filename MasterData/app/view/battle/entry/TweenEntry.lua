local TweenEntry = class("TweenEntry", require("app.view.battle.entry.Entry"))

function TweenEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._startPos = arg_1_1.startPos or cc.p(display.cx, display.cy)
	self._callback = arg_1_1.callback
	self._tweenName = arg_1_1.tweenName
	self._initScale = arg_1_1.initScale or cc.p(1, 1)
	self._eventHandler = arg_1_1.eventHandler
	self._container = arg_1_1.container
	self._zOrder = arg_1_1.zOrder or 0
	self._isInit = false
	self._flaAni = nil
	self._data = arg_1_1

	TweenEntry.super.ctor(self)
end

function TweenEntry:initEntry()
	TweenEntry.super.initEntry(self)

	local var_2_0 = require("app.view.battle.entry.TweenSpineEntry").new(self._data)

	self:addEntryToQueue(var_2_0, var_2_0.updateEntry)
end

function TweenEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true
end

function TweenEntry:_step()
	self:_init()

	return true
end

function TweenEntry:destroyEntry()
	TweenEntry.super.destroyEntry(self)

	if self._flaAni ~= nil then
		self._flaAni:removeFromParent(true)

		self._flaAni = nil
	end

	self._battleLayer = nil
	self._startPos = nil
	self._callback = nil
	self._tweenName = nil
end

return TweenEntry
