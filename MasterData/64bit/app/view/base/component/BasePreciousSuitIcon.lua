local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_1 = g.core.model.User.preciousData
local BasePreciousSuitIcon = class("BasePreciousSuitIcon", require("app.fairyGUI.base_new.UI_BasePreciousSuitIcon"))

function BasePreciousSuitIcon:ctor()
	self._pos = 0
	self._id = 0

	self.m_starComp:initStar({
		gap = -5,
		index = 3,
		num = 0,
		style = 2,
		max = var_0_0.STAR_MAX_NUM
	})
end

function BasePreciousSuitIcon:updateSuitIcon(arg_2_1, arg_2_2, arg_2_3)
	self._pos = arg_2_1
	self._id = arg_2_2

	local var_2_0 = var_0_1:getSuitByGroupId(arg_2_2)

	if self._id > 0 and var_2_0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_skillIcon:updateIcon({
			isPassive = true,
			skillId = var_2_0:getCfg().passive_skill_id
		})
		self.m_starComp:setStarNum(var_2_0:getStar())
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_isOtherController:setSelectedIndex(0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = arg_2_1,
			hasRed = arg_2_3 == true
		}
	})
end

function BasePreciousSuitIcon:updateOtherSuitIcon(arg_3_1)
	if arg_3_1 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_skillIcon:updateIcon({
			isPassive = true,
			skillId = arg_3_1:getCfg().passive_skill_id
		})
		self.m_starComp:setStarNum(arg_3_1:getStar())
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_isOtherController:setSelectedIndex(1)
	self.m_skillIcon:setTouchable(false)
end

function BasePreciousSuitIcon:isEmpty()
	return self._id <= 0
end

function BasePreciousSuitIcon:onDragStart()
	self.m_isEmptyController:setSelectedIndex(1)
end

function BasePreciousSuitIcon:getStationPos()
	return self._pos
end

function BasePreciousSuitIcon:getId()
	return self._id
end

function BasePreciousSuitIcon:becomeTo(arg_8_1)
	self:updateSuitIcon(arg_8_1:getStationPos(), arg_8_1:getId())
end

return BasePreciousSuitIcon
