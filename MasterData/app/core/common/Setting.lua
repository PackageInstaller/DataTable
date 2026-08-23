local Setting = class("Setting")

Setting.FUNC_BGM = "FUNC_BGM"
Setting.FUNC_SOUND = "FUNC_SOUND"
Setting.FUNC_BGM_VOLUME = "FUNC_BGM_VOLUME"
Setting.FUNC_SOUND_VOLUME = "FUNC_SOUND_VOLUME"
Setting.FUNC_VOICE_VOLUME = "FUNC_VOICE_VOLUME"
Setting.FUNC_GIFT = "FUNC_GIFT"
Setting.FUNC_NOTICE = "FUNC_NOTICE"
Setting.FUNC_BIND_PHONE = "FUNC_BIND_PHONE"
Setting.FUNC_QUALITY = "FUNC_QUALITY"
Setting.FUNC_PUSH = "FUNC_PUSH"
Setting.FUNC_PUSH_VIT = "FUNC_PUSH_VIT"
Setting.FUNC_PUSH_FOOD = "FUNC_PUSH_FOOD"
Setting.FUNC_PUSH_STORM = "FUNC_PUSH_STORM"
Setting.FUNC_PUSH_MINE = "FUNC_PUSH_MINE"
Setting.FUNC_PRIV = "FUNC_PRIV"
Setting.JUMP_CG = "JUMP_CG"
Setting.SKIP_CG = "SKIP_CG"
Setting.JUMP_SKILL_ENTRANCE = "JUMP_SKILL_ENTRANCE"
Setting.SKIP_TWEEN = "SKIP_TWEEN"
Setting.ACCEPT_BIO_TEAM_INVITE = "ACCEPT_BIO_TEAM_INVITE"
Setting.FUNC_BGM_SWITCH = "FUNC_BGM_SWITCH"
Setting.FUNC_SOUND_SWITCH = "FUNC_SOUND_SWITCH"
Setting.FUNC_VOICE_SWITCH = "FUNC_VOICE_SWITCH"
Setting.INIT_QUALITY = "INIT_QUALITY"
Setting.FUNC_FPS = "FUNC_FPS"
Setting.FUNC_AUTO_SET_FPS = "FUNC_AUTO_SET_FPS"

function Setting:ctor()
	self:reset()
	self:_onSetConfigChanged()
end

function Setting:reset()
	self._popTips = nil
	self._qualityConfig = {}
	self._openViewPlayer = true

	local var_2_0 = self:_load("setting.json", false)

	if next(var_2_0) then
		self._setConfig = var_2_0

		if not self._setConfig[Setting.INIT_QUALITY] and self._setConfig[Setting.FUNC_BGM] and self._setConfig[Setting.FUNC_SOUND] then
			self._setConfig[Setting.FUNC_BGM_SWITCH] = true
			self._setConfig[Setting.FUNC_SOUND_SWITCH] = true
			self._setConfig[Setting.FUNC_VOICE_SWITCH] = true
			self._setConfig[Setting.INIT_QUALITY] = true
		end
	else
		self._setConfig = {
			[Setting.FUNC_BGM] = true,
			[Setting.FUNC_SOUND] = true,
			[Setting.FUNC_PUSH] = true,
			[Setting.FUNC_PUSH_VIT] = true,
			[Setting.FUNC_PUSH_FOOD] = true,
			[Setting.FUNC_PUSH_STORM] = true,
			[Setting.FUNC_PUSH_MINE] = true,
			[Setting.JUMP_CG] = false,
			[Setting.JUMP_SKILL_ENTRANCE] = false,
			[Setting.SKIP_CG] = 0,
			[Setting.SKIP_TWEEN] = 0,
			[Setting.ACCEPT_BIO_TEAM_INVITE] = true,
			[Setting.FUNC_BGM_SWITCH] = true,
			[Setting.FUNC_SOUND_SWITCH] = true,
			[Setting.FUNC_VOICE_SWITCH] = true,
			[Setting.INIT_QUALITY] = false,
			[Setting.FUNC_FPS] = 0,
			[Setting.FUNC_AUTO_SET_FPS] = true
		}
	end
end

function Setting:_onSetConfigChanged(arg_3_1, arg_3_2)
	if arg_3_1 and arg_3_1 == Setting.FUNC_QUALITY then
		g.core.common.DeviceCheck.CUR_LEVEL = arg_3_2
	end
end

function Setting:set(arg_4_1, arg_4_2)
	self._setConfig = self._setConfig or self:_load("setting.json", false)

	if self._setConfig[arg_4_1] == arg_4_2 then
		return
	end

	self._setConfig[arg_4_1] = arg_4_2

	self:_save("setting.json", self._setConfig, false)
	self:_onSetConfigChanged(arg_4_1, arg_4_2)
end

function Setting:get(arg_5_1)
	self._setConfig = self._setConfig or self:_load("setting.json", false)

	if arg_5_1 == Setting.FUNC_QUALITY then
		return self._setConfig[arg_5_1]
	end

	return checkbool(self._setConfig[arg_5_1])
end

function Setting:getValue(arg_6_1)
	self._setConfig = self._setConfig or self:_load("setting.json", false)

	return self._setConfig[arg_6_1]
end

function Setting:setPopTipFlag(arg_7_1, arg_7_2)
	self._popTips = self._popTips or self:_load("common_poptips.json", true)
	self._popTips[arg_7_1] = arg_7_2 and g.core.common.ServerTime:getTime() or nil

	self:_save("common_poptips.json", self._popTips, true)
end

function Setting:getPopTipFlag(arg_8_1)
	self._popTips = self._popTips or self:_load("common_poptips.json", true)

	if not self._popTips[arg_8_1] then
		return false
	end

	return g.core.common.ServerTime:isToday(self._popTips[arg_8_1])
end

function Setting:loadQualityConfig()
	self._qualityConfig = self:_load("quality.json", true)

	if not self._qualityConfig or not next(self._qualityConfig) then
		g.core.common.DeviceCheck.CUR_LEVEL = g.core.common.DeviceCheck.getDevicePerformanceLv()
		self._qualityConfig = {
			level = g.core.common.DeviceCheck.CUR_LEVEL
		}

		self:_save("quality.json", self._qualityConfig, true)
	end

	self:_onQualityLevelChanged()
end

function Setting:getQualityConfig()
	return self._qualityConfig.level or 0
end

function Setting:getSkipCGConfig()
	return self._qualityConfig.level or 0
end

function Setting:setQualityLevel(arg_12_1)
	self._qualityConfig.level = arg_12_1

	self:_onQualityLevelChanged()
	self:_save("quality.json", self._qualityConfig, true)
end

function Setting:_onQualityLevelChanged()
	g.core.common.DeviceCheck.CUR_LEVEL = self._qualityConfig.level

	g.core.utils.Sdk.changeDevicePerformance()
end

function Setting:isCGFirstData(arg_14_1)
	self._CGFirstData = self._CGFirstData or self:_load("CGFirstData.json", true)

	if not g.core.common.ServerTime:isToday(self._CGFirstData.curTime or 0) then
		self._CGFirstData = {}
		self._CGFirstData.curTime = g.core.common.ServerTime:getTime()
	end

	if self._CGFirstData[arg_14_1] then
		return false
	else
		return true
	end
end

function Setting:setCGFirstData(arg_15_1)
	if self._CGFirstData then
		self._CGFirstData[arg_15_1] = true
	end
end

function Setting:isTweenFirstData(arg_16_1)
	self._tweenFirstData = self._tweenFirstData or self:_load("TweenFirstData.json", true)

	if not g.core.common.ServerTime:isToday(self._tweenFirstData.curTime or 0) then
		self._tweenFirstData = {}
		self._tweenFirstData.curTime = g.core.common.ServerTime:getTime()
	end

	if self._tweenFirstData[arg_16_1] then
		return false
	else
		self._tweenFirstData[arg_16_1] = true

		return true
	end
end

function Setting:saveFirstData()
	if self._CGFirstData then
		self:_save("CGFirstData.json", self._CGFirstData, true)
	end

	if self._tweenFirstData then
		self:_save("TweenFirstData.json", self._tweenFirstData, true)
	end
end

function Setting:_save(arg_18_1)
	if not self._setConfig then
		return
	end

	g.core.common.Storage:save(arg_18_1, ...)
end

function Setting:_load(arg_19_1)
	return g.core.common.Storage:load(arg_19_1, ...) or {}
end

function Setting:setViewPlayerStatue(arg_20_1)
	if arg_20_1.config and arg_20_1.config.detail_view_notify then
		self._openViewPlayer = arg_20_1.config.detail_view_notify == 0
	end
end

function Setting:getViewPlayerOpen()
	return self._openViewPlayer
end

return Setting
