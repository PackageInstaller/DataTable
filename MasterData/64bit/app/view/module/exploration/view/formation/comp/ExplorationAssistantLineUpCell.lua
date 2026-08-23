local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local ExplorationAssistantLineUpCell = class("ExplorationAssistantLineUpCell", require("app.fairyGUI.exploration.UI_ExplorationFormationRentLineUpCell"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/exploration/exploration",
		resName = "ExplorationFormationRentLineUpCell",
		pkgName = "exploration",
		isFullScreen = false
	}, ...)
end)

function ExplorationAssistantLineUpCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		index = 3,
		style = 1,
		num = 0,
		max = var_0_2.STAR_MAX
	})
end

function ExplorationAssistantLineUpCell:updateComp(arg_3_1)
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
	self.m_lineUpStateController:setSelectedIndex(var_0_0:getFormationData():isKnightUsedBySid(arg_3_1:getServerId()) and 1 or 0)
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1:getBaseInfo().classical))
end

return ExplorationAssistantLineUpCell
