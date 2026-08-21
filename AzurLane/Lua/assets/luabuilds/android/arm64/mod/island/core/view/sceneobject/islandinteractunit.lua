local var_0_0 = class("IslandInteractUnit", import(".IslandSceneUnit"))

function var_0_0.OnAttach(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 or arg_1_0._go

	arg_1_0.signalReceiver = GetOrAddComponent(arg_1_1 or arg_1_0._go, "DftCommonSignalReceiver")

	arg_1_0.signalReceiver:SetCommonEvent(function(arg_2_0)
		if arg_1_0.ignoreSignal then
			return
		end

		switch(arg_2_0.stringParameter, {
			TimelineEnd = function()
				arg_1_0:Op("WorldObjectInterActionEnd", arg_1_0.id, arg_1_0.view.player.id)

				return
			end
		})

		return
	end)

	arg_1_0.director = GetOrAddComponent(var_1_0, typeof(UnityEngine.Playables.PlayableDirector))
	arg_1_0.cachePlayerTransformInfoDic = {}

	return
end

function var_0_0.SetTimelineDic(arg_4_0, arg_4_1)
	arg_4_0.timelineDic = arg_4_1

	return
end

function var_0_0.GetTargetRoot(arg_5_0)
	return arg_5_0._go.transform
end

function var_0_0.GetPlayerParent(arg_6_0)
	return arg_6_0:GetTargetRoot()
end

function var_0_0.StartInteract(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if arg_7_6 then
		arg_7_0.director:Stop()
	end

	arg_7_1:ActiveOrDisactive(false)

	if arg_7_7 then
		arg_7_0.behaviourTreeOwner.graph.blackboard:SetVariableValue("inProgress", true)

		arg_7_0.ignoreSignal = false
	else
		arg_7_0.ignoreSignal = true
	end

	arg_7_0:SetPlayerTransform(arg_7_1, arg_7_0:GetPlayerParent())

	if arg_7_5 and #arg_7_5 > 1 then
		arg_7_0.behaviourTreeOwner.graph.blackboard:SetVariableValue(arg_7_5[1], arg_7_5[2])
	end

	arg_7_0.director.playableAsset = arg_7_0.timelineDic[arg_7_3]

	local var_7_0 = arg_7_0.director

	if arg_7_4.is_loop == 1 then
		var_7_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop or UnityEngine.Playables.DirectorWrapMode.None

		arg_7_0:BindPlayer(arg_7_2, arg_7_1)
		arg_7_0:BindSelf(arg_7_4)

		arg_7_0.director.enabled = true

		arg_7_0.director:Play()

		return
	end
end

function var_0_0.EndInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 then
		local var_8_0 = arg_8_0.director

		if arg_8_0.director.extrapolationMode == UnityEngine.Playables.DirectorWrapMode.None then
			var_8_0.time = arg_8_0.director.duration or 0

			arg_8_0.director:Evaluate()
			arg_8_0.director:Stop()

			arg_8_0.director.enabled = false

			arg_8_0:BindPlayer(arg_8_2, nil)

			if arg_8_1 then
				arg_8_1:ActiveOrDisactive(true)
			end

			if arg_8_4 then
				arg_8_0.behaviourTreeOwner.graph.blackboard:SetVariableValue("inProgress", false)
				onNextTick(function()
					arg_8_0:RevertPlayerTransform(arg_8_1)

					return
				end)
			else
				arg_8_0:RevertPlayerTransform(arg_8_1)
			end

			return
		end
	end
end

function var_0_0.InitStatus(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 and #arg_10_3 > 1 then
		arg_10_0.behaviourTreeOwner.graph.blackboard:SetVariableValue(arg_10_3[1], arg_10_3[2])
	end

	arg_10_0.director.playableAsset = arg_10_0.timelineDic[arg_10_1]

	arg_10_0:BindSelf(arg_10_2)

	arg_10_0.ignoreSignal = true
	arg_10_0.director.enabled = true

	arg_10_0.director:Play()

	arg_10_0.director.time = arg_10_0.director.duration

	arg_10_0.director:Evaluate()
	arg_10_0.director:Stop()

	return
end

function var_0_0.BindSelf(arg_11_0, arg_11_1)
	local var_11_0 = TimelineHelper.GetGroupTracks(arg_11_0.director):ToTable()

	if #var_11_0 > 0 then
		local var_11_1 = TimelineHelper.GetChildTracks(var_11_0[1]):ToTable()

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_2, var_11_3 = table.Find(arg_11_1.binding_track, function(arg_12_0, arg_12_1)
				return arg_12_1 == iter_11_0
			end)

			if var_11_3 ~= nil then
				if arg_11_1.binding_path[var_11_3] == "" then
					local var_11_4 = arg_11_0:GetTargetRoot() or arg_11_0:GetTargetRoot():Find(arg_11_1.binding_path[var_11_3])

					if var_11_4 then
						TimelineHelper.SetAutoBinding(arg_11_0.director, iter_11_1, go(var_11_4))
					end
				end
			end
		end

		local var_11_5 = arg_11_1.control_binding or {}

		for iter_11_2, iter_11_3 in ipairs(var_11_5) do
			local var_11_6 = iter_11_3[2]
			local var_11_7 = iter_11_3[3] or ""
			local var_11_8 = var_11_1[iter_11_3[1]]

			if var_11_1[iter_11_3[1]] and var_11_6 and var_11_6 > 0 then
				if var_11_7 == "" then
					local var_11_9 = arg_11_0:GetTargetRoot() or arg_11_0:GetTargetRoot():Find(var_11_7)

					if var_11_9 then
						TimelineHelper.SetControlBinding(arg_11_0.director, var_11_8, var_11_6 - 1, go(var_11_9))
					end
				end
			end
		end
	end

	return
end

function var_0_0.BindPlayer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = TimelineHelper.GetGroupTracks(arg_13_0.director):ToTable()
	local var_13_1 = arg_13_2 and go(arg_13_2._go.transform:GetChild(0))
	local var_13_2 = arg_13_2 and arg_13_2._go

	if arg_13_1 < #var_13_0 then
		for iter_13_0, iter_13_1 in ipairs((TimelineHelper.GetChildTracks(var_13_0[arg_13_1 + 1]):ToTable())) do
			if iter_13_0 == 1 then
				TimelineHelper.SetAutoBinding(arg_13_0.director, iter_13_1, var_13_2)
			else
				TimelineHelper.SetAutoBinding(arg_13_0.director, iter_13_1, var_13_1)
			end
		end
	end

	return
end

function var_0_0.SetPlayerTransform(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.cachePlayerTransformInfoDic[arg_14_1.id] = {
		position = arg_14_1._tf.position,
		rotation = arg_14_1._tf.rotation
	}

	setParent(arg_14_1._tf, arg_14_2)

	arg_14_1._tf.localPosition = Vector3.zero
	arg_14_1._tf.localRotation = Quaternion.identity
	GetOrAddComponent(arg_14_1._go, typeof(UnityEngine.Animator)).enabled = true

	return
end

function var_0_0.RevertPlayerTransform(arg_15_0, arg_15_1)
	if not arg_15_1 or not arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id] then
		return
	end

	setParent(arg_15_1._tf, arg_15_0.view.root)

	arg_15_1._tf.position = arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id].position
	arg_15_1._tf.rotation = arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id].rotation
	GetOrAddComponent(arg_15_1._go, typeof(UnityEngine.Animator)).enabled = false
	arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id] = nil

	return
end

return var_0_0
