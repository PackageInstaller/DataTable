local IslandItemHandCollectBuilder = class("IslandItemHandCollectBuilder", import(".IslandGenericBuilder"))

function IslandItemHandCollectBuilder:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandItemHandCollectBuilder:GetModule(arg_2_1, arg_2_2)
	return IslandHandCollectUnit.New(arg_2_1, arg_2_2)
end

function IslandItemHandCollectBuilder:SetTag(arg_3_1)
	arg_3_1.tag = IslandConst.TAG_NPC

	return
end

function IslandItemHandCollectBuilder:AddComponents(arg_4_1, arg_4_2)
	return
end

return IslandItemHandCollectBuilder
