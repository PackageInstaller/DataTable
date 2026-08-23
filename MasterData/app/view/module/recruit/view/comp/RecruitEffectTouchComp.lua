local RecruitEffectTouchComp = class("RecruitEffectTouchComp", require("app.fairyGUI.recruit.UI_RecruitEffectTouchComp"))

function RecruitEffectTouchComp:ctor()
	self._call = nil
	self._skipCall = nil
	self._showComp = nil

	self:_addListeners()
end

function RecruitEffectTouchComp:_addListeners()
	self.m_jumpBtn:addClickListener(handler(self, self._onSkipBtn))
end

function RecruitEffectTouchComp:_onSkipBtn()
	if not self._showComp then
		return
	end

	self._showComp:playHide()

	if self._skipCall then
		self._skipCall(self._param)
	end

	self:_playHide()
end

function RecruitEffectTouchComp:_onDoCall()
	if self._call ~= nil then
		self._call(self._param)
	end

	self._call = nil

	self:_playHide()
end

function RecruitEffectTouchComp:onLoad()
	self:setVisible(false)
	self:_playHide()
end

function RecruitEffectTouchComp:playShow(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if self._showComp then
		self._showComp:playHide()
	end

	local var_6_0 = self.m_effectRootNode:getChild(arg_6_1)

	if not var_6_0 then
		var_6_0 = fgui.UIPackage:createObject("recruit", arg_6_1)

		var_6_0:setName(arg_6_1)
		var_6_0:setSize(display.width, display.height)
		var_6_0:setCallBack(handler(self, self._onDoCall))
		self.m_effectRootNode:addChildWithListen(var_6_0)
	end

	var_6_0:playShow(arg_6_2)

	self._skipCall = arg_6_4
	self._call = arg_6_3
	self._param = arg_6_2
	self._showComp = var_6_0

	self:setVisible(true)
	self.m_jumpBtn:setVisible(not arg_6_5)
end

function RecruitEffectTouchComp:_playHide()
	if self._showComp then
		self._showComp:playHide()
	end

	self._showComp = nil

	self.m_jumpBtn:setVisible(false)
	self:newScheduleOnce(handler(self, self._hideSelf), 0.5)
end

function RecruitEffectTouchComp:_hideSelf()
	self:setVisible(false)
end

function RecruitEffectTouchComp:onUnload()
	self:setVisible(false)
end

return RecruitEffectTouchComp
