local var_0_0 = g.core.model.User.preciousData
local PreciousAdvanceUpSuccessComp = class("PreciousAdvanceUpSuccessComp", require("app.fairyGUI.precious.UI_PreciousAdvanceUpSuccessComp"))

function PreciousAdvanceUpSuccessComp:update(arg_1_1)
	local var_1_0 = var_0_0:getPreciousByAdvId(arg_1_1.id)
	local var_1_1 = var_1_0:getUpgradeInfo().stage

	self.m_levelText:setText(var_1_1)
	self.m_lastLevelText:setText(math.max(var_1_1 - 1, 0))

	local var_1_2 = g.core.config.talent_skill_info.get(var_1_0:getUpgradeInfo().talent_skill_id)

	self.m_talentNameTxt:setText(var_1_2.name)
	self.m_talentDescTxt:setText(var_1_2.description)
end

function PreciousAdvanceUpSuccessComp:playAnimate()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TB_ACTIVEWINDOW)
end

return PreciousAdvanceUpSuccessComp
