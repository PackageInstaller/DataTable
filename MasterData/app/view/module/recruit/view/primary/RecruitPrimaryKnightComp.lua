local RecruitPrimaryKnightComp = class("RecruitPrimaryKnightComp", require("app.fairyGUI.recruitKnight.UI_RecruitPrimaryKnightComp"))

function RecruitPrimaryKnightComp:ctor()
	self._orginMidPos = self.m_iconLoader:getPosition()

	self.m_leftIconLoader:setURL((g.core.common.Path:getRecruitShowKnightIconById("pic_zm_chulinlihui1_1")))
end

function RecruitPrimaryKnightComp:updateComp(arg_2_1)
	if not arg_2_1 then
		self.m_showDefaultController:setSelectedIndex(0)

		return
	end

	self.m_showDefaultController:setSelectedIndex(1)
	self.m_iconLoader:updateKnight({
		isReverse = false,
		resId = arg_2_1
	})
	self.m_iconLoader:setScale(0.8)
end

function RecruitPrimaryKnightComp:setIconAlpha(arg_3_1)
	self.m_iconLoader:setOpacity(arg_3_1)
end

function RecruitPrimaryKnightComp:playShow(arg_4_1)
	return
end

function RecruitPrimaryKnightComp:playHide()
	return
end

return RecruitPrimaryKnightComp
