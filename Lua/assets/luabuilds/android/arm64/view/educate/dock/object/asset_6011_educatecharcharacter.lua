local EducateCharCharacter = class("EducateCharCharacter")

function EducateCharCharacter:Ctor(arg_1_1)
	self.id = arg_1_1
	self.groupList = {}

	for iter_1_0, iter_1_1 in pairs(pg.secretary_special_ship.get_id_list_by_group) do
		if table.contains(pg.secretary_special_ship.get_id_list_by_character_id[arg_1_1], iter_1_0) then
			table.insert(self.groupList, EducateCharGroup.New(iter_1_0))
		end
	end

	return
end

function EducateCharCharacter:GetGroupList()
	return self.groupList
end

function EducateCharCharacter:GetGroupById(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.groupList) do
		if iter_3_1.id == arg_3_1 then
			return iter_3_1
		end
	end

	return
end

function EducateCharCharacter:IsLock()
	return not NewEducateHelper.IsUnlockDefaultShip(self.id)
end

function EducateCharCharacter:IsSelected(arg_5_1)
	return _.any(self.groupList, function(arg_6_0)
		return arg_6_0:IsSelected(arg_5_1)
	end)
end

function EducateCharCharacter:GetDefaultFrame()
	return pg.secretary_special_ship[self.id].head
end

function EducateCharCharacter:ShouldTip()
	return _.any(self.groupList, function(arg_9_0)
		return arg_9_0:ShouldTip()
	end)
end

return EducateCharCharacter
