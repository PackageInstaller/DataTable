local var_0_0 = class("EffectMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	print("Initialize Effect Mgr")

	arg_2_0._callback = {}
	arg_2_0._effectMap = {}
	arg_2_0._material = nil
end

function var_0_0.LoadEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = "effect/" .. arg_3_1

	if arg_3_0._effectMap[var_3_0] then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	if arg_3_0._callback[var_3_0] then
		table.insert(arg_3_0._callback[var_3_0], {
			callback = arg_3_3
		})
	elseif arg_3_2 == true then
		arg_3_0._callback[var_3_0] = {
			{
				callback = arg_3_3
			}
		}
		arg_3_0._effectMap[var_3_0] = Object.Instantiate(Asset.Load("Effect/" .. arg_3_1))

		SetActive(arg_3_0._effectMap[var_3_0], false)

		for iter_3_0, iter_3_1 in pairs(arg_3_0._callback[var_3_0]) do
			if iter_3_1.callback then
				iter_3_1.callback()
			end
		end

		arg_3_0._callback[var_3_0] = nil
	else
		arg_3_0.effectMap[var_3_0] = Object.Instantiate(Asset.Load("Effect/" .. arg_3_1))

		SetActive(arg_3_0._effectMap[var_3_0], false)

		if arg_3_3 then
			arg_3_3()
		end
	end
end

function var_0_0.PlayUIEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = "effect/" .. arg_4_1

	if not arg_4_0._effectMap[var_4_0] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", var_4_0))
		arg_4_0:LoadEffect(arg_4_1, false, function()
			return
		end)
	end

	local var_4_1 = Object.Instantiate(arg_4_0._effectMap[var_4_0], arg_4_2.transform)

	var_4_1.transform.localPosition = Vector3(0, 0, 0)

	SetActive(var_4_1, true)

	local var_4_2 = var_4_1:GetComponent("DftAniEvent")

	if var_4_2 == nil then
		var_4_2 = var_4_1:AddComponent(typeof(DftAniEvent))
	end

	if arg_4_3 then
		var_4_2:AddEndEvent(function(arg_6_0)
			if arg_4_4 then
				arg_4_4()
			end

			UnityEngine.Object.Destroy(var_4_1)
		end)
	else
		var_4_2:AddEndEvent(function(arg_7_0)
			if arg_4_4 then
				arg_4_4()
			end
		end)
	end

	return var_4_1
end

function var_0_0.PlayEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = "effect/" .. arg_8_1

	if not arg_8_0._effectMap[var_8_0] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", var_8_0))
		arg_8_0:LoadEffect(arg_8_1, false, function()
			return
		end)
	end

	local var_8_1 = Object.Instantiate(arg_8_0._effectMap[var_8_0])

	var_8_1.transform.localPosition = arg_8_2 or Vector3(0, 0, 0)
	var_8_1.transform.localEulerAngles = arg_8_3 or Vector3(0, 0, 0)

	SetActive(var_8_1, true)

	local var_8_2 = var_8_1:GetComponent("ParticleSystemEvent")

	if var_8_2 == nil then
		var_8_2 = var_8_1:AddComponent(typeof(ParticleSystemEvent))
	end

	if arg_8_4 then
		var_8_2:SetEndEvent(function(arg_10_0)
			if arg_8_5 then
				arg_8_5()
			end

			UnityEngine.Object.Destroy(var_8_1)
		end)
	else
		var_8_2:SetEndEvent(function(arg_11_0)
			if arg_8_5 then
				arg_8_5()
			end

			SetActive(arg_11_0, false)
		end)
	end

	return var_8_1
end

function var_0_0.SpriteEffect(arg_12_0, arg_12_1)
	local var_12_0 = "effect/" .. arg_12_1

	if not arg_12_0._effectMap[var_12_0] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", var_12_0))
		arg_12_0:LoadEffect(arg_12_1, false, function()
			return
		end)
	end

	local var_12_1 = Object.Instantiate(arg_12_0._effectMap[var_12_0])

	SetActive(var_12_1, true)

	return var_12_1
end

function var_0_0.UnloadEffect(arg_14_0, arg_14_1)
	local var_14_0 = "effect/" .. arg_14_1

	if arg_14_0._effectMap[var_14_0] then
		Object.Destroy(arg_14_0._effectMap[var_14_0])
	end

	arg_14_0._effectMap[var_14_0] = nil
end

function var_0_0.UnloadAllEffect(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._effectMap) do
		Object.Destroy(arg_15_0._effectMap[iter_15_0])

		arg_15_0._effectMap[iter_15_0] = nil
	end

	arg_15_0._effectMap = {}

	if arg_15_0._material then
		Object.Destroy(arg_15_0._material)

		arg_15_0._material = nil
	end
end

function var_0_0.SetGrey(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		if arg_16_0._material == nil then
			arg_16_0._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		arg_16_1.material = arg_16_0._material.transform:Find("grey"):GetComponent("SpriteRenderer").material
	else
		arg_16_1.material = nil
	end
end

function var_0_0.SetNoise(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		if arg_17_0._material == nil then
			arg_17_0._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		arg_17_1.material = arg_17_0._material.transform:Find("noise"):GetComponent("SpriteRenderer").material
	else
		arg_17_1.material = nil
	end
end

function var_0_0.GetMat(arg_18_0, arg_18_1)
	if arg_18_0._material == nil then
		arg_18_0._material = Object.Instantiate(Asset.Load("UI/Materials"))
	end

	return arg_18_0._material.transform:Find(arg_18_1):GetComponent("SpriteRenderer").material
end

return var_0_0
