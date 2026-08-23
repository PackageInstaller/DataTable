local ActivityRerunAreaComp = class("ActivityRerunAreaComp", require("app.fairyGUI.activityReturn.UI_ActivityRerunAreaComp"))

function ActivityRerunAreaComp:ctor()
	self._areaCompList = {
		self.m_r,
		self.m_sr,
		self.m_ssr
	}
	self._areaList = {
		1,
		2,
		3
	}
end

function ActivityRerunAreaComp:updateComp(arg_2_1)
	local var_2_0 = self:getSize()

	var_2_0.width = arg_2_1.width_r + 8

	self.m_r:setSize(var_2_0)

	self._areaList[1] = {
		0,
		arg_2_1.width_r
	}

	local var_2_1 = self.m_r:getPosition()

	var_2_1.x = var_2_1.x + var_2_0.width - 8

	self.m_ssr:setPosition(var_2_1)

	var_2_0.width = arg_2_1.width_ssr + 8

	self.m_ssr:setSize(var_2_0)

	self._areaList[3] = {
		arg_2_1.width_r,
		arg_2_1.width_r + arg_2_1.width_ssr
	}
	var_2_1.x = var_2_1.x + var_2_0.width - 8

	self.m_sr:setPosition(var_2_1)

	var_2_0.width = arg_2_1.width_sr + 8

	self.m_sr:setSize(var_2_0)

	self._areaList[2] = {
		arg_2_1.width_r + arg_2_1.width_ssr,
		arg_2_1.width_r + arg_2_1.width_ssr + arg_2_1.width_sr
	}
end

function ActivityRerunAreaComp:_getRandomInterNumber(arg_3_1, arg_3_2)
	local var_3_0 = math.random(arg_3_1, arg_3_2)
	local var_3_1 = 1

	if var_3_0 < 0 then
		var_3_1 = -1
	end

	local var_3_2 = math.abs(var_3_0)

	var_3_2 = var_3_2 % 1 >= 0.5 and math.ceil(var_3_2) or math.floor(var_3_2)

	return var_3_2 * var_3_1
end

function ActivityRerunAreaComp:getRandomAreaPosByQuality(arg_4_1)
	self:getPosition()

	local var_4_0 = self._areaCompList[arg_4_1]:getPosition()

	var_4_0.y = self:getPosition().y
	var_4_0.x = self:_getRandomInterNumber(math.max(32, var_4_0.x), self._areaCompList[arg_4_1]:getSize().width - 8)

	return var_4_0
end

function ActivityRerunAreaComp:isEnterQualityArea(arg_5_1, arg_5_2)
	return arg_5_1.x >= self._areaList[arg_5_2][1] and arg_5_1.x <= self._areaList[arg_5_2][2]
end

function ActivityRerunAreaComp:onContactBall(arg_6_1, arg_6_2, arg_6_3)
	self.m_effBall:addEffectSpine({
		name = "eff_ui_activityReturn_rewardBall",
		remove = true,
		isLoop = false,
		anim = ({
			"r",
			"sr",
			"ssr"
		})[arg_6_2],
		x = arg_6_1.x,
		y = self:getSize().height / 2
	})

	if arg_6_2 == 3 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_GOLDEN_PRIZE)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_BLUE_PURPLE_PRIZE)
	end

	if arg_6_3 then
		self:newScheduleOnce(arg_6_3, 1)
	end
end

return ActivityRerunAreaComp
