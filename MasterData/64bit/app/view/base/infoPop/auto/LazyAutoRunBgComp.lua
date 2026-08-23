local var_0_0 = g.core.const.ConstMgr.InfoConst.AUTO_TYPE
local var_0_1 = g.core.model.User.wushData
local LazyAutoRunBgComp = class("LazyAutoRunBgComp", require("app.fairyGUI.infoPop.UI_LazyAutoRunBgComp"))

function LazyAutoRunBgComp:ctor()
	self._clickCb = nil

	self.m_stopBtn:addClickListener(handler(self, self._onStopClick))
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		isLoop = true,
		remove = false,
		name = "eff_ui_infoPop_autorunbg"
	})
end

function LazyAutoRunBgComp:_onStopClick()
	if self._clickCb then
		self._clickCb()
	end
end

function LazyAutoRunBgComp:updateAutoState(arg_3_1)
	if arg_3_1.clickStopFunc then
		self._clickCb = arg_3_1.clickStopFunc
	end

	if var_0_0.WUSH == arg_3_1.aType then
		local var_3_0 = var_0_1:getCurFloorId() or 1

		self.m_levelTxt:setText(g.core.lang:get(303042, {
			floor = var_3_0
		}))
	elseif var_0_0.BIO == arg_3_1.aType then
		self.m_levelTxt:setText(g.core.lang:get(2801))
	elseif var_0_0.DUNGEON == arg_3_1.aType then
		self.m_levelTxt:setText(g.core.lang:get(2800))
	end
end

return LazyAutoRunBgComp
