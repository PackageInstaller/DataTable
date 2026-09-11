local EffectMgr = class("EffectMgr")

function EffectMgr:Ctor()
	self:OnCtor()
end

function EffectMgr:OnCtor()
	print("Initialize Effect Mgr")

	self._callback = {}
	self._effectMap = {}
	self._material = nil
end

function EffectMgr:LoadEffect(arg_3_1, arg_3_2, arg_3_3)
	if self._effectMap["effect/" .. arg_3_1] then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	if self._callback["effect/" .. arg_3_1] then
		table.insert(self._callback["effect/" .. arg_3_1], {
			callback = arg_3_3
		})
	elseif arg_3_2 == true then
		self._callback["effect/" .. arg_3_1] = {
			{
				callback = arg_3_3
			}
		}
		self._effectMap["effect/" .. arg_3_1] = Object.Instantiate(Asset.Load("Effect/" .. arg_3_1))

		SetActive(self._effectMap["effect/" .. arg_3_1], false)

		for iter_3_0, iter_3_1 in pairs(self._callback["effect/" .. arg_3_1]) do
			if iter_3_1.callback then
				iter_3_1.callback()
			end
		end

		self._callback["effect/" .. arg_3_1] = nil
	else
		self.effectMap["effect/" .. arg_3_1] = Object.Instantiate(Asset.Load("Effect/" .. arg_3_1))

		SetActive(self._effectMap["effect/" .. arg_3_1], false)

		if arg_3_3 then
			arg_3_3()
		end
	end
end

function EffectMgr:PlayUIEffect(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not self._effectMap["effect/" .. arg_4_1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", "effect/" .. arg_4_1))
		self:LoadEffect(arg_4_1, false, function()
			return
		end)
	end

	local var_4_0 = Object.Instantiate(self._effectMap["effect/" .. arg_4_1], arg_4_2.transform)

	var_4_0.transform.localPosition = Vector3(0, 0, 0)

	SetActive(var_4_0, true)

	local var_4_1 = var_4_0:GetComponent("DftAniEvent")

	if var_4_1 == nil then
		var_4_1 = var_4_0:AddComponent(typeof(DftAniEvent))
	end

	if arg_4_3 then
		var_4_1:AddEndEvent(function(arg_6_0)
			if arg_4_4 then
				arg_4_4()
			end

			UnityEngine.Object.Destroy(var_4_0)
		end)
	else
		var_4_1:AddEndEvent(function(arg_7_0)
			if arg_4_4 then
				arg_4_4()
			end
		end)
	end

	return var_4_0
end

function EffectMgr:PlayEffect(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not self._effectMap["effect/" .. arg_8_1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", "effect/" .. arg_8_1))
		self:LoadEffect(arg_8_1, false, function()
			return
		end)
	end

	local var_8_0 = Object.Instantiate(self._effectMap["effect/" .. arg_8_1])

	var_8_0.transform.localPosition = arg_8_2 or Vector3(0, 0, 0)
	var_8_0.transform.localEulerAngles = arg_8_3 or Vector3(0, 0, 0)

	SetActive(var_8_0, true)

	local var_8_1 = var_8_0:GetComponent("ParticleSystemEvent")

	if var_8_1 == nil then
		var_8_1 = var_8_0:AddComponent(typeof(ParticleSystemEvent))
	end

	if arg_8_4 then
		var_8_1:SetEndEvent(function(arg_10_0)
			if arg_8_5 then
				arg_8_5()
			end

			UnityEngine.Object.Destroy(var_8_0)
		end)
	else
		var_8_1:SetEndEvent(function(arg_11_0)
			if arg_8_5 then
				arg_8_5()
			end

			SetActive(arg_11_0, false)
		end)
	end

	return var_8_0
end

function EffectMgr:SpriteEffect(arg_12_1)
	if not self._effectMap["effect/" .. arg_12_1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", "effect/" .. arg_12_1))
		self:LoadEffect(arg_12_1, false, function()
			return
		end)
	end

	local var_12_0 = Object.Instantiate(self._effectMap["effect/" .. arg_12_1])

	SetActive(var_12_0, true)

	return var_12_0
end

function EffectMgr:UnloadEffect(arg_14_1)
	if self._effectMap["effect/" .. arg_14_1] then
		Object.Destroy(self._effectMap["effect/" .. arg_14_1])
	end

	self._effectMap["effect/" .. arg_14_1] = nil
end

function EffectMgr:UnloadAllEffect()
	for iter_15_0, iter_15_1 in pairs(self._effectMap) do
		Object.Destroy(self._effectMap[iter_15_0])

		self._effectMap[iter_15_0] = nil
	end

	self._effectMap = {}

	if self._material then
		Object.Destroy(self._material)

		self._material = nil
	end
end

function EffectMgr:SetGrey(arg_16_1, arg_16_2)
	if arg_16_2 then
		if self._material == nil then
			self._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		arg_16_1.material = self._material.transform:Find("grey"):GetComponent("SpriteRenderer").material
	else
		arg_16_1.material = nil
	end
end

function EffectMgr:SetNoise(arg_17_1, arg_17_2)
	if arg_17_2 then
		if self._material == nil then
			self._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		arg_17_1.material = self._material.transform:Find("noise"):GetComponent("SpriteRenderer").material
	else
		arg_17_1.material = nil
	end
end

function EffectMgr:GetMat(arg_18_1)
	if self._material == nil then
		self._material = Object.Instantiate(Asset.Load("UI/Materials"))
	end

	return self._material.transform:Find(arg_18_1):GetComponent("SpriteRenderer").material
end

return EffectMgr
