local TrophyGroup = class("TrophyGroup")

function TrophyGroup:Ctor(arg_1_1)
	self._trophyGroupID = arg_1_1
	self._trophyList = {}

	return
end

function TrophyGroup:getGroupID()
	return self._trophyGroupID
end

function TrophyGroup:getTrophyList()
	return self._trophyList
end

function TrophyGroup:getDisplayTrophy()
	local var_4_0

	while #self._trophyList > 0 do
		var_4_0 = self._trophyList[#self._trophyList]

		if self._trophyList[#self._trophyList]:isClaimed() then
			break
		end
	end

	return var_4_0
end

function TrophyGroup:getProgressTrophy()
	local var_5_0

	while 1 <= #self._trophyList do
		var_5_0 = self._trophyList[1]

		if not self._trophyList[1]:isClaimed() then
			break
		end
	end

	return var_5_0
end

function TrophyGroup:getTrophyIndex(arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(self._trophyList) do
		if iter_6_1.id == arg_6_1.id then
			var_6_0 = iter_6_0

			break
		end
	end

	return var_6_0
end

function TrophyGroup:getMaxClaimedTrophy()
	while #self._trophyList > 0 do
		if self._trophyList[#self._trophyList]:isClaimed() then
			return self._trophyList[#self._trophyList]
		end
	end

	return
end

function TrophyGroup:getTrophyCount()
	return #self._trophyList
end

function TrophyGroup:getPostTrophy(arg_9_1)
	local var_9_0 = self:getTrophyIndex(arg_9_1)

	if not var_9_0 then
		return nil
	end

	local var_9_1 = var_9_0 + 1

	if var_9_0 + 1 > #self._trophyList then
		return nil
	end

	return self._trophyList[var_9_1]
end

function TrophyGroup:getPreTrophy(arg_10_1)
	local var_10_0 = self:getTrophyIndex(arg_10_1)

	if not var_10_0 then
		return nil
	end

	local var_10_1 = var_10_0 - 1

	if var_10_0 - 1 < 1 then
		return nil
	end

	return self._trophyList[var_10_1]
end

function TrophyGroup:addTrophy(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self._trophyList) do
		if iter_11_1.id == arg_11_1.id then
			self._trophyList[iter_11_0] = arg_11_1

			return
		end
	end

	self._trophyList[#self._trophyList + 1] = arg_11_1

	return
end

function TrophyGroup:addDummyTrophy(arg_12_1)
	self:addTrophy((Trophy.generateDummyTrophy(arg_12_1)))

	return
end

function TrophyGroup:sortGroup()
	table.sort(self._trophyList, function(arg_14_0, arg_14_1)
		return arg_14_0.id < arg_14_1.id
	end)

	return
end

function TrophyGroup:GetTrophyPage()
	return self._trophyList[1]:getConfig("page")
end

function TrophyGroup:IsExpire()
	return self._trophyList[1]:getConfig("is_out_of_print")
end

return TrophyGroup
