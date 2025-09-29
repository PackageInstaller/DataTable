-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/ItemViews/HackOptimiseLightItem.lua

module("logic.extensions.hacktool.view.ItemViews.HackOptimiseLightItem", package.seeall)

local M = class("HackOptimiseLightItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._text = goutil.findChildComponent(self.mainGO, "TextName", UIComponentType.Text)
	self._toggle = goutil.findChildComponent(self.mainGO, "Toggle", UIComponentType.SpaceXToggle)
	self._goSelect = goutil.findChild(self.mainGO, "ImageSelect")
	self._btn = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "Button"))

	goutil.setActive(self._goSelect, false)
end

function M:Awake()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()

	self._btnBC = nil
	self._bCHolder = nil
	self.LightComp = nil
end

function M:updateData(LightComp)
	self._text.text = LightComp.name
	self._toggle.IsOn = LightComp.enabled
	self.LightComp = LightComp
end

function M:setClickBC(bc, bCHolder)
	self._btnBC = bc
	self._bCHolder = bCHolder
end

function M:_onClick()
	local isOn = not self._toggle.IsOn

	self._toggle.IsOn = isOn
	self.LightComp.enabled = isOn

	if self._btnBC then
		self._btnBC(self._bCHolder, isOn)
	end
end

return M
