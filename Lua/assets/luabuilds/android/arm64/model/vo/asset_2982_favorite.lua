local Favorite = class("Favorite", import(".BaseVO"))

Favorite.STATE_AWARD = 1
Favorite.STATE_WAIT = 2
Favorite.STATE_LOCK = 3
Favorite.STATE_FETCHED = 4

function Favorite:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.id = self.configId
	self.star = arg_1_1.star

	return
end

function Favorite:bindConfigTable()
	return pg.storeup_data_template
end

function Favorite:getStarCount(arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(self:getConfig("char_list")) do
		if arg_3_1[iter_3_1] then
			var_3_0 = var_3_0 + arg_3_1[iter_3_1].star
		end
	end

	return var_3_0
end

function Favorite:getNextAwardIndex(arg_4_1)
	return (arg_4_1[self.id] or nil) and arg_4_1[self.id] + 1
end

function Favorite:isFetchAll(arg_5_1)
	return (arg_5_1[self.id] or 0) >= #self:getConfig("level")
end

function Favorite:canGetRes(arg_6_1, arg_6_2)
	local var_6_0 = self:getNextAwardIndex(arg_6_2)
	local var_6_1 = false

	if var_6_0 <= #self:getConfig("award_display") then
		var_6_1 = true

		if self:getStarCount(arg_6_1) >= self:getConfig("level")[var_6_0] then
			return true
		end
	end

	return false, var_6_1
end

function Favorite:getState(arg_7_1, arg_7_2)
	local var_7_1, var_7_2 = self:canGetRes(arg_7_1, arg_7_2)

	if var_7_1 then
		return Favorite.STATE_AWARD
	elseif self:isFetchAll(arg_7_2) then
		return Favorite.STATE_FETCHED
	else
		return (var_7_2 or nil) and (Favorite.STATE_WAIT or Favorite.STATE_LOCK)
	end

	return
end

function Favorite:getAwardState(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2[self.id]
	local var_8_1

	if not arg_8_2[self.id] then
		var_8_0 = 0
		var_8_1 = self:getConfig("award_display")
	end

	if self:getConfig("level")[arg_8_3] <= self:getStarCount(arg_8_1) then
		if var_8_0 < arg_8_3 then
			local var_8_2

			if var_8_1[arg_8_3] then
				var_8_2 = Favorite.STATE_AWARD or Favorite.STATE_LOCK or Favorite.STATE_FETCHED
			end
		end

		return var_8_2
	else
		return (var_8_1[arg_8_3] or nil) and (Favorite.STATE_WAIT or Favorite.STATE_LOCK)
	end

	return
end

function Favorite:containShipGroup(arg_9_1)
	return _.any(self:getConfig("award_display"), function(arg_10_0)
		if arg_10_0[1] == DROP_TYPE_SHIP then
			if Ship.New({
				configId = arg_10_0[2]
			}):getGroupId() == arg_9_1 then
				return true
			end
		end

		return false
	end)
end

return Favorite
