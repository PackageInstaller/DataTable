local FleetAIAction = class("FleetAIAction")

function FleetAIAction:Ctor(arg_1_1)
	self.actType = arg_1_1.act_type
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

	self.shipUpdate = _.map(arg_1_1.ship_update, function(arg_2_0)
		return {
			id = arg_2_0.id,
			hpRant = arg_2_0.hp_rant
		}
	end)
	self.cellUpdates = {}

	_.each(arg_1_1.map_update, function(arg_3_0)
		if arg_3_0.item_type ~= ChapterConst.AttachNone and arg_3_0.item_type ~= ChapterConst.AttachBorn and arg_3_0.item_type ~= ChapterConst.AttachBorn_Sub and (arg_3_0.item_type ~= ChapterConst.AttachStory or arg_3_0.item_data ~= ChapterConst.StoryTrigger) then
			table.insert(self.cellUpdates, arg_3_0.item_type == ChapterConst.AttachChampion and ChapterChampionPackage.New(arg_3_0) or ChapterCell.New(arg_3_0))
		end

		return
	end)

	self.commanderSkillEffectId = arg_1_1.commander_skill_effect_id

	return
end

function FleetAIAction:applyTo(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getFleet(FleetType.Normal, self.line.row, self.line.column)

	if var_4_0 then
		return self:applyToFleet(arg_4_1, var_4_0, arg_4_2)
	end

	return false, "can not find any fleet at: [" .. self.line.row .. ", " .. self.line.column .. "]"
end

function FleetAIAction:applyToFleet(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	local var_5_0 = 0

	if arg_5_1:isPlayingWithBombEnemy() then
		if not arg_5_3 then
			_.each(self.cellUpdates, function(arg_6_0)
				local var_6_0 = arg_5_1:getChapterCell(arg_6_0.row, arg_6_0.column)

				if var_6_0.flag == ChapterConst.CellFlagActive and arg_6_0.flag == ChapterConst.CellFlagDisabled then
					assert(pg.specialunit_template[var_6_0.attachmentId], "specialunit_template not exist: " .. var_6_0.attachmentId)

					arg_5_1.modelCount = arg_5_1.modelCount + pg.specialunit_template[var_6_0.attachmentId].enemy_point
				end

				arg_5_1:mergeChapterCell(arg_6_0)

				var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyAttachment)

				return
			end)
		end
	elseif self.target then
		local var_5_1 = _.detect(self.cellUpdates, function(arg_7_0)
			return arg_7_0.row == self.target.row and arg_7_0.column == self.target.column
		end)

		if not arg_5_3 then
			if self.shipUpdate then
				_.each(self.shipUpdate, function(arg_8_0)
					arg_5_1:updateFleetShipHp(arg_8_0.id, arg_8_0.hpRant)

					return
				end)

				var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyFleet)
			end

			if var_5_1 then
				if isa(var_5_1, ChapterChampionPackage) then
					arg_5_1:mergeChampion(var_5_1)

					var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyChampion)
				else
					arg_5_1:mergeChapterCell(var_5_1)

					var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyAttachment)
				end

				var_5_0 = bit.bor(var_5_0, ChapterConst.DirtyFleet)
			end
		end
	end

	return true, var_5_0
end

function FleetAIAction:PlayAIAction(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1:getFleetIndex(FleetType.Normal, self.line.row, self.line.column)

	assert(var_9_0)

	if arg_9_1:isPlayingWithBombEnemy() then
		local var_9_1 = arg_9_1:getMapShip(arg_9_1.fleets[var_9_0])

		arg_9_2.viewComponent:doPlayStrikeAnim(var_9_1, var_9_1:GetMapStrikeAnim(), arg_9_3)
	elseif self.actType == ChapterConst.ActType_Poison then
		arg_9_3()
	elseif self.target then
		local var_9_2 = arg_9_1.fleets[var_9_0]
		local var_9_3 = _.detect(self.cellUpdates, function(arg_10_0)
			return arg_10_0.row == self.target.row and arg_10_0.column == self.target.column
		end)

		assert(var_9_3, "can not find cell")

		if var_9_3.attachment == ChapterConst.AttachLandbase then
			if pg.land_based_template[var_9_3.attachmentId].type == ChapterConst.LBCoastalGun then
				local var_9_4 = arg_9_1:getMapShip(arg_9_1.fleets[var_9_0])

				arg_9_2.viewComponent:doPlayStrikeAnim(var_9_4, var_9_4:GetMapStrikeAnim(), arg_9_3)
			else
				assert(false)
			end

			return
		end

		local var_9_5 = "-" .. var_9_3.data / 100 .. "%"
		local var_9_6 = arg_9_1.fleets[var_9_0]:getSkill(self.commanderSkillEffectId)

		assert(var_9_6, "can not find skill: " .. self.commanderSkillEffectId)

		local var_9_7 = arg_9_1.fleets[var_9_0]:findCommanderBySkillId(self.commanderSkillEffectId)

		assert(var_9_7, "command can not find by skill id: " .. self.commanderSkillEffectId)
		arg_9_2.viewComponent:doPlayCommander(var_9_7, function()
			if var_9_6:GetType() == FleetSkill.TypeAirStrikeDodge then
				arg_9_2.viewComponent:easeAvoid(arg_9_2.viewComponent.grid.cellFleets[var_9_2.id].tf.position, arg_9_3)

				return
			elseif var_9_6:GetType() == FleetSkill.TypeAttack then
				local var_11_0

				switch(var_9_6:GetArgs()[1], {
					airfight = function()
						var_11_0 = "AirStrikeUI"

						return
					end,
					torpedo = function()
						var_11_0 = "SubTorpedoUI"

						return
					end,
					cannon = function()
						var_11_0 = "CannonUI"

						return
					end
				})
				assert(nil)
				arg_9_2.viewComponent:doPlayStrikeAnim(arg_9_1:getStrikeAnimShip(var_9_2, nil), nil, function()
					arg_9_2.viewComponent:strikeEnemy(self.target, var_9_5, arg_9_3)

					return
				end)

				return
			else
				assert(false)
			end

			return
		end)
	else
		arg_9_3()
	end

	return
end

return FleetAIAction
