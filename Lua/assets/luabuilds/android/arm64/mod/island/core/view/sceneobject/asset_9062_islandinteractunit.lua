local IslandInteractUnit = class("IslandInteractUnit", import(".IslandSceneUnit"))

function IslandInteractUnit:OnAttach(arg_1_1)
	local var_1_0 = arg_1_1 or self._go

	self.signalReceiver = GetOrAddComponent(arg_1_1 or self._go, "DftCommonSignalReceiver")

	self.signalReceiver:SetCommonEvent(function(arg_2_0)
		if self.ignoreSignal then
			return
		end

		switch(arg_2_0.stringParameter, {
			TimelineEnd = function()
				self:Op("WorldObjectInterActionEnd", self.id, self.view.player.id)

				return
			end
		})

		return
	end)

	self.director = GetOrAddComponent(var_1_0, typeof(UnityEngine.Playables.PlayableDirector))
	self.cachePlayerTransformInfoDic = {}

	return
end

function IslandInteractUnit:SetTimelineDic(arg_4_1)
	self.timelineDic = arg_4_1

	return
end

function IslandInteractUnit:GetTargetRoot()
	return self._go.transform
end

function IslandInteractUnit:GetPlayerParent()
	return self:GetTargetRoot()
end

function IslandInteractUnit:StartInteract(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if arg_7_6 then
		self.director:Stop()
	end

	arg_7_1:ActiveOrDisactive(false)

	if arg_7_7 then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue("inProgress", true)

		self.ignoreSignal = false
	else
		self.ignoreSignal = true
	end

	self:SetPlayerTransform(arg_7_1, self:GetPlayerParent())

	if arg_7_5 and #arg_7_5 > 1 then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue(arg_7_5[1], arg_7_5[2])
	end

	self.director.playableAsset = self.timelineDic[arg_7_3]

	if arg_7_4.is_loop == 1 then
		self.director.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop or UnityEngine.Playables.DirectorWrapMode.None
	end

	self:BindPlayer(arg_7_2, arg_7_1)
	self:BindSelf(arg_7_4)

	self.director.enabled = true

	self.director:Play()

	return
end

function IslandInteractUnit:EndInteract(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 then
		if self.director.extrapolationMode == UnityEngine.Playables.DirectorWrapMode.None then
			self.director.time = self.director.duration or 0
		end

		self.director:Evaluate()
		self.director:Stop()

		self.director.enabled = false
	end

	self:BindPlayer(arg_8_2, nil)

	if arg_8_1 then
		arg_8_1:ActiveOrDisactive(true)
	end

	if arg_8_4 then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue("inProgress", false)
		onNextTick(function()
			self:RevertPlayerTransform(arg_8_1)

			return
		end)
	else
		self:RevertPlayerTransform(arg_8_1)
	end

	return
end

function IslandInteractUnit:InitStatus(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 and #arg_10_3 > 1 then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue(arg_10_3[1], arg_10_3[2])
	end

	self.director.playableAsset = self.timelineDic[arg_10_1]

	self:BindSelf(arg_10_2)

	self.ignoreSignal = true
	self.director.enabled = true

	self.director:Play()

	self.director.time = self.director.duration

	self.director:Evaluate()
	self.director:Stop()

	return
end

function IslandInteractUnit:BindSelf(arg_11_1)
	local var_11_0 = TimelineHelper.GetGroupTracks(self.director):ToTable()

	if #var_11_0 > 0 then
		local var_11_1 = TimelineHelper.GetChildTracks(var_11_0[1]):ToTable()

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_2, var_11_3 = table.Find(arg_11_1.binding_track, function(arg_12_0, arg_12_1)
				return arg_12_1 == iter_11_0
			end)

			if var_11_3 ~= nil then
				if arg_11_1.binding_path[var_11_3] == "" then
					local var_11_4 = self:GetTargetRoot() or self:GetTargetRoot():Find(arg_11_1.binding_path[var_11_3])

					if var_11_4 then
						TimelineHelper.SetAutoBinding(self.director, iter_11_1, go(var_11_4))
					end
				end
			end
		end

		for iter_11_2, iter_11_3 in ipairs(arg_11_1.control_binding or {}) do
			local var_11_5 = iter_11_3[2]
			local var_11_6 = iter_11_3[3] or ""

			if var_11_1[iter_11_3[1]] and var_11_5 and var_11_5 > 0 then
				if var_11_6 == "" then
					local var_11_7 = self:GetTargetRoot() or self:GetTargetRoot():Find(var_11_6)

					if var_11_7 then
						TimelineHelper.SetControlBinding(self.director, var_11_1[iter_11_3[1]], var_11_5 - 1, go(var_11_7))
					end
				end
			end
		end
	end

	return
end

function IslandInteractUnit:BindPlayer(arg_13_1, arg_13_2)
	local var_13_0 = TimelineHelper.GetGroupTracks(self.director):ToTable()
	local var_13_1 = arg_13_2 and go(arg_13_2._go.transform:GetChild(0))
	local var_13_2 = arg_13_2 and arg_13_2._go

	if arg_13_1 < #var_13_0 then
		for iter_13_0, iter_13_1 in ipairs((TimelineHelper.GetChildTracks(var_13_0[arg_13_1 + 1]):ToTable())) do
			if iter_13_0 == 1 then
				TimelineHelper.SetAutoBinding(self.director, iter_13_1, var_13_2)
			else
				TimelineHelper.SetAutoBinding(self.director, iter_13_1, var_13_1)
			end
		end
	end

	return
end

function IslandInteractUnit:SetPlayerTransform(arg_14_1, arg_14_2)
	self.cachePlayerTransformInfoDic[arg_14_1.id] = {
		position = arg_14_1._tf.position,
		rotation = arg_14_1._tf.rotation
	}

	setParent(arg_14_1._tf, arg_14_2)

	arg_14_1._tf.localPosition = Vector3.zero
	arg_14_1._tf.localRotation = Quaternion.identity
	GetOrAddComponent(arg_14_1._go, typeof(UnityEngine.Animator)).enabled = true

	return
end

function IslandInteractUnit:RevertPlayerTransform(arg_15_1)
	if not arg_15_1 or not self.cachePlayerTransformInfoDic[arg_15_1.id] then
		return
	end

	setParent(arg_15_1._tf, self.view.root)

	arg_15_1._tf.position = self.cachePlayerTransformInfoDic[arg_15_1.id].position
	arg_15_1._tf.rotation = self.cachePlayerTransformInfoDic[arg_15_1.id].rotation
	GetOrAddComponent(arg_15_1._go, typeof(UnityEngine.Animator)).enabled = false
	self.cachePlayerTransformInfoDic[arg_15_1.id] = nil

	return
end

return IslandInteractUnit
