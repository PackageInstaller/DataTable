local var_0_0 = g.core.config.passive_skill_info
local var_0_1 = g.core.config.talent_skill_info
local var_0_3 = g.core.model.User.succubaData
local SuccubaAdvSuccessPopComp = class("SuccubaAdvSuccessPopComp", require("app.fairyGUI.succuba.UI_SuccubaAdvSuccessPopComp"))

function SuccubaAdvSuccessPopComp:update(arg_1_1)
	local var_1_0 = var_0_3:getSuccubaBySid(arg_1_1.sid)

	if not var_1_0 then
		return
	end

	local var_1_1 = var_1_0:getStage()

	self.m_levelTxt:setText(var_1_1)
	self.m_lastLevelTxt:setText((math.max(0, var_1_1 - 1)))
	self.m_talentDescTxt:setText(var_0_1.get(arg_1_1.curAdvInfo.talent_skill).description)

	if arg_1_1.curAdvInfo.skill_id > 0 then
		self.m_passiveNameLbl:setTitle(var_0_0.get(arg_1_1.curAdvInfo.skill_id).name)
		self.m_passiveDescVerScrollLbl:getChild("title"):enableRich()
		self.m_passiveDescVerScrollLbl:setTitle((g.core.utils.String.formatPassiveSkillDesc(arg_1_1.curAdvInfo.skill_id)))
		self.m_passiveChangeController:setSelectedIndex(1)
	else
		self.m_passiveChangeController:setSelectedIndex(0)
	end

	if arg_1_1.showCharmData then
		self.m_charmComp:setVisible(true)
		self.m_charmComp:updateAttr(arg_1_1.showCharmData)
	else
		self.m_charmComp:setVisible(false)
	end

	self.m_enterTransition:play()
end

return SuccubaAdvSuccessPopComp
