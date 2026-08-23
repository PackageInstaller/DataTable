local var_0_0 = require("app.view.module.sevenDaysSignIn.const.SevenDaysSignInConst").RECEIVE_STATE
local var_0_1 = {
	NORMAL = 0,
	BIG_AWARD = 1
}
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.sevenDaysSignInData
local var_0_4 = g.core.common.Path
local SevenDaysSignInCell = class("SevenDaysSignInCell", require("app.fairyGUI.sevenDaysSignIn.UI_SevenDaysSignInCell"))

function SevenDaysSignInCell:ctor()
	self._day = 1
	self._canReceiveStateSpine = nil

	self:_initView()
end

function SevenDaysSignInCell:_initView()
	self:addClickListener(handler(self, self._onClickIcon))
end

function SevenDaysSignInCell:_onClickIcon()
	local var_3_0 = var_0_3:getInfoWithDay(self._day)
	local var_3_1 = var_0_3:getState(self._day)

	if var_3_1 == var_0_0.CAN_RECEIVE then
		self:dispatchCompEvent("COMP_EVENT_GET_AWARD", var_3_0.id)
	elseif var_3_1 == var_0_0.NOT_RECEIVED or var_3_1 == var_0_0.RECEIVED then
		g.core.common.GlobalFunc.pushInfoPop({
			type = var_3_0.reward_type,
			value = var_3_0.reward_value,
			size = var_3_0.reward_size,
			component = self
		})
	end
end

function SevenDaysSignInCell:updateCell(arg_4_1)
	self._day = arg_4_1

	local var_4_0 = var_0_3:getInfoWithDay(arg_4_1)
	local var_4_1 = var_0_3:getState(arg_4_1)

	self.m_stateController:setSelectedIndex(var_4_1)
	self:_playCanReceiveStateAni(var_4_1 == var_0_0.CAN_RECEIVE)
	self.m_cellBgTypeController:setSelectedIndex(var_4_0.bg_type)
	self.m_dayWordLoader:setURL((self:_getDayUrl(arg_4_1, var_4_0.bg_type)))

	local var_4_2 = var_0_2:convert({
		type = var_4_0.reward_type,
		value = var_4_0.reward_value,
		size = var_4_0.reward_size
	})

	self.m_iconLoader:setURL(var_4_2.icon)

	local var_4_3, var_4_4 = var_0_4:getEquipIconQualityBg1(var_4_2.quality)

	self.m_qualityLineLoader_1:setURL(var_4_4)
	self.m_qualityLineLoader_2:setURL(var_4_4)
	self.m_numTxt:setText(g.core.lang:get(400501, {
		num = var_4_0.reward_size
	}))
	self.m_isTomorrowGetController:setSelectedIndex(var_0_3:isTomorrowCanGetAward(arg_4_1) and 1 or 0)
end

function SevenDaysSignInCell:_getDayUrl(arg_5_1, arg_5_2)
	local var_5_0 = var_0_3:dayToPhaseDay(arg_5_1)

	if arg_5_2 == var_0_1.BIG_AWARD then
		return "pic/sevenDaysSignIn/pic_7sign_num" .. var_5_0 .. "_1.png"
	else
		return "pic/sevenDaysSignIn/pic_7sign_num" .. var_5_0 .. ".png"
	end
end

function SevenDaysSignInCell:_playCanReceiveStateAni(arg_6_1)
	if arg_6_1 then
		self._canReceiveStateSpine = self._canReceiveStateSpine or self.m_effPick:addEffectSpine({
			remove = false,
			name = "eff_ui_activity_sdPick",
			isLoop = true
		})
	elseif self._canReceiveStateSpine then
		self._canReceiveStateSpine = false

		self.m_effPick:removeAllEffect()
	end
end

function SevenDaysSignInCell:playReceiveAni(arg_7_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SEVEN_DAYS_SIGN_IN_CLICK)
	self.m_effReceive:addEffectSpine({
		remove = true,
		name = "eff_ui_activity_sdReceive",
		isLoop = false,
		eventHandler = arg_7_1
	})
	self.m_receiveTransition:play()
end

return SevenDaysSignInCell
