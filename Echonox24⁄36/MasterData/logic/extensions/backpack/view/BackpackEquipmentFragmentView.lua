-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEquipmentFragmentView.lua

module("logic.extensions.backpack.view.BackpackEquipmentFragmentView", package.seeall)

local M = class("BackpackEquipmentFragmentView", BackpackBaseFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.MainBackpackShowType.EquipShowType
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._detailView = Astral.LuaComponentContainer.Add(mainGO, BackpackEquipDetailTips)

	self._detailView:buildUI()

	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._detailView:destroyUI()
	M.super.destroyUI(self)
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
		local isRecycling = MainBackpackModel.instance:isInRecycling()

		self._detailView:setEquipStatusVisible(not isRecycling)
		self._detailView:refreshTip(itemData)
	end
end

return M
