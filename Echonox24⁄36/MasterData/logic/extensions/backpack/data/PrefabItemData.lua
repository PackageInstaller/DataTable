-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/data/PrefabItemData.lua

module("logic.extensions.backpack.data.PrefabItemData", package.seeall)

local M = class("PrefabItemData", ItemData)

function M:ctor(params)
	M.super.ctor(self, params)

	self._targetItemInfo = false
	self._prefabCO = false
	self._linkItemData = false

	self:_initTargetItem()
end

function M:_initTargetItem()
	if self._itemInfo.prefabType == GameEnum.ItemTypeEnum.EquipItemType then
		self._prefabCO = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentPrefab, self._itemInfo.prefabId)

		if self._prefabCO then
			self._targetItemInfo = BackpackConfig.instance:getItemInfoByItemId(self._prefabCO.itemId)
			self._linkItemData = ItemUtil.createItemData({
				itemId = self._prefabCO.itemId
			})
		end
	elseif self._itemInfo.prefabType == GameEnum.ItemTypeEnum.DiceItem then
		self._prefabCO = EquipmentConfig.instance:getConfigByKey(ConfigName.DicePrefab, self._itemInfo.prefabId)

		if self._prefabCO then
			self._targetItemInfo = BackpackConfig.instance:getItemInfoByItemId(self._prefabCO.itemId)
			self._linkItemData = ItemUtil.createItemData({
				itemId = self._prefabCO.itemId
			})
		end
	end

	if not self._targetItemInfo then
		printError("无法找到预设ID" .. self._itemInfo.prefabId .. "与之相关的物品信息")
	end
end

function M:getItemId()
	return self._targetItemInfo.id
end

function M:getPrefabId()
	return self._itemInfo.id
end

function M:getItemInfo()
	return self._targetItemInfo
end

function M:getTargetItemId()
	return self._targetItemInfo.id
end

function M:getName()
	return self._targetItemInfo.name or ""
end

function M:getType()
	return self._targetItemInfo.type or 0
end

function M:getSubType()
	return self._targetItemInfo.subType or 0
end

function M:getIcon()
	return self._targetItemInfo.icon or ""
end

function M:getItemDesc()
	return self._targetItemInfo.desc or ""
end

function M:getItemUseDesc()
	return self._targetItemInfo.useDesc or ""
end

function M:getPriority()
	return self._targetItemInfo.priority or 0
end

function M:getQuality()
	return self._targetItemInfo.quality or 1
end

function M:getGetWays()
	return self._targetItemInfo.getWays or {}
end

function M:getIsShowBag()
	return self._targetItemInfo.isShowBag == 1
end

function M:getJumpId()
	return self._targetItemInfo.jumpId
end

function M:getExtrInfo()
	return self._targetItemInfo.exInfo
end

function M:getLevel()
	return self._prefabCO and self._prefabCO.level or 1
end

function M:getIsEquip()
	return self._linkItemData and self._linkItemData:getIsEquip() or false
end

function M:getSuitId()
	return self._linkItemData and self._linkItemData:getSuitId() or -1
end

function M:getAllDiceAttr()
	return self._linkItemData and self._linkItemData:getAllDiceAttr() or {}
end

function M:hasOriginalD6()
	return self._linkItemData and self._linkItemData:hasOriginalD6() or false
end

function M:getPart()
	return self._linkItemData and self._linkItemData:getPart() or false
end

return M
