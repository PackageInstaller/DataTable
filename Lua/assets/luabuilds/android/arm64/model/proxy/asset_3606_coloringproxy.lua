local ColoringProxy = class("ColoringProxy", import(".NetProxy"))

function ColoringProxy:register()
	self.colorGroups = {}
	self.colorItems = {}

	return
end

function ColoringProxy:netUpdateData(arg_2_1)
	self.startTime = arg_2_1.start_time

	local var_2_0 = {}

	_.each(arg_2_1.award_list, function(arg_3_0)
		var_2_0[arg_3_0.id] = _.map(arg_3_0.award_list, function(arg_4_0)
			return {
				type = arg_4_0.type,
				id = arg_4_0.id,
				count = arg_4_0.number
			}
		end)

		return
	end)

	local var_2_1 = {}
	local var_2_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if var_2_2 and not var_2_2:isEnd() then
		var_2_1 = var_2_2:getConfig("config_data")
	end

	self.colorGroups = {}

	_.each(var_2_1, function(arg_5_0)
		local var_5_0 = arg_5_0[2]
		local var_5_1 = ColorGroup.New(arg_5_0[1])

		if var_5_1:canBeCustomised() and COLORING_ACTIVITY_CUSTOMIZED_BANNED then
			return
		end

		var_5_1:setHasAward(var_5_0 > 0)

		if arg_5_0[1] == arg_2_1.id then
			_.each(arg_2_1.cell_list, function(arg_6_0)
				var_5_1:setFill(arg_6_0.row, arg_6_0.column, arg_6_0.color)

				return
			end)
		end

		var_5_1:setDrops(var_2_0[arg_5_0[1]] or {})

		if tobool(var_2_0[arg_5_0[1]]) then
			var_5_1:setState(ColorGroup.StateAchieved)
		elseif arg_5_0[1] < arg_2_1.id or var_5_1:isAllFill() then
			var_5_1:setState(ColorGroup.StateFinish)
		end

		table.insert(self.colorGroups, var_5_1)

		return
	end)

	local var_2_3 = 0

	for iter_2_0 = #self.colorGroups, 1, -1 do
		local var_2_4 = self.colorGroups[iter_2_0]:getState()

		if var_2_4 == ColorGroup.StateFinish or var_2_4 == ColorGroup.StateAchieved then
			var_2_3 = iter_2_0

			break
		end
	end

	for iter_2_1 = var_2_3 - 1, 1, -1 do
		if not self.colorGroups[iter_2_1]:getState() then
			self.colorGroups[iter_2_1]:setState(ColorGroup.StateFinish)
		end
	end

	if var_2_3 + 1 <= #self.colorGroups then
		self.colorGroups[var_2_3 + 1]:setState((var_2_3 == 0 or nil) and (ColorGroup.StateColoring or ColorGroup.StateLock))
	end

	for iter_2_2 = var_2_3 + 2, #self.colorGroups do
		if not self.colorGroups[iter_2_2]:getState() then
			self.colorGroups[iter_2_2]:setState(ColorGroup.StateLock)
		end
	end

	self:checkState()

	self.colorItems = {}

	for iter_2_3, iter_2_4 in ipairs(arg_2_1.color_list) do
		self.colorItems[iter_2_4.id] = iter_2_4.number
	end

	return
end

function ColoringProxy:getColorItems()
	return self.colorItems
end

function ColoringProxy:getColorGroups()
	return self.colorGroups
end

function ColoringProxy:getColorGroup(arg_9_1)
	return _.detect(self.colorGroups, function(arg_10_0)
		return arg_10_0.id == arg_9_1
	end)
end

function ColoringProxy:checkState()
	local var_11_0 = false
	local var_11_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if var_11_1 and not var_11_1:isEnd() then
		local var_11_2 = pg.TimeMgr.GetInstance()
		local var_11_3 = var_11_2:DiffDay(self.startTime, var_11_2:GetServerTime()) + 1

		for iter_11_0, iter_11_1 in ipairs(self.colorGroups) do
			if iter_11_1:getState() == ColorGroup.StateColoring and iter_11_1:isAllFill() then
				iter_11_1:setState(ColorGroup.StateFinish)

				var_11_0 = true

				break
			elseif iter_11_0 < var_11_3 and iter_11_1:getState() == ColorGroup.StateAchieved then
				if self.colorGroups[iter_11_0 + 1] and self.colorGroups[iter_11_0 + 1]:getState() == ColorGroup.StateLock then
					self.colorGroups[iter_11_0 + 1]:setState(ColorGroup.StateColoring)

					var_11_0 = true

					break
				end
			end
		end
	end

	return var_11_0
end

function ColoringProxy:CheckTodayTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if var_12_0 and not var_12_0:isEnd() and self.startTime then
		local var_12_1 = pg.TimeMgr.GetInstance()
		local var_12_2 = math.min(var_12_1:DiffDay(self.startTime, var_12_1:GetServerTime()) + 1, #self.colorGroups)
		local var_12_3 = self:GetViewedPage()

		for iter_12_0, iter_12_1 in ipairs(self.colorGroups) do
			if var_12_2 < iter_12_0 then
				break
			end

			if iter_12_1:getState() == ColorGroup.StateLock then
				break
			end

			if iter_12_1:getState() ~= ColorGroup.StateAchieved and not iter_12_1:canBeCustomised() then
				if var_12_3 < iter_12_0 then
					return true
				end

				if iter_12_1:getState() == ColorGroup.StateFinish or iter_12_1:HasEnoughItem2FillAll(self:getColorItems()) then
					return true
				end

				break
			end
		end
	end

	return
end

function ColoringProxy:IsALLAchieve()
	if #self.colorGroups == 0 then
		return false
	end

	return _.all(self.colorGroups, function(arg_14_0)
		return arg_14_0:canBeCustomised() or arg_14_0:getState() == ColorGroup.StateAchieved
	end)
end

function ColoringProxy:GetViewedPage()
	local var_15_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if not var_15_0 or var_15_0:isEnd() then
		return 0
	end

	return PlayerPrefs.GetInt("pixelDraw_maxPage_" .. var_15_0.id .. "_" .. getProxy(PlayerProxy):getRawData().id, 0)
end

function ColoringProxy:SetViewedPage(arg_16_1)
	local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if not var_16_0 or var_16_0:isEnd() then
		return
	end

	if arg_16_1 <= self:GetViewedPage() then
		return
	end

	return PlayerPrefs.SetInt("pixelDraw_maxPage_" .. var_16_0.id .. "_" .. getProxy(PlayerProxy):getRawData().id, arg_16_1)
end

return ColoringProxy
