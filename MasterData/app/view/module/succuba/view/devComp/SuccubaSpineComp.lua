local var_0_0 = g.core.model.User.succubaData
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local SuccubaSpineComp = class("SuccubaSpineComp", require("app.fairyGUI.succuba.UI_SuccubaSpineComp"))

function SuccubaSpineComp:ctor()
	self:_initBtn()
end

function SuccubaSpineComp:_initBtn()
	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClick))
	self.m_showBtn:addClickListener(handler(self, self._onShowBtnClick))
end

function SuccubaSpineComp:updateComp(arg_3_1)
	if not arg_3_1 or not arg_3_1.advId then
		return
	end

	local var_3_0 = var_0_0:getSuccubaByAdvanceId(arg_3_1.advId)

	if not var_3_0 then
		return
	end

	self:updateSpineComp(var_3_0)
	self.m_nameComp:updateComp(var_3_0)
end

function SuccubaSpineComp:updateSpineComp(arg_4_1)
	self.m_spineHolder:removeChildren()

	self._drawSuccuba = DrawSuccuba.new({
		showCfg = arg_4_1:getShowCfg()
	})

	self.m_spineHolder:addChild(self._drawSuccuba)
end

function SuccubaSpineComp:_onLeftBtnClick()
	self.m_left_inTransition:play()
	self:dispatchCompEvent("SUCCUBA_DEV_LEFT_BTN_CLICK")
end

function SuccubaSpineComp:_onRightBtnClick()
	self.m_right_inTransition:play()
	self:dispatchCompEvent("SUCCUBA_DEV_RIGHT_BTN_CLICK")
end

function SuccubaSpineComp:_onShowBtnClick()
	self:dispatchCompEvent("SUCCUBA_DEV_SHOW_BTN_CLICK")
end

return SuccubaSpineComp
