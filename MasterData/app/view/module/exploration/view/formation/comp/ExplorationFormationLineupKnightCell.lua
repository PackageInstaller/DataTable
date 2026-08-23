local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.explorationData
local ExplorationFormationLineupKnightCell = class("ExplorationFormationLineupKnightCell", require("app.fairyGUI.exploration.UI_ExplorationFormationLineupKnightCell"))

function ExplorationFormationLineupKnightCell:ctor()
	self._knightStruct = 0
	self._formationData = var_0_2:getFormationData()

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX
	})
	self.m_knightIcon:addClickListener(handler(self, self._onShowAttr))
	self.m_stageText:setVisible(false)
end

function ExplorationFormationLineupKnightCell:_onShowAttr()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightStruct = self._knightStruct
	}), {
		withoutAni = true
	})
end

function ExplorationFormationLineupKnightCell:updateCell(arg_3_1, arg_3_2)
	self._knightStruct = arg_3_1

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1:getBaseInfo().classical))

	if self.m_leaderLoader then
		self.m_leaderLoader:setVisible(arg_3_1:isElementLeader())
	end

	self.m_knightIcon:setIcon((var_0_1:getKnightIconById(arg_3_1:getResInfo().icon_id)))
	self.m_nameText:setText(arg_3_1:getName())
	self.m_starComp:setStarNum(arg_3_1:getStarLv())
	self.m_qualityBg:setURL((var_0_1:getUserIconQualityStarBg(arg_3_1:getQuality())))

	local var_3_0 = arg_3_1:getServerId()

	if self._formationData:isLineUpKnight(var_3_0) then
		if self._formationData:isUsingKnight(var_3_0) then
			self.m_lineUpStateController:setSelectedIndex(1)
		else
			self.m_lineUpStateController:setSelectedIndex(2)
		end
	else
		self.m_lineUpStateController:setSelectedIndex(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			formationIndex = arg_3_2.formationIdx,
			pos = arg_3_2.stationPos,
			checkSid = var_3_0
		}
	})
end

return ExplorationFormationLineupKnightCell
