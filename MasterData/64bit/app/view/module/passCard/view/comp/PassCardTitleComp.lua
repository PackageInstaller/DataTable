local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local PassCardTitleComp = class("PassCardTitleComp", require("app.fairyGUI.passCard.UI_PassCardTitleComp"))

function PassCardTitleComp:ctor()
	self._spine = nil
end

function PassCardTitleComp:init()
	local var_2_0 = var_0_1.passCardData:getCardBaseInfo()

	if var_2_0.baseInfo.title_name_pic ~= "" then
		self.m_titleNameLoader:setURL(var_0_0:getPassCardTitlePic(var_2_0.baseInfo.title_name_pic))
	end

	if var_2_0.baseInfo.title_big_pic ~= "" then
		self.m_titleLoader:setURL(var_0_0:getPassCardTitleBgPic(var_2_0.baseInfo.title_big_pic))
	end

	self.m_startTimeTxt:setText((g.core.common.ServerTime:getDateMDFormatWithDot(var_2_0.start_time)))

	self._endTimesStamp = var_2_0.start_time + var_2_0.baseInfo.continue_time * 24 * 60 * 60 - 1

	self.m_endTimeTxt:setText((g.core.common.ServerTime:getDateMDFormatWithDot(var_2_0.start_time + var_2_0.baseInfo.continue_time * 24 * 60 * 60 - 1)))
	self:_setTimeColor(var_2_0.baseInfo.colour)

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self:_addTitleSpine()

	self._countDownSchedule = self:newSchedule(handler(self, self._updateActivityCD), 1)
end

function PassCardTitleComp:updateTitleInfo()
	return
end

function PassCardTitleComp:checkTime()
	self:_updateActivityCD()
end

function PassCardTitleComp:_updateActivityCD()
	if self._endTimesStamp - g.core.common.ServerTime:getTime() <= 0 then
		if self._countDownSchedule then
			self:cancelSchedule(self._countDownSchedule)

			self._countDownSchedule = nil
		end

		self:dispatchCompEvent("passCard_activity_end")
	end
end

function PassCardTitleComp:_addTitleSpine()
	if self._spine then
		self._spine:removeFromParent()

		self._spine = nil
	end

	self._spine = self.m_titleEff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_passCard_title",
		anim = "play"
	})
end

function PassCardTitleComp:_setTimeColor(arg_7_1)
	if not arg_7_1 or arg_7_1 == "" then
		return
	end

	local var_7_0 = {}

	for iter_7_0 = 1, 3 do
		table.insert(var_7_0, tonumber(string.sub(arg_7_1, 2 * iter_7_0 - 1, 2 * iter_7_0), 16))
	end

	self.m_startTimeTxt:setColor(cc.c3b(var_7_0[1], var_7_0[2], var_7_0[3]))
	self.m_endTimeTxt:setColor(cc.c3b(var_7_0[1], var_7_0[2], var_7_0[3]))
	self.m_line:setColor(cc.c3b(var_7_0[1], var_7_0[2], var_7_0[3]))
end

return PassCardTitleComp
