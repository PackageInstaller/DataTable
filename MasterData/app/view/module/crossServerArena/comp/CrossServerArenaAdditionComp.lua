local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaAdditionComp = class("CrossServerArenaAdditionComp", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaAdditionComp"))

function CrossServerArenaAdditionComp:ctor()
	return
end

function CrossServerArenaAdditionComp:playShow(arg_2_1)
	self.m_efficiencyTxt:setText(g.core.lang:get(411034, {
		num = arg_2_1
	}))
	self:newScheduleOnce(handler(self, self.hideShow), var_0_0.DELAY_ADDITION)
end

function CrossServerArenaAdditionComp:hideShow()
	self:setVisible(false)
end

return CrossServerArenaAdditionComp
