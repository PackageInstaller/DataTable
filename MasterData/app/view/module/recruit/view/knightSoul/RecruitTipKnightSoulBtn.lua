local DrawKnight = require("app.view.common.DrawKnight")
local RecruitTipKnightSoulBtn = class("RecruitTipKnightSoulBtn", require("app.fairyGUI.recruitKnightSoul.UI_RecruitTipKnightSoulBtn"))

function RecruitTipKnightSoulBtn:ctor()
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._info = nil

	self:addClickListener(handler(self, self._onClickSearchBtn))
end

function RecruitTipKnightSoulBtn:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_KNIGHT_SOUL,
		value = arg_2_1.knight_id
	})

	self:setIcon((g.core.common.Path:getRecruitShowKnightSoulIconById(arg_2_1.knight_id)))

	if arg_2_3 then
		self.m_icon:setPosition(cc.p(self._midPos.x + arg_2_1.x, self._midPos.y + arg_2_1.y))
	end
end

function RecruitTipKnightSoulBtn:updateCompByKnightId(arg_3_1)
	return
end

function RecruitTipKnightSoulBtn:_onPressTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitTipKnightSoulBtn:_onPressTouchEnd(arg_5_1)
	self:_onClickSearchBtn()
end

function RecruitTipKnightSoulBtn:_onClickSearchBtn()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

return RecruitTipKnightSoulBtn
