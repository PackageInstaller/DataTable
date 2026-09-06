-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData21.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData21", package.seeall)

local AssistData21 = class("AssistData21", BaseAssistData)

function AssistData21:init()
	self.keyInputNum1_1 = "inputNum1_1"
	self.keyInputNum1_2 = "inputNum1_2"
	self.keyInputNum2_1 = "inputNum2_1"
	self.keyInputNum2_2 = "inputNum2_2"
	self.keyInputNum3_1 = "inputNum3_1"
	self.keyInputNum3_2 = "inputNum3_2"
	self.keyInputNum4_1 = "inputNum4_1"
	self.keyInputNum4_2 = "inputNum4_2"

	local inputNum1_1 = self:getCellDataToNumber(self.keyInputNum1_1)
	local inputNum1_2 = self:getCellDataToNumber(self.keyInputNum1_2)
	local inputNum2_1 = self:getCellDataToNumber(self.keyInputNum2_1)
	local inputNum2_2 = self:getCellDataToNumber(self.keyInputNum2_2)
	local inputNum3_1 = self:getCellDataToNumber(self.keyInputNum3_1)
	local inputNum3_2 = self:getCellDataToNumber(self.keyInputNum3_2)

	self._assistCellData.chapterInfo = {}
	self._assistCellData.chapterInfo[1] = {}
	self._assistCellData.chapterInfo[1].selectNum = inputNum1_1
	self._assistCellData.chapterInfo[1].stageId = inputNum1_2
	self._assistCellData.chapterInfo[2] = {}
	self._assistCellData.chapterInfo[2].selectNum = inputNum2_1
	self._assistCellData.chapterInfo[2].stageId = inputNum2_2
	self._assistCellData.chapterInfo[3] = {}
	self._assistCellData.chapterInfo[3].selectNum = inputNum3_1
	self._assistCellData.chapterInfo[3].stageId = inputNum3_2
	self._assistCellData.chapterInfo[4] = {}
	self._assistCellData.chapterInfo[4].selectNum = self:getCellDataToNumber(self.keyInputNum4_1)
	self._assistCellData.chapterInfo[4].stageId = self:getCellDataToNumber(self.keyInputNum4_2)

	for i = 1, 4 do
		local chapterInfo = self._assistCellData.chapterInfo[i]

		chapterInfo.costPower = 0
	end
end

function AssistData21:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData21:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local maxSweepNum = checknumber(HolyStripeCopyConfig.instance:getCommonValue("GAME_TIME_STORAGE"))
		local leftSweepNum = HolyStripeCopyModel.instance:getLeftSoloTime()

		if leftSweepNum > 0 then
			XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), GameEnum.GoldType.Tili, 0)

			for i = 1, 4 do
				self:_addCallback(sendMo, i, leftSweepNum)
			end
		else
			sendMo:setEmptyShowText("无扫荡次数")
		end

		return sendMo
	end
end

function AssistData21:_getTotalSelectNum()
	local selectNum = 0

	for i, v in ipairs(self._assistCellData.chapterInfo) do
		local cfgChapter = HolyStripeCopyConfig.instance:getTabCfgByTabId(i)
		local isOpen = GameUtil.checkTimeStr(cfgChapter.openTime)

		if not isOpen then
			selectNum = selectNum + v.selectNum
		end
	end

	return selectNum
end

function AssistData21:_addCallback(sendMo, chapterId, leftCount)
	local stageId = self._assistCellData.chapterInfo[chapterId].stageId
	local times = self._assistCellData.chapterInfo[chapterId].selectNum
	local cfgChapter = HolyStripeCopyConfig.instance:getTabCfgByTabId(chapterId)
	local isOpen = GameUtil.checkTimeStr(cfgChapter.openTime)

	if not isOpen then
		times = 0
	end

	if leftCount >= 0 and chapterId > 0 and stageId > 0 and times > 0 then
		local cfgStage = HolyStripeCopyConfig.instance:getStageCfg(chapterId, stageId)
		local unitPower = cfgStage.strengthCost
		local curTotalPower = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)
		local leftTimes = math.min(leftCount, times)

		XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), GameEnum.GoldType.Tili, leftTimes * unitPower)

		local costTotalPower = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), GameEnum.GoldType.Tili)

		if leftTimes > 0 and costTotalPower <= curTotalPower then
			local function callback()
				LingWenAgent.instance:sendPM_LingWenSweepReq(chapterId, stageId, leftTimes)
			end

			table.insert(sendMo.callbackList, callback)

			leftCount = leftCount - leftTimes
		end
	end
end

return AssistData21
