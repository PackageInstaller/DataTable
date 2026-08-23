local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationPreLineupKnightCell = class("FormationPreLineupKnightCell", require("app.fairyGUI.formation.UI_FormationPreLineupKnightCell"))

function FormationPreLineupKnightCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_1.STAR_MAX
	})
end

function FormationPreLineupKnightCell:updateCell(arg_2_1, arg_2_2)
	self.m_knightIcon:setIcon((var_0_0:getKnightIconById(arg_2_1:getResInfo().icon_id)))
	self.m_leaderLoader:setVisible(arg_2_1:isElementLeader())
	self.m_nameText:setText(arg_2_1:getName())

	local var_2_0, var_2_1 = arg_2_1:getAdvStageAndLevel()

	if var_2_0 > 0 then
		self.m_stageText:setText("+" .. var_2_0)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_2_1:getStarLv())
	self.m_qualityBg:setURL((var_0_0:getUserIconQualityStarBg(arg_2_1:getQuality())))

	local var_2_2 = arg_2_2.formationStruct
	local var_2_3, var_2_4, var_2_5 = var_2_2:getKnightAssCount(arg_2_1:getServerId(), arg_2_2.clickPos or 0, arg_2_2.isLineupPos or false, true)

	if var_2_4 > 0 then
		self.m_isActiveAssctController:setSelectedIndex(1)
	else
		self.m_isActiveAssctController:setSelectedIndex(0)
	end

	self.m_assctNum:setText(var_2_4)
	self.m_assctMaxNum:setText("/" .. var_2_5)

	if var_2_2 then
		if var_2_2:isKnightLineUp(arg_2_1:getServerId()) then
			self.m_lineUpStateController:setSelectedIndex(1)
		elseif var_2_2:isPartnerLineUp(arg_2_1:getServerId()) then
			self.m_lineUpStateController:setSelectedIndex(2)
		else
			self.m_lineUpStateController:setSelectedIndex(0)

			if var_2_3 > 0 then
				self.m_hasActiveController:setSelectedIndex(1)
				self.m_activeNum:setText("+" .. var_2_3)
			else
				self.m_hasActiveController:setSelectedIndex(0)
			end
		end
	end
end

return FormationPreLineupKnightCell
