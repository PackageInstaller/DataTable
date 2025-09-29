-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loginpopups/util/LoginPopUpUtil.lua

module("logic.extensions.loginpopups.util.LoginPopUpUtil", package.seeall)

local LoginPopUpUtil = {}

function LoginPopUpUtil.getStoreKey(code, otherCode)
	if otherCode then
		return string.format("%s#%s#%s#%s", LoginPopEnum.LOGIN_POP_UP_KEY, code, otherCode, PlayerModel.instance:getId())
	else
		return string.format("%s#%s#%s", LoginPopEnum.LOGIN_POP_UP_KEY, code, PlayerModel.instance:getId())
	end
end

function LoginPopUpUtil.setDisplayState(code, otherCode)
	local tempCO = LoginPopUpsConfig.instance:getConfigByKey(ConfigName.LoginPopUps, code)

	if tempCO and tempCO.winType == LoginPopEnum.Type.Day then
		local key = LoginPopUpUtil.getStoreKey(code, otherCode)
		local nowTS = ServerTime.now()
		local nowHour = tonumber(os.date("%H", nowTS))
		local time = TimeUtil.instance:getTodaySpTimeStamp(0, 0, 5)

		if nowHour < 5 then
			time = time - 86400
		end

		Astral.LocalStorage.Instance:SetString(key, string.format("%s", time))
	end
end

function LoginPopUpUtil.hasShow(code, otherCode)
	local hasShow = false
	local cfg = LoginPopUpsConfig.instance:getConfigByKey(ConfigName.LoginPopUps, code)

	if cfg then
		local winType = cfg.winType

		if winType == LoginPopEnum.Type.Normal then
			-- block empty
		elseif winType == LoginPopEnum.Type.Day then
			local key = LoginPopUpUtil.getStoreKey(code, otherCode)
			local value = Astral.LocalStorage.Instance:GetString(key, "")

			if not string.nilorempty(value) then
				local lastTime = tonumber(value)

				if lastTime then
					local nowTime = ServerTime.now()

					hasShow = nowTime - lastTime < 86400
				else
					hasShow = false
				end
			end
		elseif enableErrorLog then
			printError("error type for login pop ups!", winType)
		end
	end

	return hasShow
end

return LoginPopUpUtil
