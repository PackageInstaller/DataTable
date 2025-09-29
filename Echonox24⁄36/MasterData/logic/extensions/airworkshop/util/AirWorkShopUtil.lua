-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/util/AirWorkShopUtil.lua

module("logic.extensions.airworkshop.util.AirWorkShopUtil", package.seeall)

local AirWorkShopUtil = {}
local gridRow = 15
local gridColumn = 15

function AirWorkShopUtil.isSystemOpen(showToast)
	local systemKey = GameEnum.SystemEnum.PvpFightActivity

	return SystemOpenFacade.instance:isOpen(systemKey, showToast)
end

function AirWorkShopUtil.openPersonalPage(userId, pageType)
	if not AirWorkShopUtil.isSystemOpen(true) then
		return
	end

	if not userId then
		return
	end

	pageType = pageType or AirWorkShopEnum.PersonalPageType.Main

	AirWorkShopAtkAgent.instance:sendGetAirPageRequest(userId, pageType)
end

function AirWorkShopUtil.formatPassRatio(val, numDigits)
	if val == 0 or val == 100 then
		return val
	end

	local finalVal = val
	local _, _decimals = math.modf(val)

	if _decimals ~= 0 then
		numDigits = 10^numDigits
		finalVal = MathUtil.roundingBy456(val * numDigits)
		finalVal = finalVal ~= 0 and finalVal / numDigits or finalVal / numDigits
	end

	return finalVal
end

function AirWorkShopUtil.GiveUpChallengeMode()
	printWarn("放弃挑战")

	local content = lang("tip_air_give_up_rodeo")
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(function()
		AirWorkShopAtkAgent.instance:sendRodeoGiveUpRequest()
	end, self)
end

function AirWorkShopUtil.TryGainRodeoSettleReward()
	if AirWorkShopUtil.getCanRodeoSettle() then
		AirWorkShopAtkAgent.instance:sendSettleWeekRequest()

		return true
	end

	return false
end

function AirWorkShopUtil.getCanRodeoSettle()
	local canSettle = false
	local nowTime = ServerTime.now()
	local lastWeek = AirWorkShopChallengeModel.instance:getLastSettleWeek()
	local lastSettleTime = tonumber(lastWeek) or 0

	if lastSettleTime == 0 then
		return false
	end

	local year = math.floor(lastSettleTime / 10000)
	local month = math.floor(lastSettleTime % 10000 / 100)
	local day = lastSettleTime % 100

	lastSettleTime = ServerTime.dateToTimeServerLook({
		hour = 5,
		year = year,
		month = month,
		day = day
	})

	if Astral.OSDef.isEditor then
		printWarn(string.format("竞技模式,上周赛结算周标识:%s (%s)", lastWeek, TimeUtil.instance:stampToDateStr(lastSettleTime)))
	end

	if lastSettleTime > 0 then
		local mondayTime_last = TimeUtil.instance:getWDayTimeStamp(lastSettleTime, 1, 5)
		local mondayTime_now = TimeUtil.instance:getWDayTimeStamp(nowTime, 1, 5)

		if Astral.OSDef.isEditor then
			printWarn(string.format("竞技模式,本周一时间戳:%s (%s)", mondayTime_now, TimeUtil.instance:stampToDateStr(mondayTime_now)))
		end

		if not (mondayTime_now - mondayTime_last >= 604800) or AirWorkShopUtil.getInRodeoCalculateTime(nowTime) then
			-- block empty
		else
			canSettle = true
		end
	end

	return canSettle
end

function AirWorkShopUtil.getClosestLastSettleWeek(nowTime)
	nowTime = nowTime or ServerTime.now()

	local mondayTime_now = TimeUtil.instance:getWDayTimeStamp(nowTime, 1, 5)

	if AirWorkShopUtil.getInRodeoCalculateTime(nowTime) then
		mondayTime_now = mondayTime_now - 604800
	end

	local lastSettleWeek = tonumber(AirWorkShopChallengeModel.instance:getLastSettleWeek())
	local year = math.floor(lastSettleWeek / 10000)
	local month = math.floor(lastSettleWeek % 10000 / 100)
	local day = lastSettleWeek % 100
	local lastSettleTime = ServerTime.dateToTimeServerLook({
		hour = 5,
		year = year,
		month = month,
		day = day
	})

	if mondayTime_now < lastSettleTime then
		return os.date("%Y%m%d", mondayTime_now)
	elseif mondayTime_now - lastSettleTime > 604800 then
		return os.date("%Y%m%d", mondayTime_now)
	else
		return lastSettleWeek
	end
end

function AirWorkShopUtil.rodeoLvImgChange(lv, img1, img2, goLv1Bg, imgLv2Bg)
	local name = AirWorkShopUtil.getRodeoLvGradeName(lv)
	local a = string.sub(name, 0, 1)
	local b = string.sub(name, 2, 3)

	a = string.lower(a)
	b = tonumber(b)

	local icon1 = string.format("kqgf_big_%s", a)
	local icon2 = string.format("qhd_num_%02d", b)

	if img1 then
		IconLoader.setSprite(img1, IconType.DynSpriteAtlas_AirWorkShop, icon1)
	end

	if img2 then
		IconLoader.setSprite(img2, IconType.Skinlib, icon2)

		local color = AirWorkShopEnum.RodeoLv2ImgColor[a] or AirWorkShopEnum.RodeoLv2ImgColor.d

		img2.color = Astral.ColorUtil.ParseColor(color)
	end

	if goLv1Bg then
		goutil.setActive(goLv1Bg.gameObject, a == "s")
	end

	if imgLv2Bg then
		IconLoader.setSprite(imgLv2Bg, IconType.DynSpriteAtlas_AirWorkShop, string.format("jjms_bf_0006_%s", a))
	end
end

function AirWorkShopUtil.getRodeoLvGradeNamePersonal(lv)
	local name = AirWorkShopUtil.getRodeoLvGradeName(lv)
	local a = string.sub(name, 0, 1)
	local b = string.sub(name, 2, 3)

	return string.format("%s<size=58>%s</size>", a, b)
end

function AirWorkShopUtil.getRodeoLvGradeNickName(lv, noPrintWhileNotFound)
	if not lv then
		local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()

		lv = minLv
	end

	local lvCfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirAtkPoint, lv, noPrintWhileNotFound)

	return lvCfg and lvCfg.nickName or ""
end

function AirWorkShopUtil.getRodeoLvGradeName(lv, noPrintWhileNotFound)
	if not lv then
		local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()

		lv = minLv
	end

	local lvCfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirAtkPoint, lv, noPrintWhileNotFound)

	return lvCfg and lvCfg.name or ""
end

function AirWorkShopUtil.getRodeoLvStateName(state)
	local str

	if state then
		local changeLv = AirWorkShopEnum.LvStateNum[state] or 0

		if changeLv > 0 then
			str = langF("tip_air_lv_state_change_up", changeLv)
		elseif changeLv < 0 then
			str = langF("tip_air_lv_state_change_down", math.abs(changeLv))
		else
			str = lang("tip_air_lv_state_change_keep")
		end
	end

	return str
end

function AirWorkShopUtil.getInRodeoCalculateTime(nowTime, showToast)
	nowTime = nowTime or ServerTime.now()

	local wday = 2
	local beginHour, endHour = 0, 5
	local date = os.date("*t", nowTime)

	if date.wday == wday and beginHour <= date.hour and endHour > date.hour then
		if showToast then
			FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))
		end

		return true
	end

	return false
end

function AirWorkShopUtil.getRodeoEndTimeStamp(nowTime)
	nowTime = nowTime or ServerTime.now()

	return TimeUtil.instance:getNextMondayRefreshTimeStamp(nowTime, -1)
end

function AirWorkShopUtil.convertToXY(index)
	local x, y = 0, 0

	x = (index - 1) % gridColumn
	y = gridRow - math.ceil(index / gridRow)

	return x, y
end

function AirWorkShopUtil.convertXYtoIndex(x, y)
	local column = x + 1
	local row = gridRow - y - 1
	local index = row * gridColumn + column

	return index
end

function AirWorkShopUtil.loadSceneImage(img, cover, request)
	IconLoader.clearSprite(img)

	img.enabled = true

	local sprite = AirWorkMapModel.instance:getSpriteByCover(cover, request)

	if sprite then
		img.sprite = sprite
	else
		IconLoader.setSprite(img, IconType.AirWorkShopTheme, "kqgf_loading_img")
	end
end

return AirWorkShopUtil
