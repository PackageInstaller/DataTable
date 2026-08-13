class = var_0_10000

local var_0_0 = "TacticsShipItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".DockyardShipItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.isLoaded = false
	IsNil = var_5

	if var_5(arg_1_2) then
		local function var_1_0(arg_2_0)
			arg_2_0.name = "ShipCardTpl"
			setParent = var_1

			var_1(arg_2_0, arg_1_1)

			local var_2_0 = arg_2_0.transform

			Vector3 = var_2
			var_2_0.localScale = var_2(1.28, 1.28, 1)

			local var_2_1 = arg_2_0.transform

			Vector3 = var_2
			var_2_1.localPosition = var_2(0, 251, 0)

			var_0_1.super.Ctor(arg_1_0, arg_2_0, arg_1_3, arg_1_4)

			arg_1_0.isLoaded = true

			if arg_1_0.cacheShipVO then
				local var_2_2 = arg_1_0

				var_1.update(var_2_2, arg_1_0.cacheShipVO)
			end

			return
		end

		ResourceMgr = var_6

		local var_1_1 = var_6.Inst
		local var_1_2 = var_6.getAssetAsync
		local var_1_3 = "template/shipcardtpl"
		local var_1_4 = ""

		UnityEngine = var_1_10010

		var_1_2(var_1_1, var_1_3, var_1_4, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			Instantiate = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			var_1_0(var_3_0)

			return
		end), true, true)
	else
		var_0_1.super.Ctor(arg_1_0, arg_1_2, arg_1_3, arg_1_4)

		arg_1_0.isLoaded = true
	end

	return
end

function var_0_1.update(arg_4_0, arg_4_1)
	if not arg_4_0.isLoaded then
		arg_4_0.cacheShipVO = arg_4_1
	else
		var_0_1.super.update(arg_4_0, arg_4_1)
	end

	return
end

function var_0_1.UpdateExpBuff(arg_5_0)
	return
end

return var_0_1
