local IslandFollowerUnitVO = class("IslandFollowerUnitVO", import(".IslandUnitVO"))

function IslandFollowerUnitVO:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.randomizer = defaultValue(arg_1_6, false)
	self.shipId = arg_1_1

	IslandFollowerUnitVO.super.Ctor(self, {
		behaviourTree = "Island/NodeCanvas/Npc/FollowNpc",
		id = arg_1_2,
		name = "FollowNpc" .. arg_1_2,
		type = IslandConst.UNIT_TYPE_FOLLOWER,
		modelId = arg_1_3,
		position = {
			arg_1_4.x,
			arg_1_4.y,
			arg_1_4.z
		},
		rotation = {
			arg_1_5.x,
			arg_1_5.y,
			arg_1_5.z
		},
		scale = {
			1,
			1,
			1
		}
	})

	return
end

function IslandFollowerUnitVO:IsSameShip(arg_2_1)
	return self.shipId == arg_2_1
end

function IslandFollowerUnitVO:GetShipId()
	return self.shipId
end

function IslandFollowerUnitVO:IsRandomizer()
	return self.randomizer
end

function IslandFollowerUnitVO:ActiveRandomizer()
	self.randomizer = true

	return
end

return IslandFollowerUnitVO
