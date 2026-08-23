local DebugMultiSpineComp = class("DebugMultiSpineComp", require("app.fairyGUI.debug.UI_DebugMultiSpineComp"))
local DrawKnight = require("app.view.common.DrawKnight")

function DebugMultiSpineComp:ctor()
	self._spineNum = 0
	self._skinName = "idle"

	self.m_spineList:setVirtual()
	self.m_spineList:doFairyBatching(true)
	self.m_spineList:setItemRenderer(handler(self, self._onRenderSpines))
	self.m_clearBtn:addClickListener(handler(self, self._onClickClear))
	self.m_generateBtn:addClickListener(handler(self, self._onClickGenerateBtn))
end

function DebugMultiSpineComp:_onClickClear()
	self.m_spineList:setNumItems(0)
	self.m_spineHolder:removeChildren()

	for iter_2_0 = 1, self._spineNum do
		local var_2_0 = self.m_spineHolder:getNode("wing" .. iter_2_0)

		self.m_spineHolder:removeNodeByTag("wing" .. iter_2_0)
		var_2_0:release()
	end
end

function DebugMultiSpineComp:_onClickGenerateBtn()
	self._spineNum = tonumber(self.m_spineInput:getText() or 0)

	self:_updateSpines()
end

function DebugMultiSpineComp:_updateSpines()
	if self.m_isUseSlot:isSelected() then
		self.m_spineHolder:removeChildren()

		for iter_4_0 = 1, self._spineNum do
			local var_4_0 = DrawKnight.new({
				scale = 1,
				resId = 210000
			})

			self.m_spineHolder:addChild(var_4_0)
			var_4_0:addKnightBackSpineAtSlot("Back_pendant_1", 1)
		end
	else
		for iter_4_1 = 1, self._spineNum do
			self.m_spineHolder:addChild((DrawKnight.new({
				scale = 1,
				resId = 210000
			})))
		end

		for iter_4_2 = 1, self._spineNum do
			self.m_backHolder:addNode((DrawKnight:getBackSpine(210000, 1)))
		end
	end
end

function DebugMultiSpineComp:_onRenderSpines(arg_5_1, arg_5_2)
	arg_5_2:updateCell(210000)
end

return DebugMultiSpineComp
