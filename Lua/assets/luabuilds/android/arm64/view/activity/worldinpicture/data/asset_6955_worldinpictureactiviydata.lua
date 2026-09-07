local WorldInPictureActiviyData = class("WorldInPictureActiviyData")

function WorldInPictureActiviyData:Ctor(arg_1_1)
	self.activity = arg_1_1
	self.config = pg.activity_event_grid[arg_1_1.data1]
	self.travelPoint = arg_1_1.data2
	self.drawPoint = arg_1_1.data3
	self.travelList = arg_1_1.data1_list
	self.drawList = arg_1_1.data2_list
	self.awardList = arg_1_1.data3_list
	self.size = self.config.map
	self.drawAreaList = {}
	self.drawAreaAnimList = {}

	for iter_1_0, iter_1_1 in ipairs(self.config.zone) do
		table.insert(self.drawAreaAnimList, self.config.zone_anim_Pos[iter_1_0])
		table.insert(self.drawAreaList, self:WarpDrawArea(iter_1_1))
	end

	self.boxItems = {}

	for iter_1_2, iter_1_3 in ipairs(self.config.box) do
		self.boxItems[iter_1_3[1]] = self.boxItems[iter_1_3[1]] or {}
		self.boxItems[iter_1_3[1]][iter_1_3[2]] = true
	end

	return
end

function WorldInPictureActiviyData:WarpDrawArea(arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = arg_2_1[1], arg_2_1[3] do
		for iter_2_1 = arg_2_1[2], arg_2_1[4] do
			table.insert(var_2_0, Vector2(iter_2_0, iter_2_1))
		end
	end

	return var_2_0
end

function WorldInPictureActiviyData:GetMapRowAndColumn()
	return self.size[1], self.size[2]
end

function WorldInPictureActiviyData:GetTravelPoint()
	return self.travelPoint
end

function WorldInPictureActiviyData:GetDrawPoint()
	return self.drawPoint
end

function WorldInPictureActiviyData:GetTravelProgress()
	return #self.travelList
end

function WorldInPictureActiviyData:GetMaxTravelCnt()
	local var_7_0, var_7_1 = self:GetMapRowAndColumn()

	return var_7_0 * var_7_1
end

function WorldInPictureActiviyData:IsTravelAll()
	return self:GetTravelProgress() >= self:GetMaxTravelCnt()
end

function WorldInPictureActiviyData:GetDrawProgress()
	return #self.drawList
end

function WorldInPictureActiviyData:GetMaxDrawCnt()
	return #self.drawAreaList
end

function WorldInPictureActiviyData:IsDrawAll()
	return self:GetDrawProgress() >= self:GetMaxDrawCnt()
end

function WorldInPictureActiviyData:GetTravelList()
	return self.travelList
end

function WorldInPictureActiviyData:GetDrawList()
	return self.drawList
end

function WorldInPictureActiviyData:GetAwardList()
	return self.awardList
end

function WorldInPictureActiviyData:IsFirstTravel()
	return #self.travelList == 1
end

function WorldInPictureActiviyData:OutSide(arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = self:GetMapRowAndColumn()

	return arg_16_1 <= 0 or arg_16_2 <= 0 or var_16_0 < arg_16_1 or var_16_1 < arg_16_2
end

function WorldInPictureActiviyData:IsOpened(arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = self:GetMapRowAndColumn()

	return not self:OutSide(arg_17_1, arg_17_2) and table.contains(self.travelList, (arg_17_1 - 1) * var_17_1 + arg_17_2)
end

function WorldInPictureActiviyData:CanSelect(arg_18_1, arg_18_2)
	if #self.travelList == 0 then
		return true
	end

	if self:IsOpened(arg_18_1, arg_18_2) then
		return false
	end

	return _.any({
		Vector2(arg_18_1 + 1, arg_18_2),
		Vector2(arg_18_1, arg_18_2 + 1),
		Vector2(arg_18_1 - 1, arg_18_2),
		Vector2(arg_18_1, arg_18_2 - 1)
	}, function(arg_19_0)
		return self:IsOpened(arg_19_0.x, arg_19_0.y)
	end)
end

function WorldInPictureActiviyData:ExistBox(arg_20_1, arg_20_2)
	return self.boxItems[arg_20_1] and self.boxItems[arg_20_1][arg_20_2] == true
end

function WorldInPictureActiviyData:AnyAreaCanDraw()
	return _.any(self.drawAreaList, function(arg_22_0)
		return not self:IsDrawed(arg_22_0[1].x, arg_22_0[1].y) and _.all(arg_22_0, function(arg_23_0)
			return self:IsOpened(arg_23_0.x, arg_23_0.y)
		end)
	end)
end

function WorldInPictureActiviyData:GetDrawableArea(arg_24_1, arg_24_2)
	return _.detect(self.drawAreaList, function(arg_25_0)
		return arg_25_0[1] == Vector2(arg_24_1, arg_24_2)
	end)
end

function WorldInPictureActiviyData:GetDrawableAreasState()
	return _.map(self.drawAreaList, function(arg_27_0)
		return {
			position = arg_27_0[1],
			open = not self:IsDrawed(arg_27_0[1].x, arg_27_0[1].y) and _.all(arg_27_0, function(arg_28_0)
				return self:IsOpened(arg_28_0.x, arg_28_0.y)
			end)
		}
	end)
end

function WorldInPictureActiviyData:GetDrawIndex(arg_29_1, arg_29_2)
	local var_29_0 = -1

	for iter_29_0, iter_29_1 in ipairs(self.drawAreaList) do
		if _.any(iter_29_1, function(arg_30_0)
			return arg_30_0 == Vector2(arg_29_1, arg_29_2)
		end) then
			var_29_0 = iter_29_0

			break
		end
	end

	return var_29_0
end

function WorldInPictureActiviyData:IsDrawed(arg_31_1, arg_31_2)
	return table.contains(self.drawList, (self:GetDrawIndex(arg_31_1, arg_31_2)))
end

function WorldInPictureActiviyData:CanDraw(arg_32_1, arg_32_2)
	if self:IsDrawed(arg_32_1, arg_32_2) then
		return false
	end

	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(self.drawAreaList) do
		if _.any(iter_32_1, function(arg_33_0)
			return arg_33_0 == Vector2(arg_32_1, arg_32_2)
		end) then
			var_32_0 = iter_32_1

			break
		end
	end

	if not var_32_0 then
		return false
	end

	return (_.all(var_32_0, function(arg_34_0)
		return self:IsOpened(arg_34_0.x, arg_34_0.y)
	end))
end

function WorldInPictureActiviyData:Convert2DrawAreaHead(arg_35_1, arg_35_2)
	local var_35_0
	local var_35_1

	for iter_35_0, iter_35_1 in ipairs(self.drawAreaList) do
		if _.any(iter_35_1, function(arg_36_0)
			return arg_36_0 == Vector2(arg_35_1, arg_35_2)
		end) then
			var_35_0 = iter_35_1
			var_35_1 = iter_35_0

			break
		end
	end

	assert(var_35_0)

	return var_35_0[1].x, var_35_0[1].y, var_35_1
end

function WorldInPictureActiviyData:GetDrawAnimData(arg_37_1, arg_37_2)
	return self.drawAreaAnimList[self:GetDrawIndex(arg_37_1, arg_37_2)]
end

function WorldInPictureActiviyData:FindNextTravelable()
	if self:GetTravelPoint() <= 0 then
		return nil
	end

	local var_38_0, var_38_1 = self:GetMapRowAndColumn()

	for iter_38_0 = 1, var_38_0 do
		for iter_38_1 = 1, var_38_1 do
			if self:CanSelect(iter_38_0, iter_38_1) then
				return Vector2(iter_38_0, iter_38_1), (iter_38_0 - 1) * var_38_1 + iter_38_1
			end
		end
	end

	return nil
end

function WorldInPictureActiviyData:FindNextDrawableAreaHead()
	if self:GetDrawPoint() <= 0 then
		return nil
	end

	for iter_39_0, iter_39_1 in ipairs(self.drawAreaList) do
		if not self:IsDrawed(iter_39_1[1].x, iter_39_1[1].y) and _.all(iter_39_1, function(arg_40_0)
			return self:IsOpened(arg_40_0.x, arg_40_0.y)
		end) then
			return iter_39_1[1], iter_39_0
		end
	end

	return nil
end

return WorldInPictureActiviyData
