local var_0_0 = class("TacticsShipItem", import(".DockyardShipItem"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.isLoaded = false

	if IsNil(arg_1_2) then
		local function var_1_0(arg_2_0)
			arg_2_0.name = "ShipCardTpl"

			setParent(arg_2_0, arg_1_1)

			arg_2_0.transform.localScale = Vector3(1.28, 1.28, 1)
			arg_2_0.transform.localPosition = Vector3(0, 251, 0)

			var_0_0.super.Ctor(arg_1_0, arg_2_0, arg_1_3, arg_1_4)

			arg_1_0.isLoaded = true

			if arg_1_0.cacheShipVO then
				arg_1_0:update(arg_1_0.cacheShipVO)
			end

			return
		end

		ResourceMgr.Inst:getAssetAsync("template/shipcardtpl", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			var_1_0((Instantiate(arg_3_0)))

			return
		end), true, true)
	else
		var_0_0.super.Ctor(arg_1_0, arg_1_2, arg_1_3, arg_1_4)

		arg_1_0.isLoaded = true
	end

	return
end

function var_0_0.update(arg_4_0, arg_4_1)
	if not arg_4_0.isLoaded then
		arg_4_0.cacheShipVO = arg_4_1
	else
		var_0_0.super.update(arg_4_0, arg_4_1)
	end

	return
end

function var_0_0.UpdateExpBuff(arg_5_0)
	return
end

return var_0_0
