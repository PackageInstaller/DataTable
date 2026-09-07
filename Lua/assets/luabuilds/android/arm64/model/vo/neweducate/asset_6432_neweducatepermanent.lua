local NewEducatePermanent = class("NewEducatePermanent")

function NewEducatePermanent:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.gameCnt = arg_1_2.ng_plus_count or 1
	self.polaroids = arg_1_2.polaroids or {}

	self:InitPolaroidsConfig()

	self.finishedEndings = arg_1_2.active_endings or {}
	self.activatedEndings = arg_1_2.endings or {}
	self.buffIds = arg_1_2.tarot_archive or {}

	self:InitEntryConfig()

	self.maxRound = arg_1_2.max_round

	self:InitStroyName2Id()
	self:InitSecretary()
	self:UpdateSecretaryIDs(false)

	return
end

function NewEducatePermanent:AddGameCnt()
	self.gameCnt = self.gameCnt + 1

	return
end

function NewEducatePermanent:GetGameCnt()
	return self.gameCnt
end

function NewEducatePermanent:GetMaxRound()
	return self.maxRound
end

function NewEducatePermanent:OnNextRound(arg_5_1)
	self.maxRound = math.max(arg_5_1, self.maxRound)

	return
end

function NewEducatePermanent:GetAllMemoryIds()
	return pg.child2_memory.get_id_list_by_character[self.id] or {}
end

function NewEducatePermanent:GetUnlockMemoryIds()
	return underscore.select(self:GetAllMemoryIds(), function(arg_8_0)
		return (pg.NewStoryMgr.GetInstance():IsPlayed(pg.child2_memory[arg_8_0].lua))
	end)
end

function NewEducatePermanent:InitStroyName2Id()
	self.name2memoryIds = {}

	underscore.each(self:GetAllMemoryIds(), function(arg_10_0)
		self.name2memoryIds[pg.child2_memory[arg_10_0].lua] = arg_10_0

		return
	end)

	return
end

function NewEducatePermanent:GetMemoryIdByName(arg_11_1)
	return self.name2memoryIds[arg_11_1]
end

function NewEducatePermanent:InitPolaroidsConfig()
	self.polaroidGroup2Ids = {}

	for iter_12_0, iter_12_1 in ipairs(pg.child2_polaroid.get_id_list_by_character[self.id]) do
		self.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group] = self.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group] or {}

		table.insert(self.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group], iter_12_1)
	end

	self.unlockPolaroidGroups = {}

	for iter_12_2, iter_12_3 in ipairs(self.polaroids) do
		if not table.contains(self.unlockPolaroidGroups, pg.child2_polaroid[iter_12_3].group) then
			table.insert(self.unlockPolaroidGroups, pg.child2_polaroid[iter_12_3].group)
		end
	end

	return
end

function NewEducatePermanent:GetPolaroidGroup2Ids()
	return self.polaroidGroup2Ids
end

function NewEducatePermanent:GetAllPolaroidGroups()
	return underscore.keys(self.polaroidGroup2Ids)
end

function NewEducatePermanent:GetUnlockPolaroidGroups()
	return self.unlockPolaroidGroups
end

function NewEducatePermanent:GetPolaroids()
	return self.polaroids
end

function NewEducatePermanent:AddPolaroid(arg_17_1)
	table.insert(self.polaroids, arg_17_1)

	if not table.contains(self.unlockPolaroidGroups, pg.child2_polaroid[arg_17_1].group) then
		table.insert(self.unlockPolaroidGroups, pg.child2_polaroid[arg_17_1].group)
		self:UpdateSecretaryIDs(true)
	end

	return
end

function NewEducatePermanent:GetAllEndingIds()
	return pg.child2_ending.get_id_list_by_character[self.id]
end

function NewEducatePermanent:GetFinishedEndings()
	return self.finishedEndings
end

function NewEducatePermanent:AddFinishedEnding(arg_20_1)
	if table.contains(self.finishedEndings, arg_20_1) then
		return
	end

	table.insert(self.finishedEndings, arg_20_1)

	return
end

function NewEducatePermanent:GetActivatedEndings()
	return self.activatedEndings
end

function NewEducatePermanent:AddActivatedEndings(arg_22_1)
	self.activatedEndings = table.mergeArray(self.activatedEndings, arg_22_1, true)

	self:UpdateSecretaryIDs(true)

	return
end

function NewEducatePermanent:GetAllBuffIds()
	return pg.child2_benefit_list.get_id_list_by_character[self.id] or {}
end

function NewEducatePermanent:GetAllTarotIds()
	return underscore.select(self:GetAllBuffIds(), function(arg_25_0)
		return pg.child2_benefit_list[arg_25_0].type == NewEducateBuff.TYPE.TAROT and NewEducateBuff.IsVisible(arg_25_0)
	end)
end

function NewEducatePermanent:GetActivatedTarotIds()
	return underscore.select(self.buffIds, function(arg_27_0)
		return pg.child2_benefit_list[arg_27_0].type == NewEducateBuff.TYPE.TAROT and NewEducateBuff.IsVisible(arg_27_0)
	end)
end

function NewEducatePermanent:GetAllTalentIds()
	return underscore.select(self:GetAllBuffIds(), function(arg_29_0)
		return pg.child2_benefit_list[arg_29_0].type == NewEducateBuff.TYPE.TALENT and NewEducateBuff.IsVisible(arg_29_0)
	end)
end

function NewEducatePermanent:GetActivatedTalentIds()
	return underscore.select(self.buffIds, function(arg_31_0)
		return pg.child2_benefit_list[arg_31_0].type == NewEducateBuff.TYPE.TALENT and NewEducateBuff.IsVisible(arg_31_0)
	end)
end

function NewEducatePermanent:GetAllEntryIds()
	return underscore.select(self:GetAllBuffIds(), function(arg_33_0)
		return pg.child2_benefit_list[arg_33_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_33_0)
	end)
end

function NewEducatePermanent:InitEntryConfig()
	self.entryGroup2Ids = {}

	for iter_34_0, iter_34_1 in ipairs(self:GetAllEntryIds()) do
		self.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag] = self.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag] or {}

		table.insert(self.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag], iter_34_1)
	end

	return
end

function NewEducatePermanent:GetEntryGroup2Ids()
	return self.entryGroup2Ids
end

function NewEducatePermanent:GetAllEntryGroups()
	return underscore.keys(self.entryGroup2Ids)
end

function NewEducatePermanent:GetActivatedEntryIds()
	return underscore.select(self.buffIds, function(arg_38_0)
		return pg.child2_benefit_list[arg_38_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_38_0)
	end)
end

function NewEducatePermanent:GetUnlockEntryGroups()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(self:GetActivatedEntryIds()) do
		if not table.contains(var_39_0, pg.child2_benefit_list[iter_39_1].level_tag) then
			table.insert(var_39_0, pg.child2_benefit_list[iter_39_1].level_tag)
		end
	end

	return var_39_0
end

function NewEducatePermanent:IsTarotType()
	return #self:GetAllTarotIds() > 0
end

function NewEducatePermanent:GetAllBuffCnt()
	return #self:GetAllTarotIds() + #self:GetAllTalentIds() + #self:GetAllEntryIds()
end

function NewEducatePermanent:GetAllUnlockBuffCnt()
	return #self:GetActivatedTarotIds() + #self:GetActivatedTalentIds() + #self:GetActivatedEntryIds()
end

function NewEducatePermanent:GetBuffIds()
	return self.buffIds
end

function NewEducatePermanent:CheckBuffRecord(arg_44_1)
	if not table.contains(self.buffIds, arg_44_1) then
		table.insert(self.buffIds, arg_44_1)
	end

	return
end

function NewEducatePermanent:InitSecretary()
	self.unlcokTipByPolaroidCnt = {}

	for iter_45_0, iter_45_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_45_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID then
			if not table.contains(self.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_45_1].unlock[1]) then
				table.insert(self.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_45_1].unlock[1])
			end
		end
	end

	return
end

function NewEducatePermanent:CheckSecretaryID(arg_46_1, arg_46_2)
	if arg_46_2 == "or" then
		for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
			if table.contains(self.activatedEndings, iter_46_1[1]) then
				return true
			end
		end

		return false
	elseif arg_46_2 == "and" then
		for iter_46_2, iter_46_3 in ipairs(arg_46_1) do
			if not table.contains(self.activatedEndings, iter_46_3) then
				return false
			end

			return true
		end
	end

	return false
end

function NewEducatePermanent:UpdateSecretaryIDs(arg_47_1)
	local var_47_0

	if arg_47_1 then
		var_47_0 = Clone(NewEducateHelper.GetAllUnlockSecretaryIds())
	end

	self.unlockSecretaryIds = {}

	local var_47_1 = #self.unlockPolaroidGroups

	for iter_47_0, iter_47_1 in ipairs(pg.secretary_special_ship.get_id_list_by_tb_id[self.id] or {}) do
		local var_47_2 = pg.secretary_special_ship[iter_47_1].unlock

		switch(pg.secretary_special_ship[iter_47_1].unlock_type, {
			[EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
				if var_47_2[1] and var_47_1 >= var_47_2[1] then
					table.insert(self.unlockSecretaryIds, iter_47_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_ENDING] = function()
				if var_47_2[1] then
					if type(var_47_2[1]) == "table" then
						if self:CheckSecretaryID(var_47_2, "or") then
							table.insert(self.unlockSecretaryIds, iter_47_1)
						end
					elseif type(var_47_2[1]) == "number" and self:CheckSecretaryID(var_47_2, "and") then
						table.insert(self.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_SHOP] = function()
				if var_47_2[1] then
					if getProxy(ShipSkinProxy):hasSkin(var_47_2[1]) then
						table.insert(self.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_STORY] = function()
				if var_47_2[1] then
					if pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_47_2[1])) then
						table.insert(self.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end
		})
	end

	if arg_47_1 then
		getProxy(SettingsProxy):UpdateEducateCharTip(var_47_0)
	end

	return
end

function NewEducatePermanent:GetUnlockSecretaryIds()
	return self.unlockSecretaryIds
end

return NewEducatePermanent
