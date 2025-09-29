-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/util/CurrencyExchangeUtil.lua

module("logic.extensions.currencyexchange.util.CurrencyExchangeUtil", package.seeall)

local CurrencyExchangeUtil = {}

function CurrencyExchangeUtil.SourceItemEnough(exchangeCfgId)
	local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(exchangeCfgId)

	if cfgCO == nil then
		printError(string.format("无法从[%s]找到[%s]的配置", ConfigName.CurrencyExchange, exchangeCfgId))

		return false
	end

	local sourceItemId = cfgCO:getSourceId()
	local sourceItemReqNum = cfgCO:getSourceNum()
	local sourceItemNowCount = ItemModel.instance:getItemCountByItemId(sourceItemId)

	return sourceItemReqNum <= sourceItemNowCount
end

return CurrencyExchangeUtil
