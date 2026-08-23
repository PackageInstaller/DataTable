local RecruitPrimaryBgComp = class("RecruitPrimaryBgComp", require("app.fairyGUI.recruitKnight.UI_RecruitPrimaryBgComp"))

function RecruitPrimaryBgComp:ctor()
	self._rightOriginPos = self.m_rightKnightIcon:getPosition()
	self._temp = nil

	self.m_leftKnightIcon:updateKnight({
		resId = 500020,
		scale = 2
	})
	self.m_leftKnightIcon:updateColor()
end

function RecruitPrimaryBgComp:updateComp(arg_2_1)
	local var_2_0 = {
		scale = 2,
		isReverse = false,
		resId = arg_2_1
	}

	if not arg_2_1 then
		self.m_leftKnightIcon:setVisible(true)

		var_2_0.resId = 500080
	else
		self.m_leftKnightIcon:setVisible(false)
	end

	self.m_rightKnightIcon:updateKnight(var_2_0)
	self.m_leftKnightIcon:setOpacity(0)
	self.m_rightKnightIcon:setOpacity(0)
	self.m_leftKnightIcon:setOpacity(51)
	self.m_rightKnightIcon:setOpacity(51)
	self.m_leftKnightIcon:updateColor()
	self.m_rightKnightIcon:updateColor()
end

function RecruitPrimaryBgComp:playEffect()
	return
end

return RecruitPrimaryBgComp
