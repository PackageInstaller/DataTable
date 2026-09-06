-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData9.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData9", package.seeall)

local AssistData9 = class("AssistData9", BaseAssistData)
local GOLD_CARD = -1

function AssistData9:init()
	self.selectIndex1 = 1
	self.selectIndex2 = 2
	self.selectIndex3 = 3
	self.selectIndex4 = 4
end

function AssistData9:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData9:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local params = XiaoNuoAssistantController.instance:getParams(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD) or {}

		if not params.cardList then
			local cardList = {}
			local drawPoolId = checknumber(params.drawPoolId)

			for idx, arr in ipairs(cardList) do
				if self:getCellSelect(idx) then
					for i, cardId in ipairs(arr) do
						if cardId == GOLD_CARD then
							if GoldenDiamondCardModel.instance.isUser and GoldenDiamondCardModel.instance.prizeNum > 0 then
								local function callback()
									GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()
								end

								table.insert(sendMo.callbackList, callback)
							end

							self:trySendFreeDraw(sendMo, drawPoolId)
						else
							local isActive = MonthCardModel.instance:isCardActive(cardId)

							if isActive then
								::label_3_0::

								local notget = not MonthCardModel.instance:isgetCardPrize(cardId)
								local isCanGet = isActive and notget

								if isCanGet then
									local function callback()
										MonthCardAgent.instance:sendPM_MonthCardGainDailyPrizeReq(cardId)
									end

									table.insert(sendMo.callbackList, callback)
								end
							end
						end
					end
				end
			end

			return sendMo
		end
	end
end

function AssistData9:trySendFreeDraw(sendMo, drawPoolId)
	if drawPoolId > 0 then
		local poolCfg = LotteryConfig.instance:GetPoolCfg(drawPoolId)

		if poolCfg then
			local countList, isComm, isGold = LotteryModel.instance:GetHaveFreeCount(drawPoolId)

			if countList and countList[1] > 0 then
				local lotteryNum = 1
				local isEnough, matType, matId, matNum, needNum, sttt = LotteryController.instance:getLotteryNeedConsume(lotteryNum, poolCfg)
				local zkStr, zk, zkCfg = LotteryModel.instance:getPoolConsumePlan(poolCfg)
				local discountSubId = 0

				if not string.nilorempty(zkStr) and zkCfg and zkCfg.subId then
					discountSubId = zkCfg.subId
				end

				if not poolCfg.poolInGroup then
					local function callback()
						LotteryController.instance:____CSRequestLuckDrawXiaoNuo(lotteryNum, poolCfg.poolId, -1, sttt, discountSubId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end
	end
end

return AssistData9
