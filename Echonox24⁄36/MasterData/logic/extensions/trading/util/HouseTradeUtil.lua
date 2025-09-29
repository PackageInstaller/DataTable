-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/util/HouseTradeUtil.lua

module("logic.extensions.trading.util.HouseTradeUtil", package.seeall)

local HouseTradeUtil = {}

function HouseTradeUtil.deserializeTradeInfo(id)
	local cfg = TradingConfig.instance:getConfigByKey(ConfigName.TradeInfo, id)

	if not cfg then
		return nil, false
	end

	local desc = cfg.desc

	if cfg.type == 1 then
		return desc, true
	end

	local paramsStr = TradingModel.instance:getTradeInfoParams(id)

	if string.nilorempty(paramsStr) then
		if enableLog then
			printError(string.format("deserializeTradeInfo [%s] fail, params is nil or empty!", id))
		end

		return nil, false
	end

	local _success = true
	local _paramKey = {}

	for _, p in ipairs(string.split(cfg.params, "#")) do
		local a = string.split(p, ":")

		table.insert(_paramKey, a[1])
	end

	local _tmpParam = {}

	for i, p in ipairs(string.split(paramsStr, "#")) do
		local val = p
		local key = _paramKey[i]

		if key == "randNum" then
			val = tonumber(val)
		elseif key == "randCamp" then
			val = tonumber(val)
			val = CommEnum.CampType2Name[val] and CommEnum.CampType2Name[val] or ""
		elseif key == "rankItem" then
			val = tonumber(val)

			local cfgItem = BackpackConfig.instance:getConfigByKey(ConfigName.ItemHouse, val)

			val = cfgItem and cfgItem.name or ""
		else
			val = ""
		end

		table.insert(_tmpParam, val)
	end

	local result = desc

	for str, _ in string.gmatch(desc, "%b##") do
		local paramIndex = string.match(str, "%d+")

		if string.nilorempty(paramIndex) or not _tmpParam[tonumber(paramIndex)] or string.nilorempty(_tmpParam[tonumber(paramIndex)]) then
			_success = false
			result = ""

			if enableLog then
				printError(string.format("deserializeTradeInfo [%s] fail, params index[%s] not match!", id, paramIndex))
			end
		end

		if _success then
			local _rep = _tmpParam[tonumber(paramIndex)]

			result = string.gsub(result, str, _rep)
		end
	end

	return result, _success
end

return HouseTradeUtil
