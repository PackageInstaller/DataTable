local IslandShipSkin = class("IslandShipSkin", import("model.vo.BaseVO"))

function IslandShipSkin:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.color_id = arg_1_1.color_id
	self.color_list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.color_list or {}) do
		table.insert(self.color_list, iter_1_1)
	end

	return
end

function IslandShipSkin:CheckColorOwned(arg_2_1)
	if arg_2_1 == 0 then
		return true
	end

	for iter_2_0, iter_2_1 in ipairs(self.color_list or {}) do
		if iter_2_1 == arg_2_1 then
			return true
		end
	end

	return false
end

function IslandShipSkin:SetCurrentColor(arg_3_1)
	self.color_id = arg_3_1

	return
end

function IslandShipSkin:GetCurrentColor(arg_4_1)
	return self.color_id or 0
end

function IslandShipSkin:AddSkinColor(arg_5_1)
	table.insert(self.color_list, arg_5_1)

	return
end

function IslandShipSkin:IsOwnAllColor()
	return #self.color_list == #pg.island_skin_colordiff_template.get_id_list_by_skin_group[self.id]
end

return IslandShipSkin
