local IslandWayPoint = class("IslandWayPoint")

IslandWayPoint.ACTION_TYPE_CHATBUBBLE = 1
IslandWayPoint.ACTION_TYPE_ANIM = 2

function IslandWayPoint:Ctor(arg_1_1)
	self.config = pg.island_waypoint[arg_1_1]
	self.position = BuildVector3(self.config.position)
	self.processAction = nil
	self.arriveAction = nil

	return
end

function IslandWayPoint:RandomProcessAction()
	self.processAction = self:BuildAction(self.config.process_action, self.config.process_dialogue, self.config.process_time)

	return
end

function IslandWayPoint:GetActionWhenProcess()
	return self.processAction
end

function IslandWayPoint:RandomArriveAction()
	self.arriveAction = self:BuildAction(self.config.arrive_action, self.config.arrive_dialogue, 0)

	return
end

function IslandWayPoint:GetActionWhenArrive()
	return self.arriveAction
end

function IslandWayPoint:GetRotationWhenArrive()
	if self.config.turn_to == 0 then
		return 0
	end

	return self.config.rotation or 0
end

function IslandWayPoint:DisappearWhenArrive()
	return self.config.disappear == 1
end

function IslandWayPoint:GetStartNextOneTime()
	return self.config.wait or 0
end

function IslandWayPoint:BuildAction(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = #arg_9_1
	local var_9_1 = arg_9_2 ~= ""

	if arg_9_2 ~= "" then
		var_9_0 = var_9_0 + 1
	end

	if var_9_0 == 0 then
		return nil
	end

	local var_9_2 = math.random(1, var_9_0)

	if var_9_1 and var_9_2 == var_9_0 then
		return {
			type = IslandWayPoint.ACTION_TYPE_CHATBUBBLE,
			action = arg_9_2,
			time = arg_9_3
		}
	else
		return {
			type = IslandWayPoint.ACTION_TYPE_ANIM,
			action = arg_9_1[var_9_2],
			time = arg_9_3
		}
	end

	return
end

return IslandWayPoint
