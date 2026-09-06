-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/controller/BattleItemController.lua

module("logic.extensions.battle.controller.BattleItemController", package.seeall)

local BattleItemController = class("BattleItemController")

function BattleItemController:onInit()
	BattleItemController.super.onInit(self)
end

function BattleItemController:onReset()
	return
end

function BattleItemController:isItemUsable(item)
	if BattleItemsModel.instance.performing then
		return
	end

	if BattleController.instance:isForbidPause() or BattleModel.instance.isBirthing then
		return
	end

	local forceUseItemType = BattleItemsModel.instance.forceUseItemType

	if forceUseItemType and item:getItemType() ~= forceUseItemType then
		return
	end

	local isItemUsable = BattleItemsModel.instance:isItemUsable()
	local currCd = item:getCurrCd()
	local maxCd = item:getCd()
	local consueEnergy = item:consumeEnergyPerAction()
	local itemNum = item:getItemNum()

	if not isItemUsable or currCd > 0 or itemNum == 0 or itemNum < item:consumeNumPerAction() or consueEnergy > BattleItemsModel.instance.battleItemEnergy then
		return
	else
		return true
	end
end

function BattleItemController:updateItemSprite(go, name, itemId)
	local battleItemsSprite = BattleItemsModel.instance:getItemSprites()

	if not battleItemsSprite then
		return
	end

	local qiu = goutil.findChild(go, name)

	if qiu then
		local sprite = battleItemsSprite[itemId]

		if sprite then
			GoUtil.SetTextureByImage(qiu, sprite)
		end
	end
end

function BattleItemController:getItemSprite(itemId)
	local battleItemsSprite = BattleItemsModel.instance:getItemSprites()

	if not battleItemsSprite then
		return
	end

	return battleItemsSprite[itemId]
end

function BattleItemController:getItemWidget(itemId)
	local battleItemsWidgets = BattleItemsModel.instance:getItemWidgets()

	if not battleItemsWidgets then
		return
	end

	return battleItemsWidgets[itemId]
end

function BattleItemController:getTargetUnitsByItem(item, targets)
	local teamId
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(item:isTargetEnermy() and BattleModel.instance:getEnemyPlayerTeam() or BattleModel.instance.myTeamId)

	targets = targets or {}

	table.clear(targets)

	for k, v in pairs(units) do
		if not v.isSourceMon and not v:isTransparent() and item:filterTarget(v) then
			table.insert(targets, v)
		end
	end

	return targets
end

function BattleItemController:getTargetUnitsByItemId(itemId, targets)
	local item = BattleItemsModel.instance:getBattleItemById(itemId)

	return self:getTargetUnitsByItem(item, targets)
end

function BattleItemController:startItemUsableEffects(itemId)
	local units = self:getTargetUnitsByItemId(itemId)

	if units then
		local cnt = #units

		for i = 1, cnt do
			units[i]:onItemUsable(itemId)
		end
	end
end

function BattleItemController:stopItemUsableEffects(itemId)
	local units = self:getTargetUnitsByItemId(itemId)

	if units then
		local cnt = #units

		for i = 1, cnt do
			units[i]:stopItemUsable()
		end
	end
end

function BattleItemController:pushUseItem(itemId, unit)
	local item = BattleItemsModel.instance:getBattleItemById(itemId)
	local teamId = 0
	local targetId = 0

	if unit then
		teamId = unit.teamId
		targetId = unit.id
	else
		teamId = item:isTargetEnermy() and BattleModel.instance:getEnemyPlayerTeam() or BattleModel.instance.myTeamId
	end

	BattleItemsModel.instance:pushUseItem(itemId, teamId, targetId)

	if item:isNeededSelectTarget() then
		if item:isTargetSingle() then
			unit:onWaitingItemUsing(itemId)
		else
			local battleScene = SceneMgr.instance:getCurScene()
			local units = battleScene.unitFactory:getUnits(teamId)

			for k, v in pairs(units) do
				if item:filterTarget(v) then
					v:onWaitingItemUsing(itemId)
				end
			end
		end
	end

	local remain = item:getItemNum() - item:consumeNumPerAction()

	item:setItemNum(remain)
	BattleItemsModel.instance:resetItemCd()
	GlobalDispatcher:dispatch(GlobalNotify.OnUseBattleItem, unit, itemId)
end

function BattleItemController:popUseItem(status)
	local item = BattleItemsModel.instance:popUseItem()

	if not item then
		return
	end

	local teamId = item.teamId
	local targetId = item.targetId
	local battleItem = BattleItemsModel.instance:getBattleItemById(item.itemId)

	if battleItem:isNeededSelectTarget() then
		local battleScene = SceneMgr.instance:getCurScene()

		if battleItem:isTargetSingle() then
			local unit = battleScene.unitFactory:getUnit(teamId, targetId)

			if unit then
				unit:stopWaitingItemUsing()
			end
		else
			local units = battleScene.unitFactory:getUnits(teamId)

			for k, v in pairs(units) do
				if battleItem:filterTarget(v) then
					v:stopWaitingItemUsing()
				end
			end
		end
	end

	if status ~= 0 then
		local remain = battleItem:getItemNum() + battleItem:consumeNumPerAction()

		battleItem:setItemNum(remain)
		GlobalDispatcher:dispatch(GlobalNotify.BattleItemsInfo)
	end
end

BattleItemController.instance = BattleItemController.New()

return BattleItemController
