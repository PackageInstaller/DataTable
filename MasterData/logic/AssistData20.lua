-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData20.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData20", package.seeall)

local AssistData20 = class("AssistData20", BaseAssistData)

AssistData20.MaxChallengeNum = 5
AssistData20.MaxSelectPosIndex = 3
AssistData20.ChallengeCoin = "4:703"

function AssistData20:init()
	self.keyDropdownNum1_1 = "keyDropdownNum1_1"
	self.keyDropdownNum1_2 = "keyDropdownNum1_2"
	self.keyDropdownNum2_1 = "keyDropdownNum2_1"
	self.keyDropdownNum2_2 = "keyDropdownNum2_2"
end

function AssistData20:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData20:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		sendMo:setExcuteInterval(true, 1)

		local leftChallengeTimes = ArenaModel.instance:getLeftChallengeTimes()
		local rank = ArenaModel.instance:getPosition()

		if leftChallengeTimes > 0 and rank > 5 then
			local challengeNum = self:getCellDataToNumber(self.keyDropdownNum1_1)
			local challengePos = self:getCellDataToNumber(self.keyDropdownNum1_2)

			if challengeNum > 0 and challengePos > 0 then
				for i = 1, challengeNum do
					local function callback()
						local rank = ArenaModel.instance:getPosition()

						if rank > 0 and rank <= 5 then
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local leftNum = ArenaModel.instance:getLeftChallengeTimes()

						if leftNum <= 0 then
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local cdTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

						printInfo("test cd = ", cdTime, ArenaModel.instance:getChallengeCdEndTime(), ServerTime.now())

						if cdTime > 0 then
							printInfo("test cd中", cdTime)
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local isXiaoNuoAssist = true
						local pos = ArenaModel.instance:getChallengersPosition(challengePos)

						ArenaAgent.instance:sendArenaChallengeReq(ArenaModel.instance:getSeasonId(), pos, isXiaoNuoAssist)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		local seniorChallengeNum = self:getCellDataToNumber(self.keyDropdownNum2_1)
		local seniorChallengePos = self:getCellDataToNumber(self.keyDropdownNum2_2)
		local leftCoinNum = MaterialMgr.getMatCount(AssistData20.ChallengeCoin)
		local seniorRank = SeniorArenaModel.instance:getMyRank()
		local isExistDefendForm = SeniorArenaModel.instance:isExistDefendForm()

		printInfo("test AssistData20:getSendCallbackList2", seniorChallengeNum, seniorChallengePos, leftCoinNum, seniorRank, isExistDefendForm, seniorChallengeNum > 0 and seniorChallengePos > 0 and leftCoinNum > 0 and seniorRank > 5 and isExistDefendForm)

		if seniorChallengeNum > 0 and seniorChallengePos > 0 and leftCoinNum > 0 and seniorRank > 5 and isExistDefendForm then
			for i = 1, seniorChallengeNum do
				local function callback()
					if not SeniorArenaController.instance:getIsOpen(false) then
						printInfo("test AssistData20:getSendCallbackList 高阶竞技场 当前已关闭", i)
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local seniorRank = SeniorArenaModel.instance:getMyRank()

					if seniorRank > 0 and seniorRank <= 5 then
						printInfo("test AssistData20:getSendCallbackList 高阶竞技场 排名前5，不进行挑战", i)
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local leftCoinNum = MaterialMgr.getMatCount(AssistData20.ChallengeCoin)

					if leftCoinNum <= 0 then
						printInfo("test AssistData20:getSendCallbackList 高阶竞技场 剩余次数不足，不进行挑战", i)
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local userId = SeniorArenaModel.instance:getUserIdByIndex(seniorChallengePos)

					SeniorArenaController.instance:setCurOpponentId(userId)

					local isXiaoNuoAssist = true

					SeniorArenaController.instance:reqChallenge(nil, nil, isXiaoNuoAssist)
					sendMo:setEmptyShowText("竞技场挑战完成")
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

return AssistData20
