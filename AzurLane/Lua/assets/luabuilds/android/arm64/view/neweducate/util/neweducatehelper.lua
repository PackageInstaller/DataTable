local var_0_0 = class("NewEducateHelper")

function var_0_0.Config2Drop(arg_1_0)
	return {
		type = arg_1_0[1],
		id = arg_1_0[2],
		number = arg_1_0[3]
	}
end

function var_0_0.Config2Drops(arg_2_0)
	local var_2_0 = {}

	underscore.each(arg_2_0, function(arg_3_0)
		table.insert(var_2_0, var_0_0.Config2Drop(arg_3_0))

		return
	end)

	return {}
end

function var_0_0.Config2Condition(arg_4_0)
	return {
		type = arg_4_0[1],
		id = arg_4_0[2],
		operator = arg_4_0[3],
		number = arg_4_0[4]
	}
end

function var_0_0.Config2Conditions(arg_5_0)
	local var_5_0 = {}

	underscore.each(arg_5_0, function(arg_6_0)
		table.insert(var_5_0, var_0_0.Config2Condition(arg_6_0))

		return
	end)

	return {}
end

function var_0_0.GetDropConfig(arg_7_0)
	return switch(arg_7_0.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			assert(pg.child2_attr[arg_7_0.id], "找不到child2_attr配置, id: " .. arg_7_0.id)

			return pg.child2_attr[arg_7_0.id]
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			assert(pg.child2_resource[arg_7_0.id], "找不到child2_resource配置, id: " .. arg_7_0.id)

			return pg.child2_resource[arg_7_0.id]
		end,
		[NewEducateConst.DROP_TYPE.POLAROID] = function()
			assert(pg.child2_polaroid[arg_7_0.id], "child2_polaroid, id: " .. arg_7_0.id)

			return pg.child2_polaroid[arg_7_0.id]
		end,
		[NewEducateConst.DROP_TYPE.BUFF] = function()
			assert(pg.child2_benefit_list[arg_7_0.id], "找不到child2_benefit_list配置, id: " .. arg_7_0.id)

			return pg.child2_benefit_list[arg_7_0.id]
		end,
		[NewEducateConst.DROP_TYPE.TAROT] = function()
			assert(pg.child2_benefit_list[arg_7_0.id], "找不到child2_benefit_list配置, id: " .. arg_7_0.id)

			return pg.child2_benefit_list[arg_7_0.id]
		end
	}, function()
		assert(false, "养成二期非法掉落类型:" .. arg_7_0.type)

		return
	end)
end

function var_0_0.GetDropIcon(arg_14_0)
	local var_14_0 = var_0_0.GetDropConfig(arg_14_0)

	return switch(arg_14_0.type, {
		[NewEducateConst.DROP_TYPE.TAROT] = function()
			return var_14_0.item_icon_little
		end
	}, function()
		return var_14_0.item_icon
	end)
end

function var_0_0.UpdateVectorItem(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1.type ~= NewEducateConst.DROP_TYPE.ATTR and arg_17_1.type ~= NewEducateConst.DROP_TYPE.RES then
		pg.TipsMgr.GetInstance():ShowTips("不支持的掉落展示for Vector,请检查配置！" .. arg_17_1.type)

		return
	end

	local var_17_0 = arg_17_2 or ""
	local var_17_1 = var_0_0.GetDropConfig(arg_17_1)

	LoadImageSpriteAsync("neweducateicon/" .. var_17_1.icon, arg_17_0:Find("icon"))
	setText(arg_17_0:Find("name"), var_17_1.name)
	setText(arg_17_0:Find("value"), var_17_0 .. arg_17_1.number)

	if arg_17_0:Find("benefit") then
		setActive(arg_17_0:Find("benefit"), arg_17_1.isBenefit)
		setActive(arg_17_0:Find("benefit/add"), arg_17_1.number > 0)
		setActive(arg_17_0:Find("benefit/reduce"), arg_17_1.number < 0)
	end

	return
end

function var_0_0.UpdateItem(arg_18_0, arg_18_1)
	LoadImageSpriteAsync("neweducateicon/" .. var_0_0.GetDropIcon(arg_18_1), arg_18_0:Find("frame/icon"))
	setText(arg_18_0:Find("frame/count_bg/count"), arg_18_1.number)
	setText(arg_18_0:Find("name_bg/name"), shortenString(var_0_0.GetDropConfig(arg_18_1).name, 5))

	if arg_18_0:Find("frame/benefit") then
		setActive(arg_18_0:Find("frame/benefit"), arg_18_1.isBenefit)
	end

	return
end

function var_0_0.NormalType2SiteType(arg_19_0)
	return switch(arg_19_0, {
		[NewEducateConst.SITE_NORMAL_TYPE.WORK] = function()
			return NewEducateConst.SITE_TYPE.WORK
		end,
		[NewEducateConst.SITE_NORMAL_TYPE.TRAVEL] = function()
			return NewEducateConst.SITE_TYPE.TRAVEL
		end
	})
end

function var_0_0.FilterBenefit(arg_22_0)
	return underscore.select(arg_22_0, function(arg_23_0)
		return arg_23_0.type ~= NewEducateConst.DROP_TYPE.BUFF or arg_23_0.type == NewEducateConst.DROP_TYPE.BUFF and pg.child2_benefit_list[arg_23_0.id].is_show == 1 and arg_23_0.number > 0
	end)
end

function var_0_0.MergeDrops(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0) do
		if not ({})[iter_24_1.type] then
			({})[iter_24_1.type] = {}
		end

		local var_24_0 = ({})[iter_24_1.type]
		local var_24_1 = ({})[iter_24_1.type][iter_24_1.id]

		if not ({})[iter_24_1.type][iter_24_1.id] then
			var_24_1 = 0
		end

		var_24_0[iter_24_1.id] = var_24_1 + iter_24_1.number
	end

	for iter_24_2, iter_24_3 in pairs({}) do
		for iter_24_4, iter_24_5 in pairs(iter_24_3) do
			table.insert({}, {
				type = iter_24_2,
				id = iter_24_4,
				number = iter_24_5
			})
		end
	end

	return {}
end

function var_0_0.GetSiteColors(arg_25_0)
	return switch(pg.child2_site_display[arg_25_0].type, {
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
			if var_0.bg == "red" then
				local var_29_0 = Color.NewHex("d96964")
				local var_29_1 = Color.NewHex("d96964")

				return
			elseif var_0.bg == "blue" then
				local var_29_2 = Color.NewHex("39bfff")
				local var_29_3 = Color.NewHex("26b1f3")

				return
			end

			return
		end
	})
end

function var_0_0.PlaySpecialStory(arg_30_0, arg_30_1)
	local var_30_9000
	local var_30_0 = getProxy(NewEducateProxy)
	local var_30_1 = var_30_0.GetCurChar(var_30_9000)

	pg.NewStoryMgr.GetInstance():PlayForTb(arg_30_0, var_30_1.id .. "_" .. var_30_1:GetPersonalityTag(), function(arg_31_0, arg_31_1)
		existCall(arg_30_1(arg_31_0, arg_31_1))

		return
	end, true)

	if not pg.NewStoryMgr.GetInstance().IsPlayed(var_30_0, arg_30_0) then
		getProxy(NewEducateProxy):UpdateUnlock()

		local var_30_2 = var_30_1:GetPermanentData():GetMemoryIdByName(arg_30_0)

		if var_30_2 then
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataMemory(var_30_1:GetGameCnt(), var_30_1:GetRoundData().round, var_30_2))
		end
	end

	return
end

function var_0_0.PlaySpecialStoryList(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
		table.insert({}, function(arg_33_0)
			var_0_0.PlaySpecialStory(iter_32_1, arg_33_0)

			return
		end)
	end

	seriesAsync({}, function()
		existCall(arg_32_1)

		return
	end)

	return
end

function var_0_0.IsPersonalDrop(arg_35_0)
	return arg_35_0.type == NewEducateConst.DROP_TYPE.ATTR and pg.child2_attr[arg_35_0.id].type == NewEducateChar.ATTR_TYPE.PERSONALITY
end

function var_0_0.GetBenefitValue(arg_36_0, arg_36_1)
	return math.max(0, math.floor(arg_36_0 * (1 + arg_36_1.ratio / 16) + arg_36_1.value))
end

function var_0_0.GetTarotDetailDescKey()
	return NewEducateConst.NEW_EDUCATE_TAROT_DETAIL_DESC .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. getProxy(NewEducateProxy):GetCurChar().id
end

function var_0_0.IsShowTarotDeatilDesc()
	return PlayerPrefs.GetInt(var_0_0.GetTarotDetailDescKey()) == 1
end

function var_0_0.SetTarotDeatilDescData(arg_39_0)
	PlayerPrefs.SetInt(var_0_0:GetTarotDetailDescKey(), arg_39_0 and 1 or 0)

	return
end

function var_0_0.GetNewTipKey()
	return NewEducateConst.NEW_EDUCATE_NEW_CHILD_TIP .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. pg.child2_data.all[#pg.child2_data.all]
end

function var_0_0.IsShowNewChildTip()
	local var_41_9000

	if LOCK_EDUCATE_SYSTEM or LOCK_NEW_EDUCATE_SYSTEM then
		return false
	end

	local var_41_0 = getProxy(PlayerProxy)

	if not pg.SystemOpenMgr.GetInstance().isOpenSystem(var_41_0, var_41_0.getRawData(var_41_9000).level, LOCK_NEW_EDUCATE_SYSTEM and "EducateMediator" or "NewEducateSelectMediator") then
		return false
	end

	return PlayerPrefs.GetInt(var_0_0.GetNewTipKey()) ~= 1
end

function var_0_0.ClearShowNewChildTip()
	PlayerPrefs.SetInt(var_0_0.GetNewTipKey(), 1)

	return
end

function var_0_0.ClearEventPerformance(arg_43_0)
	local var_43_0 = NewEducateConst.NEW_EDUCATE_EVENT_TIP .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_43_0.id .. "_" .. arg_43_0:GetGameCnt() .. "_"

	underscore.each(underscore.select(pg.child2_site_event_group.all, function(arg_44_0)
		return #pg.child2_site_event_group[arg_44_0].performance > 0
	end), function(arg_45_0)
		PlayerPrefs.SetInt(var_43_0 .. arg_45_0, 0)

		return
	end)

	return
end

function var_0_0.TrackRoundEnd()
	local var_46_9000
	local var_46_0 = getProxy(NewEducateProxy)
	local var_46_1 = var_46_0.GetCurChar(var_46_9000)
	local var_46_2 = underscore.map(var_46_1:GetAttrIds(), function(arg_47_0)
		return var_46_1:GetAttr(arg_47_0)
	end) or {}
	local var_46_3, var_46_4 = var_46_1:GetBenefitData().GetAllIds(var_46_0)

	pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataRoundEnd(var_46_1.id, var_46_1:GetGameCnt(), var_46_1:GetRoundData().round, var_46_1:GetResByType(NewEducateChar.RES_TYPE.MOOD), var_46_1:GetResByType(NewEducateChar.RES_TYPE.MONEY), var_46_1:GetResByType(NewEducateChar.RES_TYPE.FAVOR), var_46_1:GetPersonality(), table.concat(var_46_2, ","), table.concat(var_46_3, ",") .. ";" .. table.concat(var_46_4, ",")))

	return
end

function var_0_0.TrackEnterTime()
	if getProxy(NewEducateProxy):GetEnterTime() == 0 then
		getProxy(NewEducateProxy):RecordEnterTime()
		pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnter(getProxy(NewEducateProxy):GetCurChar().id, 0))
	end

	return
end

function var_0_0.TrackExitTime()
	local var_49_0 = getProxy(NewEducateProxy):GetEnterTime()

	if var_49_0 ~= 0 then
		pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataEnter(getProxy(NewEducateProxy):GetCurChar().id, 1, pg.TimeMgr.GetInstance():GetServerTime() - var_49_0))
		getProxy(NewEducateProxy):RecordEnterTime(0)
	end

	return
end

function var_0_0.GetAllUnlockSecretaryIds()
	local var_50_0 = getProxy(EducateProxy):GetSecretaryIDs()

	var_50_0 = var_50_0 or {}

	if not LOCK_NEW_EDUCATE_SYSTEM then
		local var_50_1 = getProxy(NewEducateProxy)

		for iter_50_0, iter_50_1 in ipairs(pg.child2_data.all) do
			if var_50_1:GetChar(iter_50_1) then
				local var_50_2 = var_50_1:GetChar(iter_50_1)

				if var_50_2:GetPermanentData() then
					local var_50_3 = var_50_1:GetChar(iter_50_1):GetPermanentData()

					var_50_0 = table.mergeArray(var_50_0, (var_50_3:GetUnlockSecretaryIds()))
				end
			end
		end
	end

	return var_50_0
end

function var_0_0.GetEducateCharacterList()
	for iter_51_0, iter_51_1 in pairs(pg.secretary_special_ship.get_id_list_by_character_id) do
		if not LOCK_NEW_EDUCATE_SYSTEM or iter_51_0 == 1000 then
			table.insert({}, EducateCharCharacter.New(iter_51_0))
		end
	end

	return {}
end

function var_0_0.GetSecIdBySkinId(arg_52_0)
	for iter_52_0, iter_52_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_52_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_SHOP and pg.secretary_special_ship[iter_52_1].unlock[1] == arg_52_0 then
			return iter_52_1
		end
	end

	return
end

function var_0_0.GetShipNameBySecId(arg_53_0)
	return pg.secretary_special_ship[arg_53_0].name
end

function var_0_0.IsUnlockDefaultShip(arg_54_0)
	return table.contains(var_0_0.GetAllUnlockSecretaryIds(), pg.secretary_special_ship[arg_54_0].character_id)
end

function var_0_0.HasAnyUnlockShip()
	local var_55_0 = var_0_0.GetAllUnlockSecretaryIds()

	if not var_55_0 then
		return false
	end

	return _.any(var_55_0, function(arg_56_0)
		return pg.secretary_special_ship[arg_56_0].character_id == arg_56_0
	end)
end

function var_0_0.UpdateUnlockBySkinId(arg_57_0)
	local var_57_0 = pg.secretary_special_ship[var_0_0.GetSecIdBySkinId(arg_57_0)].tb_id

	if var_57_0 == 0 then
		getProxy(EducateProxy):updateSecretaryIDs(true)
	else
		getProxy(NewEducateProxy):UpdateUnlock(var_57_0)
	end

	return
end

function var_0_0.GetEducateCharSlotMaxCnt()
	if LOCK_EDUCATE_SYSTEM then
		return 0
	end

	local var_58_0 = getProxy(PlayerProxy):getRawData()

	if var_58_0:ExistEducateChar() or var_0_0.HasAnyUnlockShip() then
		return 1
	else
		return 0
	end

	return
end

function var_0_0.ReqDataForServer()
	if not LOCK_EDUCATE_SYSTEM then
		table.insert({}, function(arg_60_0)
			pg.ConnectionMgr.GetInstance():Send(27000, {
				type = 1
			}, 27001, arg_60_0)

			return
		end)
	end

	if not LOCK_NEW_EDUCATE_SYSTEM then
		for iter_59_0, iter_59_1 in ipairs(pg.child2_data.all) do
			table.insert({}, function(arg_61_0)
				pg.ConnectionMgr.GetInstance():Send(29001, {
					id = iter_59_1
				}, 29002, arg_61_0)

				return
			end)
		end
	end

	seriesAsync({}, function()
		return
	end)

	return
end

return var_0_0
