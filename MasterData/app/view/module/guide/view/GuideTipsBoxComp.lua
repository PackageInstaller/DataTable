local GuideTipsBoxComp = class("GuideTipsBoxComp", require("app.fairyGUI.guide.UI_GuideTipsBoxComp"))
local var_0_1 = {
	[0] = {
		loop = "m_rectLoopTransition",
		once = "m_rectOnceTransition"
	},
	{
		loop = "m_circleLoopTransition",
		once = "m_circleOnceTransition"
	},
	{
		loop = "m_sixLoopTransition",
		once = "m_sixOnceTransition"
	},
	{
		loop = "m_circleLoopTransition",
		once = "m_circleOnceTransition"
	}
}

function GuideTipsBoxComp:setScaleAsSize(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if arg_1_3 == 1 then
		if arg_1_4 then
			self:setScale(arg_1_4)
		else
			self:setScale(0.8)
		end
	end

	arg_1_1 = arg_1_1 or 1
	arg_1_2 = arg_1_2 or 1

	local var_1_0 = self:getSize()

	self:setSize((var_1_0.width + 30) * arg_1_1, (var_1_0.height + 30) * arg_1_2)
	self.m_typeController:setSelectedIndex(arg_1_3)
	self:playOnce()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_BOX_SELECTION)
end

function GuideTipsBoxComp:playLoop()
	self[var_0_1[self.m_typeController:getSelectedIndex()].loop]:play()
end

function GuideTipsBoxComp:playOnce()
	self[var_0_1[self.m_typeController:getSelectedIndex()].once]:play(handler(self, self.playLoop))
end

return GuideTipsBoxComp
