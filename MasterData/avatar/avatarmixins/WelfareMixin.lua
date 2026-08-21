-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\WelfareMixin.lua

local UIManager = UIManager
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local ResRandClient = require("ClientData/ResRandClient")
local ResFund = require("ClientData/ResFund")
local ResRecharge = require("ClientData/ResRecharge")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResPushGiftPkgMisc = require("ClientData/ResPushGiftPkgMisc")
local ResPushGiftPkg = require("ClientData/ResPushGiftPkg")
local ResBattlePassLevel = require("ClientData/ResBattlePassLevel")
local ResBattlePassTask = require("ClientData/ResBattlePassTask")
local ResVip = require("ClientData/ResVIP")
local EventConst = require("EventConst")
local RPC = require("Framework/RPC")
local ResPrivilege = require("ClientData/ResPrivilege")
local ResMallMisc = require("ClientData/ResMallMisc")
local ResMallFirstRecharge = require("ClientData/ResMallFirstRecharge")
local ResOpActivityGiftDetail = require("ClientData/ResOpActivityGiftDetail")
local VersionUtils = require("System/VersionUtils")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResCardClient = require("ClientData/ResCardClient")
local Analytics = require("SDK/Analytics")
local UserData = require("Helper/UserData")
local ResItem = require("ClientData/ResItem")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ResRechargeGuideConfig = require("ClientData/ResRechargeGuideConfig")
local ResRechargeGuideMain = require("ClientData/ResRechargeGuideMain")
local ResPushGiftControl = require("ClientData/ResPushGiftControl")
local WelfareMixin = {}

WelfareMixin.WELFARE_INFO = {
	Fund = {
		needHide = false,
		redDot = UIConst.RD_HINT_FUND
	},
	NewBee = {
		needHide = true,
		redDot = UIConst.RD_HINT_NEWBEE
	},
	NewBee2 = {
		needHide = true,
		redDot = UIConst.RD_HINT_NEWBEE
	},
	DayBee = {
		needHide = false,
		redDot = UIConst.RD_HINT_DAYBEE
	},
	WeekBee = {
		needHide = false,
		redDot = UIConst.RD_HINT_WEEKBEE
	},
	MonthBee = {
		needHide = false,
		redDot = UIConst.RD_HINT_MONTNBEE
	},
	MonthCard = {
		needHide = false,
		redDot = UIConst.RD_HINT_MONTHCARD
	},
	BPAward = {
		needHide = false,
		redDot = UIConst.RD_HINT_BPAWARD
	},
	BPTask = {
		needHide = false
	},
	VipBenefit = {
		needHide = false,
		redDot = UIConst.RD_HINT_VIP_BENEFIT
	},
	RechargeGift = {
		needHide = false,
		redDot = UIConst.RD_HINT_RECHARGE_GIFT
	},
	PrivilegeMonthCard = {
		needHide = true,
		redDot = UIConst.RD_HINT_PRIVILEGEMONTH
	}
}

function WelfareMixin:initBaseWelfareMixin(baseData)
	self.rechargeReplaced = {}
	self.actGiftData = {}
	self.actId2WelfareType = {}
end

function WelfareMixin:initWelfareMixin(baseData, syncData)
	self.testType = Const.TEST_TYPE_A
	self.welfareToGetAward = {}
	self.welfareHide = {}
	self._GiftData = {}
	self.monthCardServerData = {}

	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	self.rechage2WelType = {}
	self._slot4ProductLoaded = Slot(self.checkToGetaward, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	self:rechargeIdToWelfare()

	self.welfareTimer = {}

	local welBaseData = baseData.necessary.welfare

	if welBaseData == nil then
		-- block empty
	else
		self:initFundData(welBaseData.fund)
		self:initMonthCardData(welBaseData.card.item)
		self:initRedPacketData(welBaseData.red_packet)
		self:initBPData(syncData.other.battle_pass)
		self:initVIPData(syncData.other.vip)
		self:initFirstRechargeData(syncData.other.recharge)
	end
end

function WelfareMixin:postinitWelfareMixin(baseData, syncData)
	local welBaseData = baseData.necessary.welfare

	if welBaseData == nil then
		-- block empty
	else
		self:initPushData(welBaseData.push_gift.trigger)
	end

	self:refreshFakeActs()
end

function WelfareMixin:getRechage2WelType(rechargeId)
	return self.rechage2WelType[rechargeId]
end

function WelfareMixin:rechargeIdToWelfare()
	self.rechage2WelType = {}

	for idx, welfare in pairs(ResMallSubPanelConfig) do
		if welfare.includeGiftId then
			for _, id in ipairs(welfare.includeGiftId) do
				if not self.rechage2WelType[id] then
					self.rechage2WelType[id] = welfare.pageType
				end
			end
		end
	end
end

function WelfareMixin:initMallClientData()
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	for idx, data in pairs(ResMallSubPanelConfig) do
		if data.includeGiftId then
			self:initGiftClientData(data)
		elseif data.limitTypeExtra then
			if data.limitTypeExtra == 1 then
				local actId = data.limitConditionExtra

				if actId then
					self.actId2WelfareType[actId] = data.pageType

					local actObj = self:getActivityObj(actId)

					if actObj then
						self:initActGiftData(actObj)
					end
				end
			elseif data.limitTypeExtra == 2 then
				for i, actId in ipairs(data.arg4 or {}) do
					self.actId2WelfareType[actId] = data.pageType

					local actObj = self:getActivityObj(actId)

					if actObj then
						self:initActGiftData(actObj)
					end
				end
			elseif data.limitTypeExtra == 3 then
				local actId = data.limitConditionExtra

				if actId then
					self.actId2WelfareType[actId] = data.pageType

					local actObj = self:getActivityObj(actId)

					if actObj then
						self:initActGiftData(actObj)
					end
				end

				for i, actId in ipairs(data.arg4 or {}) do
					self.actId2WelfareType[actId] = data.pageType

					local actObj = self:getActivityObj(actId)

					if actObj then
						self:initActGiftData(actObj)
					end
				end
			end
		end
	end

	self:checkBPRedDot()
	self:refreshFundClientData()
	self:checkUserDataMallNew()
end

function WelfareMixin:addRechargeReplaced(rechargeId, repRechargeId, actObj)
	self.rechargeReplaced[rechargeId] = {
		repRechargeId,
		actObj
	}
end

function WelfareMixin:delRechargeReplaced(rechargeId, repRechargeId, actObj)
	self.rechargeReplaced[rechargeId] = nil
end

function WelfareMixin:checkToGetaward()
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	self:checkNormalGiftAward()
	self:initMallClientData()
	self:checkActivityGiftNew()
end

function WelfareMixin:jumpToRecharge(funcCB)
	local isLocked = ConditionLimitManager.inLimitState(Const.MONEY_BUY_JUMP_CONDITION[Const.MONEY_ID_DIAMOND])

	if VersionUtils.IsRechargeDisabled() == true then
		MsgManager.notice(Lang.get(1915))
	elseif isLocked then
		local limitId = Const.MONEY_BUY_JUMP_CONDITION[Const.MONEY_ID_DIAMOND]

		MsgManager.notice(ResConditionLimit[limitId].unlock_desc)
	else
		if funcCB then
			funcCB()
		end

		local ui = UIManager.getUI("mallDlg", true)

		if ui then
			ui:onShow(Const.MALL_TYPE_FULI_TAB)
		end
	end
end

function WelfareMixin:setWelfareHide(type, isHide)
	self.welfareHide[type] = isHide
end

function WelfareMixin:isWelfareHide(pageType)
	return self.welfareHide[pageType] or false
end

function WelfareMixin:onNewDayMall()
	self:checkToGetaward()
end

function WelfareMixin:initFundData(fund)
	local season = fund.season
	local clientData = {}
	local cData = {}

	for index, data in ipairs(ResFund) do
		if data.season == season then
			table.insert(cData, data)
		end
	end

	clientData.data = cData
	self.fundData = clientData
	self.fundSvrData = {}
	self.fundSvrData.awards = {}

	self:refreshFundSvrData(fund)
end

function WelfareMixin:refreshFundSvrData(data)
	local mData = {}

	mData.isBuy = data.is_buy
	mData.awards = {}
	mData.season = data.season

	local bits = ClientUtils.getBitsListFromByteString(data.award_flag.permanance)

	for idx, id in pairs(bits) do
		mData.awards[id] = true
	end

	self.fundSvrData = mData

	self:refreshFundClientData()
end

function WelfareMixin:refreshFundClientData()
	local preData = self.fundData.data
	local svrData = self.fundSvrData
	local totalAwardNum = 0
	local canGetAwardNum = 0
	local hasGetAwardNum = 0

	for idx, data in ipairs(preData) do
		local isLock = ConditionLimitManager.inLimitState(data.limit)
		local money = ResRandClient[data.award].show_nums[1]
		local awardState = 0

		totalAwardNum = totalAwardNum + money

		if svrData.awards[data.id] == true then
			hasGetAwardNum = hasGetAwardNum + money
			awardState = 3
		else
			awardState = 1
		end

		awardState = isLock == true and 2 or awardState
		canGetAwardNum = canGetAwardNum + (awardState == 1 and money or 0)
		self.fundData.data[idx].awardState = awardState
	end

	self.fundData.totalAwardNum = totalAwardNum
	self.fundData.canGetAwardNum = canGetAwardNum
	self.fundData.hasGetAwardNum = hasGetAwardNum

	self:_checkFundAward()
	self:_checkHasGetAll()
end

function WelfareMixin:_checkHasGetAll()
	for i, data in ipairs(self.fundData.data) do
		if not self.fundSvrData.awards[data.id] then
			return
		end
	end

	self.welfareHide[Const.WELFARETYPE_FUND] = true
end

function WelfareMixin:_checkFundAward()
	local hasNewGet = false
	local noBuyNew = false

	if self.fundSvrData.isBuy == 1 then
		for k, v in ipairs(self.fundData.data) do
			if v.awardState == 1 then
				hasNewGet = true

				break
			end
		end
	else
		local maxCanGet

		for k, v in ipairs(self.fundData.data) do
			if v.awardState == 1 then
				maxCanGet = k
			end
		end

		if maxCanGet and (self.fundSvrData.season == 0 and maxCanGet > 5 or self.fundSvrData.season ~= 0) then
			local hasShowTable = UserData.getClientData(Const.USER_KEY_FUND_DATA) or {}

			if hasShowTable[self.fundSvrData.season] == nil or maxCanGet > hasShowTable[self.fundSvrData.season] then
				noBuyNew = true
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_FUND, hasNewGet)
	RedDotManager.setKeyState(UIConst.RD_HINT_FUND_NO_BUY, noBuyNew)
end

function WelfareMixin:setFundLooked()
	if self.fundSvrData.isBuy ~= 1 then
		local maxCanGet

		for k, v in ipairs(self.fundData.data) do
			if v.awardState == 1 then
				maxCanGet = k
			end
		end

		local hasShowTable = UserData.getClientData(Const.USER_KEY_FUND_DATA) or {}

		if self.fundSvrData.season then
			hasShowTable[self.fundSvrData.season] = maxCanGet
		end

		UserData.setClientData(Const.USER_KEY_FUND_DATA, hasShowTable)
		self:_checkFundAward()
	end
end

function WelfareMixin:getFundData()
	return self.fundSvrData, self.fundData
end

WelfareMixin.periodTime = {
	[Const.WELFARETYPE_DAYBEE] = 1,
	[Const.WELFARETYPE_WEEKBEE] = 2,
	[Const.WELFARETYPE_MONTHBEE] = 3
}

function WelfareMixin:checkNormalGiftAward()
	for _, gift in pairs(ResMallSubPanelConfig) do
		if gift.includeGiftId ~= nil then
			local hasFree = false

			for idx, giftId in ipairs(gift.includeGiftId) do
				local product = RechargeManager.getProductByRechargeId(giftId)

				if product then
					if self.rechargeReplaced[product.rechargeId] then
						local newRechargeInfo = self.rechargeReplaced[product.rechargeId]
						local newRechargeId = newRechargeInfo[1]
						local actObj = newRechargeInfo[2]
						local newProduct = RechargeManager.getProductByRechargeId(newRechargeId)

						if newProduct and actObj:isValid() then
							product = newProduct
						end
					end

					if product:hasFreeNew() and product:isProductValid() and product.buyTimesLeft ~= 0 then
						hasFree = true

						break
					end
				end
			end

			if hasFree == true then
				self.welfareToGetAward[gift.pageType] = true

				RedDotManager.setKeyState(WelfareMixin.WELFARE_INFO[gift.pageType].redDot, true)
			else
				RedDotManager.setKeyState(WelfareMixin.WELFARE_INFO[gift.pageType].redDot, false)

				self.welfareToGetAward[gift.pageType] = false
			end
		end
	end
end

function WelfareMixin:_getNewBeeTime(subConfigData)
	local svTime = ClientUtils.getServerTime()
	local existTime = subConfigData.value1
	local newBeeTick = ClientUtils.getServerTimeByTimeStr(ResMallMisc[1].newBee_tick)
	local timePass

	if subConfigData.arg1 ~= 1 then
		if newBeeTick >= self.roleCreateTick then
			timePass = svTime - self.roleCreateTick
		end
	elseif newBeeTick < svTime then
		if newBeeTick >= self.roleCreateTick then
			timePass = svTime - newBeeTick
		else
			timePass = svTime - self.roleCreateTick
		end
	end

	if timePass then
		return existTime * 86400 - timePass
	end

	return 0
end

function WelfareMixin:initGiftClientData(data)
	local giftType = data.pageType

	if not self._GiftData[giftType] then
		self._GiftData[giftType] = {}
	end

	self._GiftData[giftType].gifts = {}

	local giftList = {}

	giftList = data.includeGiftId

	local list = {}
	local needCheckProduct = true

	if Const.WELFARETYPE_NEWBEE_GROUP[giftType] then
		needCheckProduct = self:_getNewBeeTime(data) > 0
	end

	if needCheckProduct then
		local curVipValue = self.vipLevel

		for idx, id in ipairs(giftList) do
			if ClientUtils.isRechargeIdValid(id) then
				table.insert(list, id)
			end
		end
	end

	self._GiftData[giftType].giftList = list

	self:refreshGiftData(giftType)
end

function WelfareMixin:refreshGiftData(giftType)
	local giftRemain = 0

	if not self._GiftData then
		return
	end

	for index, id in ipairs(self._GiftData[giftType].giftList) do
		local product = RechargeManager.getProductByRechargeId(id)

		if product then
			product.index = index
			self._GiftData[giftType].gifts[id] = product
			giftRemain = giftRemain + product.buyTimesLeft
		end
	end

	if giftRemain == 0 then
		if WelfareMixin.WELFARE_INFO[giftType].needHide == true then
			self.welfareHide[giftType] = true
		else
			self.welfareHide[giftType] = #self._GiftData[giftType].giftList == 0
		end
	else
		self.welfareHide[giftType] = false
	end

	self:refreshGiftUI(giftType)
end

function WelfareMixin:getGiftData(giftType)
	if self._GiftData and self._GiftData[giftType] then
		return self._GiftData[giftType]
	end

	return nil
end

function WelfareMixin:refreshGiftUI(giftType)
	local ui = UIManager.getUI("mallDlg", nil, false)

	if ui then
		ui:refreshWelData(giftType)
	end
end

function WelfareMixin:initMonthCardData(card)
	self.monthCardServerData = {}

	for index, data in pairs(card) do
		local resData = ResCardClient[data.id]

		if resData and resData.recharge_id then
			for _, rId in ipairs(resData.recharge_id) do
				self.monthCardServerData[rId] = data
			end
		end
	end
end

function WelfareMixin:refreshMCardClientData()
	local data

	for _, v in pairs(ResMallSubPanelConfig) do
		if v.pageType == Const.WELFARETYPE_MONTHCARD then
			data = v

			break
		end
	end

	if not data then
		return
	end

	self:initGiftClientData(data)
end

function WelfareMixin:getMonthCardData()
	local monthData = {}

	if self._GiftData and self._GiftData[Const.WELFARETYPE_MONTHCARD] then
		for _, rechargeId in ipairs(self._GiftData[Const.WELFARETYPE_MONTHCARD].giftList) do
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product then
				table.insert(monthData, product)
			end
		end
	end

	return monthData, self.monthCardServerData
end

function WelfareMixin:onSubscribeGetAwardResp(...)
	if self._GiftData and self._GiftData[Const.WELFARETYPE_PRIVILEGEMONTHCARD] then
		for _, rechargeId in ipairs(self._GiftData[Const.WELFARETYPE_PRIVILEGEMONTHCARD].giftList) do
			local data = self:getSubscribeDataByRechargeId(rechargeId)

			if data then
				data.awardGet = 1
			end
		end
	end

	local ui = UIManager.getUI("mallDlg", nil, false)

	if ui then
		ui:refreshWelData(Const.WELFARETYPE_PRIVILEGEMONTHCARD)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_FIRST_SUBSCRIBE_AWARD_NOT_GOT, false)
end

function WelfareMixin:getPrivilegeMonthCardData(...)
	local monthData = {}
	local svrData = {}

	if self._GiftData and self._GiftData[Const.WELFARETYPE_PRIVILEGEMONTHCARD] then
		for _, rechargeId in ipairs(self._GiftData[Const.WELFARETYPE_PRIVILEGEMONTHCARD].giftList) do
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product then
				table.insert(monthData, product)
			end

			local efftive = self:checkSubscribeEffective(rechargeId)

			if efftive then
				svrData.efftive = true
			end

			local data = self:getSubscribeDataByRechargeId(rechargeId)

			if data then
				svrData.endtime = data.endTime
				svrData.firstBuyAwardGet = data.awardGet
			end
		end
	end

	return monthData, svrData
end

function WelfareMixin:checkPrivielgeMonthCardEffect()
	local resData, svrData = self:getPrivilegeMonthCardData()

	if svrData and svrData.efftive then
		return true
	else
		return false, svrData.endtime
	end

	return false
end

function WelfareMixin:monthCardInEffect(recharge_id)
	if self.monthCardServerData[recharge_id] and self.monthCardServerData[recharge_id].endtime and ClientUtils.getServerTime() <= self.monthCardServerData[recharge_id].endtime then
		return true
	end
end

function WelfareMixin:initPushData(data)
	self.pushGift = {}
	self.newPushGifts = {}
	self.pushGiftRechargeIdMap = {}
	self.totalPushGifts = {}
	self.cachedPushGiftData = {}

	ClientTimerManager.stopGlobalTimer("PushGiftRefreshCachedData")

	local lastTime = ResPushGiftPkgMisc[1].gift_last_time

	for index, tData in pairs(data) do
		if self.pushGiftRechargeIdMap[tData.recharge_id] ~= tData.content_id then
			utils.SetRechargeContent(tData.recharge_id, tData.content_id)

			self.pushGiftRechargeIdMap[tData.recharge_id] = tData.content_id

			local gift = tData

			gift.endTime = tData.start_time + lastTime
			gift.noticeType = ResPushGiftPkg[gift.gift_id].noticeType

			local needCache = false

			if ResPushGiftControl[gift.gift_id] and ResPushGiftControl[gift.gift_id] then
				local delayTime = ResPushGiftControl[gift.gift_id].gift_delay_time
				local startTime = delayTime + gift.start_time

				if startTime >= ClientUtils.getServerTime() then
					if not self.cachedPushGiftData then
						self.cachedPushGiftData = {}
					end

					table.insert(self.cachedPushGiftData, gift)

					needCache = true
				end
			end

			if not needCache then
				self:setPushGiftData(gift)
			end
		end
	end

	if self.cachedPushGiftData and #self.cachedPushGiftData ~= 0 then
		self:solveCachedPushGiftData()
	end

	self:openPushGiftAct()
end

function WelfareMixin:openPushGiftAct()
	if self.testType ~= Const.TEST_TYPE_B then
		return
	end

	local giftActs = {}

	self.pushGiftActs = {}

	if self.pushGift then
		local svrTime = ClientUtils.getServerTime()

		for _, data in pairs(self.pushGift) do
			if svrTime <= data.endTime then
				giftActs[#giftActs + 1] = data
			end
		end
	end

	table.sort(giftActs, function(a, b)
		if a.endTime == b.endTime then
			return a.gift_id < b.gift_id
		else
			return a.endTime < b.endTime
		end
	end)

	for i = 1, #giftActs do
		if giftActs[i] then
			self:openFakeActivityObj(Const.FAKE_ACT_PUSH_GIFT, giftActs[i].recharge_id, giftActs[i].endTime, Const.ACT_TYPE_GIFT)
		end

		self.pushGiftActs[i] = giftActs[i]
	end
end

function WelfareMixin:closePushGiftAct()
	if self.pushGiftActs then
		for i, gift in ipairs(self.pushGiftActs) do
			self:closeFakeActivityObj(Const.FAKE_ACT_PUSH_GIFT, gift.recharge_id)
		end

		self.pushGiftActs = nil
	end
end

function WelfareMixin:getPushGift(newPageMode)
	local gifts = {}

	for rechargeId, data in pairs(self.pushGift) do
		local giftData = ResPushGiftPkg[data.gift_id] or {}

		if newPageMode == true then
			if giftData.client_page_id then
				gifts[rechargeId] = data
			end
		elseif not giftData.client_page_id then
			gifts[rechargeId] = data
		end
	end

	return gifts
end

function WelfareMixin:getNewPushGift()
	return self.newPushGifts
end

function WelfareMixin:delNewPushGift(uiName, dotType)
	if self.newPushGifts and self.newPushGifts[uiName] and self.newPushGifts[uiName][dotType] then
		local data = {}

		for idx, gift in ipairs(self.newPushGifts[uiName][dotType] or {}) do
			table.insert(data, gift.gift_id)
		end

		if #data ~= 0 then
			RPC.welfarePushGiftPopupSet(data)
		end

		self.newPushGifts[uiName][dotType] = nil
	end
end

function WelfareMixin:onWelfarePushGiftPopupSetResp(data)
	for idx, id in pairs(data or {}) do
		if self.totalPushGifts then
			self.totalPushGifts[id] = true
		end
	end
end

function WelfareMixin:checkPushGiftTrigger(uiName, dotType)
	if ClientUtils.isInBeginner() then
		return false
	end

	local gift = self:getNewPushGift()

	if gift then
		self:closePushGiftAct()
		self:openPushGiftAct()
	else
		return
	end

	if self.testType == Const.TEST_TYPE_A and gift[uiName] and gift[uiName][dotType] then
		local gifts = {}

		for _, g in pairs(gift[uiName][dotType]) do
			g.action = ResPushGiftPkg[g.gift_id].action or 0
			g.param = ResPushGiftPkg[g.gift_id].param or 0
			g.noticeType = ResPushGiftPkg[g.gift_id].noticeType
			gifts[#gifts + 1] = g

			local product = RechargeManager.getProductByRechargeId(g.recharge_id)

			if not product then
				return
			end
		end

		table.sort(gifts, function(a, b)
			if a.action == b.action then
				return a.param > b.param
			else
				return a.action > b.action
			end
		end)

		self.toShowPushGift = gifts

		self:delNewPushGift(uiName, dotType)
		self:showPushGift()
	end
end

function WelfareMixin:showPushGift()
	if self.toShowPushGift and #self.toShowPushGift > 0 then
		local gift = self.toShowPushGift[#self.toShowPushGift]

		table.remove(self.toShowPushGift)
		UIManager.getUI("welfarePushGiftDlg", true):setData(gift, Slot(self.showPushGift, self))
	else
		self.toShowPushGift = nil
	end
end

function WelfareMixin:checkShowPushGiftNotice()
	if self.noNewPushGift then
		return nil, nil
	end

	local CurPushGift = self.typeBCurPushGift
	local gift = ClientUtils.getMostValueByKey(self.pushGift, "endTime")

	if not gift or not (gift.endTime > 0) then
		self:clearToShowGift()

		return nil, nil
	end

	if CurPushGift and CurPushGift.gift_id == gift.gift_id then
		return self.typeBCurPushGift, false
	else
		self.typeBCurPushGift = gift

		return self.typeBCurPushGift, true
	end
end

function WelfareMixin:clearToShowGift()
	self.toShowPushGift = nil
	self.noNewPushGift = true
	self.typeBCurPushGift = nil
end

function WelfareMixin:initBPData(data)
	local srvData = {}

	srvData.normalAward = {}
	srvData.superAward = {}
	srvData.taskHasGet = {}
	srvData.taskCanGet = {}
	srvData.hasBuy = data.is_super or 0
	srvData.canReset = data.can_reset or 0
	srvData.taskData = {}

	local step = data.step or 1

	srvData.step = step > 0 and step or 1

	for taskId, data in ipairs(data.task) do
		srvData.taskData[taskId] = {}
		srvData.taskData[taskId].award_time = data.award_time
	end

	srvData.currentSeason = data.current_season
	srvData.progress = {}

	if data.progress then
		for i, pro in ipairs(data.progress) do
			srvData.progress[i] = pro
		end
	end

	if data.normal_awarded then
		local bits = ClientUtils.getBitsListFromByteString(data.normal_awarded.bits)

		for idx, id in pairs(bits) do
			srvData.normalAward[id] = true
		end
	end

	if data.super_awarded then
		local bits = ClientUtils.getBitsListFromByteString(data.super_awarded.bits)

		for idx, id in pairs(bits) do
			srvData.superAward[id] = true
		end
	end

	self.bpServerData = srvData

	RPC.battlePassBpGetSystemData()
	self:refreshBPSrvData()
end

local TASK_GROUP_REDHINT = {
	UIConst.RD_HINT_BP_STARUP,
	UIConst.RD_HINT_BP_PVP,
	UIConst.RD_HINT_BP_DAILY,
	UIConst.RD_HINT_BP_MAZE
}

function WelfareMixin:refreshBPSrvData(needRefreshUI)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	local taskClientData = ResBattlePassTask
	local srvData = self.bpServerData or {}

	srvData.curValue = self:getMoneyByType(Const.MONEY_TYPE_BP) or 0

	local isMaxProgress = srvData.curValue >= ResBattlePassLevel[#ResBattlePassLevel][1].bp_need
	local group = {}

	for idx, data in pairs(taskClientData) do
		local stage = srvData.step

		if not stage then
			return
		end

		local info = data[stage]
		local id = info.task_id
		local actionType = info.task_type

		if not group[info.group_id] then
			group[info.group_id] = {}
		end

		local len = #group[info.group_id]

		group[info.group_id][len + 1] = false

		if srvData.progress[actionType] then
			if srvData.progress[actionType].value / info.task_param >= 1 then
				if not srvData.taskData[id] or srvData.taskData[id].award_time < srvData.progress[actionType].value then
					srvData.taskCanGet[id] = true

					if not isMaxProgress then
						group[info.group_id][len + 1] = true
					elseif ResRandClient[info.award] then
						local items = ResRandClient[info.award].show_ids

						if items and #items > 1 then
							group[info.group_id][len + 1] = true
						elseif items and #items == 1 and items[1] ~= 100014 then
							group[info.group_id][len + 1] = true
						end
					end
				else
					srvData.taskCanGet[id] = false
				end
			end

			if srvData.taskData[id] and srvData.taskData[id].award_time == info.can_get_count then
				srvData.taskHasGet[id] = true
				group[info.group_id][len + 1] = false
			end
		end
	end

	self.bpTaskRedData = group
	self.bpServerData = srvData

	self:refreshBPClientData(needRefreshUI)
end

function WelfareMixin:checkBPTaskRedDot()
	local bpData

	for i_, welData in pairs(ResMallSubPanelConfig) do
		if welData.pageType == Const.WELFARETYPE_BPAWARD then
			bpData = welData
		end
	end

	if not bpData then
		return
	elseif self.bpServerData then
		-- block empty
	else
		return
	end

	local bpTaskHide = self.welfareHide[Const.WELFARETYPE_BPTASK]

	if bpData.unlockCondition and ConditionLimitManager.inLimitState(bpData.unlockCondition) then
		self.welfareHide[Const.WELFARETYPE_BPTASK] = true

		return
	else
		local seasonValid = false

		if self.bpServerData.systemData and self.bpServerData.systemData.current_season ~= 0 then
			self.welfareHide[Const.WELFARETYPE_BPTASK] = false
			seasonValid = true
		end

		for index, Groups in pairs(self.bpTaskRedData) do
			local setRed = false

			for _, canGet in ipairs(Groups) do
				if canGet == true and seasonValid then
					setRed = true

					break
				end
			end

			if TASK_GROUP_REDHINT[index] then
				RedDotManager.setKeyState(TASK_GROUP_REDHINT[index], setRed)
			end
		end
	end
end

function WelfareMixin:refreshBPClientData(needRefreshUI)
	self.bpData = {}

	local srvData = self.bpServerData

	for idx, info in pairs(ResBattlePassLevel) do
		local stage = self.bpServerData.step

		if not stage then
			return
		end

		local data = info[stage]

		data.unLock = false

		if data.bp_need <= srvData.curValue then
			data.curLevel = data.level
			data.unLock = true
		end

		data.normalHasGet = false
		data.superHasGet = false
		data.normalToGet = false
		data.superToGet = false

		if srvData then
			if srvData.normalAward[data.level] then
				data.normalHasGet = true
			elseif data.normal_award and data.unLock == true then
				data.normalToGet = true
			end

			if srvData.superAward[data.level] then
				data.superHasGet = true
			elseif data.super_award and data.unLock == true and srvData.hasBuy ~= 0 then
				data.superToGet = true
			end
		end

		self.bpData[#self.bpData + 1] = data
	end

	table.sort(self.bpData, function(a, b)
		return a.level < b.level
	end)

	if needRefreshUI then
		local welType = Const.WELFARETYPE_BPAWARD

		self:startTimerByWelType(welType, 0.1)
	end
end

function WelfareMixin:checkBPAwardRedDot()
	local bpData

	for i_, welData in pairs(ResMallSubPanelConfig) do
		if welData.pageType == Const.WELFARETYPE_BPAWARD then
			bpData = welData
		end
	end

	if not bpData then
		return
	elseif self.bpServerData then
		-- block empty
	else
		return
	end

	local bpHide = self.welfareHide[Const.WELFARETYPE_BPAWARD]

	if bpData.unlockCondition and ConditionLimitManager.inLimitState(bpData.unlockCondition) == true then
		self.welfareHide[Const.WELFARETYPE_BPAWARD] = true

		return
	else
		local toGet = false

		for idx, srvData in ipairs(self.bpData) do
			if srvData and (srvData.normalToGet == true or srvData.superToGet == true) then
				toGet = true

				break
			end
		end

		if self.bpServerData.systemData and self.bpServerData.systemData.current_season ~= 0 then
			self.welfareHide[Const.WELFARETYPE_BPAWARD] = false
		else
			toGet = false
		end

		RedDotManager.setKeyState(UIConst.RD_HINT_BPAWARD, toGet)
	end
end

function WelfareMixin:getBpServerData()
	return self.bpServerData or {}
end

function WelfareMixin:getBPData()
	return self.bpData or {}
end

function WelfareMixin:checkBPRedDot()
	self:checkBPTaskRedDot()
	self:checkBPAwardRedDot()
end

function WelfareMixin:initVIPData(data)
	self.vipLevel = data.vip or 0
	self.vipSrvData = {}
	self.vipClientData = {}

	local mData = {}

	mData.curLevel = data.vip
	mData.curState = data.vip_hide
	mData.awards = {}

	local bits = ClientUtils.getBitsListFromByteString(data.vip_awarded.bits)

	for idx, id in pairs(bits) do
		mData.awards[id - 1] = true
	end

	self.vipSrvData = mData

	self:refreshVipSrvData()
end

function WelfareMixin:refreshVipSrvData()
	local awardState = {}
	local curValue = self:getMoneyByType(Const.MONEY_TYPE_VIP)
	local maxLevel = Const.VIP_MAX_LEVEL

	self.vipSrvData.value = curValue

	RedDotManager.setKeyState(UIConst.RD_HINT_VIP_BENEFIT, false)

	local curShowLevel, curCanGetLevel

	for i = 1, maxLevel + 1 do
		local data = ResVip[i - 1]
		local state = 0

		if not data.award then
			state = nil
		elseif curValue < data.need_exp then
			state = 0

			if not curShowLevel then
				curShowLevel = i - 2
			end
		elseif self.vipSrvData.awards[i - 1] then
			state = 2
		else
			state = 1

			RedDotManager.setKeyState(UIConst.RD_HINT_VIP_BENEFIT, true)

			curCanGetLevel = curCanGetLevel or i - 1
		end

		curShowLevel = curCanGetLevel and curCanGetLevel or curShowLevel
		awardState[i - 1] = state
	end

	curShowLevel = curShowLevel or maxLevel
	self.vipSrvData.curShowLevel = curShowLevel
	self.vipSrvData.awardState = awardState

	self:refreshVipClientData()
end

function WelfareMixin:refreshVipClientData()
	local clientData = {}

	for i = 1, Const.VIP_MAX_LEVEL + 1 do
		local mData = ResVip[i - 1]
		local priByType = {}

		if mData.privilege_id then
			for idx, id in ipairs(mData.privilege_id) do
				if ResPrivilege[id] then
					local type = ResPrivilege[id].type

					if not priByType[type] then
						priByType[type] = {}
					end

					priByType[type][id] = id
				end
			end
		end

		mData.priIdByType = priByType
		clientData[i - 1] = mData
	end

	self.vipClientData = clientData
end

function WelfareMixin:getVipClientData(level)
	if self.vipClientData then
		return self.vipClientData[level]
	end
end

function WelfareMixin:getVipSrvData()
	self:refreshVipSrvData()

	return self.vipSrvData or {}
end

function WelfareMixin:getVipShowState()
	if VersionUtils.IsRechargeDisabled() == true then
		return false
	end

	if self.vipSrvData then
		return self.vipSrvData.curState
	end
end

function WelfareMixin:setVipShowState(state)
	RPC.vIPSetHide(state)
end

function WelfareMixin:initFirstRechargeData(data)
	self.totalRechargeMoney = tonumber(data.sol_total_recharge_money)
	self.firstRechargeVersion = data.first_recharge_version or 1

	if self.firstRechargeVersion == 0 then
		self.firstRechargeVersion = 1
	end

	self.firstRechargeTriggerTick = data.get_first_award_tick or 0

	if self.firstRechargeVersion == 2 then
		UIManager.replacePrefabOfDlg("welfareSecondRecharge", 1924)
	else
		UIManager.replacePrefabOfDlg("welfareSecondRecharge", 1920)
	end

	self.clientFirstRechargeMaxTriggerLevel = UserData.loadCommonDataInt(CurAvatar.uid .. "_firstRechargeMaxTriggerLevel") or 0

	self:refreshFirstRechargeSvrData(data.first_recharge, true)
end

function WelfareMixin:onRechargeFirstNotify(recharge_info)
	self:initFirstRechargeData(recharge_info)
	self:refreshFirstRechargePanel()
end

function WelfareMixin:refreshFirstRechargeSvrData(recharge, checkInit)
	if checkInit then
		self.firstRechargeDataDic = {}
	end

	self.firstRechargeMaxTriggerLevel = recharge.reset_flag == 1 and 1 or 0

	local newLevelDic = {}

	if recharge and recharge.level then
		for _, rechargeData in ipairs(recharge.level) do
			if rechargeData.trigger_tick and rechargeData.trigger_tick > 0 then
				local data = {}
				local level = rechargeData.level

				data.level = level
				data.triggerTick = rechargeData.trigger_tick
				data.getStateDic = ClientUtils.getBitsDictFromByteString(rechargeData.awardbit)

				if data.level == 1 and self.firstRechargeTriggerTick == 0 then
					self.firstRechargeTriggerTick = rechargeData.trigger_tick
				end

				newLevelDic[level] = true
				self.firstRechargeDataDic[level] = data
				data.hasGet = true

				local config = self:getFirstRechargeConfig(level)

				if config then
					for index, targetInfo in ipairs(config.first_recharge_detail) do
						if not data.getStateDic[index] then
							data.hasGet = false

							break
						end
					end
				end

				if level > self.firstRechargeMaxTriggerLevel then
					self.firstRechargeMaxTriggerLevel = level
				end
			end
		end
	end

	for level, _ in pairs(self.firstRechargeDataDic) do
		if not newLevelDic[level] then
			self.firstRechargeDataDic[level] = nil
		end
	end

	self:refreshFirstRechargeRed()
end

function WelfareMixin:refreshFirstRechargeRed()
	local checkRed = false

	self.newUnlockFirstRechargeLevel = 0

	if self.firstRechargeMaxTriggerLevel > self.clientFirstRechargeMaxTriggerLevel and self:getFirstRechargeConfig(self.firstRechargeMaxTriggerLevel + 1) then
		checkRed = true
		self.newUnlockFirstRechargeLevel = self.firstRechargeMaxTriggerLevel + 1
	end

	if not checkRed then
		local canGetLevel = self:getFirstRechargeCanGetMaxLevel()

		checkRed = canGetLevel > 0
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_FIRST_RECHARGE, checkRed)
end

function WelfareMixin:checkFirstRechargeAllGet()
	local configList = ResMallFirstRecharge[self.firstRechargeVersion]

	for _, config in ipairs(configList) do
		local data = self.firstRechargeDataDic[config.level]

		if not data or not data.triggerTick or data.triggerTick <= 0 or not data.hasGet then
			return false
		end
	end

	return true
end

function WelfareMixin:getFirstRechargeCanGetMaxLevel()
	local configList = ResMallFirstRecharge[self.firstRechargeVersion]
	local res = 0

	for level, config in pairs(configList) do
		if res < level and self:checkFirstRechargeCanGet(level) then
			res = level
		end
	end

	return res
end

function WelfareMixin:checkFirstRechargeCanGet(level)
	local data = self.firstRechargeDataDic[level]

	if data then
		local config = self:getFirstRechargeConfig(level)

		if config then
			for index, targetInfo in ipairs(config.first_recharge_detail) do
				if not data.getStateDic[index] and self:firstRechargeEnable(targetInfo.target_type, targetInfo.target_args) then
					return true
				end
			end
		end
	end

	return false
end

function WelfareMixin:firstRechargeEnable(target_type, target_args)
	if target_type == 1 then
		local targetTick = ClientUtils.getServerTimeTodayStart(self.firstRechargeTriggerTick) + (target_args - 1) * Const.TIME_ONE_DAY
		local serverTime = ClientUtils.getServerTime()

		return targetTick <= serverTime
	elseif target_type == 2 then
		return self:isBattlePassedServerMode(target_args)
	end

	return true
end

function WelfareMixin:getFirstRechargeState()
	local firstRechargeConfig = self:getFirstRechargeConfig(1)

	if ConditionLimitManager.inLimitState(firstRechargeConfig.first_recharge_unlock_limit) then
		return false, false
	elseif self:checkFirstRechargeAllGet() then
		return false, self:secondRechargeEnable()
	else
		return true, false
	end
end

function WelfareMixin:secondRechargeEnable()
	return false
end

function WelfareMixin:refreshSecondRecharge()
	local firstRechargeConfig = self:getFirstRechargeConfig(1)
	local achieveId = firstRechargeConfig.append_achieve_id

	if achieveId and achieveId > 0 then
		local achState = self:getAchieveStatus(achieveId)

		if achState == Const.ACHIEVE_STATUS.COMPLETE then
			RedDotManager.setKeyState(UIConst.RD_HINT_SECOND_RECHARGE, true)
		else
			RedDotManager.setKeyState(UIConst.RD_HINT_SECOND_RECHARGE, false)
		end
	end
end

function WelfareMixin:getFirstRechargeConfig(level)
	return ResMallFirstRecharge[self.firstRechargeVersion][level]
end

function WelfareMixin:onFirstRechargeDlgOpen()
	if self.firstRechargeMaxTriggerLevel > self.clientFirstRechargeMaxTriggerLevel then
		self.clientFirstRechargeMaxTriggerLevel = self.firstRechargeMaxTriggerLevel

		UserData.saveCommonDataInt(CurAvatar.uid .. "_firstRechargeMaxTriggerLevel", self.clientFirstRechargeMaxTriggerLevel)
		self:refreshFirstRechargeRed()
	end
end

function WelfareMixin:onRechargeRoleFirstAwardNotify(recharge)
	self:refreshFirstRechargeSvrData(recharge)
	self:refreshFirstRechargePanel()
end

function WelfareMixin:refreshFirstRechargePanel()
	local firstRechargeDlg = UIManager.tryGetUI("welfareFirstRechargeDlg")

	if firstRechargeDlg then
		if self:checkFirstRechargeAllGet() then
			firstRechargeDlg:setVisible(false)
		else
			firstRechargeDlg:onDataChange()
		end
	end

	local mainMenuUI = UIManager.tryGetUI("mainMenu")

	if mainMenuUI then
		mainMenuUI:refreshFirstRechargeGift()
	end

	local newStageDlg = UIManager.tryGetUI("mainStageDlg")

	if newStageDlg then
		newStageDlg:refreshFirstRechargeGift()
	end
end

function WelfareMixin:refreshActGiftData(actObj)
	local actData = actObj.actData
	local pageType = self.actId2WelfareType[actObj.actId] or nil
	local redHint = UIConst.RD_HINT_ACTIVITY_CONFIG[actObj.actId]

	if redHint then
		local showRedDot = redHint and actObj.actData:checkNew() or false

		if actObj and actObj:isValid() then
			self.welfareHide[pageType] = false

			RedDotManager.setKeyState(redHint, showRedDot)
		else
			self.welfareHide[pageType] = true

			RedDotManager.setKeyState(redHint, false)
		end
	end

	self:startTimerByWelType(pageType, 0.1)
end

function WelfareMixin:initActGiftData(actObj)
	if actObj.actId and self.actId2WelfareType[actObj.actId] then
		self.actGiftData[actObj.actId] = actObj.actData

		self:refreshActGiftData(actObj)
	end
end

function WelfareMixin:getActGiftData(actId)
	return self.actGiftData[actId] or {}
end

function WelfareMixin:onWelfareFundNotify(fund)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	if fund.season ~= self.fundSvrData.season then
		local timer = Timer.New(Functor(self.initFundData, self, fund), 1.2)

		timer:Start()
	else
		self:initFundData(fund)
	end
end

function WelfareMixin:onWelfareGetAwardResp(type, resid)
	if type == "kCSWelfareTypeFund" then
		type = "Fund"

		for _, id in ipairs(resid) do
			self.fundSvrData.awards[id] = true
		end

		self:refreshFundClientData()
	end

	local welType = type

	self:startTimerByWelType(welType, 0.8)
end

function WelfareMixin.onWelfareTimer(type)
	local mallUI = UIManager.getUI("mallDlg", nil, false)
	local actUI = UIManager.getUI("activityMallDlg", nil, false)
	local petUI = UIManager.getUI("petMallDlg", nil, false)

	if mallUI then
		mallUI:refreshWelData(type)
	end

	if actUI then
		actUI:refreshWelData(type)
	end

	if petUI then
		petUI:refreshWelData(type)
	end
end

function WelfareMixin:onWelfareCardInfoNotify(cardData)
	if not self.monthCardServerData then
		self.monthCardServerData = {}
	end

	for idx, data in ipairs(cardData.item) do
		data.endtime = data.endtime - 1 or 0

		local resData = ResCardClient[data.id]

		if resData and resData.recharge_id then
			for _, rId in ipairs(resData.recharge_id) do
				self.monthCardServerData[rId] = data
			end
		end
	end

	self:refreshMCardClientData()
end

function WelfareMixin:onWelfarePushGiftTriggerNotify(triggers)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	self.noNewPushGift = nil
	self.newPushGifts = {}
	self.pushGift = {}

	local lastTime = ResPushGiftPkgMisc[1].gift_last_time

	for idx, data in pairs(triggers) do
		local gift = data

		gift.endTime = data.start_time + lastTime
		gift.noticeType = ResPushGiftPkg[gift.gift_id].noticeType

		local needCache = false

		if ResPushGiftControl[data.gift_id] and ResPushGiftControl[data.gift_id] then
			local delayTime = ResPushGiftControl[data.gift_id].gift_delay_time
			local startTime = delayTime + data.start_time

			if startTime >= ClientUtils.getServerTime() then
				if not self.cachedPushGiftData then
					self.cachedPushGiftData = {}
				end

				table.insert(self.cachedPushGiftData, gift)

				needCache = true
			end
		end

		if not needCache then
			self:setPushGiftData(gift)
		end
	end

	if self.cachedPushGiftData and #self.cachedPushGiftData ~= 0 then
		self:solveCachedPushGiftData()
	end

	self:refreshPushGiftRelateUI()
end

function WelfareMixin:setPushGiftData(gift)
	if not gift then
		return
	end

	self.pushGift[gift.recharge_id] = gift

	if self.pushGiftRechargeIdMap and self.pushGiftRechargeIdMap[gift.recharge_id] ~= gift.content_id then
		utils.SetRechargeContent(gift.recharge_id, gift.content_id)

		self.pushGiftRechargeIdMap[gift.recharge_id] = gift.content_id
	end

	if gift.wait_popup and gift.wait_popup == 0 then
		self.totalPushGifts[gift.gift_id] = true
	else
		local uiName = ResPushGiftPkg[gift.gift_id].uiName
		local dotType = ResPushGiftPkg[gift.gift_id].dotType

		if dotType == 1 then
			self.toShowPushGift = {
				gift
			}

			if self.testType == Const.TEST_TYPE_A then
				self:showPushGift()
			end
		else
			self.newPushGifts[uiName] = self.newPushGifts[uiName] or {}
			self.newPushGifts[uiName][dotType] = self.newPushGifts[uiName][dotType] or {}

			table.insert(self.newPushGifts[uiName][dotType], gift)
		end
	end
end

function WelfareMixin:solveCachedPushGiftData(...)
	ClientTimerManager.stopGlobalTimer("PushGiftRefreshCachedData")

	if self.cachedPushGiftData and #self.cachedPushGiftData ~= 0 then
		local minTick

		for idx = #self.cachedPushGiftData, 1, -1 do
			local data = self.cachedPushGiftData[idx]

			if data then
				local delayTime = ResPushGiftControl[data.gift_id].gift_delay_time
				local startTime = delayTime + data.start_time
				local tick = startTime - ClientUtils.getServerTime()

				if tick <= 0 then
					self:setPushGiftData(data)
					table.remove(self.cachedPushGiftData, idx)
				else
					minTick = minTick or tick
					minTick = math.min(tick, minTick)
				end
			end
		end

		if minTick and minTick > 0 then
			ClientTimerManager.startGlobalTimer("PushGiftRefreshCachedData", minTick, Functor(self.solveCachedPushGiftData, self))
		end
	end

	self:refreshPushGiftRelateUI()
end

function WelfareMixin:refreshPushGiftRelateUI(...)
	local mainMenuUI = UIManager.getUI("mainMenu", nil, false)

	if mainMenuUI then
		mainMenuUI:refreshPushGift()
	end

	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if mainStageDlg then
		mainStageDlg:refreshPushGift()
	end

	local actUI = UIManager.getUI("activityMainDlg", nil, false)

	if actUI then
		actUI:onRefreshBanner()
	end
end

function WelfareMixin:onBattlePassDataNotify(bp_data)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	if bp_data.current_season == 0 then
		self.welfareHide[Const.WELFARETYPE_BPAWARD] = true
		self.welfareHide[Const.WELFARETYPE_BPTASK] = true

		return
	else
		self.welfareHide[Const.WELFARETYPE_BPAWARD] = false
		self.welfareHide[Const.WELFARETYPE_BPTASK] = false
	end

	if self.bpServerData then
		self.bpServerData.systemData = bp_data
	end

	local welType = Const.WELFARETYPE_BPAWARD

	self:startTimerByWelType(welType, 0.1)

	local welTypeTask = Const.WELFARETYPE_BPTASK

	self:startTimerByWelType(welTypeTask, 0.1)
end

function WelfareMixin:onBattlePassRoleDataNotify(bp_data)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	if bp_data then
		self:initBPData(bp_data)
		self:checkBPRedDot()
	end

	local welType = Const.WELFARETYPE_BPAWARD

	self:startTimerByWelType(welType, 0.1)

	local welTypeTask = Const.WELFARETYPE_BPTASK

	self:startTimerByWelType(welTypeTask, 0.1)
end

function WelfareMixin:onBattlePassRoleTaskNotify(task_id, get_count)
	self.bpServerData.taskData[task_id] = self.bpServerData.taskData[task_id] or {}
	self.bpServerData.taskData[task_id].award_time = get_count

	self:refreshBPSrvData()
	self:checkBPRedDot()

	local welType = Const.WELFARETYPE_BPTASK

	self:startTimerByWelType(welType, 0.2)
end

function WelfareMixin:onBattlePassRoleSuperNotify(is_super)
	if self.bpServerData then
		self.bpServerData.hasBuy = is_super
	end

	self:checkBPRedDot()
end

function WelfareMixin:onBattlePassActionProgressNotify(action, progress)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	if self.bpServerData then
		self.bpServerData.progress[action] = self.bpServerData.progress[action] or {}
		self.bpServerData.progress[action].value = progress
	end

	self:refreshBPSrvData()
	self:checkBPRedDot()
end

function WelfareMixin:onBattlePassBpAwardNotify(level, normal_get, super_get)
	self.bpServerData.normalAward[level] = normal_get ~= 0
	self.bpServerData.superAward[level] = super_get ~= 0

	self:refreshBPClientData()
	self:checkBPRedDot()

	local welType = Const.WELFARETYPE_BPAWARD

	self:startTimerByWelType(welType, 0.2)
end

function WelfareMixin:onVIPLevelNotify(level)
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	self.vipLevel = level or 0

	ConditionLimitManager.triggerVipLevelUnlock(level)
	RPC.battlePassBpGetSystemData()
	self:refreshVipSrvData()

	local welType = Const.WELFARETYPE_VIPBENEFIT
	local ui = UIManager.getUI("rechargeVipDlg", nil, false)

	if ui then
		ui:refreshWelData(welType)
	end

	self:checkToGetaward()

	local ui = UIManager.getUI("mallDlg", nil, false)

	if ui then
		ui:onSetTabs()
		ui:openMall()
	end

	self:refreshNameUI()
end

function WelfareMixin:onVIPGetAwardResp(level)
	if level then
		self.vipSrvData.awards[level] = true
	end

	self:refreshVipSrvData()

	local welType = Const.WELFARETYPE_VIPBENEFIT
	local ui = UIManager.getUI("rechargeVipDlg", nil, false)

	if ui then
		ui:refreshWelData(welType)
	end
end

function WelfareMixin:onVIPSetHideResp(is_hide)
	if is_hide == 1 then
		MsgManager.clientNotice(189)
	else
		MsgManager.clientNotice(190)
	end

	self.vipSrvData.curState = is_hide

	local roleInfoPersonalDlg = UIManager.getUI("roleInfoPersonalDlg", nil, false)

	if roleInfoPersonalDlg then
		roleInfoPersonalDlg:onVipHideResp(is_hide)
	end

	self:refreshNameUI()
end

function WelfareMixin:startTimerByWelType(welType, cd)
	local mallUI = UIManager.getUI("mallDlg", nil, false)
	local actUI = UIManager.getUI("activityMallDlg", nil, false)
	local petUI = UIManager.getUI("petMallDlg", nil, false)

	if mallUI or actUI or petUI then
		if not self.welfareTimer[welType] then
			self.welfareTimer[welType] = Timer.New(Slot(self.onWelfareTimer, welType), cd)
		end

		self.welfareTimer[welType]:Restart()
	end
end

function WelfareMixin:refreshWelfareReddot()
	self:checkBPRedDot()
end

function WelfareMixin:refreshFakeActs()
	if VersionUtils.IsRechargeDisabled() == true then
		return
	end

	self:closePushGiftAct()
	self:openPushGiftAct()
end

function WelfareMixin:sendRechargeAnalyticsData(eventType, param1, param2, param3)
	Analytics.sendOSSLog(eventType, param1, param2, param3)
end

function WelfareMixin:initRedPacketData(data)
	self.redPacketData = utils.deepcopy(data)

	for i, info in ipairs(self.redPacketData.record or {}) do
		self:recordRedPacketClaimInfo(info.seq_id, nil, true)
	end

	if not ClientUtils.isTickToday(self.redPacketData.refresh_day) then
		self.redPacketData.day_get = 0

		MsgManager.setHideRedMsg(false)
	end
end

function WelfareMixin:newDayRedPacket(...)
	if self.redPacketData then
		self.redPacketData.day_get = 0
	end

	MsgManager.setHideRedMsg(false)
end

function WelfareMixin:onRedPacketGetAwardResp(item_id, seq_id, cur_limit_count, refresh_time)
	local gainNum = cur_limit_count - self.redPacketData.day_get

	self.redPacketData.day_get = cur_limit_count
	self.redPacketData.refresh_day = refresh_time

	local item = BaseObject.GetObject(item_id)
	local showType = ResItem[item_id].extend_args5 and ResItem[item_id].extend_args5[1] or nil

	if showType and showType ~= 1 and ResRedPacketShow[showType] then
		local prefabId = ResRedPacketShow[showType].receive_canvas_id

		UIManager.replacePrefabOfDlg("claimRedPacketDlg", prefabId)
	end

	UIManager.getUI("claimRedPacketDlg", true):show({
		item = item,
		num = gainNum,
		seq = seq_id
	})
	self:recordRedPacketClaimInfo(seq_id, nil, true)
end

function WelfareMixin:destroyWelfareMixin()
	self:clearToShowGift()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function WelfareMixin:checkMallTabLocked(mallData)
	for k, subTabId in pairs(mallData.contents) do
		if not self:_checkMallLocked(subTabId) then
			return false
		end
	end

	return true
end

function WelfareMixin:checkMallTabTimeLimit(mallData)
	for k, subTabId in pairs(mallData.contents) do
		if not self:_checkMallLocked(subTabId) and self:checkMallSubTabTimeLimit(subTabId) then
			return true
		end
	end

	return false
end

function WelfareMixin:checkMallSubTabTimeLimit(subTabId)
	local mallSubConfig = ResMallSubPanelConfig[subTabId] or {}

	if Const.WELFARETYPE_NEWBEE_GROUP[mallSubConfig.pageType] then
		local lastTime = self:_getNewBeeTime(mallSubConfig)

		if lastTime > 0 and lastTime < Const.TIME_ONE_DAY then
			return true, lastTime
		end
	end

	if mallSubConfig.pageType == Const.WELFARETYPE_MONTHCARD then
		return ClientUtils.getMonthCardMallTick()
	end

	return false
end

Const.RECHARGE_GUIDE_CRERATE_TIME = 1
Const.RECHARGE_GUIDE_TOTAL_RECHARGE = 2

function WelfareMixin:getValidRechargeGuideData()
	local guideData = {}

	for _, condData in pairs(ResRechargeGuideMain) do
		local valid = true

		if condData.time_args then
			local startDay = condData.time_args[1]
			local endDay = condData.time_args[2]

			if not self:checkCreateRoleTime(startDay, endDay) then
				valid = false
			end
		end

		if condData.recahrge_args and (self.totalRechargeMoney < condData.recahrge_args[1] or self.totalRechargeMoney >= condData.recahrge_args[2]) then
			valid = false
		end

		if valid then
			self:_addRechargeGuideData(guideData, condData.contents)
		end
	end

	return guideData
end

function WelfareMixin:_addRechargeGuideData(container, contents)
	for _, contentId in ipairs(contents) do
		local contentData = ResRechargeGuideConfig[contentId]

		if not contentData or contentData.condition_id and ConditionLimitManager.inLimitState(contentData.condition_id) then
			-- block empty
		elseif contentData.relate_activity and not self:isActivityValid(contentData.relate_activity) then
			-- block empty
		else
			local subId = contentData.sub_id

			if not container[subId] then
				container[subId] = {}
			end

			table.insert(container[subId], contentData)
		end
	end
end

function WelfareMixin:checkCreateRoleTime(startDay, endDay)
	local todayStart = ClientUtils.getServerTimeTodayStart(ClientUtils.getServerTime())
	local passedTime = todayStart - self.roleCreateTick
	local curDay = 0

	if passedTime > 0 then
		curDay = math.floor(passedTime / Const.TIME_ONE_DAY) + 1
	end

	if startDay <= curDay and curDay < endDay then
		return true
	else
		return false
	end
end

return WelfareMixin
