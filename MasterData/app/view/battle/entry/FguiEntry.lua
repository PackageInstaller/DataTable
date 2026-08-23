local BattleConst = require("app.view.battle.const.BattleConst")
local FguiEntry = class("FguiEntry", require("app.view.battle.entry.Entry"))

function FguiEntry:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._params = arg_1_1
	self._battleLayer = arg_1_2
	self._eventCallBack = arg_1_3
	self._isDone = false
	self._isInit = false

	FguiEntry.super.ctor(self)
end

function FguiEntry:initEntry()
	FguiEntry.super.initEntry(self)
	self.addEntryToQueue(self, self, self._step)
end

function FguiEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true
	self._isDone = false

	self:showUILayer()
end

function FguiEntry:showUILayer()
	local BattleBossLayer
	local var_4_1 = {}

	if self._params.start then
		if self._params.rebelId then
			self:endEvent()

			return
		else
			self:endEvent()

			return
		end
	elseif self._params.boss then
		BattleBossLayer = require("app.view.battle.fgui.BattleBossLayer")
	elseif self._params.vs then
		BattleBossLayer = require("app.view.battle.fgui.BattleVSLayer")
	elseif self._params.round then
		BattleBossLayer = require("app.view.battle.fgui.BattleRoundLayer")
		var_4_1 = self._params.num
	elseif self._params.witch then
		BattleBossLayer = require("app.view.battle.fgui.BattleSuccubaComparePop")
	elseif self._params.witchResult then
		BattleBossLayer = require("app.view.battle.fgui.BattleSuccubaCompareResultPop")
		var_4_1.result = self._params.result
	else
		self:endEvent()

		return
	end

	if self._params.start and self._params.rebelId then
		self._uiLayer = BattleBossLayer.new(var_4_1)

		self._uiLayer:displayObject():retain()
		g.core.module.ModuleManager:pushPopup(self._uiLayer, {
			touchDisappear = false
		})
	else
		self._uiLayer = BattleBossLayer.new(self._battleLayer, handler(self, self.endEvent), var_4_1)

		self._uiLayer:displayObject():retain()
		g.core.module.ModuleManager:pushPopup(self._uiLayer, {
			touchDisappear = false
		})
	end
end

function FguiEntry:removeUILayer()
	if self._uiLayer then
		self._uiLayer:displayObject():release()
		self._uiLayer:removeFromParent()

		self._uiLayer = nil
	end
end

function FguiEntry:endEvent()
	if self._eventCallBack then
		self._eventCallBack()
	end

	self._isDone = true
end

function FguiEntry:_step()
	self:_init()

	return self._isDone
end

function FguiEntry:destroyEntry()
	self:removeUILayer()
	FguiEntry.super.destroyEntry(self)

	self._isDone = nil
	self._isInit = false
	self._eventCallBack = nil
	self._params = nil
	self._battleLayer = nil
end

return FguiEntry
