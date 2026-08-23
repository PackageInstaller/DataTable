local Entry = require("app.view.battle.entry.Entry")
local BattleArtifactUrEntry = class("BattleArtifactUrEntry", Entry)

function BattleArtifactUrEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._identity = arg_1_1.identity
	self._skillInfo = arg_1_1.skillInfo
	self._knightInfo = arg_1_1.knightInfo
	self._skillName = arg_1_1.skillName
	self._isMonster = arg_1_1.isMonster
	self._actor = arg_1_1.actor
	self._isDone = false

	BattleArtifactUrEntry.super.ctor(self)
end

function BattleArtifactUrEntry:initEntry()
	self.super.initEntry(self)

	local var_2_0 = Entry.new()

	var_2_0:addEntryToNewQueue(nil, handler(self, self._showUI))
	self:addEntryToQueue(var_2_0, var_2_0.updateEntry)
end

function BattleArtifactUrEntry:_showUI()
	if g.core.battle.BattleProxy:getBattleLayer():isCurPaused() then
		return false
	end

	local var_3_0 = fgui.UIPackage:createObject("battle", "BattleArtifactUrComp")

	if self._identity ~= 1 then
		var_3_0:setScaleX(-1)
		var_3_0:setPosition(cc.p(display.width - 0, 0))
	else
		var_3_0:setPosition(cc.p(0, 0))
	end

	var_3_0:updateView({
		identity = self._identity,
		skillInfo = self._skillInfo,
		knightInfo = self._knightInfo,
		skillName = self._skillName,
		isMonster = self._isMonster,
		timeScale = self._battleLayer:getCurSpeed(),
		actor = self._actor,
		callback = function()
			self._isDone = true
		end
	})
	self._battleLayer:addNodeToUILayer(var_3_0, 1)

	return true
end

function BattleArtifactUrEntry:isDone()
	return self._isDone
end

function BattleArtifactUrEntry:destroyEntry()
	BattleArtifactUrEntry.super.destroyEntry(self)

	self._battleLayer = nil
	self._identity = nil
	self._skillInfo = nil
	self._knightInfo = nil
	self._skillName = nil
	self._isMonster = nil
end

return BattleArtifactUrEntry
