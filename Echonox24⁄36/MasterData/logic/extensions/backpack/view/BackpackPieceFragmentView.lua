-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackPieceFragmentView.lua

module("logic.extensions.backpack.view.BackpackPieceFragmentView", package.seeall)

local M = class("BackpackPieceFragmentView", BackpackBaseFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.MainBackpackShowType.CardChipShowType
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._detailView = Astral.LuaComponentContainer.Add(mainGO, BackpackPieceDetailView)
	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._detailView:_destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	M.super.onEnter(self)
	self._detailView:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self._detailView:onExit()
	M.super.onExit(self)
end

function M:showSelecItemInfo()
	local itemData = MainBackpackModel.instance:getCurSelecedItem()

	if itemData then
		self._detailView:setItemData(itemData)
	end
end

return M
