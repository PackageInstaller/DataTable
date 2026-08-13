class = var_0_10000

local var_0_0 = "IslandInteractUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSceneUnit"))

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 or arg_1_0._go

	GetOrAddComponent = var_1_10003
	arg_1_0.signalReceiver = var_1_10003(var_1_0, "DftCommonSignalReceiver")

	local var_1_1 = arg_1_0.signalReceiver

	var_3.SetCommonEvent(var_1_1, function(arg_2_0)
		if arg_1_0.ignoreSignal then
			return
		end

		switch = var_1

		var_1(arg_2_0.stringParameter, {
			TimelineEnd = function()
				local var_3_0 = arg_1_0

				var_0.Op(var_3_0, "WorldObjectInterActionEnd", arg_1_0.id, arg_1_0.view.player.id)

				return
			end
		})

		return
	end)

	GetOrAddComponent = var_3

	local var_1_2 = var_1_0

	typeof = var_5
	UnityEngine = var_1_10006
	arg_1_0.director = var_3(var_1_2, var_5(var_1_10006.Playables.PlayableDirector))
	arg_1_0.cachePlayerTransformInfoDic = {}

	return
end

function var_0_1.SetTimelineDic(arg_4_0, arg_4_1)
	arg_4_0.timelineDic = arg_4_1

	return
end

function var_0_1.GetTargetRoot(arg_5_0)
	return arg_5_0._go.transform
end

function var_0_1.GetPlayerParent(arg_6_0)
	return arg_6_0:GetTargetRoot()
end

function var_0_1.StartInteract(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if arg_7_6 then
		local var_7_0 = arg_7_0.director

		var_8.Stop(var_7_0)
	end

	arg_7_1:ActiveOrDisactive(false)

	if arg_7_7 then
		local var_7_1 = arg_7_0.behaviourTreeOwner.graph.blackboard

		var_8.SetVariableValue(var_7_1, "inProgress", true)

		arg_7_0.ignoreSignal = false
	else
		arg_7_0.ignoreSignal = true
	end

	arg_7_0:SetPlayerTransform(arg_7_1, arg_7_0:GetPlayerParent())

	if arg_7_5 and #arg_7_5 > 1 then
		local var_7_2 = arg_7_0.behaviourTreeOwner.graph.blackboard

		var_8.SetVariableValue(var_7_2, arg_7_5[1], arg_7_5[2])
	end

	arg_7_0.director.playableAsset = arg_7_0.timelineDic[arg_7_3]

	local var_7_3 = arg_7_0.director

	if arg_7_4.is_loop == 1 then
		UnityEngine = var_7_4

		local var_7_4

		if not var_7_4.Playables.DirectorWrapMode.Loop then
			UnityEngine = var_7_4
			var_7_4 = var_7_4.Playables.DirectorWrapMode.None
		end

		var_7_3.extrapolationMode = var_7_4

		arg_7_0:BindPlayer(arg_7_2, arg_7_1)
		arg_7_0:BindSelf(arg_7_4)

		arg_7_0.director.enabled = true

		local var_7_5 = arg_7_0.director

		var_8.Play(var_7_5)

		return
	end
end

function var_0_1.EndInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 then
		local var_8_0 = arg_8_0.director
		local var_8_1 = arg_8_0.director.extrapolationMode

		UnityEngine = var_1_10007

		local var_8_2

		if var_8_1 ~= var_1_10007.Playables.DirectorWrapMode.None or not arg_8_0.director.duration then
			var_8_2 = 0
		end

		var_8_0.time = var_8_2

		local var_8_3 = arg_8_0.director

		var_5.Evaluate(var_8_3)

		local var_8_4 = arg_8_0.director

		var_5.Stop(var_8_4)

		arg_8_0.director.enabled = false
	end

	arg_8_0:BindPlayer(arg_8_2, nil)

	if arg_8_1 then
		arg_8_1:ActiveOrDisactive(true)
	end

	if arg_8_4 then
		local var_8_5 = arg_8_0.behaviourTreeOwner.graph.blackboard

		var_5.SetVariableValue(var_8_5, "inProgress", false)

		onNextTick = var_5

		var_5(function()
			local var_9_0 = arg_8_0

			var_0.RevertPlayerTransform(var_9_0, arg_8_1)

			return
		end)
	else
		arg_8_0:RevertPlayerTransform(arg_8_1)
	end

	return
end

function var_0_1.InitStatus(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 and #arg_10_3 > 1 then
		local var_10_0 = arg_10_0.behaviourTreeOwner.graph.blackboard

		var_4.SetVariableValue(var_10_0, arg_10_3[1], arg_10_3[2])
	end

	arg_10_0.director.playableAsset = arg_10_0.timelineDic[arg_10_1]

	arg_10_0:BindSelf(arg_10_2)

	arg_10_0.ignoreSignal = true
	arg_10_0.director.enabled = true

	local var_10_1 = arg_10_0.director

	var_4.Play(var_10_1)

	arg_10_0.director.time = arg_10_0.director.duration

	local var_10_2 = arg_10_0.director

	var_4.Evaluate(var_10_2)

	local var_10_3 = arg_10_0.director

	var_4.Stop(var_10_3)

	return
end

function var_0_1.BindSelf(arg_11_0, arg_11_1)
	TimelineHelper = var_1_10002

	local var_11_0 = var_1_10002.GetGroupTracks(arg_11_0.director)

	if #var_2.ToTable(var_11_0) > 0 then
		TimelineHelper = var_3

		local var_11_1 = var_3.GetChildTracks(var_2[1])
		local var_11_2 = var_3.ToTable(var_11_1)

		ipairs = var_11_1

		for iter_11_0, iter_11_1 in var_11_1(var_11_2) do
			table = var_1_10009

			local var_11_3

			var_1_10009, var_11_3 = var_1_10009.Find(arg_11_1.binding_track, function(arg_12_0, arg_12_1)
				return arg_12_1 == iter_11_0
			end)

			if var_11_3 ~= nil then
				if arg_11_1.binding_path[var_11_3] == "" then
					var_1_10013 = arg_11_0

					local var_11_4

					if not arg_11_0.GetTargetRoot(var_1_10013) then
						var_1_10013 = arg_11_0
						var_1_10013 = arg_11_0.GetTargetRoot(var_1_10013)
						var_11_4 = var_12.Find(var_1_10013, var_11)
					end

					if var_11_4 then
						TimelineHelper = var_1_10013
						var_1_10013 = var_1_10013.SetAutoBinding
						var_1_10014 = arg_11_0.director

						local var_11_5 = iter_11_1

						go = var_1_10016

						var_1_10013(var_1_10014, var_11_5, var_1_10016(var_11_4))
					end
				end
			end
		end

		ipairs = var_4

		local var_11_6

		if not arg_11_1.control_binding then
			var_11_6 = {}
		end

		for iter_11_2, iter_11_3 in var_4(var_11_6) do
			local var_11_7 = iter_11_3[1]
			local var_11_8 = iter_11_3[2]
			local var_11_9

			if not iter_11_3[3] then
				var_11_9 = ""
			end

			if var_11_2[var_11_7] and var_11_8 and var_11_8 > 0 then
				if var_11_9 == "" then
					var_1_10014 = arg_11_0

					local var_11_10

					if not arg_11_0.GetTargetRoot(var_1_10014) then
						var_1_10014 = arg_11_0
						var_1_10014 = arg_11_0.GetTargetRoot(var_1_10014)
						var_11_10 = var_13.Find(var_1_10014, var_11_9)
					end

					if var_11_10 then
						TimelineHelper = var_1_10014
						var_1_10014 = var_1_10014.SetControlBinding

						local var_11_11 = arg_11_0.director
						local var_11_12 = var_12
						local var_11_13 = var_11_8 - 1

						go = var_1_10018

						var_1_10014(var_11_11, var_11_12, var_11_13, var_1_10018(var_11_10))
					end
				end
			end
		end
	end

	return
end

function var_0_1.BindPlayer(arg_13_0, arg_13_1, arg_13_2)
	TimelineHelper = var_1_10003

	local var_13_0 = var_1_10003.GetGroupTracks(arg_13_0.director)
	local var_13_1 = var_3.ToTable(var_13_0)

	if arg_13_2 then
		::label_13_0::

		go = var_13_0

		local var_13_2 = arg_13_2._go.transform

		var_13_0 = var_13_0(var_5.GetChild(var_13_2, 0))
	end

	local var_13_3 = arg_13_2 and arg_13_2._go

	if arg_13_1 < #var_13_1 then
		TimelineHelper = var_6

		local var_13_4 = var_6.GetChildTracks(var_13_1[arg_13_1 + 1])
		local var_13_5 = var_6.ToTable(var_13_4)

		ipairs = var_13_4

		for iter_13_0, iter_13_1 in var_13_4(var_13_5) do
			if iter_13_0 == 1 then
				TimelineHelper = var_1_10012

				var_1_10012.SetAutoBinding(arg_13_0.director, iter_13_1, var_13_3)
			else
				TimelineHelper = var_1_10012

				var_1_10012.SetAutoBinding(arg_13_0.director, iter_13_1, var_13_0)
			end
		end
	end

	return
end

function var_0_1.SetPlayerTransform(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.cachePlayerTransformInfoDic

	var_14_0[arg_14_1.id] = {
		position = arg_14_1._tf.position,
		rotation = arg_14_1._tf.rotation
	}
	setParent = var_14_0

	var_14_0(arg_14_1._tf, arg_14_2)

	local var_14_1 = arg_14_1._tf

	Vector3 = var_4
	var_14_1.localPosition = var_4.zero

	local var_14_2 = arg_14_1._tf

	Quaternion = var_4
	var_14_2.localRotation = var_4.identity
	GetOrAddComponent = var_14_2

	local var_14_3 = arg_14_1._go

	typeof = var_5
	UnityEngine = var_6
	var_14_2(var_14_3, var_5(var_6.Animator)).enabled = true

	return
end

function var_0_1.RevertPlayerTransform(arg_15_0, arg_15_1)
	if not arg_15_1 or not arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id] then
		return
	end

	setParent = var_1_10002

	var_1_10002(arg_15_1._tf, arg_15_0.view.root)

	arg_15_1._tf.position = arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id].position

	local var_15_0 = arg_15_1._tf

	var_15_0.rotation = arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id].rotation
	GetOrAddComponent = var_15_0

	local var_15_1 = arg_15_1._go

	typeof = var_4
	UnityEngine = var_1_10005
	var_15_0(var_15_1, var_4(var_1_10005.Animator)).enabled = false
	arg_15_0.cachePlayerTransformInfoDic[arg_15_1.id] = nil

	return
end

return var_0_1
