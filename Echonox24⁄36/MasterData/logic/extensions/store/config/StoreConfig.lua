-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/config/StoreConfig.lua

module("logic.extensions.store.config.StoreConfig", package.seeall)

local M = class("StoreConfig", BaseConfig)

function M:onInit()
	self._storeConfig = {}
	self._storeMonthyCard = {}
	self._storeGoodsPayCfg = {}
	self._firstMoneyCfg = {}
	self._secondMoneyCfg = {}
	self._normalGoodsCfg = {}
	self._giftBagGoodsCfg = {}
	self._storeBubble = {}
	self._skinGoodsCfg = {}
	self._seasonVipCfg = {}
end

function M:getNames()
	return {
		ConfigName.StoreBookMark,
		ConfigName.StoreRecommend,
		ConfigName.Store,
		ConfigName.MonthlyCard,
		ConfigName.GoodsPay,
		ConfigName.FirstMoney,
		ConfigName.SecondMoney,
		ConfigName.NormalGoods,
		ConfigName.GiftBagGoods,
		ConfigName.StoreBubble,
		ConfigName.SkinGoods,
		ConfigName.SeasonVip,
		ConfigName.EchoCardPack
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.StoreBookMark then
		StoreModel.instance:initStoreTab(content.dataList)
	elseif name == ConfigName.StoreRecommend then
		self._storeRecommendCfg = content
	elseif name == ConfigName.Store then
		self._storeConfig = content

		StoreModel.instance:initAllStoreCfg(content.dataList)
	elseif name == ConfigName.MonthlyCard then
		self._storeMonthyCard = content
	elseif name == ConfigName.GoodsPay then
		self._storeGoodsPayCfg = content
	elseif name == ConfigName.FirstMoney then
		self._firstMoneyCfg = content
	elseif name == ConfigName.SecondMoney then
		self._secondMoneyCfg = content
	elseif name == ConfigName.NormalGoods then
		self._normalGoodsCfg = content
	elseif name == ConfigName.GiftBagGoods then
		self._giftBagGoodsCfg = content
	elseif name == ConfigName.StoreBubble then
		self._storeBubble = content
	elseif name == ConfigName.SkinGoods then
		self._skinGoodsCfg = content
	elseif name == ConfigName.SeasonVip then
		self._seasonVipCfg = content
	elseif name == ConfigName.EchoCardPack then
		self._echoCardPackCfg = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getStoreCO(storeid)
	local storeCO = self._storeConfig[storeid]

	if storeid > 0 and not storeCO and enableErrorLog then
		printError(string.format("StoreConfig::cannot find store config for storeid[%s]", storeid))
	end

	return storeCO
end

function M:getRecommendDataList()
	return self._storeRecommendCfg.dataList
end

function M:getRecommendCo(code)
	local storeCO = self._storeRecommendCfg[code]

	if code > 0 and not storeCO and enableErrorLog then
		printError(string.format("StoreConfig::cannot find recommend config for code[%s]", code))
	end

	return storeCO
end

function M:getGoodsPayCO(goodsId)
	local storeCO = self._storeGoodsPayCfg[goodsId]

	if goodsId > 0 and not storeCO and enableErrorLog then
		printError(string.format("StoreConfig::cannot find goodspay config for goodsId[%s]", goodsId))
	end

	return storeCO
end

function M:getGoodsPrice(goodsId)
	local storeCO = self:getGoodsPayCO(goodsId)

	return storeCO and storeCO.price
end

function M:getMonthyCardCO(mothycardid)
	local storeCO = self._storeMonthyCard[mothycardid]

	if mothycardid > 0 and not storeCO and enableErrorLog then
		printError(string.format("StoreConfig::cannot find mothycard config for mothycardid[%s]", mothycardid))
	end

	return storeCO
end

function M:getStoreCfgList()
	return self._storeConfig.dataList
end

function M:getFirstMoneyGoods(goodsId)
	local goodsCo = self._firstMoneyCfg[goodsId]

	if goodsId > 0 and not goodsCo and enableErrorLog then
		printError(string.format("StoreConfig::cannot find config for goodsId[%s]", goodsId))
	end

	return goodsCo
end

function M:getSecondMoneyGoods(goodsId)
	local goodsCo = self._secondMoneyCfg[goodsId]

	if goodsId > 0 and not goodsCo and enableErrorLog then
		printError(string.format("StoreConfig::cannot find config for goodsId[%s]", goodsId))
	end

	return goodsCo
end

function M:getNormalGoods(goodsId)
	local goodsCo = self._normalGoodsCfg[goodsId]

	return goodsCo
end

function M:getGiftBagGoods(goodsId)
	local goodsCo = self._giftBagGoodsCfg[goodsId]

	if goodsId > 0 and not goodsCo and enableErrorLog then
		printError(string.format("StoreConfig::cannot find config for goodsId[%s]", goodsId))
	end

	return goodsCo
end

function M:getGoodsCO(goodsId)
	local goodsCo = self._firstMoneyCfg[goodsId]

	if goodsCo then
		return goodsCo
	end

	goodsCo = self._secondMoneyCfg[goodsId]

	if goodsCo then
		return goodsCo
	end

	goodsCo = self._normalGoodsCfg[goodsId]

	if goodsCo then
		return goodsCo
	end

	goodsCo = self._giftBagGoodsCfg[goodsId]

	if goodsCo then
		return goodsCo
	end

	goodsCo = self._echoCardPackCfg[goodsId]

	if goodsCo then
		return goodsCo
	end

	return goodsCo
end

function M:getStoreBubbleCo(code)
	local co = self._storeBubble[code]

	if code > 0 and not co and enableErrorLog then
		printError(string.format("StoreConfig::cannot find config for code[%s]", code))
	end

	return co
end

function M:getBubbleByFactor(factor)
	local tmp = {}

	for _, v in pairs(self._storeBubble) do
		if v.factor == factor then
			table.insert(tmp, v)
		end
	end

	local randomIndex = math.random(#tmp)
	local bubbleCo = tmp[randomIndex]

	return bubbleCo
end

function M:getSkinGoodsCo(skinId)
	for _, v in pairs(self._skinGoodsCfg) do
		if skinId == v.skinId then
			return v
		end
	end

	return nil
end

function M:getSeasonVipCo(id)
	return self._seasonVipCfg[id]
end

function M:getSkinGoodsCoByKey(id)
	return self._skinGoodsCfg[id]
end

function M:getStoreTabId(id)
	local config = self._storeConfig[id]

	return config and config.tabId or -id
end

M.instance = M.New()

return M
