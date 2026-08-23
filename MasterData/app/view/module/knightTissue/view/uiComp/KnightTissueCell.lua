local KnightTissueCell = class("KnightTissueCell", require("app.fairyGUI.knightTissue.UI_KnightTissueCell"))
local var_0_1 = g.core.model.User.knightFavoData
local var_0_2 = g.core.model.User.knightsData

function KnightTissueCell:ctor()
	self._knightId = 0
	self._favoLevel = 0

	self.m_touchLoader:addClickListener(handler(self, self._onClickGiftLoader))
end

function KnightTissueCell:updateKnight(arg_2_1)
	self.m_subComp:updateKnightIcon(arg_2_1)

	self._knightId = arg_2_1
	self._knight = var_0_2:getKnight({
		advance_id = self._knightId
	})

	local var_2_0 = false

	if self._knight and self._knight:isOwn() and self._knight:isPut() then
		var_2_0 = true
		self._favoLevel = self._knight:getFavoLevel()

		self.m_favoLevelTxt:setText(self._favoLevel)
	end

	self.m_isOwnController:setSelectedIndex(var_2_0 and 0 or 1)
end

function KnightTissueCell:_onClickGiftLoader(arg_3_1)
	arg_3_1:stopPropagation()

	if self._knight then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_FAVO, (var_0_1:getKnightFavoById(self._knight:getAdvanceId())))
	end
end

return KnightTissueCell
