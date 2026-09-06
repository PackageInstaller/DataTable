-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/controller/AngelInvestorController.lua

module("logic.extensions.angelinvestor.controller.AngelInvestorController", package.seeall)

local AngelInvestorController = class("AngelInvestorController", BaseController)

AngelInvestorController.endState = {
	CAN_GET = 1,
	NOT_ENOUGH = 1
}

function AngelInvestorController:onInit()
	GlobalDispatcher:addListener("enterangelinvestor", self._enterAngelInvestor, self)
end

function AngelInvestorController:sendPM_AngelInvestorGetInfoReq(activityId)
	AngelInvestorAgent.instance:sendPM_AngelInvestorGetInfoReq(activityId)
end

function AngelInvestorController:handlePM_AngelInvestorGetInfoRes(msg)
	AngelInvestorModel.instance:handlePM_AngelInvestorGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorGetInfoRes)
end

function AngelInvestorController:sendPM_AngelInvestorSignContractReq(activityId)
	AngelInvestorAgent.instance:sendPM_AngelInvestorSignContractReq(activityId)
end

function AngelInvestorController:handlePM_AngelInvestorSignContractRes(msg)
	AngelInvestorModel.instance:handlePM_AngelInvestorSignContractRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorSignContractRes)
end

function AngelInvestorController:sendPM_AngelInvestorUpgradeAngelReq(activityId)
	AngelInvestorAgent.instance:sendPM_AngelInvestorUpgradeAngelReq(activityId)
end

function AngelInvestorController:handlePM_AngelInvestorUpgradeAngelRes(msg)
	local info = AngelInvestorModel.instance:getInfo(msg.activityId)
	local preLv = info and checknumber(info.angelLevel) or 0
	local preCfg = AngelInvestorConfig.instance:getInvestLevelCfg(msg.activityId, preLv)

	if preCfg and info then
		local consume = preCfg.consume

		info.curScore = info.curScore - consume
	end

	AngelInvestorModel.instance:handlePM_AngelInvestorUpgradeAngelRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorUpgradeAngelRes)
end

function AngelInvestorController:sendPM_AngelInvestorStartHangReq(activityId)
	AngelInvestorAgent.instance:sendPM_AngelInvestorStartHangReq(activityId)
end

function AngelInvestorController:handlePM_AngelInvestorStartHangRes(msg)
	AngelInvestorModel.instance:handlePM_AngelInvestorStartHangRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorStartHangRes)
end

function AngelInvestorController:sendPM_AngelInvestorGainHangRewardReq(activityId, prizeIds)
	AngelInvestorAgent.instance:sendPM_AngelInvestorGainHangRewardReq(activityId, prizeIds)
end

function AngelInvestorController:handlePM_AngelInvestorGainHangRewardRes(msg)
	AngelInvestorModel.instance:handlePM_AngelInvestorGainHangRewardRes(msg)

	local activityId = msg.activityId
	local info = AngelInvestorModel.instance:getInfo(activityId)

	if info then
		if not info.angelLevel then
			local curLv = 1
			local actCfg = AngelInvestorConfig.instance:getActivityCfg(activityId)
			local buyTime = PayShopModel.instance:getMibaoBuyTimesById(actCfg.cardShopItemId)
			local hasBuy = buyTime > 0
			local prizeGainCountMap = AngelInvestorModel.instance:getPrizeGainCountMap(activityId)
			local prizeIds = msg.prizeIds

			if prizeGainCountMap then
				for i, prizeId in ipairs(prizeIds) do
					local prizeLvCfg = AngelInvestorConfig.instance:getPrizeLvCfg(activityId, prizeId, curLv)
					local prizeCfg = AngelInvestorConfig.instance:getPrizeCfg(activityId, prizeId)
					local prizeNum = prizeLvCfg.prizeMpCount

					if hasBuy then
						if not prizeCfg.payGainLimit then
							local buyMaxNum = prizeCfg.maxGainLimit

							prizeGainCountMap[prizeId] = checknumber(prizeGainCountMap[prizeId]) + prizeNum
							prizeGainCountMap[prizeId] = math.min(buyMaxNum, prizeGainCountMap[prizeId])
						end
					end
				end
			end

			AngelInvestorModel.instance:clearSelectPrizeMap(activityId)
			GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorGainHangRewardRes)
		end
	end
end

function AngelInvestorController:sendPM_AngelInvestorChallengeReq(activityId, stageId, form)
	AngelInvestorAgent.instance:sendPM_AngelInvestorChallengeReq(activityId, stageId, form)
end

function AngelInvestorController:handlePM_AngelInvestorChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelInvestorChallengeRes)
end

function AngelInvestorController:handlePM_Notify_AngelInvestorChallengeResultRes(msg)
	if msg.win then
		AngelInvestorModel.instance:handlePM_Notify_AngelInvestorChallengeResultRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_AngelInvestorChallengeResultRes)
end

function AngelInvestorController:_enterAngelInvestor(param)
	local activityId = checknumber(param[1])
	local info = AngelInvestorModel.instance:getInfo(activityId)

	if info then
		local signed = info.signed

		if signed then
			UIStateManager.instance:push(ViewName.AngelInvestorHangView, activityId)
		else
			UIStateManager.instance:push(ViewName.AngelInvestorSignView, activityId)
		end
	else
		FloatWordMgr.instance:show("数据尚未同步，请稍后再试")
	end
end

function AngelInvestorController:sendAngelInvestorGetInfoReq()
	local curActId = ActivityDefineController.instance:getActivityIdByType(588)

	if curActId > 0 then
		self:sendPM_AngelInvestorGetInfoReq(curActId)
	end
end

function AngelInvestorController:enterBattleClg(activityId, stageId)
	local customFmtMo = AngelInvestorModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function AngelInvestorController:getCurSelectPrizeList(activityId)
	local selectMap = AngelInvestorModel.instance:getSelectPrizeMap(activityId)
	local selectList = {}

	for prizeId, hasSelect in pairs(selectMap) do
		if hasSelect then
			table.insert(selectList, prizeId)
		end
	end

	return selectList
end

function AngelInvestorController:getCurSelectPrizeNum(activityId)
	local selectNum = 0
	local selectMap = AngelInvestorModel.instance:getSelectPrizeMap(activityId)

	for prizeId, hasSelect in pairs(selectMap) do
		if hasSelect then
			selectNum = selectNum + 1
		end
	end

	return selectNum
end

function AngelInvestorController:getCurSelectTypeNum(activityId, curType)
	local num = 0
	local selectMap = AngelInvestorModel.instance:getSelectPrizeMap(activityId)

	for prizeId, hasSelect in pairs(selectMap) do
		if hasSelect then
			local cfg = AngelInvestorConfig.instance:getPrizeCfg(activityId, prizeId)
			local type = cfg.type

			if type == curType then
				num = num + 1
			end
		end
	end

	return num
end

function AngelInvestorController:getCanSelectTypeNum(activityId, curType, hasBuy)
	local hasFullNum = 0
	local hasChoosedNum = 0
	local info = AngelInvestorModel.instance:getInfo(activityId)

	if info then
		if not info.angelLevel then
			local angelLv = 1
			local hangGainPrizeIds = info and checktable(info.hangGainPrizeIds) or {}
			local actCfg = AngelInvestorConfig.instance:getActivityCfg(activityId)
			local angelLvCfg = AngelInvestorConfig.instance:getInvestLevelCfg(activityId, angelLv)

			if angelLvCfg then
				if not angelLvCfg.typePrizeCountLimit then
					local typePrizeCountLimit = {}
					local openPrizeCfgs = AngelInvestorConfig.instance:getOpenRewardPrizeCfgs(activityId, angelLv, curType)
					local totalOpenNum = #openPrizeCfgs

					if actCfg then
						if not actCfg.payTypePrizeCountAdd then
							local payTypePrizeCountAdd = 0
							local canChooseNum = checknumber(typePrizeCountLimit[curType])

							if hasBuy then
								canChooseNum = canChooseNum + payTypePrizeCountAdd
							end

							local hasChooseMap = {}
							local prizeCountMap = AngelInvestorModel.instance:getPrizeGainCountMap(activityId)
							local prizeCfgs = AngelInvestorConfig.instance:getPrizeCfgs(activityId)

							for i, id in ipairs(hangGainPrizeIds) do
								local cfg = AngelInvestorConfig.instance:getPrizeCfg(activityId, id)
								local type = cfg.type

								if type == curType then
									hasChooseMap[id] = true
									hasChoosedNum = hasChoosedNum + 1
								end
							end

							for i, cfg in ipairs(prizeCfgs) do
								local prizeId = cfg.prizeId

								if not hasChooseMap[prizeId] and curType == cfg.type then
									local hasGainNum = checknumber(prizeCountMap[prizeId])

									if ((hasBuy or nil) and cfg.payGainLimit) <= hasGainNum then
										hasFullNum = hasFullNum + 1
									end
								end
							end

							totalOpenNum = totalOpenNum - hasFullNum - hasChoosedNum
							canChooseNum = canChooseNum - hasChoosedNum

							return (math.min(totalOpenNum, canChooseNum))
						end
					end
				end
			end
		end
	end
end

function AngelInvestorController:hasLeftPrizeCanGet(activityId, curType, hasBuy)
	local info = AngelInvestorModel.instance:getInfo(activityId)
	local hangGainPrizeIds = info and checktable(info.hangGainPrizeIds) or {}
	local prizeCountMap = AngelInvestorModel.instance:getPrizeGainCountMap(activityId)

	if info then
		local angelLv = info.angelLevel
		local prizeCfgs = AngelInvestorConfig.instance:getPrizeCfgs(activityId)

		for i, cfg in ipairs(prizeCfgs) do
			local type = cfg.type
			local prizeId = cfg.prizeId
			local hasChoose = table.indexof(hangGainPrizeIds, prizeId)

			if not hasChoose and type == curType and angelLv >= cfg.unlockLv then
				local hasGainPrizeNum = checknumber(prizeCountMap[prizeId])

				if hasGainPrizeNum < ((hasBuy or nil) and cfg.payGainLimit) then
					return true
				end
			end
		end
	end

	return false
end

function AngelInvestorController:hasLeftPrizeToGain(activityId, hasBuy)
	local info = AngelInvestorModel.instance:getInfo(activityId)

	if info then
		local actCfg = AngelInvestorConfig.instance:getActivityCfg(activityId)
		local angelLv = info.angelLevel
		local investLvCfg = AngelInvestorConfig.instance:getInvestLevelCfg(activityId, angelLv)

		if investLvCfg then
			if not investLvCfg.typePrizeCountLimit then
				local typePrizeCountLimit = {}

				if actCfg then
					if not actCfg.payTypePrizeCountAdd then
						for curType, limitNum in ipairs(typePrizeCountLimit) do
							local canSelectTypeNum = self:getCanSelectTypeNum(activityId, curType, hasBuy)

							if canSelectTypeNum > 0 then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function AngelInvestorController:getRepeatPrizeNameStr(activityId, curSelectList)
	local info = AngelInvestorModel.instance:getInfo(activityId)
	local hangGainPrizeIds = info and checktable(info.hangGainPrizeIds) or {}
	local repeatIdList = {}
	local nameStr = ""

	for i, id in ipairs(curSelectList) do
		if table.indexof(hangGainPrizeIds, id) then
			table.insert(repeatIdList, id)
		end
	end

	if #repeatIdList > 0 then
		for i, prizeId in ipairs(repeatIdList) do
			local prizeCfg = AngelInvestorConfig.instance:getPrizeCfg(activityId, prizeId)

			if prizeCfg then
				if not prizeCfg.prizeMpKey then
					local prizeMpKey = ""
					local matName = MaterialMgr.getMaterialsNameByCfg(prizeMpKey)

					nameStr = i ~= #repeatIdList and nameStr .. matName .. "、" or nameStr .. matName
				end
			end
		end

		return nameStr
	end
end

AngelInvestorController.instance = AngelInvestorController.New()

return AngelInvestorController
