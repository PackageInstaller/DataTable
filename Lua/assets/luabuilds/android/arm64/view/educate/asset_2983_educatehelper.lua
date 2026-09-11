local EducateHelper = class("EducateHelper")

function EducateHelper:GetItemAddDrops()
	local var_1_0 = {}

	underscore.each(pg.child_item[self.id].display, function(arg_2_0)
		assert(arg_2_0[1] == EducateConst.DROP_TYPE_ATTR or arg_2_0[1] == EducateConst.DROP_TYPE_RES, "非法道具增益, item id:" .. self.id)
		table.insert(var_1_0, {
			type = arg_2_0[1],
			id = arg_2_0[2],
			number = arg_2_0[3] * self.number
		})

		return
	end)

	return var_1_0
end

function EducateHelper:UpdateDropsData()
	local var_3_0 = getProxy(EducateProxy)

	for iter_3_0, iter_3_1 in ipairs(self) do
		switch(iter_3_1.type, {
			[EducateConst.DROP_TYPE_ATTR] = function()
				var_3_0:UpdateAttr(iter_3_1.id, iter_3_1.number)

				return
			end,
			[EducateConst.DROP_TYPE_RES] = function()
				var_3_0:UpdateRes(iter_3_1.id, iter_3_1.number)

				return
			end,
			[EducateConst.DROP_TYPE_ITEM] = function()
				var_3_0:AddItem(iter_3_1.id, iter_3_1.number)
				EducateHelper.UpdateDropsData((EducateHelper.GetItemAddDrops(iter_3_1)))

				return
			end,
			[EducateConst.DROP_TYPE_MEMORY] = function()
				var_3_0:AddMemory(iter_3_1.id, iter_3_1.number)

				return
			end,
			[EducateConst.DROP_TYPE_POLAROID] = function()
				var_3_0:AddPolaroid(iter_3_1.id)

				return
			end,
			[EducateConst.DROP_TYPE_BUFF] = function()
				var_3_0:AddBuff(iter_3_1.id)

				return
			end
		})
	end

	return
end

function EducateHelper:UpdateDropShow(arg_10_1)
	if arg_10_1.type == EducateConst.DROP_TYPE_MEMORY or arg_10_1.type == EducateConst.DROP_TYPE_POLAROID then
		pg.TipsMgr.GetInstance():ShowTips(string.format("不支持的掉落展示for Item,请检查配置！type:%d, id:%d", arg_10_1.type, arg_10_1.id))

		return
	end

	local var_10_0 = EducateHelper.GetDropConfig(arg_10_1)

	LoadImageSpriteAsync("educateprops/" .. var_10_0.icon, findTF(self, "frame/icon"))
	setText(findTF(self, "frame/count_bg/count"), "x" .. arg_10_1.number)
	setText(findTF(self, "name_bg/name"), shortenString(var_10_0.name, 5))

	if arg_10_1.type == EducateConst.DROP_TYPE_ITEM then
		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", EducateItem.RARITY2FRAME[var_10_0.rarity], findTF(self, "frame"))
	end

	return
end

function EducateHelper:GetDropConfig()
	return switch(self.type, {
		[EducateConst.DROP_TYPE_ATTR] = function()
			assert(pg.child_attr[self.id], "找不到child_attr配置, id: " .. self.id)

			return pg.child_attr[self.id]
		end,
		[EducateConst.DROP_TYPE_RES] = function()
			assert(pg.child_resource[self.id], "找不到child_resource配置, id: " .. self.id)

			return pg.child_resource[self.id]
		end,
		[EducateConst.DROP_TYPE_ITEM] = function()
			assert(pg.child_item[self.id], "找不到child_item配置, id: " .. self.id)

			return pg.child_item[self.id]
		end,
		[EducateConst.DROP_TYPE_MEMORY] = function()
			assert(pg.child_memory[self.id], "找不到child_memory配置, id: " .. self.id)

			return pg.child_memory[self.id]
		end,
		[EducateConst.DROP_TYPE_POLAROID] = function()
			assert(pg.child_polaroid[self.id], "找不到child_polaroid配置, id: " .. self.id)

			return pg.child_polaroid[self.id]
		end,
		[EducateConst.DROP_TYPE_BUFF] = function()
			assert(pg.child_buff[self.id], "找不到child_buff配置, id: " .. self.id)

			return pg.child_buff[self.id]
		end
	})
end

function EducateHelper:GetColorForAttrDrop()
	if self.type == EducateConst.DROP_TYPE_RES then
		return Color.NewHex("6FD9C4")
	elseif self.type == EducateConst.DROP_TYPE_ATTR then
		local var_18_0 = getProxy(EducateProxy):GetCharData():GetAttrTypeById(self.id)

		if var_18_0 == EducateChar.ATTR_TYPE_MAJOR then
			return Color.NewHex("5DC9FD")
		elseif var_18_0 == EducateChar.ATTR_TYPE_PERSONALITY then
			return Color.NewHex("6FD9C4")
		elseif var_18_0 == EducateChar.ATTR_TYPE_MINOR then
			return Color.NewHex("8CA1EE")
		end
	end

	return Color.NewHex("39BFFF")
end

function EducateHelper:UpdateDropShowForAttr(arg_19_1)
	if arg_19_1.type ~= EducateConst.DROP_TYPE_ATTR and arg_19_1.type ~= EducateConst.DROP_TYPE_RES then
		pg.TipsMgr.GetInstance():ShowTips(string.format("不支持的掉落展示for Attr,请检查配置！type:%d, id:%d", arg_19_1.type, arg_19_1.id))

		return
	end

	setImageColor(self, EducateHelper.GetColorForAttrDrop(arg_19_1))

	local var_19_0 = arg_19_1.type == EducateConst.DROP_TYPE_ATTR and "attr_" or "res_"
	local var_19_1 = arg_19_1.number > 0 and "+" or ""
	local var_19_2 = EducateHelper.GetDropConfig(arg_19_1)

	setActive(findTF(self, "icon"), true)
	GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", var_19_0 .. arg_19_1.id, findTF(self, "icon"))
	setText(findTF(self, "name"), var_19_2.name)
	setText(findTF(self, "value"), var_19_1 .. arg_19_1.number)

	return
end

function EducateHelper:FilterDropByTypes(arg_20_1)
	return underscore.select(self, function(arg_21_0)
		return table.contains(arg_20_1, arg_21_0.type)
	end)
end

function EducateHelper:GetDialogueShowDrops()
	return EducateHelper.FilterDropByTypes(self, {
		EducateConst.DROP_TYPE_ATTR,
		EducateConst.DROP_TYPE_RES,
		EducateConst.DROP_TYPE_BUFF
	})
end

function EducateHelper:GetCommonShowDrops()
	return EducateHelper.FilterDropByTypes(self, {
		EducateConst.DROP_TYPE_ITEM,
		EducateConst.DROP_TYPE_POLAROID
	})
end

function EducateHelper:UpdateAvatarShow(arg_24_1, arg_24_2)
	setImageSprite(findTF(self, "mask/Image"), LoadSprite("squareicon/" .. arg_24_2), true)

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_0 = findTF(self, "progress/" .. iter_24_1[1])

		setFillAmount(var_24_0, iter_24_1[2] - 0.005)
		setLocalEulerAngles(var_24_0, Vector3(0, 0, 24 * 0))
	end

	return
end

function EducateHelper:GetTimeFromCfg()
	return {
		month = self[1],
		week = self[2],
		day = self[3]
	}
end

function EducateHelper:IsSameDay(arg_26_1)
	return self.month == arg_26_1.month and self.week == arg_26_1.week and self.day == arg_26_1.day
end

function EducateHelper:CfgTime2Time()
	local var_27_0 = {
		month = self[1][1]
	}

	var_27_0.week = self[1][2] or 1
	var_27_0.day = self[1][3] or 1

	local var_27_1 = {
		month = self[2][1]
	}

	var_27_1.week = self[2][2] or 4
	var_27_1.day = self[2][3] or 7

	return var_27_0, var_27_1
end

function EducateHelper:IsBeforeTime(arg_28_1)
	if self.month < arg_28_1.month then
		return true
	end

	if self.month == arg_28_1.month and self.week < arg_28_1.week then
		return true
	end

	if self.month == arg_28_1.month and self.week == arg_28_1.week and self.day < arg_28_1.day then
		return true
	end

	return false
end

function EducateHelper:IsAfterTime(arg_29_1)
	if self.month > arg_29_1.month then
		return true
	end

	if self.month == arg_29_1.month and self.week > arg_29_1.week then
		return true
	end

	if self.month == arg_29_1.month and self.week == arg_29_1.week and self.day > arg_29_1.day then
		return true
	end

	return false
end

function EducateHelper:InTime(arg_30_1, arg_30_2)
	return not EducateHelper.IsBeforeTime(self, arg_30_1) and not EducateHelper.IsAfterTime(self, arg_30_2)
end

function EducateHelper:GetTimeAfterDays(arg_31_1)
	local var_31_0 = {
		month = self.month,
		week = self.week,
		day = self.day,
		day = self.day + arg_31_1
	}

	while var_31_0.day > 7 or var_31_0.week > 4 do
		if var_31_0.day > 7 then
			var_31_0.day = var_31_0.day - 7
			var_31_0.week = var_31_0.week + 1
		end

		if var_31_0.week > 4 then
			var_31_0.week = var_31_0.week - 4
			var_31_0.month = var_31_0.month + 1
		end
	end

	return var_31_0
end

function EducateHelper:GetTimeAfterWeeks(arg_32_1)
	local var_32_0 = {
		month = self.month,
		week = self.week,
		day = self.day
	}

	var_32_0.week = var_32_0.week + arg_32_1

	while var_32_0.week > 4 do
		var_32_0.week = var_32_0.week - 4
		var_32_0.month = var_32_0.month + 1
	end

	return var_32_0
end

function EducateHelper:GetDaysBetweenTimes(arg_33_1)
	return (arg_33_1.month - self.month) * 28 + (arg_33_1.week - self.week) * 7 + (arg_33_1.day - self.day)
end

function EducateHelper:GetWeekIdxWithTime()
	return (self.month - 1) * 4 + self.week
end

function EducateHelper:GetShowMonthNumber()
	return (self > 12 or nil) and (self - 12 or self)
end

function EducateHelper:GetWeekByNumber()
	if self == 7 then
		return i18n("word_day")
	else
		return i18n("number_" .. self)
	end

	return
end

function EducateHelper:GetWeekStrByNumber()
	return i18n("word_week_day" .. self)
end

function EducateHelper:InUnlockTime(arg_38_1)
	if self.month > arg_38_1[1] then
		return true
	end

	if self.month == arg_38_1[1] and self.week > arg_38_1[2] then
		return true
	end

	if self.month == arg_38_1[1] and self.week == arg_38_1[2] and self.day >= arg_38_1[3] then
		return true
	end

	return false
end

function EducateHelper:IsSystemUnlock()
	if not getProxy(EducateProxy):IsFirstGame() and EducateConst.SYSTEM_UNLOCK_CONFIG[self][2] then
		return true
	end

	return EducateHelper.InUnlockTime(getProxy(EducateProxy):GetCurTime(), pg.gameset[EducateConst.SYSTEM_UNLOCK_CONFIG[self][1]].description)
end

function EducateHelper.IsShowNature()
	local var_40_0, var_40_1 = EducateHelper.CfgTime2Time(pg.gameset.child_charactor_time.description)

	return EducateHelper.InTime(getProxy(EducateProxy):GetCurTime(), var_40_0, var_40_1)
end

function EducateHelper:IsSiteUnlock(arg_41_1)
	return EducateHelper.InUnlockTime(getProxy(EducateProxy):GetCurTime(), (arg_41_1 or nil) and (pg.child_site[self].unlock_time_1 or pg.child_site[self].unlock_time_2))
end

function EducateHelper:IsMatchSubType(arg_42_1)
	if self == "" then
		return false
	end

	if type(self) == "table" then
		return table.contains(self, arg_42_1)
	elseif type(self) == "string" then
		return arg_42_1 == tonumber(self)
	end

	return false
end

function EducateHelper:ReqEducateDataCheck()
	if LOCK_EDUCATE_SYSTEM then
		self()

		return
	end

	local var_43_0 = {}

	if not getProxy(EducateProxy):CheckDataRequestEnd() then
		table.insert(var_43_0, function(arg_44_0)
			pg.m02:sendNotification(GAME.EDUCATE_REQUEST, {
				callback = arg_44_0
			})

			return
		end)
	end

	seriesAsync(var_43_0, self)

	return
end

return EducateHelper
