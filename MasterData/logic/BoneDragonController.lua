-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/controller/BoneDragonController.lua

module("logic.extensions.bonedragon.controller.BoneDragonController", package.seeall)

local BoneDragonController = class("BoneDragonController", BaseController)

function BoneDragonController:ctor()
	return
end

function BoneDragonController:onInit()
	self:onReset()
end

function BoneDragonController:onReset()
	return
end

function BoneDragonController:sendPM_BoneDragonClgInfoReq(activityId)
	BoneDragonAgent.instance:sendPM_BoneDragonClgInfoReq(activityId)
end

function BoneDragonController:handlePM_BoneDragonClgInfoRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgInfoRes)
end

function BoneDragonController:sendPM_BoneDragonClgSelectPetReq(activityId, petIds)
	BoneDragonAgent.instance:sendPM_BoneDragonClgSelectPetReq(activityId, petIds)
end

function BoneDragonController:handlePM_BoneDragonClgSelectPetRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgSelectPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgSelectPetRes)
end

function BoneDragonController:sendPM_BoneDragonClgSelectFormationReq(activityId, stageId, formationId)
	BoneDragonAgent.instance:sendPM_BoneDragonClgSelectFormationReq(activityId, stageId, formationId)
end

function BoneDragonController:handlePM_BoneDragonClgSelectFormationRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgSelectFormationRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgSelectFormationRes)
end

function BoneDragonController:sendPM_BoneDragonClgRefreshFormationReq(activityId, stageId)
	BoneDragonAgent.instance:sendPM_BoneDragonClgRefreshFormationReq(activityId, stageId)
end

function BoneDragonController:handlePM_BoneDragonClgRefreshFormationRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgRefreshFormationRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgRefreshFormationRes)
end

function BoneDragonController:sendPM_BoneDragonClgChallengeReq(activityId, stageId, form)
	BoneDragonAgent.instance:sendPM_BoneDragonClgChallengeReq(activityId, stageId, form)
end

function BoneDragonController:handlePM_BoneDragonClgChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgChallengeRes)
end

function BoneDragonController:sendPM_BoneDragonClgConfirmReq(activityId, save)
	BoneDragonAgent.instance:sendPM_BoneDragonClgConfirmReq(activityId, save)
end

function BoneDragonController:handlePM_BoneDragonClgConfirmRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgConfirmRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgConfirmRes)
end

function BoneDragonController:sendPM_BoneDragonClgResetReq(activityId)
	BoneDragonAgent.instance:sendPM_BoneDragonClgResetReq(activityId)
end

function BoneDragonController:handlePM_BoneDragonClgResetRes(msg)
	BoneDragonModel.instance:handlePM_BoneDragonClgResetRes(msg)
	BoneDragonModel.instance:clearFormationPetDic(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonClgResetRes)
end

function BoneDragonController:handlePM_NotifyBoneDragonClgChallengeFinishRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	BoneDragonModel.instance:handlePM_NotifyBoneDragonClgChallengeFinishRes(msg)
	BoneDragonModel.instance:clearFormationPetDic(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyBoneDragonClgChallengeFinishRes)
end

function BoneDragonController:_onResFightEnd(msg)
	if msg.isWin then
		local pb = GameUtil.pbToTable(msg)

		UIStateManager.instance:push(ViewName.BoneDragonFightEndView, msg.activityId, pb.pets)
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFail)
	end

	return true
end

function BoneDragonController:enterBattleClg(activityId, stageId, petPosList, petMoList, summonIdx, summonIdList)
	if summonIdx then
		BoneDragonModel.instance:setSummonPetId(activityId, summonIdx)
	end

	local customFmtMo = BoneDragonModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId, petPosList, petMoList, summonIdx, summonIdList)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function BoneDragonController:getCurFormationChooseIdx(activityId)
	local petHasInFormationNum = 0
	local formationDic = BoneDragonModel.instance:getFormationPetDic(activityId)
	local posLimitDic = BoneDragonConfig.instance:getFormationPosDicByStageId(self._activityId, self._curStageId, self._chooseFormationId)

	for k, pet in pairs(formationDic) do
		petHasInFormationNum = petHasInFormationNum + 1
	end

	petHasInFormationNum = petHasInFormationNum + 1

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local hasPos = posLimitDic[i]

		if hasPos then
			petHasInFormationNum = petHasInFormationNum - 1
		end

		if petHasInFormationNum == 0 then
			return i
		end
	end
end

function BoneDragonController:curFormationHasSummonMaster(activityId)
	local formationPetDic = BoneDragonModel.instance:getFormationPetDic(activityId)
	local supportList = BoneDragonConfig.instance:getSupportPetIdList()
	local posList, moList = BoneDragonModel.instance:getFormationPosAndMo(activityId)
	local fmtRaceIdMap = {}

	for idx, mo in ipairs(moList) do
		fmtRaceIdMap[mo.raceId] = true
	end

	for idx, petId in ipairs(formationPetDic) do
		if petId ~= 0 then
			local isSupportPet = table.indexof(supportList, petId)

			if isSupportPet then
				local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(petId)

				if not string.nilorempty(supportPetCfg.summonedPetId) then
					local summonPetId = checknumber(supportPetCfg.summonedPetId)
					local summonPetIsOnFmt = formationPetDic[summonPetId]

					if not summonPetIsOnFmt then
						return true
					end
				end
			else
				local curBagPetMo = BagPetsController.instance:getPet(petId)
				local isSummonMaster = BagPetsController.instance:checkPetIsActiveMaster(curBagPetMo)

				if isSummonMaster then
					local summonPetList = ContractConfig.instance:getSummonBySummonMasterId(curBagPetMo.raceId)

					for i, element in ipairs(summonPetList) do
						local summonRaceId = element.summonRaceId
						local bagHasPet = BagModel.instance:isExistRaceId(summonRaceId)
						local curRaceIdInOnFmt = fmtRaceIdMap[summonRaceId]

						if bagHasPet and not curRaceIdInOnFmt then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

BoneDragonController.instance = BoneDragonController.New()

return BoneDragonController
