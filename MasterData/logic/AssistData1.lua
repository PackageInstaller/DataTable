-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData1.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData1", package.seeall)

local AssistData1 = class("AssistData1", BaseAssistData)

AssistData1.bossId1 = 1
AssistData1.bossId2 = 3

function AssistData1:setSelectAll(isOn)
	self._selectData[1] = isOn
	self._selectData[2] = isOn
end

function AssistData1:isSelectAll()
	return self._selectData[1] and self._selectData[2]
end

function AssistData1:isSelectAny()
	return self._selectData[1] or self._selectData[2]
end

function AssistData1:getSendCallbackList()
	local callbackList = {}

	if not FuncOpenModel.instance:getFuncIsOpen(60) then
		return callbackList
	end

	local isJoinFamily = FamilyModel.instance:isInFamily()

	if not isJoinFamily then
		return callbackList
	end

	local bossId1 = AssistData1.bossId1
	local bossId2 = AssistData1.bossId2
	local isUnlock1 = not FamilyModel.instance:isBossLock(bossId1)
	local isUnlock2 = not FamilyModel.instance:isBossLock(bossId2)

	if self._selectData[1] and isUnlock1 then
		local isChallengeOpen = FamilyModel.instance:isChallengeOpen(bossId1)
		local hasChallenge = FamilyModel.instance:hasChallenge(bossId1)
		local leftTime = FamilyModel.instance:getBossChallegenLeftTime(bossId1)

		if isChallengeOpen and hasChallenge and leftTime > 0 then
			local function callback()
				printInfo("test 请求家族挑战 合金猪")
				FamilyController.instance:sendSweepBossReq(bossId1)
			end

			for i = 1, leftTime do
				table.insert(callbackList, callback)
			end
		end
	end

	if self._selectData[2] and isUnlock2 then
		local isChallengeOpen = FamilyModel.instance:isChallengeOpen(bossId2)
		local hasChallenge = FamilyModel.instance:hasChallenge(bossId2)
		local leftTime = FamilyModel.instance:getBossChallegenLeftTime(bossId2)

		if isChallengeOpen and hasChallenge and leftTime > 0 then
			local function callback()
				printInfo("test 请求家族挑战 黄金龙")
				FamilyController.instance:sendSweepBossReq(bossId2)
			end

			for i = 1, leftTime do
				table.insert(callbackList, callback)
			end
		end
	end

	return callbackList
end

return AssistData1
