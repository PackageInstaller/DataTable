local var_0_0 = class("WSMapObject", import("...BaseEntity"))

var_0_0.Fields = {
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

function var_0_0.GetModelAngles(arg_1_0)
	return arg_1_0.modelAngles and arg_1_0.modelAngles:Clone() or Vector3.zero
end

function var_0_0.UpdateModelAngles(arg_2_0, arg_2_1)
	if arg_2_0.modelAngles ~= arg_2_1 then
		arg_2_0.modelAngles = arg_2_1

		arg_2_0:FlushModelAngles()
	end

	return
end

function var_0_0.FlushModelAngles(arg_3_0)
	if arg_3_0.model and arg_3_0.modelAngles then
		arg_3_0.model.localEulerAngles = arg_3_0.modelAngles
	end

	return
end

function var_0_0.GetModelScale(arg_4_0)
	return arg_4_0.modelScale and arg_4_0.modelScale:Clone() or Vector3.one
end

function var_0_0.UpdateModelScale(arg_5_0, arg_5_1)
	if arg_5_0.modelScale ~= arg_5_1 then
		arg_5_0.modelScale = arg_5_1

		arg_5_0:FlushModelScale()
	end

	return
end

function var_0_0.GetModelAction(arg_6_0)
	return arg_6_0.modelAction
end

function var_0_0.FlushModelScale(arg_7_0)
	if arg_7_0.model and arg_7_0.modelScale then
		arg_7_0.model.localScale = arg_7_0.modelScale
	end

	return
end

function var_0_0.UpdateModelAction(arg_8_0, arg_8_1)
	if arg_8_0.modelAction ~= arg_8_1 then
		arg_8_0.modelAction = arg_8_1

		arg_8_0:FlushModelAction()
	end

	return
end

function var_0_0.FlushModelAction(arg_9_0)
	if arg_9_0.model and arg_9_0.modelAction then
		if arg_9_0.modelType == WorldConst.ModelSpine then
			local var_9_0 = arg_9_0.modelComps and arg_9_0.modelComps[1]

			if var_9_0 then
				var_9_0:SetAction(arg_9_0.modelAction, 0)
			end
		elseif arg_9_0.modelType == WorldConst.ModelPrefab then
			local var_9_1 = arg_9_0.modelComps and arg_9_0.modelComps[1]

			if var_9_1 then
				local var_9_2 = Animator.StringToHash(arg_9_0.modelAction)

				if var_9_1:HasState(0, var_9_2) then
					var_9_1:Play(var_9_2)
				end
			end
		end
	end

	return
end

function var_0_0.PlayModelAction(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	assert(arg_10_1)

	if arg_10_0.model then
		if arg_10_0.modelType == WorldConst.ModelSpine then
			local var_10_0 = arg_10_0.modelComps[1]

			if arg_10_0.modelComps[1] and isa(arg_10_0.modelComps[1], SpineAnimChar) and arg_10_0.modelComps[1]:GetModel().transform.gameObject.activeInHierarchy then
				table.insert({}, function(arg_11_0)
					var_10_0:SetAction(arg_10_1, 0)

					if arg_10_2 then
						arg_10_0:NewActionTimer(arg_10_2, arg_11_0)
					else
						var_10_0:SetActionCallBack(function(arg_12_0)
							if arg_12_0 == "finish" then
								var_10_0:SetActionCallBack(nil)
								arg_11_0()
							end

							return
						end)
					end

					return
				end)
			elseif arg_10_0.modelComps[1] and isa(arg_10_0.modelComps[1], SpineRole) and arg_10_0.modelComps[1]:GetRootModel().transform.gameObject.activeInHierarchy then
				table.insert({}, function(arg_13_0)
					var_10_0:SetAction(arg_10_1, 0)

					if arg_10_2 then
						arg_10_0:NewActionTimer(arg_10_2, arg_13_0)
					else
						var_10_0:SetActionCallBack(function(arg_14_0)
							if arg_14_0 == "finish" then
								var_10_0:SetActionCallBack(nil)
								arg_13_0()
							end

							return
						end)
					end

					return
				end)
			elseif arg_10_0.modelComps[1] and arg_10_0.modelComps[1].transform.gameObject.activeInHierarchy then
				table.insert({}, function(arg_15_0)
					var_10_0:SetAction(arg_10_1, 0)

					if arg_10_2 then
						arg_10_0:NewActionTimer(arg_10_2, arg_15_0)
					else
						var_10_0:SetActionCallBack(function(arg_16_0)
							if arg_16_0 == "finish" then
								var_10_0:SetActionCallBack(nil)
								arg_15_0()
							end

							return
						end)
					end

					return
				end)
			end
		elseif arg_10_0.modelType == WorldConst.ModelPrefab then
			local var_10_1 = arg_10_0.modelComps

			if arg_10_0.modelComps then
				var_10_1 = arg_10_0.modelComps[1]
			end

			if var_10_1 and var_10_1.transform.gameObject.activeInHierarchy then
				if var_10_1:HasState(0, (Animator.StringToHash(arg_10_1))) then
					table.insert({}, function(arg_17_0)
						var_10_1:Play(var_0)

						if arg_10_2 then
							arg_10_0:NewActionTimer(arg_10_2, arg_17_0)
						else
							arg_10_0.modelComps[2]:SetEndEvent(function()
								var_0:SetEndEvent(nil)
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

	seriesAsync({}, arg_10_3)

	return
end

function var_0_0.LoadModel(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if arg_19_0.modelType ~= arg_19_1 or arg_19_0.modelResPath ~= arg_19_2 or arg_19_0.modelResName ~= arg_19_3 then
		arg_19_0:UnloadModel()

		arg_19_0.model = createNewGameObject("model")
		arg_19_0.modelType = arg_19_1
		arg_19_0.modelResPath = arg_19_2
		arg_19_0.modelResName = arg_19_3
		arg_19_0.modelResAsync = defaultValue(arg_19_4, true)

		local var_19_0 = {}

		if arg_19_0.modelType == WorldConst.ModelSpine then
			arg_19_0.modelAction = arg_19_0.modelAction or WorldConst.ActionIdle

			table.insert(var_19_0, function(arg_20_0)
				arg_19_0:LoadSpine(arg_20_0)

				return
			end)
		elseif arg_19_0.modelType == WorldConst.ModelPrefab then
			arg_19_0.modelAction = arg_19_0.modelAction or "idle"

			table.insert(var_19_0, function(arg_21_0)
				arg_19_0:LoadPrefab(arg_21_0)

				return
			end)
		else
			assert("invalid model type: " .. arg_19_1)
		end

		seriesAsync(var_19_0, function()
			if arg_19_0.modelScale == nil then
				arg_19_0.modelScale = arg_19_0.model.localScale
			else
				arg_19_0:FlushModelScale()
			end

			if arg_19_0.modelAngles == nil then
				arg_19_0.modelAngles = arg_19_0.model.localEulerAngles
			else
				arg_19_0:FlushModelAngles()
			end

			arg_19_0:FlushModelAction()

			if arg_19_5 then
				arg_19_5()
			end

			return
		end)
	end

	return
end

function var_0_0.UnloadModel(arg_23_0)
	arg_23_0:DisposeActionTimer()

	if arg_23_0.model then
		if arg_23_0.model.childCount > 0 then
			if arg_23_0.modelType == WorldConst.ModelSpine then
				arg_23_0:UnloadSpine()
			elseif arg_23_0.modelType == WorldConst.ModelPrefab then
				arg_23_0:UnloadPrefab()
			end
		end

		Destroy(arg_23_0.model)
	end

	arg_23_0.model = nil
	arg_23_0.modelComps = nil
	arg_23_0.modelType = nil
	arg_23_0.modelResPath = nil
	arg_23_0.modelResName = nil
	arg_23_0.modelResAsync = nil

	return
end

function var_0_0.LoadSpine(arg_24_0, arg_24_1)
	local var_24_0 = SpineAnimChar.New()

	var_24_0:SetPaint(arg_24_0.modelResPath)
	var_24_0:Load(arg_24_0.modelResAsync, function(arg_25_0)
		if arg_24_0.modelType ~= WorldConst.ModelSpine or arg_24_0.modelResPath ~= var_0 then
			arg_25_0:Dispose()

			var_24_0 = nil

			return
		end

		arg_25_0:GetSkeletonGraphic().raycastTarget = false

		arg_25_0:SetAnchoredPosition3D(Vector3.zero)
		arg_25_0:SetLocalScale(Vector3.one)
		arg_25_0:SetLayer(Layer.UI)
		arg_25_0:SetParent(arg_24_0.model)

		arg_24_0.modelComps = {
			arg_25_0
		}

		arg_24_1()

		return
	end)

	return
end

function var_0_0.LoadPrefab(arg_26_0, arg_26_1)
	PoolMgr.GetInstance():GetPrefab(arg_26_0.modelResPath, arg_26_0.modelResName, arg_26_0.modelResAsync, function(arg_27_0)
		if arg_26_0.modelType ~= WorldConst.ModelPrefab or arg_26_0.modelResPath ~= var_0 or arg_26_0.modelResName ~= var_0 then
			PoolMgr.GetInstance():ReturnPrefab(var_0, var_0, arg_27_0, true)

			return
		end

		local var_27_0 = arg_27_0:GetComponentsInChildren(typeof(Image))

		for iter_27_0, iter_27_1 in ipairs((var_27_0:ToTable())) do
			iter_27_1.raycastTarget = false
		end

		arg_27_0.transform:SetParent(arg_26_0.model, false)

		arg_26_0.modelComps = {}

		local var_27_1 = arg_27_0:GetComponentInChildren(typeof(Animator))

		if var_27_1 then
			arg_26_0.modelComps = {
				var_27_1,
				(var_27_1:GetComponent("DftAniEvent"))
			}
		end

		arg_26_1()

		return
	end)

	return
end

function var_0_0.UnloadSpine(arg_28_0)
	if arg_28_0.modelComps[1] and isa(arg_28_0.modelComps[1], SpineAnimChar) then
		arg_28_0.modelComps[1]:SetActionCallBack(nil)
		arg_28_0.modelComps[1]:Dispose()
	end

	return
end

function var_0_0.UnloadPrefab(arg_29_0)
	if arg_29_0.modelComps[2] then
		arg_29_0.modelComps[2]:SetEndEvent(nil)
	end

	PoolMgr.GetInstance():ReturnPrefab(arg_29_0.modelResPath, arg_29_0.modelResName, arg_29_0.model:GetChild(0).gameObject, true)

	return
end

function var_0_0.NewActionTimer(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:DisposeActionTimer()

	arg_30_0.modelActionTimer = Timer.New(arg_30_2, arg_30_1, 1)

	arg_30_0.modelActionTimer:Start()

	return
end

function var_0_0.DisposeActionTimer(arg_31_0)
	if arg_31_0.modelActionTimer then
		arg_31_0.modelActionTimer:Stop()

		arg_31_0.modelActionTimer = nil
	end

	return
end

return var_0_0
