local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local FogNightAssistantLineUpCell = class("FogNightAssistantLineUpCell", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantLineUpCell"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		isFullScreen = false,
		resName = "FogNightAssistantLineUpCell",
		pkgPath = "ui/fogNightmare/fogNightmare"
	}, ...)
end)

function FogNightAssistantLineUpCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		style = 1,
		num = 0,
		gap = 0,
		index = 3,
		max = var_0_2.STAR_MAX
	})
end

function FogNightAssistantLineUpCell:updateComp(arg_3_1)
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
	self.m_lineUpStateController:setSelectedIndex(var_0_0:getAssistantData():isUseKnightById(arg_3_1:getServerId()) and 1 or 0)
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1:getBaseInfo().classical))
	self.m_leaderLoader:setVisible(arg_3_1:isElementLeader())
end

return FogNightAssistantLineUpCell
