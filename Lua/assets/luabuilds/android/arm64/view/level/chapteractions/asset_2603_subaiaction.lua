local SubAIAction = class("SubAIAction")

function SubAIAction:Ctor(arg_1_1)
	self.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}

	if arg_1_1.target_pos and arg_1_1.target_pos.row < 9999 and arg_1_1.target_pos.column < 9999 then
		self.target = {
			row = arg_1_1.target_pos.row,
			column = arg_1_1.target_pos.column
		}
	end

	self.movePath = _.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)
	self.cellUpdates = {}

	_.each(arg_1_1.map_update, function(arg_3_0)
		if arg_3_0.item_type ~= ChapterConst.AttachNone and arg_3_0.item_type ~= ChapterConst.AttachBorn and arg_3_0.item_type ~= ChapterConst.AttachBorn_Sub and (arg_3_0.item_type ~= ChapterConst.AttachStory or arg_3_0.item_data ~= ChapterConst.StoryTrigger) then
			table.insert(self.cellUpdates, arg_3_0.item_type == ChapterConst.AttachChampion and ChapterChampionPackage.New(arg_3_0) or ChapterCell.New(arg_3_0))
		end

		return
	end)

	return
end

function SubAIAction:applyTo(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getFleet(FleetType.Submarine, self.line.row, self.line.column)

	if var_4_0 then
		return self:applyToFleet(arg_4_1, var_4_0, arg_4_2)
	end

	return false, "can not find any submarine at: [" .. self.line.row .. ", " .. self.line.column .. "]"
end

function SubAIAction:applyToFleet(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	if self.target then
		if arg_5_2.restAmmo <= 0 then
			return false, "lack ammo of fleet."
		end

		local var_5_1 = _.detect(self.cellUpdates, function(arg_6_0)
			return arg_6_0.row == self.target.row and arg_6_0.column == self.target.column
		end)

		if not var_5_1 then
			return false, "can not find cell update at: [" .. self.target.row .. ", " .. self.target.column .. "]"
		end

		if not arg_5_3 then
			if isa(var_5_1, ChapterChampionPackage) then
				arg_5_1:mergeChampion(var_5_1)

				var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyChampion)
			else
				arg_5_1:mergeChapterCell(var_5_1)

				var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyAttachment)
			end

			arg_5_2.restAmmo = arg_5_2.restAmmo - 1
			var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyFleet)
		end
	elseif #self.movePath > 0 then
		if _.any(self.movePath, function(arg_7_0)
			local var_7_0 = arg_5_1:getChapterCell(arg_7_0.row, arg_7_0.column)

			return not var_7_0 or not var_7_0:IsWalkable()
		end) then
			return false, "invalide move path"
		end

		if not arg_5_3 then
			arg_5_2.line = {
				row = self.movePath[#self.movePath].row,
				column = self.movePath[#self.movePath].column
			}
			var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyFleet)
		end
	end

	return true, var_5_0
end

function SubAIAction:PlayAIAction(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1:getFleetIndex(FleetType.Submarine, self.line.row, self.line.column)

	if var_8_0 then
		if self.target then
			local var_8_1 = arg_8_1.fleets[var_8_0]
			local var_8_2 = _.detect(self.cellUpdates, function(arg_9_0)
				return arg_9_0.row == self.target.row and arg_9_0.column == self.target.column
			end)
			local var_8_3 = arg_8_1:GetRawChapterCell(var_8_2.row, var_8_2.column)
			local var_8_4 = "-" .. (var_8_2.data - ((var_8_3 or nil) and (var_8_3.data or 0))) / 100 .. "%"
			local var_8_5 = var_8_1:getShips(false)[1]

			arg_8_2.viewComponent:doPlayStrikeAnim(var_8_5, var_8_5:GetMapStrikeAnim(), function()
				arg_8_2.viewComponent:strikeEnemy(self.target, var_8_4, arg_8_3)

				return
			end)
		elseif #self.movePath > 0 then
			arg_8_2.viewComponent.grid:moveSub(var_8_0, self.movePath, nil, arg_8_3)
		else
			arg_8_3()
		end
	end

	return
end

return SubAIAction
