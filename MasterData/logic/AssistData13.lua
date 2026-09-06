-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData13.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData13", package.seeall)

local AssistData13 = class("AssistData13", BaseAssistData)

function AssistData13:init()
	self.keyInputNum1 = "inputNum1"
	self.keyInputNum2 = "inputNum2"

	local selectNum = self:getCellDataToNumber(self.keyInputNum1)

	self._assistCellData.challengeId = self:getCellDataToNumber(self.keyInputNum2)
	self._assistCellData.selectNum = selectNum
end

function AssistData13:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData13:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local times = self._assistCellData.selectNum
		local challengeId = self._assistCellData.challengeId

		if challengeId > 0 then
			self._cfgPets = LegendConfig.instance:getLegendChallengeCfgs()

			local cfg = self._cfgPets[challengeId]
			local leftCount = LegendModel.instance:getLeftCountByChallengeId(cfg.challengeId)

			if times > 0 and times <= leftCount then
				local unitPower = self:getUnitPower(cfg.challengeId)

				XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), GameEnum.GoldType.Tili, times * unitPower)

				local costTotalPower = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), GameEnum.GoldType.Tili)
				local curTotalPower = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)

				if costTotalPower <= curTotalPower then
					local function callback()
						LegendChallengeAgent.instance:sendSweepsByTimesReq(challengeId, times)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		return sendMo
	end
end

function AssistData13:getUnitPower(challengeId)
	local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)
	local stageId = cfgList[#cfgList].stageId
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)

	return cfgTeam.strengthConsumption
end

return AssistData13
