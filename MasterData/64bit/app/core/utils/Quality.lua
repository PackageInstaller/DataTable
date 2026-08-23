return {
	getGaussianBlurParam = function()
		local var_1_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_1_0 == 0 then
			return 10, 3
		elseif var_1_0 == 1 then
			return 12, 5
		else
			return 16, 8
		end
	end,
	needCloseBackAction = function()
		local var_2_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_2_0 == 0 then
			return true
		elseif var_2_0 == 1 then
			return true
		else
			return false
		end
	end,
	needCloseWeather = function()
		local var_3_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_3_0 == 0 then
			return true
		elseif var_3_0 == 1 then
			return true
		else
			return false
		end
	end,
	needCloseUIAnime = function()
		local var_4_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_4_0 == 0 then
			return true
		elseif var_4_0 == 1 then
			return true
		else
			return false
		end
	end,
	needCloseParallaxEffect = function()
		local var_5_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_5_0 == 0 then
			return false
		elseif var_5_0 == 1 then
			return false
		else
			return false
		end
	end,
	needStopKnightSpine = function()
		local var_6_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_6_0 == 0 then
			return false
		elseif var_6_0 == 1 then
			return false
		else
			return false
		end
	end,
	needStopUniteTokenSpine = function()
		local var_7_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_7_0 == 0 then
			return false
		elseif var_7_0 == 1 then
			return false
		else
			return false
		end
	end,
	needUnLoadSoundBank = function()
		local var_8_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_8_0 == 0 then
			return false
		elseif var_8_0 == 1 then
			return false
		else
			return false
		end
	end,
	needSkipCriSprite = function()
		if g.core.utils.Sdk.getDevicePerformLevel() then
			return false
		end
	end,
	needIgnoreBattleCache = function()
		local var_10_0 = g.core.resource.ResourceManager:getDeviceRealQuality()

		if var_10_0 == 0 then
			return true
		elseif var_10_0 == 1 then
			return true
		else
			return false
		end
	end,
	needUseStaticMap = function()
		local var_11_0 = g.core.utils.Sdk.getDevicePerformLevel()

		if var_11_0 == 0 then
			return true
		elseif var_11_0 == 1 then
			return false
		else
			return false
		end
	end,
	getRealQuality = function()
		local DeviceCheckConst = require("app.core.common.DeviceCheckConst")

		if g.core.common.DeviceCheck.CUR_LEVEL == DeviceCheckConst.LEVEL_SIGN.HIGH then
			return 2
		elseif g.core.common.DeviceCheck.CUR_LEVEL == DeviceCheckConst.LEVEL_SIGN.MID_HIGH or g.core.common.DeviceCheck.CUR_LEVEL == DeviceCheckConst.LEVEL_SIGN.MID_LOW then
			return 1
		end

		return 0
	end
}
