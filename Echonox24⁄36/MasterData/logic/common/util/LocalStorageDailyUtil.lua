-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/LocalStorageDailyUtil.lua

module("logic.common.util.LocalStorageDailyUtil", package.seeall)

local LocalStorageDailyUtil = class("LocalStorageDailyUtil")

function LocalStorageDailyUtil.setValue(storageKeyStr)
	local saveKeyStr = LocalStorageDailyUtil.getSaveKey(storageKeyStr)

	Astral.LocalStorage.Instance:SetInt(saveKeyStr, 1)
end

function LocalStorageDailyUtil.isFirst(storageKeyStr)
	local saveKeyStr = LocalStorageDailyUtil.getSaveKey(storageKeyStr)

	return not Astral.LocalStorage.Instance:HasKey(saveKeyStr)
end

function LocalStorageDailyUtil.clear(storageKeyStr)
	local roleId = PlayerModel.instance:getId()

	if roleId then
		for i = 1, 31 do
			local storeKey = storageKeyStr .. roleId .. i

			if Astral.LocalStorage.Instance:HasKey(storeKey) then
				Astral.LocalStorage.Instance:DeleteKey(storeKey)
			end
		end
	elseif Astral.LocalStorage.Instance:HasKey(storageKeyStr) then
		Astral.LocalStorage.Instance:DeleteKey(storageKeyStr)
	end
end

function LocalStorageDailyUtil.getSaveKey(storageKeyStr)
	local roleId = PlayerModel.instance:getId()
	local serverDate = ServerTime.nowDateServerLook()
	local day = serverDate.day

	if roleId == nil or day == nil then
		return storageKeyStr
	end

	local saveKeyStr = storageKeyStr .. roleId .. day

	return saveKeyStr
end

function LocalStorageDailyUtil.isFirstToday(storageKey)
	local roleId = PlayerModel.instance:getId() or "0"
	local yearKey = string.format("%s_%s_dailyutil_year_", storageKey, roleId)
	local monthKey = string.format("%s_%s_dailyutil_month_", storageKey, roleId)
	local dayKey = string.format("%s_%s_dailyutil_day_", storageKey, roleId)
	local hourKey = string.format("%s_%s_dailyutil_hour_", storageKey, roleId)
	local nowYear = tonumber(ServerTime.formatNowServerLook("%Y"))
	local nowMonth = tonumber(ServerTime.formatNowServerLook("%m"))
	local nowDay = tonumber(ServerTime.formatNowServerLook("%d"))
	local nowHour = tonumber(ServerTime.formatNowServerLook("%H"))
	local lastYear = Astral.LocalStorage.Instance:GetInt(yearKey, 0)
	local lastMonth = Astral.LocalStorage.Instance:GetInt(monthKey, 0)
	local lastDay = Astral.LocalStorage.Instance:GetInt(dayKey, 0)
	local lastHour = Astral.LocalStorage.Instance:GetInt(hourKey, 0)
	local isFirst = false

	if lastYear == 0 then
		LocalStorageDailyUtil.resetDailyStorage(yearKey, monthKey, dayKey, hourKey, nowYear, nowMonth, nowDay, nowHour)

		isFirst = true
	elseif lastYear < nowYear then
		LocalStorageDailyUtil.resetDailyStorage(yearKey, monthKey, dayKey, hourKey, nowYear, nowMonth, nowDay, nowHour)

		isFirst = true
	elseif nowYear == lastYear then
		if lastMonth < nowMonth then
			LocalStorageDailyUtil.resetDailyStorage(yearKey, monthKey, dayKey, hourKey, nowYear, nowMonth, nowDay, nowHour)

			isFirst = true
		elseif nowMonth == lastMonth and (lastDay < nowDay and nowHour >= 5 or nowDay == lastDay and nowHour >= 5 and lastHour < 5 or nowDay >= lastDay + 1) then
			LocalStorageDailyUtil.resetDailyStorage(yearKey, monthKey, dayKey, hourKey, nowYear, nowMonth, nowDay, nowHour)

			isFirst = true
		end
	end

	return isFirst
end

function LocalStorageDailyUtil.resetDailyStorage(yearKey, monthKey, dayKey, hourKey, nowYear, nowMonth, nowDay, nowHour)
	Astral.LocalStorage.Instance:SetInt(yearKey, nowYear)
	Astral.LocalStorage.Instance:SetInt(monthKey, nowMonth)
	Astral.LocalStorage.Instance:SetInt(dayKey, nowDay)
	Astral.LocalStorage.Instance:SetInt(hourKey, nowHour)
end

return LocalStorageDailyUtil
