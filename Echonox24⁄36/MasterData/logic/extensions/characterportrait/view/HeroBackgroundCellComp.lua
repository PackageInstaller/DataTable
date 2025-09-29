-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterportrait/view/HeroBackgroundCellComp.lua

module("logic.extensions.characterportrait.view.HeroBackgroundCellComp", package.seeall)

local M = class("HeroBackgroundCellComp", CellBaseComponent)

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._iconImg = registry:findUIElement("background_item_2058723834", UIComponentType.Image)
	self._selectObj = registry:findUIElement("background_item_-1198572182")
	self._useMarkGo = registry:findUIElement("background_item_-504918435")
	self._lockGo = registry:findUIElement("background_item_1071872337")
	self._btnSelect = registry:findUIElement("background_item_-1688634802", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)
end

function M:_clickSelect()
	if self._curSelectId == self._bgId then
		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex)
	end
end

function M:updateData(data, index)
	self._curIndex = index
	self._hasGot = data.hasGot
	self._bgCO = data.co
	self._bgId = self._bgCO.id

	self:_refreshView()
end

function M:_refreshView()
	IconLoader.setSprite(self._iconImg, IconType.Background, self._bgCO.icon)
	goutil.setActive(self._lockGo, not self._hasGot)
	goutil.setActive(self._selectObj, self._curSelectId == self._bgId)
	goutil.setActive(self._useMarkGo, self._curUseId == self._bgId)
end

function M:setUseAndSelectFaceId(curUseId, curSelectId)
	self._curUseId = curUseId
	self._curSelectId = curSelectId
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
end

return M
