-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/model/ArmorherolotteryModel.lua

module("logic.extensions.armorherolottery.view.ArmorherolotteryModel", package.seeall)

local ArmorherolotteryModel = class("ArmorherolotteryModel", BaseModel)

function ArmorherolotteryModel:ctor()
	return
end

function ArmorherolotteryModel:onInit()
	self:onReset()
end

function ArmorherolotteryModel:onReset()
	self._msgInfos = {}
end

function ArmorherolotteryModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].gainPrizeIds = self._msgInfos[msg.activityId].gainPrizeIds or {}
	self._msgInfos[msg.activityId].itemIds = self._msgInfos[msg.activityId].itemIds or {}
	self._msgInfos[msg.activityId].historyRuleIdAndNum = self._msgInfos[msg.activityId].historyRuleIdAndNum or {}
end

function ArmorherolotteryModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function ArmorherolotteryModel:isGetedReward(activityId, prizeId)
	local info = self:getInfo(activityId)

	return TableUtil.isHad(info.gainPrizeIds, prizeId)
end

function ArmorherolotteryModel:onGainPrizeRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	table.insert(info.gainPrizeIds, msg.prizeId)
end

function ArmorherolotteryModel:onLotteryDrawRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.score = msg.score
	info.itemIds = GameUtil.pbToTable(msg.itemIds)

	for i, v in ipairs(msg.ruleIdAndNum or {}) do
		local isHit = false

		for _, history in ipairs(info.historyRuleIdAndNum) do
			if history.left == v.left then
				history.right = history.right + v.right
				isHit = true

				break
			end
		end

		if not isHit then
			table.insert(info.historyRuleIdAndNum, {
				left = v.left,
				right = v.right
			})
		end
	end
end

ArmorherolotteryModel.instance = ArmorherolotteryModel.New()

return ArmorherolotteryModel
