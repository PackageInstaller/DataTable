-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueMoneyItem.lua

module("logic.extensions.roguelike.view.explore.map.RogueMoneyItem", package.seeall)

local M = class("RogueMoneyItem")
local kMoneyCode = 50090010

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._txtCount = goutil.findChildTextComponent(go, "txtNum")

	self:setEvent(true)
	self:updateData()
end

function M:setContent(content)
	self._txtCount.text = content
end

function M:updateData()
	local count = RoguelikeModel.instance:getGold()

	self:setContent(count)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_GOLD, self._onGoldRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, self._onShowChangeCollector, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_GOLD, self._onGoldRefresh, self)
	end
end

function M:_onGoldRefresh()
	self:updateData()
end

function M:_onShowChangeCollector(sender, changes)
	if #changes > 0 then
		local attrType = RoguelikeExtension_pb.AttrType

		for k, v in ipairs(changes) do
			if v.type == attrType.R_GOLD then
				-- block empty
			end
		end
	end
end

function M:OnDestroy()
	self:setEvent(false)
end

return M
