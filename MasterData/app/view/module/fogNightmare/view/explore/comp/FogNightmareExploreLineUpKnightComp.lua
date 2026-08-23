local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.model.User.fogNightmareData
local FogNightmareExploreLineUpKnightComp = class("FogNightmareExploreLineUpKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLineUpKnightComp"))

function FogNightmareExploreLineUpKnightComp:ctor()
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

function FogNightmareExploreLineUpKnightComp:updateComp(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2 or {}

	self.m_knightIcon:updateIcon({
		isFogNightPop = true,
		struct = arg_2_1
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_stageText:setText("")
	self.m_starComp:setStarNum(arg_2_1:getStarLv())
	self.m_qualityBg:setURL((var_0_0:getUserIconQualityStarBg(arg_2_1:getQuality())))

	local var_2_1 = arg_2_1:getHpPercent()

	self.m_hpBar:setValue(var_2_1)
	self.m_hpBar:setVisible(var_2_0.isFormationPop)

	local var_2_2 = 0

	if var_2_1 <= 0 then
		var_2_2 = 2
	elseif arg_2_1:isLineup() or arg_2_1:getTempFormationPos() > 0 then
		var_2_2 = 1
	end

	self.m_stateController:setSelectedIndex(var_2_2)
	self.m_isUseController:setSelectedIndex(var_0_2:getFormationData():isUsedKnight(arg_2_1:getServerId()) and 1 or 0)
end

return FogNightmareExploreLineUpKnightComp
