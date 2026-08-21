-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ShopMixin.lua

local ShopMixin = {}

function ShopMixin:initShopMixin(baseData, syncData)
	local shopData = syncData.other.shop

	self.shopData = shopData
	self.shopRandData = {}
	self.refreshData = {}

	for i, data in ipairs(shopData.data.arand) do
		if data.shop_id then
			self.shopRandData[data.shop_id] = data
		end
	end

	for i, refData in ipairs(shopData.refresh_data.item) do
		if refData.shop_id then
			self.refreshData[refData.shop_id] = refData
		end
	end
end

function ShopMixin:postinitShopMixin(baseData, syncData)
	return
end

function ShopMixin:getShopRandData()
	return self.shopRandData, self.refreshData
end

function ShopMixin:onShopRandDataNotify(data)
	if data and data.shop_id then
		self.shopRandData[data.shop_id] = data
	end
end

function ShopMixin:onRoleShopRefreshItemNotify(item)
	if item and item.shop_id then
		self.refreshData[item.shop_id] = item
	end
end

function ShopMixin:onShopEnterResp(shopID, shopItemInfos)
	local allUI = {
		"mallDlg",
		"activityMallDlg",
		"rearHouseShopDlg",
		"activityCommonStoreDlg",
		"petMallDlg"
	}

	for i, uiName in pairs(allUI) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui then
			ui:onShopEnterResp(shopID, shopItemInfos)
		end
	end
end

function ShopMixin:onShopRecordUpdateNotify(shopItemInfo)
	local allUI = {
		"mallDlg",
		"activityMallDlg",
		"rearHouseShopDlg",
		"activityCommonStoreDlg",
		"petMallDlg"
	}

	for i, uiName in pairs(allUI) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui then
			ui:updateItem(shopItemInfo)
		end
	end
end

return ShopMixin
