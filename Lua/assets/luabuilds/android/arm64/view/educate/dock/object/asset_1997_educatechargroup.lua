local EducateCharGroup = class("EducateCharGroup")

function EducateCharGroup:Ctor(arg_1_1)
	self.id = arg_1_1
	self.charIdList = {}

	for iter_1_0, iter_1_1 in ipairs(pg.secretary_special_ship.get_id_list_by_group[arg_1_1]) do
		if pg.secretary_special_ship[iter_1_1].secrerary_show == 1 then
			table.insert(self.charIdList, iter_1_1)
		end
	end

	return
end

function EducateCharGroup:GetSortWeight()
	return pg.secretary_special_ship[self:GetShowId()].type
end

function EducateCharGroup:GetCharIdList()
	return self.charIdList
end

function EducateCharGroup:GetTitle()
	if pg.secretary_special_ship[self:GetShowId()].genghuan_word == 1 then
		return i18n("secretary_special_title_age")
	else
		return i18n("secretary_special_title_physiognomy")
	end

	return
end

function EducateCharGroup:GetUnlockDesc()
	return pg.secretary_special_ship[self:GetShowId()].unlock_desc
end

function EducateCharGroup:GetSpriteName()
	return "label_" .. pg.secretary_special_ship[self:GetShowId()].type
end

function EducateCharGroup:GetShowId()
	return (_.detect(self.charIdList, function(arg_8_0)
		return pg.secretary_special_ship[arg_8_0].type ~= 0
	end))
end

function EducateCharGroup:IsSp()
	return pg.secretary_special_ship[self:GetShowId()].type == EducateConst.SECRETARY_TYPE_SP
end

function EducateCharGroup:GetShowPainting()
	local var_10_0 = self:GetShowId()

	assert(var_10_0)

	return pg.secretary_special_ship[var_10_0].painting
end

function EducateCharGroup:IsSelected(arg_11_1)
	return _.any(self.charIdList, function(arg_12_0)
		return arg_11_1 == arg_12_0
	end)
end

function EducateCharGroup:IsLock()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs((NewEducateHelper.GetAllUnlockSecretaryIds())) do
		var_13_0[iter_13_1] = true
	end

	return _.all(self.charIdList, function(arg_14_0)
		return not var_13_0[arg_14_0]
	end)
end

function EducateCharGroup:ShouldTip()
	local var_15_0 = getProxy(SettingsProxy)

	return _.any(self.charIdList, function(arg_16_0)
		return var_15_0:_ShouldEducateCharTip(arg_16_0)
	end)
end

return EducateCharGroup
