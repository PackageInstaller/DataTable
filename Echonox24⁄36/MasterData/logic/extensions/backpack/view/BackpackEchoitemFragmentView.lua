-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEchoitemFragmentView.lua

module("logic.extensions.backpack.view.BackpackEchoitemFragmentView", package.seeall)

local M = class("BackpackEchoitemFragmentView", BackpackBaseFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.MainBackpackShowType.EchoShowType
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._echoMainGo = goutil.findChild(mainGO, "backpack_echo_detail_tips_copy")
	self._echoDebrisMainGo = goutil.findChild(mainGO, "backpack_item_detail_tips_copy")
	self._detailView = Astral.LuaComponentContainer.Add(self._echoMainGo, BackpackEchoDetailView)
	self._detailDebrisView = Astral.LuaComponentContainer.Add(self._echoDebrisMainGo, BackpackPropDetailView)
	self._guiAnimation = goutil.addComponentOnce(self._echoMainGo, typeof(Astral.GUITimelineAniLua))
	self._guiAnimationDebris = goutil.addComponentOnce(self._echoDebrisMainGo, typeof(Astral.GUITimelineAniLua))
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
	self._detailDebrisView:onEnter()
	self._guiAnimationDebris:StopTimelineAni()
	self._guiAnimationDebris:PlayAniByName("open")
end

function M:onExit()
	self._detailView:onExit()
	self._detailDebrisView:onExit()
	M.super.onExit(self)
end

function M:showSelecItemInfo()
	local itemData = MainBackpackModel.instance:getCurSelecedItem()

	if itemData then
		goutil.setActive(self._echoMainGo, itemData:getType() == GameEnum.ItemTypeEnum.EchoItemType)
		goutil.setActive(self._echoDebrisMainGo, itemData:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem)

		if itemData:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
			self._detailDebrisView:setItemData(itemData)
		else
			local isRecycling = MainBackpackModel.instance:isInRecycling()

			self._detailView:setLockRootVisible(not isRecycling)
			self._detailView:setNeedShowDetailBtn(true)
			self._detailView:setEchoItemData(itemData)
		end
	end
end

return M
