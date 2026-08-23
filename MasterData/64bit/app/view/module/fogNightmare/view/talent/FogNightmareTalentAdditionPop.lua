local FogNightmareTalentAdditionPop = class("FogNightmareTalentAdditionPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareTalentAdditionPop"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		resName = "FogNightmareTalentAdditionPop",
		pkgPath = "ui/fogNightmare/fogNightmare"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareTalentAdditionPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curLv = arg_2_1.lv

	self:_initView()
	self.m_tipBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onShowTips))
	self:addClickListener(handler(self, self._onClickMyself))
end

function FogNightmareTalentAdditionPop:_initView()
	self.m_infoComp:updateView(self._curLv)
	self.m_txt:setText(g.core.lang:get(500193, {
		num = g.core.config.parameter_info.get(20052).parameter
	}))
	self.m_tipBubbleTxt:setText(g.core.lang:get(500194, {
		lv = var_0_1:getFogLevel(),
		lv2 = var_0_1:getFogTalentMaxLevel()
	}))
end

function FogNightmareTalentAdditionPop:_onShowTips(arg_4_1)
	arg_4_1:stopPropagation()
	self.m_showTipsController:setSelectedIndex(1)
end

function FogNightmareTalentAdditionPop:_onClickMyself()
	if self.m_showTipsController:getSelectedIndex() == 1 then
		self.m_showTipsController:setSelectedIndex(0)
	end
end

return FogNightmareTalentAdditionPop
