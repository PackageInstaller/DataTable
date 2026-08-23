local DrawKnight = require("app.view.common.DrawKnight")
local DebugMultiSpineCell = class("DebugMultiSpineCell", require("app.fairyGUI.debug.UI_DebugMultiSpineCell"))

function DebugMultiSpineCell:ctor()
	self._resId = 0
	self._spine = nil
end

function DebugMultiSpineCell:updateCell(arg_2_1)
	if self._resId ~= arg_2_1 then
		if self._spine then
			self._spine:removeFromParent()
		end

		self._resId = arg_2_1
		self._spine = DrawKnight.new({
			scale = 1,
			resId = arg_2_1
		})

		self.m_nodeRoot:addChild(self._spine)
		self._spine:addKnightWingSpine(1)
	end
end

function DebugMultiSpineCell:addKnightWingSpine()
	self._spine:addKnightWingSpine(1)
end

return DebugMultiSpineCell
