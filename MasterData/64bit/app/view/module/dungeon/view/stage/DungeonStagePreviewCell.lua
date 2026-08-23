local var_0_0 = g.core.config.dungeon_stage_info
local var_0_1 = g.core.model.User.dungeonData
local var_0_2 = g.core.const.ConstMgr.DungeonConst
local DungeonStageBottomComp = class("DungeonStageBottomComp", require("app.fairyGUI.dungeon.UI_DungeonStagePreviewCell"))

DungeonStageBottomComp.ICONPATH = "ui://dungeon/pic_stage_"

function DungeonStageBottomComp:updateView(arg_1_1)
	local var_1_0 = var_0_1:getStage(arg_1_1)
	local var_1_1 = var_0_0.get(arg_1_1)

	self.m_icon:setURL(var_0_2.MONSTER_ICON_PATH .. var_1_1.quality)

	if var_1_0 and var_1_0:isPassed() then
		self.m_icon:setURL(var_0_2.MONSTER_ICON_PATH .. var_1_1.quality .. "_gray")
	end
end

return DungeonStageBottomComp
