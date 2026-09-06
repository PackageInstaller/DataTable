-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/items/BattleItemBase.lua

module("logic.extensions.battle.model.items.BattleItemBase", package.seeall)

local BattleItemBase = class("BattleItemBase")

function BattleItemBase:ctor(itemCo, itemNum)
	self._itemCo = itemCo
	self._itemNum = itemNum
	self._currItemCd = itemCo.initCd
end

function BattleItemBase:fillData(itemData)
	self._consumeEnergy = itemData.consumeEnergy
	self._itemCd = itemData.releaseCd

	self:setTargetType(itemData.target)
	self:setTargetFilter(itemData.targetFilter)
	self:setCurrCd(itemData.nextReleaseRound - BattleModel.instance.currSubRoundNum)
end

function BattleItemBase:getItemName()
	return self._itemCo.name
end

function BattleItemBase:setTargetType(target)
	self._target = target
end

function BattleItemBase:getTargetType()
	return self._target
end

function BattleItemBase:setTargetFilter(filter)
	self:_initTargetFilters(filter)
end

function BattleItemBase:getTargetFilter()
	return self._targetFilter
end

function BattleItemBase:getItemId()
	return self._itemCo.id
end

function BattleItemBase:getItemType()
	return self._itemCo.type
end

function BattleItemBase:setItemNum(num)
	self._itemNum = num
end

function BattleItemBase:getPetId()
	return 0
end

function BattleItemBase:getSkillId()
	return 0
end

function BattleItemBase:isNeededSelectTarget()
	return self._itemCo.targetDesc == GameEnum.BattleItemTargetSelectType.ClientSingle
end

function BattleItemBase:isTargetEnermy()
	local tgtType = self:getTargetType()

	return tgtType == GameEnum.BattleItemTargetType.EnemyAll or tgtType == GameEnum.BattleItemTargetType.EnemySingle or tgtType == GameEnum.BattleItemTargetType.EnemyRandom or tgtType == GameEnum.BattleItemTargetType.EnemyDie or tgtType == GameEnum.BattleItemTargetType.EnemyRealDie
end

function BattleItemBase:isTargetSingle()
	local tgtType = self:getTargetType()

	return tgtType ~= GameEnum.BattleItemTargetType.EnemyAll and tgtType ~= GameEnum.BattleItemTargetType.FriendAll
end

function BattleItemBase:getItemNum()
	return self._itemNum
end

function BattleItemBase:getItemIcon()
	return GameUrl.getItemIconUrl(self._itemCo.icon)
end

function BattleItemBase:getItemModel()
	return
end

function BattleItemBase:setCurrCd(cd)
	self._currItemCd = cd
end

function BattleItemBase:getCurrCd()
	return self._currItemCd
end

function BattleItemBase:setCd(cd)
	self._itemCd = cd or self._itemCo.releaseCd
end

function BattleItemBase:getCd()
	return self._itemCd
end

function BattleItemBase:cooldownItemCd()
	if self._currItemCd > 0 then
		self:setCurrCd(self._currItemCd - 1)
	end
end

function BattleItemBase:resetItemCd()
	self:setCurrCd(self:getCd())
end

function BattleItemBase:consumeNumPerAction()
	return self._itemCo.consumeNumPerAction
end

function BattleItemBase:consumeEnergyPerAction()
	return self._consumeEnergy
end

function BattleItemBase:filterTarget(unit)
	if self._targetFilter then
		local cnt = #self._targetFilter

		for i = 1, cnt do
			local filter = self._targetFilter[i]

			if (filter == "Active" or filter == "(Active)") and (unit:isDead() or unit.attrs:isSummonedCharacter() and not unit.attrs:isHaveBeenSummoned() or unit.attrs:isDoppelganger() and not unit.attrs:isHaveBeenDoppelgangerCreated()) then
				return
			end

			if filter == "Catchable" and not unit.attrs:isCatchable() then
				return
			end
		end
	end

	return true
end

function BattleItemBase:selectTargetEff()
	return
end

function BattleItemBase:watingRespondEff()
	return
end

function BattleItemBase:displaySuccessEff()
	return
end

function BattleItemBase:fullScreenSuccessEff()
	return
end

function BattleItemBase:displayFailedEff()
	return
end

function BattleItemBase:fullScreenFailedEff()
	return
end

function BattleItemBase:_initTargetFilters()
	if self._itemCo.targetFilter and #self._itemCo.targetFilter then
		self._targetFilter = string.split(self._itemCo.targetFilter, "&")
	end
end

return BattleItemBase
