-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueMiddleTips.lua

module("logic.extensions.roguelike.view.widgets.RogueMiddleTips", package.seeall)

local M = class("RogueMiddleTips")

function M:ctor(go)
	self._go = go.gameObject
	self._txtTips = goutil.findChildTextComponent(go, "txtType")
end

function M:updateData(data)
	self._txtTips.text = data.text

	self:setActive(true)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:OnDestroy()
	return
end

return M
