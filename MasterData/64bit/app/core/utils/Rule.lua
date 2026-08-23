local var_0_0 = {
	Level = {
		OFF = 0,
		HIGH = 3,
		MID = 2,
		NORMAL = 1
	}
}
local var_0_1 = var_0_0.Level.OFF
local var_0_2 = {
	setRuleLevel = function(arg_1_0)
		var_0_1 = arg_1_0
	end,
	getRuleLevel = function()
		return var_0_1
	end,
	matchChannelOther = function()
		local var_3_0 = g.core.platform.PlatformProxy:getCurChannel()

		if var_3_0.name and ({
			HUAWEI = true,
			HARMONY = true,
			OPPO = true
		})[var_3_0.name] then
			return true
		end

		return false
	end
}

function var_0_2.isForceUseRulePath(arg_4_0)
	arg_4_0 = arg_4_0 or var_0_2.matchChannelAndLv

	if arg_4_0() then
		return true
	else
		return false
	end
end

function var_0_2.isHideLoginPv()
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		return true
	else
		return var_0_1 > var_0_0.Level.OFF
	end
end

function var_0_2.isSwitchPV2()
	return var_0_1 > var_0_0.Level.OFF
end

function var_0_2.isHideFuncGuide()
	return var_0_1 > var_0_0.Level.OFF
end

function var_0_2.isUseHQSuffix()
	return var_0_1 > var_0_0.Level.OFF
end

function var_0_2.isCheckRecruitPreviewKnight()
	return var_0_1 > var_0_0.Level.NORMAL
end

function var_0_2.isHideSkinHandbook()
	return var_0_1 > var_0_0.Level.NORMAL
end

function var_0_2.isForceStopDrawKnight()
	return var_0_1 > var_0_0.Level.MID
end

function var_0_2.isKnightDetailPopUseSpine()
	if var_0_2.matchChannelAndLv() then
		return true
	else
		return false
	end
end

function var_0_2.isSpecialChannelWaitGameBg()
	if var_0_2.matchSpecialChannel() then
		return true
	else
		return false
	end
end

function var_0_2.matchSpecialChannel()
	local var_14_0 = g.core.platform.PlatformProxy:getCurChannel()

	if var_14_0.name and ({
		VIVO = true,
		HAOYOUKB = true,
		TAPTAP = true,
		LEIDIAN = true,
		MUMU = true,
		C4399 = true,
		C9YOU = true,
		OPPO = true,
		HUAWEI = true,
		XIAOMI = true,
		DOUYIN = true,
		BILI = true,
		YYB = true,
		RONGYAO = true
	})[var_14_0.name] then
		return true
	end

	return false
end

function var_0_2.isHideSignActivityKnightImg()
	return var_0_1 > var_0_0.Level.MID
end

function var_0_2.isHideRecruitActiveOfOpenServer()
	return var_0_1 > var_0_0.Level.MID
end

function var_0_2.matchChannel()
	local ChannelConst = require("app.core.platform.const.ChannelConst")
	local var_17_1 = g.core.platform.PlatformProxy:getCurChannel()

	if var_17_1.name and ({
		HUAWEI = true,
		OPPO = true,
		TAPTAP = true,
		VIVO = true,
		DOUYIN = true,
		BILI = true,
		YYB = true,
		XIAOMI = true
	})[var_17_1.name] then
		return true
	end

	return false
end

function var_0_2.matchChannelAndLv()
	if var_0_2.matchChannel() and ((({
		[require("app.core.platform.const.ChannelConst").ChannelNames.TAPTAP] = true
	})[g.core.platform.PlatformProxy:getCurChannel().name] or nil) and 20) >= g.core.model.User:getLevel() then
		return true
	end

	return false
end

function var_0_2.isDownloadAllHqZips()
	return false
end

function var_0_2.doRulePatchLogic()
	require("app.core.utils.RulePatch").doPatch()
end

function var_0_2.doOnlineRulePatch()
	return
end

return var_0_2
