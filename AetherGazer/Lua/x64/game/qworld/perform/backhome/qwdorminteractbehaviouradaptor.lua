local var_0_0 = {}
local var_0_1 = {
	SELF = 0,
	FURNITURE = 1
}
local var_0_2 = {
	play = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_1.eID
		local var_1_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_1_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager():PlayAnimeDuringInteract(var_1_1.entity, arg_1_0.animeActionName, arg_1_0.crossFade, arg_1_0.entity)
	end,
	putAt = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.eID
		local var_2_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_2_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager():PutAt(var_2_1.entity, arg_2_0.referencePointName)
	end,
	playEfx = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1.eID
		local var_3_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_3_0)
		local var_3_2
		local var_3_3
		local var_3_4

		if arg_3_0.offset then
			var_3_2 = Vector3.New(arg_3_0.offset.x, arg_3_0.offset.y, arg_3_0.offset.z)
		else
			var_3_2 = Vector3.zero
		end

		if arg_3_0.rotation then
			var_3_3 = Quaternion.New(arg_3_0.rotation.x, arg_3_0.rotation.y, arg_3_0.rotation.z, arg_3_0.rotation.w)
		else
			var_3_3 = Quaternion.identity
		end

		if arg_3_0.scale then
			var_3_4 = Vector3.New(arg_3_0.scale.x, arg_3_0.scale.y, arg_3_0.scale.z)
		else
			var_3_4 = Vector3.one
		end

		QWorldMgr:GetQWorldPerformMgr():GetCManager():PlayEffect(var_3_1.entity, arg_3_0.attachPoint, arg_3_0.efxPath, var_3_2, var_3_3, var_3_4, arg_3_0.duration, arg_3_0.entity)
	end,
	clearEfx = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1.eID
		local var_4_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_4_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager():ClearEffect(var_4_1.entity, arg_4_0.attachPoint, arg_4_0.entity)
	end,
	attachTo = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1.eID
		local var_5_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_5_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager().AttachToEntity(var_5_1.entity, 1, arg_5_0.attachPoint)
	end,
	grabPart = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1.eID
		local var_6_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_6_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager().GrabItemPart(var_6_1.entity, 1, arg_6_0.itemPartName, arg_6_0.attachPoint)
	end,
	restorePart = function(arg_7_0, arg_7_1)
		return
	end,
	setEntityVisible = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.eID
		local var_8_1 = QWorldMgr:GetQWorldEntityMgr():GetEnt(var_8_0)

		QWorldMgr:GetQWorldPerformMgr():GetCManager().SetVisible(var_8_1.entity, arg_8_0.entity, arg_8_0.visible)
	end
}

function var_0_0.DriveInteractSequenceNode(arg_9_0, arg_9_1)
	if type(arg_9_0) == "table" then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			if type(iter_9_1) == "table" then
				local var_9_0 = iter_9_1.action
				local var_9_1 = var_0_2[var_9_0]

				if var_9_1 then
					var_9_1(iter_9_1, arg_9_1)
				end
			else
				iter_9_1(arg_9_1)
			end
		end
	elseif type(arg_9_0) == "function" then
		arg_9_0(arg_9_1)
	end
end

function var_0_0.MakeCtx(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 or {}

	var_10_0.eID = arg_10_0

	return var_10_0
end

function var_0_0.MakeDefaultCtx(arg_11_0, arg_11_1)
	local var_11_0, var_11_1, var_11_2 = var_0_0.GetNextAction(arg_11_1)
	local var_11_3 = {
		nextAction = var_11_1,
		nextActionWaitTime = var_11_2,
		continuous = var_11_0
	}

	return (var_0_0.MakeCtx(arg_11_0, var_11_3))
end

function var_0_0.GetNextAction(arg_12_0)
	local var_12_0 = nullable(DormInteractSequence, arg_12_0, "next_action")

	if var_12_0 and next(var_12_0) then
		local var_12_1 = var_12_0[math.random(#var_12_0)]

		return true, nullable(var_12_1, 1), nullable(var_12_1, 2)
	end

	return false
end

function var_0_0.SetupInteractTask(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = var_0_0.MakeDefaultCtx(arg_13_0, arg_13_1)

	var_13_0.onComplete = arg_13_3

	local var_13_1 = var_0_0.ValidateAction(nil, arg_13_1)

	var_0_0.MakeInteractTask(var_13_1, var_13_0, arg_13_2)
	arg_13_2:SetOnComplete(function()
		if arg_13_3 ~= nil then
			arg_13_3(var_13_0)
		end
	end)
end

function var_0_0.ValidateAction(arg_15_0, arg_15_1)
	local var_15_0 = nullable(DormInteractSequence, arg_15_1, "name")

	return var_0_0.GetSequence(nil, arg_15_0, var_15_0)
end

function var_0_0.GetSequence(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = var_0_0.GetSequencePath(arg_16_0, arg_16_1, arg_16_2, arg_16_3)

	arg_16_4 = Dorm.InteractionGrouping

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_1 = package.loaded[iter_16_1]

			if var_16_1 == nil then
				local var_16_2 = arg_16_4[iter_16_1]

				if var_16_2 then
					var_16_1 = var_16_2[math.random(#var_16_2)]
				end
			end

			if var_16_1 then
				return var_16_1
			end
		end
	end
end

function var_0_0.GetSequencePath(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = arg_17_3 or "game.dorm.interacts.qworld"

	if arg_17_2 ~= nil then
		local var_17_0 = {}

		if arg_17_0 then
			if arg_17_1 then
				table.insert(var_17_0, string.format("%s.%d.%d_%s", arg_17_3, arg_17_0, arg_17_1, arg_17_2))
			end

			local var_17_1 = BackHomeHeroSkinCfg[arg_17_0]
			local var_17_2 = arg_17_0
			local var_17_3

			if var_17_1 then
				var_17_2, var_17_3 = var_17_1.hero_id, var_17_1.style
			end

			table.insert(var_17_0, string.format("%s.%d.%s", arg_17_3, arg_17_0, arg_17_2))
			table.insert(var_17_0, string.format("%s.%d.%s", arg_17_3, var_17_2, arg_17_2))

			if var_17_3 then
				table.insert(var_17_0, string.format("%s.%s.%s", arg_17_3, var_17_3, arg_17_2))
			end
		end

		table.insert(var_17_0, string.format("%s.%s", arg_17_3, arg_17_2))

		return var_17_0
	end
end

function var_0_0.MakeInteractTask(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0 then
		local var_18_0 = arg_18_0.sequence
		local var_18_1 = arg_18_0.duration
		local var_18_2 = arg_18_0.keys

		arg_18_1.duration = var_18_1

		local var_18_3 = arg_18_2

		var_18_3:WaitUntil(function(arg_19_0)
			local var_19_0 = arg_19_0.taskDataCtx.task.taskRunner
			local var_19_1 = arg_19_0.taskDataCtx.start
			local var_19_2 = arg_19_0.k
			local var_19_3 = Time.time - var_19_1

			while var_19_2 <= #var_18_2 and var_19_3 >= var_18_2[var_19_2] do
				local var_19_4 = var_18_0[var_18_2[var_19_2]]

				var_0_0.DriveInteractSequenceNode(var_19_4, arg_18_1)

				var_19_2 = var_19_2 + 1
			end

			arg_19_0.k = var_19_2
			arg_18_1.playTime = var_19_3

			return var_19_2 > #var_18_2 or var_19_3 >= var_18_1
		end, false, {
			k = 1
		})
		var_18_3:WaitUntil(function(arg_20_0)
			local var_20_0 = arg_20_0.taskDataCtx.task.taskRunner
			local var_20_1 = arg_20_0.taskDataCtx.start

			arg_18_1.playTime = Time.time - var_20_1

			return arg_18_1.playTime >= var_18_1
		end)

		if arg_18_0.onAbort then
			var_18_3:SetOnAbort(function()
				arg_18_0.onAbort(arg_18_1)
			end)
		end

		if arg_18_0.onComplete then
			var_18_3:SetOnComplete(function()
				arg_18_1.playTime = arg_18_1.duration

				arg_18_0.onComplete(arg_18_1)
			end)
		end

		return var_18_3
	end
end

return var_0_0
