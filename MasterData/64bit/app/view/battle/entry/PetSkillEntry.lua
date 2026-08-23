local Entry = require("app.view.battle.entry.Entry")
local PetSkillEntry = class("PetSkillEntry", Entry)

function PetSkillEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._skillInfo = arg_1_1.skillInfo
	self._identity = arg_1_1.identity or 1
	self._quality = arg_1_1.quality

	PetSkillEntry.super.ctor(self)
end

function PetSkillEntry:initEntry()
	self.super.initEntry(self)

	local var_2_0 = Entry.new()

	var_2_0:addEntryToNewQueue(nil, handler(self, self._showUI))
	self:addEntryToQueue(var_2_0, var_2_0.updateEntry)
end

function PetSkillEntry:_showUI()
	if g.core.battle.BattleProxy:getBattleLayer():isCurPaused() then
		return false
	end

	local var_3_0 = fgui.UIPackage:createObject("battle", "BattlePetSkillCurtainComp")
	local var_3_1 = cc.Director:getInstance():getSafeAreaRect().x

	if self._identity ~= 1 then
		var_3_0:setScaleX(-1)
		var_3_0:setPosition(cc.p(display.width + var_3_1, 0))
	else
		var_3_0:setPosition(cc.p(-var_3_1, 0))
	end

	var_3_0:updateView({
		identity = self._identity,
		skillInfo = self._skillInfo,
		quality = self._quality,
		callback = function()
			self._isDone = true
		end
	})
	self._battleLayer:addNodeToUILayer(var_3_0, 1)

	return true
end

function PetSkillEntry:isDone()
	return self._isDone
end

function PetSkillEntry:destroyEntry()
	PetSkillEntry.super.destroyEntry(self)

	self._battleLayer = nil
	self._identity = nil
	self._skillInfo = nil
end

return PetSkillEntry
