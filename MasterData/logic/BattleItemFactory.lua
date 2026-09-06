-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/items/BattleItemFactory.lua

module("logic.extensions.battle.model.items.BattleItemFactory", package.seeall)

local BattleItemFactory = {}

function BattleItemFactory.createItem(itemId, itemNum)
	local itemCo = BattleConfig.instance:getBattleItem(itemId)

	if not itemCo then
		return
	end

	if itemCo.type == GameEnum.BattleItemType.Ball then
		return BattleItemBall.New(itemCo, itemNum)
	elseif itemCo.type == GameEnum.BattleItemType.Buff then
		return BattleItemBuff.New(itemCo, itemNum)
	elseif itemCo.type == GameEnum.BattleItemType.Skill then
		return BattleItemSkill.New(itemCo, itemNum)
	end
end

return BattleItemFactory
