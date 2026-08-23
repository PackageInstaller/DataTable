local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveBagData()
local GveBuffComp = class("GveBuffComp", require("app.fairyGUI.gve.UI_GveBuffComp"))

function GveBuffComp:ctor()
	var_0_1 = var_0_0:getGveBagData()
end

function GveBuffComp:updateByBuff(arg_2_1)
	local var_2_0 = var_0_1:getCfgBySkillType(arg_2_1.buffType)

	self.m_buffIcon:setURL("res/common/icon/halidom_resource/" .. var_2_0.main_skill_grid_icon .. ".png")

	local var_2_1 = 0

	if arg_2_1.buffType == 8 then
		var_2_1 = arg_2_1.buffNum * var_2_0.main_skill_param_2 < var_2_0.main_skill_param_3 and arg_2_1.buffNum or math.floor(var_2_0.main_skill_param_3 / var_2_0.main_skill_param_2)
	elseif arg_2_1.buffType == 9 then
		var_2_1 = math.min(arg_2_1.buffNum, var_2_0.main_skill_param_3)
	end

	self.m_buffNumTxt:setText(var_2_1)
end

return GveBuffComp
