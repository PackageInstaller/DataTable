local var_0_0 = g.core.model.User.outpostData
local OutpostSpeedPop = class("OutpostSpeedPop", require("app.fairyGUI.outpost.UI_OutpostSpeedPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostSpeedPop",
		pkgName = "outpost",
		isFullScreen = false
	}, ...)
end)

function OutpostSpeedPop:ctor()
	self:showAtCenter()
	self:initView()
	self.m_enterTransition:play()
end

function OutpostSpeedPop:initView()
	self.m_speedBtn:addClickListener(handler(self, self._onClickSpeedCheck))
	self.m_touchComp:addClickListener(handler(self, self._onClickClose))
end

function OutpostSpeedPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "slider_speed_change_ing" then
		self.m_speedBtn:setSelected(false)

		return true
	elseif arg_4_1 == "slider_speed_change_end" then
		self.m_speedBtn:setSelected(var_0_0:isSpeedOn())

		return true
	end
end

function OutpostSpeedPop:onLoad()
	self.m_battleSpeed:updateView()
	self.m_speedBtn:setSelected(var_0_0:isSpeedOn())
	self:updateSpeedBtnEffect()
end

function OutpostSpeedPop:_onClickSpeedCheck()
	self:updateSpeedBtnEffect()
	var_0_0:setSpeed(nil, (self.m_speedBtn:isSelected()))
end

function OutpostSpeedPop:updateSpeedBtnEffect()
	if self.m_speedBtn:isSelected() then
		self.m_speedBtn:getChild("effectPlace"):removeAllEffect()
	else
		self.m_speedBtn:getChild("effectPlace"):addEffectSpine({
			anim = "start",
			name = "eff_ui_spiritHelp_mainLayer",
			isLoop = true
		})
	end
end

function OutpostSpeedPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function OutpostSpeedPop:onRemoved()
	if var_0_0:isSpeedOn() then
		cc.Director:getInstance():getScheduler():setTimeScale(var_0_0:getSpeed())
	else
		cc.Director:getInstance():getScheduler():setTimeScale(1)
	end

	var_0_0:saveSpeedJsonData()
end

return OutpostSpeedPop
