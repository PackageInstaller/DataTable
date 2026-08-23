local UniteTokenSkillBottomComp = class("UniteTokenSkillBottomComp", require("app.fairyGUI.uniteToken.UI_UniteTokenSkillBottomComp"))
local var_0_1 = g.core.model.User.uniteTokenData
local UniteTokenConst = require("app.view.module.uniteToken.const.UniteTokenConst")
local var_0_3 = g.core.config.unite_token_info

function UniteTokenSkillBottomComp:ctor()
	return
end

function UniteTokenSkillBottomComp:updateComp(arg_2_1)
	self:updateView(arg_2_1)
end

function UniteTokenSkillBottomComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1:getBaseId()
	local var_3_1 = arg_3_1:getAdvanceId()
	local var_3_2 = var_0_3.get(var_3_0)
	local var_3_3 = var_0_1:getTokenStarInfo(var_3_1, (var_0_3.get((arg_3_1:getPreStarId()))))
	local var_3_4 = var_0_1:getTokenStarInfo(var_3_1, var_3_2)
	local var_3_5 = arg_3_1:getNextStarId() == 0

	for iter_3_0 = 1, UniteTokenConst.STAR_ATTR_NUM do
		local var_3_6 = not not var_3_3.attrList[iter_3_0]
		local var_3_7 = self["m_totalAttrComp" .. iter_3_0]

		self["m_totalAttrComp" .. iter_3_0]:setVisible(var_3_3.attrList[iter_3_0] and true or false)

		if var_3_6 then
			var_3_7:updateAttr({
				iconType = 2,
				name = var_3_3.attrList[iter_3_0].name,
				type = var_3_3.attrList[iter_3_0].type,
				value = var_3_4.attrList[iter_3_0].value
			})
		end
	end

	self.m_skillIcon:updateIcon(var_3_4.skillInfo)
	self.m_skillLevelTxt:setText("Lv." .. g.core.config.skill_info.get(var_3_2.skill_id).level)

	local var_3_8 = var_0_1:getTokenStarInfo(var_3_1, (var_0_3.get(var_3_0)))

	self.m_starComp:initStar({
		index = 4,
		style = 2,
		num = var_3_8.starNum,
		max = var_3_8.maxStarNum
	})

	local var_3_9 = var_0_1:getTokenPassiveInfo(var_3_1, arg_3_1:getStarLevel())

	if var_3_9 then
		self.m_passiveIcon:updateIcon(var_3_9)
		self.m_passiveLevel:setText("Lv." .. var_3_9.level)
		self.m_showPassiveController:setSelectedIndex(1)
	else
		self.m_showPassiveController:setSelectedIndex(0)
	end
end

return UniteTokenSkillBottomComp
