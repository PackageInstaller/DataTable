-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkThemeTabItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkThemeTabItem", package.seeall)

local M = class("AirWorkThemeTabItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "normal"))
	self._goSelect = goutil.findChild(self.mainGO, "select")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "txtTitle")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:setData(themeCO)
	self._themeCO = themeCO

	self:_updateView()
end

function M:_updateView()
	self._nameTxt.text = self._themeCO.name
end

function M:setSeleted(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._themeCO.id)
	end
end

return M
