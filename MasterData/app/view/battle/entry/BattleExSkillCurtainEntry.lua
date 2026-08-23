local Entry = require("app.view.battle.entry.Entry")
local BattleExSkillCurtainEntry = class("BattleExSkillCurtainEntry", Entry)

function BattleExSkillCurtainEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._identity = arg_1_1.identity
	self._skillInfo = arg_1_1.skillInfo
	self._knightInfo = arg_1_1.knightInfo
	self._skillName = arg_1_1.skillName
	self._isMonster = arg_1_1.isMonster
	self._actor = arg_1_1.actor
	self._isDone = false

	BattleExSkillCurtainEntry.super.ctor(self)
end

function BattleExSkillCurtainEntry:initEntry()
	self.super.initEntry(self)

	local var_2_0 = Entry.new()

	var_2_0:addEntryToNewQueue(nil, handler(self, self._showUI))
	self:addEntryToQueue(var_2_0, var_2_0.updateEntry)
end

function BattleExSkillCurtainEntry:_showUI()
	if g.core.battle.BattleProxy:getBattleLayer():isCurPaused() then
		return false
	end

	local var_3_0 = fgui.UIPackage:createObject("battle", "BattleExSkillCurtainComp")

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

	local var_3_1 = fgui.UIPackage:createObject("battle", "BattleExTopSkillCurtainComp")

	if self._identity ~= 1 then
		var_3_1:setScaleX(-1)
		var_3_1:setPosition(cc.p(display.width - 0, 0))
	else
		var_3_1:setPosition(cc.p(0, 0))
	end

	var_3_1:updateView({
		identity = self._identity,
		skillInfo = self._skillInfo,
		knightInfo = self._knightInfo,
		skillName = self._skillName,
		isMonster = self._isMonster,
		timeScale = self._battleLayer:getCurSpeed(),
		actor = self._actor,
		callback = function()
			self._isDone1 = true
		end
	})
	self._battleLayer:addNodeToUILayer(var_3_1, 1)

	return true
end

function BattleExSkillCurtainEntry:isDone()
	return self._isDone and self._isDone1
end

function BattleExSkillCurtainEntry:destroyEntry()
	BattleExSkillCurtainEntry.super.destroyEntry(self)

	self._battleLayer = nil
	self._identity = nil
	self._skillInfo = nil
	self._knightInfo = nil
	self._skillName = nil
	self._isMonster = nil
end

return BattleExSkillCurtainEntry
