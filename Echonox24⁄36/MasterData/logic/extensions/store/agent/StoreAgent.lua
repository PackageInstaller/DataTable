-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/agent/StoreAgent.lua

module("logic.extensions.store.agent.StoreAgent", package.seeall)

local StoreAgent = class("StoreAgent", BaseAgent)
local kPayWaitingMaxTime = 10

function StoreAgent:ctor()
	StoreAgent.super.ctor(self)
end

function StoreAgent:reqJumpTo(storeId, goodsId)
	local req = MallExtension_pb.GetMallListRequest()

	self:invoke({
		funcName = "handleGetMallListReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				StoreModel.instance:initStoreByAgent(msg.mall)

				local storeId = storeId
				local tabId = StoreModel.instance:getTabIdByStoreId(storeId)
				local req2 = MallExtension_pb.GetGoodsListRequest()

				table.insert(req2.mallId, storeId)
				self:invoke({
					funcName = "handleGetGoodsListReply",
					sendData = req2,
					handleCall = function(status, msg)
						if status == 0 then
							StoreModel.instance:clearGoodsData(storeId)

							for index, goods in ipairs(msg.goods) do
								self:_checkGoods(goods, tabId)
							end

							local success = StoreMainFacade.instance:jumpToStore(tabId, storeId, goodsId)

							GlobalDispatcher:dispatchEvent(EventType.ON_JUMP_TO_STORE_REPLY, success)
						end
					end
				})
			end
		end
	})
end

function StoreAgent:reqJumpToStoreInList(storeIds)
	local len = storeIds and #storeIds or 0

	if len == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ON_JUMP_TO_STORE_REPLY, false)

		return
	end

	local req = MallExtension_pb.GetMallListRequest()

	self:invoke({
		funcName = "handleGetMallListReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				StoreModel.instance:initStoreByAgent(msg.mall)

				local storeIds_online = {}

				for _, _storeId in ipairs(storeIds) do
					if StoreModel.instance:isStoreOnline(_storeId) then
						table.insert(storeIds_online, _storeId)
					end
				end

				if #storeIds_online == 0 then
					GlobalDispatcher:dispatchEvent(EventType.ON_JUMP_TO_STORE_REPLY, false)
				else
					local req2 = MallExtension_pb.GetGoodsListRequest()

					for _, _storeId in ipairs(storeIds_online) do
						table.insert(req2.mallId, _storeId)
					end

					self:invoke({
						funcName = "handleGetGoodsListReply",
						sendData = req2,
						handleCall = function(status, msg)
							if status == 0 then
								for _, _storeId in ipairs(storeIds_online) do
									StoreModel.instance:clearGoodsData(_storeId)
								end

								for index, goods in ipairs(msg.goods) do
									local tabId = StoreModel.instance:getTabIdByStoreId(goods.commonInfo.mallId)

									self:_checkGoods(goods, tabId)
								end

								local jumpStoreId, jumpGoodsId

								for _, _storeId in ipairs(storeIds_online) do
									if not jumpStoreId then
										local canBuyGoodsIds = StoreModel.instance:getCanBuyGoodsInStore(_storeId)

										if canBuyGoodsIds and #canBuyGoodsIds > 0 then
											jumpStoreId = _storeId
											jumpGoodsId = canBuyGoodsIds[1]
										end
									end
								end

								local success = false

								if jumpStoreId then
									local tabId = StoreModel.instance:getTabIdByStoreId(jumpStoreId)

									success = StoreMainFacade.instance:jumpToStore(tabId, jumpStoreId, jumpGoodsId)
								end

								GlobalDispatcher:dispatchEvent(EventType.ON_JUMP_TO_STORE_REPLY, success)
							end
						end
					})
				end
			end
		end
	})
end

function StoreAgent:sendGetMallListRequest(openui)
	local req = MallExtension_pb.GetMallListRequest()

	self:invoke({
		funcName = "handleGetMallListReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local showUI = openui

				StoreModel.instance:initStoreByAgent(msg.mall)

				if showUI then
					StoreMainFacade.instance:showStoreMain(1)
				end

				GlobalDispatcher:dispatchEvent(EventType.REFRESH_STORE_LIST)
			end
		end
	})
end

function StoreAgent:sendGetGoodsListRequest(mallIds)
	local req = MallExtension_pb.GetGoodsListRequest()
	local needRequest = false

	for i = 1, #mallIds do
		if StoreModel.instance:isStoreOnline(mallIds[i]) then
			table.insert(req.mallId, mallIds[i])

			needRequest = true
		end
	end

	if not needRequest then
		return
	end

	self:invoke({
		funcName = "handleGetGoodsListReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				for i = 1, #mallIds do
					local storeId = mallIds[i]

					StoreModel.instance:clearGoodsData(storeId)
				end

				for index, goods in ipairs(msg.goods) do
					self:_checkGoods(goods)
				end

				GlobalDispatcher:dispatchEvent(EventType.REFRESH_GOODSITEM_DATA, true)
			else
				for i = 1, #mallIds do
					local storeId = mallIds[i]

					StoreModel.instance:clearGoodsData(storeId)
				end

				self:sendGetMallListRequest()
				GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR, status)
			end
		end
	})
end

function StoreAgent:_checkGoods(goods, tabId)
	local storeId = goods.commonInfo.mallId

	tabId = tabId or StoreConfig.instance:getStoreTabId(storeId)

	local goodsMo = false

	if goods:HasField("firstMoneyGoods") then
		goodsMo = FirstMoneyGoodsData.New(goods.commonInfo, tabId)
	elseif goods:HasField("monthlyCardGoods") then
		goodsMo = MonthlyCardGoodsData.New(goods.monthlyCardGoods, tabId, goods.commonInfo)
	elseif goods:HasField("secondMoneyGoods") then
		goodsMo = SecondMoneyGoodsData.New(goods.secondMoneyGoods, tabId, goods.commonInfo)
	elseif goods:HasField("normalGoods") then
		goodsMo = NormalGoodsData.New(goods.normalGoods, tabId, goods.commonInfo)
	elseif goods:HasField("giftBagGoods") then
		goodsMo = GiftBagGoodsData.New(goods.giftBagGoods, tabId, goods.commonInfo)
	elseif goods:HasField("heroSkinGoods") then
		goodsMo = SkinGoodsData.New(goods.skinGoods, tabId, goods.commonInfo)
	elseif goods:HasField("echoCardPack") then
		goodsMo = EchoCardGoodsData.New(goods.skinGoods, tabId, goods.commonInfo)
	end

	if goodsMo then
		StoreModel.instance:initGoodsData(goodsMo, tabId, storeId)
	end
end

function StoreAgent:sendBuyGoodsRequest(goodsId, num, costItems, uiName)
	local sourceName = ViewName.StoreShoppingTipsViewPresentor

	if uiName then
		sourceName = uiName
	end

	local req = MallExtension_pb.BuyGoodsRequest()

	req.goodsId = goodsId
	req.num = num
	req.source = sourceName

	for key, costItem in pairs(costItems) do
		local costNO = MallExtension_pb.MallCostNO()

		costNO.itemId = costItem.costId
		costNO.num = costItem.costCount

		table.insert(req.costs, costNO)
	end

	self:invoke({
		funcName = "handleBuyGoodsReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local goodsData = StoreModel.instance:getGoodMoByGoodsId(goodsId)

				self:_checkGoods(msg.goods)
				GlobalDispatcher:dispatchEvent(EventType.REFRESH_GOODSITEM_DATA, false, true)
				self:_checkNeedUpdateGiftShop(goodsData)
			else
				self:sendGetMallListRequest()
				GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR, status)
			end
		end
	})
end

function StoreAgent:_checkNeedUpdateGiftShop(goodsData)
	if goodsData and goodsData:getGoodsType() == StoreEnum.GoodsType.GiftBag then
		local storeId = goodsData:getStoreId()

		self:sendGetGoodsListRequest({
			storeId
		})
	end
end

function StoreAgent:sendBuyGoodsRequestBySDK(goodsId, num, tabId, _payMoney, _coinName, _moreCharge, _payType, _productName, _coinsAmount, _rate, _platformGoodsId, _exStr, _uiName)
	local sourceName = ViewName.StoreShoppingTipsViewPresentor

	if _uiName then
		sourceName = _uiName
	end

	local req = MallExtension_pb.BuyGoodsRequest()

	req.goodsId = goodsId
	req.num = num
	req.source = sourceName

	local isVisitor = PlayerModel.instance:getIsVisitor()

	if isVisitor then
		local dialog = Dialog.showNotifyMessage("提示", "游客账号无法进行充值，请升级账号")

		dialog:setConfirmButtonText("确定")
		dialog:setConfirmListener(self.upgradeAccount, self)

		return
	end

	self:invoke({
		funcName = "handleBuyGoodsReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local tabId = tabId
				local roleId = PlayerModel.instance:getId()
				local roleName = PlayerModel.instance:getNickName()
				local roleLevel = PlayerModel.instance:getLevel()
				local serverName = LoginModel.instance:getServerName()
				local roleCTime = PlayerModel.instance:getRegisterTime()
				local loginTime = PlayerModel.instance:getLoginTimeDataStr()
				local lastLogoutTime = PlayerModel.instance:getLastLogoutTimeDataStr()
				local registerTime = PlayerModel.instance:getRegisterTime()
				local callBackStr = ""
				local money = _payMoney
				local gameGold = _coinName
				local moreCharge = _moreCharge or 0
				local payType = _payType or 0
				local productName = _productName or ""
				local coinsAmount = _coinsAmount
				local rate = _rate
				local platformGoodsId = _platformGoodsId or ""
				local outOrderNo = -1
				local zoneId = BootstrapGameConfigMgr.getZoneId()
				local exStr = _exStr or "111"
				local sign = ""

				if msg:HasField("order") then
					outOrderNo = msg.order.outOrderNo
					callBackStr = msg.order.callBackInfo
					sign = msg.order.sign
				end

				SDKPaymentInfo.roleId = roleId
				SDKPaymentInfo.callBackStr = callBackStr
				SDKPaymentInfo.money = money
				SDKPaymentInfo.gameGold = gameGold
				SDKPaymentInfo.moreCharge = moreCharge
				SDKPaymentInfo.payType = payType
				SDKPaymentInfo.productName = productName
				SDKPaymentInfo.coinsAmount = coinsAmount
				SDKPaymentInfo.rate = rate
				SDKPaymentInfo.goodsId = tostring(goodsId)
				SDKPaymentInfo.platformGoodsId = tostring(goodsId)
				SDKPaymentInfo.outOrderNo = outOrderNo
				SDKPaymentInfo.zoneId = tostring(zoneId)
				SDKPaymentInfo.exStr = exStr
				SDKPaymentInfo.sign = sign

				printWarn("SDKPaymentInfo", SDKPaymentInfo.roleId, SDKPaymentInfo.callBackStr, SDKPaymentInfo.money, SDKPaymentInfo.gameGold, SDKPaymentInfo.moreCharge, SDKPaymentInfo.payType, SDKPaymentInfo.productName, SDKPaymentInfo.coinsAmount, SDKPaymentInfo.rate, SDKPaymentInfo.goodsId, SDKPaymentInfo.outOrderNo, SDKPaymentInfo.zoneId, SDKPaymentInfo.exStr, SDKPaymentInfo.sign)

				SDKGameRoleInfo.type = 4
				SDKGameRoleInfo.roleId = roleId
				SDKGameRoleInfo.roleName = roleName
				SDKGameRoleInfo.roleLevel = roleLevel
				SDKGameRoleInfo.serverId = tostring(zoneId)
				SDKGameRoleInfo.serverName = serverName
				SDKGameRoleInfo.roleCTime = roleCTime
				SDKGameRoleInfo.loginTime = loginTime
				SDKGameRoleInfo.lastLogoutTime = lastLogoutTime
				SDKGameRoleInfo.registerTime = registerTime

				printWarn("SDKGameRoleInfo", SDKGameRoleInfo.roleId, SDKGameRoleInfo.roleName, SDKGameRoleInfo.roleLevel, SDKGameRoleInfo.serverId, SDKGameRoleInfo.serverName, SDKGameRoleInfo.roleCTime, SDKGameRoleInfo.loginTime, SDKGameRoleInfo.lastLogoutTime, SDKGameRoleInfo.registerTime)

				if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
					ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Store)
				end

				SDKManager.getSDKInstacne():registerPayListener(self.payCallBack)
				RechargeFacade.instance:pay(SDKPaymentInfo, SDKGameRoleInfo)
				GlobalDispatcher:dispatchEvent(EventType.REFRESH_GOODSITEM_DATA, false)
			else
				self:sendGetMallListRequest()
				GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR, status)
			end
		end
	})
end

function StoreAgent:upgradeAccount()
	if SDKManager.getSDKInstacne():isShowGuestUpgradeAccount() then
		SDKManager.getSDKInstacne():registerGuestUpgradeListener(function(statusCode, statusDesc)
			if statusCode == SDKManager.STATUS_GUEST_UPGRADE_SUCCESS then
				UserAgent.instance:sendNotifyRealNameInfoUpdateRequest()
			elseif statusCode == SDKManager.STATUS_GUEST_UPGRADE_CANCEL then
				printError(lang("guest upgrade tourist cancel..."))
			else
				printError(lang("guest upgrade tourist fail ...") .. statusDesc)
				FloatWordMgr.instance:show(string.format("%d:%s", statusCode, statusDesc))
			end

			SDKManager.getSDKInstacne():unregisterGuestUpgradeListener()
		end)
		SDKManager.getSDKInstacne():gotoGuestUpgradeAccount()
	else
		printError(lang("guest upgrade tourist not support..."))
	end
end

function StoreAgent.payCallBack(statusCode, statusDesc)
	SDKManager.getSDKInstacne():unregisterPayListener()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Store)
	printWarn("function StoreAgent:payCallBack()", statusCode, statusDesc)

	if statusCode == SDKManager.STATUS_OK then
		LoadingFacade.instance:showWaiting(ViewBlockKey.Store)
		settimer(kPayWaitingMaxTime, StoreAgent._delayCancelWaitPay, StoreAgent, false)
	end
end

function StoreAgent._delayCancelWaitPay()
	LoadingFacade.instance:hideWaiting(ViewBlockKey.Store)
end

function StoreAgent:sendManualRefreshGoodsRequest(mallId, tabId)
	local req = MallExtension_pb.ManualRefreshGoodsRequest()

	req.mallId = mallId

	self:invoke({
		funcName = "handleManualRefreshGoodsReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local tabId = tabId
				local storeId = mallId

				StoreModel.instance:updateStoreByAgent(msg.mall)
				StoreModel.instance:clearGoodsData(storeId)

				for index, goods in ipairs(msg.goods) do
					self:_checkGoods(goods, tabId)
				end

				GlobalDispatcher:dispatchEvent(EventType.REFRESH_GOODSITEM_DATA, true)
			else
				self:sendGetMallListRequest()
				GlobalDispatcher:dispatchEvent(EventType.STORE_STATE_CODE_ERROR, status)
			end
		end
	})
end

function StoreAgent:handleMonthlyCardRewardPush(status, msg)
	if status == 0 then
		local tabId = StoreModel.instance:getTabIdByGoodsId(msg.monthlyCard.monthlyCardGoods.goodsId)

		self:_checkGoods(msg.monthlyCard, tabId)
		StoreController.instance:setMonthCardReward(true)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_MONTH_CARD_DATA)
	end
end

function StoreAgent:sendTryTakeMonthlyCardRewardRequest(goodsId)
	local req = MallExtension_pb.TryTakeMonthlyCardRewardRequest()

	req.goodsId = goodsId

	self:sendMsg(req)
end

function StoreAgent:handleTryTakeMonthlyCardRewardReply(status)
	if status == 0 then
		-- block empty
	end

	StoreController.instance:setMonthCardReward(false)
	GlobalDispatcher:dispatchEvent(EventType.ON_TAKE_MONTH_CARD_REWARD, status)
end

function StoreAgent:handleOrderSuccessPush(status, msg)
	removetimer(StoreAgent._delayCancelWaitPay, StoreAgent)
	LoadingFacade.instance:hideWaiting(ViewBlockKey.Store)

	if status == 0 then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Store)

		local mallId = msg.goods and msg.goods.commonInfo.mallId or nil

		if not mallId then
			if enableErrorLog then
				printError("StoreAgent:handleOrderSuccessPush could not found mallId")
			end

			return
		end

		local tabId = StoreConfig.instance:getStoreTabId(mallId)

		if tabId then
			self:_checkGoods(msg.goods, tabId)
			GlobalDispatcher:dispatchEvent(EventType.REFRESH_GOODSITEM_DATA, false, true)
		end
	end
end

function StoreAgent:handleMallUpdatePush(status, msg)
	if status == 0 then
		if not ViewMgr.instance:isOpen(ViewName.StoreMainViewViewPresentor) then
			return
		end

		local len = #msg.mall

		for i = 1, len do
			if msg.mall[i] == 0 then
				self:sendGetMallListRequest()
			elseif msg.mall[i] > 0 then
				local storeId = msg.mall[i]

				self:sendGetGoodsListRequest({
					storeId
				})
			end
		end
	end
end

local defualtRecommendId = 10000

function StoreAgent:checkEnableShow(checkList)
	local req = MallExtension_pb.GetMallListRequest()

	self:invoke({
		funcName = "handleGetMallListReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local req2 = MallExtension_pb.GetGoodsListRequest()

				StoreModel.instance:initStoreByAgent(msg.mall)

				local storeInfos = {}

				for i = 1, #msg.mall do
					local storeId = msg.mall[i].mallId
					local tabId = StoreModel.instance:getTabIdByStoreId(storeId)

					table.insert(storeInfos, {
						storeId = storeId,
						tabId = tabId
					})
					table.insert(req2.mallId, storeId)
				end

				self:invoke({
					funcName = "handleGetGoodsListReply",
					sendData = req2,
					handleCall = function(status, msg)
						if status == 0 then
							for i = 1, #storeInfos do
								local tmpStoreId = storeInfos[i].storeId

								StoreModel.instance:clearGoodsData(tmpStoreId)
							end

							for index, goods in ipairs(msg.goods) do
								self:_checkGoods(goods, nil)
							end

							local result = {}

							for i = 1, #checkList do
								local code = checkList[i].code

								if code ~= defualtRecommendId then
									local tempStoreId = checkList[i].data:getStoreId()
									local tempGoodsId = checkList[i].data:getGoodsId()
									local storeMo = StoreModel.instance:getStoreMoByID(tempStoreId)

									if storeMo and storeMo:getIsOnLine() and tempGoodsId then
										local tempTabId = StoreModel.instance:getTabIdByStoreId(tempStoreId)
										local goodlist = StoreModel.instance:getGoodsList(tempTabId, tempStoreId)

										for index, goodMo in pairs(goodlist) do
											if goodMo:getGoodsId() == tempGoodsId then
												table.insert(result, checkList[i])

												break
											end
										end
									end
								else
									table.insert(result, checkList[i])
								end
							end

							GlobalDispatcher:dispatchEvent(EventType.REFRESH_RECOMMEND_LIST, result)
						end
					end
				})
			end
		end
	})
end

StoreAgent.instance = StoreAgent.New()

return StoreAgent
