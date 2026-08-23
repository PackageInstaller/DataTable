local var_0_0 = g.core.config.dungeon_stinger_info
local EasterEggData = class("EasterEggData")

function EasterEggData:ctor()
	self:initData()
end

function EasterEggData:initData()
	self._openEggList = {}
	self._allEggInfoList = {}
	self._indexByKey = {}
	self._isGetNewEgg = false
	self._interactionData = {}
	self._likeIndex = 0

	self:_initEggInfo()
end

function EasterEggData:_initEggInfo(arg_3_1)
	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		table.insert(self._allEggInfoList, {
			isUnlock = false,
			cfg = iter_3_1,
			key = iter_3_1.interaction_id .. "_" .. iter_3_1.id,
			interactionId = iter_3_1.interaction_id,
			id = iter_3_1.id
		})

		self._indexByKey[iter_3_1.interaction_id .. "_" .. iter_3_1.id] = iter_3_0
	end
end

function EasterEggData:onS2CInteractionAll(arg_4_1)
	self._openEggList = {}

	local var_4_0 = arg_4_1.datas or {}

	for iter_4_0 = 1, #var_4_0 do
		self._openEggList[var_4_0[iter_4_0].interaction_id .. "_" .. var_4_0[iter_4_0].id] = var_4_0[iter_4_0]

		if self._allEggInfoList[self._indexByKey[var_4_0[iter_4_0].interaction_id .. "_" .. var_4_0[iter_4_0].id]] then
			self._allEggInfoList[self._indexByKey[var_4_0[iter_4_0].interaction_id .. "_" .. var_4_0[iter_4_0].id]].isUnlock = true
		end
	end
end

function EasterEggData:onS2CInteraction(arg_5_1)
	if arg_5_1.data then
		self._openEggList[arg_5_1.data.interaction_id .. "_" .. arg_5_1.data.id] = arg_5_1.data

		if self._allEggInfoList[self._indexByKey[arg_5_1.data.interaction_id .. "_" .. arg_5_1.data.id]] then
			self._allEggInfoList[self._indexByKey[arg_5_1.data.interaction_id .. "_" .. arg_5_1.data.id]].isUnlock = true
		end

		local var_5_0 = arg_5_1.data.likes or {}
		local var_5_1 = 0

		for iter_5_0, iter_5_1 in pairs(arg_5_1.data.likes) do
			if iter_5_1 > 0 then
				var_5_1 = var_5_1 + 1
			end
		end

		local var_5_2 = {
			key = arg_5_1.data.interaction_id .. "_" .. arg_5_1.data.id,
			userLike = var_5_0,
			likeCount = var_5_1
		}

		var_5_2.talkLikes = arg_5_1.data.likes_num or {}
		self._interactionData = var_5_2
	end
end

function EasterEggData:onS2CTalkSucc(arg_6_1)
	if arg_6_1 then
		if arg_6_1.interaction_id .. "_" .. arg_6_1.id == self._interactionData.key then
			local var_6_0 = 0

			for iter_6_0, iter_6_1 in pairs(self._interactionData.userLike) do
				if iter_6_0 == arg_6_1.index then
					self._interactionData.userLike[iter_6_0] = iter_6_1 + 1
					self._interactionData.talkLikes[iter_6_0] = arg_6_1.size
					self._likeIndex = arg_6_1.index
				end

				if self._interactionData.userLike[iter_6_0] > 0 then
					var_6_0 = var_6_0 + 1
				end
			end

			self._interactionData = {
				key = arg_6_1.interaction_id .. "_" .. arg_6_1.id,
				userLike = self._interactionData.userLike,
				likeCount = var_6_0,
				talkLikes = self._interactionData.talkLikes
			}
		end
	end
end

function EasterEggData:onS2CInteractionOther(arg_7_1)
	if arg_7_1.data then
		local var_7_0 = arg_7_1.data.likes or {}
		local var_7_1 = 0

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1 > 0 then
				var_7_1 = var_7_1 + 1
			end
		end

		local var_7_2 = {
			key = arg_7_1.data.interaction_id .. "_" .. arg_7_1.data.id,
			userLike = var_7_0,
			likeCount = var_7_1
		}

		var_7_2.talkLikes = arg_7_1.data.likes_num or {}
		self._interactionData = var_7_2
	end
end

function EasterEggData:getUserDataByKey(arg_8_1)
	return self._openEggList[arg_8_1]
end

function EasterEggData:checkEggIsGet(arg_9_1)
	return self._openEggList[arg_9_1.interaction_id .. "_" .. arg_9_1.id] ~= nil
end

function EasterEggData:getAllEggDataList()
	local var_10_0 = clone(self._allEggInfoList)

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		if (arg_11_0.isUnlock and 0 or 1) ~= (arg_11_1.isUnlock and 0 or 1) then
			return (arg_11_0.isUnlock and 0 or 1) < (arg_11_1.isUnlock and 0 or 1)
		elseif arg_11_0.interactionId ~= arg_11_1.interactionId then
			return arg_11_0.interactionId < arg_11_1.interactionId
		elseif arg_11_0.id ~= arg_11_1.id then
			return arg_11_0.id < arg_11_1.id
		end
	end)

	return var_10_0
end

function EasterEggData:resetInteractionTalkData()
	self._interactionData = {}
end

function EasterEggData:getCurInteractionTalkData()
	return self._interactionData
end

function EasterEggData:getCurLikeIndex()
	return self._likeIndex
end

function EasterEggData:setCurLikeIndex(arg_15_1)
	self._likeIndex = arg_15_1
end

return EasterEggData
