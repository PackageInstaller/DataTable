local CommonAnimateConst = require("app.view.common.const.CommonAnimateConst")
local BasePop = class("BasePop", require("app.fairyGUI.base_new.UI_BasePop"))

function BasePop:ctor()
	self._parentTrans = nil
	self._endCallBack = nil
	self._parentContent = nil

	self.m_openTransition:play(handler(self, self._playParentAnim))
	self:checkEnterAnimPlay()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))

	self.m_helpBtn = self:getChild("help")

	if self.m_helpBtn then
		self.m_helpBtn:addClickListener(handler(self, self._onHelp))
	end
end

function BasePop:setTitleName(arg_2_1)
	self:setTitle(arg_2_1)

	local var_2_0 = self:getChild("leftTitle")

	if var_2_0 then
		var_2_0:setText(arg_2_1)
	end
end

function BasePop:setCloseBtnShow(arg_3_1)
	self.m_closeBtn:setVisible(arg_3_1)
end

function BasePop:checkEnterAnimPlay()
	local var_4_0 = self:getParent()

	for iter_4_0, iter_4_1 in pairs(CommonAnimateConst) do
		if var_4_0:getChild(iter_4_0) then
			var_4_0:getSharedTrans(iter_4_1.enterName, iter_4_1.compName):play()
		end
	end
end

function BasePop:setEndAnim(arg_5_1)
	self.m_parentTrans = arg_5_1
end

function BasePop:setEndCallBack(arg_6_1)
	self._endCallBack = arg_6_1
end

function BasePop:_playParentAnim()
	if self._parentContent then
		self._parentContent:setVisible(true)
	end

	if self._endCallBack then
		self._endCallBack()
	elseif self.m_parentTrans then
		self.m_parentTrans:play()
	end
end

function BasePop:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function BasePop:setHelpId(arg_9_1)
	self._helpId = arg_9_1
end

function BasePop:_onHelp()
	if self._helpId and self._helpId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = self._helpId
		}), {
			touchDisappear = true
		})
	end
end

return BasePop
