local Entry = require("app.view.battle.entry.Entry")
local PassiveLeaderEntry = class("PassiveLeaderEntry", Entry)

function PassiveLeaderEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._skillInfo = arg_1_1.skillInfo
	self._identity = arg_1_1.identity or 1
	self._quality = arg_1_1.quality
	self._knightInfo = arg_1_1.knightInfo
	self._playInfo = arg_1_1.playInfo
	self._actor = arg_1_1.actor

	PassiveLeaderEntry.super.ctor(self)
end

function PassiveLeaderEntry:initEntry()
	self.super.initEntry(self)

	local var_2_0 = Entry.new()

	var_2_0:addEntryToNewQueue(nil, handler(self, self._showUI))
	self:addEntryToQueue(var_2_0, var_2_0.updateEntry)
end

function PassiveLeaderEntry:_showUI()
	if g.core.battle.BattleProxy:getBattleLayer():isCurPaused() then
		return false
	end

	local var_3_0 = fgui.UIPackage:createObject("battle", "BattlePassiveLeaderCurtainComp")

	if self._identity ~= 1 then
		var_3_0:setScaleX(-1)
		var_3_0:setPosition(cc.p(display.width + 0, 0))
	else
		var_3_0:setPosition(cc.p(-0, 0))
	end

	var_3_0:updateView({
		identity = self._identity,
		skillInfo = self._skillInfo,
		quality = self._quality,
		knightInfo = self._knightInfo,
		playInfo = self._playInfo,
		actor = self._actor,
		callback = function()
			self._isDone = true
		end
	})
	self._battleLayer:addNodeToUILayer(var_3_0, 1)

	return true
end

function PassiveLeaderEntry:isDone()
	return self._isDone
end

function PassiveLeaderEntry:destroyEntry()
	PassiveLeaderEntry.super.destroyEntry(self)

	self._battleLayer = nil
	self._identity = nil
	self._skillInfo = nil
end

return PassiveLeaderEntry
