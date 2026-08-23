local SpireFloorTransformationPop = class("SpireFloorTransformationPop", require("app.fairyGUI.spire.UI_SpireFloorTransformationPop"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		resName = "SpireFloorTransformationPop"
	}, ...)
end)

function SpireFloorTransformationPop:ctor(arg_2_1, arg_2_2)
	self.m_nameTxt:setText(arg_2_1:getCfg().name)
	self.m_floorTxt:setText(g.core.lang:get(432025, {
		floor = arg_2_1:getCurFloor():getFloorId()
	}))

	self._callback = arg_2_2

	self:showAtCenter()
end

function SpireFloorTransformationPop:onLoad()
	self.m_enterTransition:play(handler(self, self._playBack))
	self.m_effComp:addEffectSpine({
		name = "eff_ui_spire_floorcurtain",
		isLoop = false,
		remove = true
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_04)
end

function SpireFloorTransformationPop:onUnload()
	if self._callback then
		self._callback()
	end
end

function SpireFloorTransformationPop:_playBack()
	self:newScheduleOnce(handler(self, function(arg_6_0)
		arg_6_0.m_backTransition:play(handler(arg_6_0, arg_6_0._closeSelf))
	end), 1)
end

function SpireFloorTransformationPop:_closeSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpireFloorTransformationPop
