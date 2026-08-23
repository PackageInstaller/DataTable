local RecycleCultivateIncreaseSuccessComp = class("RecycleCultivateIncreaseSuccessComp", require("app.fairyGUI.recycleCultivate.UI_RecycleCultivateIncreaseSuccessComp"))

function RecycleCultivateIncreaseSuccessComp:update(arg_1_1)
	self.m_lastLevelText:setText(arg_1_1.lastInfo.stage)
	self.m_levelText:setText(arg_1_1.curInfo.stage)

	for iter_1_0 = 1, 4 do
		self["m_attrComp" .. iter_1_0]:updateAttr({
			type = arg_1_1.lastInfo["affect_type_" .. iter_1_0],
			value = arg_1_1.lastInfo["affect_value_" .. iter_1_0],
			value2 = arg_1_1.curInfo["affect_value_" .. iter_1_0]
		})
	end

	local var_1_0 = g.core.config.talent_skill_info.get(arg_1_1.curInfo.talent)

	self.m_talentNameTxt:setText(var_1_0.name)
	self.m_talentDescTxt:setText(var_1_0.description)
end

function RecycleCultivateIncreaseSuccessComp:playAnimate()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TB_ACTIVEWINDOW)
end

return RecycleCultivateIncreaseSuccessComp
