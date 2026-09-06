-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/config/ActivityshopConfig.lua

module("logic.extensions.activityshop.config.ActivityshopConfig", package.seeall)

local ActivityshopConfig = class("ActivityshopConfig", BaseConfig)

function ActivityshopConfig:onInit()
	return
end

function ActivityshopConfig:getNames()
	return {
		"activity_shop",
		"activity_shop_page",
		"activity_shop_name",
		"shenqi_exchange",
		"shenqi_exchange_common",
		"activity_shop_cost_icon",
		"activity_shop_coupon"
	}
end

function ActivityshopConfig:handleConfig(name, content)
	if name == "activity_shop" then
		self._activity_shopCfgs = content

		self:_parseShopCfgs2PageKey(content.dataList)
	elseif name == "activity_shop_page" then
		self._activity_shop_pageCfg = content
	elseif name == "activity_shop_name" then
		self._activity_shop_nameCfg = content
	elseif name == "shenqi_exchange" then
		self._shenqi_exchangeCfg = content
	elseif name == "shenqi_exchange_common" then
		self._shenqi_exchange_common = content
	elseif name == "activity_shop_cost_icon" then
		self._cost_icon = content
	elseif name == "activity_shop_coupon" then
		self._activity_shop_coupon = content
	end
end

function ActivityshopConfig:getActivityShopCfg(activityType, activityId)
	return self._activity_shopCfgs[activityType][activityId]
end

function ActivityshopConfig:getActivityShopCfgWithPage(activityType, activityId)
	return self._activity_shopHasPageCfgs[activityType][activityId]
end

function ActivityshopConfig:_parseShopCfgs2PageKey(dataList)
	self._activity_shopHasPageCfgs = {}

	for i, v in ipairs(dataList) do
		self._activity_shopHasPageCfgs[v.activityType] = self._activity_shopHasPageCfgs[v.activityType] or {}
		self._activity_shopHasPageCfgs[v.activityType][v.activityId] = self._activity_shopHasPageCfgs[v.activityType][v.activityId] or {}
		self._activity_shopHasPageCfgs[v.activityType][v.activityId][v.page] = self._activity_shopHasPageCfgs[v.activityType][v.activityId][v.page] or {}

		table.insert(self._activity_shopHasPageCfgs[v.activityType][v.activityId][v.page], v)
	end
end

function ActivityshopConfig:getActivityShopCfgByItemId(activityType, activityId, itemId)
	if not activityType then
		return
	end

	return self._activity_shopCfgs[activityType][activityId][itemId]
end

function ActivityshopConfig:getActivityShopPageCfg(activityType, activityId, page)
	return self._activity_shop_pageCfg[activityType][activityId][page]
end

function ActivityshopConfig:getActivityShopPageCfgs(activityType, activityId)
	if not self._activity_shop_pageCfg[activityType] or not self._activity_shop_pageCfg[activityType][activityId] then
		printError("export_分页时间限制  in  y运营-活动商店.xlsx  缺少配置 activityType,activityId", activityType, activityId)
	end

	return self._activity_shop_pageCfg[activityType][activityId]
end

function ActivityshopConfig:getActShopTitleName(activityType, activityId)
	local tab1 = self._activity_shop_nameCfg[activityType]

	if tab1 and tab1[activityId] then
		if not tab1[activityId].mainName then
			return "兑换商店"
		end
	end
end

function ActivityshopConfig:getShenQiTabList()
	return self._shenqi_exchangeCfg.dataList
end

function ActivityshopConfig:getShenqiKeyValue(key, need2number)
	if need2number then
		return checknumber(self._shenqi_exchange_common[key].value)
	else
		return self._shenqi_exchange_common[key].value
	end
end

function ActivityshopConfig:getCostIcon(actType, actId)
	if self._cost_icon[actType] ~= nil then
		return self._cost_icon[actType][actId]
	end

	return nil
end

function ActivityshopConfig:getActDiscountTimeStr(activityId)
	return nil
end

function ActivityshopConfig:getCouponIdsByShopItemId(activityType, activityId, shopItemId)
	local cfg = self:getActivityShopCfgByItemId(activityType, activityId, shopItemId)

	return cfg.couponIds
end

function ActivityshopConfig:getCouponCfgsByShopItemId(activityType, activityId, shopItemId)
	local cfg = self:getActivityShopCfgByItemId(activityType, activityId, shopItemId)
	local cfgs = {}

	if cfg.couponIds then
		for i, v in ipairs(cfg.couponIds) do
			table.insert(cfgs, self:getCouponCfg(v))
		end
	end

	return cfgs
end

function ActivityshopConfig:getCouponCfg(couponId)
	return self._activity_shop_coupon[couponId]
end

ActivityshopConfig.instance = ActivityshopConfig.New()

return ActivityshopConfig
