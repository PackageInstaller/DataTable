-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/config/CurrencyExchangeCO.lua

module("logic.extensions.currencyexchange.config.CurrencyExchangeCO", package.seeall)

local M = class("CurrencyExchangeCO")

function M:ctor(cfg)
	self._id = cfg.id
	self._sourceId = cfg.sourceId
	self._targetId = cfg.targetId
	self._rule = cfg.rule
	self._targetLimit = cfg.targetLimit or 0
	self._exchangeLimit = cfg.exchangeLimit or {}
	self._jumpId = cfg.jumpId or 0
	self._goodsId = cfg.goodsId or 0

	self:_dealRule()
end

function M:_dealRule()
	local ruleStr = self:getRuleStr()

	self._ruleSourceNums = {}
	self._ruleTargetNums = {}

	if string.nilorempty(ruleStr) then
		self._ruleSourceNum = 1
		self._ruleTargetNum = 1

		printError(string.format("[%s] 物品兑换配置，rule 为空", self:getId()))
	else
		local ruleItemStr = string.split(ruleStr, "|")

		if #ruleItemStr == 0 then
			local factors = string.split(ruleStr, ":")

			self._ruleSourceNum = tonumber(factors[1])
			self._ruleTargetNum = tonumber(factors[2])

			table.insert(self._ruleSourceNums, tonumber(factors[1]))
			table.insert(self._ruleTargetNums, tonumber(factors[2]))
		else
			for k, v in pairs(ruleItemStr) do
				local factors = string.split(v, ":")

				self._ruleSourceNum = tonumber(factors[1])
				self._ruleTargetNum = tonumber(factors[2])

				table.insert(self._ruleSourceNums, tonumber(factors[1]))
				table.insert(self._ruleTargetNums, tonumber(factors[2]))
			end
		end
	end
end

function M:getId()
	return self._id
end

function M:getSourceId()
	return self._sourceId
end

function M:getTargetId()
	return self._targetId
end

function M:getJumpId()
	return self._jumpId or 0
end

function M:getGoodsId()
	return self._goodsId
end

function M:getJumpDesc()
	if not self._jumpDesc then
		self._jumpDesc = ""

		local jumpId = self:getJumpId()

		if jumpId > 0 then
			local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

			if jumpInfo then
				self._jumpDesc = jumpInfo.jumpDesc
			else
				printError(string.format("无法从[%s]找到[%s]的配置", ConfigName.SystemJump, jumpId))
			end
		end
	end

	return self._jumpDesc
end

function M:getTargetLimit()
	return self._targetLimit
end

function M:getMaxMultiNum()
	if not self._maxMultiNum then
		self._maxMultiNum = self:getTargetLimit()
	end

	return self._maxMultiNum
end

function M:getMaxCountType()
	return self._exchangeLimit[1] or 0
end

function M:getMaxCount()
	return self._exchangeLimit[2] or 0
end

function M:getRuleStr()
	return self._rule
end

function M:getSourceNum()
	local remainedTime = CurrencyExchangeModel.instance:getRemainedTime(self:getId())
	local curCountIndex = 1

	if self:getMaxCount() ~= 0 and remainedTime then
		curCountIndex = self:getMaxCount() - remainedTime + 1
	end

	if self._ruleSourceNums[curCountIndex] then
		return self._ruleSourceNums[curCountIndex]
	end

	return self._ruleSourceNum
end

function M:getTargetNum()
	local remainedTime = CurrencyExchangeModel.instance:getRemainedTime(self:getId())
	local curCountIndex = 1

	if self:getMaxCount() ~= 0 and remainedTime then
		curCountIndex = self:getMaxCount() - remainedTime + 1
	end

	if self._ruleTargetNums[curCountIndex] then
		return self._ruleTargetNums[curCountIndex]
	end

	return self._ruleTargetNum
end

function M:getItemNameSource()
	if not self._itemNameSource then
		local co = BackpackConfig.instance:getItemInfoByItemId(self:getSourceId())

		if co == nil then
			printError(string.format("无法找到物品[%s]的配置", self:getSourceId()))
		end

		self._itemNameSource = co and co.name or ""
	end

	return self._itemNameSource
end

function M:getItemNameTarget()
	if not self._itemNameTarget then
		local co = BackpackConfig.instance:getItemInfoByItemId(self:getTargetId())

		if co == nil then
			printError(string.format("无法找到物品[%s]的配置", self:getTargetId()))
		end

		self._itemNameTarget = co and co.name or ""
	end

	return self._itemNameTarget
end

return M
