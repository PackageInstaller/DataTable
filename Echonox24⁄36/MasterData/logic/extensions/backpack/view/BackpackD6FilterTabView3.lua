-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackD6FilterTabView3.lua

module("logic.extensions.backpack.view.BackpackD6FilterTabView3", package.seeall)

local M = class("BackpackD6FilterTabView3", BackpackFilterTabView)

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._btnNormal = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "normal"))
	self._btnSelect = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "select"))
	self._btnSpecial = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "special"))
	self._txtNormal = goutil.findChildTextComponent(self._mainGo, "normal/Text")
	self._txtSelect = goutil.findChildTextComponent(self._mainGo, "select/Text")
	self._txtSpecial = goutil.findChildTextComponent(self._mainGo, "special/Text")

	self:_bindEvents()
end

return M
