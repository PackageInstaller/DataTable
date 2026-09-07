local IslandItemWildGahterBuilder = class("IslandItemWildGahterBuilder", import(".IslandGenericBuilder"))

function IslandItemWildGahterBuilder:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandItemWildGahterBuilder:GetModule(arg_2_1, arg_2_2)
	return IslandWildGatherUnit.New(arg_2_1, arg_2_2)
end

function IslandItemWildGahterBuilder:SetTag(arg_3_1)
	arg_3_1.tag = IslandConst.TAG_NPC

	return
end

function IslandItemWildGahterBuilder:AddComponents(arg_4_1, arg_4_2)
	return
end

return IslandItemWildGahterBuilder
