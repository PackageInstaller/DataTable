local IslandStrollUnitVO = class("IslandStrollUnitVO", import(".IslandUnitVO"))

function IslandStrollUnitVO:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.shipId = arg_1_1

	IslandStrollUnitVO.super.Ctor(self, {
		name = "StrollNpc",
		id = arg_1_2,
		type = IslandConst.UNIT_TYPE_STROLL,
		modelId = arg_1_3 or pg.island_strollnpc[arg_1_2].unit_id,
		behaviourTree = self:GetDefaultBt(pg.island_strollnpc[arg_1_2]),
		position = {
			0,
			0,
			0
		},
		rotation = {
			0,
			0,
			0
		},
		scale = {
			0,
			0,
			0
		}
	})

	self.config = pg.island_strollnpc[arg_1_2]
	self.actionFeedback = nil
	self.skillActionFeedback = nil

	return
end

function IslandStrollUnitVO:GetShipId()
	return self.shipId
end

function IslandStrollUnitVO:IsSameShip(arg_3_1)
	return self.shipId == arg_3_1
end

function IslandStrollUnitVO:SetSkillActionFeedback(arg_4_1)
	self.skillActionFeedback = arg_4_1

	return
end

function IslandStrollUnitVO:ClearSkillActionFeedback()
	self.skillActionFeedback = nil

	return
end

function IslandStrollUnitVO:ExistSkillActionFeedback()
	return self.skillActionFeedback ~= nil
end

function IslandStrollUnitVO:SetActionFeedback(arg_7_1)
	self.actionFeedback = arg_7_1

	return
end

function IslandStrollUnitVO:ExistActionFeedback()
	return self.actionFeedback ~= nil
end

function IslandStrollUnitVO:ClearActionFeedback()
	self.actionFeedback = nil

	return
end

function IslandStrollUnitVO:GetGreetingFeedback()
	return self.actionFeedback or self.skillActionFeedback
end

function IslandStrollUnitVO:ExistGreetingActionFeedback()
	return self:GetGreetingFeedback() ~= nil
end

function IslandStrollUnitVO:ClearGreetingActionFeedback()
	self.actionFeedback = nil
	self.skillActionFeedback = nil

	return
end

function IslandStrollUnitVO:OnlySkillActionFeedback()
	return not self:ExistActionFeedback() and self:ExistSkillActionFeedback()
end

local function var_0_1(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if pg.island_action_feedback[iter_14_1].feedback_type == arg_14_0 then
			table.insert(var_14_0, iter_14_1)
		end
	end

	if #var_14_0 <= 0 then
		return nil
	end

	return var_14_0[math.random(1, #var_14_0)]
end

function IslandStrollUnitVO:GetResponeAction(arg_15_1)
	local var_15_0 = self:GetGreetingFeedback()
	local var_15_1 = pg.island_action[arg_15_1].feedback_type

	if var_15_0 and var_15_0 == arg_15_1 then
		return var_0_1(var_15_1, pg.island_action_feedback.get_id_list_by_condition[1]), true
	else
		return var_0_1(var_15_1, pg.island_action_feedback.get_id_list_by_condition[2]), false
	end

	return
end

function IslandStrollUnitVO:GetDefaultBt(arg_16_1)
	if not arg_16_1.behaviourTree or arg_16_1.behaviourTree == "" then
		return "Island/NodeCanvas/Npc/StrollNpc"
	end

	return arg_16_1.behaviourTree
end

function IslandStrollUnitVO:GetDefaultPathId(arg_17_1)
	local var_17_0 = _.detect(self.config.mapId, function(arg_18_0)
		return arg_18_0[1] == arg_17_1
	end)

	return var_17_0 and var_17_0[2]
end

function IslandStrollUnitVO:SetPath(arg_19_1, arg_19_2)
	self.position = BuildVector3(arg_19_2)
	self.pathId = arg_19_1

	return
end

function IslandStrollUnitVO:GetPath()
	return self.pathId
end

return IslandStrollUnitVO
