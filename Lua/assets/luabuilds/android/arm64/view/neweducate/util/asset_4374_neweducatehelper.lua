local NewEducateHelper = class("NewEducateHelper")

function NewEducateHelper:Config2Drop()
	return {
		type = self[1],
		id = self[2],
		number = self[3]
	}
end

function NewEducateHelper:Config2Drops()
	local var_2_0 = {}

	underscore.each(self, function(arg_3_0)
		table.insert(var_2_0, NewEducateHelper.Config2Drop(arg_3_0))

		return
	end)

	return var_2_0
end

function NewEducateHelper:Config2Condition()
	return {
		type = self[1],
		id = self[2],
		operator = self[3],
		number = self[4]
	}
end

function NewEducateHelper:Config2Conditions()
	local var_5_0 = {}

	underscore.each(self, function(arg_6_0)
		table.insert(var_5_0, NewEducateHelper.Config2Condition(arg_6_0))

		return
	end)

	return var_5_0
end

function NewEducateHelper:GetDropConfig()
	return switch(self.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			assert(pg.child2_attr[self.id], "找不到child2_attr配置, id: " .. self.id)

			return pg.child2_attr[self.id]
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			assert(pg.child2_resource[self.id], "找不到child2_resource配置, id: " .. self.id)

			return pg.child2_resource[self.id]
		end,
		[NewEducateConst.DROP_TYPE.POLAROID] = function()
			assert(pg.child2_polaroid[self.id], "child2_polaroid, id: " .. self.id)

			return pg.child2_polaroid[self.id]
		end,
		[NewEducateConst.DROP_TYPE.BUFF] = function()
			assert(pg.child2_benefit_list[self.id], "找不到child2_benefit_list配置, id: " .. self.id)

			return pg.child2_benefit_list[self.id]
		end,
		[NewEducateConst.DROP_TYPE.TAROT] = function()
			assert(pg.child2_benefit_list[self.id], "找不到child2_benefit_list配置, id: " .. self.id)

			return pg.child2_benefit_list[self.id]
		end
	}, function()
		assert(false, "养成二期非法掉落类型:" .. self.type)

		return
	end)
end

function NewEducateHelper:GetDropIcon()
	local var_14_0 = NewEducateHelper.GetDropConfig(self)

	return switch(self.type, {
		[NewEducateConst.DROP_TYPE.TAROT] = function()
			return var_14_0.item_icon_little
		end
	}, function()
		return var_14_0.item_icon
	end)
end

function NewEducateHelper:UpdateVectorItem(arg_17_1, arg_17_2)
	if arg_17_1.type ~= NewEducateConst.DROP_TYPE.ATTR and arg_17_1.type ~= NewEducateConst.DROP_TYPE.RES then
		pg.TipsMgr.GetInstance():ShowTips("不支持的掉落展示for Vector,请检查配置！" .. arg_17_1.type)

		return
	end

	local var_17_0 = arg_17_2 or ""
	local var_17_1 = NewEducateHelper.GetDropConfig(arg_17_1)

	LoadImageSpriteAsync("neweducateicon/" .. var_17_1.icon, self:Find("icon"))
	setText(self:Find("name"), var_17_1.name)
	setText(self:Find("value"), var_17_0 .. arg_17_1.number)

	if self:Find("benefit") then
		setActive(self:Find("benefit"), arg_17_1.isBenefit)
		setActive(self:Find("benefit/add"), arg_17_1.number > 0)
		setActive(self:Find("benefit/reduce"), arg_17_1.number < 0)
	end

	return
end

function NewEducateHelper:UpdateItem(arg_18_1)
	LoadImageSpriteAsync("neweducateicon/" .. NewEducateHelper.GetDropIcon(arg_18_1), self:Find("frame/icon"))
	setText(self:Find("frame/count_bg/count"), arg_18_1.number)
	setText(self:Find("name_bg/name"), shortenString(NewEducateHelper.GetDropConfig(arg_18_1).name, 5))

	if self:Find("frame/benefit") then
		setActive(self:Find("frame/benefit"), arg_18_1.isBenefit)
	end

	return
end

function NewEducateHelper:NormalType2SiteType()
	return switch(self, {
		[NewEducateConst.SITE_NORMAL_TYPE.WORK] = function()
			return NewEducateConst.SITE_TYPE.WORK
		end,
		[NewEducateConst.SITE_NORMAL_TYPE.TRAVEL] = function()
			return NewEducateConst.SITE_TYPE.TRAVEL
		end
	})
end

function NewEducateHelper:FilterBenefit()
	return underscore.select(self, function(arg_23_0)
		return arg_23_0.type ~= NewEducateConst.DROP_TYPE.BUFF or arg_23_0.type == NewEducateConst.DROP_TYPE.BUFF and pg.child2_benefit_list[arg_23_0.id].is_show == 1 and arg_23_0.number > 0
	end)
end

function NewEducateHelper:MergeDrops()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self) do
		var_24_0[iter_24_1.type] = var_24_0[iter_24_1.type] or {}
		var_24_0[iter_24_1.type][iter_24_1.id] = (var_24_0[iter_24_1.type][iter_24_1.id] or 0) + iter_24_1.number
	end

	local var_24_1 = {}

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		for iter_24_4, iter_24_5 in pairs(iter_24_3) do
			table.insert(var_24_1, {
				type = iter_24_2,
				id = iter_24_4,
				number = iter_24_5
			})
		end
	end

	return var_24_1
end

function NewEducateHelper:GetSiteColors()
	local var_25_0 = pg.child2_site_display[self]

	return switch(pg.child2_site_display[self].type, {
		[NewEducateConst.SITE_TYPE.WORK] = function()
			local var_26_0 = Color.NewHex("f6bb56")
			local var_26_1 = Color.NewHex("eea221")
		end,
		[NewEducateConst.SITE_TYPE.TRAVEL] = function()
			local var_27_0 = Color.NewHex("f6bb56")
			local var_27_1 = Color.NewHex("eea221")
		end,
		[NewEducateConst.SITE_TYPE.EVENT] = function()
			local var_28_0 = Color.NewHex("887af2")
			local var_28_1 = Color.NewHex("7668e2")
		end,
		[NewEducateConst.SITE_TYPE.SHIP] = function()
			if var_25_0.bg == "red" then
				local var_29_0 = Color.NewHex("d96964")
				local var_29_1 = Color.NewHex("d96964")

				return
			elseif var_25_0.bg == "blue" then
				local var_29_2 = Color.NewHex("39bfff")
				local var_29_3 = Color.NewHex("26b1f3")

				return
			end

			return
		end
	})
end

function NewEducateHelper:PlaySpecialStory(arg_30_1)
	local var_30_0 = getProxy(NewEducateProxy):GetCurChar()

	pg.NewStoryMgr.GetInstance():PlayForTb(self, var_30_0.id .. "_" .. var_30_0:GetPersonalityTag(), function(arg_31_0, arg_31_1)
		existCall(arg_30_1(arg_31_0, arg_31_1))

		return
	end, true)

	if not pg.NewStoryMgr.GetInstance():IsPlayed(self) then
		getProxy(NewEducateProxy):UpdateUnlock()

		local var_30_1 = var_30_0:GetPermanentData():GetMemoryIdByName(self)

		if var_30_1 then
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataMemory(var_30_0:GetGameCnt(), var_30_0:GetRoundData().round, var_30_1))
		end
	end

	return
end

function NewEducateHelper:PlaySpecialStoryList(arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(self) do
		table.insert(var_32_0, function(arg_33_0)
			NewEducateHelper.PlaySpecialStory(iter_32_1, arg_33_0)

			return
		end)
	end

	seriesAsync(var_32_0, function()
		existCall(arg_32_1)

		return
	end)

	return
end

function NewEducateHelper:IsPersonalDrop()
	return self.type == NewEducateConst.DROP_TYPE.ATTR and pg.child2_attr[self.id].type == NewEducateChar.ATTR_TYPE.PERSONALITY
end

function NewEducateHelper:GetBenefitValue(arg_36_1)
	return math.max(0, math.floor(self * (1 + arg_36_1.ratio / 16) + arg_36_1.value))
end

function NewEducateHelper.GetTarotDetailDescKey()
	return NewEducateConst.NEW_EDUCATE_TAROT_DETAIL_DESC .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. getProxy(NewEducateProxy):GetCurChar().id
end

function NewEducateHelper.IsShowTarotDeatilDesc()
	return PlayerPrefs.GetInt(NewEducateHelper.GetTarotDetailDescKey()) == 1
end

function NewEducateHelper:SetTarotDeatilDescData()
	PlayerPrefs.SetInt(NewEducateHelper:GetTarotDetailDescKey(), self and 1 or 0)

	return
end

function NewEducateHelper.GetNewTipKey()
	return NewEducateConst.NEW_EDUCATE_NEW_CHILD_TIP .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. pg.child2_data.all[#pg.child2_data.all]
end

function NewEducateHelper.IsShowNewChildTip()
	if LOCK_EDUCATE_SYSTEM or LOCK_NEW_EDUCATE_SYSTEM then
		return false
	end

	if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, LOCK_NEW_EDUCATE_SYSTEM and "EducateMediator" or "NewEducateSelectMediator") then
		return false
	end

	return PlayerPrefs.GetInt(NewEducateHelper.GetNewTipKey()) ~= 1
end

function NewEducateHelper.ClearShowNewChildTip()
	PlayerPrefs.SetInt(NewEducateHelper.GetNewTipKey(), 1)

	return
end

function NewEducateHelper:ClearEventPerformance()
	local var_43_0 = NewEducateConst.NEW_EDUCATE_EVENT_TIP .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id .. "_" .. self:GetGameCnt() .. "_"

	underscore.each(underscore.select(pg.child2_site_event_group.all, function(arg_44_0)
		return #pg.child2_site_event_group[arg_44_0].performance > 0
	end), function(arg_45_0)
		PlayerPrefs.SetInt(var_43_0 .. arg_45_0, 0)

		return
	end)

	return
end

function NewEducateHelper.TrackRoundEnd()
	local var_46_0 = getProxy(NewEducateProxy)
	local var_46_1 = var_46_0:GetCurChar()
	local var_46_2 = underscore.map(var_46_1:GetAttrIds(), function(arg_47_0)
		return var_46_1:GetAttr(arg_47_0)
	end) or {}
	local var_46_3, var_46_4 = var_46_1:GetBenefitData().GetAllIds(var_46_0)

	pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataRoundEnd(var_46_1.id, var_46_1:GetGameCnt(), var_46_1:GetRoundData().round, var_46_1:GetResByType(NewEducateChar.RES_TYPE.MOOD), var_46_1:GetResByType(NewEducateChar.RES_TYPE.MONEY), var_46_1:GetResByType(NewEducateChar.RES_TYPE.FAVOR), var_46_1:GetPersonality(), table.concat(var_46_2, ","), table.concat(var_46_3, ",") .. ";" .. table.concat(var_46_4, ",")))

	return
end

function NewEducateHelper.TrackEnterTime()
	if getProxy(NewEducateProxy):GetEnterTime() == 0 then
		getProxy(NewEducateProxy):RecordEnterTime()
		pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnter(getProxy(NewEducateProxy):GetCurChar().id, 0))
	end

	return
end

function NewEducateHelper.TrackExitTime()
	local var_49_0 = getProxy(NewEducateProxy):GetEnterTime()

	if var_49_0 ~= 0 then
		pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnter(getProxy(NewEducateProxy):GetCurChar().id, 1, pg.TimeMgr.GetInstance():GetServerTime() - var_49_0))
		getProxy(NewEducateProxy):RecordEnterTime(0)
	end

	return
end

function NewEducateHelper.GetAllUnlockSecretaryIds()
	local var_50_0 = getProxy(EducateProxy):GetSecretaryIDs()

	var_50_0 = var_50_0 or {}

	if not LOCK_NEW_EDUCATE_SYSTEM then
		local var_50_1 = getProxy(NewEducateProxy)

		for iter_50_0, iter_50_1 in ipairs(pg.child2_data.all) do
			if var_50_1:GetChar(iter_50_1) then
				if var_50_1:GetChar(iter_50_1):GetPermanentData() then
					var_50_0 = table.mergeArray(var_50_0, (var_50_1:GetChar(iter_50_1):GetPermanentData():GetUnlockSecretaryIds()))
				end
			end
		end
	end

	return var_50_0
end

function NewEducateHelper.GetEducateCharacterList()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(pg.secretary_special_ship.get_id_list_by_character_id) do
		if not LOCK_NEW_EDUCATE_SYSTEM or iter_51_0 == 1000 then
			table.insert(var_51_0, EducateCharCharacter.New(iter_51_0))
		end
	end

	return var_51_0
end

function NewEducateHelper:GetSecIdBySkinId()
	for iter_52_0, iter_52_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_52_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_SHOP and pg.secretary_special_ship[iter_52_1].unlock[1] == self then
			return iter_52_1
		end
	end

	return
end

function NewEducateHelper:GetShipNameBySecId()
	return pg.secretary_special_ship[self].name
end

function NewEducateHelper:IsUnlockDefaultShip()
	return table.contains(NewEducateHelper.GetAllUnlockSecretaryIds(), pg.secretary_special_ship[self].character_id)
end

function NewEducateHelper.HasAnyUnlockShip()
	local var_55_0 = NewEducateHelper.GetAllUnlockSecretaryIds()

	if not var_55_0 then
		return false
	end

	return _.any(var_55_0, function(arg_56_0)
		return pg.secretary_special_ship[arg_56_0].character_id == arg_56_0
	end)
end

function NewEducateHelper:UpdateUnlockBySkinId()
	local var_57_0 = pg.secretary_special_ship[NewEducateHelper.GetSecIdBySkinId(self)].tb_id

	if var_57_0 == 0 then
		getProxy(EducateProxy):updateSecretaryIDs(true)
	else
		getProxy(NewEducateProxy):UpdateUnlock(var_57_0)
	end

	return
end

function NewEducateHelper.GetEducateCharSlotMaxCnt()
	if LOCK_EDUCATE_SYSTEM then
		return 0
	end

	if getProxy(PlayerProxy):getRawData():ExistEducateChar() or NewEducateHelper.HasAnyUnlockShip() then
		return 1
	else
		return 0
	end

	return
end

function NewEducateHelper.ReqDataForServer()
	local var_59_0 = {}

	if not LOCK_EDUCATE_SYSTEM then
		table.insert(var_59_0, function(arg_60_0)
			pg.ConnectionMgr.GetInstance():Send(27000, {
				type = 1
			}, 27001, arg_60_0)

			return
		end)
	end

	if not LOCK_NEW_EDUCATE_SYSTEM then
		for iter_59_0, iter_59_1 in ipairs(pg.child2_data.all) do
			table.insert(var_59_0, function(arg_61_0)
				pg.ConnectionMgr.GetInstance():Send(29001, {
					id = iter_59_1
				}, 29002, arg_61_0)

				return
			end)
		end
	end

	seriesAsync(var_59_0, function()
		return
	end)

	return
end

return NewEducateHelper
