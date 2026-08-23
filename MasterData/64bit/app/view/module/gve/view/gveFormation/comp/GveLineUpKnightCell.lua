local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local GveLineUpKnightCell = class("GveLineUpKnightCell", require("app.fairyGUI.gve.UI_GveLineUpKnightCell"))

function GveLineUpKnightCell:ctor()
	self._formationData = var_0_0:getGveFormationData()

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		num = 0,
		gap = 0,
		index = 3,
		style = 1,
		max = var_0_2.STAR_MAX
	})
end

function GveLineUpKnightCell:updateCompByGveKnihgtStruct(arg_2_1)
	self.m_knightIcon:setIcon((var_0_1:getKnightIconById(arg_2_1:getResInfo().icon_id)))
	self.m_nameText:setText(arg_2_1:getName())

	local var_2_0, var_2_1 = arg_2_1:getAdvStageAndLevel()

	if var_2_0 > 0 then
		self.m_stageText:setText("+" .. var_2_0)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_2_1:getStarLv())
	self.m_qualityBg:setURL((var_0_1:getUserIconQualityStarBg(arg_2_1:getQuality())))

	local var_2_2 = self._formationData:getKnightActionBySid(arg_2_1:getServerId())

	self.m_actionText:setText(var_2_2)
	self.m_isHideActionController:setSelectedIndex(0)

	if self._formationData:checkKnightIsLineUp(arg_2_1:getServerId()) then
		self.m_lineUpStateController:setSelectedIndex(1)
	elseif self._formationData:checkKnightIsUsed(arg_2_1:getServerId()) then
		self.m_lineUpStateController:setSelectedIndex(2)
	elseif var_2_2 < var_0_0:getGveBaseCfg().action_cost then
		self.m_lineUpStateController:setSelectedIndex(3)
	else
		self.m_lineUpStateController:setSelectedIndex(0)
	end
end

function GveLineUpKnightCell:updateCell(arg_3_1, arg_3_2)
	self.m_knightIcon:setIcon((var_0_1:getKnightIconById(arg_3_1:getResInfo().icon_id)))
	self.m_nameText:setText(arg_3_1:getName())

	local var_3_0, var_3_1 = arg_3_1:getAdvStageAndLevel()

	if var_3_0 > 0 then
		self.m_stageText:setText("+" .. var_3_0)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_3_1:getStarLv())
	self.m_qualityBg:setURL((var_0_1:getUserIconQualityStarBg(arg_3_1:getQuality())))
	self.m_isHideActionController:setSelectedIndex(1)

	if arg_3_2 then
		if arg_3_2.formationStruct:isKnightLineUp(arg_3_1:getServerId()) then
			self.m_lineUpStateController:setSelectedIndex(1)
		else
			self.m_lineUpStateController:setSelectedIndex(0)
		end
	else
		self.m_lineUpStateController:setSelectedIndex(0)
	end
end

return GveLineUpKnightCell
