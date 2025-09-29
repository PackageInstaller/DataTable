-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonRewardCellComp.lua

module("logic.extensions.dungeon.view.DungeonRewardCellComp", package.seeall)

local M = class("DungeonRewardCellComp", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._imgQuality = registry:findUIElement("branchline_reward_item_-965698395", UIComponentType.Image)
	self._iconImg = registry:findUIElement("reward_item_1053251948", UIComponentType.Image)
	self._isReceivedGo = registry:findUIElement("reward_item_-120540047")
	self._isFirstGo = registry:findUIElement("reward_item_489687583")
	self._isMainGo = registry:findUIElement("reward_item_-1059045891")
	self._countTxt = registry:findUIElement("branchline_reward_item_1906874577", UIComponentType.Text)
end

function M:updateData(luaTable)
	self._itemCode = luaTable.code

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(luaTable.code)

	IconLoader.setSpriteByItemType(self._iconImg, itemCo.type, itemCo.icon)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemCo.quality])
	goutil.setActive(self._isReceivedGo, luaTable.hasPassed)
	goutil.setActive(self._isMainGo, not luaTable.isFirstPassReward)

	self._countTxt.text = luaTable.count and luaTable.count or ""
end

return M
