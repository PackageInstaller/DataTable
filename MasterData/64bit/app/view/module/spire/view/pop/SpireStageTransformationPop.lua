local SpireStageTransformationPop = class("SpireStageTransformationPop", require("app.fairyGUI.spire.UI_SpireStageTransformationPop"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		resName = "SpireStageTransformationPop"
	}, ...)
end)

function SpireStageTransformationPop:ctor(arg_2_1, arg_2_2)
	self.m_stageTxt:setText(g.core.lang:get(432026, {
		floor = arg_2_1.floor,
		stage = arg_2_1.stage
	}))

	self._callback = arg_2_2

	local var_2_0 = self.m_preTxt:getSize()

	var_2_0.width = var_2_0.width + self.m_stageTxt:getSize().width

	local var_2_1 = (self:getView():getSize().width - var_2_0.width) / 2
	local var_2_2 = self.m_preTxt:getPosition()

	var_2_2.x = var_2_1

	self.m_preTxt:setPosition(var_2_2)

	local var_2_3 = self.m_stageTxt:getPosition()

	var_2_3.x = var_2_1 + self.m_preTxt:getSize().width

	self.m_stageTxt:setPosition(var_2_3)
	self:showAtCenter()
end

function SpireStageTransformationPop:onLoad()
	self.m_enterTransition:play(handler(self, self._playBack))
	self.m_effComp:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_spire_levelcurtain"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_02)
end

function SpireStageTransformationPop:onUnload()
	if self._callback then
		self._callback()
	end
end

function SpireStageTransformationPop:_playBack()
	self:newScheduleOnce(handler(self, function(arg_6_0)
		arg_6_0.m_backTransition:play(handler(arg_6_0, arg_6_0._closeSelf))
	end), 1)
end

function SpireStageTransformationPop:_closeSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpireStageTransformationPop
