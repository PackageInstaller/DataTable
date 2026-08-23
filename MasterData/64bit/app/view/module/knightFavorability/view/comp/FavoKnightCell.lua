local FavoKnightCell = class("FavoKnightCell", require("app.fairyGUI.knightFavorability.UI_FavoKnightCell"))

function FavoKnightCell:ctor(arg_1_1)
	self._data = {}

	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)
end

function FavoKnightCell:updateView(arg_2_1)
	self._data = arg_2_1 or {}

	if not self._data.getBaseKnightInfo then
		return
	end

	local var_2_0 = self._data:getBaseKnightInfo()

	self.m_picComp:updatePic(var_2_0)
	self.m_knightNameTxt:setText(var_2_0:getName())
	self.m_favoLevelTxt:setText((var_2_0:getFavoLevel()))

	local var_2_1 = self._data:getProgressData()

	self.m_favoProgComp:setPercent({
		cur = var_2_1.curLevelExp,
		max = var_2_1.toLevelExp
	})

	if self._data:getUnlockStoryFlag() then
		self.m_storyFlagController:setSelectedIndex(0)
	else
		self.m_storyFlagController:setSelectedIndex(1)
	end

	if var_2_0:isLineup() then
		self.m_isLineUpController:setSelectedIndex(1)
	else
		self.m_isLineUpController:setSelectedIndex(0)
	end

	self.m_weddingFrameComp:updateCompByKnight(var_2_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = var_2_0:getAdvanceId()
		}
	})
end

return FavoKnightCell
