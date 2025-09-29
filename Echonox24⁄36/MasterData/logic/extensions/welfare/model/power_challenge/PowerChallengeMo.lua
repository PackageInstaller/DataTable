-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/power_challenge/PowerChallengeMo.lua

module("logic.extensions.welfare.model.power_challenge.PowerChallengeMo", package.seeall)

local M = class("PowerChallengeMo")

function M:ctor()
	return
end

function M:updateFromServer(taskNo)
	local id = taskNo.id

	self:refreshCfg(id)

	self._id = id
	self._count = taskNo.count
	self._finish = taskNo.finish
end

function M:refreshCfg(id)
	if self._id == nil or self._id ~= id then
		local cfg = ActivityTaskConfig.instance:getTaskInfoById(id)

		self._param = cfg and cfg.param or ""
		self._text = cfg and cfg.text or ""
		self._content = cfg and cfg.content or 0
		self._jumpId = cfg and cfg.jump or ""
		self._jumpId = string.nilorempty(self._jumpId) and 0 or tonumber(self._jumpId)
		self._rewardId = cfg and cfg.reward or 0
		self._icon = cfg and cfg.icon or ""

		if not string.nilorempty(self._param) and self._content > 0 then
			local taskDesc, maxCount, isTaskGroup = TaskUtil.parseContent(self._content, self._param)

			self._maxCount = maxCount

			if not string.nilorempty(taskDesc) then
				self._taskDesc = taskDesc
			end
		end

		if not string.nilorempty(self._text) then
			self._taskDesc = self._text
		end
	end
end

function M:getId()
	return self._id
end

function M:getCount()
	return self._count
end

function M:getDesc()
	return self._taskDesc
end

function M:getIcon()
	return self._icon
end

function M:setIsFinish(isFinish)
	self._finish = isFinish
end

function M:getIsFinish()
	return self._finish
end

function M:getMaxCnt()
	return self._maxCount or 1
end

function M:getJumpId()
	return self._jumpId
end

function M:canJump()
	return not string.nilorempty(self:getJumpId())
end

function M:canGetReward()
	return self:getCount() >= self:getMaxCnt() and not self._finish
end

function M:getRewardItemData()
	if not self._rewardItemData then
		self._rewardItemData = {}

		local rewardInfo = RewardConfig.instance:getRewardCfgByCode(tonumber(self._rewardId))

		for idx, item in ipairs(rewardInfo.reward) do
			local itemId = rewardInfo.reward[idx].code
			local count = rewardInfo.reward[idx].num
			local rewardItem = ItemUtil.createItemData({
				itemId = itemId
			})

			rewardItem:setCount(count)
			table.insert(self._rewardItemData, rewardItem)
		end
	end

	return self._rewardItemData
end

return M
