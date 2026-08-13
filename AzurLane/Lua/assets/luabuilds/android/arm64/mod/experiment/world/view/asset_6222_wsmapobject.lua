class = var_0_10000

local var_0_0 = "WSMapObject"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	modelType = "number",
	modelAction = "string",
	modelResPath = "string",
	modelParent = "userdata",
	modelActionTimer = "table",
	modelAngles = "table",
	modelScale = "table",
	model = "userdata",
	modelComps = "table",
	modelResAsync = "boolean",
	modelResName = "string"
}

function var_0_1.GetModelAngles(arg_1_0)
	if arg_1_0.modelAngles then
		local var_1_0 = arg_1_0.modelAngles
		local var_1_1

		if not var_1_1.Clone(var_1_0) then
			Vector3 = var_1_1
			var_1_1 = var_1_1.zero
		end

		return var_1_1
	end
end

function var_0_1.UpdateModelAngles(arg_2_0, arg_2_1)
	if arg_2_0.modelAngles ~= arg_2_1 then
		arg_2_0.modelAngles = arg_2_1

		arg_2_0:FlushModelAngles()
	end

	return
end

function var_0_1.FlushModelAngles(arg_3_0)
	if arg_3_0.model and arg_3_0.modelAngles then
		arg_3_0.model.localEulerAngles = arg_3_0.modelAngles
	end

	return
end

function var_0_1.GetModelScale(arg_4_0)
	if arg_4_0.modelScale then
		local var_4_0 = arg_4_0.modelScale
		local var_4_1

		if not var_4_1.Clone(var_4_0) then
			Vector3 = var_4_1
			var_4_1 = var_4_1.one
		end

		return var_4_1
	end
end

function var_0_1.UpdateModelScale(arg_5_0, arg_5_1)
	if arg_5_0.modelScale ~= arg_5_1 then
		arg_5_0.modelScale = arg_5_1

		arg_5_0:FlushModelScale()
	end

	return
end

function var_0_1.GetModelAction(arg_6_0)
	return arg_6_0.modelAction
end

function var_0_1.FlushModelScale(arg_7_0)
	if arg_7_0.model and arg_7_0.modelScale then
		arg_7_0.model.localScale = arg_7_0.modelScale
	end

	return
end

function var_0_1.UpdateModelAction(arg_8_0, arg_8_1)
	if arg_8_0.modelAction ~= arg_8_1 then
		arg_8_0.modelAction = arg_8_1

		arg_8_0:FlushModelAction()
	end

	return
end

function var_0_1.FlushModelAction(arg_9_0)
	if arg_9_0.model and arg_9_0.modelAction then
		local var_9_0 = arg_9_0.modelType

		WorldConst = var_1_10002

		if var_9_0 == var_1_10002.ModelSpine then
			local var_9_1

			if arg_9_0.modelComps then
				var_9_1 = arg_9_0.modelComps[1]
			end

			if var_9_1 then
				var_9_1:SetAction(arg_9_0.modelAction, 0)
			end
		else
			local var_9_2 = arg_9_0.modelType

			WorldConst = var_2

			if var_9_2 == var_2.ModelPrefab then
				local var_9_3

				if arg_9_0.modelComps then
					var_9_3 = arg_9_0.modelComps[1]
				end

				if var_9_3 then
					Animator = var_2

					local var_9_4 = var_2.StringToHash(arg_9_0.modelAction)

					if var_9_3:HasState(0, var_9_4) then
						var_9_3:Play(var_9_4)
					end
				end
			end
		end
	end

	return
end

function var_0_1.PlayModelAction(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	assert = var_1_10004

	var_1_10004(arg_10_1)

	local var_10_0 = {}
	local var_10_1

	if arg_10_0.model then
		var_10_1 = arg_10_0.modelType
		WorldConst = var_6

		if var_10_1 == var_6.ModelSpine then
			if arg_10_0.modelComps[1] then
				isa = var_6

				local var_10_2 = var_10_1

				SpineAnimChar = var_1_10009

				if var_6(var_10_2, var_1_10009) and var_10_1:GetModel().transform.gameObject.activeInHierarchy then
					table = var_6

					var_6.insert(var_10_0, function(arg_11_0)
						local var_11_0 = var_10_1

						var_1.SetAction(var_11_0, arg_10_1, 0)

						if arg_10_2 then
							local var_11_1 = arg_10_0

							var_1.NewActionTimer(var_11_1, arg_10_2, arg_11_0)
						else
							local var_11_2 = var_10_1

							var_1.SetActionCallBack(var_11_2, function(arg_12_0)
								if arg_12_0 == "finish" then
									local var_12_0 = var_10_1

									var_1.SetActionCallBack(var_12_0, nil)
									arg_11_0()
								end

								return
							end)
						end

						return
					end)

					goto label_10_0
				end
			end

			if var_10_1 then
				isa = var_6

				local var_10_3 = var_10_1

				SpineRole = var_1_10009

				if var_6(var_10_3, var_1_10009) and var_10_1:GetRootModel().transform.gameObject.activeInHierarchy then
					table = var_6

					var_6.insert(var_10_0, function(arg_13_0)
						local var_13_0 = var_10_1

						var_1.SetAction(var_13_0, arg_10_1, 0)

						if arg_10_2 then
							local var_13_1 = arg_10_0

							var_1.NewActionTimer(var_13_1, arg_10_2, arg_13_0)
						else
							local var_13_2 = var_10_1

							var_1.SetActionCallBack(var_13_2, function(arg_14_0)
								if arg_14_0 == "finish" then
									local var_14_0 = var_10_1

									var_1.SetActionCallBack(var_14_0, nil)
									arg_13_0()
								end

								return
							end)
						end

						return
					end)

					goto label_10_0
				end
			end

			if var_10_1 and var_10_1.transform.gameObject.activeInHierarchy then
				table = var_6

				var_6.insert(var_10_0, function(arg_15_0)
					local var_15_0 = var_10_1

					var_1.SetAction(var_15_0, arg_10_1, 0)

					if arg_10_2 then
						local var_15_1 = arg_10_0

						var_1.NewActionTimer(var_15_1, arg_10_2, arg_15_0)
					else
						local var_15_2 = var_10_1

						var_1.SetActionCallBack(var_15_2, function(arg_16_0)
							if arg_16_0 == "finish" then
								local var_16_0 = var_10_1

								var_1.SetActionCallBack(var_16_0, nil)
								arg_15_0()
							end

							return
						end)
					end

					return
				end)
			end

			::label_10_0::
		else
			var_10_1 = arg_10_0.modelType
			WorldConst = var_6

			if var_10_1 == var_6.ModelPrefab then
				if arg_10_0.modelComps then
					var_10_1 = arg_10_0.modelComps[1]
				end

				if var_10_1 and var_10_1.transform.gameObject.activeInHierarchy then
					Animator = var_6

					local var_10_4 = var_6.StringToHash(arg_10_1)

					if var_10_1:HasState(0, var_10_4) then
						table = var_7

						var_7.insert(var_10_0, function(arg_17_0)
							local var_17_0 = var_10_1

							var_1.Play(var_17_0, var_10_4)

							if arg_10_2 then
								local var_17_1 = arg_10_0

								var_1.NewActionTimer(var_17_1, arg_10_2, arg_17_0)
							else
								local var_17_2 = arg_10_0.modelComps[2]

								var_1.SetEndEvent(var_17_2, function()
									local var_18_0 = var_0

									var_0.SetEndEvent(var_18_0, nil)
									arg_17_0()

									return
								end)
							end

							return
						end)
					end
				end
			end
		end
	end

	seriesAsync = var_10_1

	var_10_1(var_10_0, arg_10_3)

	return
end

function var_0_1.LoadModel(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if arg_19_0.modelType ~= arg_19_1 or arg_19_0.modelResPath ~= arg_19_2 or arg_19_0.modelResName ~= arg_19_3 then
		arg_19_0:UnloadModel()

		createNewGameObject = var_6
		arg_19_0.model = var_6("model")
		arg_19_0.modelType = arg_19_1
		arg_19_0.modelResPath = arg_19_2
		arg_19_0.modelResName = arg_19_3
		defaultValue = var_6
		arg_19_0.modelResAsync = var_6(arg_19_4, true)

		local var_19_0 = {}
		local var_19_1 = arg_19_0.modelType

		WorldConst = var_8

		if var_19_1 == var_8.ModelSpine then
			if not arg_19_0.modelAction then
				WorldConst = var_19_1
				var_19_1 = var_19_1.ActionIdle
			end

			arg_19_0.modelAction = var_19_1
			table = var_19_1

			var_19_1.insert(var_19_0, function(arg_20_0)
				local var_20_0 = arg_19_0

				var_1.LoadSpine(var_20_0, arg_20_0)

				return
			end)
		else
			var_19_1 = arg_19_0.modelType
			WorldConst = var_8

			if var_19_1 == var_8.ModelPrefab then
				if not arg_19_0.modelAction then
					var_19_1 = "idle"
				end

				arg_19_0.modelAction = var_19_1
				table = var_19_1

				var_19_1.insert(var_19_0, function(arg_21_0)
					local var_21_0 = arg_19_0

					var_1.LoadPrefab(var_21_0, arg_21_0)

					return
				end)
			else
				assert = var_19_1

				var_19_1("invalid model type: " .. arg_19_1)
			end
		end

		seriesAsync = var_19_1

		var_19_1(var_19_0, function()
			if arg_19_0.modelScale == nil then
				arg_19_0.modelScale = arg_19_0.model.localScale
			else
				local var_22_0 = arg_19_0

				var_0.FlushModelScale(var_22_0)
			end

			if arg_19_0.modelAngles == nil then
				arg_19_0.modelAngles = arg_19_0.model.localEulerAngles
			else
				local var_22_1 = arg_19_0

				var_0.FlushModelAngles(var_22_1)
			end

			local var_22_2 = arg_19_0

			var_0.FlushModelAction(var_22_2)

			if arg_19_5 then
				arg_19_5()
			end

			return
		end)
	end

	return
end

function var_0_1.UnloadModel(arg_23_0)
	arg_23_0:DisposeActionTimer()

	if arg_23_0.model then
		local var_23_0 = arg_23_0.model.childCount

		if 0 < var_23_0 then
			var_23_0 = arg_23_0.modelType
			WorldConst = var_2

			if var_23_0 == var_2.ModelSpine then
				arg_23_0:UnloadSpine()
			else
				var_23_0 = arg_23_0.modelType
				WorldConst = var_2

				if var_23_0 == var_2.ModelPrefab then
					arg_23_0:UnloadPrefab()
				end
			end
		end

		Destroy = var_23_0

		var_23_0(arg_23_0.model)
	end

	arg_23_0.model = nil
	arg_23_0.modelComps = nil
	arg_23_0.modelType = nil
	arg_23_0.modelResPath = nil
	arg_23_0.modelResName = nil
	arg_23_0.modelResAsync = nil

	return
end

function var_0_1.LoadSpine(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.modelResPath
	local var_24_1 = arg_24_0.modelResAsync

	SpineAnimChar = var_1_10004

	local var_24_2 = var_1_10004.New()

	var_4.SetPaint(var_24_2, var_24_0)
	var_4:Load(var_24_1, function(arg_25_0)
		local var_25_0 = arg_24_0.modelType

		WorldConst = var_2_10002

		if var_25_0 ~= var_2_10002.ModelSpine or arg_24_0.modelResPath ~= var_24_0 then
			arg_25_0:Dispose()

			var_0 = nil

			return
		end

		arg_25_0:GetSkeletonGraphic().raycastTarget = false

		local var_25_1 = arg_25_0
		local var_25_2 = arg_25_0.SetAnchoredPosition3D

		Vector3 = var_2_10004

		var_25_2(var_25_1, var_2_10004.zero)

		local var_25_3 = arg_25_0
		local var_25_4 = arg_25_0.SetLocalScale

		Vector3 = var_4

		var_25_4(var_25_3, var_4.one)

		local var_25_5 = arg_25_0
		local var_25_6 = arg_25_0.SetLayer

		Layer = var_4

		var_25_6(var_25_5, var_4.UI)
		arg_25_0:SetParent(arg_24_0.model)

		arg_24_0.modelComps = {
			arg_25_0
		}

		arg_24_1()

		return
	end)

	return
end

function var_0_1.LoadPrefab(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.modelResPath
	local var_26_1 = arg_26_0.modelResName
	local var_26_2 = arg_26_0.modelResAsync

	PoolMgr = var_1_10005

	local var_26_3 = var_1_10005.GetInstance()

	var_5.GetPrefab(var_26_3, var_26_0, var_26_1, var_26_2, function(arg_27_0)
		local var_27_0 = arg_26_0.modelType

		WorldConst = var_2_10002

		if var_27_0 ~= var_2_10002.ModelPrefab or arg_26_0.modelResPath ~= var_26_0 or arg_26_0.modelResName ~= var_26_1 then
			PoolMgr = var_27_0

			local var_27_1 = var_27_0.GetInstance()

			var_1.ReturnPrefab(var_27_1, var_26_0, var_26_1, arg_27_0, true)

			return
		end

		local var_27_2 = arg_27_0
		local var_27_3 = arg_27_0.GetComponentsInChildren

		typeof = var_2_10004
		Image = var_2_10006

		local var_27_4 = var_27_3(var_27_2, var_2_10004(var_2_10006))
		local var_27_5 = var_1.ToTable(var_27_4)

		ipairs = var_2

		for iter_27_0, iter_27_1 in var_2(var_27_5) do
			iter_27_1.raycastTarget = false
		end

		local var_27_6 = arg_27_0.transform

		var_2.SetParent(var_27_6, arg_26_0.model, false)

		arg_26_0.modelComps = {}

		local var_27_7 = arg_27_0
		local var_27_8 = arg_27_0.GetComponentInChildren

		typeof = var_5
		Animator = var_2_10007

		if var_27_8(var_27_7, var_5(var_2_10007)) then
			local var_27_9 = var_2:GetComponent("DftAniEvent")

			arg_26_0.modelComps = {
				var_2,
				var_27_9
			}
		end

		arg_26_1()

		return
	end)

	return
end

function var_0_1.UnloadSpine(arg_28_0)
	if arg_28_0.modelComps[1] then
		isa = var_1_10002

		local var_28_0 = var_1

		SpineAnimChar = var_1_10005

		if var_1_10002(var_28_0, var_1_10005) then
			var_1:SetActionCallBack(nil)
			var_1:Dispose()
		end
	end

	return
end

function var_0_1.UnloadPrefab(arg_29_0)
	if arg_29_0.modelComps[2] then
		var_1:SetEndEvent(nil)
	end

	PoolMgr = var_1_10002

	local var_29_0 = var_1_10002.GetInstance()
	local var_29_1 = var_2.ReturnPrefab
	local var_29_2 = arg_29_0.modelResPath
	local var_29_3 = arg_29_0.modelResName
	local var_29_4 = arg_29_0.model

	var_29_1(var_29_0, var_29_2, var_29_3, var_7.GetChild(var_29_4, 0).gameObject, true)

	return
end

function var_0_1.NewActionTimer(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:DisposeActionTimer()

	Timer = var_3
	arg_30_0.modelActionTimer = var_3.New(arg_30_2, arg_30_1, 1)

	local var_30_0 = arg_30_0.modelActionTimer

	var_3.Start(var_30_0)

	return
end

function var_0_1.DisposeActionTimer(arg_31_0)
	if arg_31_0.modelActionTimer then
		local var_31_0 = arg_31_0.modelActionTimer

		var_1.Stop(var_31_0)

		arg_31_0.modelActionTimer = nil
	end

	return
end

return var_0_1
