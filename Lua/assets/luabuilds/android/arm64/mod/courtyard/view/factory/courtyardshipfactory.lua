local var_0_0 = class("CourtYardShipFactory")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.poolMgr = arg_1_1

	return
end

function var_0_0.Make(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.poolMgr:GetShipPool():Dequeue()
	local var_2_1 = SpineRole.New(arg_2_1)
	local var_2_2 = arg_2_1:GetShipType() == CourtYardConst.SHIP_TYPE_OTHER and CourtYardOtherPlayerShipModule.New(arg_2_1, var_2_0, var_2_1) or ({
		CourtYardShipModule,
		CourtYardVisitorShipModule,
		CourtYardFeastShipModule
	})[arg_2_1:GetShipType()].New(arg_2_1, var_2_0, var_2_1)
	local var_2_3 = arg_2_1:GetPrefab()

	seriesAsync({
		function(arg_3_0)
			var_2_1:Load(arg_3_0, true)

			return
		end,
		function(arg_4_0)
			arg_2_0:MakeAttachments(var_2_0, arg_2_1, arg_4_0)

			return
		end
	}, function()
		if IsNil(var_2_0) then
			return
		end

		var_2_1:SetName("model")
		var_2_1:SetLocalScale(Vector3.one)
		var_2_1:SetSizeDelta(Vector2.New(200, 500))
		var_2_1:SetParent(var_2_0)
		var_2_1:SetSiblingIndex(2)
		setActive(var_2_0, true)
		var_2_2:OnIconLoaed()
		var_2_2:Init()

		return
	end)

	return var_2_2
end

function var_0_0.MakeAttachments(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2:GetShipType() == CourtYardConst.SHIP_TYPE_FEAST then
		ResourceMgr.Inst:getAssetAsync("ui/CourtYardFeastAttachments", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
			if arg_6_0.exited then
				return
			end

			Object.Instantiate(arg_7_0, arg_6_1.transform).name = "feastAttachments"

			arg_6_3()

			return
		end), true, true)
	else
		arg_6_3()
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.exited = true

	return
end

return var_0_0
