local CommonAnimateConst = require("app.view.common.const.CommonAnimateConst")
local BaseInfoPop = class("BaseInfoPop", require("app.fairyGUI.base_new.UI_BaseInfoPop"))

function BaseInfoPop:ctor()
	self._parentTrans = nil
	self._endCallBack = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	self.m_openTransition:play(handler(self, self._playParentAnim))
	self:checkEnterAnimPlay()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))
end

function BaseInfoPop:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function BaseInfoPop:checkEnterAnimPlay()
	local var_3_0 = self:getParent()

	for iter_3_0, iter_3_1 in pairs(CommonAnimateConst) do
		if var_3_0:getChild(iter_3_0) then
			var_3_0:getSharedTrans(iter_3_1.enterName, iter_3_1.compName):play()

			break
		end
	end
end

function BaseInfoPop:setEndAnim(arg_4_1)
	self.m_parentTrans = arg_4_1
end

function BaseInfoPop:setEndCallBack(arg_5_1)
	self._endCallBack = arg_5_1
end

function BaseInfoPop:_playParentAnim()
	if self._endCallBack then
		self._endCallBack()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	elseif self.m_parentTrans then
		self.m_parentTrans:play(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

			self._waitState = false
		end)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	end
end

function BaseInfoPop:getCloseTransition()
	return self.m_closeTransition
end

function BaseInfoPop:exitAnim()
	self.m_closeTransition:play()
end

function BaseInfoPop:onUnload()
	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	end
end

return BaseInfoPop
