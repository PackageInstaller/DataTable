local IslandItemHandPlantBuilder = class("IslandItemHandPlantBuilder", import(".IslandGenericBuilder"))

function IslandItemHandPlantBuilder:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandItemHandPlantBuilder:GetModule(arg_2_1, arg_2_2)
	return IslandHandPlantUnit.New(arg_2_1, arg_2_2)
end

function IslandItemHandPlantBuilder:SetTag(arg_3_1)
	arg_3_1.tag = IslandConst.TAG_NPC

	return
end

function IslandItemHandPlantBuilder:AddComponents(arg_4_1, arg_4_2)
	arg_4_1:AddComponent(typeof(HighlightController))

	return
end

return IslandItemHandPlantBuilder
