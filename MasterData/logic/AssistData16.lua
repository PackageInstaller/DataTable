-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData16.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData16", package.seeall)

local AssistData16 = class("AssistData16", BaseAssistData)

function AssistData16:init()
	printInfo("test AssistData16:init")

	self.selectIndex1 = 1
	self.selectIndex2 = 2
	self.selectIndex3 = 3
	self.selectIndex4 = 4
	self.selectIndex5 = 5
	self.selectIndex6 = 6

	self:_initShopDefineIds()
end

function AssistData16:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData16:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		XiaoNuoAssistCostModel.instance:clearCoin(self:getFuncIndex(), AssistCell16.Diamond)
		XiaoNuoAssistCostModel.instance:clearCoin(self:getFuncIndex(), AssistCell16.GodGem)

		if self:getCellSelect(self.selectIndex1) then
			local shopDefineId = self._assistCellData.ShopDefineIds[1]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.Diamond, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.Diamond)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 9折神唤券礼包", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex2) then
			local shopDefineId = self._assistCellData.ShopDefineIds[2]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.Diamond, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.Diamond)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 9折召唤券礼包", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex3) then
			local shopDefineId = self._assistCellData.ShopDefineIds[3]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.Diamond, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.Diamond)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 9折炼金石礼包", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex4) then
			local shopDefineId = self._assistCellData.ShopDefineIds[4]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.Diamond, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.Diamond)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 9折神炼石礼包", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex5) then
			printInfo("test getSendCallbackList1")

			local shopDefineId = self._assistCellData.ShopDefineIds[5]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			printInfo("test getSendCallbackList2", isCanBuy, shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.Diamond, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.Diamond)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				printInfo("test getSendCallbackList3", curTotalDiamond, costTotalDiamond, costTotalDiamond <= curTotalDiamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 淬源晶石（周）钻石", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					printInfo("test getSendCallbackList4", shopDefineId, maxBuyCount, planId)
					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex6) then
			local shopDefineId = self._assistCellData.ShopDefineIds[6]
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopDefineId)

			if isCanBuy then
				local maxBuyCount = self:getMaxBuyCount(shopDefineId)
				local singlePrice = self:getDiscountPrice(shopDefineId)
				local totalPrice = singlePrice * maxBuyCount

				XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), AssistCell16.GodGem, totalPrice)

				local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell16.GodGem)
				local curTotalDiamond = MaterialMgr.getMatCount(AssistCell16.Diamond)

				if costTotalDiamond <= curTotalDiamond then
					local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(shopDefineId)

					local function callback()
						printInfo("test 9折炼金石礼包", shopDefineId, maxBuyCount, planId)
						PayShopController.instance:buyShopItem(shopDefineId, maxBuyCount, planId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		return sendMo
	end
end

function AssistData16:getReqParams()
	return tostring(1012)
end

function AssistData16:getMaxBuyCount(shopDefineId)
	local usedTimes = PayShopModel.instance:getMibaoBuyTimesById(shopDefineId)
	local cfgPayShop = PayShopConfig.instance:getPayShopGoodsCfgById(shopDefineId)

	return (Mathf.Max(0, cfgPayShop.limitTimes - usedTimes))
end

function AssistData16:getDiscountPrice(shopDefineId)
	local cfgPayShop = PayShopConfig.instance:getPayShopGoodsCfgById(shopDefineId)
	local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(cfgPayShop.id)
	local dcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)

	if dcfg then
		local list = string.split(dcfg.discountPrice, ":")
		local discountPrice = list[#list]

		return checkint(discountPrice)
	else
		local list = string.split(cfgPayShop.originalGoodsId, ":")
		local originalPrice = list[#list]

		return checkint(originalPrice)
	end
end

function AssistData16:_initShopDefineIds()
	self._assistCellData.ShopDefineIds = {}

	local params = XiaoNuoAssistantController.instance:getParams(XiaoNuoAssistantModel.FuncEnum.PAY_SHOP)

	for i = 1, 6 do
		local shopIdList = params.shopId[i]

		self._assistCellData.ShopDefineIds[i] = self:_getMatchShopId(shopIdList)
	end
end

function AssistData16:_getMatchShopId(shopIdList)
	local count = #shopIdList

	for i = count, 1, -1 do
		local shopId = shopIdList[i]
		local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)

		if mibaoCfg and GameUtil.checkIsInTimePeriod(mibaoCfg.onlineTime, mibaoCfg.offlineTime) then
			return shopId
		end
	end

	return shopIdList[1]
end

return AssistData16
