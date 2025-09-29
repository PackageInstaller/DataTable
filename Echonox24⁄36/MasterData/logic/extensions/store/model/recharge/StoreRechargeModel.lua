-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/recharge/StoreRechargeModel.lua

module("logic.extensions.store.model.recharge.StoreRechargeModel", package.seeall)

local M = class("StoreRechargeModel", BaseModel)

function M:ctor()
	self._rechargeList = nil
	self._hasGetRewardIds = {}
	self._curCredit = -1
	self._firstStatus = StoreEnum.StoreFirstChargeStatus.unsatisfied
end

function M:onReset()
	self._rechargeList = nil
	self._hasGetRewardIds = {}
	self._curCredit = -1
end

function M:getRewardList()
	if not self._rechargeList then
		self._rechargeList = {}

		local list = StoreRechargeConfig.instance:getPermanentRechargeList()

		for i = 1, #list do
			local mo = StoreRechargeMo.New(list[i])

			table.insert(self._rechargeList, mo)
		end

		table.sort(self._rechargeList, function(a, b)
			return a:getCredit() < b:getCredit()
		end)
	end

	return self._rechargeList
end

function M:updateRewardList()
	self._rechargeList = self:getRewardList()

	for i = 1, #self._rechargeList do
		local rechargeMo = self._rechargeList[i]
		local status = self:getItemStatue(rechargeMo)

		rechargeMo:setItemStatus(status)
	end
end

function M:setHasGetRewardIds(list)
	if not list then
		return
	end

	for k, v in pairs(list) do
		self._hasGetRewardIds[v] = v
	end
end

function M:setHasGetRewardId(id)
	self._hasGetRewardIds[id] = id
end

function M:setCurCredit(credit)
	self._curCredit = credit
end

function M:getCurCredit()
	return self._curCredit
end

function M:setFirstStatus(firstStatus)
	self._firstStatus = firstStatus

	if firstStatus == StoreEnum.StoreFirstChargeStatus.satisfied then
		local firstTime = PlayerModel.instance:getLocalStorageString(StoreEnum.StoreFirstChargeKey)

		if firstTime == "" then
			local curTime = ServerTime.now()

			self._firstTime = curTime

			PlayerModel.instance:setLocalStorageString(StoreEnum.StoreFirstChargeKey, tostring(curTime))
		end
	end
end

function M:getFirstStatus()
	return self._firstStatus
end

function M:isShowStoreFirstCharge()
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FirstRecharge)

	if not isOpen then
		return false
	end

	return self._firstStatus ~= StoreEnum.StoreFirstChargeStatus.hasGet
end

function M:isShowFirstChargeRedPoint()
	local data = PlayerModel.instance:getLocalStorageInt(StoreEnum.CacheKey.FirstRePointKey, 0)

	if data == 0 then
		return true
	end

	return false
end

function M:isShowFirstCharge()
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FirstRecharge)

	if not isOpen then
		return false
	end

	if self._firstStatus == StoreEnum.StoreFirstChargeStatus.hasGet then
		return false
	end

	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.showBtn ~= 1 then
		return false
	end

	local isAllTimeShow = cfg.showDay <= 0

	if isAllTimeShow then
		return true
	end

	if not self._firstTime then
		local firstTime = PlayerModel.instance:getLocalStorageString(StoreEnum.StoreFirstChargeKey)

		self._firstTime = firstTime ~= "" and tonumber(firstTime) or -1
	end

	local registerTime = PlayerModel.instance:getRegisterTime()
	local endTime = registerTime + cfg.showDay * 24 * 3600

	if self._firstTime < 0 then
		local curTime = ServerTime.now()

		return curTime < endTime and true or false
	elseif endTime < self._firstTime then
		return false
	else
		return true
	end
end

function M:getNextCredit()
	local list = self:getRewardList()

	for i = 1, #list do
		local credit = list[i]:getCredit()

		if credit > self._curCredit then
			return credit - self._curCredit
		end
	end

	return "-"
end

function M:getItemStatue(rechargeMo)
	if rechargeMo:getCredit() > self._curCredit then
		return StoreEnum.StoreRechargeStatus.unsatisfied
	end

	if self._hasGetRewardIds[rechargeMo:getId()] then
		return StoreEnum.StoreRechargeStatus.hasGet
	end

	return StoreEnum.StoreRechargeStatus.canGet
end

M.instance = M.New()

return M
