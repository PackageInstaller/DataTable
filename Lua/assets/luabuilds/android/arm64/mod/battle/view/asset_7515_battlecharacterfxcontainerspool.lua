ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleResourceManager

ys.Battle.BattleCharacterFXContainersPool = singletonClass("BattleCharacterFXContainersPool")
ys.Battle.BattleCharacterFXContainersPool.__name = "BattleCharacterFXContainersPool"

function ys.Battle.BattleCharacterFXContainersPool.Ctor(arg_1_0)
	return
end

function ys.Battle.BattleCharacterFXContainersPool:Init()
	self._pool = {}
	self._templateContainer = GameObject("characterFXContainerPoolParent")
	self._templateContainerTf = self._templateContainer.transform
	self._templateContainerTf.position = Vector3(-10000, -10000, 0)

	return
end

function ys.Battle.BattleCharacterFXContainersPool:Pop(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or {
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}

	local var_3_0

	if #self._pool == 0 then
		var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(var_0_0.Battle.BattleConst.FXContainerIndex) do
			local var_3_1 = GameObject()

			var_3_1.transform:SetParent(arg_3_1, false)

			var_3_1.transform.localPosition = Vector3(arg_3_2[iter_3_0][1], arg_3_2[iter_3_0][2], arg_3_2[iter_3_0][3])
			var_3_1.transform.localEulerAngles = Vector3(arg_3_1.localEulerAngles.x * -1, arg_3_1.localEulerAngles.y, arg_3_1.localEulerAngles.z)
			var_3_1.name = "fxContainer_" .. iter_3_1
			var_3_0[iter_3_0] = var_3_1
		end
	else
		var_3_0 = self._pool[#self._pool]
		self._pool[#self._pool] = nil

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			iter_3_3.transform:SetParent(arg_3_1, false)

			iter_3_3.transform.localPosition = Vector3(arg_3_2[iter_3_2][1], arg_3_2[iter_3_2][2], arg_3_2[iter_3_2][3])
			iter_3_3.transform.localEulerAngles = Vector3(arg_3_1.localEulerAngles.x * -1, arg_3_1.localEulerAngles.y, arg_3_1.localEulerAngles.z)
		end
	end

	return var_3_0
end

function ys.Battle.BattleCharacterFXContainersPool:Push(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		iter_4_1.transform:SetParent(self._templateContainerTf, false)

		for iter_4_2 = iter_4_1.transform.childCount - 1, 0, -1 do
			var_0_1.GetInstance():DestroyOb(iter_4_1.transform:GetChild(iter_4_2).gameObject)
		end
	end

	self._pool[#self._pool + 1] = arg_4_1

	return
end

function ys.Battle.BattleCharacterFXContainersPool:Clear()
	for iter_5_0, iter_5_1 in ipairs(self._pool) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			Object.Destroy(iter_5_3)
		end
	end

	self._pool = nil

	Object.Destroy(self._templateContainer)

	self._templateContainer = nil
	self._templateContainerTf = nil

	return
end

return
