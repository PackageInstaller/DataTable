class = var_0_10000

local var_0_0 = var_0_10000("CourtYardShipFactory")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.poolMgr = arg_1_1

	return
end

function var_0_0.Make(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.poolMgr
	local var_2_1 = var_2.GetShipPool(var_2_0)
	local var_2_2 = var_2.Dequeue(var_2_1)

	SpineRole = var_1_10003

	local var_2_3 = var_1_10003.New(arg_2_1)
	local var_2_4
	local var_2_5 = arg_2_1:GetShipType()

	CourtYardConst = var_1_10006

	if var_2_5 == var_1_10006.SHIP_TYPE_OTHER then
		CourtYardOtherPlayerShipModule = var_2_5
		var_2_4 = var_2_5.New(arg_2_1, var_2_2, var_2_3)
	else
		local var_2_6 = {}

		CourtYardShipModule = var_6
		var_2_6[1] = var_6
		CourtYardVisitorShipModule = var_6
		var_2_6[2] = var_6
		CourtYardFeastShipModule = var_6
		var_2_6[3] = var_6
		var_2_4 = var_2_6[arg_2_1:GetShipType()].New(arg_2_1, var_2_2, var_2_3)
	end

	local var_2_7 = arg_2_1:GetPrefab()

	seriesAsync = var_6

	var_6({
		function(arg_3_0)
			local var_3_0 = var_2_3

			var_1.Load(var_3_0, arg_3_0, true)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.MakeAttachments(var_4_0, var_2_2, arg_2_1, arg_4_0)

			return
		end
	}, function()
		IsNil = var_2_10000

		if var_2_10000(var_2_2) then
			return
		end

		local var_5_0 = var_2_3

		var_0.SetName(var_5_0, "model")

		local var_5_1 = var_2_3
		local var_5_2 = var_0.SetLocalScale

		Vector3 = var_3

		var_5_2(var_5_1, var_3.one)

		local var_5_3 = var_2_3
		local var_5_4 = var_0.SetSizeDelta

		Vector2 = var_3

		var_5_4(var_5_3, var_3.New(200, 500))

		local var_5_5 = var_2_3

		var_0.SetParent(var_5_5, var_2_2)

		local var_5_6 = var_2_3

		var_0.SetSiblingIndex(var_5_6, 2)

		setActive = var_0

		var_0(var_2_2, true)

		local var_5_7 = var_2_4

		var_0.OnIconLoaed(var_5_7)

		local var_5_8 = var_2_4

		var_0.Init(var_5_8)

		return
	end)

	return var_2_4
end

function var_0_0.MakeAttachments(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2:GetShipType()

	CourtYardConst = var_1_10005

	if var_6_0 == var_1_10005.SHIP_TYPE_FEAST then
		ResourceMgr = var_6_0

		local var_6_1 = var_6_0.Inst
		local var_6_2 = var_4.getAssetAsync
		local var_6_3 = "ui/CourtYardFeastAttachments"
		local var_6_4 = ""

		typeof = var_1_10009
		GameObject = var_1_10011

		local var_6_5 = var_1_10009(var_1_10011)

		UnityEngine = var_1_10010

		var_6_2(var_6_1, var_6_3, var_6_4, var_6_5, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
			if arg_6_0.exited then
				return
			end

			Object = var_1
			var_1.Instantiate(arg_7_0, arg_6_1.transform).name = "feastAttachments"

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
