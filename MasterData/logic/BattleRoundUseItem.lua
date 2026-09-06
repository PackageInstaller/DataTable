-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundUseItem.lua

module("logic.extensions.battle.model.round.BattleRoundUseItem", package.seeall)

local BattleRoundUseItem = class("BattleRoundUseItem", BattleRoundBase)

function BattleRoundUseItem:ctor()
	self.roundType = BattleRoundBase.RoundUseItem
end

function BattleRoundUseItem:pushUserActionResult(userActionResult)
	local itemCo = BattleConfig.instance:getBattleItem(userActionResult.itemView.itemId)

	if itemCo then
		self._evts = self._evts or {}

		local evt = itemCo.type == GameEnum.BattleItemType.Skill and BattleEvtUseSkillItem.New() or BattleEvtUseItem.New()

		evt.oneRoundUserActionResult = userActionResult

		table.insert(self._evts, evt)

		self._evts = self._evts or {}
	end
end

function BattleRoundUseItem:start()
	BattleRoundUseItem.super.start(self)

	BattleItemsModel.instance.performing = true
end

function BattleRoundUseItem:finish()
	BattleRoundUseItem.super.finish(self)

	BattleItemsModel.instance.performing = nil
end

return BattleRoundUseItem
