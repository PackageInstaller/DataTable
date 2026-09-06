-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtUseItem.lua

module("logic.extensions.battle.model.events.BattleEvtUseItem", package.seeall)

local BattleEvtUseItem = class("BattleEvtUseItem", BattleEvtBase)

function BattleEvtUseItem:ctor()
	self.oneRoundUserActionResult = nil
end

function BattleEvtUseItem:handleEvt()
	self.isToggled = true
	self._unitFactory = SceneMgr.instance:getCurScene().unitFactory
	self.currUnit = nil
	self.targetUnits = self.oneRoundUserActionResult.targetCharacterResults

	BattleItemsModel.instance:updateBattleItemEnergy(self.oneRoundUserActionResult.curBtlItemEnergy)
	BattleItemsModel.instance:updateItem(self.oneRoundUserActionResult.itemView)
	self:_handleUnit()
end

function BattleEvtUseItem:update()
	if self.currUnit and not self.currUnit.attrs:isItemUsing() then
		self:_handleUnit()
	end
end

function BattleEvtUseItem:clear()
	self.oneRoundUserActionResult = nil
	self.currUnit = nil
	self._unitFactory = nil
	self.targetUnits = nil
end

function BattleEvtUseItem:isDone()
	return not self.currUnit
end

function BattleEvtUseItem:_handleUnit()
	if self.targetUnits and #self.targetUnits > 0 then
		local result = self.targetUnits[1]
		local target = result.target

		table.remove(self.targetUnits, 1)

		self.currUnit = self._unitFactory:getUnit(target.targetTeamId, target.targetCharacterId)

		self.currUnit.battleFlow:onUseItem(self.oneRoundUserActionResult.itemView.itemId, result)
	else
		self.currUnit = nil
	end
end

return BattleEvtUseItem
