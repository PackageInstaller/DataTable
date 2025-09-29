-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/ConsoleItem.lua

module("logic.extensions.hacktool.view.ConsoleItem", package.seeall)

local M = class("ConsoleItem", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._data = {}

	self:_buildUI()
end

function M:_buildUI()
	self._txtDesc = goutil.findChildTextComponent(self._mainGo, "text")
	self._btnCom = Astral.ButtonAdapter.Get(self._mainGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnCom:AddClickListener(self._onClickSelf, self)
end

function M:_unbindEvents()
	self._btnCom:RemoveClickListener()
end

function M:setHandler(handlerFunc, handlerObj)
	self._handlerFunc = handlerFunc
	self._handlerObj = handlerObj
end

function M:updateData(data)
	self._data = data
	self._txtDesc.text = data.id .. data.name
end

function M:_onClickSelf()
	if self._handlerObj then
		self._handlerFunc(self._handlerObj, self._data.id)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

return M
