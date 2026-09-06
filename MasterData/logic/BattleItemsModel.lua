-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleItemsModel.lua

module("logic.extensions.battle.model.BattleItemsModel", package.seeall)

local BattleItemsModel = class("BattleItemsModel", BaseListModel)

BattleItemsModel.ItemUseMode_Drag = 1
BattleItemsModel.ItemUseMode_Click = 2
BattleItemsModel.ItemUseMode_Both = 3

function BattleItemsModel:ctor()
	BattleItemsModel.super.ctor(self)

	self._itemUseMode = BattleItemsModel.ItemUseMode_Both
	self.forceUseItemType = nil
	self.forceUseItemUnit = nil
	self.targetUnits = nil
	self.expression = nil
	self._battleItems = nil
	self._catchedUnits = nil
	self.battleItemEnergy = 0
	self._battleItemsSprite = nil
	self._battleItemsWidget = nil
end

function BattleItemsModel:onReset()
	BattleItemsModel.super.onReset(self)

	self.battleItemEnergy = 0
	self.forceUseItemUnit = nil
	self.forceUseItemType = nil
	self.targetUnits = nil
	self.expression = nil
	self._battleItems = nil
	self._othersItems = nil
	self._battleItemsSprite = nil
	self._battleItemsWidget = nil
	self.performing = nil
	self._catchedUnits = nil
	self._forbidPushCatchUnits = nil
end

function BattleItemsModel:updateBattleItemEnergy(battleItemEnergy, allUnits)
	local changeValue = battleItemEnergy - self.battleItemEnergy

	self.battleItemEnergy = battleItemEnergy

	GlobalDispatcher:dispatch(GlobalNotify.BattleEnergy, battleItemEnergy, changeValue, allUnits)
end

function BattleItemsModel:updateItem(curItemView)
	local item = self:getBattleItemById(curItemView.itemId)

	if item then
		item:fillData(curItemView)
		GlobalDispatcher:dispatch(GlobalNotify.BattleItemsInfo)
	end
end

function BattleItemsModel:isItemDragable()
	return self._itemUseMode == BattleItemsModel.ItemUseMode_Drag or self._itemUseMode == BattleItemsModel.ItemUseMode_Both
end

function BattleItemsModel:isItemClickable()
	return self._itemUseMode == BattleItemsModel.ItemUseMode_Click or self._itemUseMode == BattleItemsModel.ItemUseMode_Both
end

function BattleItemsModel:onBattleStartData(battleData)
	for k, v in pairs(battleData.originalStates.teams) do
		if v.playerView then
			if not battleData.myTeamId then
				if v.teamId == battleData.myTeamId then
					self.battleItemEnergy = v.playerView.initBtlItemEnergy
				end

				if v.teamId == battleData.myTeamId then
					self._battleItems = self:_createBattleItems(v.playerView.battleItems)

					if self._battleItems then
						table.sort(self._battleItems, function(x, y)
							if x == y then
								return false
							end

							local xNum = x:getItemNum()
							local yNum = y:getItemNum()

							if xNum > 0 and yNum <= 0 then
								return true
							end

							if xNum <= 0 and yNum > 0 then
								return false
							end

							local xId = x:getItemId()
							local yId = y:getItemId()

							if xId < yId then
								return true
							end

							return false
						end)
					end
				else
					self._othersItems = self:_createBattleItems(v.playerView.battleItems)
				end
			end
		end
	end
end

function BattleItemsModel:_createBattleItems(battleItems)
	if not battleItems or #battleItems == 0 then
		return
	end

	local items = {}
	local cnt = #battleItems

	for i = 1, cnt do
		local itemData = battleItems[i]
		local itemCo = BattleConfig.instance:getBattleItem(itemData.itemId)
		local item

		if itemCo then
			if BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Catch then
				if itemCo.type == GameEnum.BattleItemType.Ball then
					item = BattleItemFactory.createItem(itemData.itemId, itemData.curNum)
				end
			elseif BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Skill and itemCo.type == GameEnum.BattleItemType.Skill then
				item = BattleItemFactory.createItem(itemData.itemId, itemData.curNum)
			end
		end

		if item then
			table.insert(items, item)
			item:fillData(itemData)
		end
	end

	return items
end

function BattleItemsModel:viewUserFightMonsterBtlResult(btlresult)
	self:onBattleStartData(btlresult)
end

function BattleItemsModel:getBattleItems()
	return self._battleItems
end

function BattleItemsModel:getBattleItemById(id)
	local items = self._battleItems

	if items then
		local cnt = #items

		for i = 1, cnt do
			if items[i]:getItemId() == id then
				return items[i]
			end
		end
	end
end

function BattleItemsModel:pushUseItem(itemId, teamId, targetId)
	self.targetUnits = self.targetUnits or {}

	table.insert(self.targetUnits, {
		itemId = itemId,
		teamId = teamId,
		targetId = targetId
	})
end

function BattleItemsModel:hasUsingItems()
	return self.targetUnits and #self.targetUnits > 0
end

function BattleItemsModel:popUseItem()
	if self.targetUnits and #self.targetUnits > 0 then
		local item = self.targetUnits[1]

		table.remove(self.targetUnits, 1)

		return item
	end
end

function BattleItemsModel:isItemUsable()
	if self.expression then
		return self.expression:isMet()
	end

	return true
end

function BattleItemsModel:getItemUnusableTips()
	if self.expression then
		return self.expression:getTips()
	end
end

function BattleItemsModel:forbidPushCatchUnits()
	self._forbidPushCatchUnits = true

	if self._catchedUnits then
		table.clear(self._catchedUnits)
	end
end

function BattleItemsModel:pushCatchedUnits(unit)
	if not BattleModel.instance.monsterId or self._forbidPushCatchUnits then
		return
	end

	self._catchedUnits = self._catchedUnits or {}

	local raceId = unit.attrs:getOriginRaceId()

	for i = 1, #self._catchedUnits do
		if self._catchedUnits[i].isSouceMon and self._catchedUnits[i].raceId == unit.raceId then
			return
		end
	end

	local unitInfo = {}

	unitInfo.raceId = unit.attrs:getOriginRaceId()
	unitInfo.level = 1

	table.insert(self._catchedUnits, unitInfo)
end

function BattleItemsModel:getCatchedUnits()
	return self._catchedUnits
end

function BattleItemsModel:pushCatchedSourcemons(catchedSourcemons)
	if not BattleModel.instance.monsterId or not catchedSourcemons then
		return
	end

	self._catchedUnits = self._catchedUnits or {}

	for i = 1, #catchedSourcemons do
		local j = 1
		local cfg = SourceMonConfig.instance:getCfgById(catchedSourcemons[i].defineId)

		while j <= #self._catchedUnits do
			if self._catchedUnits[j].raceId == cfg.modelId and not self._catchedUnits[j].isSouceMon then
				table.remove(self._catchedUnits, j)
			else
				j = j + 1
			end
		end
	end

	for i = 1, #catchedSourcemons do
		local unitInfo = {}
		local cfg = SourceMonConfig.instance:getCfgById(catchedSourcemons[i].defineId)

		unitInfo.raceId = cfg.modelId
		unitInfo.level = catchedSourcemons[i].level
		unitInfo.isSouceMon = true

		table.insert(self._catchedUnits, unitInfo)
	end
end

function BattleItemsModel:cooldownItemCd()
	if self._battleItems then
		for k, v in pairs(self._battleItems) do
			v:cooldownItemCd()
		end

		GlobalDispatcher:dispatch(GlobalNotify.BattleItemsInfo)
	end
end

function BattleItemsModel:resetItemCd()
	if self._battleItems then
		for k, v in pairs(self._battleItems) do
			v:resetItemCd()
		end

		GlobalDispatcher:dispatch(GlobalNotify.BattleItemsInfo)
	end
end

function BattleItemsModel:addItemSprite(itemId, sprite)
	self._battleItemsSprite = self._battleItemsSprite or {}
	self._battleItemsSprite[itemId] = sprite
end

function BattleItemsModel:getItemSprites()
	return self._battleItemsSprite
end

function BattleItemsModel:clearItemSprites()
	self._battleItemsSprite = nil
end

function BattleItemsModel:addItemWidget(itemId, widget)
	self._battleItemsWidget = self._battleItemsWidget or {}
	self._battleItemsWidget[itemId] = widget
end

function BattleItemsModel:clearItemWidgets()
	self._battleItemsWidget = nil
end

function BattleItemsModel:getItemWidgets()
	return self._battleItemsWidget
end

function BattleItemsModel:getItemIconsAssetPath()
	if BattleModel.instance:getActionMode() ~= GameEnum.ActionModel.NoneAction and self._battleItems then
		local iconsPath = {}

		for k, item in pairs(self._battleItems) do
			table.insert(iconsPath, item:getItemIcon())
		end

		return iconsPath
	end
end

function BattleItemsModel:getItemModelAssetPath()
	if BattleModel.instance:getActionMode() ~= GameEnum.ActionModel.NoneAction then
		local modelsPath = {}

		if self._battleItems then
			for k, item in pairs(self._battleItems) do
				if item:getItemNum() > 0 then
					local path = item:getItemModel()

					if path and #path > 0 then
						table.insert(modelsPath, path)
					end
				end
			end
		end

		if self._othersItems then
			for k, item in pairs(self._othersItems) do
				if item:getItemNum() > 0 then
					local path = item:getItemModel()

					if path and #path > 0 then
						table.insert(modelsPath, path)
					end
				end
			end
		end

		return modelsPath
	end
end

function BattleItemsModel:getSkillPetAssetPath()
	if BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Skill then
		local spinePath

		if self._battleItems then
			for k, item in pairs(self._battleItems) do
				if item:getItemNum() > 0 then
					local petCo = CharacterConfig.instance:getPetCo(item:getPetId())
					local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

					spinePath = spinePath or {}

					table.insert(spinePath, GameUrl.getSpineUrl(modelCo.resName))
				end
			end
		end

		if self._othersItems then
			for k, item in pairs(self._othersItems) do
				if item:getItemNum() > 0 then
					local petCo = CharacterConfig.instance:getPetCo(item:getPetId())
					local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

					spinePath = spinePath or {}

					table.insert(spinePath, GameUrl.getSpineUrl(modelCo.resName))
				end
			end
		end

		return spinePath
	end
end

function BattleItemsModel:getSkillPetIds()
	if BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Skill and self._battleItems then
		local petIds = {}

		for k, item in pairs(self._battleItems) do
			if item:getItemNum() > 0 then
				table.insert(petIds, item:getPetId())
			end
		end

		return petIds
	end
end

function BattleItemsModel:getEnemySkillPetIds()
	if BattleModel.instance:getActionMode() == GameEnum.ActionModel.UserAction_Skill and self._othersItems then
		local petIds = {}

		for k, item in pairs(self._othersItems) do
			if item:getItemNum() > 0 then
				table.insert(petIds, item:getPetId())
			end
		end

		return petIds
	end
end

function BattleItemsModel:isItemsEmpty()
	if self._battleItems then
		for k, item in pairs(self._battleItems) do
			if item:getItemNum() > 0 then
				return false
			end
		end
	end

	if self._othersItems then
		for k, item in pairs(self._othersItems) do
			if item:getItemNum() > 0 then
				return false
			end
		end
	end
end

BattleItemsModel.instance = BattleItemsModel.New()

return BattleItemsModel
