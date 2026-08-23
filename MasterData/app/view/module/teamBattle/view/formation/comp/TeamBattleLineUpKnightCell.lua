local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local TeamBattleLineUpKnightCell = class("TeamBattleLineUpKnightCell", require("app.fairyGUI.teamBattle.UI_TeamBattleLineUpKnightCell"))

function TeamBattleLineUpKnightCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_1.STAR_MAX
	})
	self.m_hpBar:setMax(100)
end

function TeamBattleLineUpKnightCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = g.core.model.User.teamBattleData:getFormationData()

	self.m_knightIcon:updateIcon({
		isFogNightPop = true,
		struct = arg_2_1
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_stageText:setText("")
	self.m_starComp:setStarNum(arg_2_1:getStarLv())
	self.m_qualityBg:setURL((var_0_0:getUserIconQualityStarBg(arg_2_1:getQuality())))

	local var_2_2 = var_2_0:isLineUpKnight(arg_2_1:getServerId())
	local var_2_3 = 100

	if arg_2_2.isTempGuard then
		var_2_2 = var_2_0:isInTempGuardMap(arg_2_1:getAdvanceId())
	else
		var_2_3 = arg_2_1:getHpPercent()
	end

	self.m_hpBar:setValue(var_2_3)

	local var_2_4 = 0

	if var_2_3 <= 0 then
		var_2_4 = 2
	elseif var_2_2 then
		var_2_4 = 1
	end

	self.m_stateController:setSelectedIndex(var_2_4)
end

return TeamBattleLineUpKnightCell
