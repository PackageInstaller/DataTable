-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData10.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData10", package.seeall)

local AssistData10 = class("AssistData10", BaseAssistData)

function AssistData10:init()
	self._keyInputNum1 = "inputNum1"

	local inputNum1 = self:getCellData(self._keyInputNum1)

	self.localInputNum1 = inputNum1 ~= nil and checknumber(inputNum1) or 0

	if inputNum1 == nil then
		self:setCellData(self._keyInputNum1, self.localInputNum1)
	end

	self._assistCellData.donateCount = 0
	self._assistCellData.donateTimes = 0
	self._assistCellData.localDonateCount = self.localInputNum1
	self._donateTimes = 0
	self._realMaxDonateCount = 0
	self._familylvMaxDonateCount = 0
	self._cfgDonateList = FamilyConfig.instance:getDonateList()

	local coinItemStr = self._cfgDonateList[1].donateResource
	local diamondItemStr = self._cfgDonateList[#self._cfgDonateList].donateResource
	local curHasCoinNum = MaterialMgr.getMatCount(coinItemStr)
	local curHasDiamondNum = MaterialMgr.getMatCount(diamondItemStr)
	local coinMatType, coinId = MaterialMgr.getMatParams(coinItemStr)
	local diamondMatType, diamondId = MaterialMgr.getMatParams(diamondItemStr)

	self._coinItemStr = coinItemStr
	self._diamondItemStr = diamondItemStr
	self._coinMatType, self._coinId = coinMatType, coinId
	self._diamondMatType, self._diamondId = diamondMatType, diamondId
	self._isOpenFamily = FamilyController.instance:checkFamilyOpen()
	self._donateInfo = FamilyModel.instance:getDonateInfo()

	if self._isOpenFamily and self._donateInfo then
		local infos = {}

		if self._donateInfo and self._donateInfo.infos then
			infos = self._donateInfo.infos
		end

		local poolCfg = FamilyConfig.instance:getDonatePoolCfg(checknumber(infos.poolFamilyLevel))

		self._donateTimes = checknumber(infos.donateTimes)

		local familyInfo = FamilyModel.instance:getMyFamilyInfo()
		local level, curVal, needVal, isMaxLv = FamilyConfig.instance:getCurLvProgress(familyInfo.score)
		local curPoolCfg = FamilyConfig.instance:getDonatePoolCfg(level)

		self._familylvMaxDonateCount = curPoolCfg.maxDonateTimes

		local startIndex = self._donateTimes + 1

		self._realMaxDonateCount = self._familylvMaxDonateCount - self._donateTimes

		if self._assistCellData.localDonateCount <= self._realMaxDonateCount then
			if not self._assistCellData.localDonateCount then
				local tempCount = self._realMaxDonateCount
				local endIndex = self._donateTimes + tempCount
				local curNeedCoinNum, curNeedDiamondNum = self:_getCoinAndDiamondNum(startIndex, endIndex)

				XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId), curNeedCoinNum)
				XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId), curNeedDiamondNum)
			end
		end
	else
		XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId), 0)
		XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId), 0)
	end

	if self._assistCellData.localDonateCount <= self._realMaxDonateCount then
		self._assistCellData.donateCount = self._assistCellData.localDonateCount or self._realMaxDonateCount
	end

	self._assistCellData.donateTimes = self._donateTimes
end

function AssistData10:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData10:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local donateCount = self._assistCellData.donateCount
		local donateTimes = self._assistCellData.donateTimes
		local curNeedCoinNum = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId))
		local curNeedDiamondNum = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId))
		local curHasCoinNum = MaterialMgr.getMatCount(self._coinItemStr)
		local curHasDiamondNum = MaterialMgr.getMatCount(self._diamondItemStr)

		if curNeedCoinNum <= curHasCoinNum and curNeedDiamondNum <= curHasDiamondNum then
			for i = 1, donateCount do
				local function callback()
					FamilyController.instance:familyDonateReq(donateTimes + i)
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

function AssistData10:_getCoinAndDiamondNum(startIndex, maxIndex)
	local curNeedCoinNum = 0
	local curNeedDiamondNum = 0
	local cfgDonateList = FamilyConfig.instance:getDonateList()

	for i, v in ipairs(cfgDonateList) do
		if startIndex <= i and i <= maxIndex then
			local matType, id, num = MaterialMgr.getMatParams(v.donateResource)

			if matType == self._coinMatType and id == self._coinId then
				curNeedCoinNum = curNeedCoinNum + num
			elseif matType == self._diamondMatType and id == self._diamondId then
				curNeedDiamondNum = curNeedDiamondNum + num
			end
		end
	end

	return curNeedCoinNum, curNeedDiamondNum
end

return AssistData10
