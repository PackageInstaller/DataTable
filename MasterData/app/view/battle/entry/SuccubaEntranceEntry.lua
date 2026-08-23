local SuccubaEntranceEntry = class("SuccubaEntranceEntry", require("app.view.battle.entry.Entry"))

function SuccubaEntranceEntry:ctor(arg_1_1)
	self._battleLayer = arg_1_1.battleLayer
	self._succubaId = arg_1_1.succubaId
	self._identity = arg_1_1.identity or 1
	self._isDone = false

	SuccubaEntranceEntry.super.ctor(self)
end

function SuccubaEntranceEntry:initEntry()
	self.super.initEntry(self)

	local var_2_0 = self._battleLayer:getCurSpeed()
	local var_2_1 = fgui.UIPackage:createObject("battle", "BattleSuccubaEntranceComp")

	if self._identity ~= 1 then
		var_2_1:setScaleX(-1)
		var_2_1:setPosition(cc.p(display.width + 0, 0))
	else
		var_2_1:setPosition(cc.p(-0, 0))
	end

	var_2_1:updateView({
		succubaId = self._succubaId,
		identity = self._identity,
		callback = function()
			self._isDone = true
		end,
		timeScale = var_2_0
	})
	self._battleLayer:addNodeToUILayer(var_2_1, 1)
end

function SuccubaEntranceEntry:isDone()
	return self._isDone
end

function SuccubaEntranceEntry:destroyEntry()
	SuccubaEntranceEntry.super.destroyEntry(self)

	self._battleLayer = nil
	self._succubaId = nil
	self._isDone = nil
end

return SuccubaEntranceEntry
