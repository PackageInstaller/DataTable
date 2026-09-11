local var_0_0 = {}
local var_0_2 = {
	play = function(self, arg_1_1)
		QWorldMgr:GetQWorldPerformMgr():GetCManager():PlayAnimeDuringInteract(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_1_1.eID).entity, self.animeActionName, self.crossFade, self.entity)
	end,
	putAt = function(self, arg_2_1)
		QWorldMgr:GetQWorldPerformMgr():GetCManager():PutAt(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_2_1.eID).entity, self.referencePointName)
	end,
	playEfx = function(self, arg_3_1)
		local var_3_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_3_1.eID)

		QWorldMgr:GetQWorldPerformMgr():GetCManager():PlayEffect(var_3_0.entity, self.attachPoint, self.efxPath, self.offset and Vector3.New(self.offset.x, self.offset.y, self.offset.z) or Vector3.zero, self.rotation and Quaternion.New(self.rotation.x, self.rotation.y, self.rotation.z, self.rotation.w) or Quaternion.identity, self.scale and Vector3.New(self.scale.x, self.scale.y, self.scale.z) or Vector3.one, self.duration, self.entity)
	end,
	clearEfx = function(self, arg_4_1)
		QWorldMgr:GetQWorldPerformMgr():GetCManager():ClearEffect(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_4_1.eID).entity, self.attachPoint, self.entity)
	end,
	attachTo = function(self, arg_5_1)
		local var_5_0 = QWorldMgr:GetQWorldPerformMgr():GetCManager().AttachToEntity

		QWorldMgr:GetQWorldPerformMgr():GetCManager().AttachToEntity(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_5_1.eID).entity, 1, self.attachPoint)
	end,
	grabPart = function(self, arg_6_1)
		local var_6_0 = QWorldMgr:GetQWorldPerformMgr():GetCManager().GrabItemPart

		QWorldMgr:GetQWorldPerformMgr():GetCManager().GrabItemPart(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_6_1.eID).entity, 1, self.itemPartName, self.attachPoint)
	end,
	restorePart = function(arg_7_0, arg_7_1)
		return
	end,
	setEntityVisible = function(self, arg_8_1)
		local var_8_0 = QWorldMgr:GetQWorldPerformMgr():GetCManager().SetVisible

		QWorldMgr:GetQWorldPerformMgr():GetCManager().SetVisible(QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_8_1.eID).entity, self.entity, self.visible)
	end
}

function var_0_0.DriveInteractSequenceNode(arg_9_0, arg_9_1)
	if type(arg_9_0) == "table" then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			if type(iter_9_1) == "table" then
				if var_0_2[iter_9_1.action] then
					var_0_2[iter_9_1.action](iter_9_1, arg_9_1)
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

	return (var_0_0.MakeCtx(arg_11_0, {
		nextAction = var_11_1,
		nextActionWaitTime = var_11_2,
		continuous = var_11_0
	}))
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

	var_0_0.MakeInteractTask(var_0_0.ValidateAction(nil, arg_13_1), var_13_0, arg_13_2)
	arg_13_2:SetOnComplete(function()
		if arg_13_3 ~= nil then
			arg_13_3(var_13_0)
		end
	end)
end

function var_0_0.ValidateAction(arg_15_0, arg_15_1)
	return var_0_0.GetSequence(nil, arg_15_0, (nullable(DormInteractSequence, arg_15_1, "name")))
end

function var_0_0.GetSequence(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = var_0_0.GetSequencePath(arg_16_0, arg_16_1, arg_16_2, arg_16_3)

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_1 = package.loaded[iter_16_1]

			if package.loaded[iter_16_1] == nil then
				if Dorm.InteractionGrouping[iter_16_1] then
					var_16_1 = Dorm.InteractionGrouping[iter_16_1][math.random(#Dorm.InteractionGrouping[iter_16_1])]
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

			if BackHomeHeroSkinCfg[arg_17_0] then
				var_17_3 = var_17_1.style
				var_17_2 = var_17_1.hero_id
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

function var_0_0:MakeInteractTask(arg_18_1, arg_18_2)
	if self then
		local var_18_0 = self.sequence
		local var_18_1 = self.duration
		local var_18_2 = self.keys

		arg_18_1.duration = self.duration

		arg_18_2:WaitUntil(function(arg_19_0)
			local var_19_1 = arg_19_0.k
			local var_19_2 = Time.time - arg_19_0.taskDataCtx.start

			while var_19_1 <= #var_18_2 and var_19_2 >= var_18_2[var_19_1] do
				var_0_0.DriveInteractSequenceNode(var_18_0[var_18_2[var_19_1]], arg_18_1)

				var_19_1 = var_19_1 + 1
			end

			arg_19_0.k = var_19_1
			arg_18_1.playTime = var_19_2

			return var_19_1 > #var_18_2 or var_19_2 >= var_18_1
		end, false, {
			k = 1
		})
		arg_18_2:WaitUntil(function(arg_20_0)
			arg_18_1.playTime = Time.time - arg_20_0.taskDataCtx.start

			return arg_18_1.playTime >= var_18_1
		end)

		if self.onAbort then
			arg_18_2:SetOnAbort(function()
				self.onAbort(arg_18_1)
			end)
		end

		if self.onComplete then
			arg_18_2:SetOnComplete(function()
				arg_18_1.playTime = arg_18_1.duration

				self.onComplete(arg_18_1)
			end)
		end

		return arg_18_2
	end
end

return var_0_0
